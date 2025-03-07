import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    const data = await prisma.employeeSalarySummary.findMany({
      include: {
        Employee: true
      },
      where: {
        isPayed: false
      }
    })

    return NextResponse.json({ data: data });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
