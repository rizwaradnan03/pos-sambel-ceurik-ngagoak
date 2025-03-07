import { IFOrder } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  try {
    const data: IFOrder = await req.json();

    const createdData = await prisma.$transaction(async (trx) => {
      try {
        let totalCost = 0;
  
        const createOrder = await trx.order.create({
          data: {
            customer: data.customer,
            paymentType: data.paymentType,
            totalPrice: data.totalPrice,
          },
        });
  
        for (const item of data.cart) {
          if (item.category === "PRODUCT") {
            // Ambil semua bahan produk sekaligus untuk menghindari query berulang
            const productIngredients = await trx.productIngredient.findMany({
              where: { productId: item.id },
              include: { Ingredient: true },
            });
  
            if(productIngredients.length < 1){
              throw new Error("Produk tidak memiliki bahan baku untuk diproses!")
            }
  
            for (const productIngredient of productIngredients) {
              const ingredient = productIngredient.Ingredient;
  
              if (!ingredient) {
                throw new Error(`Bahan dengan ID ${productIngredient.ingredientId} tidak ditemukan.`);
              }
  
              // Mengurangi stok berdasarkan quantity dari produk
              const totalDoseNeeded = Number(productIngredient.dose) * item.quantity;
              const updatedStock = Number(ingredient.stock) - totalDoseNeeded;
  
              if (updatedStock < 0) {
                console.log("aino")
                throw new Error(
                  `Stok bahan untuk ${item.name} tidak mencukupi! Dibutuhkan: ${totalDoseNeeded}, tersedia: ${ingredient.stock}`
                );
              }
  
              if (ingredient.avgCostPerUnit !== undefined) {
                totalCost += Number(ingredient.avgCostPerUnit) * totalDoseNeeded;
              }
  
              // Update stok bahan
              await trx.ingredient.update({
                data: { stock: updatedStock },
                where: { id: ingredient.id },
              });
            }
  
            // Simpan produk ke dalam order
            await trx.orderProduct.create({
              data: {
                orderId: createOrder.id,
                productId: item.id,
                quantity: item.quantity,
              },
            });
          } else if (item.category === "PACKAGE") {
            const packageProducts = await trx.packageItem.findMany({
              where: { packageId: item.id },
              include: {
                Product: {
                  include: {
                    ProductIngredient: { include: { Ingredient: true } },
                  },
                },
              },
            });
  
            for (const packageProduct of packageProducts) {
              if (!packageProduct.Product) throw new Error("Paket harus memiliki produk terdaftar!");
              if (!packageProduct.Product?.ProductIngredient || packageProduct.Product.ProductIngredient.length < 1){
                throw new Error("Produk dalam paket harus memiliki bahan baku!")
              }
  
              for (const productIngredient of packageProduct.Product.ProductIngredient) {
                const ingredient = productIngredient.Ingredient;
                if (!ingredient) continue;
  
                // const totalDoseNeeded = Number(productIngredient.dose) * item.quantity;
                const totalDoseNeeded = Number(productIngredient.dose) * packageProduct.quantity;
                const updatedStock = Number(ingredient.stock) - totalDoseNeeded;
  
                if (updatedStock < 0) {
                  throw new Error(
                    `Stok bahan untuk ${item.name} tidak mencukupi! Dibutuhkan: ${totalDoseNeeded}, tersedia: ${ingredient.stock}`
                  );
                }
  
                if (ingredient.avgCostPerUnit !== undefined) {
                  totalCost += Number(ingredient.avgCostPerUnit) * totalDoseNeeded;
                }
  
                await trx.ingredient.update({
                  data: { stock: updatedStock },
                  where: { id: ingredient.id },
                });
              }
            }
  
            await trx.orderPackage.create({
              data: {
                orderId: createOrder.id,
                packageId: item.id,
                quantity: item.quantity,
              },
            });
          }
        }
  
        let profit
        let taxAmount = data.taxAmount
        let totalPrice
  
        if(data.isTaxEnable){
          totalPrice = data.totalPrice - data.taxAmount!
          profit = totalPrice - totalCost
        }else{
          totalPrice = data.totalPrice
          profit = totalPrice - totalCost
        }
        
        await trx.order.update({
          data: {
            totalCost: totalCost,
            profit: profit,
            isTaxIncluded: data.isTaxEnable,
            taxAmount: taxAmount,
            totalPrice: totalPrice
          },
          where: { id: createOrder.id },
        });
  
        return createOrder;
      } catch (error) {
        throw error
      }
    });

    return NextResponse.json(
      { success: true, data: createdData },
      { status: 201 }
    );
  } catch (error: any) {
    console.error("Error processing order:", error);

    return NextResponse.json(
      { message: error.message },
      { status: 500 }
    );
  }
}
