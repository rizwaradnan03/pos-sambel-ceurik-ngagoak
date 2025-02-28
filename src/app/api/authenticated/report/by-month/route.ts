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
      { header: "No", key: "no", width: 5, alignment: { horizontal: "left" } },
      { header: "Judul", key: "title", width: 20 },
      { header: "Amount", key: "amount", width: 20 },
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

    let expenseAmount = 0;
    let employeeSalaryPayAmount = 0;
    let ingredientPurchaseAmount = 0

    const ingredientPurchases = await prisma.$queryRawUnsafe<{name: string, total_cost: number}[]>(`SELECT ingredients.name as 'name', SUM(total_cost) as 'total_cost' FROM ingredient_purchases INNER JOIN ingredients ON ingredients.id = ingredient_purchases.ingredient_id WHERE MONTH(ingredient_purchases.created_at) = ${currentMonth} AND YEAR(ingredient_purchases.created_at) = ${currentYear} GROUP BY ingredients.name`)
    for(let i = 0;i < ingredientPurchases.length;i++){
      ingredientPurchaseAmount += Number(ingredientPurchases[i].total_cost)
    }

    const transactions = await prisma.$queryRawUnsafe<
      { pendapatan_kotor: number; pajak: number; hpp: number }[]
    >(
      `SELECT SUM(totalPrice) as 'pendapatan_kotor', SUM(taxAmount) as 'pajak', SUM(totalCost) as 'hpp' FROM orders WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear}`
    );

    const expenses = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(`SELECT name, SUM(amount) as 'amount' FROM expenses GROUP BY name`);
    for(let i = 0;i < expenses.length;i++){
      expenseAmount += Number(expenses[i].amount)
    }

    const employeeSalaryPays = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(
      `SELECT employees.name as name, SUM(employee_salary_pays.amount) as amount FROM employee_salary_pays INNER JOIN employees ON employees.id = employee_salary_pays.employee_id WHERE employee_salary_pays.is_payed = true AND MONTH(employee_salary_pays.created_at) = ${currentMonth} AND YEAR(employee_salary_pays.created_at) = ${currentYear} GROUP BY employees.name`
    );
    for(let i = 0;i < employeeSalaryPays.length;i++){
      employeeSalaryPayAmount += Number(employeeSalaryPays[i].amount)
    }

    const logOrders = await prisma.$queryRawUnsafe<ISOrder[]>(
      `SELECT * FROM orders WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear}`
    );

    const pendapatanKotor =
      Number(transactions[0].pendapatan_kotor) + Number(transactions[0].pajak);
    const pendapatanBersih = Number(transactions[0].pendapatan_kotor);
    const labaKotor = pendapatanBersih - Number(transactions[0].hpp);
    const totalBiayaOperasional = expenseAmount + employeeSalaryPayAmount;
    const labaBersih = labaKotor - totalBiayaOperasional;

    workSheetLabaRugi.addRow({
      no: 1,
      title: "Pendapatan Kotor",
      amount: pendapatanKotor,
    });

    workSheetLabaRugi.addRow({
      no: 2,
      title: "Pendapatan Bersih",
      amount: pendapatanBersih,
    });

    workSheetLabaRugi.addRow({
      title: "LABA",
    });

    workSheetLabaRugi.addRow({});

    if (expenses.length > 0) {
      const expenseRow = workSheetLabaRugi.addRow({
        title: "Biaya Operasional",
        amount: expenseAmount
      });
      expenseRow.getCell("title").font = { bold: true, size: 11 };

      expenses.forEach((expense, index) => {
        workSheetLabaRugi.addRow({
          no: index + 1,
          title: expense.name,
          amount: Number(expense.amount),
        });
      });
    }

    if (employeeSalaryPays.length > 0) {
      const employeeSalaryRow = workSheetLabaRugi.addRow({
        title: "Gaji Karyawan",
        amount: employeeSalaryPayAmount
      });
      employeeSalaryRow.getCell("title").font = { bold: true, size: 11 };

      employeeSalaryPays.forEach((employeeSalary, index) => {
        workSheetLabaRugi.addRow({
          no: index + 1,
          title: employeeSalary.name,
          amount: Number(employeeSalary.amount),
        });
      });
    }

    const lossRow = workSheetLabaRugi.addRow({
      title: "RUGI",
      amount: expenseAmount + employeeSalaryPayAmount,
    });
    lossRow.getCell("title").font = { bold: true, size: 12 };
    lossRow.getCell("amount").font = { bold: true, size: 12 };

    // workSheetLabaRugi.addRow({
    //   no: 4,
    //   title: "Laba Kotor",
    //   amount: labaKotor
    // });

    logOrders.forEach((order) => {
      workSheetLogOrder.addRow({
        id: order.id,
        customer: order.customer,
        paymentType: order.paymentType,
        totalPrice: Number(order.totalPrice),
        profit: Number(order.profit),
        totalCost: Number(order.totalCost),
        taxAmount: Number(order.taxAmount),
      });
    });

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
