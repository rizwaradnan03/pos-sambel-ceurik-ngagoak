/*
  Warnings:

  - You are about to alter the column `stock` on the `ingredients` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Decimal(65,30)`.
  - You are about to alter the column `dose` on the `product_ingredients` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Decimal(65,30)`.
  - Added the required column `constPerUnit` to the `ingredients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `totalPrice` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `products` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `ingredients` ADD COLUMN `constPerUnit` DECIMAL(65, 30) NOT NULL,
    MODIFY `stock` DECIMAL(65, 30) NOT NULL;

-- AlterTable
ALTER TABLE `orders` ADD COLUMN `totalPrice` DECIMAL(65, 30) NOT NULL;

-- AlterTable
ALTER TABLE `product_ingredients` MODIFY `dose` DECIMAL(65, 30) NOT NULL;

-- AlterTable
ALTER TABLE `products` ADD COLUMN `price` INTEGER NOT NULL;
