/*
  Warnings:

  - Added the required column `quantity` to the `order_packages` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `order_packages` ADD COLUMN `quantity` INTEGER NOT NULL;
