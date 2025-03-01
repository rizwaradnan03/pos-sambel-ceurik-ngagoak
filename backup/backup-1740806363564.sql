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
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employee_salary_pays
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employee_salary_pays` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_payed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `amount` decimal(65, 30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_salary_pays_employee_id_fkey` (`employee_id`),
  CONSTRAINT `employee_salary_pays_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE
  SET
  NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employees
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employees` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('CASHIER', 'CHEF') COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` decimal(65, 30) NOT NULL,
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
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL,
  `avgCostPerUnit` decimal(65, 30) NOT NULL DEFAULT '0.000000000000000000000000000000',
  `unitOfMeasure` enum('G', 'ML', 'PCS') COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `paymentType` enum('CASH', 'CARD', 'TRANSFER') COLLATE utf8mb4_unicode_ci NOT NULL,
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
    '11eb5706-f6a6-4246-a414-caf511005386',
    'f172d646df96c519ede083e704d05c38ec9f5572ee8f1f510224909d86a2809d',
    '2025-02-22 22:26:18.183',
    '20250222222618_',
    NULL,
    NULL,
    '2025-02-22 22:26:18.035',
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
    '3559b6b5-971c-4a3a-aa85-f988c3c30fed',
    'f9ee5b30a7ebc9ca24e18c3a9c7b457017bda80680abf8e1f2f7492f756e1896',
    '2025-02-24 07:54:19.761',
    '20250224075417_',
    NULL,
    NULL,
    '2025-02-24 07:54:17.934',
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
    '392e8348-4436-470a-a22f-a132cd3acadf',
    '9f866337c1104eb95e672c588ebf2aebf0d0bcbd232deaede9f3db1bbca02112',
    '2025-02-25 04:27:19.196',
    '20250225042718_',
    NULL,
    NULL,
    '2025-02-25 04:27:18.976',
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
    '4004036f-3f44-4d9f-9183-dcf9e57ce680',
    '9d56adaeb26984a645148410d6ca4becdd4fba1af4e6ed8f69718bc02dab4783',
    '2025-02-25 05:21:46.959',
    '20250225052146_',
    NULL,
    NULL,
    '2025-02-25 05:21:46.887',
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
    '57d3c74d-973e-430b-ae7e-955512f5662a',
    '052613b194fd09228f411cfaae9455a5cdb2607ded228ef3ef866e8fe9a94238',
    '2025-02-26 15:14:04.833',
    '20250226151403_',
    NULL,
    NULL,
    '2025-02-26 15:14:03.894',
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
    '58ac6e67-c497-4ee9-bcc8-6c008bf2e983',
    '0026448ce9e9ad184e27e45c9fb1e5b00066bf5772d3b57795aa5e977dd37e27',
    '2025-02-24 11:46:16.135',
    '20250224114615_',
    NULL,
    NULL,
    '2025-02-24 11:46:15.927',
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
    '83536209-4a5a-4a2e-99e3-4fd50ee00337',
    '3ffa4c44eae09455b3ee593f681e5a5dada591cbb783766bc69b153ffb58684d',
    '2025-02-26 15:06:33.967',
    '20250226150633_',
    NULL,
    NULL,
    '2025-02-26 15:06:33.751',
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
    '874325b9-908f-4b70-be4d-a7c7dad53759',
    '51deaea97462a73a6078b1ee5005602ebafa2a2c7fa793b248e2c2e5d78d9c5b',
    '2025-02-22 22:44:06.870',
    '20250222224406_',
    NULL,
    NULL,
    '2025-02-22 22:44:06.226',
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
    '9a0909f7-223e-4f91-b488-0a608c267ca1',
    'e6df07f51e26a845106d4df851f8f92537f4d7c3b3751c0ca58efda0e73bcd9c',
    '2025-02-27 03:46:11.095',
    '20250227034610_',
    NULL,
    NULL,
    '2025-02-27 03:46:10.765',
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
    'bba9bd39-eb72-496c-8a0f-31b154238078',
    '4b8a4464f0f57a566d3e81e4d00676ce14f4bad2bc469aff8fb81b8baa382ddf',
    '2025-02-22 22:02:28.984',
    '20250222220228_',
    NULL,
    NULL,
    '2025-02-22 22:02:28.348',
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
    'cae48f72-f29e-4928-8456-f1b3cc2ef58a',
    '22b3d5ea5a1611767761741a78c4f6ed38331aa570b592452e53bcf2f8335fa3',
    '2025-02-22 12:28:35.457',
    '20250222122833_',
    NULL,
    NULL,
    '2025-02-22 12:28:33.315',
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
    'e84736a9-9a32-46e2-b124-6b7e69a34ac1',
    '489879b425882d81788321d37f875c271587f57446ac854e7b841a91e38e22fe',
    '2025-02-22 22:21:59.566',
    '20250222222159_',
    NULL,
    NULL,
    '2025-02-22 22:21:59.041',
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
    'f164d7fb-53ad-4a67-83fc-6cd39dd9b8a8',
    '8a9766a75783766a27b7e2e752388d17012f6188d6cbc8e209d5ea2662e5bdf2',
    '2025-02-25 22:57:28.074',
    '20250225225727_',
    NULL,
    NULL,
    '2025-02-25 22:57:27.974',
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
    'f38a93a9-1e7e-452e-afc7-3bc68d01b4da',
    '196b475baba0e7698406d75e5b6e3d3387d08dcc53d024da43210a65607aae44',
    '2025-02-25 00:17:05.953',
    '20250225001705_',
    NULL,
    NULL,
    '2025-02-25 00:17:05.495',
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
    'fe6d8ca9-1fa2-484b-9ca9-2973036337e5',
    'c632fe7573768b62993d5837ed79267010a30c050fc9c97e3873d958be3cd472',
    '2025-02-26 07:09:11.652',
    '20250226070910_',
    NULL,
    NULL,
    '2025-02-26 07:09:10.658',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: categories
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employee_salary_pays
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
    '14d1dad0-54ba-4e25-95b3-2a2c7371a1d0',
    'analytics Guy',
    'ANALYTICS',
    'analytics@gmail.com',
    '$2b$10$4QtpoH/Y34fX8la.5ZQ71e3q3szKoLU8CYL7SiL.wLAr2IKVh9bh2',
    '2025-02-25 14:52:27.115',
    '2025-02-25 14:52:27.115'
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
    '38643dc3-d009-4cb5-a689-3c821480bf60',
    'Inventory Manager',
    'INVENTORY',
    'inventory@gmail.com',
    '$2b$10$vHraUH6sksUgXRA2MXLPfuI8HhtOo.0ufX8aLYWdUQhGY02Xvx862',
    '2025-02-25 14:52:27.115',
    '2025-02-25 14:52:27.115'
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
    '769dce53-16e6-44dc-b8ea-3b187f0d7313',
    'Cashier Guy',
    'CASHIER',
    'cashier@gmail.com',
    '$2b$10$nGmyNRN.63lPrsUCLyi6au/w3otbAD8RBfd5fFU4X0hNMeL8voN1i',
    '2025-02-25 14:52:27.115',
    '2025-02-25 14:52:27.115'
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
    '8a163de1-94c2-4559-b285-c97333103e9b',
    'Admin Man',
    'ADMIN',
    'admin@gmail.com',
    '$2b$10$JbXiedwhONtCqlBvsAkwH.uO4KXHH9at7DAn8uhs1zz2uIWgqAGau',
    '2025-02-25 14:52:27.115',
    '2025-02-25 14:52:27.115'
  );

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_ingredient_create
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_ingredient_create;
DELIMITER ;;
CREATE TRIGGER `after_ingredient_create` AFTER INSERT ON `ingredients` FOR EACH ROW BEGIN
	INSERT INTO log_ingredients (id, ingredient_id, description, created_at, updated_at)
	VALUES (UUID(), NEW.id, CONCAT("Stock ", NEW.name, " Telah Ditambahkan Sebanyak ", NEW.stock), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_ingredient_insert
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_ingredient_insert;
DELIMITER ;;
CREATE TRIGGER `after_ingredient_insert` AFTER INSERT ON `ingredients` FOR EACH ROW BEGIN
    INSERT INTO log_ingredients (id, ingredient_id, description, created_at, updated_at)
    VALUES (UUID(), NEW.id, CONCAT("(CREATE) Stock ", NEW.name, " ditambahkan sebanyak ", NEW.stock, " ", NEW.unitOfMeasure), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_ingredient_update
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_ingredient_update;
DELIMITER ;;
CREATE TRIGGER `after_ingredient_update` AFTER UPDATE ON `ingredients` FOR EACH ROW BEGIN
    INSERT INTO log_ingredients (id, ingredient_id, description, created_at, updated_at)
    VALUES (UUID(), NEW.id, CONCAT("(UPDATE) Stock ", NEW.name, " diperbarui menjadi ", NEW.stock, " ", NEW.unitOfMeasure), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_ingredient_delete
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_ingredient_delete;
DELIMITER ;;
CREATE TRIGGER `after_ingredient_delete` AFTER DELETE ON `ingredients` FOR EACH ROW BEGIN
    INSERT INTO log_ingredients (id, ingredient_id, description, created_at, updated_at)
    VALUES (UUID(), OLD.id, CONCAT("(DELETE) Stock ", OLD.name, " dihapus dengan sisa ", OLD.stock, " ", OLD.unitOfMeasure), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_order_insert
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_order_insert;
DELIMITER ;;
CREATE TRIGGER `after_order_insert` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    INSERT INTO log_orders (id, order_id, description, created_at, updated_at)
    VALUES (UUID(), NEW.id, CONCAT("(CREATE) Order baru dibuat dengan total harga Rp", NEW.totalPrice), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_order_update
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_order_update;
DELIMITER ;;
CREATE TRIGGER `after_order_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    INSERT INTO log_orders (id, order_id, description, created_at, updated_at)
    VALUES (UUID(), NEW.id, CONCAT("(UPDATE) Order diperbarui dengan total harga Rp", NEW.totalPrice), NOW(), NOW());
END;;
DELIMITER ;

# ------------------------------------------------------------
# TRIGGER DUMP FOR: after_order_delete
# ------------------------------------------------------------

DROP TRIGGER IF EXISTS after_order_delete;
DELIMITER ;;
CREATE TRIGGER `after_order_delete` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
    INSERT INTO log_orders (id, order_id, description, created_at, updated_at)
    VALUES (UUID(), OLD.id, CONCAT("(DELETE) Order dengan total harga Rp", OLD.totalPrice, " dihapus"), NOW(), NOW());
END;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
