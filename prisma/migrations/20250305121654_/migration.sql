/*
  Warnings:

  - You are about to drop the `employee_salary_pays` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `employee_salary_pays` DROP FOREIGN KEY `employee_salary_pays_employee_id_fkey`;

-- DropTable
DROP TABLE `employee_salary_pays`;
