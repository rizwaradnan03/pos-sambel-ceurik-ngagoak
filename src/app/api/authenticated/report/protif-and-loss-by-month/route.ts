import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs"

export async function GET(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const productId = searchParams.get("product_id")

        // const reportData = [
        //     {ka}
        // ]

        const workBook = new ExcelJS.Workbook()
        const workSheetLabaRugi = workBook.addWorksheet('Laporan Laba Rugi')

        workSheetLabaRugi.columns = [
            {header: 'Kategori', key: 'kategori', width: 20},
            {header: 'Deskripsi', key: 'deskripsi', width: 20},
            {header: 'Jumlah', key: 'jumlah', width: 20}
        ]

        workSheetLabaRugi.addRow({kategori: 'Anjay', deskripsi: 'AnjayDeskripsi', jumlah: 2000})

        const buffer = await workBook.xlsx.writeBuffer()

        return NextResponse.json({data: buffer})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }   
}