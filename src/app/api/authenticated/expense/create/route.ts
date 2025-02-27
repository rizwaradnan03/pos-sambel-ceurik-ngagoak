import { IFCategory, IFExpense, IFIngredient } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { name, amount, createdAt, description }: IFExpense = await req.json();

        const create = await prisma.expense.create({
            data: {
                name: name,
                amount: amount,
                description: description,
                createdAt: createdAt,
            }
        });

        return NextResponse.json({ data: create });
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }
}
