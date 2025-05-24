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
    '0c0ddc7b-7821-48db-b9b8-d52ce8e3d775',
    'f6d6feec-3fc5-4bf1-967a-c8f3e7fcafe7',
    3000000.000000000000000000000000000000,
    0.004333333333333333000000000000,
    13000.000000000000000000000000000000,
    NULL,
    '2025-05-23 07:32:55.066',
    '2025-05-23 07:32:55.066'
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
    '2166a0c9-7307-48ea-818e-f0deff48cc0f',
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    30000.000000000000000000000000000000,
    0.083333333333333330000000000000,
    2500.000000000000000000000000000000,
    NULL,
    '2025-05-23 08:49:16.624',
    '2025-05-23 08:49:16.624'
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
    '2b6dc5f4-c684-4ab2-b181-de1f66ef7a69',
    'b4b37403-65b1-4973-b9be-76f4c043a3de',
    100.000000000000000000000000000000,
    0.250000000000000000000000000000,
    25.000000000000000000000000000000,
    NULL,
    '2025-05-20 08:33:20.619',
    '2025-05-20 08:33:20.619'
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
    '30c2d069-8100-45e9-8fb5-c769cb1608e6',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    30000.000000000000000000000000000000,
    1.500000000000000000000000000000,
    45000.000000000000000000000000000000,
    NULL,
    '2025-05-23 08:49:35.699',
    '2025-05-23 08:49:35.699'
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
    '4818e725-3632-4cf5-b6e2-196d26579299',
    'd5301512-3061-4a10-be4f-82943e996c8a',
    1000.000000000000000000000000000000,
    30.000000000000000000000000000000,
    30000.000000000000000000000000000000,
    NULL,
    '2025-05-20 06:39:48.798',
    '2025-05-20 06:39:48.798'
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
    '52b44781-6fb1-4c17-a3c9-b02e521ee90f',
    '21463e89-5f09-441c-ab4b-d05abc1a984c',
    500000.000000000000000000000000000000,
    0.020000000000000000000000000000,
    10000.000000000000000000000000000000,
    NULL,
    '2025-05-22 05:01:30.389',
    '2025-05-22 05:01:30.389'
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
    '5824eed8-3f76-4096-8f9b-659be55e879e',
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    1000000.000000000000000000000000000000,
    0.130000000000000000000000000000,
    130000.000000000000000000000000000000,
    NULL,
    '2025-05-23 07:31:40.014',
    '2025-05-23 07:31:40.014'
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
    '6b01d1d6-5a32-4288-a4c5-0156ce466a40',
    '91db68b5-f78b-4412-80f1-42953beddf9c',
    80.000000000000000000000000000000,
    1875.000000000000000000000000000000,
    150000.000000000000000000000000000000,
    NULL,
    '2025-05-21 15:10:48.074',
    '2025-05-21 15:10:48.074'
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
    '70097d07-0f96-40bf-9828-16a48c499024',
    '423dcfe3-dd7c-4145-867e-557ef853f987',
    80.000000000000000000000000000000,
    1875.000000000000000000000000000000,
    150000.000000000000000000000000000000,
    NULL,
    '2025-05-21 15:09:28.290',
    '2025-05-21 15:09:28.290'
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
    '829a4a6d-2d9f-4a86-94ea-1f2ec1797da0',
    '4cc4d16a-079c-4506-bc0e-df1f347accee',
    80.000000000000000000000000000000,
    10000.000000000000000000000000000000,
    800000.000000000000000000000000000000,
    NULL,
    '2025-05-19 19:19:56.857',
    '2025-05-19 19:19:56.857'
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
    '9c3e8725-f4b1-40a5-ab16-af7ef6f8cee3',
    'e61e2368-8222-4780-a103-2d69d652f463',
    300000.000000000000000000000000000000,
    0.150000000000000000000000000000,
    45000.000000000000000000000000000000,
    NULL,
    '2025-05-23 08:55:26.493',
    '2025-05-23 08:55:26.493'
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
    'a2a2d6da-a614-4d57-83f5-58b87d31d499',
    '55c21907-9719-468e-aa02-b6e8aa178233',
    5000.000000000000000000000000000000,
    10.000000000000000000000000000000,
    50000.000000000000000000000000000000,
    NULL,
    '2025-05-21 15:07:25.124',
    '2025-05-21 15:07:25.124'
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
    'b34c2006-5aa1-4aa1-abdb-98e9aa9af872',
    '013f65f4-83fd-4d35-aa63-03a92ff986da',
    10.000000000000000000000000000000,
    500.000000000000000000000000000000,
    5000.000000000000000000000000000000,
    NULL,
    '2025-05-20 05:42:48.081',
    '2025-05-20 05:42:48.081'
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
    'b8fbf058-f937-400b-85cc-2c556ff30e6a',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    500.000000000000000000000000000000,
    90.000000000000000000000000000000,
    45000.000000000000000000000000000000,
    NULL,
    '2025-05-23 09:00:43.600',
    '2025-05-23 09:00:43.600'
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
    'be96035d-2c61-4c36-81a8-98905bda1782',
    '0e47cdad-7c53-43b2-a7ad-c5fc23d87144',
    500.000000000000000000000000000000,
    1000.000000000000000000000000000000,
    500000.000000000000000000000000000000,
    NULL,
    '2025-05-20 05:58:14.889',
    '2025-05-20 05:58:14.889'
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
    'e0615688-d017-4ff8-93f8-bc02a79aa85a',
    '21463e89-5f09-441c-ab4b-d05abc1a984c',
    500000.000000000000000000000000000000,
    0.016000000000000000000000000000,
    8000.000000000000000000000000000000,
    NULL,
    '2025-05-22 05:02:03.830',
    '2025-05-22 05:02:03.830'
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
    'e3491da9-a2ec-4e7c-90be-ec5a6b3ddbba',
    'cfc75508-4c1a-42da-8725-e8acd797cc79',
    500.000000000000000000000000000000,
    200.000000000000000000000000000000,
    100000.000000000000000000000000000000,
    NULL,
    '2025-05-20 06:01:54.835',
    '2025-05-20 06:01:54.835'
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
    'e4b596a9-bf44-4289-b95c-51f1e32cd38f',
    '70785041-1f9e-46cc-b2fa-87a1465b5d1a',
    5000.000000000000000000000000000000,
    100.000000000000000000000000000000,
    500000.000000000000000000000000000000,
    NULL,
    '2025-05-19 19:24:09.768',
    '2025-05-19 19:24:09.768'
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
    30021.000000000000000000000000000000,
    'PCS',
    1.909664563268017000000000000000,
    1,
    '2025-05-19 12:04:34.907',
    '2025-05-24 09:50:21.705'
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
    '0e47cdad-7c53-43b2-a7ad-c5fc23d87144',
    'Kerupuk',
    463.000000000000000000000000000000,
    'PCS',
    1000.000000000000000000000000000000,
    1,
    '2025-05-20 05:57:39.838',
    '2025-05-24 08:10:24.877'
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
    38.000000000000000000000000000000,
    'PCS',
    1000.000000000000000000000000000000,
    1,
    '2025-05-19 18:16:35.684',
    '2025-05-24 07:07:50.787'
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
    '21463e89-5f09-441c-ab4b-d05abc1a984c',
    'Kangkung',
    998650.000000000000000000000000000000,
    'G',
    0.018000000000000000000000000000,
    1,
    '2025-05-22 05:01:05.624',
    '2025-05-24 09:50:21.687'
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
    30009.000000000000000000000000000000,
    'PCS',
    12.329223592135960000000000000000,
    1,
    '2025-05-19 07:06:02.905',
    '2025-05-24 09:50:21.697'
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
    1700.000000000000000000000000000000,
    'G',
    45.000000000000000000000000000000,
    1,
    '2025-05-19 18:03:32.863',
    '2025-05-22 05:35:41.270'
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
    78.000000000000000000000000000000,
    'PCS',
    1875.000000000000000000000000000000,
    1,
    '2025-05-19 12:21:25.429',
    '2025-05-24 06:59:24.336'
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
    10.000000000000000000000000000000,
    'PCS',
    500.000000000000000000000000000000,
    1,
    '2025-05-19 12:04:28.699',
    '2025-05-24 07:38:10.463'
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
    100.000000000000000000000000000000,
    'PCS',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 10:06:22.289',
    '2025-05-19 19:19:56.867'
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
    3400.000000000000000000000000000000,
    'G',
    10.714285714285710000000000000000,
    1,
    '2025-05-19 11:55:21.753',
    '2025-05-24 05:40:28.173'
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
    511.000000000000000000000000000000,
    'PCS',
    456.310679611650500000000000000000,
    1,
    '2025-05-19 10:05:44.414',
    '2025-05-23 09:26:05.823'
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
    '70785041-1f9e-46cc-b2fa-87a1465b5d1a',
    'Sambel Ceurik Ngagoak',
    4800.000000000000000000000000000000,
    'G',
    100.000000000000000000000000000000,
    1,
    '2025-05-19 19:23:10.762',
    '2025-05-23 10:06:47.258'
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
    2500.000000000000000000000000000000,
    'G',
    45.000000000000000000000000000000,
    1,
    '2025-05-19 18:07:18.230',
    '2025-05-23 09:19:03.542'
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
    4.000000000000000000000000000000,
    'PCS',
    7500.000000000000000000000000000000,
    1,
    '2025-05-19 07:02:56.156',
    '2025-05-24 08:10:24.855'
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
    82.000000000000000000000000000000,
    'PCS',
    2187.500000000000000000000000000000,
    1,
    '2025-05-19 10:15:33.951',
    '2025-05-24 09:50:21.727'
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
    75.000000000000000000000000000000,
    'PCS',
    700.000000000000000000000000000000,
    1,
    '2025-05-19 17:58:13.579',
    '2025-05-24 09:50:21.752'
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
    14.000000000000000000000000000000,
    'PCS',
    8750.000000000000000000000000000000,
    1,
    '2025-05-19 07:04:28.312',
    '2025-05-24 07:38:10.486'
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
    94.000000000000000000000000000000,
    'PCS',
    2.000000000000000000000000000000,
    1,
    '2025-05-19 18:01:23.259',
    '2025-05-24 09:50:21.735'
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
    999300.000000000000000000000000000000,
    'G',
    0.229540918163672600000000000000,
    1,
    '2025-05-19 11:59:18.125',
    '2025-05-24 07:38:10.527'
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
    'tumis kangkung',
    100.000000000000000000000000000000,
    'PCS',
    9.535714285714286000000000000000,
    1,
    '2025-05-19 11:55:02.800',
    '2025-05-22 05:06:14.048'
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
    12800.000000000000000000000000000000,
    'G',
    1.000000000000000000000000000000,
    1,
    '2025-05-19 18:14:08.490',
    '2025-05-23 09:16:37.482'
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
    99.000000000000000000000000000000,
    'PCS',
    2000.000000000000000000000000000000,
    1,
    '2025-05-19 18:00:43.752',
    '2025-05-24 09:50:21.761'
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
    96.000000000000000000000000000000,
    'PCS',
    20.000000000000000000000000000000,
    1,
    '2025-05-19 18:02:49.791',
    '2025-05-22 10:02:53.826'
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
    4300.000000000000000000000000000000,
    'G',
    15.000000000000000000000000000000,
    1,
    '2025-05-19 12:06:13.813',
    '2025-05-24 09:50:21.712'
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
    950.000000000000000000000000000000,
    'G',
    25.000000000000000000000000000000,
    1,
    '2025-05-19 18:05:46.176',
    '2025-05-23 14:22:18.619'
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
    20.000000000000000000000000000000,
    'G',
    7.500000000000000000000000000000,
    1,
    '2025-05-19 13:11:19.629',
    '2025-05-24 09:50:21.743'
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
    'cfc75508-4c1a-42da-8725-e8acd797cc79',
    'Kerupuk Gantung',
    500.000000000000000000000000000000,
    'PCS',
    200.000000000000000000000000000000,
    1,
    '2025-05-20 06:01:13.007',
    '2025-05-20 06:01:54.843'
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
    500.000000000000000000000000000000,
    'G',
    30.000000000000000000000000000000,
    1,
    '2025-05-19 12:02:57.320',
    '2025-05-23 14:22:18.602'
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
    49.000000000000000000000000000000,
    'PCS',
    6000.000000000000000000000000000000,
    1,
    '2025-05-19 10:13:16.984',
    '2025-05-23 09:21:01.467'
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
    850.000000000000000000000000000000,
    'G',
    10.000000000000000000000000000000,
    1,
    '2025-05-19 11:55:30.625',
    '2025-05-24 09:39:22.623'
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
    298400.000000000000000000000000000000,
    'G',
    1.204620462046205000000000000000,
    1,
    '2025-05-19 10:06:07.242',
    '2025-05-24 09:50:21.720'
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
    1700.000000000000000000000000000000,
    'G',
    20.000000000000000000000000000000,
    1,
    '2025-05-19 18:05:11.286',
    '2025-05-23 07:31:56.722'
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
    3000007.000000000000000000000000000000,
    'PCS',
    0.016333137335685300000000000000,
    1,
    '2025-05-19 10:07:35.568',
    '2025-05-24 07:18:13.656'
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
    '056146c2-5c01-4af8-803d-e7fb992cb139',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-22 13:42:17.417',
    '2025-05-22 13:42:17.417'
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
    '06dd9270-0dee-4bf2-9bb0-f366f4148e8e',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    4,
    '2025-05-24 07:38:10.472',
    '2025-05-24 07:38:10.472'
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
    '08d7d4d3-9ee3-4e76-a099-5c6961a34524',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-21 06:51:23.364',
    '2025-05-21 06:51:23.364'
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
    '135d6038-0558-4039-b3f3-970daa934df6',
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-24 06:59:24.321',
    '2025-05-24 06:59:24.321'
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
    '1a0d1d4a-c346-4f41-90a7-aad6d61fb8be',
    '8f9615c0-a456-40ee-bedb-bc2d2b0478ff',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-23 09:23:06.342',
    '2025-05-23 09:23:06.342'
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
    '1a312f96-f344-4702-8c33-c293d3709ab6',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-23 07:31:56.754',
    '2025-05-23 07:31:56.754'
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
    '1c6b01ad-9c3e-4b4f-97f2-153f73a2e50a',
    'ea6870a9-1dea-4735-86a5-dca1591aea1d',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-22 13:28:15.478',
    '2025-05-22 13:28:15.478'
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
    '20547f08-6d33-4635-9957-34ce2fc493db',
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-24 06:59:24.343',
    '2025-05-24 06:59:24.343'
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
    '232a227c-ea46-4525-8ae7-cef42d7873f2',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 10:52:14.129',
    '2025-05-22 10:52:14.129'
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
    '2889bb8f-03c7-42b5-9b6b-d390bacab810',
    '06e507de-390c-454c-9b20-6694a2502dec',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    2,
    '2025-05-22 13:18:00.155',
    '2025-05-22 13:18:00.155'
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
    '31dd657a-604c-4383-a0b9-72b65b78b1fd',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-21 07:11:39.297',
    '2025-05-21 07:11:39.297'
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
    '32cfc98c-934c-4f6d-974f-281245d95bc0',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 07:08:48.255',
    '2025-05-22 07:08:48.255'
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
    '3a093ae6-c646-480b-94ef-ebd48d79a070',
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-20 07:45:47.192',
    '2025-05-20 07:45:47.192'
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
    '3dac74fc-9113-44c8-9519-7c9545bf9233',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-21 07:17:36.221',
    '2025-05-21 07:17:36.221'
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
    '3f4d4f37-a8a2-4346-a161-c2b8e5f18864',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-22 05:57:17.707',
    '2025-05-22 05:57:17.707'
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
    '425f978a-780f-4aa3-8079-55e837c65e95',
    '31968987-8060-434e-8c46-e83d6023b9a5',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-21 15:12:56.927',
    '2025-05-21 15:12:56.927'
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
    '4ebb61ca-21ca-4f07-b82a-e0b89ec4c461',
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-24 06:59:24.300',
    '2025-05-24 06:59:24.300'
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
    '52a28452-e064-4a1f-a57e-4ff379fe853c',
    'd57648aa-c853-4591-836a-2197ede095dc',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-22 05:23:44.483',
    '2025-05-22 05:23:44.483'
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
    '530cd48c-0fef-4302-bc7a-e91a7868e0cd',
    '340c66a7-a516-4bbd-81f0-bdfe35339b7b',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    2,
    '2025-05-20 09:28:19.895',
    '2025-05-20 09:28:19.895'
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
    '57dbb121-fa25-4b75-ae8e-7e1a6e6f7e7b',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-22 05:57:17.742',
    '2025-05-22 05:57:17.742'
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
    '58a8d5a0-c952-4f84-bcc7-a1f2c2617205',
    '4e734b6f-a13d-4235-a745-5d5fff720e88',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 05:33:34.718',
    '2025-05-22 05:33:34.718'
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
    '58f1ae49-8138-4acb-a626-6f747aa31615',
    'c4ac97e5-0660-48cd-836c-b003d653c821',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 04:34:59.661',
    '2025-05-22 04:34:59.661'
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
    '613150c6-212d-4491-acf2-d26fae89116c',
    '4e734b6f-a13d-4235-a745-5d5fff720e88',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 05:33:34.737',
    '2025-05-22 05:33:34.737'
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
    '61f880d3-9626-480f-8d0a-7ecefede1560',
    '5fb0b2df-83d4-415f-9073-321153e18f4b',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-24 05:40:28.154',
    '2025-05-24 05:40:28.154'
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
    '61f95b71-1251-43d9-a60e-dea0c282a05d',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-20 05:49:38.456',
    '2025-05-20 05:49:38.456'
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
    '67a4f2b2-82ab-4d61-9dfa-8b9991faf20d',
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    1,
    '2025-05-23 07:06:30.631',
    '2025-05-23 07:06:30.631'
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
    '6f35dfbe-b5f7-4caf-b822-99c11c25805b',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-23 14:11:43.395',
    '2025-05-23 14:11:43.395'
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
    '71199ef4-348d-4bec-b64a-afa7841e2bf1',
    'b834497d-5376-4ce8-9f00-9138159651d4',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    8,
    '2025-05-20 05:40:53.878',
    '2025-05-20 05:40:53.878'
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
    '72f8967a-8c31-4f80-a750-c728e86163ba',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    2,
    '2025-05-22 13:45:49.647',
    '2025-05-22 13:45:49.647'
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
    '776c65b2-5b64-43f8-84fe-3ebcf83da1c1',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-21 06:51:23.345',
    '2025-05-21 06:51:23.345'
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
    '7b72390e-3b67-4085-88d7-0d8bc6e5745a',
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 13:39:06.205',
    '2025-05-22 13:39:06.205'
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
    '8cf8e3ce-332b-4ada-b756-120c7ef2b472',
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-23 07:06:30.652',
    '2025-05-23 07:06:30.652'
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
    '9a7b5de6-38b3-492a-94a9-f8c9858d6659',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-21 06:48:16.540',
    '2025-05-21 06:48:16.540'
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
    'a78952de-c355-4dd0-8819-7a9ed0385b4c',
    '75051264-8f10-41ea-a673-5330e2784174',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 06:29:13.167',
    '2025-05-22 06:29:13.167'
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
    'a80cffb0-ec12-47fd-bd74-ba4c5c5309e9',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-21 06:48:16.561',
    '2025-05-21 06:48:16.561'
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
    'b4f7f2dd-9591-492d-9fc5-92ebf1196959',
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-23 07:06:30.601',
    '2025-05-23 07:06:30.601'
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
    'b6e97441-1ba5-4ae7-9d9d-58b96973a68b',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-22 13:42:17.458',
    '2025-05-22 13:42:17.458'
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
    'bc8742b2-b75b-4e42-bbde-d82aaf2ce749',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 10:52:14.195',
    '2025-05-22 10:52:14.195'
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
    'bd027a59-19eb-4105-bcf2-c74f698d584f',
    '02b5e0cc-193f-4e0d-88e0-e15a695c3253',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-22 14:05:19.110',
    '2025-05-22 14:05:19.110'
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
    'bd6a866f-cc5c-4f4b-8c26-c462ac2120ec',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    1,
    '2025-05-23 14:22:18.614',
    '2025-05-23 14:22:18.614'
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
    'c552c099-7642-4ca0-b2b4-d5b0397ce434',
    '8f9615c0-a456-40ee-bedb-bc2d2b0478ff',
    'a3d3f73f-c7e7-48bc-9f8d-93c203d2a964',
    1,
    '2025-05-23 09:23:06.322',
    '2025-05-23 09:23:06.322'
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
    'c77f6b14-575d-4974-a63d-23ffbd1899ca',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-23 09:19:03.508',
    '2025-05-23 09:19:03.508'
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
    'd495e953-1029-47a5-89ab-524fd4bb1b78',
    '75051264-8f10-41ea-a673-5330e2784174',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-22 06:29:13.141',
    '2025-05-22 06:29:13.141'
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
    'd5aeaa18-a2d9-4e02-852c-935901a69b62',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 05:35:41.233',
    '2025-05-22 05:35:41.233'
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
    'd6674409-3818-4b79-a9e8-5c9c1fac93f6',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 13:53:00.290',
    '2025-05-22 13:53:00.290'
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
    'd77edc4d-239f-4dd1-b14f-4b8b19dd7c2f',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-22 13:53:00.314',
    '2025-05-22 13:53:00.314'
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
    'dd07835c-91a2-4d2e-a8bf-386b2e643548',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    1,
    '2025-05-22 10:52:14.092',
    '2025-05-22 10:52:14.092'
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
    'e1877403-d7ed-4585-973a-1b23039b6ade',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'cf2f0dd8-9ec4-4b41-9772-4380e4b96118',
    5,
    '2025-05-20 05:49:38.477',
    '2025-05-20 05:49:38.477'
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
    'eabee7f0-1d21-4340-853f-5e3ccde2b47c',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-22 07:08:48.225',
    '2025-05-22 07:08:48.225'
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
    'eed2e8b1-28bc-4c52-93ff-1758561de0bb',
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 13:39:06.186',
    '2025-05-22 13:39:06.186'
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
    'ef3039ab-2ec6-4932-a7dd-eba60e3f66d2',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    1,
    '2025-05-22 10:52:14.111',
    '2025-05-22 10:52:14.111'
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
    'f4215733-f074-4b9a-8202-a85be9248536',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    '0901ac6a-0622-4b37-916d-ac75fac4d6e7',
    1,
    '2025-05-23 09:19:03.529',
    '2025-05-23 09:19:03.529'
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
    'fd09adcd-9b82-451f-a420-060dc0120ccf',
    'c4ac97e5-0660-48cd-836c-b003d653c821',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    1,
    '2025-05-22 04:34:59.687',
    '2025-05-22 04:34:59.687'
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
    'ffeb7e4a-b89c-46ab-9bb1-c4878f17fabb',
    'f7a2f358-47f2-4594-b50b-32117351cda5',
    '2b4bb3d0-508f-4b47-9f08-9a1d64a6d514',
    2,
    '2025-05-21 06:34:22.848',
    '2025-05-21 06:34:22.848'
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
    '004841c8-0fa0-4c7f-9632-5fb4a0fa1643',
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    '71532023-e03e-4dca-9a07-dd972b238203',
    2,
    '2025-05-23 07:06:30.661',
    '2025-05-23 07:06:30.661'
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
    '0089fa3a-e23f-4866-972f-0b2cb8574324',
    'ad82a598-d22b-46e1-b262-ba1e140b2a1a',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-20 06:03:39.041',
    '2025-05-20 06:03:39.041'
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
    '014813c0-4098-4443-adc0-f8ea77cd7040',
    '9360582e-2af0-4901-868f-f7e14163955e',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    1,
    '2025-05-22 13:48:29.160',
    '2025-05-22 13:48:29.160'
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
    '01cf23f4-7b7d-4fef-8f2f-bd3b0be2ed11',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-22 10:02:53.856',
    '2025-05-22 10:02:53.856'
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
    '02c3a47a-dac7-4715-8930-f7f64873695a',
    '5fb0b2df-83d4-415f-9073-321153e18f4b',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-24 05:40:28.166',
    '2025-05-24 05:40:28.166'
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
    '03bc2a77-c7af-4ba5-8b30-fdeaea53ea91',
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    2,
    '2025-05-20 07:45:47.225',
    '2025-05-20 07:45:47.225'
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
    '04453e16-a0ff-4320-8941-eb0c8931dd21',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-22 05:57:17.671',
    '2025-05-22 05:57:17.671'
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
    '06d52fba-0004-4381-a663-fd0f403a2038',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-23 14:11:43.366',
    '2025-05-23 14:11:43.366'
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
    '07227420-21ce-453a-9e26-96bcd166d0d3',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-22 13:45:49.592',
    '2025-05-22 13:45:49.592'
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
    '08aa4b6a-9250-4480-a05c-2f2d8f579822',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-23 09:16:37.464',
    '2025-05-23 09:16:37.464'
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
    '098e1017-1957-4f7d-9242-072fb8d728c0',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-21 06:48:16.504',
    '2025-05-21 06:48:16.504'
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
    '0af10595-6722-421e-9fb5-8b04f8f7682e',
    '4539a5f1-b2b5-4744-b70a-b68abcee2bee',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 09:12:28.839',
    '2025-05-23 09:12:28.839'
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
    '0b353375-ddc4-4fe1-9d50-b7c58dd87c33',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    4,
    '2025-05-24 07:38:10.522',
    '2025-05-24 07:38:10.522'
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
    '0d88d126-acab-45fb-9b16-4f284c960cbe',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-23 09:26:05.819',
    '2025-05-23 09:26:05.819'
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
    '0d96492f-f3d3-4ff6-a9ab-da014dc1e40e',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    2,
    '2025-05-21 06:51:23.388',
    '2025-05-21 06:51:23.388'
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
    '0e330125-2207-4f1f-84f5-b566fa649ced',
    '1698330b-0736-4014-9e89-b98e40011e7a',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-21 15:16:11.328',
    '2025-05-21 15:16:11.328'
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
    '0e399a8e-96d7-4ab7-96e2-e024b53575ce',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-24 07:38:10.497',
    '2025-05-24 07:38:10.497'
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
    '0e673c34-4a19-452d-b295-8996b387a1c0',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-24 09:50:21.730',
    '2025-05-24 09:50:21.730'
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
    '0eb20a90-d60d-4c28-9603-7689502c8903',
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    'e60bee15-d3cd-48e8-abba-c80959d5ac41',
    1,
    '2025-05-23 08:21:48.779',
    '2025-05-23 08:21:48.779'
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
    '0ee70501-a555-4b56-928b-40823d3656eb',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 05:35:41.265',
    '2025-05-22 05:35:41.265'
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
    '10acb8bd-58b3-4a20-9739-93c3c5236057',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-21 07:14:48.998',
    '2025-05-21 07:14:48.998'
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
    '110c413b-c42c-490a-af7c-2d20c40ba89f',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-22 07:08:48.262',
    '2025-05-22 07:08:48.262'
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
    '110e9fee-8be0-46fa-939e-d629f7f64c3f',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-23 14:11:43.419',
    '2025-05-23 14:11:43.419'
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
    '125b08d2-c2c8-4f7d-abb8-2cc1c3cbc048',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-21 06:51:23.381',
    '2025-05-21 06:51:23.381'
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
    '1262e669-bcbb-45d8-946a-a6f97bc9cfc2',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    3,
    '2025-05-24 09:50:21.715',
    '2025-05-24 09:50:21.715'
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
    '12c4ffc6-94cb-4836-8a9e-d6060ddc0e85',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-22 10:52:14.161',
    '2025-05-22 10:52:14.161'
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
    '13c06b4e-4557-44db-8f13-bf96f6cf711d',
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '48fd0274-df76-43d9-a212-58ff5add2d3b',
    1,
    '2025-05-23 09:21:01.471',
    '2025-05-23 09:21:01.471'
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
    '174878e7-1ba3-443e-802b-1eac71a2cfd4',
    'ee083b6b-2757-4393-8df2-91030d541766',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-24 07:18:13.660',
    '2025-05-24 07:18:13.660'
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
    '19a6e82b-b75a-466d-a3c1-8d68dfad2cb5',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-23 14:22:18.559',
    '2025-05-23 14:22:18.559'
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
    '19ba69ca-fc43-4514-a5f8-69fb684071b7',
    '72fe124d-8b70-4bf3-9fc4-5510f62f1d17',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    4,
    '2025-05-23 07:13:08.688',
    '2025-05-23 07:13:08.688'
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
    '19f09fbe-eed9-43e5-b1e6-a6a9d15c720c',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-21 07:17:36.244',
    '2025-05-21 07:17:36.244'
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
    '1a23f2db-0998-4fd6-a257-803d632a49cc',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-21 06:30:07.527',
    '2025-05-21 06:30:07.527'
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
    '1a35308d-d7f9-432c-a5b7-1805b7924553',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-21 06:30:07.519',
    '2025-05-21 06:30:07.519'
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
    '1afe2142-7f56-43df-92a3-3da002a9fa60',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-22 13:53:00.322',
    '2025-05-22 13:53:00.322'
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
    '1cc69804-1010-4fee-8c0a-a4e6d88bbb06',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    1,
    '2025-05-20 07:52:52.893',
    '2025-05-20 07:52:52.893'
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
    '1d920d68-414c-406f-9261-3bbc63018163',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-23 14:11:43.374',
    '2025-05-23 14:11:43.374'
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
    '1e7e3175-fc6e-4947-9edd-a6ef40869402',
    '6d4fe050-59d7-421b-b4e8-20e8971402f8',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 05:16:02.470',
    '2025-05-22 05:16:02.470'
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
    '1ea2e140-2465-4877-88f0-86723c8f3302',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-23 07:31:56.711',
    '2025-05-23 07:31:56.711'
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
    '1faee788-0c4f-4118-8327-8a4984f5a621',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-22 11:39:02.999',
    '2025-05-22 11:39:02.999'
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
    '20d5fc2b-82f8-4b42-88a6-e58fb1eadb31',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 05:57:17.680',
    '2025-05-22 05:57:17.680'
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
    '2101f141-1238-4a5f-9165-72fea9783f40',
    '3aadc7c3-408f-4751-9e61-3da1d5224ff6',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-24 09:39:22.626',
    '2025-05-24 09:39:22.626'
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
    '21398cb3-b196-4f1e-96a5-9d88f201f500',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-22 13:42:17.440',
    '2025-05-22 13:42:17.440'
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
    '2395be09-d351-4e5c-be05-e1f2c4fba922',
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-23 09:21:01.501',
    '2025-05-23 09:21:01.501'
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
    '23bc503d-25c7-431b-b7e8-90b5597d813b',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    1,
    '2025-05-21 07:11:39.351',
    '2025-05-21 07:11:39.351'
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
    '24156c16-8f6b-4f15-8e4d-b984bb5d57dd',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-20 06:50:50.284',
    '2025-05-20 06:50:50.284'
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
    '24999e81-17a8-427e-a909-eb9fae7273c9',
    '75051264-8f10-41ea-a673-5330e2784174',
    '71532023-e03e-4dca-9a07-dd972b238203',
    2,
    '2025-05-22 06:29:13.174',
    '2025-05-22 06:29:13.174'
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
    '24fe6888-b329-476d-8614-bbca1be57d30',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    8,
    '2025-05-23 07:11:45.825',
    '2025-05-23 07:11:45.825'
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
    '25c02214-a20a-422a-b0f8-576a19e0d579',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-21 06:51:23.396',
    '2025-05-21 06:51:23.396'
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
    '266cf1aa-29b1-43d6-88e6-c2c04ce5153f',
    '9360582e-2af0-4901-868f-f7e14163955e',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-22 13:48:29.201',
    '2025-05-22 13:48:29.201'
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
    '2836e962-2768-4690-a96a-cc5e6c23c69c',
    '5bb9832b-54d7-4ffa-ad2b-8dc1f5f187f2',
    '190c0657-2097-4e20-a004-8a67ae138648',
    3,
    '2025-05-23 10:06:47.270',
    '2025-05-23 10:06:47.270'
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
    '2a9249c6-2069-44f0-b489-a24f732253e1',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-22 05:35:41.258',
    '2025-05-22 05:35:41.258'
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
    '2a96a017-a1da-4da6-93ca-79430d4b5540',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    2,
    '2025-05-21 07:17:36.252',
    '2025-05-21 07:17:36.252'
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
    '2c566fbb-7bc6-49ff-ad04-b2b7c88b780b',
    '3aadc7c3-408f-4751-9e61-3da1d5224ff6',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-24 09:39:22.619',
    '2025-05-24 09:39:22.619'
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
    '2c7e3974-d707-4b05-a6c6-b4ca611fe7f2',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    1,
    '2025-05-23 09:16:37.485',
    '2025-05-23 09:16:37.485'
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
    '2cb9ee22-7318-4029-bb3b-7cd1f3554dda',
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-23 08:21:48.756',
    '2025-05-23 08:21:48.756'
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
    '2cc6a3eb-2dee-4e58-9176-fc402cf3856d',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    1,
    '2025-05-23 09:06:57.627',
    '2025-05-23 09:06:57.627'
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
    '2d41ea4d-b96a-4377-a84e-425ccfb43f43',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-23 09:19:03.537',
    '2025-05-23 09:19:03.537'
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
    '2d8f64db-f690-4b49-a28a-f613d11a2239',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 13:53:00.267',
    '2025-05-22 13:53:00.267'
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
    '2e58a7e0-f58c-43db-beb6-1116c4c21f1d',
    'ee083b6b-2757-4393-8df2-91030d541766',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-24 07:18:13.676',
    '2025-05-24 07:18:13.676'
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
    '2e8c7725-c042-44cf-a149-41f0304a0828',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-21 07:11:39.329',
    '2025-05-21 07:11:39.329'
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
    '2e9a12e2-d5a1-4572-b6ca-198e25bf5d2f',
    'b1b8df21-05ef-4d84-8774-ca0a67833189',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    1,
    '2025-05-22 10:56:28.976',
    '2025-05-22 10:56:28.976'
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
    '2f6beaad-5f13-4051-9b3c-1766f2be3076',
    '06e507de-390c-454c-9b20-6694a2502dec',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-22 13:18:00.187',
    '2025-05-22 13:18:00.187'
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
    '2fc1e3f6-e4b9-46b9-9757-0d7803ae2bd5',
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-24 08:10:24.873',
    '2025-05-24 08:10:24.873'
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
    '309c47c4-ab4a-4103-ae8d-01e29ac6f37b',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    3,
    '2025-05-20 06:50:50.261',
    '2025-05-20 06:50:50.261'
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
    '30ec4f4b-f3d7-487f-85e9-6009a137905c',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-23 09:19:03.559',
    '2025-05-23 09:19:03.559'
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
    '3179bae6-61f1-46e4-831b-341b4eb44f38',
    'b3600480-c53f-44db-b40f-8f7f8cd00642',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-24 07:25:31.566',
    '2025-05-24 07:25:31.566'
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
    '327fffd5-54fc-4058-bcac-d56ea69262e7',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-20 07:52:52.937',
    '2025-05-20 07:52:52.937'
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
    '32c148f6-8be8-4835-942a-284f800c5326',
    '0763b76c-1c1b-4f17-890f-6daa14ac5640',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-23 08:04:16.004',
    '2025-05-23 08:04:16.004'
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
    '33aabd34-eb9d-43cf-86db-a1f73acba8f0',
    '4e734b6f-a13d-4235-a745-5d5fff720e88',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-22 05:33:34.745',
    '2025-05-22 05:33:34.745'
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
    '3401e491-faab-463f-bc9b-57b6a1a2fccc',
    '50a04ac2-9193-4e78-865c-9a0e74bdee4f',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    3,
    '2025-05-22 05:38:23.281',
    '2025-05-22 05:38:23.281'
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
    '34e43cdf-830d-481f-813e-22d4c04724ca',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-20 05:49:38.491',
    '2025-05-20 05:49:38.491'
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
    '34fc8062-54f5-419a-9858-4215dda9cc91',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    3,
    '2025-05-23 14:22:18.543',
    '2025-05-23 14:22:18.543'
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
    '35328104-6d0f-498d-b25b-90fadb2bc1b6',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-22 11:39:03.006',
    '2025-05-22 11:39:03.006'
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
    '359bf550-2f91-4f92-ae55-f1e39b880167',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-22 05:57:17.750',
    '2025-05-22 05:57:17.750'
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
    '35aff93b-4fa8-408e-9b44-d6b5c61edeaa',
    'ad82a598-d22b-46e1-b262-ba1e140b2a1a',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    9,
    '2025-05-20 06:03:39.032',
    '2025-05-20 06:03:39.032'
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
    '39d243e3-fef8-4433-99c0-c6551c2aaae3',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 09:26:05.833',
    '2025-05-23 09:26:05.833'
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
    '39f387d0-cd01-4e0a-af9a-96594ab9ee08',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    1,
    '2025-05-20 07:52:52.868',
    '2025-05-20 07:52:52.868'
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
    '3a84b5fe-b879-4626-8c53-9b25119a458f',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '71532023-e03e-4dca-9a07-dd972b238203',
    9,
    '2025-05-24 07:38:10.505',
    '2025-05-24 07:38:10.505'
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
    '3ac0ef31-8b81-4174-91b3-fba90ff805d2',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-23 09:16:37.493',
    '2025-05-23 09:16:37.493'
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
    '3b00aeea-551b-45be-b8b1-baa49e524c48',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-21 07:11:39.305',
    '2025-05-21 07:11:39.305'
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
    '3b043714-97ad-403b-b057-02416042405c',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-22 10:52:14.168',
    '2025-05-22 10:52:14.168'
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
    '3b7801b8-a713-4138-9cef-5e8fc89b4a25',
    '3f906102-b5ba-4645-b0bb-35ad7ebda5a5',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 14:07:29.080',
    '2025-05-22 14:07:29.080'
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
    '3c9beead-423c-4c6f-bd3c-758e3718eaca',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-20 07:52:52.885',
    '2025-05-20 07:52:52.885'
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
    '3df1c5ea-9b1f-45fd-b868-9f675faef4e2',
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-23 09:21:01.487',
    '2025-05-23 09:21:01.487'
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
    '3e55de5d-c29b-4ba3-af61-4d0e42c64e75',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-23 07:31:56.733',
    '2025-05-23 07:31:56.733'
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
    '3e67843e-d28e-4bc7-810a-1ab8b2011268',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    1,
    '2025-05-23 09:26:05.826',
    '2025-05-23 09:26:05.826'
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
    '3e91a636-0b70-48a8-b2ed-2c033b254d66',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-23 09:06:57.655',
    '2025-05-23 09:06:57.655'
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
    '402d0e3d-8c14-453a-ab7a-941512c9c416',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    3,
    '2025-05-24 07:38:10.444',
    '2025-05-24 07:38:10.444'
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
    '403b4c3c-3755-4863-8b1e-b179e57d7559',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '190c0657-2097-4e20-a004-8a67ae138648',
    3,
    '2025-05-20 05:49:38.525',
    '2025-05-20 05:49:38.525'
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
    '40498d56-211a-44a0-aea1-ccf0f6a662cb',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-23 09:06:57.634',
    '2025-05-23 09:06:57.634'
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
    '4136609a-2314-4966-831f-b1d37ffd5f4f',
    '31968987-8060-434e-8c46-e83d6023b9a5',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-21 15:12:56.902',
    '2025-05-21 15:12:56.902'
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
    '41a53866-18f5-48f1-a8a3-16b3c2eef545',
    '06e507de-390c-454c-9b20-6694a2502dec',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    1,
    '2025-05-22 13:18:00.194',
    '2025-05-22 13:18:00.194'
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
    '424ce066-c54c-48fd-ad7e-cacd903a18e0',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    16,
    '2025-05-23 07:11:45.833',
    '2025-05-23 07:11:45.833'
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
    '42ceafa2-2764-48f3-8f9a-7ddeac005e6f',
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-22 13:39:06.158',
    '2025-05-22 13:39:06.158'
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
    '4336406c-dae6-4fa8-89c5-a0e57f0cc96b',
    '72ccf99e-e7a1-4cf1-ad9f-5a256157a5fa',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-23 09:13:32.767',
    '2025-05-23 09:13:32.767'
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
    '4343b363-572a-4e4f-a602-2b650ebe8c73',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    2,
    '2025-05-21 07:11:39.358',
    '2025-05-21 07:11:39.358'
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
    '43897786-a8df-431a-95d8-ef068f6a4669',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    4,
    '2025-05-20 06:50:50.291',
    '2025-05-20 06:50:50.291'
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
    '43e03d15-cc84-41a7-9600-ea8e3cda5388',
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 13:39:06.212',
    '2025-05-22 13:39:06.212'
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
    '44756050-dc97-4ffd-8043-6781d07947ea',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    '98ccd5f2-4855-4508-b6af-a9b18db941de',
    1,
    '2025-05-23 09:06:57.605',
    '2025-05-23 09:06:57.605'
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
    '44782a4a-0fc5-4113-b599-bd5eb67bf820',
    '26255448-6a9a-4003-b096-66365a69b810',
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    1,
    '2025-05-23 07:36:20.065',
    '2025-05-23 07:36:20.065'
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
    '447d164c-a420-41c4-bd94-82ab01247b71',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '891012ff-2b63-4834-92c2-be50cae6b070',
    1,
    '2025-05-22 05:35:41.273',
    '2025-05-22 05:35:41.273'
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
    '44e426f6-eb82-4506-bcf6-377e0d2acc87',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    1,
    '2025-05-23 09:16:37.457',
    '2025-05-23 09:16:37.457'
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
    '459c94aa-003b-452d-9ed9-84dba12f6a79',
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-24 07:07:50.775',
    '2025-05-24 07:07:50.775'
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
    '468401fe-4e58-456f-93e0-d9186f1a0266',
    '0763b76c-1c1b-4f17-890f-6daa14ac5640',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-23 08:04:16.019',
    '2025-05-23 08:04:16.019'
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
    '468c0f59-4b71-4df5-9c94-a73be8747560',
    'dfe5219a-52c2-49fb-8a28-03df5d641539',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    1,
    '2025-05-23 08:54:55.274',
    '2025-05-23 08:54:55.274'
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
    '4721cd11-082f-4f3d-b658-84edd824e50f',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-23 09:26:05.842',
    '2025-05-23 09:26:05.842'
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
    '47f99339-e301-4986-a1a0-55e87e4d52f5',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-20 05:49:38.512',
    '2025-05-20 05:49:38.512'
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
    '47fd96c0-c2a9-4e04-ac10-f82bafa4771f',
    '3aadc7c3-408f-4751-9e61-3da1d5224ff6',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-24 09:39:22.611',
    '2025-05-24 09:39:22.611'
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
    '49217022-24d1-4607-9c44-c9a3770264d2',
    '6cb50640-f979-4b75-be02-999a9651ad44',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-23 09:10:19.445',
    '2025-05-23 09:10:19.445'
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
    '4a48f361-7929-41fe-9ffb-fa2c741937ce',
    '3f906102-b5ba-4645-b0bb-35ad7ebda5a5',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-22 14:07:29.071',
    '2025-05-22 14:07:29.071'
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
    '4b352ea5-dc0f-4ee3-9112-4b03c96e7f2d',
    '340c66a7-a516-4bbd-81f0-bdfe35339b7b',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-20 09:28:19.904',
    '2025-05-20 09:28:19.904'
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
    '4b9b8c54-beec-420f-ad3d-7e399acab073',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    2,
    '2025-05-21 07:14:48.987',
    '2025-05-21 07:14:48.987'
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
    '4bce4541-d741-40de-baf8-3efb87f8a572',
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-23 08:21:48.763',
    '2025-05-23 08:21:48.763'
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
    '4c9586b8-d6c1-4b90-a2dd-468cb38f0781',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    2,
    '2025-05-24 07:38:10.489',
    '2025-05-24 07:38:10.489'
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
    '4cca1be1-3aa1-48dc-878e-de926caf43c0',
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    1,
    '2025-05-22 09:50:48.323',
    '2025-05-22 09:50:48.323'
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
    '4cd4ad33-0c1f-4fb4-a98e-44e94318c3b6',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    2,
    '2025-05-22 11:34:32.265',
    '2025-05-22 11:34:32.265'
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
    '4d700671-a8ef-4276-b47e-e1983dbbee2b',
    '3f906102-b5ba-4645-b0bb-35ad7ebda5a5',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-22 14:07:29.094',
    '2025-05-22 14:07:29.094'
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
    '4dd2dc4f-f937-4463-a7d4-fbeee12d0639',
    '75051264-8f10-41ea-a673-5330e2784174',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    3,
    '2025-05-22 06:29:13.149',
    '2025-05-22 06:29:13.149'
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
    '4e088b19-3f38-4b0d-ac8a-6f39b573f7d7',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-22 11:34:32.295',
    '2025-05-22 11:34:32.295'
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
    '4fab553e-e919-4382-bbeb-6e441fcdb2b5',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    3,
    '2025-05-23 09:26:05.790',
    '2025-05-23 09:26:05.790'
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
    '50162963-91af-4e40-9f1e-c7c593d87a6a',
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    '190c0657-2097-4e20-a004-8a67ae138648',
    4,
    '2025-05-24 06:59:24.355',
    '2025-05-24 06:59:24.355'
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
    '504144de-9647-49b6-ac27-c708869cd168',
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    2,
    '2025-05-23 07:04:46.358',
    '2025-05-23 07:04:46.358'
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
    '507a63b7-2231-42e9-89c0-9058e9a6a9b4',
    '8f8f6d73-1408-45bc-9a7b-c0b5be333bb6',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    1,
    '2025-05-21 06:33:00.009',
    '2025-05-21 06:33:00.009'
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
    '50c25485-fddb-42c6-b713-f3f9ebdaea19',
    '4e734b6f-a13d-4235-a745-5d5fff720e88',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 05:33:34.754',
    '2025-05-22 05:33:34.754'
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
    '50dd7ae1-5dc8-45e3-9f0f-732e2ab5e8a8',
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-23 07:04:46.342',
    '2025-05-23 07:04:46.342'
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
    '50ecc039-37b0-4dfb-aa33-854d53474f1d',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-22 13:53:00.259',
    '2025-05-22 13:53:00.259'
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
    '5158d1f1-053d-43f8-9dfc-35af32a0fa42',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    3,
    '2025-05-23 09:06:57.612',
    '2025-05-23 09:06:57.612'
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
    '5184dbaa-a692-491b-84df-0433047e881d',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    3,
    '2025-05-22 11:34:32.287',
    '2025-05-22 11:34:32.287'
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
    '529661ff-c1c5-40b4-a1cd-fc467f23ba0e',
    '33fd3a2c-7181-45c6-90bc-53ae87ae0458',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 04:58:30.206',
    '2025-05-22 04:58:30.206'
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
    '54bcbf5e-1999-45f8-967e-58fc1b60b9df',
    'a1624f57-125a-4b33-9fe5-9ecf27424a99',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-22 06:44:01.534',
    '2025-05-22 06:44:01.534'
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
    '56c3214a-c596-4d5b-9a5e-9080c2fb85a7',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    16,
    '2025-05-23 07:11:45.811',
    '2025-05-23 07:11:45.811'
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
    '57d0755e-58e7-4f85-b4da-7be507c222cd',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-23 09:19:03.487',
    '2025-05-23 09:19:03.487'
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
    '582674be-d285-4793-822a-97ba238fef6e',
    '4539a5f1-b2b5-4744-b70a-b68abcee2bee',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    1,
    '2025-05-23 09:12:28.832',
    '2025-05-23 09:12:28.832'
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
    '58d681e3-c143-441e-9494-d27504e17c14',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    2,
    '2025-05-22 11:34:32.273',
    '2025-05-22 11:34:32.273'
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
    '597dd52b-f9af-4864-9080-22e955dacb68',
    '3f906102-b5ba-4645-b0bb-35ad7ebda5a5',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-22 14:07:29.087',
    '2025-05-22 14:07:29.087'
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
    '59a6595f-271b-4e06-a8dc-1d8ea4d1c10e',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    8,
    '2025-05-23 07:11:45.818',
    '2025-05-23 07:11:45.818'
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
    '59d7efaa-33cf-48eb-a56f-c790278513d2',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    '190c0657-2097-4e20-a004-8a67ae138648',
    3,
    '2025-05-22 13:44:33.254',
    '2025-05-22 13:44:33.254'
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
    '5a008ca7-b75f-4d4d-9a41-49e6fb6c0046',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-21 07:17:36.237',
    '2025-05-21 07:17:36.237'
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
    '5a1cf236-036f-43b8-b706-d58513906fdd',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    5,
    '2025-05-23 14:22:18.588',
    '2025-05-23 14:22:18.588'
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
    '5a85868a-8db0-473d-9635-4f41e376fbed',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    4,
    '2025-05-21 07:11:39.343',
    '2025-05-21 07:11:39.343'
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
    '5abdd17a-a984-44f3-95b6-44e98b73cbc3',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-21 06:48:16.520',
    '2025-05-21 06:48:16.520'
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
    '5ada4475-53ea-47b1-adc5-b1847741877a',
    '4539a5f1-b2b5-4744-b70a-b68abcee2bee',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-23 09:12:28.846',
    '2025-05-23 09:12:28.846'
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
    '5adb45cd-1943-4132-9273-90f732135fe4',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-21 07:14:48.949',
    '2025-05-21 07:14:48.949'
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
    '5e81957f-d87f-4eef-8197-577a21b631ab',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    3,
    '2025-05-20 07:52:52.900',
    '2025-05-20 07:52:52.900'
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
    '5e901a01-86f1-47cd-8f1b-e6e18f745caa',
    '5bb9832b-54d7-4ffa-ad2b-8dc1f5f187f2',
    '9183f0ac-2d61-416c-a7bd-6ea5f5221b9a',
    2,
    '2025-05-23 10:06:47.263',
    '2025-05-23 10:06:47.263'
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
    '60855eea-31af-4b42-8b7b-6e5d42dfcbee',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-22 13:44:33.233',
    '2025-05-22 13:44:33.233'
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
    '610d0ece-fb88-4856-8a10-7819c72233d0',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-20 06:50:50.269',
    '2025-05-20 06:50:50.269'
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
    '61840ba7-2381-486b-8966-771774c274f6',
    'b3600480-c53f-44db-b40f-8f7f8cd00642',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    1,
    '2025-05-24 07:25:31.574',
    '2025-05-24 07:25:31.574'
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
    '629aad53-afc8-4aca-b1d8-6c22e8ac4437',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    1,
    '2025-05-24 07:38:10.531',
    '2025-05-24 07:38:10.531'
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
    '62a061c6-f7b4-4e7f-b61e-1280ed43f7ff',
    '6cb50640-f979-4b75-be02-999a9651ad44',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 09:10:19.453',
    '2025-05-23 09:10:19.453'
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
    '6302d007-8bde-4cd5-836c-73d1f63d275c',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-22 10:52:14.146',
    '2025-05-22 10:52:14.146'
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
    '6389fdf7-cc46-4097-9915-90c6de6ce122',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '190c0657-2097-4e20-a004-8a67ae138648',
    3,
    '2025-05-22 10:52:14.176',
    '2025-05-22 10:52:14.176'
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
    '64ba85f9-7194-4859-a4b7-e5a200aa1642',
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-23 09:21:01.494',
    '2025-05-23 09:21:01.494'
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
    '6752478a-be07-4014-8782-f04f73b80fa1',
    '72ccf99e-e7a1-4cf1-ad9f-5a256157a5fa',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-23 09:13:32.759',
    '2025-05-23 09:13:32.759'
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
    '67966867-e158-4071-b471-18eddf5d5707',
    'f46dea06-99af-4afb-9bf5-d0582e3fe269',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-22 07:47:16.961',
    '2025-05-22 07:47:16.961'
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
    '67ba5b09-ea8a-476f-9172-cf1afa88abc3',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    4,
    '2025-05-23 07:11:45.741',
    '2025-05-23 07:11:45.741'
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
    '68a8094a-dbc7-42ae-8065-041b1cb2f2e1',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-21 07:17:36.200',
    '2025-05-21 07:17:36.200'
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
    '68fdda08-2c71-463e-b888-2e5ce8a133d0',
    '0763b76c-1c1b-4f17-890f-6daa14ac5640',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-23 08:04:16.026',
    '2025-05-23 08:04:16.026'
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
    '6a420835-abb4-4714-8de1-dbcff7ba88b9',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    '9bc4bceb-2fc7-4107-82bd-72ced4b1242f',
    1,
    '2025-05-21 06:48:16.495',
    '2025-05-21 06:48:16.495'
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
    '6a8a0402-dd6c-4f91-ba0e-1cafa58f9687',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-23 14:11:43.411',
    '2025-05-23 14:11:43.411'
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
    '6b4ac2e1-e95d-4260-b467-3c50b81a42a2',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    1,
    '2025-05-24 09:50:21.708',
    '2025-05-24 09:50:21.708'
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
    '6c42ca92-83fd-4814-84d6-74311bce11fe',
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-22 09:50:48.330',
    '2025-05-22 09:50:48.330'
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
    '6d7bff9c-4501-4261-9cd8-cd61c986ea90',
    '6cb50640-f979-4b75-be02-999a9651ad44',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-23 09:10:19.439',
    '2025-05-23 09:10:19.439'
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
    '6e54a4b5-edde-494b-bafc-d505e28bd98b',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-20 05:49:38.504',
    '2025-05-20 05:49:38.504'
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
    '6e69e27c-db18-4b72-83cf-4a34c8c021db',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    5,
    '2025-05-23 07:11:45.803',
    '2025-05-23 07:11:45.803'
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
    '6e7a9d68-59a3-46a6-8450-651e48707527',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-20 05:49:38.533',
    '2025-05-20 05:49:38.533'
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
    '6ec721e8-2330-48b6-a8b1-88481a113a0b',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-24 07:38:10.512',
    '2025-05-24 07:38:10.512'
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
    '71164184-8ba6-4757-832b-35aac6427c33',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    2,
    '2025-05-20 05:49:38.498',
    '2025-05-20 05:49:38.498'
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
    '711a195b-7861-48af-bbff-49ff839165b1',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 09:16:37.499',
    '2025-05-23 09:16:37.499'
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
    '7162154f-01b9-4c2e-80fa-3c419275ab57',
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    3,
    '2025-05-24 06:59:24.365',
    '2025-05-24 06:59:24.365'
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
    '724152ec-76ac-4baf-acc9-6addfb7d9fc8',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    1,
    '2025-05-23 09:16:37.478',
    '2025-05-23 09:16:37.478'
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
    '7286e6f0-66fd-42dc-846e-38cf41cbfd00',
    '3aadc7c3-408f-4751-9e61-3da1d5224ff6',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-24 09:39:22.635',
    '2025-05-24 09:39:22.635'
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
    '72aa32a5-c7df-41d9-9d2b-0764157b02d2',
    '6cb50640-f979-4b75-be02-999a9651ad44',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    1,
    '2025-05-23 09:10:19.424',
    '2025-05-23 09:10:19.424'
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
    '754125a7-f11e-44f1-8da1-1cfedfb570dc',
    '9360582e-2af0-4901-868f-f7e14163955e',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    2,
    '2025-05-22 13:48:29.168',
    '2025-05-22 13:48:29.168'
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
    '772a7669-1f44-4736-afa8-5719611bb602',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    1,
    '2025-05-20 05:49:38.484',
    '2025-05-20 05:49:38.484'
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
    '7806f7dd-37f2-4c6f-a0b1-c501bbe4c9c0',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    2,
    '2025-05-20 05:49:38.540',
    '2025-05-20 05:49:38.540'
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
    '7818cdbd-497c-4f18-8449-a1884842b02e',
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-21 06:51:23.372',
    '2025-05-21 06:51:23.372'
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
    '7913edc5-9072-48f6-ba6d-4a2cdf0ab3b2',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-22 11:39:02.991',
    '2025-05-22 11:39:02.991'
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
    '794ae9fb-ceb5-431b-9e75-8c90494858ca',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-24 09:50:21.723',
    '2025-05-24 09:50:21.723'
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
    '79fb389b-8f17-45ab-aab8-edd6482ec875',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-24 09:50:21.746',
    '2025-05-24 09:50:21.746'
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
    '7a72a092-3087-4d77-bd85-54f1e929762d',
    '8f9615c0-a456-40ee-bedb-bc2d2b0478ff',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-23 09:23:06.287',
    '2025-05-23 09:23:06.287'
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
    '7ac861b5-7e1c-4d28-901e-5ba08d044368',
    'ee083b6b-2757-4393-8df2-91030d541766',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-24 07:18:13.669',
    '2025-05-24 07:18:13.669'
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
    '7c738535-14e6-42a4-bd07-4df04a0dac04',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    1,
    '2025-05-24 07:38:10.481',
    '2025-05-24 07:38:10.481'
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
    '7f800702-de19-472d-ade6-a08c6d9e1ca3',
    '5fb0b2df-83d4-415f-9073-321153e18f4b',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-24 05:40:28.176',
    '2025-05-24 05:40:28.176'
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
    '84abcfb5-8334-4d47-b28a-84bfffbc944f',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-20 07:52:52.929',
    '2025-05-20 07:52:52.929'
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
    '8504f99f-e858-4576-8a0a-dea4f847eb57',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-23 07:31:56.702',
    '2025-05-23 07:31:56.702'
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
    '855268f5-a0f7-43e3-9202-616a08d2c822',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-22 13:44:33.247',
    '2025-05-22 13:44:33.247'
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
    '85a3061d-f28a-4f2f-a696-304a2fa4ca8a',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-20 07:52:52.908',
    '2025-05-20 07:52:52.908'
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
    '85d819be-1aa9-42a7-bfbb-a7ae1085cc64',
    'dfe5219a-52c2-49fb-8a28-03df5d641539',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-23 08:54:55.267',
    '2025-05-23 08:54:55.267'
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
    '869b5298-f87f-4499-8dcc-ef05161ae34c',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 13:42:17.473',
    '2025-05-22 13:42:17.473'
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
    '86ec362b-efb5-4133-85a9-35b07effbadb',
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    1,
    '2025-05-24 07:07:50.767',
    '2025-05-24 07:07:50.767'
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
    '8783b6e1-6519-4c71-ae27-afad6f10b469',
    'c4d3201e-60aa-4464-b781-abf1e55413ed',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-20 09:11:58.026',
    '2025-05-20 09:11:58.026'
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
    '878b9df7-bb56-483b-97b8-8e99bed1fdd0',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    1,
    '2025-05-21 07:14:48.957',
    '2025-05-21 07:14:48.957'
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
    '87db0c0d-f696-4fcf-aaff-8e5efacb6fb5',
    'f46dea06-99af-4afb-9bf5-d0582e3fe269',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    1,
    '2025-05-22 07:47:16.953',
    '2025-05-22 07:47:16.953'
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
    '88629504-35d3-4558-979a-2058ae566e1e',
    '06e507de-390c-454c-9b20-6694a2502dec',
    '71532023-e03e-4dca-9a07-dd972b238203',
    2,
    '2025-05-22 13:18:00.179',
    '2025-05-22 13:18:00.179'
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
    '88fc89bf-07ab-471a-be35-d96aa163d576',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    1,
    '2025-05-20 05:49:38.548',
    '2025-05-20 05:49:38.548'
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
    '893d4514-d2c6-4455-b853-ff27c6b7a469',
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    1,
    '2025-05-24 07:07:50.790',
    '2025-05-24 07:07:50.790'
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
    '8986158e-49e4-469d-be16-c00fa1b55160',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-22 13:42:17.465',
    '2025-05-22 13:42:17.465'
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
    '89878734-b4af-4998-8692-8f0b9e473473',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-21 07:11:39.276',
    '2025-05-21 07:11:39.276'
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
    '899a4ac9-1576-4838-ada9-26a54e49b723',
    'ff27776f-32cc-4b51-9766-e6a1c6485316',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 09:59:34.611',
    '2025-05-23 09:59:34.611'
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
    '8a9260f3-a87d-4014-8c57-17117d719900',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-23 09:26:05.798',
    '2025-05-23 09:26:05.798'
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
    '8aa91cab-203c-4f55-a8f1-dcc518a39050',
    '72fe124d-8b70-4bf3-9fc4-5510f62f1d17',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-23 07:13:08.680',
    '2025-05-23 07:13:08.680'
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
    '8ab053f4-59aa-4039-a9fa-f6db88b56295',
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-20 07:45:47.217',
    '2025-05-20 07:45:47.217'
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
    '8abffac9-9c01-4305-96ec-c7d4e3432bab',
    '8f9615c0-a456-40ee-bedb-bc2d2b0478ff',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-23 09:23:06.295',
    '2025-05-23 09:23:06.295'
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
    '8ae1f457-38f9-446c-840b-68048c6b12b8',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    4,
    '2025-05-21 07:11:39.321',
    '2025-05-21 07:11:39.321'
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
    '901eb9e8-5e23-4e25-ae03-daf23e897b87',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-22 13:45:49.584',
    '2025-05-22 13:45:49.584'
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
    '90574a06-1062-498b-8d7f-cb81f9ce0cb9',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-22 13:45:49.570',
    '2025-05-22 13:45:49.570'
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
    '908cfbd7-5d09-4362-abe1-d6f4fbb317ef',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    1,
    '2025-05-21 07:11:39.313',
    '2025-05-21 07:11:39.313'
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
    '91553e70-98ea-4bc2-ad4d-137e95ac6a53',
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    1,
    '2025-05-22 09:50:48.315',
    '2025-05-22 09:50:48.315'
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
    '92bd511e-7f0f-4881-be34-0d3b2cf487f9',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-21 07:11:39.267',
    '2025-05-21 07:11:39.267'
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
    '92d712b1-2321-4d3f-bea1-4623effd243f',
    '1246a44c-6ae9-4038-a94d-0ebf9e6f64fb',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 05:19:07.404',
    '2025-05-22 05:19:07.404'
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
    '92e31cb4-5b09-44e9-8fa8-b0fb5c2aaa78',
    'c4ac97e5-0660-48cd-836c-b003d653c821',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-22 04:34:59.704',
    '2025-05-22 04:34:59.704'
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
    '93bf9613-38cd-477d-961a-d064f6e41d70',
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    '50962768-a856-4623-976f-696fe73615b4',
    1,
    '2025-05-24 08:10:24.850',
    '2025-05-24 08:10:24.850'
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
    '946f4590-0ecb-416c-ade3-fc00668c4d3a',
    '9360582e-2af0-4901-868f-f7e14163955e',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-22 13:48:29.177',
    '2025-05-22 13:48:29.177'
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
    '95c5a749-e668-4997-b65b-d27cb02a7dbe',
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-23 07:06:30.671',
    '2025-05-23 07:06:30.671'
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
    '96eeed88-e85f-4fa6-9000-2b484acb829b',
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-22 09:50:48.307',
    '2025-05-22 09:50:48.307'
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
    '9808e754-b2a9-4b7d-882f-7ac1ded7ae1e',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-23 09:19:03.552',
    '2025-05-23 09:19:03.552'
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
    '98456e0b-d518-400e-b1d9-08fc16181d07',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    2,
    '2025-05-22 05:35:41.241',
    '2025-05-22 05:35:41.241'
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
    '9a298fbc-4e4a-4af1-9598-5b35f3146a3b',
    'a1624f57-125a-4b33-9fe5-9ecf27424a99',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-22 06:44:01.544',
    '2025-05-22 06:44:01.544'
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
    '9d01fdcf-4c9a-4630-9a2d-978acb3a0ae5',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    9,
    '2025-05-24 07:38:10.452',
    '2025-05-24 07:38:10.452'
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
    '9d94ace9-6662-4adb-bb9a-6f2ed0f9c9d1',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    1,
    '2025-05-22 10:02:53.841',
    '2025-05-22 10:02:53.841'
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
    '9ec35013-cdbb-4457-82d3-119adf45e55f',
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    2,
    '2025-05-23 07:04:46.321',
    '2025-05-23 07:04:46.321'
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
    'a054c2b0-8b38-4f20-80a5-f0f857053ed4',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-20 07:52:52.877',
    '2025-05-20 07:52:52.877'
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
    'a05d6319-71e8-4e47-97f2-749986498c24',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-20 07:52:52.922',
    '2025-05-20 07:52:52.922'
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
    'a0e8e9ed-ce21-47ca-8a40-4d330af8bc7d',
    '9360582e-2af0-4901-868f-f7e14163955e',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-22 13:48:29.185',
    '2025-05-22 13:48:29.185'
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
    'a23a8e0f-56dd-4cbc-9c13-4904cd54c5e8',
    '0763b76c-1c1b-4f17-890f-6daa14ac5640',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-23 08:04:16.012',
    '2025-05-23 08:04:16.012'
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
    'a464d61b-05cd-47be-9dc1-83e70f2ce46b',
    'f7a2f358-47f2-4594-b50b-32117351cda5',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-21 06:34:22.873',
    '2025-05-21 06:34:22.873'
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
    'a509c19a-f135-456d-ad02-167d5915503e',
    'b3600480-c53f-44db-b40f-8f7f8cd00642',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-24 07:25:31.558',
    '2025-05-24 07:25:31.558'
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
    'a6950d6a-46a8-4330-9157-594ce470ffda',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-22 10:02:53.864',
    '2025-05-22 10:02:53.864'
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
    'a799d55b-b97c-4b83-ab31-d1e736c615c3',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-21 06:30:07.558',
    '2025-05-21 06:30:07.558'
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
    'a81f8de6-9203-4eca-b5b6-2b3fffaa885f',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-22 10:02:53.849',
    '2025-05-22 10:02:53.849'
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
    'a860f316-99ef-4f46-a21c-136fba96a72c',
    '0462450a-e9c4-4133-8343-1206957be990',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    3,
    '2025-05-22 05:37:38.327',
    '2025-05-22 05:37:38.327'
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
    'a8c4f566-7e47-4c47-9d07-0c5cedf9eb41',
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-23 07:04:46.335',
    '2025-05-23 07:04:46.335'
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
    'a8dea704-8f1d-4f60-b6e9-6a761159ae65',
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-23 09:21:01.479',
    '2025-05-23 09:21:01.479'
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
    'a8e1c55a-6bd3-4987-bee6-aa8f910cdc29',
    '0462450a-e9c4-4133-8343-1206957be990',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 05:37:38.335',
    '2025-05-22 05:37:38.335'
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
    'a905dc5e-4f93-460a-89a3-4f51ca5b8853',
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    3,
    '2025-05-22 13:39:06.166',
    '2025-05-22 13:39:06.166'
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
    'aa10f38e-0259-4876-8c3e-efdd3de18816',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    '190c0657-2097-4e20-a004-8a67ae138648',
    4,
    '2025-05-22 05:57:17.723',
    '2025-05-22 05:57:17.723'
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
    'add9e2f5-9efe-47cc-b6ae-8e8c8d7951ad',
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-20 07:52:52.915',
    '2025-05-20 07:52:52.915'
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
    'af387988-90ae-4176-9492-14e06d46e9e9',
    '9360582e-2af0-4901-868f-f7e14163955e',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-22 13:48:29.193',
    '2025-05-22 13:48:29.193'
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
    'af51490d-352a-483a-b46e-a63a1aa570ed',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 05:57:17.716',
    '2025-05-22 05:57:17.716'
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
    'afa1eacd-89f7-4274-9d78-f0171d2c7376',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-21 06:30:07.505',
    '2025-05-21 06:30:07.505'
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
    'afedf1f0-61a4-4463-bce4-d32f671d5f35',
    '1b6342ff-18e8-4b24-a1c9-302d9b57cf23',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 05:16:37.615',
    '2025-05-22 05:16:37.615'
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
    'b13be1e2-7b8e-4518-8556-2a4fdfffddee',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '92fd3e8b-68a0-42e4-a187-34f8d50f1894',
    1,
    '2025-05-24 09:50:21.700',
    '2025-05-24 09:50:21.700'
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
    'b1eabc09-7d03-4eba-95bf-f2e4402f6750',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-23 09:16:37.449',
    '2025-05-23 09:16:37.449'
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
    'b2ae0f40-7674-4e82-8996-3363218adc09',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-23 09:26:05.812',
    '2025-05-23 09:26:05.812'
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
    'b69c48eb-d92e-4703-a7fc-15dbfe07ced8',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-23 09:06:57.597',
    '2025-05-23 09:06:57.597'
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
    'b8b4e33c-1933-4366-bc01-c861b8a8f486',
    'b1b8df21-05ef-4d84-8774-ca0a67833189',
    'cab33588-90bd-4b6c-a240-e8c2243b399f',
    1,
    '2025-05-22 10:56:28.984',
    '2025-05-22 10:56:28.984'
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
    'b911f379-6713-4685-b4ca-b50fd81c1a47',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    1,
    '2025-05-23 09:06:57.641',
    '2025-05-23 09:06:57.641'
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
    'b912e384-fba4-4430-9841-f000a9eb50a7',
    '6cb50640-f979-4b75-be02-999a9651ad44',
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    1,
    '2025-05-23 09:10:19.432',
    '2025-05-23 09:10:19.432'
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
    'b96e91e8-f422-4fff-8614-a696afbcbcdf',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    1,
    '2025-05-22 13:45:49.561',
    '2025-05-22 13:45:49.561'
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
    'b99c0ddf-7711-40c0-9152-8aea5895cb0c',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-24 09:50:21.692',
    '2025-05-24 09:50:21.692'
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
    'babe2b52-32dc-48a8-a71e-73562bd3ff4e',
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-21 06:48:16.512',
    '2025-05-21 06:48:16.512'
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
    'bb66d46f-a934-41e2-98c9-7ef622909cf6',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-23 14:22:18.573',
    '2025-05-23 14:22:18.573'
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
    'bb9a3349-c2a5-4e60-972c-fcc3b1c2aa9c',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    5,
    '2025-05-23 07:11:45.778',
    '2025-05-23 07:11:45.778'
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
    'bc019635-4df7-4d8a-8a78-3b8701e36368',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-22 11:34:32.316',
    '2025-05-22 11:34:32.316'
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
    'bc1ed0a5-f9ee-4063-9e20-e68b48965ad1',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    2,
    '2025-05-22 11:39:03.035',
    '2025-05-22 11:39:03.035'
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
    'bd252e9e-2554-4569-ab0f-9f2453e2076d',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-24 09:50:21.738',
    '2025-05-24 09:50:21.738'
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
    'c122bc69-4906-47f3-a4d1-985c191952bc',
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-23 07:04:46.350',
    '2025-05-23 07:04:46.350'
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
    'c123dcbb-274c-4107-bb99-59913318d9aa',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-22 11:34:32.302',
    '2025-05-22 11:34:32.302'
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
    'c2564685-7470-4cc1-812b-d760ffff6d61',
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-20 05:49:38.518',
    '2025-05-20 05:49:38.518'
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
    'c2b9a50c-0013-438b-99a0-fc126db7b49a',
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-21 07:11:39.336',
    '2025-05-21 07:11:39.336'
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
    'c45478dd-2679-497a-92a5-d0c8ee89bed4',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    '42925662-986e-4a32-bd52-c7ad03ecee83',
    2,
    '2025-05-21 06:30:07.551',
    '2025-05-21 06:30:07.551'
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
    'c5335997-288b-4a94-95d3-c4df45a5f704',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 11:39:03.028',
    '2025-05-22 11:39:03.028'
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
    'c57f1e7d-645d-4376-81ae-6b443e795720',
    '340c66a7-a516-4bbd-81f0-bdfe35339b7b',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-20 09:28:19.912',
    '2025-05-20 09:28:19.912'
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
    'c638c61e-f17f-47d6-96fc-21f8f81144f6',
    'b3600480-c53f-44db-b40f-8f7f8cd00642',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-24 07:25:31.550',
    '2025-05-24 07:25:31.550'
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
    'c68ca81a-a81a-4bed-8780-7d754f7b1e8f',
    '50a04ac2-9193-4e78-865c-9a0e74bdee4f',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-22 05:38:23.297',
    '2025-05-22 05:38:23.297'
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
    'c6919d71-5884-4bac-879d-af7d6d3c194e',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-22 13:42:17.433',
    '2025-05-22 13:42:17.433'
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
    'c82e89e8-022e-4435-93a8-84715a4dcf25',
    'b834497d-5376-4ce8-9f00-9138159651d4',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    8,
    '2025-05-20 05:40:53.893',
    '2025-05-20 05:40:53.893'
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
    'c8316a61-516b-4c15-bd4d-6f87dc2ba470',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    '1b10bd7f-2657-407b-a5b5-8eff96e000a0',
    1,
    '2025-05-20 06:50:50.277',
    '2025-05-20 06:50:50.277'
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
    'c951c573-e1c2-4b79-808b-e71fd44f859e',
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-21 07:17:36.229',
    '2025-05-21 07:17:36.229'
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
    'c97ff666-20a2-4db9-bb2c-275e878bd5e0',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-22 13:45:49.577',
    '2025-05-22 13:45:49.577'
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
    'c9b09dd1-90b7-4d02-b8b5-179de32d0c58',
    'a2821a8d-a94e-4ee5-b130-b2da2e060afe',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    2,
    '2025-05-23 10:08:38.340',
    '2025-05-23 10:08:38.340'
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
    'ca54a56e-5b02-441d-b07d-15885fa9b6c4',
    '4539a5f1-b2b5-4744-b70a-b68abcee2bee',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-23 09:12:28.824',
    '2025-05-23 09:12:28.824'
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
    'caf920c9-37c4-4c1b-a4c7-0449902509b4',
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 05:35:41.251',
    '2025-05-22 05:35:41.251'
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
    'cafc6c29-3fb5-41e9-8a79-70568a914332',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 07:08:48.270',
    '2025-05-22 07:08:48.270'
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
    'cc636c8d-caf6-4e75-ad46-d3f2db7742e3',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    '6e876c14-b07d-4288-a5a0-946bf44982a3',
    1,
    '2025-05-23 07:31:56.725',
    '2025-05-23 07:31:56.725'
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
    'cce08c5f-0536-4f1e-bd6d-fee3d6ca3fe2',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '7cd0cc04-4800-4b46-b5ab-8f2fe2c08076',
    1,
    '2025-05-22 10:52:14.153',
    '2025-05-22 10:52:14.153'
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
    'cdf84e78-c067-4a4e-b149-d898ccd6fa09',
    'f46dea06-99af-4afb-9bf5-d0582e3fe269',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 07:47:16.968',
    '2025-05-22 07:47:16.968'
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
    'ce6929c9-059a-4fed-9298-e1ee69c621ea',
    'a1624f57-125a-4b33-9fe5-9ecf27424a99',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-22 06:44:01.553',
    '2025-05-22 06:44:01.553'
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
    'ce6bb700-4d19-4527-86e5-1f374655369e',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    1,
    '2025-05-23 14:22:18.552',
    '2025-05-23 14:22:18.552'
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
    'ceb125b4-61a0-4bb3-ae43-f6533cc4e05a',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    1,
    '2025-05-22 13:44:33.225',
    '2025-05-22 13:44:33.225'
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
    'd2b279da-fc35-4186-aa3c-0bf62e2764a2',
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-23 09:16:37.471',
    '2025-05-23 09:16:37.471'
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
    'd38b92e0-1437-45db-8aea-e3f435ff7f8d',
    '06e507de-390c-454c-9b20-6694a2502dec',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    1,
    '2025-05-22 13:18:00.172',
    '2025-05-22 13:18:00.172'
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
    'd411c8d5-d24d-42c0-b20b-0f4609c89c46',
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-23 09:26:05.805',
    '2025-05-23 09:26:05.805'
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
    'd453aa98-d669-4536-b49c-af4ada93c2ea',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-23 09:06:57.619',
    '2025-05-23 09:06:57.619'
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
    'd5aeb8ff-b5bc-4bc9-a4c4-440259123375',
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-22 05:57:17.687',
    '2025-05-22 05:57:17.687'
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
    'd5bbef48-32f8-46fb-b12e-aeb0da152041',
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 10:52:14.137',
    '2025-05-22 10:52:14.137'
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
    'd662da84-a9d8-4b8c-a2d5-56cd40008bf0',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    '50962768-a856-4623-976f-696fe73615b4',
    1,
    '2025-05-22 07:08:48.235',
    '2025-05-22 07:08:48.235'
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
    'd7870cf9-88da-48cf-8a49-fb3cd0b53eee',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-21 07:14:48.942',
    '2025-05-21 07:14:48.942'
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
    'd800b3a8-66dd-49c6-baff-d57c6b18a61e',
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-22 13:45:49.599',
    '2025-05-22 13:45:49.599'
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
    'd8c9e1fa-e567-462a-bf2e-f8ab1ebd6e88',
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    2,
    '2025-05-24 07:07:50.758',
    '2025-05-24 07:07:50.758'
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
    'd8d3a883-88bc-440f-b7e7-271f48c2c987',
    '553e5fb6-96c7-4375-a4cd-f4eadcbeba39',
    'c6b1cbdc-c50f-4c7f-b0b1-2d5d8220216b',
    1,
    '2025-05-22 04:59:16.458',
    '2025-05-22 04:59:16.458'
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
    'd97f79a9-707d-415d-b937-46cf0861e954',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 11:39:03.013',
    '2025-05-22 11:39:03.013'
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
    'da388f7c-fa8d-4a3a-a48f-4fd4cf6376b6',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    8,
    '2025-05-23 07:11:45.760',
    '2025-05-23 07:11:45.760'
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
    'daf90711-5e65-4dea-80b4-8a5dd79ab43c',
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-23 09:06:57.648',
    '2025-05-23 09:06:57.648'
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
    'dc8869e5-b223-49d6-808c-55b93d8fa8d2',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-22 07:08:48.278',
    '2025-05-22 07:08:48.278'
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
    'de70c7d4-23c4-4d03-ae8d-cdb200ec2553',
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-23 14:11:43.404',
    '2025-05-23 14:11:43.404'
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
    'dea4dd21-4d44-4968-bbcd-1ce419f335cc',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    '59d9ac5f-1c7b-4805-8148-039c4f3a3fab',
    2,
    '2025-05-23 07:11:45.720',
    '2025-05-23 07:11:45.720'
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
    'df357278-2adc-4973-96b1-d777bc95f76a',
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    '0842f5a7-ea46-4658-a4a9-ade9801f37d0',
    1,
    '2025-05-23 07:31:56.718',
    '2025-05-23 07:31:56.718'
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
    'e238564f-2146-4c97-a547-a195074d85f0',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 11:34:32.281',
    '2025-05-22 11:34:32.281'
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
    'e2d0f379-5da0-4ae7-a701-ce2431af7452',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    2,
    '2025-05-23 07:11:45.635',
    '2025-05-23 07:11:45.635'
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
    'e40576aa-8957-406f-93bf-134100a8a502',
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-20 07:45:47.200',
    '2025-05-20 07:45:47.200'
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
    'e4849da9-344f-426f-afcc-a1e5c150165e',
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    1,
    '2025-05-22 11:34:32.309',
    '2025-05-22 11:34:32.309'
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
    'e559fb9f-3548-4009-9c14-1668243f5884',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-22 10:02:53.872',
    '2025-05-22 10:02:53.872'
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
    'e5d0f0ef-84e0-47d1-a421-373f535389a5',
    '06e507de-390c-454c-9b20-6694a2502dec',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 13:18:00.164',
    '2025-05-22 13:18:00.164'
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
    'e5d51bba-8b73-48f3-b3ce-4c3dbaf97791',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '4b5b8ab5-dd73-4325-bff6-d0de427ed7cb',
    1,
    '2025-05-24 09:50:21.765',
    '2025-05-24 09:50:21.765'
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
    'e6279a82-d93e-47b3-8e6d-afbd2e244982',
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    '71532023-e03e-4dca-9a07-dd972b238203',
    1,
    '2025-05-24 09:50:21.756',
    '2025-05-24 09:50:21.756'
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
    'e64367ae-209b-4858-a14a-9c267272accc',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-21 06:30:07.543',
    '2025-05-21 06:30:07.543'
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
    'e789fa1b-b2e5-46d5-b062-27e0435aeec9',
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    '4f2b25cf-c95b-4f3d-84fc-0b26bf0f3e2d',
    1,
    '2025-05-24 08:10:24.858',
    '2025-05-24 08:10:24.858'
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
    'e7e64e88-71d4-4e88-a467-bb50cacee28a',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-21 07:14:48.967',
    '2025-05-21 07:14:48.967'
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
    'e8140bb1-2fea-4a43-960e-6a236e1497d1',
    '099f52e6-ed37-4512-8ddd-8ba02b542b44',
    'c1a22abc-000c-4887-b2b5-08593e9f98e9',
    2,
    '2025-05-22 09:40:06.623',
    '2025-05-22 09:40:06.623'
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
    'e8e155a9-2c23-4ed3-b684-8a93ecc5782d',
    'd90c9884-9057-42e5-9312-bbf467936483',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    2,
    '2025-05-22 11:11:37.636',
    '2025-05-22 11:11:37.636'
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
    'e9e1367f-6cca-47fa-96a5-239d880fc774',
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-22 13:42:17.425',
    '2025-05-22 13:42:17.425'
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
    'ea82aea4-17f7-4b3e-8b2b-973d28b3d2d3',
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-24 07:07:50.782',
    '2025-05-24 07:07:50.782'
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
    'ead52fca-c7df-4b48-b8c3-45dda479ed0c',
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    '190c0657-2097-4e20-a004-8a67ae138648',
    3,
    '2025-05-20 06:50:50.298',
    '2025-05-20 06:50:50.298'
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
    'eb36c181-816d-4315-87d7-ad79774e0f26',
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-23 09:19:03.545',
    '2025-05-23 09:19:03.545'
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
    'eb8b811e-e9e9-439e-a838-63839e052de7',
    'dfe5219a-52c2-49fb-8a28-03df5d641539',
    'fa1719b3-74f1-4fa4-a646-a6a8c1cf3562',
    1,
    '2025-05-23 08:54:55.259',
    '2025-05-23 08:54:55.259'
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
    'ebe46823-2511-42b4-aff2-22c9a5262093',
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    'd9989f37-3466-4bce-b3f2-76bee0c9f39c',
    1,
    '2025-05-21 07:14:48.933',
    '2025-05-21 07:14:48.933'
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
    'ecdfd2ae-a00c-4a61-945f-f11f5963a996',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '35461ee0-4d04-4758-b1dc-6f36505761ea',
    1,
    '2025-05-23 14:22:18.622',
    '2025-05-23 14:22:18.622'
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
    'ecf071c6-732a-42c7-a79b-fa6133dd0896',
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    '79715bb3-3142-4e6e-9244-6ebff2c1b412',
    1,
    '2025-05-22 10:02:53.831',
    '2025-05-22 10:02:53.831'
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
    'ed337965-d176-41f9-be27-3a6b01accbf6',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    2,
    '2025-05-23 14:22:18.581',
    '2025-05-23 14:22:18.581'
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
    'ee0393b4-8211-4a03-a05a-e3702e6186bc',
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    1,
    '2025-05-22 09:50:48.298',
    '2025-05-22 09:50:48.298'
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
    'eedcc8f3-55e5-4606-aa01-6cdc86563ee9',
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    'b58a8a15-c117-49ce-b193-d9acef4a2448',
    1,
    '2025-05-23 08:21:48.771',
    '2025-05-23 08:21:48.771'
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
    'eee88a10-89e5-4e72-889e-337c3b8124fb',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    'c182d78b-69da-44c5-83fd-d08efeb61635',
    1,
    '2025-05-22 13:44:33.240',
    '2025-05-22 13:44:33.240'
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
    'f0cf6b26-21a2-4ac9-b2bb-529351757e1a',
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    '7a8d8cd1-0666-4806-8ae4-5b5d99d8bcfd',
    3,
    '2025-05-22 13:44:33.218',
    '2025-05-22 13:44:33.218'
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
    'f133cc1f-80fe-49a8-b7c2-310827e47ea2',
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    'df094a92-12c4-430a-8c57-51aff33fd312',
    1,
    '2025-05-23 08:21:48.748',
    '2025-05-23 08:21:48.748'
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
    'f3461b4e-9c54-44a0-b3bf-ef6c97e38ae1',
    '50a04ac2-9193-4e78-865c-9a0e74bdee4f',
    'a5ae5cc1-a81e-47d5-b09c-7baf5bb4919f',
    1,
    '2025-05-22 05:38:23.289',
    '2025-05-22 05:38:23.289'
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
    'f37cbab2-142f-4c87-b876-43bf73c9a548',
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-20 07:45:47.209',
    '2025-05-20 07:45:47.209'
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
    'f3bf199a-47d7-458e-a3c5-a733710df42c',
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-22 07:08:48.285',
    '2025-05-22 07:08:48.285'
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
    'f3cd6002-f938-486d-886e-818c53d40755',
    'ea6870a9-1dea-4735-86a5-dca1591aea1d',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 13:28:15.487',
    '2025-05-22 13:28:15.487'
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
    'f3d3fc63-142d-415b-b198-6646bcda1d3f',
    '099f52e6-ed37-4512-8ddd-8ba02b542b44',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-22 09:40:06.632',
    '2025-05-22 09:40:06.632'
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
    'f5c9839a-8215-4e3e-a392-78dff5e6355b',
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-24 08:10:24.865',
    '2025-05-24 08:10:24.865'
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
    'f6824aa3-c9e3-430a-a3a3-a41965698910',
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    3,
    '2025-05-22 11:39:03.020',
    '2025-05-22 11:39:03.020'
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
    'f6d37294-84c9-4677-9329-58bf94623639',
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-24 07:38:10.435',
    '2025-05-24 07:38:10.435'
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
    'f7a738df-1c7f-4542-ad71-5d614eeaab32',
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    'd9e5cfa8-a70d-4244-9a33-b7f33f0bb613',
    1,
    '2025-05-21 06:30:07.535',
    '2025-05-21 06:30:07.535'
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
    'f867ba64-73f0-400d-88d9-e49acf3426a6',
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    1,
    '2025-05-24 08:10:24.880',
    '2025-05-24 08:10:24.880'
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
    'f884fa4b-7de9-471e-bea7-8827a8d1a840',
    'c4d3201e-60aa-4464-b781-abf1e55413ed',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    1,
    '2025-05-20 09:11:58.035',
    '2025-05-20 09:11:58.035'
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
    'f9aee6d4-4954-4d41-a51a-733f1a2d47ff',
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    '6cb51b31-bbda-4d4e-bc10-d7c8be0f73a9',
    3,
    '2025-05-23 14:22:18.566',
    '2025-05-23 14:22:18.566'
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
    'f9fa63cf-8927-4adf-b82e-6e0f845d7d00',
    'c4ac97e5-0660-48cd-836c-b003d653c821',
    '190c0657-2097-4e20-a004-8a67ae138648',
    2,
    '2025-05-22 04:34:59.695',
    '2025-05-22 04:34:59.695'
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
    'fb8d68c0-8c0a-4b55-8803-9c57816b3f6c',
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    '190c0657-2097-4e20-a004-8a67ae138648',
    1,
    '2025-05-22 13:53:00.252',
    '2025-05-22 13:53:00.252'
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
    'fcc6c897-2157-47ed-9824-1525dc4e56bd',
    '1698330b-0736-4014-9e89-b98e40011e7a',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    2,
    '2025-05-21 15:16:11.338',
    '2025-05-21 15:16:11.338'
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
    'fd163c46-ad96-4a23-92d5-8aa3e68010fa',
    '75051264-8f10-41ea-a673-5330e2784174',
    'dd44069b-db13-47b7-a69d-3eef0f8e2e79',
    1,
    '2025-05-22 06:29:13.121',
    '2025-05-22 06:29:13.121'
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
    'fddd6eef-458e-4e40-bd89-ec04f8d54793',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    'ba328a6a-5ec6-4bb2-8644-209614d6cefb',
    5,
    '2025-05-23 07:11:45.790',
    '2025-05-23 07:11:45.790'
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
    'ffc4ea7a-4da6-4552-a463-f1fb2c73da9f',
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    'd2fcde68-eaea-46ef-827c-1c8fbe410d46',
    6,
    '2025-05-23 07:11:45.912',
    '2025-05-23 07:11:45.912'
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
    'ffdab430-13d0-4923-a087-0ba7ca8a1e65',
    'ad82a598-d22b-46e1-b262-ba1e140b2a1a',
    '2416c5e5-92e3-4fb3-abd1-c4d801cf0438',
    1,
    '2025-05-20 06:03:39.048',
    '2025-05-20 06:03:39.048'
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
    '02b5e0cc-193f-4e0d-88e0-e15a695c3253',
    'ta',
    '56',
    'QRIS',
    30000.000000000000000000000000000000,
    4500.000000000000000000000000000000,
    25500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 14:05:19.086',
    '2025-05-23 07:00:26.305'
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
    '0462450a-e9c4-4133-8343-1206957be990',
    'fiki',
    '123',
    'CASH',
    53000.000000000000000000000000000000,
    30000.900000000000000000000000000000,
    22999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:37:38.315',
    '2025-05-23 07:00:30.438'
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
    '06e507de-390c-454c-9b20-6694a2502dec',
    'cici',
    '123',
    'QRIS',
    72000.000000000000000000000000000000,
    9163.400000000000000000000000000000,
    62836.600000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:18:00.129',
    '2025-05-23 07:00:33.243'
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
    '0763b76c-1c1b-4f17-890f-6daa14ac5640',
    'ta',
    '123',
    'CASH',
    42000.000000000000000000000000000000,
    11000.016333137340000000000000000000,
    30999.983666862670000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 08:04:15.993',
    '2025-05-23 15:33:32.037'
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
    '0964e6e1-b864-4778-8ea3-05190fd9b305',
    'yani',
    '123',
    'QRIS',
    40000.000000000000000000000000000000,
    10120.000000000000000000000000000000,
    29880.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 09:50:48.285',
    '2025-05-23 07:00:36.227'
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
    '096763e9-c2ad-43e5-af77-be9f9d85a690',
    'maya',
    '123',
    'QRIS',
    179000.000000000000000000000000000000,
    54607.142857142860000000000000000000,
    124392.857142857100000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 07:11:39.254',
    '2025-05-22 04:23:29.282'
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
    '099f52e6-ed37-4512-8ddd-8ba02b542b44',
    'alwi',
    '123',
    'CASH',
    42000.000000000000000000000000000000,
    15000.900000000000000000000000000000,
    26999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 09:40:06.610',
    '2025-05-23 07:00:39.658'
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
    '1144b48d-dc9f-4022-8cc0-ef9a7530567f',
    'anin',
    '123',
    'QRIS',
    114000.000000000000000000000000000000,
    42950.000000000000000000000000000000,
    71050.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 06:50:50.249',
    '2025-05-21 06:27:23.526'
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
    '1246a44c-6ae9-4038-a94d-0ebf9e6f64fb',
    'y6',
    'hf',
    'CASH',
    8000.000000000000000000000000000000,
    0.899999999999999900000000000000,
    7999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:19:07.395',
    '2025-05-22 05:31:52.442'
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
    '13151a50-ad83-46ec-b381-b1f2f664b412',
    'novi',
    '123',
    'CASH',
    130000.000000000000000000000000000000,
    25349.786138613860000000000000000000,
    104650.213861386100000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:06:57.585',
    '2025-05-23 15:33:34.096'
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
    '1698330b-0736-4014-9e89-b98e40011e7a',
    'Tes 2',
    '123',
    'CASH',
    25000.000000000000000000000000000000,
    6000.000000000000000000000000000000,
    19000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 15:16:11.317',
    '2025-05-22 04:23:31.284'
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
    '1aaf9a24-7e67-4405-a357-c2ec15870737',
    'jae',
    '123',
    'QRIS',
    127000.000000000000000000000000000000,
    62357.142857142870000000000000000000,
    64642.857142857130000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 06:30:07.468',
    '2025-05-21 06:33:43.894'
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
    '1b6342ff-18e8-4b24-a1c9-302d9b57cf23',
    'gfgf',
    '24',
    'CASH',
    8000.000000000000000000000000000000,
    0.899999999999999900000000000000,
    7999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:16:37.607',
    '2025-05-22 05:31:59.896'
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
    '2220f334-f376-46d5-be93-749cb9b1d9a3',
    'Bu Onin',
    '223',
    'CASH',
    72000.000000000000000000000000000000,
    25500.000000000000000000000000000000,
    46500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 07:07:50.746',
    '2025-05-24 09:46:04.245'
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
    '2234cd34-3e74-4003-bb36-bc5dacdb516c',
    'ta',
    '123',
    'CASH',
    64000.000000000000000000000000000000,
    20875.900000000000000000000000000000,
    43124.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:04:46.287',
    '2025-05-23 15:33:36.927'
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
    '26255448-6a9a-4003-b096-66365a69b810',
    'ta',
    NULL,
    'CASH',
    22000.000000000000000000000000000000,
    8750.000000000000000000000000000000,
    13250.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:36:20.054',
    '2025-05-23 15:33:37.006'
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
    '2ba017a0-e6fa-4d99-96c3-e7fc240e410f',
    'rere',
    '123',
    'QRIS',
    108000.000000000000000000000000000000,
    22788.400000000000000000000000000000,
    85211.600000000010000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:57:17.658',
    '2025-05-23 07:00:42.581'
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
    '306b94e3-7160-4ec4-8ce7-bd9e4e03e125',
    'ibu evi',
    '123',
    'CASH',
    70000.000000000000000000000000000000,
    11745.908183632740000000000000000000,
    58254.091816367260000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:31:56.691',
    '2025-05-23 15:33:41.106'
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
    '31968987-8060-434e-8c46-e83d6023b9a5',
    'Tes',
    '123',
    'CASH',
    27000.000000000000000000000000000000,
    11125.000000000000000000000000000000,
    15875.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 15:12:56.885',
    '2025-05-22 04:23:33.190'
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
    '31995e4d-3727-4f75-aaee-bdce89be6a9c',
    'fizi',
    '5667',
    'QRIS',
    134000.000000000000000000000000000000,
    50200.000000000000000000000000000000,
    83800.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:44:33.206',
    '2025-05-23 07:00:46.154'
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
    '33fd3a2c-7181-45c6-90bc-53ae87ae0458',
    'fika',
    '123',
    'CASH',
    5000.000000000000000000000000000000,
    1500.000000000000000000000000000000,
    3500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 04:58:30.196',
    '2025-05-22 05:32:04.483'
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
    '340c66a7-a516-4bbd-81f0-bdfe35339b7b',
    'indri',
    '123',
    'QRIS',
    37000.000000000000000000000000000000,
    4675.000000000000000000000000000000,
    32325.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 09:28:19.872',
    '2025-05-21 06:27:27.637'
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
    '35a33963-2b58-488b-89fa-ddcf4b083e86',
    '8',
    '123',
    'QRIS',
    75000.000000000000000000000000000000,
    43950.000000000010000000000000000000,
    31049.999999999990000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 08:21:48.736',
    '2025-05-23 15:33:41.742'
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
    '3aadc7c3-408f-4751-9e61-3da1d5224ff6',
    'no 4',
    '123',
    'CASH',
    29000.000000000000000000000000000000,
    4337.500000000000000000000000000000,
    24662.500000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 09:39:22.598',
    '2025-05-24 09:46:05.792'
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
    '3bfc3c6e-8775-43d0-aef7-436a405c7fc8',
    '2',
    NULL,
    'CASH',
    26500.000000000000000000000000000000,
    8650.000000000000000000000000000000,
    17850.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:21:01.461',
    '2025-05-23 15:33:42.322'
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
    '3c51a515-5b4d-493a-b3ab-2d36695610ee',
    'tiara',
    NULL,
    'CASH',
    164000.000000000000000000000000000000,
    36394.710679611660000000000000000000,
    127605.289320388300000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:26:05.781',
    '2025-05-23 15:33:42.944'
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
    '3f906102-b5ba-4645-b0bb-35ad7ebda5a5',
    'ta rizkki',
    '5667',
    'CASH',
    49000.000000000000000000000000000000,
    16000.900000000000000000000000000000,
    32999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 14:07:29.062',
    '2025-05-23 07:00:49.509'
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
    '4539a5f1-b2b5-4744-b70a-b68abcee2bee',
    'meja 13',
    '123',
    'CASH',
    56000.000000000000000000000000000000,
    18300.000000000000000000000000000000,
    37700.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:12:28.812',
    '2025-05-23 15:33:43.475'
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
    '46bcf5af-8077-44a8-aa88-96d6a2393658',
    'arya',
    '123',
    'CASH',
    110000.000000000000000000000000000000,
    17272.517161716170000000000000000000,
    92727.482838283830000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:16:37.438',
    '2025-05-23 15:33:43.964'
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
    '4e6ffb63-e80f-4da1-b826-7e95d913f0a9',
    'lia',
    '123',
    'CASH',
    144000.000000000000000000000000000000,
    31775.900000000000000000000000000000,
    112224.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 10:52:14.065',
    '2025-05-23 07:00:55.015'
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
    '4e7313ff-e559-4d47-97ed-2b977c45d146',
    'meti',
    '1223',
    'CASH',
    185000.000000000000000000000000000000,
    10130.075378998110000000000000000000,
    174869.924621001900000000000000000000,
    0,
    0.000000000000000000000000000000,
    'ON_PROGRESS',
    '2025-05-24 09:50:21.679',
    '2025-05-24 09:50:21.770'
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
    '4e734b6f-a13d-4235-a745-5d5fff720e88',
    'vira',
    '123',
    'CASH',
    39000.000000000000000000000000000000,
    10050.000000000000000000000000000000,
    28950.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:33:34.694',
    '2025-05-23 07:00:58.816'
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
    '50a04ac2-9193-4e78-865c-9a0e74bdee4f',
    'ta',
    '123',
    'CASH',
    79000.000000000000000000000000000000,
    34642.857142857140000000000000000000,
    44357.142857142860000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:38:23.270',
    '2025-05-23 07:01:02.080'
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
    '515fb8af-7fd7-467c-bca6-e94d66cff282',
    'windi',
    '54',
    'QRIS',
    122000.000000000000000000000000000000,
    55628.190476190490000000000000000000,
    66371.809523809510000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:42:17.396',
    '2025-05-23 07:01:06.017'
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
    '553e5fb6-96c7-4375-a4cd-f4eadcbeba39',
    'zsfew',
    '1234',
    'CASH',
    15000.000000000000000000000000000000,
    10000.000000000000000000000000000000,
    5000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 04:59:16.446',
    '2025-05-22 05:18:30.302'
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
    '58d3948e-b5bd-4354-97e8-0650b3d44468',
    'dirga',
    '123',
    'QRIS',
    74000.000000000000000000000000000000,
    19488.400000000000000000000000000000,
    54511.600000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 11:39:02.981',
    '2025-05-23 07:01:09.920'
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
    '5b14c985-0026-469c-961d-b4d7d97ddad3',
    'icaa',
    '123',
    'QRIS',
    166000.000000000000000000000000000000,
    101400.900000000000000000000000000000,
    64599.099999999980000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 11:34:32.252',
    '2025-05-23 07:01:13.720'
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
    '5bb9832b-54d7-4ffa-ad2b-8dc1f5f187f2',
    'ta',
    NULL,
    'CASH',
    16000.000000000000000000000000000000,
    20450.000000000000000000000000000000,
    -4450.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 10:06:47.251',
    '2025-05-23 15:33:44.398'
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
    '5bd0a81a-076e-4adb-a211-5a8b62bf4f41',
    'jae',
    '123',
    'QRIS',
    127000.000000000000000000000000000000,
    62357.142857142870000000000000000000,
    64642.857142857130000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 07:14:48.921',
    '2025-05-22 04:23:34.933'
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
    '5bd705e3-bc9b-460c-a8ef-6d8e8a723a07',
    'Angga',
    '123',
    'QRIS',
    80000.000000000000000000000000000000,
    12221.617161716170000000000000000000,
    67778.382838283830000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 08:10:24.839',
    '2025-05-24 09:46:07.148'
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
    '5fb0b2df-83d4-415f-9073-321153e18f4b',
    'ta',
    NULL,
    'CASH',
    67000.000000000000000000000000000000,
    11644.783140557750000000000000000000,
    55355.216859442250000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 05:40:28.099',
    '2025-05-24 09:46:08.304'
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
    '5fcf5fa0-7518-468d-9829-3a9bbc6ff9b4',
    'andri',
    '123',
    'CASH',
    86000.000000000000000000000000000000,
    23692.857142857140000000000000000000,
    62307.142857142860000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:06:30.573',
    '2025-05-23 15:33:44.841'
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
    '649a1ffe-f132-42f3-ae9e-71011ee13273',
    '4',
    '123',
    'CASH',
    50000.000000000000000000000000000000,
    14726.909664563270000000000000000000,
    35273.090335436730000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 14:11:43.353',
    '2025-05-23 15:33:45.262'
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
    '6cb50640-f979-4b75-be02-999a9651ad44',
    'yadi',
    '123',
    'CASH',
    77000.000000000000000000000000000000,
    27050.000000000000000000000000000000,
    49950.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:10:19.414',
    '2025-05-23 15:33:46.319'
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
    '6d4fe050-59d7-421b-b4e8-20e8971402f8',
    'r3wr',
    '35',
    'CASH',
    8000.000000000000000000000000000000,
    0.899999999999999900000000000000,
    7999.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:16:02.459',
    '2025-05-22 05:18:27.301'
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
    '6ef14722-e82d-49d6-a5b0-93513e9fffd1',
    'aan',
    '123',
    'CASH',
    69000.000000000000000000000000000000,
    14300.000000000000000000000000000000,
    54700.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 07:45:47.168',
    '2025-05-21 06:27:39.932'
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
    '704df806-58df-4d00-9d16-5b5cbaf64330',
    'honda',
    NULL,
    'TRANSFER',
    122000.000000000000000000000000000000,
    30253.851995401210000000000000000000,
    91746.148004598800000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:19:03.476',
    '2025-05-23 15:33:47.400'
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
    '72ccf99e-e7a1-4cf1-ad9f-5a256157a5fa',
    'ta',
    '123',
    'CASH',
    36000.000000000000000000000000000000,
    15000.000000000000000000000000000000,
    21000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:13:32.750',
    '2025-05-23 15:33:48.703'
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
    '72fe124d-8b70-4bf3-9fc4-5510f62f1d17',
    'ta',
    '123',
    'CASH',
    46000.000000000000000000000000000000,
    17000.000000000000000000000000000000,
    29000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:13:08.672',
    '2025-05-23 15:33:49.156'
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
    '73bd0aff-e6c4-4c91-876d-9cebd9fab628',
    'budi',
    '123',
    'CASH',
    102000.000000000000000000000000000000,
    25500.000000000000000000000000000000,
    76500.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 06:51:23.318',
    '2025-05-22 04:23:36.990'
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
    '75051264-8f10-41ea-a673-5330e2784174',
    'ice',
    '123',
    'CASH',
    95000.000000000000000000000000000000,
    18777.000000000000000000000000000000,
    76223.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 06:29:13.107',
    '2025-05-23 07:01:16.821'
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
    '77ee705a-4449-459d-b360-7f5f48f1bb13',
    'ta bojong ',
    '123',
    'TRANSFER',
    794000.000000000000000000000000000000,
    191658.985714285700000000000000000000,
    602341.014285714400000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 07:11:45.624',
    '2025-05-23 15:33:49.607'
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
    '832f77f8-568b-4fd0-9ece-918c57424d67',
    'ibu yeti',
    '234',
    'CASH',
    95000.000000000000000000000000000000,
    20475.000000000000000000000000000000,
    74525.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:45:49.551',
    '2025-05-23 07:01:19.660'
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
    '8370f160-21c9-4cf0-bf0b-1e56cc3490a0',
    'meli',
    '123',
    'QRIS',
    93000.000000000000000000000000000000,
    54758.333333333340000000000000000000,
    38241.666666666660000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 07:08:48.201',
    '2025-05-23 07:01:21.985'
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
    '8f8f6d73-1408-45bc-9a7b-c0b5be333bb6',
    'f',
    '123',
    'CASH',
    1000.000000000000000000000000000000,
    200.000000000000000000000000000000,
    800.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 06:32:59.995',
    '2025-05-21 06:33:48.113'
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
    '8f9615c0-a456-40ee-bedb-bc2d2b0478ff',
    'azza',
    NULL,
    'QRIS',
    63000.000000000000000000000000000000,
    17496.692805121010000000000000000000,
    45503.307194878990000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:23:06.275',
    '2025-05-23 15:33:50.926'
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
    '9360582e-2af0-4901-868f-f7e14163955e',
    'arini',
    '98',
    'QRIS',
    88000.000000000000000000000000000000,
    29817.857142857140000000000000000000,
    58182.142857142860000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:48:29.148',
    '2025-05-23 07:01:24.061'
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
    '9eabdb74-a6b3-4f23-ad0a-a8414136b0d5',
    'hidayh',
    '23',
    'CASH',
    82000.000000000000000000000000000000,
    49485.333333333340000000000000000000,
    32514.666666666660000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 07:17:36.191',
    '2025-05-22 04:23:38.708'
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
    '9ebcb16a-f8c8-4754-96d9-c071dc2f6599',
    'a',
    '56',
    'QRIS',
    57000.000000000000000000000000000000,
    15675.900000000000000000000000000000,
    41324.100000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:53:00.241',
    '2025-05-23 07:01:26.660'
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
    'a1624f57-125a-4b33-9fe5-9ecf27424a99',
    'ibu orin',
    '123',
    'CASH',
    48000.000000000000000000000000000000,
    17375.000000000000000000000000000000,
    30625.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 06:44:01.522',
    '2025-05-23 07:01:29.280'
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
    'a2821a8d-a94e-4ee5-b130-b2da2e060afe',
    'niar',
    NULL,
    'QRIS',
    36000.000000000000000000000000000000,
    15000.000000000000000000000000000000,
    21000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 10:08:38.331',
    '2025-05-23 15:33:51.353'
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
    'a5bceb92-a082-4270-8d5d-fe6861dc480a',
    'bekto',
    '123',
    'CASH',
    101000.000000000000000000000000000000,
    26957.142857142860000000000000000000,
    74042.857142857140000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 06:48:16.480',
    '2025-05-22 04:23:40.813'
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
    'ad82a598-d22b-46e1-b262-ba1e140b2a1a',
    'serli',
    '123',
    'CASH',
    25000.000000000000000000000000000000,
    9300.000000000000000000000000000000,
    15700.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 06:03:39.022',
    '2025-05-21 06:27:43.258'
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
    'b1b8df21-05ef-4d84-8774-ca0a67833189',
    'ta',
    NULL,
    'CASH',
    80000.000000000000000000000000000000,
    44666.666666666680000000000000000000,
    35333.333333333320000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 10:56:28.965',
    '2025-05-23 07:01:31.775'
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
    'b3600480-c53f-44db-b40f-8f7f8cd00642',
    'ita',
    '1233',
    'CASH',
    86000.000000000000000000000000000000,
    17161.386138613860000000000000000000,
    68838.613861386140000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 07:25:31.538',
    '2025-05-24 09:46:09.657'
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
    'b834497d-5376-4ce8-9f00-9138159651d4',
    'Serli',
    '123',
    'CASH',
    240000.000000000000000000000000000000,
    11200.000000000000000000000000000000,
    228800.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 05:40:53.821',
    '2025-05-21 06:27:45.896'
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
    'c4ac97e5-0660-48cd-836c-b003d653c821',
    'vira',
    '123',
    'CASH',
    39000.000000000000000000000000000000,
    10050.000000000000000000000000000000,
    28950.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 04:34:59.620',
    '2025-05-22 04:58:04.056'
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
    'c4d3201e-60aa-4464-b781-abf1e55413ed',
    'rini',
    '123',
    'QRIS',
    26000.000000000000000000000000000000,
    9407.142857142857000000000000000000,
    16592.857142857140000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 09:11:58.015',
    '2025-05-21 06:27:48.244'
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
    'd1fedbf0-978b-4fb2-ba19-4a3d7f945466',
    'bu lis',
    '123',
    'QRIS',
    82000.000000000000000000000000000000,
    28550.000000000000000000000000000000,
    53450.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:35:41.212',
    '2025-05-23 07:01:34.455'
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
    'd57648aa-c853-4591-836a-2197ede095dc',
    'ta',
    '123',
    'CASH',
    50000.000000000000000000000000000000,
    10000.000000000000000000000000000000,
    40000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 05:23:44.459',
    '2025-05-23 07:01:36.792'
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
    'd7349adb-9e4d-4535-9d6a-07dd4b350261',
    '3',
    '234',
    'CASH',
    50000.000000000000000000000000000000,
    14175.000000000000000000000000000000,
    35825.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:39:06.146',
    '2025-05-23 07:01:39.820'
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
    'd90c9884-9057-42e5-9312-bbf467936483',
    'niar',
    '123',
    'CASH',
    36000.000000000000000000000000000000,
    15000.000000000000000000000000000000,
    21000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 11:11:37.624',
    '2025-05-23 07:01:42.863'
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
    'dc396018-6dd5-4a15-9589-4e1f37066789',
    'bu tini',
    '123',
    'CASH',
    125000.000000000000000000000000000000,
    49250.000000000000000000000000000000,
    75750.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 07:52:52.856',
    '2025-05-21 06:27:50.345'
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
    'de610e8e-0721-496e-9880-71d47e63cfc6',
    'gentin',
    '123',
    'QRIS',
    314000.000000000000000000000000000000,
    52000.000000000000000000000000000000,
    262000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-20 05:49:38.436',
    '2025-05-21 06:27:52.441'
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
    'dfe5219a-52c2-49fb-8a28-03df5d641539',
    'novi',
    '123',
    'CASH',
    45000.000000000000000000000000000000,
    15800.000000000000000000000000000000,
    29200.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 08:54:55.251',
    '2025-05-23 09:02:26.932'
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
    'ea6870a9-1dea-4735-86a5-dca1591aea1d',
    'anas',
    NULL,
    'QRIS',
    54000.000000000000000000000000000000,
    10300.000000000000000000000000000000,
    43700.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 13:28:15.454',
    '2025-05-23 07:01:46.727'
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
    'ee083b6b-2757-4393-8df2-91030d541766',
    'yanti ',
    '1234',
    'CASH',
    32000.000000000000000000000000000000,
    8000.016333137336000000000000000000,
    23999.983666862660000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 07:18:13.648',
    '2025-05-24 09:46:11.003'
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
    'f2003b32-a835-4db8-b472-f7a204d0d255',
    'andi',
    '123',
    'QRIS',
    184000.000000000000000000000000000000,
    53245.683140557750000000000000000000,
    130754.316859442200000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 14:22:18.530',
    '2025-05-23 15:33:51.816'
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
    'f46dea06-99af-4afb-9bf5-d0582e3fe269',
    'ta',
    '123',
    'CASH',
    58000.000000000000000000000000000000,
    24000.000000000000000000000000000000,
    34000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 07:47:16.941',
    '2025-05-23 07:01:49.596'
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
    'f4d1e3fe-bc9f-4610-aa9d-d2bdc469d9e1',
    'Ibam',
    '1233',
    'CASH',
    94000.000000000000000000000000000000,
    18980.745326827130000000000000000000,
    75019.254673172870000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 06:59:24.272',
    '2025-05-24 09:46:12.337'
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
    'f7a2f358-47f2-4594-b50b-32117351cda5',
    '6',
    '123',
    'QRIS',
    60000.000000000000000000000000000000,
    10300.000000000000000000000000000000,
    49700.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-21 06:34:22.825',
    '2025-05-22 04:23:42.876'
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
    'f96a7a44-e6a8-411f-8c73-f786cccc3149',
    'mita',
    '123',
    'CASH',
    402000.000000000000000000000000000000,
    96067.580123645110000000000000000000,
    305932.419876354900000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-24 07:38:10.423',
    '2025-05-24 09:46:13.496'
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
    'fb9d3f1d-0106-4104-97b7-392cfbe17b2b',
    'laras',
    '123',
    'CASH',
    70000.000000000000000000000000000000,
    21920.000000000000000000000000000000,
    48080.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-22 10:02:53.817',
    '2025-05-23 07:01:52.373'
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
    'ff27776f-32cc-4b51-9766-e6a1c6485316',
    'ta',
    NULL,
    'CASH',
    10000.000000000000000000000000000000,
    3000.000000000000000000000000000000,
    7000.000000000000000000000000000000,
    0,
    0.000000000000000000000000000000,
    'DONE',
    '2025-05-23 09:59:34.600',
    '2025-05-23 15:33:52.436'
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
    '0679f0c6-0d6c-4720-a1da-93f3b0ae8b9b',
    '5d72aace-a131-4aa9-8bc9-92159f483624',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    '2025-05-21 14:58:46.784',
    '2025-05-21 14:58:46.784'
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
    '30139444-4da2-44fb-995c-cf9c7c3a7dd1',
    'cee6f583-f897-4d70-b6f0-761954782ae7',
    '99cb3f9e-b2ab-459d-91e0-098711a267fd',
    1,
    '2025-05-19 19:22:05.706',
    '2025-05-19 19:22:05.706'
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
    '3d8b13cf-f7b9-46af-9054-b2ed0f9c1d71',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    '27617977-b509-4d94-bc7d-f5df36b0ff0f',
    1,
    '2025-05-20 09:22:17.027',
    '2025-05-20 09:22:17.027'
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
    '3e633529-a88b-4f88-8fbb-527576b1dbdf',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    '0bf4a51d-1161-4d7c-a8f3-6b6fe5eeb036',
    1,
    '2025-05-20 09:22:17.012',
    '2025-05-20 09:22:17.012'
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
    '4635e476-13c5-4518-a47f-8313b4c7603e',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    '248a01c4-6371-41f4-829b-e85e8fb4d28b',
    1,
    '2025-05-20 09:22:17.023',
    '2025-05-20 09:22:17.023'
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
    '9beef10e-8610-4dea-a441-7a5d38da086a',
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    '10b6a5a4-1db8-4b9d-8ae7-192509ae12f9',
    1,
    '2025-05-20 09:22:17.020',
    '2025-05-20 09:22:17.020'
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
    'e7b5bb88-cc1b-4537-a263-f645d15129dd',
    'cee6f583-f897-4d70-b6f0-761954782ae7',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    1,
    '2025-05-19 19:22:05.712',
    '2025-05-19 19:22:05.712'
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
    '49fa4fa5-c069-4305-a2b4-4dec0f514685',
    'paket hemat',
    '/package/7158f402-23d0-4b8e-84c3-58962b3879b9.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-20 09:16:09.482',
    '2025-05-24 09:47:20.853'
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
    'cee6f583-f897-4d70-b6f0-761954782ae7',
    'Paket Puyuh',
    '/package/87348c75-0751-479e-b561-e86ff1949bc7.jpg',
    30000.000000000000000000000000000000,
    1,
    '2025-05-19 19:21:51.909',
    '2025-05-19 19:21:51.909'
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
    '13ac2a73-ff14-4733-928a-7b1192745a57',
    '765d430f-bc7d-4f1a-b837-3371f9403d96',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-24 09:46:37.007',
    '2025-05-24 09:46:37.007'
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
    '3f03ff87-b574-42ec-8b27-1517e537b8fc',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-20 06:02:14.919',
    '2025-05-20 06:02:14.919'
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
    '54ac6b8f-03c1-47d0-b84c-b7121d78726c',
    'e60bee15-d3cd-48e8-abba-c80959d5ac41',
    'a4acb4f2-fd65-4cc6-8c16-b9e5ed3dfae6',
    '2025-05-20 06:02:14.913',
    '2025-05-20 06:02:14.913'
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
    'f11ac5f3-05d5-4b66-a235-04a77c0cf2aa',
    '92fd3e8b-68a0-42e4-a187-34f8d50f1894',
    '40349ca3-bc5d-46c7-a473-17bf1c8e3348',
    '2025-05-24 09:46:37.013',
    '2025-05-24 09:46:37.013'
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
    '07845a70-14e2-4e71-b5e6-eaa4f18a8a76',
    '77c4c652-675b-44d3-9b8d-bfff9b2c6f52',
    '714b1ee0-9384-42bc-b3fe-7baf30fe9998',
    1.000000000000000000000000000000,
    '2025-05-20 09:10:02.681',
    '2025-05-20 09:10:02.681'
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
    '2ec569f1-1f7f-48f2-b6f9-50abfedf3e7c',
    'f455cd6a-66e1-4356-9497-0911aeadf24b',
    '4cc4d16a-079c-4506-bc0e-df1f347accee',
    1.000000000000000000000000000000,
    '2025-05-19 19:21:22.253',
    '2025-05-19 19:21:22.253'
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
    '688f22ee-d3c2-46d4-b16e-6beae7b60c62',
    '92fd3e8b-68a0-42e4-a187-34f8d50f1894',
    '224fd7df-f7f4-4c5e-80a5-6f50ed031cfe',
    1.000000000000000000000000000000,
    '2025-05-24 09:44:07.329',
    '2025-05-24 09:44:07.329'
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
    '741cf9cf-0353-4ebc-a488-e4b695abc055',
    '4dca53a1-88a2-404b-af7e-06c3e086e46b',
    'ddf79b3b-bbb7-422a-a597-8bc4ca68d2c1',
    1.000000000000000000000000000000,
    '2025-05-21 15:01:21.028',
    '2025-05-21 15:01:21.028'
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
    '8ad2cf94-10b8-4f90-a106-98bfebb0120e',
    '190c0657-2097-4e20-a004-8a67ae138648',
    'cf38e6ef-a686-49a5-bb08-9da0b5d194c6',
    20.000000000000000000000000000000,
    '2025-05-20 05:49:29.399',
    '2025-05-20 05:49:29.399'
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
    '9ef69131-7558-4479-95ff-0459a907b3a1',
    'e60bee15-d3cd-48e8-abba-c80959d5ac41',
    '0e47cdad-7c53-43b2-a7ad-c5fc23d87144',
    1.000000000000000000000000000000,
    '2025-05-20 06:30:10.714',
    '2025-05-20 06:30:10.714'
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
    'a947019c-ce1f-4804-a250-edac3ba4175e',
    '9183f0ac-2d61-416c-a7bd-6ea5f5221b9a',
    '70785041-1f9e-46cc-b2fa-87a1465b5d1a',
    100.000000000000000000000000000000,
    '2025-05-19 19:23:30.755',
    '2025-05-19 19:23:30.755'
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
    'c63773ad-315d-42f6-bd4d-2d468bcd226d',
    '93802ab0-71c1-48d1-a760-52376a26851f',
    '21463e89-5f09-441c-ab4b-d05abc1a984c',
    50.000000000000000000000000000000,
    '2025-05-22 05:15:17.831',
    '2025-05-22 05:15:17.831'
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
    'c9f5b0d0-9124-4167-985b-0e2216e2eaff',
    '549b1b17-a348-4a36-8053-25cae5dd1663',
    'e18a3c64-5b15-4532-b9b8-a1e919845f9c',
    50.000000000000000000000000000000,
    '2025-05-21 15:02:02.718',
    '2025-05-21 15:02:02.718'
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
    'ded9a117-b3c4-4b49-a67e-0a7903f26106',
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    '0e47cdad-7c53-43b2-a7ad-c5fc23d87144',
    1.000000000000000000000000000000,
    '2025-05-20 05:58:28.194',
    '2025-05-20 05:58:28.194'
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
    'e509cc38-6ff9-4aad-86dc-1b3d88684bd6',
    '5969d084-d38a-43da-98c9-2b96c1e43d66',
    'a16d5791-f18e-418a-b259-8dd95cd1b346',
    500.000000000000000000000000000000,
    '2025-05-23 07:25:52.317',
    '2025-05-23 07:25:52.317'
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
    'e78b2686-0b61-43f3-b90e-0f38294a0da3',
    '765d430f-bc7d-4f1a-b837-3371f9403d96',
    '5b2d05bd-92f7-4bdb-8a8e-ec24a4f93676',
    1.000000000000000000000000000000,
    '2025-05-24 09:44:54.022',
    '2025-05-24 09:44:54.022'
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
    'ec4530a9-4016-4f51-8c28-5ef9179ec818',
    '99cb3f9e-b2ab-459d-91e0-098711a267fd',
    '4cc4d16a-079c-4506-bc0e-df1f347accee',
    1.000000000000000000000000000000,
    '2025-05-19 19:21:13.566',
    '2025-05-19 19:21:13.566'
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
    '/product/d765b038-daa1-4742-a1c2-daa871fc943f.jpg',
    13000.000000000000000000000000000000,
    1,
    '2025-05-19 12:01:31.109',
    '2025-05-23 07:27:24.716'
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
    '765d430f-bc7d-4f1a-b837-3371f9403d96',
    'Gurame Saos Padang 350 Gram',
    '/product/da9900a3-5dd0-40ba-a34e-4a8bb5cc60c0.jpg',
    45000.000000000000000000000000000000,
    1,
    '2025-05-24 09:44:37.458',
    '2025-05-24 09:44:37.458'
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
    '/product/b2627fb5-d6de-4263-b033-9b8a3398b001.jpg',
    25000.000000000000000000000000000000,
    1,
    '2025-05-19 11:22:43.043',
    '2025-05-19 19:27:44.014'
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
    '9183f0ac-2d61-416c-a7bd-6ea5f5221b9a',
    'Sambel Ceurik Ekstra Pedas',
    NULL,
    5000.000000000000000000000000000000,
    1,
    '2025-05-19 19:22:47.203',
    '2025-05-19 19:22:47.203'
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
    '92fd3e8b-68a0-42e4-a187-34f8d50f1894',
    'Gurame Saos Padang 500 Gram',
    '/product/bf1528bc-cb35-4844-9762-5c91a979098e.jpg',
    65000.000000000000000000000000000000,
    1,
    '2025-05-24 09:43:37.149',
    '2025-05-24 09:43:37.149'
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
    '/product/ea189e9d-afb1-4488-a6ab-863e2b2a07d5.jpg',
    10000.000000000000000000000000000000,
    1,
    '2025-05-19 17:52:42.262',
    '2025-05-19 19:36:42.376'
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
    '99cb3f9e-b2ab-459d-91e0-098711a267fd',
    'Puyuh Goreng',
    '/product/912023b2-19c3-4346-8a06-1ec2eb54fafe.jpg',
    20000.000000000000000000000000000000,
    1,
    '2025-05-19 19:20:34.270',
    '2025-05-19 19:20:34.270'
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
    '/product/e2dc851d-2a95-47a7-ba8b-f6698942a133.undefined',
    23000.000000000000000000000000000000,
    1,
    '2025-05-19 11:21:22.768',
    '2025-05-19 19:30:23.302'
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
    '/product/6df163ac-8046-4a8b-ad27-0622631ccffe.jpg',
    15000.000000000000000000000000000000,
    1,
    '2025-05-19 12:01:43.764',
    '2025-05-19 19:30:40.797'
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
    '/product/87abce9d-ebc1-4122-b9a6-16e29a286093.jpg',
    8000.000000000000000000000000000000,
    1,
    '2025-05-19 17:52:27.477',
    '2025-05-19 19:34:36.635'
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
    'e60bee15-d3cd-48e8-abba-c80959d5ac41',
    'Kerupuk Gantung',
    NULL,
    4000.000000000000000000000000000000,
    1,
    '2025-05-20 06:00:59.932',
    '2025-05-20 06:00:59.932'
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
    'e6fcb082-c490-4621-8fac-d77eb2140c60',
    'Kerupuk Kaleng',
    NULL,
    2000.000000000000000000000000000000,
    1,
    '2025-05-20 05:56:24.332',
    '2025-05-20 06:00:42.875'
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
    'f455cd6a-66e1-4356-9497-0911aeadf24b',
    'Puyuh Bakar',
    '/product/34376c7a-2206-4a5f-aeeb-04b02ebcac79.jpg',
    22000.000000000000000000000000000000,
    1,
    '2025-05-19 19:20:58.094',
    '2025-05-19 19:20:58.094'
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
    12000.000000000000000000000000000000,
    1,
    '2025-05-19 17:53:42.121',
    '2025-05-21 15:05:35.799'
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
