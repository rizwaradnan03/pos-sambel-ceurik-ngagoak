import { dateEndOfMonth, dateStartOfMonth } from "@/data/date";
import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function GET(){
    try {
        const data = await prisma.expense.findMany({
            where: {
                createdAt: {
                    gte: dateStartOfMonth,
                    lte: dateEndOfMonth
                }
            }
        })

        return NextResponse.json({data: data})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }    
}