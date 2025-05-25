/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('PRODUCT', 'PACKAGE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employee_attendances
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employee_attendances` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime(3) NOT NULL,
  `is_present` tinyint(1) NOT NULL DEFAULT '0',
  `is_transport` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_attendances_employee_id_fkey` (`employee_id`),
  CONSTRAINT `employee_attendances_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employee_salary_summaries
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employee_salary_summaries` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `total_salary` decimal(65, 30) NOT NULL,
  `total_transport` decimal(65, 30) NOT NULL,
  `total_cut` decimal(65, 30) NOT NULL,
  `is_payed` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_salary_summaries_employee_id_fkey` (`employee_id`),
  CONSTRAINT `employee_salary_summaries_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employees
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employees` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary_per_day` decimal(65, 30) NOT NULL,
  `transport` decimal(65, 30) NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: expenses
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `expenses` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65, 30) NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ingredient_purchases
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ingredient_purchases` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredient_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(65, 30) NOT NULL,
  `price_per_unit` decimal(65, 30) NOT NULL,
  `total_cost` decimal(65, 30) NOT NULL,
  `supplier` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ingredient_purchases_ingredient_id_fkey` (`ingredient_id`),
  CONSTRAINT `ingredient_purchases_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ingredients
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` decimal(65, 30) NOT NULL,
  `unitOfMeasure` enum('G', 'ML', 'PCS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `avgCostPerUnit` decimal(65, 30) NOT NULL DEFAULT '0.000000000000000000000000000000',
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: log_ingredients
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `log_ingredients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredient_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_ingredients_ingredient_id_fkey` (`ingredient_id`),
  CONSTRAINT `log_ingredients_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: log_orders
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `log_orders` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_orders_order_id_fkey` (`order_id`),
  CONSTRAINT `log_orders_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: order_packages
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `order_packages` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_packages_order_id_fkey` (`order_id`),
  KEY `order_packages_package_id_fkey` (`package_id`),
  CONSTRAINT `order_packages_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `order_packages_package_id_fkey` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: order_products
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `order_products` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_products_order_id_fkey` (`order_id`),
  KEY `order_products_product_id_fkey` (`product_id`),
  CONSTRAINT `order_products_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `order_products_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: orders
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `orders` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `totalPrice` decimal(65, 30) NOT NULL,
  `totalCost` decimal(65, 30) DEFAULT NULL,
  `profit` decimal(65, 30) DEFAULT NULL,
  `is_tax_included` tinyint(1) NOT NULL DEFAULT '0',
  `taxAmount` decimal(65, 30) DEFAULT '0.000000000000000000000000000000',
  `order_status` enum('DONE', 'ON_PROGRESS') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ON_PROGRESS',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: package_categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `package_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `package_categories_category_id_fkey` (`category_id`),
  KEY `package_categories_package_id_fkey` (`package_id`),
  CONSTRAINT `package_categories_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `package_categories_package_id_fkey` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: package_items
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `package_items` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `package_items_package_id_fkey` (`package_id`),
  KEY `package_items_product_id_fkey` (`product_id`),
  CONSTRAINT `package_items_package_id_fkey` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `package_items_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: packages
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `packages` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(65, 30) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: product_categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_categories_product_id_fkey` (`product_id`),
  KEY `product_categories_category_id_fkey` (`category_id`),
  CONSTRAINT `product_categories_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `product_categories_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: product_ingredients
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `product_ingredients` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ingredient_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dose` decimal(65, 30) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_ingredients_ingredient_id_fkey` (`ingredient_id`),
  KEY `product_ingredients_product_id_fkey` (`product_id`),
  CONSTRAINT `product_ingredients_ingredient_id_fkey` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE,
  CONSTRAINT `product_ingredients_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: products
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `products` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(65, 30) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN', 'CASHIER', 'INVENTORY', 'ANALYTICS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_key` (`email`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: categories
# ------------------------------------------------------------

INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    'Ikan Goreng dan Bakar',
    'PRODUCT',
    1,
    '2025-05-19 11:49:14.186',
    '2025-05-19 11:49:14.186'
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    'Paket Lengkap',
    'PACKAGE',
    1,
    '2025-05-19 13:07:36.877',
    '2025-05-19 13:07:36.877'
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '73874af2-55d8-444b-8321-e9f9312990fe',
    'Ayam Goreng & Bakar',
    'PRODUCT',
    1,
    '2025-05-19 11:48:31.445',
    '2025-05-19 11:48:31.445'
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    'Minuman',
    'PRODUCT',
    1,
    '2025-05-19 18:19:33.983',
    '2025-05-19 18:19:33.983'
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a2cb0d8e-395a-4a0b-ac53-4bca814673e7',
    'Iga Bakar & Sop',
    'PRODUCT',
    1,
    '2025-05-19 11:50:28.046',
    '2025-05-19 11:50:28.046'
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `category`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    'Menu Pelengkap',
    'PRODUCT',
    1,
    '2025-05-19 11:51:02.450',
    '2025-05-19 11:51:02.450'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employee_attendances
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employee_salary_summaries
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employees
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: expenses
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ingredient_purchases
# ------------------------------------------------------------

INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '07b04934-4b66-4984-bc0f-eb12e77263a8',
    '712b4b21-c3cb-4f69-8eb1-ebe646a3120a',
    2000.000000000000000000000000000000,
    45.000000000000000000000000000000,
    90000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:07:57.380',
    '2025-05-19 18:07:57.380'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0e89b9da-4058-499f-b25d-4a5a94fb085c',
    '96e28634-3b80-4c0d-9b77-b31a46906c35',
    100.000000000000000000000000000000,
    2.000000000000000000000000000000,
    200.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:01:50.621',
    '2025-05-19 18:01:50.621'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '19ea8b4b-b220-49b3-89a5-9b25d24bca52',
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    2000.000000000000000000000000000000,
    50.000000000000000000000000000000,
    100000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:00:04.273',
    '2025-05-19 12:00:04.273'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1ad38993-f8b1-4d40-b8db-8bfc9456ecf6',
    'f6d6feec-3fc5-4bf1-967a-c8f3e7fcafe7',
    36.000000000000000000000000000000,
    1000.000000000000000000000000000000,
    36000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:08:31.394',
    '2025-05-19 10:08:31.394'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2023f014-1cad-4172-9f9f-89314b34181c',
    '6783fcab-95d3-49b6-812c-71e47858725d',
    2000.000000000000000000000000000000,
    25.000000000000000000000000000000,
    50000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:04:54.867',
    '2025-05-19 18:04:54.867'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '324ff812-e6e5-43eb-b7f2-d1993d2559cf',
    'cf38e6ef-a686-49a5-bb08-9da0b5d194c6',
    2000.000000000000000000000000000000,
    7.500000000000000000000000000000,
    15000.000000000000000000000000000000,
    NULL,
    '2025-05-19 13:11:56.581',
    '2025-05-19 13:11:56.581'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '3596c4f1-1b0f-4e93-b2fc-0a473793117c',
    'ddf79b3b-bbb7-422a-a597-8bc4ca68d2c1',
    50.000000000000000000000000000000,
    6000.000000000000000000000000000000,
    300000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:15:05.476',
    '2025-05-19 10:15:05.476'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '401efe14-05df-4b69-8cbf-a0db01edb03c',
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    40.000000000000000000000000000000,
    8750.000000000000000000000000000000,
    350000.000000000000000000000000000000,
    NULL,
    '2025-05-19 07:05:35.000',
    '2025-05-19 07:05:35.000'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '426e64a1-f8ec-4455-ba59-6c25ac455e9a',
    'e18a3c64-5b15-4532-b9b8-a1e919845f9c',
    2000.000000000000000000000000000000,
    10.000000000000000000000000000000,
    20000.000000000000000000000000000000,
    NULL,
    '2025-05-19 11:58:33.600',
    '2025-05-19 11:58:33.600'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6442c99e-e705-4632-8a90-db6096091f39',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    10.000000000000000000000000000000,
    32500.000000000000000000000000000000,
    325000.000000000000000000000000000000,
    NULL,
    '2025-05-19 07:07:15.230',
    '2025-05-19 07:07:15.230'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '79d9a5b3-e549-4048-aa1c-b4949dd3af84',
    'b4ea336f-3f28-42b8-9423-543e40684bac',
    15000.000000000000000000000000000000,
    1.000000000000000000000000000000,
    15000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:14:34.315',
    '2025-05-19 18:14:34.315'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7bb1c488-ea4d-4bb6-8b48-1c93e7700a5e',
    '438a6fc0-536e-4b51-9e41-13f91ca14458',
    100.000000000000000000000000000000,
    2000.000000000000000000000000000000,
    200000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:02:14.405',
    '2025-05-19 18:02:14.405'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '84b5bbbb-06f9-4433-ac85-7651a556b746',
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    100.000000000000000000000000000000,
    7500.000000000000000000000000000000,
    750000.000000000000000000000000000000,
    NULL,
    '2025-05-19 07:04:09.560',
    '2025-05-19 07:04:09.560'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '94803b71-8e6e-4093-a3a7-afc922f3fa38',
    '91db68b5-f78b-4412-80f1-42953beddf9c',
    16.000000000000000000000000000000,
    3750.000000000000000000000000000000,
    60000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:17:08.575',
    '2025-05-19 10:17:08.575'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9edc4a65-f76c-4369-b773-748aef8098a1',
    'b96b2aa9-7b58-434c-93f3-71a797b6acd1',
    100.000000000000000000000000000000,
    20.000000000000000000000000000000,
    2000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:03:04.191',
    '2025-05-19 18:03:04.191'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a28a7c65-ee2b-4ae1-900a-c3d2cfa08cbe',
    '55c21907-9719-468e-aa02-b6e8aa178233',
    2000.000000000000000000000000000000,
    12.500000000000000000000000000000,
    25000.000000000000000000000000000000,
    NULL,
    '2025-05-19 11:58:08.201',
    '2025-05-19 11:58:08.201'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'bd114dfc-e303-4371-8e26-79855baa29b6',
    'b84f268f-a1ed-4887-a3b2-c60bdb6e1631',
    100.000000000000000000000000000000,
    2000.000000000000000000000000000000,
    200000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:00:59.658',
    '2025-05-19 18:00:59.658'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cbeef0ad-94e1-420f-a9a8-bc2494a58713',
    'e61e2368-8222-4780-a103-2d69d652f463',
    3000.000000000000000000000000000000,
    106.666666666666700000000000000000,
    320000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:12:17.803',
    '2025-05-19 10:12:17.803'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cda00840-e75e-43f7-9d79-6d153b853562',
    '92c8c044-e2ed-443f-8a58-bda622cf9394',
    100.000000000000000000000000000000,
    700.000000000000000000000000000000,
    70000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:00:04.754',
    '2025-05-19 18:00:04.754'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd1499489-4d3d-4522-8ef6-5f563c229c8a',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    15.000000000000000000000000000000,
    12666.666666666670000000000000000000,
    190000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:11:01.478',
    '2025-05-19 10:11:01.478'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd24b1cef-c4e3-4bfa-9523-52fc97193eb1',
    'd5301512-3061-4a10-be4f-82943e996c8a',
    2000.000000000000000000000000000000,
    30.000000000000000000000000000000,
    60000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:03:50.183',
    '2025-05-19 12:03:50.183'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd60f61b9-1356-4e97-8f50-dca447be9dc6',
    '423dcfe3-dd7c-4145-867e-557ef853f987',
    16.000000000000000000000000000000,
    1875.000000000000000000000000000000,
    30000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:21:46.236',
    '2025-05-19 12:21:46.236'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd8e63608-ad56-4389-be0a-4bc125a53349',
    '712b4b21-c3cb-4f69-8eb1-ebe646a3120a',
    2000.000000000000000000000000000000,
    45.000000000000000000000000000000,
    90000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:07:34.315',
    '2025-05-19 18:07:34.315'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dad1e4bb-6170-41f8-bf6a-73f209dfb9f8',
    'c3d03239-532f-47b6-85bd-d9426db2406a',
    20000.000000000000000000000000000000,
    15.000000000000000000000000000000,
    300000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:06:34.539',
    '2025-05-19 12:06:34.539'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dba44aca-838f-4533-9784-f385f271ec89',
    'c9c1bd60-740a-494a-a4cc-3cb0b6a0f644',
    2000.000000000000000000000000000000,
    25.000000000000000000000000000000,
    50000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:06:05.972',
    '2025-05-19 18:06:05.972'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ddba5919-bf15-4af7-a6a0-b97ff3f58ac5',
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    100.000000000000000000000000000000,
    500.000000000000000000000000000000,
    50000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:05:40.853',
    '2025-05-19 12:05:40.853'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e15a0ecc-b32c-4e18-897f-e7b105fa14a9',
    '1cfa1d77-6b15-4bcf-acdd-3da08a7372b9',
    48.000000000000000000000000000000,
    1000.000000000000000000000000000000,
    48000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:17:57.383',
    '2025-05-19 18:17:57.383'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ee994a08-28a3-4f8b-9029-f8bd72186280',
    'f007bd17-38db-41a7-8537-14ac9872ccf7',
    2000.000000000000000000000000000000,
    20.000000000000000000000000000000,
    40000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:05:30.853',
    '2025-05-19 18:05:30.853'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f5815762-bec3-4c0c-993c-9f62746dbd6e',
    'b4b37403-65b1-4973-b9be-76f4c043a3de',
    2000.000000000000000000000000000000,
    10.000000000000000000000000000000,
    20000.000000000000000000000000000000,
    NULL,
    '2025-05-19 11:57:42.061',
    '2025-05-19 11:57:42.061'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'fb221ddb-ee63-4531-9104-fa289fc3067d',
    '4cc4d16a-079c-4506-bc0e-df1f347accee',
    20.000000000000000000000000000000,
    10000.000000000000000000000000000000,
    200000.000000000000000000000000000000,
    NULL,
    '2025-05-19 10:06:58.961',
    '2025-05-19 10:06:58.961'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'fbe7a8f6-5601-4009-96c1-fa46d4aec7c2',
    '40656320-04dc-4696-b934-f603bb915463',
    2000.000000000000000000000000000000,
    45.000000000000000000000000000000,
    90000.000000000000000000000000000000,
    NULL,
    '2025-05-19 18:04:04.560',
    '2025-05-19 18:04:04.560'
  );
INSERT INTO
  `ingredient_purchases` (
    `id`,
    `ingredient_id`,
    `quantity`,
    `price_per_unit`,
    `total_cost`,
    `supplier`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'fed39f16-8a52-452e-8d4f-ec86fd45b473',
    '46a41f9d-628b-47e3-bed3-554ac4959a6c',
    100.000000000000000000000000000000,
    500.000000000000000000000000000000,
    50000.000000000000000000000000000000,
    NULL,
    '2025-05-19 12:05:28.694',
    '2025-05-19 12:05:28.694'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ingredients
# ------------------------------------------------------------

INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    'Tempe',
    97.000000000000000000000000000000,
    'PCS',
    500.000000000000000000000000000000,
    1,
    '2025-05-19 12:04:34.907',
    '2025-05-19 18:33:04.806'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1cfa1d77-6b15-4bcf-acdd-3da08a7372b9',
    'Minerale 600 ml',
    48.000000000000000000000000000000,
    'PCS',
    1000.000000000000000000000000000000,
    1,
    '2025-05-19 18:16:35.684',
    '2025-05-19 18:17:57.391'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    'Ikan Gurame 500 Gram',
    10.000000000000000000000000000000,
    'PCS',
    32500.000000000000000000000000000000,
    1,
    '2025-05-19 07:06:02.905',
    '2025-05-19 07:07:15.239'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '40656320-04dc-4696-b934-f603bb915463',
    'Strawberry',
    1850.000000000000000000000000000000,
    'G',
    45.000000000000000000000000000000,
    1,
    '2025-05-19 18:03:32.863',
    '2025-05-19 18:32:06.708'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '423dcfe3-dd7c-4145-867e-557ef853f987',
    'Telur',
    16.000000000000000000000000000000,
    'PCS',
    1875.000000000000000000000000000000,
    1,
    '2025-05-19 12:21:25.429',
    '2025-05-19 12:21:46.244'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '438a6fc0-536e-4b51-9e41-13f91ca14458',
    'Coklat Bembeng',
    100.000000000000000000000000000000,
    'PCS',
    2000.000000000000000000000000000000,
    1,
    '2025-05-19 18:02:03.577',
    '2025-05-19 18:02:14.413'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '46a41f9d-628b-47e3-bed3-554ac4959a6c',
    'Tahu',
    92.000000000000000000000000000000,
    'PCS',
    500.000000000000000000000000000000,
    1,
    '2025-05-19 12:04:28.699',
    '2025-05-19 19:09:05.759'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4cc4d16a-079c-4506-bc0e-df1f347accee',
    'Puyuh',
    20.000000000000000000000000000000,
    'PCS',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 10:06:22.289',
    '2025-05-19 10:06:58.976'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '55c21907-9719-468e-aa02-b6e8aa178233',
    'Toge',
    1400.000000000000000000000000000000,
    'G',
    12.500000000000000000000000000000,
    1,
    '2025-05-19 11:55:21.753',
    '2025-05-19 19:09:05.770'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    'Ikan Gurame 350 grm',
    15.000000000000000000000000000000,
    'PCS',
    12666.666666666670000000000000000000,
    1,
    '2025-05-19 10:05:44.414',
    '2025-05-19 10:11:01.489'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6783fcab-95d3-49b6-812c-71e47858725d',
    'Buah Naga',
    2000.000000000000000000000000000000,
    'G',
    25.000000000000000000000000000000,
    1,
    '2025-05-19 18:04:32.107',
    '2025-05-19 18:04:54.874'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '712b4b21-c3cb-4f69-8eb1-ebe646a3120a',
    'Alpukat',
    4000.000000000000000000000000000000,
    'G',
    45.000000000000000000000000000000,
    1,
    '2025-05-19 18:07:18.230',
    '2025-05-19 18:07:57.389'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    'Ayam',
    100.000000000000000000000000000000,
    'PCS',
    7500.000000000000000000000000000000,
    1,
    '2025-05-19 07:02:56.156',
    '2025-05-19 07:04:09.576'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '91db68b5-f78b-4412-80f1-42953beddf9c',
    'Ikan Peda',
    16.000000000000000000000000000000,
    'PCS',
    3750.000000000000000000000000000000,
    1,
    '2025-05-19 10:15:33.951',
    '2025-05-19 10:17:08.587'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '92c8c044-e2ed-443f-8a58-bda622cf9394',
    'Jeruk',
    100.000000000000000000000000000000,
    'PCS',
    700.000000000000000000000000000000,
    1,
    '2025-05-19 17:58:13.579',
    '2025-05-19 18:00:04.770'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    'Ikan Nila',
    38.000000000000000000000000000000,
    'PCS',
    8750.000000000000000000000000000000,
    1,
    '2025-05-19 07:04:28.312',
    '2025-05-19 19:03:27.638'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '96e28634-3b80-4c0d-9b77-b31a46906c35',
    'Mix Tea',
    98.000000000000000000000000000000,
    'PCS',
    2.000000000000000000000000000000,
    1,
    '2025-05-19 18:01:23.259',
    '2025-05-19 18:32:06.692'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    'Cumi',
    2000.000000000000000000000000000000,
    'G',
    50.000000000000000000000000000000,
    1,
    '2025-05-19 11:59:18.125',
    '2025-05-19 12:00:04.282'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b4b37403-65b1-4973-b9be-76f4c043a3de',
    'Kangkung',
    1800.000000000000000000000000000000,
    'G',
    10.000000000000000000000000000000,
    1,
    '2025-05-19 11:55:02.800',
    '2025-05-19 12:56:37.370'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b4ea336f-3f28-42b8-9423-543e40684bac',
    'Es Batu',
    14800.000000000000000000000000000000,
    'G',
    1.000000000000000000000000000000,
    1,
    '2025-05-19 18:14:08.490',
    '2025-05-19 18:28:57.310'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b84f268f-a1ed-4887-a3b2-c60bdb6e1631',
    'Milo',
    100.000000000000000000000000000000,
    'PCS',
    2000.000000000000000000000000000000,
    1,
    '2025-05-19 18:00:43.752',
    '2025-05-19 18:00:59.666'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b96b2aa9-7b58-434c-93f3-71a797b6acd1',
    'Teh Tarik',
    98.000000000000000000000000000000,
    'PCS',
    20.000000000000000000000000000000,
    1,
    '2025-05-19 18:02:49.791',
    '2025-05-19 18:29:23.325'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c3d03239-532f-47b6-85bd-d9426db2406a',
    'Beras',
    19500.000000000000000000000000000000,
    'G',
    15.000000000000000000000000000000,
    1,
    '2025-05-19 12:06:13.813',
    '2025-05-19 18:33:04.803'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c9c1bd60-740a-494a-a4cc-3cb0b6a0f644',
    'Mangga',
    1700.000000000000000000000000000000,
    'G',
    25.000000000000000000000000000000,
    1,
    '2025-05-19 18:05:46.176',
    '2025-05-19 18:33:04.782'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cf38e6ef-a686-49a5-bb08-9da0b5d194c6',
    'Daun Teh',
    2000.000000000000000000000000000000,
    'G',
    7.500000000000000000000000000000,
    1,
    '2025-05-19 13:11:19.629',
    '2025-05-19 13:11:56.590'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd5301512-3061-4a10-be4f-82943e996c8a',
    'Jengkol',
    1700.000000000000000000000000000000,
    'G',
    30.000000000000000000000000000000,
    1,
    '2025-05-19 12:02:57.320',
    '2025-05-19 18:33:04.800'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ddf79b3b-bbb7-422a-a597-8bc4ca68d2c1',
    'Ikan Sepat',
    50.000000000000000000000000000000,
    'PCS',
    6000.000000000000000000000000000000,
    1,
    '2025-05-19 10:13:16.984',
    '2025-05-19 10:15:05.487'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e18a3c64-5b15-4532-b9b8-a1e919845f9c',
    'Sayur Asem',
    2000.000000000000000000000000000000,
    'G',
    10.000000000000000000000000000000,
    1,
    '2025-05-19 11:55:30.625',
    '2025-05-19 11:58:33.607'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e61e2368-8222-4780-a103-2d69d652f463',
    'Daging Iga',
    3000.000000000000000000000000000000,
    'G',
    106.666666666666700000000000000000,
    1,
    '2025-05-19 10:06:07.242',
    '2025-05-19 10:12:17.810'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f007bd17-38db-41a7-8537-14ac9872ccf7',
    'Jambu',
    1850.000000000000000000000000000000,
    'G',
    20.000000000000000000000000000000,
    1,
    '2025-05-19 18:05:11.286',
    '2025-05-19 18:32:06.701'
  );
INSERT INTO
  `ingredients` (
    `id`,
    `name`,
    `stock`,
    `unitOfMeasure`,
    `avgCostPerUnit`,
    `isActive`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f6d6feec-3fc5-4bf1-967a-c8f3e7fcafe7',
    'Ikan Selar',
    34.000000000000000000000000000000,
    'PCS',
    1000.000000000000000000000000000000,
    1,
    '2025-05-19 10:07:35.568',
    '2025-05-19 18:33:04.797'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: log_ingredients
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: log_orders
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: order_packages
# ------------------------------------------------------------

INSERT INTO
  `order_packages` (
    `id`,
    `order_id`,
    `package_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1d804d22-2e9d-4d62-bf81-f9994f04162f',
    'd125bd06-353c-4fc2-9aad-c8736fac5be5',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    1,
    '2025-05-19 18:29:23.358',
    '2025-05-19 18:29:23.358'
  );
