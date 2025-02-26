import { IFCategorySave, IFProductCategory } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest){
    try {
        const {categoryId, selectedItems}: IFCategorySave = await req.json();

        const productCategory = await prisma.productCategory.findMany({
            where: {
                categoryId: categoryId
            },
            include: {
                Category: true
            }
        })

        const packageCategory = await prisma.packageCategory.findMany({
            where: {
                categoryId: categoryId
            },
            include: {
                Category: true
            }
        })

        for(let i = 0;i < selectedItems.length;i++){
            if(selectedItems[i].category == "PRODUCT"){
                let isFound = false
                for(let j = 0;j < productCategory.length;j++){
                    if(selectedItems[i].value == productCategory[j].id){
                        isFound = true
                    }
                }

                if(!isFound){
                    await prisma.productCategory.create({
                        data: {
                            categoryId: categoryId,
                            productId: selectedItems[i].value
                        }
                    })
                }
            }else if(selectedItems[i].category == "PACKAGE"){
                let isFound = false
                for(let j = 0;j < packageCategory.length;j++){
                    if(selectedItems[i].value == packageCategory[j].id){
                        isFound = true
                    }
                }

                if(!isFound){
                    await prisma.packageCategory.create({
                        data: {
                            categoryId: categoryId,
                            packageId: selectedItems[i].value
                        }
                    })
                }
            }
        }

        return NextResponse.json({data: "Berhasil!"})
    } catch (error) {
        return NextResponse.json({ error: (error as Error).message }, { status: 500 });
    }
}