import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const productId = searchParams.get("product_id")

        const data = await prisma.ingredient.findMany({
            where: {
                NOT: {
                    ProductIngredient: {
                        some: {
                            productId: productId,
                        },
                    },
                },
            },
        });

        return NextResponse.json({data: data})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }
}