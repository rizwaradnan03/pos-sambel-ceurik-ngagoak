import { IFIngredientPurchase } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { quantity, totalCost, ingredientId }: IFIngredientPurchase = await req.json();

        const pricePerUnit = totalCost / quantity;

        // Buat pembelian baru
        await prisma.ingredientPurchase.create({
            data: {
                quantity: quantity,
                totalCost: totalCost,
                pricePerUnit: pricePerUnit,
                ingredientId: ingredientId
            }
        });

        // Ambil semua pembelian sebelumnya
        const allPurchases = await prisma.ingredientPurchase.findMany({
            where: { ingredientId },
        });

        // Hitung total jumlah dan total biaya
        const totalQuantity = allPurchases.reduce((sum, p) => sum + Number(p.quantity), 0);
        const totalCostSum = allPurchases.reduce((sum, p) => sum + Number(p.totalCost), 0);

        // Hitung rata-rata cost per unit
        const avgCostPerUnit = totalQuantity > 0 ? totalCostSum / totalQuantity : 0;

        // Update stok & avgCostPerUnit
        const updateIngredientStock = await prisma.ingredient.update({
            where: { id: ingredientId },
            data: {
                stock: { increment: quantity }, // Tambahkan stok otomatis
                avgCostPerUnit: avgCostPerUnit, // Gunakan rata-rata semua pembelian
            }
        });

        return NextResponse.json({ data: updateIngredientStock });
    } catch (error) {
        console.error("Error updating ingredient:", error);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}
