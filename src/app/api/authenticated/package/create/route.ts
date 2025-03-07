import { IFPackage } from "@/interfaces/form-interface";
import { UseDecodedBase64ToFile } from "@/lib/base64/server";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {name, price, image}: IFPackage = await req.json();

        let imageName: string | undefined;

        if(image){
            const {fileUrl} = await UseDecodedBase64ToFile({base64String: image, dir: "package"})
            console.log("file url nyaa ", fileUrl)
            imageName = fileUrl;
        }

        const create = await prisma.package.create({
            data: {
                name: name,
                price: price,
                image: imageName
            }
        })

        return NextResponse.json({data: create})
    } catch (error) {

    }
}