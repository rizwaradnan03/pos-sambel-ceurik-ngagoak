import { UseErrorApiFunction } from "@/lib/error";
import { prisma } from "@/lib/prisma";
import bcryptjs from "bcryptjs";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    const createManyUsers = await prisma.user.createMany({
        data: [
            {
                email: "admin@gmail.com",
                name: "Admin Man",
                role: "ADMIN",
                password: await bcryptjs.hash("admin", 10),
            },
            {
                email: "inventory@gmail.com",
                name: "Inventory Manager",
                role: "INVENTORY",
                password: await bcryptjs.hash("inventory", 10),
            },
            {
                email: "cashier@gmail.com",
                name: "Cashier Guy",
                role: "CASHIER",
                password: await bcryptjs.hash("cashier", 10),
            },
            {
                email: "analytics@gmail.com",
                name: "analytics Guy",
                role: "ANALYTICS",
                password: await bcryptjs.hash("analytics", 10),
            },
        ]
    })

    return NextResponse.json({data: createManyUsers})
  } catch (error) {
    UseErrorApiFunction({ error: error });
    return Response.json(
      { message: "Terjadi kesalahan", error },
      { status: 500 }
    );
  }
}
