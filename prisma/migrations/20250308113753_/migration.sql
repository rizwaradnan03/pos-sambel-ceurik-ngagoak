/*
  Warnings:

  - You are about to alter the column `role` on the `employees` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(1))` to `VarChar(191)`.

*/
-- AlterTable
ALTER TABLE `employees` MODIFY `role` VARCHAR(191) NOT NULL;
