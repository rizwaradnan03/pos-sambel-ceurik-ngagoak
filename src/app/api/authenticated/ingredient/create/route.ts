import { IFIngredient } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {name, stock, unitOfMeasure}: IFIngredient = await req.json();

        const create = await prisma.ingredient.create({
            data: {
                name: name,
                stock: stock,
                unitOfMeasure: unitOfMeasure
            }
        })

        return NextResponse.json({data: create})
    } catch (error) {

    }
}