/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80300
 Source Host           : localhost:3306
 Source Schema         : goods

 Target Server Type    : MySQL
 Target Server Version : 80300
 File Encoding         : 65001

 Date: 31/05/2024 15:19:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_department
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `join_data` date DEFAULT NULL,
  `bobby` varchar(100) DEFAULT NULL,
  `department` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_employee_tmp
-- ----------------------------
DROP TABLE IF EXISTS `t_employee_tmp`;
CREATE TABLE `t_employee_tmp` (
  `employee_id` int NOT NULL,
  `employee_name` varchar(30) DEFAULT NULL,
  `department_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_employee_tmp
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `t_category_id` int DEFAULT NULL,
  `t_category` varchar(30) DEFAULT NULL,
  `t_name` varchar(50) DEFAULT NULL,
  `t_price` decimal(10,2) DEFAULT NULL,
  `t_stock` int DEFAULT NULL,
  `t_upper_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_category_name` (`t_category_id`,`t_name`),
  KEY `category_part` (`t_category`(10)),
  KEY `stock_index` (`t_stock`),
  KEY `t_upper_time_index` (`t_upper_time`),
  KEY `name_index` (`t_name`),
  KEY `category_name_index` (`t_category`,`t_name`),
  KEY `category_name_index2` (`t_category`,`t_name`),
  KEY `name_stock_index` (`t_name`,`t_stock`),
  KEY `category_name_index3` (`t_category` DESC,`t_name`),
  CONSTRAINT `foreign_category` FOREIGN KEY (`t_category_id`) REFERENCES `t_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
BEGIN;
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (1, 1, '电子产品', '智能手机', 699.99, 50, '2024-01-01 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (2, 1, '电子产品', '笔记本电脑', 999.99, 30, '2024-01-05 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (3, 1, '电子产品', '平板电脑', 499.99, 20, '2024-01-10 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (4, 1, '电子产品', '耳机', 199.99, 100, '2024-01-15 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (5, 1, '电子产品', '智能手表', 299.99, 40, '2024-01-20 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (6, 2, '服装', 'T恤', 19.99, 200, '2024-02-01 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (7, 2, '服装', '牛仔裤', 49.99, 150, '2024-02-05 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (8, 2, '服装', '夹克', 79.99, 100, '2024-02-10 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (9, 2, '服装', '运动鞋', 59.99, 120, '2024-02-15 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (10, 2, '服装', '帽子', 14.99, 300, '2024-02-20 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (11, 3, '家用电器', '冰箱', 799.99, 10, '2024-03-01 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (12, 3, '家用电器', '洗衣机', 499.99, 15, '2024-03-05 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (13, 3, '家用电器', '微波炉', 149.99, 25, '2024-03-10 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (14, 3, '家用电器', '吸尘器', 199.99, 30, '2024-03-15 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (15, 3, '家用电器', '空调', 999.99, 5, '2024-03-20 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (16, 6, '食品', '巧克力', 5.99, 200, '2024-04-01 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (17, 6, '食品', '饼干', 3.49, 300, '2024-04-05 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (18, 7, '玩具', '积木', 29.99, 150, '2024-04-10 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (19, 7, '玩具', '洋娃娃', 19.99, 100, '2024-04-15 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (20, 8, '家具', '沙发', 499.99, 20, '2024-04-20 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (21, 8, '家具', '餐桌', 299.99, 15, '2024-04-25 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (22, 9, '办公用品', '打印机', 99.99, 50, '2024-05-01 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (23, 9, '办公用品', '文件夹', 9.99, 500, '2024-05-05 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (24, 10, '宠物用品', '狗粮', 49.99, 100, '2024-05-10 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (25, 10, '宠物用品', '猫砂', 29.99, 200, '2024-05-15 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (26, 11, '化妆品', '口红', 19.99, 150, '2024-06-01 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (27, 11, '化妆品', '粉底液', 29.99, 100, '2024-06-05 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (28, 12, '家居用品', '枕头', 15.99, 200, '2024-06-10 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (29, 12, '家居用品', '床单', 25.99, 150, '2024-06-15 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (30, 13, '汽车用品', '机油', 39.99, 50, '2024-06-20 14:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (31, 13, '汽车用品', '车载充电器', 9.99, 300, '2024-06-25 10:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (32, 14, '乐器', '吉他', 199.99, 30, '2024-07-01 11:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (33, 14, '乐器', '电子琴', 299.99, 20, '2024-07-05 12:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (34, 15, '健康用品', '血压计', 49.99, 80, '2024-07-10 13:00:00');
INSERT INTO `t_goods` (`id`, `t_category_id`, `t_category`, `t_name`, `t_price`, `t_stock`, `t_upper_time`) VALUES (35, 15, '健康用品', '体温计', 19.99, 200, '2024-07-15 14:00:00');
COMMIT;

-- ----------------------------
-- Table structure for t_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_category`;
CREATE TABLE `t_goods_category` (
  `id` int NOT NULL,
  `t_category` varchar(30) DEFAULT NULL,
  `t_remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_goods_category
-- ----------------------------
BEGIN;
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (1, '电子产品', '电子小工具和设备');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (2, '服装', '服饰和配件');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (3, '家用电器', '家用电器和商品');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (4, '图书', '印刷和电子书籍');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (5, '运动用品', '运动设备和服装');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (6, '食品', '各种食品和饮料');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (7, '玩具', '儿童和成人的玩具');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (8, '家具', '家庭和办公室家具');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (9, '办公用品', '办公设备和文具');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (10, '宠物用品', '宠物的食品和用品');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (11, '化妆品', '美容和护肤产品');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (12, '家居用品', '家居装饰和日用品');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (13, '汽车用品', '汽车配件和装饰');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (14, '乐器', '各种乐器和音乐设备');
INSERT INTO `t_goods_category` (`id`, `t_category`, `t_remark`) VALUES (15, '健康用品', '保健品和医疗设备');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `hobby` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_user_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_user_detail`;
CREATE TABLE `t_user_detail` (
  `user_id` int NOT NULL,
  `phone` varchar(14) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `hobby` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_user_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_user_puls
-- ----------------------------
DROP TABLE IF EXISTS `t_user_puls`;
CREATE TABLE `t_user_puls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of t_user_puls
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_partition_innodb
-- ----------------------------
DROP TABLE IF EXISTS `tbl_partition_innodb`;
CREATE TABLE `tbl_partition_innodb` (
  `id` int NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`id`)
PARTITIONS 5 */;

-- ----------------------------
-- Records of tbl_partition_innodb
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
