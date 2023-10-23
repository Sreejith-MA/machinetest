-- Adminer 4.8.1 MySQL 8.0.34-0ubuntu0.22.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `log_details`;
CREATE TABLE `log_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `ip_address` varchar(25) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `message` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `log_details` (`id`, `user_id`, `ip_address`, `status`, `message`, `file_name`, `create_at`) VALUES
(1,	1,	'1',	'rejected',	NULL,	'how are you',	NULL),
(2,	1,	'::1',	'Rejected',	'File Too Large',	'food-delivery.pdf',	'2023-10-23 08:47:56'),
(3,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest.pdf',	'2023-10-23 08:49:25'),
(4,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest.pdf',	'2023-10-23 14:20:28'),
(5,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_2.pdf',	'2023-10-23 14:21:44'),
(6,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_3.pdf',	'2023-10-23 14:45:28'),
(7,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_4.pdf',	'2023-10-23 14:46:18'),
(8,	1,	'::1',	'Rejected',	'File Too Large',	'food-delivery.pdf',	'2023-10-23 14:46:53'),
(9,	1,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest.pdf',	'2023-10-23 15:04:40'),
(10,	8,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest.pdf',	'2023-10-23 15:52:05'),
(11,	7,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest.pdf',	'2023-10-23 15:52:21'),
(12,	7,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_1.pdf',	'2023-10-23 15:54:21'),
(13,	8,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_2.pdf',	'2023-10-23 16:01:40'),
(14,	8,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_3.pdf',	'2023-10-23 16:02:17'),
(15,	8,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_4.pdf',	'2023-10-23 16:03:14'),
(16,	8,	'::1',	'Rejected',	'File Too Large',	'food-delivery.pdf',	'2023-10-23 16:04:51'),
(17,	8,	'::1',	'Rejected',	'File Too Large',	'food-delivery.pdf',	'2023-10-23 16:06:06'),
(18,	8,	'::1',	'Accepted',	'uploaded successfully',	'Resume.docx',	'2023-10-23 16:46:30'),
(19,	8,	'::1',	'Accepted',	'uploaded successfully',	'MachineTest_5.pdf',	'2023-10-23 16:48:42'),
(20,	8,	'::1',	'Accepted',	'uploaded successfully',	'Resume_1.docx',	'2023-10-23 16:49:11'),
(21,	8,	'::1',	'Accepted',	'uploaded successfully',	'Resume_2.docx',	'2023-10-23 16:50:56'),
(22,	8,	'::1',	'Accepted',	'uploaded successfully',	'Screenshot_from_2023-10-19_18-02-53.png',	'2023-10-23 16:51:15');

DROP TABLE IF EXISTS `uploads`;
CREATE TABLE `uploads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `ip_address` varchar(25) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `uploads` (`id`, `user_id`, `file_name`, `ip_address`, `created_at`) VALUES
(1,	1,	'how are you',	'1',	'0102-02-02 00:09:02'),
(2,	1,	'::1',	'MachineTest_3.pdf',	'2023-10-23 14:45:28'),
(3,	1,	'MachineTest_4.pdf',	'::1',	'2023-10-23 14:46:18'),
(4,	1,	'MachineTest.pdf',	'::1',	'2023-10-23 15:04:40'),
(5,	8,	'MachineTest.pdf',	'::1',	'2023-10-23 15:52:05'),
(6,	7,	'MachineTest.pdf',	'::1',	'2023-10-23 15:52:21'),
(7,	7,	'MachineTest_1.pdf',	'::1',	'2023-10-23 15:54:21'),
(8,	8,	'MachineTest_2.pdf',	'::1',	'2023-10-23 16:01:40'),
(9,	8,	'MachineTest_3.pdf',	'::1',	'2023-10-23 16:02:17'),
(10,	8,	'MachineTest_4.pdf',	'::1',	'2023-10-23 16:03:14'),
(11,	8,	'Resume.docx',	'::1',	'2023-10-23 16:46:30'),
(12,	8,	'MachineTest_5.pdf',	'::1',	'2023-10-23 16:48:42'),
(13,	8,	'Resume_1.docx',	'::1',	'2023-10-23 16:49:11'),
(14,	8,	'Resume_2.docx',	'::1',	'2023-10-23 16:50:56'),
(15,	8,	'Screenshot_from_2023-10-19_18-02-53.png',	'::1',	'2023-10-23 16:51:15');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `username`, `password`, `created_at`) VALUES
(7,	'sreejith@gmail.com',	'$2y$10$NPFAJmU38ve5cNdCt4uY..Qq4swhrrBiRWr4gcCoSKgFTqgXzYvqa',	'2023-10-23 00:18:21'),
(8,	'sree@gmail.com',	'$2y$10$biPLB7k1w1IbkMhwysdSZ.jj6EPdhI1ZFCcUnqPN5zx4AMwm4.VU.',	'2023-10-23 10:20:22');

-- 2023-10-23 11:29:00
