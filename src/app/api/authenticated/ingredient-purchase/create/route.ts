import { IFIngredientPurchase } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { quantity, totalCost, ingredientId }: IFIngredientPurchase = await req.json();

        if (!quantity || !totalCost || !ingredientId) {
            return NextResponse.json({ error: "Invalid input data" }, { status: 400 });
        }
        const pricePerUnit = totalCost / quantity;

        await prisma.ingredientPurchase.create({
            data: {
                quantity: quantity,
                totalCost: totalCost,
                pricePerUnit: pricePerUnit,
                ingredientId: ingredientId
            }
        });

        const previousPurchases = await prisma.ingredientPurchase.findMany({
            where: { ingredientId }
        });

        let totalQuantity = 0;
        let totalCostSum = 0;

        for (const purchase of previousPurchases) {
            totalQuantity += Number(purchase.quantity);
            totalCostSum += Number(purchase.totalCost);
        }

        // Hitung rata-rata cost per unit
        const avgCostPerUnit = totalQuantity > 0 ? totalCostSum / totalQuantity : pricePerUnit;

        // Update stok dan avgCostPerUnit pada tabel ingredient
        const updateIngredientStock = await prisma.ingredient.update({
            where: { id: ingredientId },
            data: {
                stock: { increment: quantity },
                avgCostPerUnit: avgCostPerUnit,
            }
        });

        return NextResponse.json({ data: updateIngredientStock });
    } catch (error) {
        console.error("Error updating ingredient:", error);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}