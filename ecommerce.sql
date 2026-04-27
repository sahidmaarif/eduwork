-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2026 at 03:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `nama_produk` varchar(25) NOT NULL,
  `harga` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ============================================================
-- CRUD EXAMPLES FOR ECOMMERCE DATABASE
-- ============================================================

-- --------------------------------------------------------
-- USERS TABLE CRUD
-- --------------------------------------------------------

-- CREATE: Insert a new user
INSERT INTO `users` (`id`, `nama`, `email`, `password`) VALUES
(1, 'John Doe', 'john@example.com', 'password123');

-- READ: Get all users
SELECT * FROM `users`;

-- READ: Get user by id
SELECT * FROM `users` WHERE `id` = 1;

-- READ: Get user by email
SELECT * FROM `users` WHERE `email` = 'john@example.com';

-- UPDATE: Update user name
UPDATE `users` SET `nama` = 'John Smith' WHERE `id` = 1;

-- UPDATE: Update user password
UPDATE `users` SET `password` = 'newpassword456' WHERE `id` = 1;

-- DELETE: Delete user by id
DELETE FROM `users` WHERE `id` = 1;

-- --------------------------------------------------------
-- PRODUCTS TABLE CRUD
-- --------------------------------------------------------

-- CREATE: Insert a new product
INSERT INTO `products` (`id`, `nama_produk`, `harga`, `deskripsi`, `stok`) VALUES
(1, 'Laptop', 5000000, 'Laptop gaming dengan spesifikasi tinggi', 10);

-- CREATE: Insert multiple products
INSERT INTO `products` (`id`, `nama_produk`, `harga`, `deskripsi`, `stok`) VALUES
(2, 'Mouse', 150000, 'Mouse wireless ergonomis', 50),
(3, 'Keyboard', 300000, 'Keyboard mechanical RGB', 30),
(4, 'Monitor', 2000000, 'Monitor 24 inch Full HD', 15);

-- READ: Get all products
SELECT * FROM `products`;

-- READ: Get product by id
SELECT * FROM `products` WHERE `id` = 1;

-- READ: Get products with stock > 0
SELECT * FROM `products` WHERE `stok` > 0;

-- READ: Search products by name
SELECT * FROM `products` WHERE `nama_produk` LIKE '%Laptop%';

-- READ: Get products ordered by price (ascending)
SELECT * FROM `products` ORDER BY `harga` ASC;

-- READ: Get products ordered by price (descending)
SELECT * FROM `products` ORDER BY `harga` DESC;

-- READ: Get only product names and prices
SELECT `nama_produk`, `harga` FROM `products`;

-- UPDATE: Update product price
UPDATE `products` SET `harga` = 5500000 WHERE `id` = 1;

-- UPDATE: Update product stock
UPDATE `products` SET `stok` = `stok` - 1 WHERE `id` = 1;

-- UPDATE: Update product details
UPDATE `products` SET `nama_produk` = 'Laptop Pro', `harga` = 6000000, `deskripsi` = 'Laptop gaming terbaru' WHERE `id` = 1;

-- DELETE: Delete product by id
DELETE FROM `products` WHERE `id` = 1;

-- --------------------------------------------------------
-- ORDERS TABLE CRUD
-- --------------------------------------------------------

-- CREATE: Insert a new order
INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `quantity`, `total`) VALUES
(1, 1, 1, 2, 10000000);

-- CREATE: Insert multiple orders
INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `quantity`, `total`) VALUES
(2, 1, 2, 1, 150000),
(3, 1, 3, 1, 300000);

-- READ: Get all orders
SELECT * FROM `orders`;

-- READ: Get order by id
SELECT * FROM `orders` WHERE `order_id` = 1;

-- READ: Get orders by user id
SELECT * FROM `orders` WHERE `user_id` = 1;

-- READ: Get orders with user and product details (JOIN)
SELECT 
    o.order_id,
    u.nama AS customer_name,
    u.email,
    p.nama_produk,
    o.quantity,
    o.total,
    o.order_id
FROM `orders` o
JOIN `users` u ON o.user_id = u.id
JOIN `products` p ON o.product_id = p.id;

-- READ: Get total order amount by user
SELECT `user_id`, SUM(`total`) AS total_spent FROM `orders` GROUP BY `user_id`;

-- READ: Get order count by user
SELECT `user_id`, COUNT(*) AS total_orders FROM `orders` GROUP BY `user_id`;

-- UPDATE: Update order quantity
UPDATE `orders` SET `quantity` = 3, `total` = 15000000 WHERE `order_id` = 1;

-- DELETE: Delete order by id
DELETE FROM `orders` WHERE `order_id` = 1;

-- --------------------------------------------------------
-- ADVANCED CRUD EXAMPLES
-- --------------------------------------------------------

-- INSERT with subquery (copy product data)
INSERT INTO `products` (`id`, `nama_produk`, `harga`, `deskripsi`, `stok`)
SELECT 5, CONCAT(`nama_produk`, ' - Edition'), `harga` + 500000, `deskripsi`, `stok`
FROM `products` WHERE `id` = 1;

-- UPDATE with condition (reduce stock if available)
UPDATE `products` SET `stok` = `stok` - 1 WHERE `id` = 1 AND `stok` > 0;

-- DELETE with condition (delete orders for inactive users)
DELETE FROM `orders` WHERE `user_id` IN (SELECT `id` FROM `users` WHERE `email` = '');

-- Transaction example (rollback if error)
START TRANSACTION;
INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `quantity`, `total`) VALUES (10, 1, 1, 1, 5000000);
UPDATE `products` SET `stok` = `stok` - 1 WHERE `id` = 1;
COMMIT;

-- Rollback example (cancel transaction)
START TRANSACTION;
INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `quantity`, `total`) VALUES (11, 1, 2, 1, 150000);
ROLLBACK;

