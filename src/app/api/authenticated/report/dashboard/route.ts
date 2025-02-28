import { PrismaClient } from "@prisma/client";
import { NextRequest, NextResponse } from "next/server";

const prisma = new PrismaClient();

export async function GET(req: NextRequest) {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const todaySales = await prisma.order.aggregate({
      _sum: {
        totalPrice: true,
      },
      where: {
        createdAt: {
          gte: today,
        },
        orderStatus: "DONE",
      },
    });

    const now = new Date();
    const firstDayOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);

    const thisMonthSales = await prisma.order.aggregate({
      _sum: {
        totalPrice: true,
      },
      where: {
        createdAt: {
          gte: firstDayOfMonth,
        },
        orderStatus: "DONE",
      },
    });

    const dailySales = await prisma.$queryRawUnsafe(`
      SELECT 
        DATE(created_at) as date,
        SUM(totalPrice) as total
      FROM 
        orders
      WHERE 
        created_at >= ? 
        AND order_status = 'DONE'
      GROUP BY 
        DATE(created_at)
      ORDER BY 
        DATE(created_at) ASC
    `, firstDayOfMonth);

    const labels = (dailySales as Array<{ date: string; total: number }>).map((sale) =>
      new Date(sale.date).toLocaleDateString("id-ID")
    );
    const data = (dailySales as Array<{ date: string; total: number }>).map((sale) =>
      parseFloat((sale.total || 0).toString())
    );

    return NextResponse.json({
      data: {
        todaySales: todaySales._sum.totalPrice || 0,
        thisMonthSales: thisMonthSales._sum.totalPrice || 0,
        dailySales: {
          labels,
          data,
        },
      },
    });
  } catch (error) {
    console.error("Error fetching sales data:", error);
    return NextResponse.json(
      { message: "Internal Server Error" },
      { status: 500 }
    );
  }
}