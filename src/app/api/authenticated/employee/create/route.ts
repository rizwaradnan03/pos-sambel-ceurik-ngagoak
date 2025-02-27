import { IFEmployee, IFProduct, IFProductIngredient } from "@/interfaces/form-interface";
import { UseDecodedBase64ToFile } from "@/lib/base64/server";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const { name, phoneNumber, salary, isActive, role }: IFEmployee = await req.json();


        const create = await prisma.employee.create({
            data: {
                name: name,
                phoneNumber: phoneNumber,
                salary: salary,
                isActive: isActive,
                role: role
            }
        });

        return NextResponse.json({ success: true, data: create }, { status: 201 });
    } catch (error) {
        console.error("Error creating product:", error);
        return NextResponse.json({ success: false, message: "Internal Server Error" }, { status: 500 });
    }
}
