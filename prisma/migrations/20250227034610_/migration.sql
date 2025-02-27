/*
  Warnings:

  - Added the required column `amount` to the `employee_salary_pays` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `employee_salary_pays` ADD COLUMN `amount` DECIMAL(65, 30) NOT NULL;
