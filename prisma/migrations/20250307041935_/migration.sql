/*
  Warnings:

  - You are about to drop the column `transport_per_day` on the `employees` table. All the data in the column will be lost.
  - Added the required column `transport` to the `employees` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `employees` DROP COLUMN `transport_per_day`,
    ADD COLUMN `transport` DECIMAL(65, 30) NOT NULL;
