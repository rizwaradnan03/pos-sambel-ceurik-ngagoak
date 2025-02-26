-- AlterTable
ALTER TABLE `orders` ADD COLUMN `is_tax_included` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `taxAmount` DECIMAL(65, 30) NULL DEFAULT 0;
