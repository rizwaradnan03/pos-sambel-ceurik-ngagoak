import { IFEmployee } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(req: NextRequest) {
    try {
        const {searchParams} = new URL(req.url)
        const id = searchParams.get("id")
        const { name, phoneNumber, role, salaryPerDay, transport }: IFEmployee = await req.json();

        if(!id){
            return
        }

        const create = await prisma.employee.update({
            data: {
                name: name,
                phoneNumber: phoneNumber,
                role: role,
                salaryPerDay: salaryPerDay,
                transport: transport,
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
