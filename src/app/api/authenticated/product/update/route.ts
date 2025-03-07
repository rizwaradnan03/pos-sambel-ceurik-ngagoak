import { IFProduct } from "@/interfaces/form-interface";
import { UseDecodedBase64ToFile } from "@/lib/base64/server";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function PATCH(req: NextRequest) {
    try {
        const {searchParams} = new URL(req.url)
        const id = searchParams.get("id")
        const { name, price, image }: IFProduct = await req.json();

        let imageName: string | undefined;

        if(!id){
            return
        }

        if (image) {
            const { fileUrl } = await UseDecodedBase64ToFile({ base64String: image, dir: "product" });
            console.log("file url ", fileUrl);
            imageName = fileUrl;
        }

        const create = await prisma.product.update({
            data: {
                name: name,
                price: price,
                image: imageName
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
