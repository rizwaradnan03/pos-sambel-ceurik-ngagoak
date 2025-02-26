import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs";
import { prisma } from "@/lib/prisma";
import { ISOrder } from "@/interfaces/schema-interface";

export async function GET(req: NextRequest) {
  try {
    const workBook = new ExcelJS.Workbook();
    const workSheetLabaRugi = workBook.addWorksheet("Laporan Laba Rugi");
    const workSheetLogOrder = workBook.addWorksheet("Log Order");

    const now = new Date();
    const currentMonth = now.getMonth() + 1;
    const currentYear = now.getFullYear();

    workSheetLabaRugi.columns = [
      { header: "No", key: "no", width: 20 },
      { header: "Judul", key: "title", width: 20 },
      { header: "Jumlah", key: "amount", width: 20 },
    ];
    
    workSheetLogOrder.columns = [
      { header: "Id Transaksi", key: "id", width: 20 },
      { header: "Nama Customer", key: "customer", width: 20 },
      { header: "Jenis Pembayaran", key: "paymentType", width: 20 },
      { header: "Total Harga", key: "totalPrice", width: 20 },
      { header: "Profit", key: "profit", width: 20 },
      { header: "Total HPP", key: "totalCost", width: 20 },
      { header: "Pajak", key: "taxAmount", width: 20 },
    ];

    const transactions = await prisma.$queryRawUnsafe<{ pendapatan_kotor: number, pajak: number, hpp: number }[]>(
      `SELECT SUM(totalPrice) as 'pendapatan_kotor', SUM(taxAmount) as 'pajak', SUM(totalCost) as 'hpp' FROM orders WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear}`
    );

    const logOrders = await prisma.$queryRawUnsafe<ISOrder[]>(`SELECT * FROM orders WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear}`)

    const pendapatanKotor = Number(transactions[0].pendapatan_kotor) + Number(transactions[0].pajak)
    const pendapatanBersih = Number(transactions[0].pendapatan_kotor)
    const labaKotor = pendapatanBersih - Number(transactions[0].hpp)

    workSheetLabaRugi.addRow({
      no: 1,
      title: "Pendapatan Kotor",
      amount: pendapatanKotor
    });

    workSheetLabaRugi.addRow({
      no: 2,
      title: "Pendapatan Bersih",
      amount: pendapatanBersih
    });

    workSheetLabaRugi.addRow({
      no: 2,
      title: "Laba Kotor",
      amount: labaKotor
    });

    logOrders.forEach((order) => {
        workSheetLogOrder.addRow({
            id: order.id,
            customer: order.customer,
            paymentType: order.paymentType,
            totalPrice: Number(order.totalPrice),
            profit: Number(order.profit),
            totalCost: Number(order.totalCost),
            taxAmount: Number(order.taxAmount)
        })
    })

    const buffer = await workBook.xlsx.writeBuffer();

    return new NextResponse(buffer, {
      status: 200,
      headers: {
        "Content-Disposition": "attachment; filename=report.xlsx",
        "Content-Type":
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      },
    });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
