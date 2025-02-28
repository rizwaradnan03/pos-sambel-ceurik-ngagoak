import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs";
import { prisma } from "@/lib/prisma";
import { ISOrder } from "@/interfaces/schema-interface";

function formatPrice({ value }: { value: number }): string {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    minimumFractionDigits: 0,
  }).format(value);
}

export async function POST(req: NextRequest) {
  try {
    const {month, year} = await req.json()
    console.log("month dan year", [month, year])

    const workBook = new ExcelJS.Workbook();
    const workSheetLabaRugi = workBook.addWorksheet("Laporan Laba Rugi");
    const workSheetLogOrder = workBook.addWorksheet("Log Order");

    const now = new Date();
    const currentMonth = month ? month : now.getMonth() + 1;
    const currentYear = year ? year : now.getFullYear();

    workSheetLabaRugi.columns = [
      { header: "No", key: "no", width: 5, alignment: { horizontal: "left" } },
      { header: "Judul", key: "title", width: 30 },
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

    const orders = await prisma.$queryRawUnsafe<
      { taxAmount: number; totalPrice: number; totalCost: number }[]
    >(
      `SELECT SUM(taxAmount) as taxAmount, SUM(totalCost) as totalCost, SUM(totalPrice) totalPrice FROM orders WHERE order_status = 'DONE' AND MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear} GROUP BY totalCost, taxAmount, totalPrice`
    );
    console.log("orders ", orders);

    const expenses = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(
      `SELECT name, SUM(amount) as amount FROM expenses WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear} GROUP BY name`
    );
    console.log("expenses ", expenses);
    for (let i = 0; i < expenses.length; i++) {
      expenseAmount += Number(expenses[i].amount);
    }

    const employeeSalaryPays = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(
      `SELECT employees.name as name, SUM(employee_salary_pays.amount) as amount 
       FROM employee_salary_pays 
       INNER JOIN employees ON employees.id = employee_salary_pays.employee_id 
       WHERE is_payed = true 
       AND MONTH(employee_salary_pays.created_at) = ${currentMonth} 
       AND YEAR(employee_salary_pays.created_at) = ${currentYear} 
       GROUP BY employees.name`
    );
    console.log("employee salary pays ", employeeSalaryPays);

    for (let i = 0; i < employeeSalaryPays.length; i++) {
      employeeSalaryPayAmount += Number(employeeSalaryPays[i].amount);
    }

    const sale = Number(orders[0].totalPrice) + Number(orders[0].taxAmount);

    const incomeRow = workSheetLabaRugi.addRow({
      title: "Pendapatan",
      amount: formatPrice({ value: Number(orders[0].totalPrice) - Number(orders[0].totalCost) }),
    });
    incomeRow.getCell("title").font = { bold: true, size: 12 };
    incomeRow.getCell("amount").font = { bold: true, size: 12 };

    const saleRow = workSheetLabaRugi.addRow({
      title: "Penjualan",
      amount: formatPrice({ value: sale }),
    });

    const taxRow = workSheetLabaRugi.addRow({
      title: "Pajak",
      amount: formatPrice({ value: Number(orders[0].taxAmount) }),
    });

    const saleWithoutTaxRow = workSheetLabaRugi.addRow({
      title: "Penjualan - Pajak",
      amount: formatPrice({ value: Number(orders[0].totalPrice) }),
    });

    const costOfGoodSoldsRow = workSheetLabaRugi.addRow({
      title: "HPP",
      amount: formatPrice({ value: Number(orders[0].totalCost) }),
    });

    workSheetLabaRugi.addRow({});
    workSheetLabaRugi.addRow({});

    const costRow = workSheetLabaRugi.addRow({
      title: "Biaya Biaya",
      amount: formatPrice({ value: employeeSalaryPayAmount + expenseAmount }),
    });
    costRow.getCell("title").font = { bold: true, size: 12 };
    costRow.getCell("amount").font = { bold: true, size: 12 };

    if (employeeSalaryPays.length > 0) {
      const employeeSalaryPayRow = workSheetLabaRugi.addRow({
        title: "Gaji Karyawan",
        amount: formatPrice({ value: employeeSalaryPayAmount }),
      });
      employeeSalaryPayRow.getCell("title").font = { bold: true, size: 11 };

      employeeSalaryPays.forEach((salary, index) => {
        workSheetLabaRugi.addRow({
          title: `(${index + 1}) ${salary.name}`,
          amount: formatPrice({ value: Number(salary.amount) }),
        });
      });
    }

    if (expenses.length > 0) {
      const expenseRow = workSheetLabaRugi.addRow({
        title: "Biaya Operasional",
        amount: formatPrice({ value: expenseAmount }),
      });
      expenseRow.getCell("title").font = { bold: true, size: 11 };

      expenses.forEach((expense, index) => {
        workSheetLabaRugi.addRow({
          title: `(${index + 1}) ${expense.name}`,
          amount: formatPrice({ value: Number(expense.amount) }),
        });
      });
    }

    workSheetLabaRugi.addRow({})

    const profitRow = workSheetLabaRugi.addRow({
      title: "Laba (Pendapatan - Biaya Biaya)",
      amount: formatPrice({
        value:
          Number(orders[0].totalPrice) -
          Number(orders[0].totalCost) -
          (employeeSalaryPayAmount + expenseAmount),
      }),
    });
    profitRow.getCell("title").font = { bold: true, size: 13 };
    profitRow.getCell("amount").font = { bold: true, size: 13 };

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