import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest){
    try {
        const {searchParams} = new URL(req.url)
        const id = searchParams.get("id")

        const data = await prisma.order.update({
            where: {
                id: id!
            },
            data: {
                orderStatus: "DONE"
            }
        })

        return NextResponse.json({data: data})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }   
}