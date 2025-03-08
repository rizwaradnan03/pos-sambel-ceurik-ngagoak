/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `categories` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `category` enum('PRODUCT', 'PACKAGE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
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
  `role` enum('CASHIER', 'CHEF') COLLATE utf8mb4_unicode_ci NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `salary_per_day` decimal(65, 30) NOT NULL,
  `transport` decimal(65, 30) NOT NULL,
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `avgCostPerUnit` decimal(65, 30) NOT NULL DEFAULT '0.000000000000000000000000000000',
  `unitOfMeasure` enum('G', 'ML', 'PCS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `quantity` int NOT NULL,
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `quantity` int NOT NULL,
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
  `paymentType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `totalPrice` decimal(65, 30) NOT NULL,
  `customer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profit` decimal(65, 30) DEFAULT NULL,
  `totalCost` decimal(65, 30) DEFAULT NULL,
  `order_status` enum('DONE', 'ON_PROGRESS') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ON_PROGRESS',
  `is_tax_included` tinyint(1) NOT NULL DEFAULT '0',
  `taxAmount` decimal(65, 30) DEFAULT '0.000000000000000000000000000000',
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
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
  KEY `product_ingredients_product_id_fkey` (`product_id`),
  KEY `product_ingredients_ingredient_id_fkey` (`ingredient_id`),
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
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `price` decimal(65, 30) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN', 'CASHIER', 'INVENTORY', 'ANALYTICS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_key` (`email`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: _prisma_migrations
# ------------------------------------------------------------

INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '47843596-7531-4618-8d1b-8aa5546ba714',
    '6aae5630b46cda2b5cf344db86f0d0f16bbde71fbe5268997809a30eb0728ab1',
    '2025-03-08 10:42:27.254',
    '20250308055833_',
    NULL,
    NULL,
    '2025-03-08 10:42:26.794',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '49fd43b2-6208-44ac-be80-43688947856e',
    '0026448ce9e9ad184e27e45c9fb1e5b00066bf5772d3b57795aa5e977dd37e27',
    '2025-03-08 10:42:21.831',
    '20250224114615_',
    NULL,
    NULL,
    '2025-03-08 10:42:21.671',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '744ec459-b633-45b6-bb33-70697eb933f2',
    'c632fe7573768b62993d5837ed79267010a30c050fc9c97e3873d958be3cd472',
    '2025-03-08 10:42:23.134',
    '20250226070910_',
    NULL,
    NULL,
    '2025-03-08 10:42:22.834',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '748c8adb-7ddf-4eba-9ea4-6050d296d69e',
    'e8c2489fd8fc50d23d4980163c6d3d888102049b2afb33abbb17da06040a4f67',
    '2025-03-08 10:42:26.382',
    '20250305102216_',
    NULL,
    NULL,
    '2025-03-08 10:42:24.568',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '7b5870e0-7c23-4f0e-9f61-b718ce2b4279',
    '371c135247e6ad7e7c3e0e62aa66732666046f1f647d3277371449e4b7a332f7',
    '2025-03-08 10:42:24.537',
    '20250302131709_',
    NULL,
    NULL,
    '2025-03-08 10:42:24.277',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '9633199c-7801-47ca-930a-b5b8e5a604ac',
    '9d56adaeb26984a645148410d6ca4becdd4fba1af4e6ed8f69718bc02dab4783',
    '2025-03-08 10:42:22.592',
    '20250225052146_',
    NULL,
    NULL,
    '2025-03-08 10:42:22.483',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    '9a75188f-a5f5-4ee4-93a9-14c512258886',
    '51deaea97462a73a6078b1ee5005602ebafa2a2c7fa793b248e2c2e5d78d9c5b',
    '2025-03-08 10:42:18.773',
    '20250222224406_',
    NULL,
    NULL,
    '2025-03-08 10:42:18.262',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'a22561f4-d6af-489b-ad9e-5ffa8d953428',
    '9f866337c1104eb95e672c588ebf2aebf0d0bcbd232deaede9f3db1bbca02112',
    '2025-03-08 10:42:22.452',
    '20250225042718_',
    NULL,
    NULL,
    '2025-03-08 10:42:22.252',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'b6fba35e-1a86-481b-8df0-089d67fce856',
    '8a9766a75783766a27b7e2e752388d17012f6188d6cbc8e209d5ea2662e5bdf2',
    '2025-03-08 10:42:22.803',
    '20250225225727_',
    NULL,
    NULL,
    '2025-03-08 10:42:22.663',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bb8ba3b0-d7d3-413c-9f0e-a09e0913c94e',
    '196b475baba0e7698406d75e5b6e3d3387d08dcc53d024da43210a65607aae44',
    '2025-03-08 10:42:22.221',
    '20250225001705_',
    NULL,
    NULL,
    '2025-03-08 10:42:21.972',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bbebf8c9-6921-4e31-9065-6e237e1bbdae',
    '4b8a4464f0f57a566d3e81e4d00676ce14f4bad2bc469aff8fb81b8baa382ddf',
    '2025-03-08 10:42:16.788',
    '20250222220228_',
    NULL,
    NULL,
    '2025-03-08 10:42:15.766',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bd347d96-c3bb-4590-b301-7be14feef15d',
    '22b3d5ea5a1611767761741a78c4f6ed38331aa570b592452e53bcf2f8335fa3',
    '2025-03-08 10:42:15.735',
    '20250222122833_',
    NULL,
    NULL,
    '2025-03-08 10:42:12.531',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bdc68905-3554-4426-9b23-eca364c5f6fd',
    'f172d646df96c519ede083e704d05c38ec9f5572ee8f1f510224909d86a2809d',
    '2025-03-08 10:42:18.042',
    '20250222222618_',
    NULL,
    NULL,
    '2025-03-08 10:42:17.681',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bf889f1a-31e6-4929-a5aa-7a685c061c78',
    '93d7aac9445925f669cff15a79769529a00d7c27469df2c184395d5c59fb3b13',
    '2025-03-08 10:42:26.762',
    '20250307041935_',
    NULL,
    NULL,
    '2025-03-08 10:42:26.653',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'bff729b8-0507-4cfe-8e00-31d0b8469c23',
    '3ffa4c44eae09455b3ee593f681e5a5dada591cbb783766bc69b153ffb58684d',
    '2025-03-08 10:42:23.389',
    '20250226150633_',
    NULL,
    NULL,
    '2025-03-08 10:42:23.205',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'c78d26a0-dfd5-4a3e-8557-98bc59eb18d9',
    'e6df07f51e26a845106d4df851f8f92537f4d7c3b3751c0ca58efda0e73bcd9c',
    '2025-03-08 10:42:24.207',
    '20250227034610_',
    NULL,
    NULL,
    '2025-03-08 10:42:23.847',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'e5c4752e-0e3d-44a6-9789-8cffcbfe61ea',
    '489879b425882d81788321d37f875c271587f57446ac854e7b841a91e38e22fe',
    '2025-03-08 10:42:17.650',
    '20250222222159_',
    NULL,
    NULL,
    '2025-03-08 10:42:16.859',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'e6aaa5b2-d94a-49f8-8878-0c66d5c18cfd',
    'e15913ddea40a62e4d97c045011b23c1888fef4902c2f010616d30c9280ed22b',
    '2025-03-08 10:42:26.622',
    '20250305121654_',
    NULL,
    NULL,
    '2025-03-08 10:42:26.462',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'e949c709-97b8-4bef-9d2b-454fb2984595',
    'f9ee5b30a7ebc9ca24e18c3a9c7b457017bda80680abf8e1f2f7492f756e1896',
    '2025-03-08 10:42:21.600',
    '20250224075417_',
    NULL,
    NULL,
    '2025-03-08 10:42:18.854',
    1
  );
INSERT INTO
  `_prisma_migrations` (
    `id`,
    `checksum`,
    `finished_at`,
    `migration_name`,
    `logs`,
    `rolled_back_at`,
    `started_at`,
    `applied_steps_count`
  )
VALUES
  (
    'fe1bd55c-c5ed-4789-afcb-73c242cbccae',
    '052613b194fd09228f411cfaae9455a5cdb2607ded228ef3ef866e8fe9a94238',
    '2025-03-08 10:42:23.815',
    '20250226151403_',
    NULL,
    NULL,
    '2025-03-08 10:42:23.425',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: categories
# ------------------------------------------------------------

INSERT INTO
  `categories` (
    `id`,
    `title`,
    `created_at`,
    `updated_at`,
    `category`,
    `is_active`
  )
VALUES
  (
    '0da18c56-adda-4ab5-b8e0-e60f4b3f9f52',
    'Paket',
    '2025-03-08 10:44:19.715',
    '2025-03-08 10:44:19.715',
    'PACKAGE',
    1
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `created_at`,
    `updated_at`,
    `category`,
    `is_active`
  )
VALUES
  (
    '2de5e116-627d-4683-afc6-243659c18bfe',
    'Makanan',
    '2025-03-08 10:44:05.706',
    '2025-03-08 10:44:05.706',
    'PRODUCT',
    1
  );
INSERT INTO
  `categories` (
    `id`,
    `title`,
    `created_at`,
    `updated_at`,
    `category`,
    `is_active`
  )
VALUES
  (
    '6f12deaf-9968-40cf-84dd-97c71eebea44',
    'Minuman',
    '2025-03-08 10:44:14.156',
    '2025-03-08 10:44:14.156',
    'PRODUCT',
    1
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


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ingredients
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: log_ingredients
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: log_orders
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: order_packages
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: order_products
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: orders
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: package_categories
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: package_items
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: packages
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: product_categories
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: product_ingredients
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: products
# ------------------------------------------------------------

INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '02309d92-6bb8-489c-8256-a974cbf11525',
    NULL,
    'Ikan Asin Selar Goreng',
    '2025-03-08 11:29:26.133',
    '2025-03-08 11:29:26.133',
    7000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '0bf7641e-1233-4abf-b575-a6226c9e3c64',
    NULL,
    'Pecak Ikan Nila Kuah',
    '2025-03-08 10:54:08.115',
    '2025-03-08 10:54:08.115',
    25000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '0da8162a-9eb8-4720-bddf-cfe05817ac2a',
    NULL,
    'Puyuh Bakar Madu',
    '2025-03-08 10:46:51.552',
    '2025-03-08 10:46:51.552',
    22000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '12d66890-55e9-4d05-8678-8d7fbcda2ae6',
    NULL,
    'Tumis Ikan Asin Selar',
    '2025-03-08 11:29:38.841',
    '2025-03-08 11:29:38.841',
    10000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '14854d71-4735-46ed-99ae-fc9fd5577a62',
    NULL,
    'Ikan Gurame Goreng 1/2 Kg',
    '2025-03-08 10:51:06.685',
    '2025-03-08 10:51:06.685',
    60000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '1a89bd37-eb3c-427e-85ca-3d3ba9879249',
    NULL,
    'Pecak Ikan Mas Kuah',
    '2025-03-08 10:53:55.774',
    '2025-03-08 10:53:55.774',
    25000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '2701bac2-3051-48f1-bf42-4aa050cc02c3',
    NULL,
    'Ikan Mas Bakar',
    '2025-03-08 10:50:42.978',
    '2025-03-08 10:50:42.978',
    21000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '96ecd2ac-f117-46e1-bd66-3abf3275e0bb',
    NULL,
    'Puyuh Penyet Sambel Ijo',
    '2025-03-08 10:49:37.778',
    '2025-03-08 10:49:37.778',
    22000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '9b867c52-2262-43e0-b4f0-4d9c2a06333a',
    NULL,
    'Ikan Mas Goreng',
    '2025-03-08 10:50:31.251',
    '2025-03-08 10:50:31.251',
    20000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '9e797cad-1f67-4bf8-8582-5e12593d5f27',
    NULL,
    'Ikan Gurame Bakar 1/2 Kg',
    '2025-03-08 10:51:35.447',
    '2025-03-08 10:51:35.447',
    65000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    '9f3fc8d1-8eb9-4ca5-bb55-1766136f0b54',
    NULL,
    'Ikan Gurame Goreng',
    '2025-03-08 10:51:46.830',
    '2025-03-08 10:51:46.830',
    40000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'ad496db4-84a6-4574-b2ad-b74b0f83b601',
    NULL,
    'Puyuh Penyet Sambel Ceurik',
    '2025-03-08 10:49:53.842',
    '2025-03-08 10:49:53.842',
    22000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'b11ab8db-f67b-4c0a-8073-21f381785a09',
    NULL,
    'Ikan Nila Bakar',
    '2025-03-08 10:50:13.522',
    '2025-03-08 10:50:13.522',
    21000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'b2f68eea-2577-4f83-b353-27ab7b2b6293',
    NULL,
    'Ayam Saos Padang',
    '2025-03-08 10:46:17.886',
    '2025-03-08 10:46:17.886',
    18000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'd3110b40-a349-49c8-93f3-3175a03ab1e9',
    NULL,
    'Puyuh Goreng',
    '2025-03-08 10:46:38.646',
    '2025-03-08 10:46:38.646',
    20000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'd73a98fd-dcc6-4bac-930f-56cf045692e3',
    NULL,
    'Ayam Bakar Madu',
    '2025-03-08 10:46:08.129',
    '2025-03-08 10:46:08.129',
    18000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'd800c21f-ca9a-46b8-810d-bff8052412ad',
    NULL,
    'Ikan Gurame Bakar',
    '2025-03-08 10:53:14.096',
    '2025-03-08 10:53:14.096',
    45000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'e05fdf8d-5d51-42ea-b3ed-0d66bdf5e672',
    NULL,
    'Ikan Nila Goreng',
    '2025-03-08 10:50:04.016',
    '2025-03-08 10:50:04.016',
    20000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'ebb8670e-872b-4905-a87d-9dea33185e29',
    NULL,
    'Ikan Gurame Saos Padang',
    '2025-03-08 10:53:27.421',
    '2025-03-08 10:53:27.421',
    45000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'ef89febb-4bbd-44ed-a0f5-a748a299213b',
    NULL,
    'Ayam Goreng',
    '2025-03-08 10:45:44.025',
    '2025-03-08 10:45:44.025',
    17000.000000000000000000000000000000,
    1
  );
INSERT INTO
  `products` (
    `id`,
    `image`,
    `name`,
    `created_at`,
    `updated_at`,
    `price`,
    `is_active`
  )
VALUES
  (
    'f093465c-460a-42db-81a2-e31955e9cdaa',
    NULL,
    'Ayam Penyet',
    '2025-03-08 10:46:27.668',
    '2025-03-08 10:46:27.668',
    18000.000000000000000000000000000000,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `name`,
    `role`,
    `email`,
    `password`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '0eb645b1-e6bb-4a72-8d5f-5addfef83490',
    'analytics Guy',
    'ANALYTICS',
    'analytics@gmail.com',
    '$2b$10$JZnOBsuLmN8ZyV1Bg1c5j.n0gKwaCdGKiAAk3UQLG.8yy0PKqLmQe',
    '2025-03-08 10:44:35.811',
    '2025-03-08 10:44:35.811'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `role`,
    `email`,
    `password`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    '907b8116-163c-4ce1-a76f-46d5274d29d6',
    'Cashier Guy',
    'CASHIER',
    'cashier@gmail.com',
    '$2b$10$JobH6MgsaFJ2euJB/bLWWOrvIzVPUu.i2MSyqqHQQdB8pttZfO4TW',
    '2025-03-08 10:44:35.811',
    '2025-03-08 10:44:35.811'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `role`,
    `email`,
    `password`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'd5e21dda-60b3-4776-bedd-c79e49263120',
    'Admin Man',
    'ADMIN',
    'admin@gmail.com',
    '$2b$10$GCZX5l5TRX59JLp4inJkHufAKDKlHv7OrQJSSmf/MoVOaWdVkEQgK',
    '2025-03-08 10:44:35.811',
    '2025-03-08 10:44:35.811'
  );
INSERT INTO
  `users` (
    `id`,
    `name`,
    `role`,
    `email`,
    `password`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    'ef192c6a-3972-4fe5-9aac-0ae654b8883d',
    'Inventory Manager',
    'INVENTORY',
    'inventory@gmail.com',
    '$2b$10$oLwrGAKdnyVjsMLxirGYD.WDiXhqJ2E9BYvKhKxCiB3B25vtd639G',
    '2025-03-08 10:44:35.811',
    '2025-03-08 10:44:35.811'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
