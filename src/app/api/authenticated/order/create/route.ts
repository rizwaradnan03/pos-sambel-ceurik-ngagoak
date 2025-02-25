import { IFOrder } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client"; 

export async function POST(req: NextRequest) {
  try {
    const data: IFOrder = await req.json();

    const createdData = await prisma.$transaction(async (trx) => {
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
          const productIngredients = await trx.productIngredient.findMany({
            where: { productId: item.id },
          });

          for (const productIngredient of productIngredients) {
            const ingredient = await trx.ingredient.findUnique({
              where: { id: productIngredient.ingredientId! },
            });

            if (!ingredient) {
              throw new Error(`Bahan dengan ID ${productIngredient.ingredientId} tidak ditemukan.`);
            }

            // Mengurangi stok berdasarkan quantity dari produk
            const totalDoseNeeded = Number(productIngredient.dose) * item.quantity;
            const updatedStock = Number(ingredient.stock) - totalDoseNeeded;

            if (updatedStock < 0) {
              throw new Error(`Stok bahan untuk ${item.name} tidak mencukupi! Dibutuhkan: ${totalDoseNeeded}, tersedia: ${ingredient.stock}`);
            }

            if (ingredient.avgCostPerUnit !== undefined) {
              totalCost += Number(ingredient.avgCostPerUnit) * item.quantity;
            }

            await trx.ingredient.update({
              data: { stock: updatedStock },
              where: { id: ingredient.id },
            });

            await trx.orderProduct.create({
              data: {
                orderId: createOrder.id,
                productId: item.id,
                quantity: item.quantity,
              },
            });
          }
        } else if (item.category === "PACKAGE") {
          const packageProducts = await trx.packageItem.findMany({
            where: { packageId: item.id },
            include: { Product: true },
          });

          for (const packageProduct of packageProducts) {
            const productIngredients = await trx.productIngredient.findMany({
              where: { productId: packageProduct.Product?.id },
              include: { Ingredient: true },
            });

            for (const productIngredient of productIngredients) {
              const ingredient = productIngredient.Ingredient;

              if (!ingredient) {
                throw new Error(`Bahan ${productIngredient.ingredientId} tidak ditemukan.`);
              }

              // Mengurangi stok berdasarkan quantity dari package
              const totalDoseNeeded = Number(productIngredient.dose) * item.quantity;
              const updatedStock = Number(ingredient.stock) - totalDoseNeeded;

              if (updatedStock < 0) {
                throw new Error(`Stok bahan untuk ${item.name} tidak mencukupi! Dibutuhkan: ${totalDoseNeeded}, tersedia: ${ingredient.stock}`);
              }

              if (ingredient.avgCostPerUnit !== undefined) {
                totalCost += Number(ingredient.avgCostPerUnit) * item.quantity;
              }

              await trx.ingredient.update({
                data: { stock: updatedStock },
                where: { id: ingredient.id },
              });

              await trx.orderPackage.create({
                data: {
                  orderId: createOrder.id,
                  packageId: item.id,
                  quantity: item.quantity,
                },
              });
            }
          }
        }
      }

      const profit = data.totalPrice - totalCost;
      await trx.order.update({
        data: {
          totalCost: totalCost,
          profit: profit,
        },
        where: { id: createOrder.id },
      });

      return createOrder;
    });

    return NextResponse.json(
      { success: true, data: createdData },
      { status: 201 }
    );
  } catch (error: any) {

    return NextResponse.json(
      { message: error.message },
      { status: 500 }
    );
  }
}
