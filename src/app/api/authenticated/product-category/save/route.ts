import { IFProductCategory } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {productId, selectedCategories}: IFProductCategory = await req.json();

        const productCategory = await prisma.productCategory.findMany({
            where: {
                productId: productId
            },
            include: {
                Category: true
            }
        })

        for(let i = 0;i < productCategory.length;i++){
            let isFound = false
            for(let j = 0;j < selectedCategories.length;j++){
                if(productCategory[j].categoryId === selectedCategories[j].value){
                    isFound = true
                }
            }

            if(!isFound){
                await prisma.productCategory.delete({
                    where: {
                        id: productCategory[i].id
                    }
                })
            }
        }

        for(let i = 0;i < selectedCategories.length;i++){
            let isFound = false
            for(let j = 0;j < productCategory.length;j++){
                if(selectedCategories[i].value === productCategory[j].categoryId){
                    isFound = true
                }
            }

            if(!isFound){
                await prisma.productCategory.create({
                    data: {
                        productId: productId,
                        categoryId: selectedCategories[i].value
                    }
                })
            }
        }

        return NextResponse.json({data: "Berhasil!"})
    } catch (error) {

    }
}