INSERT INTO
  `order_packages` (
    `id`,
    `order_id`,
    `package_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dfae373e-1c01-48e8-aea5-4003688ac831',
    'b3dfa4b0-13a8-4789-8336-fb953ea19422',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    1,
    '2025-05-19 18:33:04.812',
    '2025-05-19 18:33:04.812'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: order_products
# ------------------------------------------------------------

INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1f2b5c62-657e-456e-a07d-2491aef337df',
    '2b08b7b8-58db-43b1-bf09-81f0154e1464',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 15:41:21.379',
    '2025-05-19 15:41:21.379'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4188cf22-733a-4ffd-9863-8951b9c4c706',
    '2be55627-41d3-4816-8de4-3243c46e40ea',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-19 18:32:06.696',
    '2025-05-19 18:32:06.696'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4e1517ad-a29e-48e8-8d89-587eb2c10129',
    '5509e071-3e25-4102-a868-b20735af6f8c',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 15:44:03.965',
    '2025-05-19 15:44:03.965'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4fa3ee6f-76c0-4d62-989c-2e9bfce89603',
    'c43e057c-f788-4bba-a2d9-6f5d7b6c27f6',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    1,
    '2025-05-19 18:28:57.326',
    '2025-05-19 18:28:57.326'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '52e2c3cd-fa28-4b17-96cd-2d4a1125d830',
    '2b08b7b8-58db-43b1-bf09-81f0154e1464',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-19 15:41:21.363',
    '2025-05-19 15:41:21.363'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5c7e2ad6-9f0a-4c4d-a7e1-f913db6d3f69',
    '8f5cbeb0-32c0-4dbb-9986-81daf1431f4c',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-19 18:26:28.137',
    '2025-05-19 18:26:28.137'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9b5bd8b0-cef6-4738-9888-5d5902a50ed7',
    '027fce86-2994-4133-af64-8868a5a8687b',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-19 19:09:05.773',
    '2025-05-19 19:09:05.773'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a59cb139-065d-469f-b49b-bcd6419ca829',
    'b3dfa4b0-13a8-4789-8336-fb953ea19422',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    1,
    '2025-05-19 18:33:04.823',
    '2025-05-19 18:33:04.823'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ac2e814e-9a91-4749-a3b7-5da69b49e48a',
    '2b08b7b8-58db-43b1-bf09-81f0154e1464',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 15:41:21.391',
    '2025-05-19 15:41:21.391'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'bca11b17-b8bb-4ab1-b020-838c47b581f3',
    '8f5cbeb0-32c0-4dbb-9986-81daf1431f4c',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-19 18:26:28.151',
    '2025-05-19 18:26:28.151'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c196a3bb-2056-4c79-ab7e-50de8d21937f',
    '2be55627-41d3-4816-8de4-3243c46e40ea',
    '891012ff-2b63-4834-92c2-be50cae6b070',
    1,
    '2025-05-19 18:32:06.711',
    '2025-05-19 18:32:06.711'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c552ee03-5d18-445b-a8df-b1379f837e9e',
    'd125bd06-353c-4fc2-9aad-c8736fac5be5',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    1,
    '2025-05-19 18:29:23.329',
    '2025-05-19 18:29:23.329'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c69c9196-9018-4a52-96cb-4415cd6fe219',
    'c43e057c-f788-4bba-a2d9-6f5d7b6c27f6',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    1,
    '2025-05-19 18:28:57.316',
    '2025-05-19 18:28:57.316'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'caa7f849-d97f-4edc-b4cf-3efa0d9b2600',
    '685f9746-d975-43b1-9d0a-e775a0a3595f',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 15:42:35.719',
    '2025-05-19 15:42:35.719'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ce4f922b-0a68-4c26-9c35-2fba1056c53d',
    '0153c2bf-9f11-414c-9401-d7c1ce3d3577',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-19 19:03:27.654',
    '2025-05-19 19:03:27.654'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd7230123-24da-4a50-88bf-82408a4c0cc3',
    '2be55627-41d3-4816-8de4-3243c46e40ea',
    '6e876c14-b07d-4288-a5a0-946bf44982a3',
    1,
    '2025-05-19 18:32:06.704',
    '2025-05-19 18:32:06.704'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd7924c83-00aa-4f84-ba54-b99d9fc131d6',
    'b2396f96-13d6-4d81-a29c-1dcc20b341d4',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-19 12:56:37.388',
    '2025-05-19 12:56:37.388'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e054a1a3-0483-4bcc-9884-29a1badf250e',
    'b3dfa4b0-13a8-4789-8336-fb953ea19422',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-19 18:33:04.786',
    '2025-05-19 18:33:04.786'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e3abf712-2803-441f-8ac6-8e049f7d6a0f',
    '0153c2bf-9f11-414c-9401-d7c1ce3d3577',
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    1,
    '2025-05-19 19:03:27.644',
    '2025-05-19 19:03:27.644'
  );
INSERT INTO
  `order_products` (
    `id`,
    `order_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f4648a29-01d8-4c54-82df-8dfb02e314a8',
    '027fce86-2994-4133-af64-8868a5a8687b',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-19 19:09:05.764',
    '2025-05-19 19:09:05.764'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: orders
# ------------------------------------------------------------

INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0153c2bf-9f11-414c-9401-d7c1ce3d3577',
    'jk',
    '123',
    'CASH',
    33000.000000000000000000000000000000,
    10250.000000000000000000000000000000,
    22750.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 19:03:27.630',
    '2025-05-19 19:12:32.025'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '027fce86-2994-4133-af64-8868a5a8687b',
    'wr',
    '12',
    'CASH',
    20000.000000000000000000000000000000,
    4000.000000000000000000000000000000,
    16000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 19:09:05.752',
    '2025-05-19 19:12:33.627'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2b08b7b8-58db-43b1-bf09-81f0154e1464',
    'yusa',
    '12',
    'CASH',
    22500.000000000000000000000000000000,
    5000.000000000000000000000000000000,
    17500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 15:41:21.310',
    '2025-05-19 18:21:17.730'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2be55627-41d3-4816-8de4-3243c46e40ea',
    'dff',
    '12',
    'CASH',
    32000.000000000000000000000000000000,
    9752.000000000000000000000000000000,
    22248.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 18:32:06.686',
    '2025-05-19 18:45:05.031'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5509e071-3e25-4102-a868-b20735af6f8c',
    'k',
    '78',
    'CASH',
    5000.000000000000000000000000000000,
    1500.000000000000000000000000000000,
    3500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 15:44:03.954',
    '2025-05-19 18:21:16.066'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '685f9746-d975-43b1-9d0a-e775a0a3595f',
    '12',
    '12',
    'CASH',
    5000.000000000000000000000000000000,
    1500.000000000000000000000000000000,
    3500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 15:42:35.709',
    '2025-05-19 18:21:14.730'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8f5cbeb0-32c0-4dbb-9986-81daf1431f4c',
    'yusuf',
    '0982',
    'CASH',
    20000.000000000000000000000000000000,
    3752.000000000000000000000000000000,
    16248.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 18:26:28.122',
    '2025-05-19 18:45:06.352'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b2396f96-13d6-4d81-a29c-1dcc20b341d4',
    'yusa',
    '091',
    'CASH',
    8000.000000000000000000000000000000,
    2000.000000000000000000000000000000,
    6000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 12:56:37.328',
    '2025-05-19 12:56:55.591'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b3dfa4b0-13a8-4789-8336-fb953ea19422',
    'rt',
    '234',
    'CASH',
    62000.000000000000000000000000000000,
    21500.000000000000000000000000000000,
    40500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 18:33:04.776',
    '2025-05-19 18:45:07.604'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c43e057c-f788-4bba-a2d9-6f5d7b6c27f6',
    'ad',
    '234',
    'CASH',
    11000.000000000000000000000000000000,
    220.000000000000000000000000000000,
    10780.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 18:28:57.301',
    '2025-05-19 18:45:09.005'
  );
