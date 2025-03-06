import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function DELETE(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const id = searchParams.get("id")

        if(!id){
            return
        }

        const data = await prisma.product.update({
            where: {
                id: id
            },
            data: {
                isActive: false
            }
        })

        return NextResponse.json({data: data})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }   
}