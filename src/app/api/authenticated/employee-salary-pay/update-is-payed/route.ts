import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const id = searchParams.get("id");
    const { isPayed }: { isPayed: boolean } = await req.json();

    if (!id) {
      return;
    }

    const update = await prisma.employeeSalaryPay.update({
        data: {
            isPayed: isPayed
        },
        where: {
            id: id
        }
    })

    return NextResponse.json({ data: update });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
