import { IFOrder } from "@/interfaces/form-interface";
import { prisma } from "@/lib/prisma";
import { NextRequest, NextResponse } from "next/server";

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

      for (let i = 0; i < data.cart.length; i++) {
        const item = data.cart[i];

        if (item.category == "PRODUCT") {
          const productIngredient = await trx.productIngredient.findMany({
            where: {
              productId: item.id,
            },
          });

          for (let j = 0; j < productIngredient.length; j++) {
            const ingredient = await trx.ingredient.findFirst({
              where: {
                id: productIngredient[j].ingredientId!,
              },
            });

            const updatedStock =
              Number(ingredient?.stock) - Number(productIngredient[j].dose);

            if (updatedStock < 0) {
              throw new Error(
                `Produk ${item.name} stock bahan nya tidak mencukupi!`
              );
            }

            if (ingredient?.avgCostPerUnit !== undefined) {
              totalCost = totalCost + Number(ingredient.avgCostPerUnit);
            }

            await trx.ingredient.update({
              data: {
                stock: updatedStock,
              },
              where: {
                id: ingredient?.id,
              },
            });

            await trx.orderProduct.create({
              data: {
                orderId: createOrder.id,
                productId: item.id,
                quantity: item.quantity,
              },
            });
          }
        } else if (item.category == "PACKAGE") {
          const packageProducts = await trx.packageItem.findMany({
            where: {
              packageId: item.id,
            },
            include: {
              Product: true,
            },
          });

          for (let i = 0; i < packageProducts.length; i++) {
            const product = packageProducts[i].Product;

            const productIngredients = await trx.productIngredient.findMany({
              where: {
                productId: product?.id,
              },
              include: {
                Ingredient: true,
              },
            });

            for (let j = 0; j < productIngredients.length; j++) {
              const ingredient = productIngredients[i].Ingredient;

              const updatedStock =
                Number(ingredient?.stock) - Number(productIngredients[j].dose);

              if (updatedStock < 0) {
                throw new Error(
                  `Produk ${item.name} stock bahan nya tidak mencukupi!`
                );
              }

              if (ingredient?.avgCostPerUnit !== undefined) {
                totalCost = totalCost + Number(ingredient.avgCostPerUnit);
              }

              await trx.ingredient.update({
                data: {
                  stock: updatedStock,
                },
                where: {
                  id: ingredient?.id,
                },
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
        where: {
          id: createOrder.id,
        },
      });
    });

    return NextResponse.json(
      { success: true, data: createdData },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating product:", error);
    return NextResponse.json(
      { success: false, message: "Internal Server Error" },
      { status: 500 }
    );
  }
}