INSERT INTO
  `orders` (
    `id`,
    `customer`,
    `phoneNumber`,
    `paymentType`,
    `totalPrice`,
    `totalCost`,
    `profit`,
    `is_tax_included`,
    `taxAmount`,
    `order_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd125bd06-353c-4fc2-9aad-c8736fac5be5',
    'era',
    '234',
    'CASH',
    35000.000000000000000000000000000000,
    9020.000000000000000000000000000000,
    25980.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-19 18:29:23.319',
    '2025-05-19 18:45:10.311'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: package_categories
# ------------------------------------------------------------

INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1e515fb5-09e5-4c97-b434-014607a7fb16',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    '2025-05-19 13:07:57.688',
    '2025-05-19 13:07:57.688'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7876155a-2808-4c65-a536-23518eabba14',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    '2025-05-19 13:07:57.683',
    '2025-05-19 13:07:57.683'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '881367a5-7944-4389-a1e7-c6294d2a24ae',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '2025-05-19 13:21:03.845',
    '2025-05-19 13:21:03.845'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8d5f217f-4116-4030-94cb-4d50eeaf0866',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '2025-05-19 13:21:03.839',
    '2025-05-19 13:21:03.839'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8f59e50f-7a0f-404a-bd4c-022d43b7be94',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    '2025-05-19 13:07:57.678',
    '2025-05-19 13:07:57.678'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd508a323-9c9f-48e6-aca9-7bcdd5f61461',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '2025-05-19 13:21:03.850',
    '2025-05-19 13:21:03.850'
  );
INSERT INTO
  `package_categories` (
    `id`,
    `category_id`,
    `package_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f3d323c4-1f09-4353-9bf2-10bce2a0f5ce',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    '2025-05-19 13:07:57.672',
    '2025-05-19 13:07:57.672'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: package_items
# ------------------------------------------------------------

INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '02ce1fa9-389e-4496-8717-aca23cc7a334',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    1,
    '2025-05-19 13:19:43.910',
    '2025-05-19 13:19:43.910'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0802bc23-6c30-47ce-9dc0-cdc263d19301',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-19 13:10:32.872',
    '2025-05-19 13:10:32.872'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0e2da9c6-0b67-4587-b0fb-63c3e2ad073a',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 12:20:51.387',
    '2025-05-19 12:20:51.387'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1757b6b5-c4a1-48ea-a7fa-fe85a2f0ff0b',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 12:18:34.543',
    '2025-05-19 12:18:34.543'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '196d8d6b-2fe5-486c-b7e5-85fa292ca8b6',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 13:17:01.409',
    '2025-05-19 13:17:01.409'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1b5f5f5f-bcdb-4101-8a7d-904720f9542b',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    1,
    '2025-05-19 13:10:32.851',
    '2025-05-19 13:10:32.851'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1fcf621e-3f0e-459a-9486-0ff6619ee1ed',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 12:19:27.810',
    '2025-05-19 12:19:27.810'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '208aeb5f-ae92-439a-8d69-12a90c5edada',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 12:19:27.802',
    '2025-05-19 12:19:27.802'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '21ea487c-f93a-4afa-9b13-bf12655ff13a',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    1,
    '2025-05-19 13:13:32.098',
    '2025-05-19 13:13:32.098'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '223d8e48-6023-4356-a195-eb953766a3c3',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-19 13:19:43.935',
    '2025-05-19 13:19:43.935'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2a3c6c67-6e65-4376-b075-68e488213876',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 12:20:51.395',
    '2025-05-19 12:20:51.395'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '3dd95664-048b-4c9b-9a76-5e0020615adf',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 13:19:43.916',
    '2025-05-19 13:19:43.916'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '45a6f285-b4e4-4fd0-a682-14ab1158620a',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-19 12:16:06.730',
    '2025-05-19 12:16:06.730'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5009137d-3eba-4e9f-90c9-774e536b2229',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-19 12:19:27.797',
    '2025-05-19 12:19:27.797'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '54c8eeec-1a5a-48b2-abee-39b67f496d8b',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-19 12:18:34.551',
    '2025-05-19 12:18:34.551'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '554c5cb6-6bd5-42a2-94d7-095efd71923b',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-19 13:17:01.404',
    '2025-05-19 13:17:01.404'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '64ed43ea-73f9-4faf-812e-e194d02ab8a8',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 12:16:06.737',
    '2025-05-19 12:16:06.737'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '65cf415d-32d0-42d9-9301-dd5605524683',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-19 13:17:16.954',
    '2025-05-19 13:17:16.954'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '77166941-06a0-451e-a981-70f4f0a5db68',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-19 13:10:32.860',
    '2025-05-19 13:10:32.860'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7b8161f1-5ae0-48fa-8261-a9a339905f87',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-19 13:10:32.876',
    '2025-05-19 13:10:32.876'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7d31062e-584f-426c-8a0a-d672603fd826',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-19 13:19:43.924',
    '2025-05-19 13:19:43.924'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7e2427e0-42c2-449f-99e9-062180154b39',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 12:16:06.742',
    '2025-05-19 12:16:06.742'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8be0481a-11ff-4a48-9356-8d7ca6470603',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 12:16:06.746',
    '2025-05-19 12:16:06.746'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '91d72f92-55dc-4afd-818f-6552addb7bd0',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 13:19:43.931',
    '2025-05-19 13:19:43.931'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '958ac459-a6c1-4313-9bf6-b316a23c35c3',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '13886bc2-5d79-4008-883e-33c4a1278fba',
    1,
    '2025-05-19 13:10:32.868',
    '2025-05-19 13:10:32.868'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9b3d7fe6-319a-4383-8cd7-4e8e704a703f',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    1,
    '2025-05-19 13:10:32.864',
    '2025-05-19 13:10:32.864'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9c0fe972-1216-4d55-a958-df7b7e70f115',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-19 13:10:32.845',
    '2025-05-19 13:10:32.845'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ae12a513-04e2-4345-9675-fefb9ee65ea3',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-19 13:17:41.979',
    '2025-05-19 13:17:41.979'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'afd013e9-486a-47cd-a7e1-6833641a044d',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 12:19:27.806',
    '2025-05-19 12:19:27.806'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b01cb9d9-792a-46e3-8397-6911bf4c8e74',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    'b6a3b278-e62f-411a-b511-98f0f5084c12',
    1,
    '2025-05-19 13:10:32.855',
    '2025-05-19 13:15:43.918'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b9864c5c-04c8-4e79-b374-d0238a460f8d',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 13:17:01.413',
    '2025-05-19 13:17:01.413'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b9bd2770-3506-4baa-8f3c-d53cd412d72e',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-19 12:18:34.555',
    '2025-05-19 12:18:34.555'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'bb04d16e-bfb5-4833-a9e5-cbaadc90f392',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-19 12:20:51.381',
    '2025-05-19 12:20:51.381'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cd2b34f2-c4d0-433b-b740-2a6fa50b5bcf',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 12:18:34.533',
    '2025-05-19 12:18:34.533'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ce03e17d-c7f8-42a3-a839-e0dba79e14e7',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-19 13:10:32.880',
    '2025-05-19 13:10:32.880'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cf29104d-aefe-4a93-b515-f0cf8d82399b',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 12:18:34.547',
    '2025-05-19 12:18:34.547'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd1d93985-16f0-4b02-b403-1eef33afb837',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-19 13:19:43.920',
    '2025-05-19 13:19:43.920'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd8825cca-6313-4b67-932e-4d5e76d2262f',
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-19 13:19:43.928',
    '2025-05-19 13:19:43.928'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'da5539b2-471e-4a93-8655-3d90953e2627',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 13:17:01.418',
    '2025-05-19 13:17:01.418'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e6aedef9-8a4a-4554-aebb-2d8613d2119f',
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-19 13:10:32.884',
    '2025-05-19 13:10:32.884'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ebd0d17e-4545-4d4e-9875-07de4cc3704b',
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-19 13:17:01.422',
    '2025-05-19 13:17:01.422'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'edf78e36-54c6-4c52-8646-8e24c479a697',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    1,
    '2025-05-19 12:20:51.391',
    '2025-05-19 12:20:51.391'
  );
