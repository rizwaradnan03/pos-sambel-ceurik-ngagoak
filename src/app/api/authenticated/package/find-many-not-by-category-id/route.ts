import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const categoryId = searchParams.get("category_id")

        const data = await prisma.package.findMany({
            where: {
                NOT: {
                    PackageCategory: {
                        some: {
                            categoryId: categoryId
                        }
                    }
                },
            },
        });

        return NextResponse.json({data: data})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }
}