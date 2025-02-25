import { IFCategory, IFIngredient } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { title, category }: IFCategory = await req.json();

        const create = await prisma.category.create({
            data: {
                title,
                category
            }
        });

        return NextResponse.json({ data: create });
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }
}
