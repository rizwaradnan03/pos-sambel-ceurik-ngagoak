import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const id = searchParams.get("id");

    const { transportation } = await req.json();
    

    if (!id) {
      return;
    }

    const data = await prisma.employeeAttendance.update({
      where: {
        id: id,
      },
      data: {
        isPresent: true,
        isTransport: transportation
      }
    });

    return NextResponse.json({ data: data });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