INSERT INTO
  `package_items` (
    `id`,
    `package_id`,
    `product_id`,
    `quantity`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'eff79979-e0db-4c81-9fb0-2ba3099a7308',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-19 12:18:34.539',
    '2025-05-19 12:18:34.539'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: packages
# ------------------------------------------------------------

INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    'Paket Ngasin',
    '/package/8cbb4484-a5f3-4ce2-a3e2-96c75a35fcec.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 12:19:04.813',
    '2025-05-19 12:19:04.813'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1f346490-e6e0-4aec-bfc8-fcb3ca17a2c5',
    'Paket Ngariung 6A',
    '/package/8cdeaaaf-45f0-4e41-9438-c2adebc4d4e0.jpg',
    195000.000000000000000000000000000000,
    1,
    '2025-05-19 13:16:19.283',
    '2025-05-19 13:24:29.324'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    'Paket Ayam SCN',
    '/package/3e4bcbc9-3a4f-435b-bad1-a64a43a5ebc0.jpg',
    25000.000000000000000000000000000000,
    1,
    '2025-05-19 12:15:29.998',
    '2025-05-19 12:15:29.998'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '48c2ffb0-390b-4985-9d14-804c394cc770',
    'Paket Ngariung 6B',
    '/package/2f8f7260-2d20-4816-8f43-064bc19b3aba.jpg',
    205000.000000000000000000000000000000,
    1,
    '2025-05-19 13:18:27.877',
    '2025-05-19 13:24:37.095'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '749b9367-a7d5-4996-a1d3-3579156eb9e3',
    'Paket Ngariung 10 Orang',
    '/package/6cfd1e53-df69-4892-9012-dd8438336b3b.jpg',
    449000.000000000000000000000000000000,
    1,
    '2025-05-19 13:08:38.369',
    '2025-05-19 13:24:44.529'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    'Paket Nasi Cobek',
    '/package/61d22e75-4437-490b-b40e-30894824357c.jpg',
    25000.000000000000000000000000000000,
    1,
    '2025-05-19 12:17:38.827',
    '2025-05-19 12:17:38.827'
  );
