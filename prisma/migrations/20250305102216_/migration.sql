/*
  Warnings:

  - You are about to drop the column `salary` on the `employees` table. All the data in the column will be lost.
  - Made the column `employee_id` on table `employee_salary_pays` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `salary_per_day` to the `employees` table without a default value. This is not possible if the table is not empty.
  - Added the required column `transport_per_day` to the `employees` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `employee_salary_pays` DROP FOREIGN KEY `employee_salary_pays_employee_id_fkey`;

-- DropIndex
DROP INDEX `employee_salary_pays_employee_id_fkey` ON `employee_salary_pays`;

-- AlterTable
ALTER TABLE `employee_salary_pays` MODIFY `employee_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `employees` DROP COLUMN `salary`,
    ADD COLUMN `salary_per_day` DECIMAL(65, 30) NOT NULL,
    ADD COLUMN `transport_per_day` DECIMAL(65, 30) NOT NULL;

-- CreateTable
CREATE TABLE `employee_attendances` (
    `id` VARCHAR(191) NOT NULL,
    `employee_id` VARCHAR(191) NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `is_present` BOOLEAN NOT NULL DEFAULT false,
    `is_transport` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `employee_salary_summaries` (
    `id` VARCHAR(191) NOT NULL,
    `employee_id` VARCHAR(191) NOT NULL,
    `month` INTEGER NOT NULL,
    `year` INTEGER NOT NULL,
    `total_salary` DECIMAL(65, 30) NOT NULL,
    `total_transport` DECIMAL(65, 30) NOT NULL,
    `total_cut` DECIMAL(65, 30) NOT NULL,
    `is_payed` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `employee_attendances` ADD CONSTRAINT `employee_attendances_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `employee_salary_pays` ADD CONSTRAINT `employee_salary_pays_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `employee_salary_summaries` ADD CONSTRAINT `employee_salary_summaries_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
