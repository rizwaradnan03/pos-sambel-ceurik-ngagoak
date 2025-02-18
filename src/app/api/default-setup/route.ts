// import { UseErrorApiFunction } from "@/lib/error";
// import { prisma } from "@/lib/prisma";
// import bcryptjs from "bcryptjs";
// import { NextResponse } from "next/server";

// export async function GET() {
//   try {
//     // 1. Buat Users
//     const createUser = await prisma.user.createMany({
//       data: [
//         {
//           name: "Admin",
//           role: "ADMIN",
//           email: "admin@gmail.com",
//           password: await bcryptjs.hash("admin", 10),
//         },
//         {
//           name: "Cashier",
//           role: "CASHIER",
//           email: "cashier@gmail.com",
//           password: await bcryptjs.hash("cashier", 10),
//         },
//       ],
//     });

//     // 2. Buat Categories
//     const categories = await prisma.category.createManyAndReturn({
//       data: [{ title: "Makanan" }, { title: "Minuman" }],
//     });

//     // 3. Buat Products
//     const products = await prisma.product.createManyAndReturn({
//       data: [
//         { name: "Fuyunghai" },
//         { name: "Ayam Kecap Manis" },
//         { name: "Mie Ayam" },
//         { name: "Es Kelapa" },
//       ],
//     });

//     // 4. Hubungkan Products dengan Categories
//     const productCategories = await prisma.productCategory.createManyAndReturn({
//       data: [
//         { productId: products[0].id, categoryId: categories[0].id },
//         { productId: products[1].id, categoryId: categories[0].id },
//         { productId: products[2].id, categoryId: categories[0].id },
//         { productId: products[3].id, categoryId: categories[1].id },
//       ],
//     });

//     // 5. Buat Ingredients
//     const ingredients = await prisma.ingredient.createManyAndReturn({
//       data: [
//         { name: "Tepung", stock: "100", unitOfMeasure: "G" },
//         { name: "Telur", stock: "50", unitOfMeasure: "PCS" },
//         { name: "Daging Ayam", stock: "200", unitOfMeasure: "G" },
//         { name: "Mie", stock: "300", unitOfMeasure: "G" },
//         { name: "Kelapa", stock: "20", unitOfMeasure: "PCS" },
//         { name: "Air Kelapa", stock: "50", unitOfMeasure: "ML" },
//         { name: "Kecap Manis", stock: "100", unitOfMeasure: "ML" },
//       ],
//     });

//     // 6. Hubungkan Products dengan Ingredients (ProductIngredient)
//     const productIngredientData = [
//       { productName: "Fuyunghai", ingredientName: "Telur", dose: "2 PCS" },
//       { productName: "Fuyunghai", ingredientName: "Tepung", dose: "100 G" },
//       {
//         productName: "Ayam Kecap Manis",
//         ingredientName: "Daging Ayam",
//         dose: "150 G",
//       },
//       {
//         productName: "Ayam Kecap Manis",
//         ingredientName: "Kecap Manis",
//         dose: "50 ML",
//       },
//       { productName: "Mie Ayam", ingredientName: "Mie", dose: "200 G" },
//       { productName: "Mie Ayam", ingredientName: "Daging Ayam", dose: "50 G" },
//       { productName: "Es Kelapa", ingredientName: "Kelapa", dose: "1 PCS" },
//       {
//         productName: "Es Kelapa",
//         ingredientName: "Air Kelapa",
//         dose: "200 ML",
//       },
//     ];

//     const productIngredients = [];

//     for (const item of productIngredientData) {
//       const product = products.find((p) => p.name === item.productName);
//       const ingredient = ingredients.find(
//         (i) => i.name === item.ingredientName
//       );

//       if (product && ingredient) {
//         productIngredients.push({
//           productId: product.id,
//           ingredientId: ingredient.id,
//           dose: item.dose,
//         });
//       }
//     }

//     await prisma.productIngredient.createMany({
//       data: productIngredients,
//     });

//     // 7. Return Response
//     return NextResponse.json({
//       data: {
//         users: createUser.count,
//         categories: categories.length,
//         products: products.length,
//         productCategories: productCategories.length,
//         ingredients: ingredients.length,
//         productIngredients: productIngredients.length,
//       },
//     });
//   } catch (error) {
//     UseErrorApiFunction({ error: error });
//     return Response.json(
//       { message: "Terjadi kesalahan", error },
//       { status: 500 }
//     );
//   }
// }