INSERT INTO
  `packages` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    'Paket Nila',
    '/package/589f1abe-0809-454f-b104-50b5cc4d1335.jpg',
    30000.000000000000000000000000000000,
    1,
    '2025-05-19 12:20:01.994',
    '2025-05-19 12:20:01.994'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: product_categories
# ------------------------------------------------------------

INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '00399cc0-3979-4246-bca4-0864a2f4a206',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.906',
    '2025-05-19 11:50:07.906'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '027edefa-9bc5-42c4-b597-0e6763289298',
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.877',
    '2025-05-19 11:50:07.877'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0f211171-4c8c-4dad-8e23-0454d1fd9024',
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.893',
    '2025-05-19 11:50:07.893'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '11b071c0-ef44-4f70-a837-8fce3a62c154',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.741',
    '2025-05-19 12:14:20.741'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1695a2fb-4d5f-4c07-ac0d-aae7bbea1d79',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.633',
    '2025-05-19 18:20:09.633'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '26163d28-e17f-4ff5-9443-acfc44a6abcf',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.762',
    '2025-05-19 12:14:20.762'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '29529470-5d30-45a1-b115-d0a3f7de46b5',
    '48fd0274-df76-43d9-a212-58ff5add2d3b',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.193',
    '2025-05-19 11:52:12.193'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2b51a310-1b70-4372-9a75-3a6af28d016f',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.629',
    '2025-05-19 18:20:09.629'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '36f5f044-675b-48cb-8a7c-5cd6d85f3630',
    '6e876c14-b07d-4288-a5a0-946bf44982a3',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.641',
    '2025-05-19 18:20:09.641'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '37d77d90-4258-4544-a839-04f2d87ef16b',
    '3c0d32f9-184c-49f2-88d3-24d8a7e09a7e',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.889',
    '2025-05-19 11:50:07.889'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '40ec888e-f348-4a3d-b343-b84046868541',
    '13886bc2-5d79-4008-883e-33c4a1278fba',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.183',
    '2025-05-19 11:52:12.183'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '44dc9bfc-9f7f-4cae-a7d7-b00a058ff0f7',
    '571d4ab3-d143-4faf-b13a-5b1bb8dc1069',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.637',
    '2025-05-19 18:20:09.637'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '471c5ecd-5830-4c55-b8bf-69026cdc9302',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    '73874af2-55d8-444b-8321-e9f9312990fe',
    '2025-05-19 11:48:47.238',
    '2025-05-19 11:48:47.238'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4a79102b-4330-4d23-800d-c9b4918ba272',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.757',
    '2025-05-19 12:14:20.757'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '57aefbd8-92e7-4099-a0d8-b4d1bbb18513',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.771',
    '2025-05-19 12:14:20.771'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5851b169-a96c-4a60-a484-2e3f97d9d7b0',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.897',
    '2025-05-19 11:50:07.897'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '67399e60-4248-4142-9d48-fd0b306c2330',
    '891012ff-2b63-4834-92c2-be50cae6b070',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.645',
    '2025-05-19 18:20:09.645'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6a4f8aef-bd08-432e-8dcf-cb5577e7021e',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.188',
    '2025-05-19 11:52:12.188'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6a8b1d62-25fb-48ad-afae-3a1a7a7ecdcd',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.880',
    '2025-05-19 11:50:07.880'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6ad6e529-e18c-49d2-b789-4a5bc7e04f7e',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 18:48:09.521',
    '2025-05-19 18:48:09.521'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6c87a891-8847-466d-adc5-6d44357ce97f',
    '190c0657-2097-4e20-a004-8a67ae138648',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.600',
    '2025-05-19 18:20:09.600'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6dd73771-7e76-4032-b83c-c3c7aa713a75',
    '71532023-e03e-4dca-9a07-dd972b238203',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.615',
    '2025-05-19 18:20:09.615'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6e380244-c4d3-498d-a9fc-ae22cc2be57c',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    'a2cb0d8e-395a-4a0b-ac53-4bca814673e7',
    '2025-05-19 11:50:40.863',
    '2025-05-19 11:50:40.863'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '708c9b0e-0fc2-4789-9857-e759e4defcd6',
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.745',
    '2025-05-19 12:14:20.745'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '77cebca6-7d2e-4858-899a-354352fbe318',
    '93598b46-a756-4e6a-9a63-fb56c1d213f8',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.625',
    '2025-05-19 18:20:09.625'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '79e61e4d-3d93-4840-b34a-5a3debfbd98d',
    '4b5b8ab5-dd73-4325-bff6-d0de427ed7cb',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.611',
    '2025-05-19 18:20:09.611'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '79e91a13-29ba-4951-a031-9ce104bdc275',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.753',
    '2025-05-19 12:14:20.753'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8cb2091f-866c-48db-896a-c7f357c51e6e',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.732',
    '2025-05-19 12:14:20.732'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8cd5e4f7-92ca-40c3-939f-25c5590f4482',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    '73874af2-55d8-444b-8321-e9f9312990fe',
    '2025-05-19 11:48:47.234',
    '2025-05-19 11:48:47.234'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '970eb69c-36b3-4a44-a4e4-6fabffaa14d9',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.619',
    '2025-05-19 18:20:09.619'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9baae6e1-b1c0-4bcf-b3e7-47631a7af7bb',
    '50962768-a856-4623-976f-696fe73615b4',
    'a2cb0d8e-395a-4a0b-ac53-4bca814673e7',
    '2025-05-19 11:50:40.852',
    '2025-05-19 11:50:40.852'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a13df6ef-3b54-49c6-9456-2092f5281393',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    '73874af2-55d8-444b-8321-e9f9312990fe',
    '2025-05-19 11:48:47.230',
    '2025-05-19 11:48:47.230'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a31f5fba-a4ae-4456-b68a-9c442dae8fce',
    'e2fa86b5-6fa9-49e6-9632-278bb6886569',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.205',
    '2025-05-19 11:52:12.205'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'abaa99d4-366d-4acc-9548-5f312655ed46',
    'b6a3b278-e62f-411a-b511-98f0f5084c12',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.872',
    '2025-05-19 11:50:07.872'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'afa85b56-3235-43ea-b37a-39ab5adb6588',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.648',
    '2025-05-19 18:20:09.648'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b9e0de97-3912-464f-aeae-19ffbb4d1e20',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.201',
    '2025-05-19 11:52:12.201'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c435babf-1e11-488c-8fcd-95f0f2a919ce',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    'a2cb0d8e-395a-4a0b-ac53-4bca814673e7',
    '2025-05-19 11:50:40.857',
    '2025-05-19 11:50:40.857'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c5a3b979-41b3-4a52-a62a-a288d858716d',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.728',
    '2025-05-19 12:14:20.728'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c80d3cf2-d001-42d1-909e-ceff73a3a3ed',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.737',
    '2025-05-19 12:14:20.737'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cee1937c-37a3-44ea-8993-88e3e5b6822b',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.722',
    '2025-05-19 12:14:20.722'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd25cbfb6-8271-4f1c-be06-212ebc300c7a',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.910',
    '2025-05-19 11:50:07.910'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd2a058ec-5aca-4b20-85fe-2f25722e93e1',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.748',
    '2025-05-19 12:14:20.748'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd9cbf505-4e4a-4db6-83ce-816d256fb290',
    '4dca53a1-88a2-404b-af7e-06c3e086e46b',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 11:52:12.197',
    '2025-05-19 11:52:12.197'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dce6e80e-a776-4f27-8a1b-945405902660',
    'f79273d1-1811-466b-b6cb-4374917165b3',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.885',
    '2025-05-19 11:50:07.885'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dd16842d-d6f4-40b8-afb9-d43cb2e72e5e',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-19 12:14:20.766',
    '2025-05-19 12:14:20.766'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dd1e30cc-53ca-42eb-bf05-d51a37aaa860',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:28:28.453',
    '2025-05-19 18:28:28.453'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e5481d9a-3e45-41b4-bab1-a1b174e78945',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    '80294e63-fd72-4c0f-8fed-3ae66febeff2',
    '2025-05-19 18:20:09.607',
    '2025-05-19 18:20:09.607'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'eb1fc632-6606-4672-a34f-9bd7b39f6799',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    '73874af2-55d8-444b-8321-e9f9312990fe',
    '2025-05-19 11:48:47.223',
    '2025-05-19 11:48:47.223'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f341e7b4-4ce4-4912-abbd-c896b16ad5ac',
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.901',
    '2025-05-19 11:50:07.901'
  );
