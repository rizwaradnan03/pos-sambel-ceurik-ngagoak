import { IFIngredient } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(req: NextRequest) {
    try {
        const {searchParams} = new URL(req.url)
        const id = searchParams.get("id")
        const { name, unitOfMeasure }: IFIngredient = await req.json();

        if(!id){
            return
        }

        const create = await prisma.ingredient.update({
            data: {
                name: name,
                unitOfMeasure: unitOfMeasure,
            },
            where: {
                id: id
            }
        });

        return NextResponse.json({ success: true, data: create }, { status: 201 });
    } catch (error) {
        console.error("Error creating product:", error);
        return NextResponse.json({ success: false, message: "Internal Server Error" }, { status: 500 });
    }
}
