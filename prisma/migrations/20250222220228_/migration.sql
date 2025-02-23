/*
  Warnings:

  - You are about to drop the `ingredient` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `log_ingredients` DROP FOREIGN KEY `log_ingredients_ingredient_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_ingredients` DROP FOREIGN KEY `product_ingredients_ingredient_id_fkey`;

-- DropIndex
DROP INDEX `log_ingredients_ingredient_id_fkey` ON `log_ingredients`;

-- DropIndex
DROP INDEX `product_ingredients_ingredient_id_fkey` ON `product_ingredients`;

-- DropTable
DROP TABLE `ingredient`;

-- CreateTable
CREATE TABLE `ingredients` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `stock` VARCHAR(191) NOT NULL,
    `unit_of_measure` ENUM('G', 'ML', 'PCS') NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `log_ingredients` ADD CONSTRAINT `log_ingredients_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_ingredients` ADD CONSTRAINT `product_ingredients_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
