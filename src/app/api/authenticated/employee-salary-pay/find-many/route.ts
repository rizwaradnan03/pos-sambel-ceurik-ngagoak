import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function GET(){
    try {
        const data = await prisma.employeeSalaryPay.findMany({
            where: {
                isPayed: false
            },
            include: {
                Employee: true
            }
        })

        return NextResponse.json({data: data})
    } catch (error) {

    }    
}