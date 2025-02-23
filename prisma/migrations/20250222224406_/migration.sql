/*
  Warnings:

  - You are about to drop the column `constPerUnit` on the `ingredients` table. All the data in the column will be lost.
  - You are about to drop the column `unit_of_measure` on the `ingredients` table. All the data in the column will be lost.
  - You are about to drop the column `pcs` on the `order_products` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `orders` table. All the data in the column will be lost.
  - Added the required column `unitOfMeasure` to the `ingredients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `order_products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `profit` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `totalCost` to the `orders` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `ingredients` DROP COLUMN `constPerUnit`,
    DROP COLUMN `unit_of_measure`,
    ADD COLUMN `avgCostPerUnit` DECIMAL(65, 30) NOT NULL DEFAULT 0,
    ADD COLUMN `unitOfMeasure` ENUM('G', 'ML', 'PCS') NOT NULL;

-- AlterTable
ALTER TABLE `order_products` DROP COLUMN `pcs`,
    ADD COLUMN `quantity` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `orders` DROP COLUMN `name`,
    ADD COLUMN `customer` VARCHAR(191) NULL,
    ADD COLUMN `profit` DECIMAL(65, 30) NOT NULL,
    ADD COLUMN `totalCost` DECIMAL(65, 30) NOT NULL,
    MODIFY `paymentType` ENUM('CASH', 'CARD', 'TRANSFER') NOT NULL;

-- CreateTable
CREATE TABLE `ingredient_purchases` (
    `id` VARCHAR(191) NOT NULL,
    `ingredient_id` VARCHAR(191) NULL,
    `quantity` DECIMAL(65, 30) NOT NULL,
    `price_per_unit` DECIMAL(65, 30) NOT NULL,
    `total_cost` DECIMAL(65, 30) NOT NULL,
    `supplier` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `expenses` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `amount` DECIMAL(65, 30) NOT NULL,
    `category` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ingredient_purchases` ADD CONSTRAINT `ingredient_purchases_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
