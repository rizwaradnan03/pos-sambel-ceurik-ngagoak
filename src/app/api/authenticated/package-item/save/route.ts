import { IFProductPackage } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { packageId, selectedProducts }: IFProductPackage = await req.json();

        const packageItems = await prisma.packageItem.findMany({
            where: { packageId },
            include: { Product: true }
        });

        const selectedProductIds = selectedProducts.map((product) => product.value);

        for (let i = 0; i < packageItems.length; i++) {
            if (!selectedProductIds.includes(packageItems[i].productId!)) {
                await prisma.packageItem.delete({
                    where: { id: packageItems[i].id }
                });
            }
        }

        for (let i = 0; i < selectedProductIds.length; i++) {
            const isFound = packageItems.some((item) => item.productId === selectedProductIds[i]);

            if (!isFound) {
                await prisma.packageItem.create({
                    data: {
                        packageId,
                        productId: selectedProductIds[i]
                    }
                });
            }
        }

        return NextResponse.json({ data: "Berhasil menyimpan paket produk!" });
    } catch (error) {
        console.error("Error:", error);
        return NextResponse.json({ error: "Terjadi kesalahan saat menyimpan" }, { status: 500 });
    }
}
