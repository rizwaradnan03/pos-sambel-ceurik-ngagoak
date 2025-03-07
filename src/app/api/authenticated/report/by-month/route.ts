import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs";
import { prisma } from "@/lib/prisma";
import { ISOrder } from "@/interfaces/schema-interface";

function formatPrice({ value }: { value: number }): string {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0,
  }).format(value);
}

export async function POST(req: NextRequest) {
  try {
    const { month, year } = await req.json();
    console.log("month dan year", [month, year]);

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

    let saleAmount = 0;
    let taxAmount = 0;
    let costAmount = 0;

    let expenseAmount = 0;
    let employeeSalaryPayAmount = 0;
    let ingredientPurchaseAmount = 0;

    const orders = await prisma.$queryRawUnsafe<
      { taxAmount: number; totalPrice: number; totalCost: number }[]
    >(
      `SELECT SUM(taxAmount) as taxAmount, SUM(totalCost) as totalCost, SUM(totalPrice) totalPrice FROM orders WHERE order_status = 'DONE' AND MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear} GROUP BY totalCost, taxAmount, totalPrice`
    );
    for (let i = 0; i < orders.length; i++) {
      saleAmount += Number(orders[i].totalPrice);
      taxAmount += Number(orders[i].taxAmount);
      costAmount += Number(orders[i].totalCost);
    }

    const expenses = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(
      `SELECT name, SUM(amount) as amount FROM expenses WHERE MONTH(created_at) = ${currentMonth} AND YEAR(created_at) = ${currentYear} GROUP BY name`
    );
    for (let i = 0; i < expenses.length; i++) {
      expenseAmount += Number(expenses[i].amount);
    }

    const employeeSalaryPays = await prisma.$queryRawUnsafe<
      { name: string; salary: number; transport: number; cut: number }[]
    >(
      `SELECT employees.name as name, SUM(employee_salary_summaries.total_salary) as salary,
      SUM(employee_salary_summaries.total_transport) as transport, SUM(employee_salary_summaries.total_cut) as cut
      FROM employee_salary_summaries INNER JOIN employees 
      ON employees.id = employee_salary_summaries.employee_id 
      WHERE employee_salary_summaries.month = '${currentMonth}' AND 
      employee_salary_summaries.year = '${currentYear}' AND employee_salary_summaries.is_payed = true GROUP BY employees.name`
    );

    for (let i = 0; i < employeeSalaryPays.length; i++) {
      employeeSalaryPayAmount +=
        Number(employeeSalaryPays[i].salary) +
        Number(employeeSalaryPays[i].transport) -
        Number(employeeSalaryPays[i].cut);
    }

    const ingredientPurchases = await prisma.$queryRawUnsafe<
      { name: string; amount: number }[]
    >(`SELECT ingredients.name as name, SUM(ingredient_purchases.total_cost) as amount FROM ingredient_purchases INNER JOIN ingredients ON ingredients.id = ingredient_purchases.ingredient_id WHERE MONTH(ingredient_purchases.created_at) = ${currentMonth} 
       AND YEAR(ingredient_purchases.created_at) = ${currentYear}  GROUP BY name`);
    for (let i = 0; i < ingredientPurchases.length; i++) {
      ingredientPurchaseAmount += Number(ingredientPurchases[i].amount);
    }

    const pendapatan = saleAmount - costAmount 

    const incomeRow = workSheetLabaRugi.addRow({
      title: "Pendapatan",
      amount: formatPrice({ value: pendapatan }),
    });
    incomeRow.getCell("title").font = { bold: true, size: 12 };
    incomeRow.getCell("amount").font = { bold: true, size: 12 };

    const saleRow = workSheetLabaRugi.addRow({
      title: "Penjualan",
      amount: formatPrice({ value: saleAmount + taxAmount }),
    });

    const taxRow = workSheetLabaRugi.addRow({
      title: "Pajak",
      amount: formatPrice({ value: taxAmount }),
    });

    const saleWithoutTaxRow = workSheetLabaRugi.addRow({
      title: "Penjualan - Pajak",
      amount: formatPrice({ value: saleAmount }),
    });

    const costOfGoodSoldsRow = workSheetLabaRugi.addRow({
      title: "HPP",
      amount: formatPrice({ value: costAmount }),
    });

    workSheetLabaRugi.addRow({});
    workSheetLabaRugi.addRow({});

    const biaya = employeeSalaryPayAmount + expenseAmount + ingredientPurchaseAmount

    const costRow = workSheetLabaRugi.addRow({
      title: "Biaya Biaya",
      amount: formatPrice({
        value:
          biaya,
      }),
    });
    costRow.getCell("title").font = { bold: true, size: 12 };
    costRow.getCell("amount").font = { bold: true, size: 12 };

    if (ingredientPurchases.length > 0) {
      const ingredientPurchaseRow = workSheetLabaRugi.addRow({
        title: "Biaya Belanja",
        amount: formatPrice({ value: ingredientPurchaseAmount }),
      });

      ingredientPurchases.forEach((purchase, index) => {
        workSheetLabaRugi.addRow({
          title: `(${index + 1}) ${purchase.name}`,
          amount: formatPrice({ value: Number(purchase.amount) }),
        });
      });
    }

    if (employeeSalaryPays.length > 0) {
      const employeeSalaryPayRow = workSheetLabaRugi.addRow({
        title: "Gaji Karyawan",
        amount: formatPrice({ value: employeeSalaryPayAmount }),
      });
      employeeSalaryPayRow.getCell("title").font = { bold: true, size: 11 };

      employeeSalaryPays.forEach((salary, index) => {
        workSheetLabaRugi.addRow({
          title: `(${index + 1}) ${salary.name}`,
          amount: formatPrice({
            value:
              Number(salary.salary) +
              Number(salary.transport) -
              Number(salary.cut),
          }),
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

    workSheetLabaRugi.addRow({});

    const profitRow = workSheetLabaRugi.addRow({
      title: "Laba (Pendapatan - Biaya Biaya)",
      amount: formatPrice({
        value:
          pendapatan - biaya
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
