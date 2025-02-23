import { IFIngredient, IFIngredientPurchase } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {quantity, totalCost, ingredientId}: IFIngredientPurchase = await req.json();

        const pricePerUnit = totalCost / quantity

        const createIngredientPurchase = await prisma.ingredientPurchase.create({
            data: {
                quantity: quantity,
                totalCost: totalCost,
                pricePerUnit: pricePerUnit,
                ingredientId: ingredientId
            }
        })

        const ingredient = await prisma.ingredient.findUnique({
            where: {
                id: ingredientId
            }
        })

        const updateIngredientStock = await prisma.ingredient.update({
            where: {
                id: ingredientId
            },
            data: {
                stock: ingredient ? Number(ingredient.stock) + quantity : quantity
            }
        })

        return NextResponse.json({data: updateIngredientStock})
    } catch (error) {

    }
}