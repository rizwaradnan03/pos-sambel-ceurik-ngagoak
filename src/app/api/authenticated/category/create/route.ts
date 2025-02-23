import { IFCategory, IFIngredient } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {title}: IFCategory = await req.json();

        const create = await prisma.category.create({
            data: {
                title: title,
            }
        })
        
        return NextResponse.json({data: create})
    } catch (error) {

    }
}