INSERT INTO
  `product_categories` (
    `id`,
    `product_id`,
    `category_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'fd55b48b-c9a8-424b-ac47-7348636366c1',
    '6e80e9bc-bf07-4eff-9913-0d088134f271',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-19 11:50:07.866',
    '2025-05-19 11:50:07.866'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: product_ingredients
# ------------------------------------------------------------

INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0c20f460-a266-45bf-81e1-3b8e5cae4c57',
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    1.000000000000000000000000000000,
    '2025-05-19 11:20:24.891',
    '2025-05-19 11:20:24.891'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0c64c2fe-d0b9-4dc0-9fba-f755cbf3695e',
    '6e80e9bc-bf07-4eff-9913-0d088134f271',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    1.000000000000000000000000000000,
    '2025-05-19 11:24:44.739',
    '2025-05-19 11:24:44.739'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '22289551-031b-448b-a02b-500a5ebf3833',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    1.000000000000000000000000000000,
    '2025-05-19 11:44:31.843',
    '2025-05-19 11:44:31.843'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '26693a14-6ccd-4dd5-86e6-0ebfb3c232ae',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    '46a41f9d-628b-47e3-bed3-554ac4959a6c',
    3.000000000000000000000000000000,
    '2025-05-19 12:09:21.105',
    '2025-05-19 12:09:21.105'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2681a1c1-8c1c-441c-a14a-fbf35c180b98',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    '46a41f9d-628b-47e3-bed3-554ac4959a6c',
    1.000000000000000000000000000000,
    '2025-05-19 12:09:04.922',
    '2025-05-19 12:09:04.922'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '27d814b0-5479-4d78-a662-b22d49e6bdbe',
    '93598b46-a756-4e6a-9a63-fb56c1d213f8',
    '438a6fc0-536e-4b51-9e41-13f91ca14458',
    1.000000000000000000000000000000,
    '2025-05-19 18:12:09.953',
    '2025-05-19 18:12:09.953'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '27dc155c-b5ab-4646-b421-5b58fc5c8679',
    '891012ff-2b63-4834-92c2-be50cae6b070',
    '40656320-04dc-4696-b934-f603bb915463',
    150.000000000000000000000000000000,
    '2025-05-19 18:09:32.455',
    '2025-05-19 18:09:32.455'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2a83004f-fec0-442b-9e6d-5d0323e5c209',
    'e2fa86b5-6fa9-49e6-9632-278bb6886569',
    '91db68b5-f78b-4412-80f1-42953beddf9c',
    1.000000000000000000000000000000,
    '2025-05-19 11:45:01.176',
    '2025-05-19 11:45:01.176'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2eab7c7c-48cb-4546-887e-795f735eb050',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    1.000000000000000000000000000000,
    '2025-05-19 11:20:55.513',
    '2025-05-19 11:20:55.513'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '33356b4b-f5ff-4f7d-be52-9679222088da',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    1.000000000000000000000000000000,
    '2025-05-19 11:18:04.861',
    '2025-05-19 11:18:04.861'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '36ef2d79-d913-48a9-8fee-72ad9d1ffb33',
    '6e876c14-b07d-4288-a5a0-946bf44982a3',
    'f007bd17-38db-41a7-8537-14ac9872ccf7',
    150.000000000000000000000000000000,
    '2025-05-19 18:20:40.757',
    '2025-05-19 18:20:40.757'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '3f2bb833-1faf-4058-97a5-480ce246cab7',
    'b6a3b278-e62f-411a-b511-98f0f5084c12',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    1.000000000000000000000000000000,
    '2025-05-19 11:38:17.673',
    '2025-05-19 11:38:17.673'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '42fd21f6-26af-4dd7-a29a-76862a1b0304',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    1.000000000000000000000000000000,
    '2025-05-19 11:22:51.454',
    '2025-05-19 11:22:51.454'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '44a019b9-fced-4a3b-bcf6-3e10da6d9a7a',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    3.000000000000000000000000000000,
    '2025-05-19 12:09:30.410',
    '2025-05-19 12:09:30.410'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4c438851-fa92-4dc2-ac9c-16776794752e',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    '423dcfe3-dd7c-4145-867e-557ef853f987',
    1.000000000000000000000000000000,
    '2025-05-19 12:22:06.616',
    '2025-05-19 12:22:06.616'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '58219d98-3112-4ae2-b8c2-2f34978f4c0f',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    1.000000000000000000000000000000,
    '2025-05-19 12:08:56.097',
    '2025-05-19 12:08:56.097'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '58a4a836-9561-45a6-8540-6fb1667245cf',
    '571d4ab3-d143-4faf-b13a-5b1bb8dc1069',
    '6783fcab-95d3-49b6-812c-71e47858725d',
    150.000000000000000000000000000000,
    '2025-05-19 18:09:46.358',
    '2025-05-19 18:09:46.358'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5930c84d-decc-4047-8737-15b582cec42b',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    1.000000000000000000000000000000,
    '2025-05-19 11:22:04.151',
    '2025-05-19 11:22:04.151'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5b4ed0f8-205c-4821-94a2-9914dd11ed60',
    '48fd0274-df76-43d9-a212-58ff5add2d3b',
    'ddf79b3b-bbb7-422a-a597-8bc4ca68d2c1',
    1.000000000000000000000000000000,
    '2025-05-19 11:36:55.059',
    '2025-05-19 11:36:55.059'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '60544d47-c17d-42c4-a93d-04ee1ca68333',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    200.000000000000000000000000000000,
    '2025-05-19 12:02:32.117',
    '2025-05-19 12:02:32.117'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6276f46c-04a3-4b51-af60-cab66d00ee99',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    1.000000000000000000000000000000,
    '2025-05-19 11:17:34.016',
    '2025-05-19 11:17:34.016'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '679dd313-e595-40ac-a971-4b810d0354c4',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    '91db68b5-f78b-4412-80f1-42953beddf9c',
    1.000000000000000000000000000000,
    '2025-05-19 11:43:08.040',
    '2025-05-19 11:43:08.040'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6b590296-5dd9-4b43-acc2-865dbf5541c8',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    '1cfa1d77-6b15-4bcf-acdd-3da08a7372b9',
    1.000000000000000000000000000000,
    '2025-05-19 18:19:13.976',
    '2025-05-19 18:19:13.976'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6e6cf6bb-13ed-40dd-a63c-757b354979ad',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    'e61e2368-8222-4780-a103-2d69d652f463',
    350.000000000000000000000000000000,
    '2025-05-19 11:44:18.659',
    '2025-05-19 11:44:18.659'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7477776b-39fa-4ade-8ab1-ed765b988902',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    'e61e2368-8222-4780-a103-2d69d652f463',
    300.000000000000000000000000000000,
    '2025-05-19 11:43:52.709',
    '2025-05-19 11:43:52.709'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8636cf6d-1406-44dd-9edd-c4ce92b51150',
    '50962768-a856-4623-976f-696fe73615b4',
    'e61e2368-8222-4780-a103-2d69d652f463',
    350.000000000000000000000000000000,
    '2025-05-19 11:37:24.116',
    '2025-05-19 11:37:24.116'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '88b84728-1588-4b0f-9a98-511dde6a69f9',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    '55c21907-9719-468e-aa02-b6e8aa178233',
    200.000000000000000000000000000000,
    '2025-05-19 12:00:56.541',
    '2025-05-19 12:00:56.541'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '8d3646d5-8e31-490d-a052-8a86c755528a',
    '71532023-e03e-4dca-9a07-dd972b238203',
    '92c8c044-e2ed-443f-8a58-bda622cf9394',
    1.000000000000000000000000000000,
    '2025-05-19 18:10:10.951',
    '2025-05-19 18:10:10.951'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '90f35ef4-f2f9-4f87-a913-299b978fc5fa',
    '4b5b8ab5-dd73-4325-bff6-d0de427ed7cb',
    'b84f268f-a1ed-4887-a3b2-c60bdb6e1631',
    1.000000000000000000000000000000,
    '2025-05-19 18:11:22.702',
    '2025-05-19 18:11:22.702'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '912b27c7-dfb7-487d-b6de-fc8b413aa825',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    'cf38e6ef-a686-49a5-bb08-9da0b5d194c6',
    20.000000000000000000000000000000,
    '2025-05-19 13:12:09.828',
    '2025-05-19 13:12:09.828'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '96c85269-8af1-4110-ac9d-1e5d5efab9ef',
    '13886bc2-5d79-4008-883e-33c4a1278fba',
    'f6d6feec-3fc5-4bf1-967a-c8f3e7fcafe7',
    1.000000000000000000000000000000,
    '2025-05-19 11:36:26.605',
    '2025-05-19 11:36:26.605'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9d9f5fb5-5139-46a2-abb0-373c01d2c29c',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    '96e28634-3b80-4c0d-9b77-b31a46906c35',
    1.000000000000000000000000000000,
    '2025-05-19 18:13:01.461',
    '2025-05-19 18:13:01.461'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a1cd18c6-9ec2-454b-95ed-6510d60a3235',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    'c3d03239-532f-47b6-85bd-d9426db2406a',
    100.000000000000000000000000000000,
    '2025-05-19 12:08:40.048',
    '2025-05-19 12:08:40.048'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a4e9da7d-29c4-4317-b76c-8a742ee47b94',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    'b96b2aa9-7b58-434c-93f3-71a797b6acd1',
    1.000000000000000000000000000000,
    '2025-05-19 18:11:40.498',
    '2025-05-19 18:11:40.498'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a5879fc5-0ab5-48ed-80d5-c61976c6beea',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    'c9c1bd60-740a-494a-a4cc-3cb0b6a0f644',
    150.000000000000000000000000000000,
    '2025-05-19 18:09:09.357',
    '2025-05-19 18:09:09.357'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a86d046a-bf57-4303-bd77-b0b810f20991',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    'd5301512-3061-4a10-be4f-82943e996c8a',
    100.000000000000000000000000000000,
    '2025-05-19 12:13:08.285',
    '2025-05-19 12:13:08.285'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ae2c5ebd-31a6-4d1a-8d9e-52e72af43e65',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    'b4ea336f-3f28-42b8-9423-543e40684bac',
    200.000000000000000000000000000000,
    '2025-05-19 18:15:26.834',
    '2025-05-19 18:15:26.834'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b161055f-d7f3-4231-9cc9-f9057dd6a790',
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    1.000000000000000000000000000000,
    '2025-05-19 11:24:50.960',
    '2025-05-19 11:24:50.960'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b5c26910-43cd-4610-9949-fd529a236beb',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    'f6d6feec-3fc5-4bf1-967a-c8f3e7fcafe7',
    1.000000000000000000000000000000,
    '2025-05-19 11:36:35.368',
    '2025-05-19 11:36:35.368'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b89eb8fb-fcdf-43ea-8521-20f3bcc6554a',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    '712b4b21-c3cb-4f69-8eb1-ebe646a3120a',
    150.000000000000000000000000000000,
    '2025-05-19 18:10:35.356',
    '2025-05-19 18:10:35.356'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b8e1fb81-1ba0-422c-8dc0-db332e30cb0b',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    'b4b37403-65b1-4973-b9be-76f4c043a3de',
    200.000000000000000000000000000000,
    '2025-05-19 12:00:41.030',
    '2025-05-19 12:00:41.030'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'bc19ff51-0356-4f34-a794-90237f7c9b75',
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    200.000000000000000000000000000000,
    '2025-05-19 12:02:17.835',
    '2025-05-19 12:02:17.835'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'bdf2e195-4124-4b0e-a5ac-c2cb2fee4607',
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    '96c4d9ce-c59d-4d8b-a616-6660243d2b5f',
    1.000000000000000000000000000000,
    '2025-05-19 11:21:57.543',
    '2025-05-19 11:21:57.543'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd6566707-df00-48ce-b168-146fedc80db9',
    '3c0d32f9-184c-49f2-88d3-24d8a7e09a7e',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    1.000000000000000000000000000000,
    '2025-05-19 11:36:47.019',
    '2025-05-19 11:36:47.019'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e0ddccab-8b8c-443c-b965-2a770dd29e56',
    '289b6b99-ce39-4f1c-915b-24895dcf2169',
    '712b4b21-c3cb-4f69-8eb1-ebe646a3120a',
    150.000000000000000000000000000000,
    '2025-05-19 18:10:50.472',
    '2025-05-19 18:10:50.472'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f4ab2ff0-a189-49f4-834a-8a7becfdd009',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    'd5301512-3061-4a10-be4f-82943e996c8a',
    100.000000000000000000000000000000,
    '2025-05-19 12:12:30.314',
    '2025-05-19 12:12:30.314'
  );
INSERT INTO
  `product_ingredients` (
    `id`,
    `product_id`,
    `ingredient_id`,
    `dose`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f9d571c8-4b09-49f3-b61c-e77337cb6282',
    'f79273d1-1811-466b-b6cb-4374917165b3',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    1.000000000000000000000000000000,
    '2025-05-19 11:45:13.781',
    '2025-05-19 11:45:13.781'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: products
# ------------------------------------------------------------

INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    'Jengkol Balado',
    '/product/d06d4136-1eef-4071-8d96-ab5f6f2a5079.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 12:11:37.217',
    '2025-05-19 12:11:37.217'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    'Tempe Goreng',
    '/product/bfc57db6-8630-44cf-86af-3548aa6a68f8.jpg',
    2500.000000000000000000000000000000,
    1,
    '2025-05-19 11:53:34.514',
    '2025-05-19 18:58:22.198'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    'Nasi Putih',
    '/product/9780d664-1344-4f55-bb55-82173cdf9638.jpg',
    5000.000000000000000000000000000000,
    1,
    '2025-05-19 12:08:17.163',
    '2025-05-19 12:08:17.163'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '13886bc2-5d79-4008-883e-33c4a1278fba',
    'Tumis Ikan Selar',
    '/product/0b33469b-6080-4853-8c7f-d48cff27b26b.jpg',
    13000.000000000000000000000000000000,
    1,
    '2025-05-19 11:32:43.206',
    '2025-05-19 11:32:43.206'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '190c0657-2097-4e20-a004-8a67ae138648',
    'Teh Tawar Es/Panas',
    '/product/ea9d0b35-9061-4626-a4fc-2ce681c02616.jpg',
    2000.000000000000000000000000000000,
    1,
    '2025-05-19 17:46:56.248',
    '2025-05-19 17:46:56.248'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    'Ikan Asin Selar Goreng',
    '/product/e037075a-39e5-4658-a6d4-338cfb3275bb.jpg',
    7000.000000000000000000000000000000,
    1,
    '2025-05-19 11:32:13.409',
    '2025-05-19 11:32:13.409'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    'Teh Manis Es/Panas',
    '/product/59a073a4-2bc0-4f44-a61e-7b1f8f969960.jpg',
    5000.000000000000000000000000000000,
    1,
    '2025-05-19 13:10:45.089',
    '2025-05-19 17:46:28.592'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    'Telur Dadar',
    '/product/1707826f-dee8-48e0-b6c2-5454084bf5cf.jpg',
    5000.000000000000000000000000000000,
    1,
    '2025-05-19 12:21:57.389',
    '2025-05-19 18:47:29.129'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    'Tahu Goreng',
    '/product/66136136-c7ad-4962-ad6c-a80324ee02f0.jpg',
    2500.000000000000000000000000000000,
    1,
    '2025-05-19 11:53:09.834',
    '2025-05-19 18:58:35.540'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '289b6b99-ce39-4f1c-915b-24895dcf2169',
    'Alpukat Kocok Mentega',
    '/product/bdbe4741-8240-4e46-8bc2-956f0c530315.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 17:54:37.484',
    '2025-05-19 17:54:37.484'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    'Jus Mangga',
    '/product/cd93e938-9627-477b-95a5-56c6fa8d4d18.jpg',
    12000.000000000000000000000000000000,
    1,
    '2025-05-19 17:53:26.215',
    '2025-05-19 17:53:26.215'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '3c0d32f9-184c-49f2-88d3-24d8a7e09a7e',
    'Gurame Pecak 350 Gram',
    '/product/648abd51-cabd-4023-b2a8-9ec03036432e.jpg',
    45000.000000000000000000000000000000,
    1,
    '2025-05-19 11:26:55.298',
    '2025-05-19 11:26:55.298'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    'Es Batu',
    '/product/2984014e-5fe8-43da-b835-5fb93acdf420.jpg',
    1000.000000000000000000000000000000,
    1,
    '2025-05-19 17:56:17.121',
    '2025-05-19 17:56:17.121'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '48fd0274-df76-43d9-a212-58ff5add2d3b',
    'Ikan Sepat Goreng',
    '/product/fe9b08ac-111a-4160-912f-e1fb420cfdf1.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 11:33:06.567',
    '2025-05-19 11:33:06.567'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4b5b8ab5-dd73-4325-bff6-d0de427ed7cb',
    'Milo Es/Panas',
    '/product/9d1888fa-e7c1-4ff3-80c5-bacf2f580bc1.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 17:50:33.397',
    '2025-05-19 17:50:33.397'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4dca53a1-88a2-404b-af7e-06c3e086e46b',
    'Tumis Ikan Sepat',
    '/product/e8ac0fc6-0ffd-4669-abb6-56cebdf7dc72.jpg',
    13000.000000000000000000000000000000,
    1,
    '2025-05-19 11:33:26.171',
    '2025-05-19 11:33:26.171'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    'Ayam Penyet Saos Padang',
    '/product/ccdbbd48-9571-4984-b907-8cf6b09940bd.jpg',
    18000.000000000000000000000000000000,
    1,
    '2025-05-19 11:18:42.434',
    '2025-05-19 11:18:42.434'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '50962768-a856-4623-976f-696fe73615b4',
    'Iga Bakar Kecap Manis',
    '/product/788cf3f4-1d77-46d1-b89e-839c17d2fecd.jpg',
    40000.000000000000000000000000000000,
    1,
    '2025-05-19 11:29:42.813',
    '2025-05-19 11:29:42.813'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    'Sayur Asem',
    '/product/e219b59c-152a-4ef8-a78e-c4ab1e846ee2.jpg',
    7000.000000000000000000000000000000,
    1,
    '2025-05-19 11:54:45.747',
    '2025-05-19 11:54:45.747'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '571d4ab3-d143-4faf-b13a-5b1bb8dc1069',
    'Jus Buah Naga',
    '/product/4e4e0102-830e-4196-bc16-a0fbb7975006.jpg',
    12000.000000000000000000000000000000,
    1,
    '2025-05-19 17:57:00.792',
    '2025-05-19 18:58:06.809'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    'Cumi Goreng',
    NULL,
    13000.000000000000000000000000000000,
    1,
    '2025-05-19 12:01:31.109',
    '2025-05-19 12:01:31.109'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    'Nila Goreng',
    '/product/04da77ba-973d-41d7-a89e-2d7bd9aa95b8.jpg',
    22000.000000000000000000000000000000,
    1,
    '2025-05-19 11:20:17.168',
    '2025-05-19 11:20:17.168'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    'Air Minerale 600 ml',
    '/product/d6cf56a4-3de0-450a-844b-bd709bc5b2c8.jpg',
    7000.000000000000000000000000000000,
    1,
    '2025-05-19 17:56:04.888',
    '2025-05-19 18:18:20.501'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6e80e9bc-bf07-4eff-9913-0d088134f271',
    'Gurame Goreng 500 Gram',
    '/product/e2d817ee-27e7-4c93-8314-8d239323b8b1.jpg',
    60000.000000000000000000000000000000,
    1,
    '2025-05-19 11:24:29.970',
    '2025-05-19 11:24:29.970'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '6e876c14-b07d-4288-a5a0-946bf44982a3',
    'Jus Jambu',
    '/product/f08c2b1c-4096-4d5c-86c3-cbc07ed5d9c9.jpg',
    12000.000000000000000000000000000000,
    1,
    '2025-05-19 17:57:13.917',
    '2025-05-19 18:44:51.050'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '71532023-e03e-4dca-9a07-dd972b238203',
    'Jeruk Es/Panas',
    '/product/3705e384-239d-47f1-9e97-52d6ca879bb8.jpg',
    8000.000000000000000000000000000000,
    1,
    '2025-05-19 17:49:36.580',
    '2025-05-19 17:49:36.580'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    'Ayam Penyet Sambel Ceurik',
    '/product/1b2aea28-f211-4dc9-8891-701478ae0a8b.jpg',
    18000.000000000000000000000000000000,
    1,
    '2025-05-19 11:18:25.496',
    '2025-05-19 11:18:25.496'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    'Teh Tarik Es/Panas',
    '/product/81977699-466b-4ed2-bfe0-82467cd48b33.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 17:51:12.331',
    '2025-05-19 17:54:13.745'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    'Nila Pecak',
    NULL,
    25000.000000000000000000000000000000,
    1,
    '2025-05-19 11:22:43.043',
    '2025-05-19 11:22:43.043'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    'Tempe Penyet',
    '/product/497e7eee-0029-415e-ac2f-7b28fa19e12a.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 12:07:57.329',
    '2025-05-19 12:07:57.329'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '891012ff-2b63-4834-92c2-be50cae6b070',
    'Jus Strawberry',
    '/product/9ce280db-9773-419e-bc94-d4085aeee398.jpg',
    12000.000000000000000000000000000000,
    1,
    '2025-05-19 17:53:14.737',
    '2025-05-19 17:53:14.737'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '93598b46-a756-4e6a-9a63-fb56c1d213f8',
    'Chocolat Es/Panas',
    NULL,
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 17:52:42.262',
    '2025-05-19 17:52:42.262'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '93802ab0-71c1-48d1-a760-52376a26851f',
    'Tumis Kangkung',
    '/product/af5015d3-7ae3-49d3-8934-61e646f628b0.jpg',
    8000.000000000000000000000000000000,
    1,
    '2025-05-19 11:53:48.319',
    '2025-05-19 11:54:22.018'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    'Tahu Penyet',
    '/product/eb18a983-6efc-4d0c-b8d6-97709742fbd0.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 12:07:42.357',
    '2025-05-19 12:07:42.357'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    'Nila Saos Padang',
    NULL,
    23000.000000000000000000000000000000,
    1,
    '2025-05-19 11:21:22.768',
    '2025-05-19 11:21:22.768'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    'Tumis Toge',
    '/product/b3230e4b-015c-47e0-96c3-fb27c9fd165c.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 11:54:08.041',
    '2025-05-19 11:54:08.041'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    'Sop Iga',
    '/product/f742f16e-1137-49b9-81f3-74df23ce8ff5.jpg',
    35000.000000000000000000000000000000,
    1,
    '2025-05-19 11:30:14.084',
    '2025-05-19 11:30:14.084'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'b6a3b278-e62f-411a-b511-98f0f5084c12',
    'Gurame Bakar 500 Gram',
    '/product/496f3264-8347-4ae5-b24b-19cbd32700f4.jpg',
    45000.000000000000000000000000000000,
    1,
    '2025-05-19 11:25:56.964',
    '2025-05-19 11:25:56.964'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    'Tumis Ikan Peda',
    '/product/848636bc-3016-4432-876e-e7da9e1c182d.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 11:34:20.107',
    '2025-05-19 11:34:20.107'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    'Jengkol Goreng',
    '/product/32ed42f5-fc36-4801-a27e-f132d5fd8723.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 12:11:16.048',
    '2025-05-19 12:11:16.048'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    'Ayam Goreng',
    '/product/e2e7c299-11f9-40b7-b77a-a8c531b82089.jpg',
    17000.000000000000000000000000000000,
    1,
    '2025-05-19 11:17:25.303',
    '2025-05-19 11:17:25.303'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    'Tumis Cumi',
    NULL,
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 12:01:43.764',
    '2025-05-19 12:01:43.764'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    'Gurame Goreng 350 Gram',
    '/product/a31139ca-693f-4ecc-94c6-0f3e646c27eb.jpg',
    45000.000000000000000000000000000000,
    1,
    '2025-05-19 11:23:51.139',
    '2025-05-19 11:23:51.139'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    'Ayam Bakar Madu',
    '/product/56d14df7-6a36-427d-92dd-7b2288f1611e.jpg',
    18000.000000000000000000000000000000,
    1,
    '2025-05-19 11:17:57.654',
    '2025-05-19 11:17:57.654'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    'Iga Bakar Kecap Pedas',
    '/product/6d30cd60-806f-4738-b52d-017e4e6db1a9.jpg',
    42000.000000000000000000000000000000,
    1,
    '2025-05-19 11:30:00.188',
    '2025-05-19 11:30:00.188'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    'Gurame Bakar 350 Gram',
    '/product/01bb8067-d6e6-40fc-a0c5-a0665d44ead9.jpg',
    45000.000000000000000000000000000000,
    1,
    '2025-05-19 11:25:31.700',
    '2025-05-19 11:25:31.700'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    'Lemon Tea Es/Panas',
    NULL,
    8000.000000000000000000000000000000,
    1,
    '2025-05-19 17:52:27.477',
    '2025-05-19 17:52:27.477'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'df094a92-12c4-430a-8c57-51aff33fd312',
    'Nila Bakar',
    '/product/1f7ebad7-175e-4e58-888e-ac6a1ecab51e.jpg',
    23000.000000000000000000000000000000,
    1,
    '2025-05-19 11:20:46.143',
    '2025-05-19 11:20:46.143'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'e2fa86b5-6fa9-49e6-9632-278bb6886569',
    'Ikan Peda Goreng',
    '/product/1bd21536-bcec-44a8-af0c-07d86c28df1e.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 11:33:51.396',
    '2025-05-19 11:33:51.396'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'f79273d1-1811-466b-b6cb-4374917165b3',
    'Gurame Pecak 500 Gram',
    '/product/fc651a6e-7b3c-4cb6-92dc-12aabaa8096b.jpg',
    65000.000000000000000000000000000000,
    1,
    '2025-05-19 11:26:36.411',
    '2025-05-19 11:26:36.411'
  );
INSERT INTO
  `products` (
    `id`,
    `name`,
    `image`,
    `price`,
    `is_active`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    'Jus Alpukat',
    '/product/c490b2b8-9264-4a22-93df-79986c94189f.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 17:53:42.121',
    '2025-05-19 17:53:42.121'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `name`,
    `email`,
    `password`,
    `role`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '5f379920-3d3d-4821-9a85-e44495d592ef',
    'Admin Man',
    'admin@gmail.com',
    '$2b$10$sEZmNjlTnpSwH2FnnUMaoOLKlKf.xj.kUakOiSB0unqtr3zeH5x.G',
    'ADMIN',
    '2025-05-19 06:06:37.107',
    '2025-05-19 06:06:37.107'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `email`,
    `password`,
    `role`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'affbead4-d4e5-4ef3-bcdb-22b4a011c4cc',
    'Cashier Guy',
    'cashier@gmail.com',
    '$2b$10$mTqxBcrbf.rAwMUmXJEafe5LZCW/bv0srempdRYXf92S0eGowoUwW',
    'CASHIER',
    '2025-05-19 06:06:37.107',
    '2025-05-19 06:06:37.107'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `email`,
    `password`,
    `role`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ba0c73bb-b337-4b63-ae9b-06f31a6892d6',
    'analytics Guy',
    'analytics@gmail.com',
    '$2b$10$5p0iepUqDN6ILvDEqdvutuPCZAC9PLp2WXwO1umaYo439ycRaVuz2',
    'ANALYTICS',
    '2025-05-19 06:06:37.107',
    '2025-05-19 06:06:37.107'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `email`,
    `password`,
    `role`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd3f5d16c-0ff3-43a1-afc3-a0c4a87c5f95',
    'Inventory Manager',
    'inventory@gmail.com',
    '$2b$10$Yequ9/03bZbeA3XCbczEh.3fTaMhqFmFOdz20F3zRcLcWPk/kus2S',
    'INVENTORY',
    '2025-05-19 06:06:37.107',
    '2025-05-19 06:06:37.107'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
