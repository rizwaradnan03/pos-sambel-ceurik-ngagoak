import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const employeeId = searchParams.get("employee_id");

    if (!employeeId) {
      return;
    }

    const now = new Date();
    const today = now.toISOString().split("T")[0];

    const data = await prisma.employeeAttendance.findFirst({
      where: {
        date: new Date(today),
        employeeId: employeeId,
        isPresent: false
      },
    });

    return NextResponse.json({ data: data });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
