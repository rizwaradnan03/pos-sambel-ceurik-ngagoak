import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const packageId = searchParams.get("package_id")

        const data = await prisma.product.findMany({
            where: {
                NOT: {
                    PackageItem: {
                        some: {
                            packageId: packageId
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