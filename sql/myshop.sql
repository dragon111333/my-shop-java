/*
 Navicat Premium Data Transfer

 Source Server         : Thewin
 Source Server Type    : MySQL
 Source Server Version : 100411
 Source Host           : localhost:3306
 Source Schema         : myshop

 Target Server Type    : MySQL
 Target Server Version : 100411
 File Encoding         : 65001

 Date: 21/08/2020 21:19:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_bill
-- ----------------------------
DROP TABLE IF EXISTS `tb_bill`;
CREATE TABLE `tb_bill`  (
  `bill_id` int(20) NOT NULL AUTO_INCREMENT,
  `bill_sum` decimal(10, 2) NULL DEFAULT NULL,
  `bill_profit` decimal(10, 2) NULL DEFAULT NULL,
  `time_reg` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_bill
-- ----------------------------
INSERT INTO `tb_bill` VALUES (26, 500.00, 54.00, '2020-06-20 00:25:59');
INSERT INTO `tb_bill` VALUES (27, 522.00, 4.00, '2020-06-20 00:26:47');
INSERT INTO `tb_bill` VALUES (28, 100.00, 6.00, '2020-06-20 00:33:21');
INSERT INTO `tb_bill` VALUES (29, 50.00, 6.00, '2020-06-20 00:43:12');
INSERT INTO `tb_bill` VALUES (30, 43.00, 3.00, '2020-06-20 00:45:18');
INSERT INTO `tb_bill` VALUES (31, 90.00, 0.00, '2020-06-20 00:47:14');
INSERT INTO `tb_bill` VALUES (32, 9.00, 8.00, '2020-06-20 00:56:57');
INSERT INTO `tb_bill` VALUES (33, 48.00, 5.00, '2020-06-20 01:03:27');
INSERT INTO `tb_bill` VALUES (34, 156.00, 83.00, '2020-06-20 01:23:21');
INSERT INTO `tb_bill` VALUES (35, 99.00, 4.00, '2020-06-20 09:56:54');
INSERT INTO `tb_bill` VALUES (36, 641.00, 4.00, '2020-06-22 14:28:13');
INSERT INTO `tb_bill` VALUES (37, 518.00, 4.00, '2020-06-23 15:54:12');
INSERT INTO `tb_bill` VALUES (38, 591.00, 7.00, '2020-06-23 18:26:56');
INSERT INTO `tb_bill` VALUES (39, 62.00, 1.80, '2020-06-23 20:52:42');
INSERT INTO `tb_bill` VALUES (40, 85.00, 5.00, '2020-06-23 22:49:49');
INSERT INTO `tb_bill` VALUES (41, 23.00, 2.80, '2020-06-23 23:15:00');
INSERT INTO `tb_bill` VALUES (42, 17.00, 2.00, '2020-06-23 23:16:49');
INSERT INTO `tb_bill` VALUES (43, 78.00, 80.00, '2020-06-24 16:21:41');
INSERT INTO `tb_bill` VALUES (44, 7.50, 41.00, '2020-06-24 16:21:52');
INSERT INTO `tb_bill` VALUES (49, 56.00, 6.00, '2020-06-25 18:32:56');
INSERT INTO `tb_bill` VALUES (50, 112.00, 7.00, '2020-06-25 23:30:49');
INSERT INTO `tb_bill` VALUES (51, 164.00, 4.00, '2020-06-26 01:29:25');
INSERT INTO `tb_bill` VALUES (52, 32.00, 2.00, '2020-06-26 15:59:24');
INSERT INTO `tb_bill` VALUES (53, 322.00, 11.60, '2020-06-27 23:20:49');
INSERT INTO `tb_bill` VALUES (54, 204.00, 13.80, '2020-06-29 16:16:49');
INSERT INTO `tb_bill` VALUES (55, 164.00, 9.00, '2020-06-29 16:17:01');
INSERT INTO `tb_bill` VALUES (56, 129.00, 9.00, '2020-07-04 13:39:58');
INSERT INTO `tb_bill` VALUES (57, 80.00, 3.00, '2020-07-08 08:38:14');
INSERT INTO `tb_bill` VALUES (58, 48.00, 4.00, '2020-07-16 10:01:18');
INSERT INTO `tb_bill` VALUES (59, 84.00, 3.00, '2020-07-16 10:01:31');
INSERT INTO `tb_bill` VALUES (60, 155.00, 5.00, '2020-07-26 20:59:27');
INSERT INTO `tb_bill` VALUES (61, 107.00, 7.00, '2020-07-26 21:04:41');
INSERT INTO `tb_bill` VALUES (62, 49.00, 17.00, '2020-08-19 18:13:12');
INSERT INTO `tb_bill` VALUES (63, 106.00, 11.80, '2020-08-20 01:16:34');
INSERT INTO `tb_bill` VALUES (64, 12.00, 1.00, '2020-08-20 09:54:09');
INSERT INTO `tb_bill` VALUES (65, 12.00, 1.00, '2020-08-20 09:55:32');
INSERT INTO `tb_bill` VALUES (66, 68.00, 7.00, '2020-08-20 10:05:43');
INSERT INTO `tb_bill` VALUES (67, 12.00, 1.00, '2020-08-20 10:14:36');
INSERT INTO `tb_bill` VALUES (68, 12.00, 1.00, '2020-08-20 10:15:06');
INSERT INTO `tb_bill` VALUES (69, 58.00, 3.00, '2020-08-20 10:15:49');
INSERT INTO `tb_bill` VALUES (70, 321.00, 46.00, '2020-08-20 23:01:11');
INSERT INTO `tb_bill` VALUES (71, 112.00, 12.00, '2020-08-20 23:02:10');
INSERT INTO `tb_bill` VALUES (72, 36.00, 3.00, '2020-08-21 00:33:57');

-- ----------------------------
-- Table structure for tb_bill_det
-- ----------------------------
DROP TABLE IF EXISTS `tb_bill_det`;
CREATE TABLE `tb_bill_det`  (
  `bill_det_id` int(20) NOT NULL AUTO_INCREMENT,
  `bill_id` int(20) NOT NULL,
  `item_id` int(20) NOT NULL,
  PRIMARY KEY (`bill_det_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  INDEX `bill_id`(`bill_id`) USING BTREE,
  CONSTRAINT `tb_bill_det_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_bill_det_ibfk_2` FOREIGN KEY (`bill_id`) REFERENCES `tb_bill` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_bill_det
-- ----------------------------
INSERT INTO `tb_bill_det` VALUES (58, 26, 6);
INSERT INTO `tb_bill_det` VALUES (59, 26, 6);
INSERT INTO `tb_bill_det` VALUES (60, 26, 6);
INSERT INTO `tb_bill_det` VALUES (61, 26, 6);
INSERT INTO `tb_bill_det` VALUES (62, 26, 6);
INSERT INTO `tb_bill_det` VALUES (63, 26, 6);
INSERT INTO `tb_bill_det` VALUES (64, 26, 6);
INSERT INTO `tb_bill_det` VALUES (65, 26, 6);
INSERT INTO `tb_bill_det` VALUES (66, 26, 6);
INSERT INTO `tb_bill_det` VALUES (67, 26, 6);
INSERT INTO `tb_bill_det` VALUES (68, 27, 7);
INSERT INTO `tb_bill_det` VALUES (69, 27, 5);
INSERT INTO `tb_bill_det` VALUES (74, 28, 6);
INSERT INTO `tb_bill_det` VALUES (75, 28, 5);
INSERT INTO `tb_bill_det` VALUES (76, 28, 7);
INSERT INTO `tb_bill_det` VALUES (77, 28, 7);
INSERT INTO `tb_bill_det` VALUES (78, 29, 5);
INSERT INTO `tb_bill_det` VALUES (79, 30, 13);
INSERT INTO `tb_bill_det` VALUES (93, 32, 5);
INSERT INTO `tb_bill_det` VALUES (95, 32, 7);
INSERT INTO `tb_bill_det` VALUES (96, 32, 13);
INSERT INTO `tb_bill_det` VALUES (106, 34, 16);
INSERT INTO `tb_bill_det` VALUES (107, 34, 16);
INSERT INTO `tb_bill_det` VALUES (108, 34, 14);
INSERT INTO `tb_bill_det` VALUES (109, 35, 14);
INSERT INTO `tb_bill_det` VALUES (110, 35, 13);
INSERT INTO `tb_bill_det` VALUES (111, 36, 14);
INSERT INTO `tb_bill_det` VALUES (112, 36, 7);
INSERT INTO `tb_bill_det` VALUES (113, 36, 5);
INSERT INTO `tb_bill_det` VALUES (114, 37, 10);
INSERT INTO `tb_bill_det` VALUES (115, 37, 6);
INSERT INTO `tb_bill_det` VALUES (116, 37, 10);
INSERT INTO `tb_bill_det` VALUES (117, 37, 10);
INSERT INTO `tb_bill_det` VALUES (118, 38, 7);
INSERT INTO `tb_bill_det` VALUES (119, 38, 10);
INSERT INTO `tb_bill_det` VALUES (120, 38, 5);
INSERT INTO `tb_bill_det` VALUES (121, 39, 10);
INSERT INTO `tb_bill_det` VALUES (122, 39, 14);
INSERT INTO `tb_bill_det` VALUES (124, 40, 7);
INSERT INTO `tb_bill_det` VALUES (125, 41, 17);
INSERT INTO `tb_bill_det` VALUES (126, 41, 10);
INSERT INTO `tb_bill_det` VALUES (127, 42, 17);
INSERT INTO `tb_bill_det` VALUES (129, 43, 18);
INSERT INTO `tb_bill_det` VALUES (130, 43, 6);
INSERT INTO `tb_bill_det` VALUES (131, 43, 18);
INSERT INTO `tb_bill_det` VALUES (132, 44, 16);
INSERT INTO `tb_bill_det` VALUES (138, 49, 5);
INSERT INTO `tb_bill_det` VALUES (139, 50, 14);
INSERT INTO `tb_bill_det` VALUES (140, 50, 5);
INSERT INTO `tb_bill_det` VALUES (141, 51, 7);
INSERT INTO `tb_bill_det` VALUES (142, 51, 14);
INSERT INTO `tb_bill_det` VALUES (143, 51, 14);
INSERT INTO `tb_bill_det` VALUES (144, 52, 18);
INSERT INTO `tb_bill_det` VALUES (145, 52, 18);
INSERT INTO `tb_bill_det` VALUES (146, 53, 10);
INSERT INTO `tb_bill_det` VALUES (147, 53, 14);
INSERT INTO `tb_bill_det` VALUES (148, 53, 10);
INSERT INTO `tb_bill_det` VALUES (149, 53, 14);
INSERT INTO `tb_bill_det` VALUES (150, 53, 14);
INSERT INTO `tb_bill_det` VALUES (151, 53, 14);
INSERT INTO `tb_bill_det` VALUES (152, 53, 13);
INSERT INTO `tb_bill_det` VALUES (153, 53, 13);
INSERT INTO `tb_bill_det` VALUES (154, 54, 5);
INSERT INTO `tb_bill_det` VALUES (155, 54, 10);
INSERT INTO `tb_bill_det` VALUES (156, 54, 13);
INSERT INTO `tb_bill_det` VALUES (157, 54, 13);
INSERT INTO `tb_bill_det` VALUES (158, 54, 14);
INSERT INTO `tb_bill_det` VALUES (159, 55, 5);
INSERT INTO `tb_bill_det` VALUES (160, 55, 7);
INSERT INTO `tb_bill_det` VALUES (161, 55, 14);
INSERT INTO `tb_bill_det` VALUES (162, 56, 13);
INSERT INTO `tb_bill_det` VALUES (163, 56, 13);
INSERT INTO `tb_bill_det` VALUES (164, 56, 13);
INSERT INTO `tb_bill_det` VALUES (165, 57, 16);
INSERT INTO `tb_bill_det` VALUES (166, 57, 16);
INSERT INTO `tb_bill_det` VALUES (167, 57, 14);
INSERT INTO `tb_bill_det` VALUES (168, 58, 16);
INSERT INTO `tb_bill_det` VALUES (169, 58, 16);
INSERT INTO `tb_bill_det` VALUES (170, 58, 16);
INSERT INTO `tb_bill_det` VALUES (171, 58, 16);
INSERT INTO `tb_bill_det` VALUES (172, 59, 16);
INSERT INTO `tb_bill_det` VALUES (173, 59, 18);
INSERT INTO `tb_bill_det` VALUES (174, 59, 14);
INSERT INTO `tb_bill_det` VALUES (175, 60, 14);
INSERT INTO `tb_bill_det` VALUES (176, 60, 13);
INSERT INTO `tb_bill_det` VALUES (177, 60, 14);
INSERT INTO `tb_bill_det` VALUES (178, 61, 17);
INSERT INTO `tb_bill_det` VALUES (179, 61, 17);
INSERT INTO `tb_bill_det` VALUES (180, 61, 17);
INSERT INTO `tb_bill_det` VALUES (181, 61, 14);
INSERT INTO `tb_bill_det` VALUES (182, 62, 16);
INSERT INTO `tb_bill_det` VALUES (183, 62, 16);
INSERT INTO `tb_bill_det` VALUES (184, 62, 22);
INSERT INTO `tb_bill_det` VALUES (185, 63, 24);
INSERT INTO `tb_bill_det` VALUES (186, 63, 10);
INSERT INTO `tb_bill_det` VALUES (187, 64, 16);
INSERT INTO `tb_bill_det` VALUES (188, 65, 16);
INSERT INTO `tb_bill_det` VALUES (189, 66, 16);
INSERT INTO `tb_bill_det` VALUES (190, 66, 5);
INSERT INTO `tb_bill_det` VALUES (191, 67, 16);
INSERT INTO `tb_bill_det` VALUES (192, 68, 16);
INSERT INTO `tb_bill_det` VALUES (193, 69, 20);
INSERT INTO `tb_bill_det` VALUES (194, 70, 5);
INSERT INTO `tb_bill_det` VALUES (195, 70, 5);
INSERT INTO `tb_bill_det` VALUES (196, 70, 5);
INSERT INTO `tb_bill_det` VALUES (197, 70, 5);
INSERT INTO `tb_bill_det` VALUES (198, 70, 5);
INSERT INTO `tb_bill_det` VALUES (199, 70, 22);
INSERT INTO `tb_bill_det` VALUES (200, 70, 18);
INSERT INTO `tb_bill_det` VALUES (201, 71, 16);
INSERT INTO `tb_bill_det` VALUES (202, 71, 24);
INSERT INTO `tb_bill_det` VALUES (203, 72, 16);
INSERT INTO `tb_bill_det` VALUES (204, 72, 16);
INSERT INTO `tb_bill_det` VALUES (205, 72, 16);

-- ----------------------------
-- Table structure for tb_deptor
-- ----------------------------
DROP TABLE IF EXISTS `tb_deptor`;
CREATE TABLE `tb_deptor`  (
  `deptor_id` int(20) NOT NULL AUTO_INCREMENT,
  `deptor_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deptor_sum` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`deptor_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_deptor
-- ----------------------------
INSERT INTO `tb_deptor` VALUES (38, 'เปรม', 682.00);
INSERT INTO `tb_deptor` VALUES (39, 'วิทย์', 675.00);
INSERT INTO `tb_deptor` VALUES (40, 'จารแป', 106.00);
INSERT INTO `tb_deptor` VALUES (41, 'เทวินติดห', 102.00);

-- ----------------------------
-- Table structure for tb_deptor_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_deptor_log`;
CREATE TABLE `tb_deptor_log`  (
  `deptor_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `deptor_id` int(11) NULL DEFAULT NULL,
  `deptor_log_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deptor_log_sum` decimal(10, 0) NULL DEFAULT NULL,
  `time_reg` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`deptor_log_id`) USING BTREE,
  INDEX `deptor_id`(`deptor_id`) USING BTREE,
  CONSTRAINT `tb_deptor_log_ibfk_1` FOREIGN KEY (`deptor_id`) REFERENCES `tb_deptor` (`deptor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_deptor_log
-- ----------------------------
INSERT INTO `tb_deptor_log` VALUES (39, 38, 'ไม่บอกก็ได้', 89, '2020-08-05 01:11:25');
INSERT INTO `tb_deptor_log` VALUES (40, 39, 'ปล้น', 5656, '2020-08-10 10:33:27');
INSERT INTO `tb_deptor_log` VALUES (55, 40, 'เหล้าสี', 56, '2020-08-19 17:00:09');
INSERT INTO `tb_deptor_log` VALUES (56, 40, 'กองทิพย์', 56, '2020-08-19 17:00:32');
INSERT INTO `tb_deptor_log` VALUES (57, 40, 'จ่ายหนี้', 6, '2020-08-19 17:00:38');
INSERT INTO `tb_deptor_log` VALUES (59, 38, 'หมากฝรั่ง', 1, '2020-08-19 17:12:58');
INSERT INTO `tb_deptor_log` VALUES (60, 38, 'จ่ายหนี้', 30, '2020-08-19 17:13:10');
INSERT INTO `tb_deptor_log` VALUES (61, 39, 'จ่ายหนี้', 5000, '2020-08-20 01:10:34');
INSERT INTO `tb_deptor_log` VALUES (62, 38, 'ยาสูบ', 622, '2020-08-20 01:10:58');
INSERT INTO `tb_deptor_log` VALUES (63, 39, 'จ่ายหนี้', 1, '2020-08-20 09:59:18');
INSERT INTO `tb_deptor_log` VALUES (64, 39, 'จ่ายหนี้', 100, '2020-08-20 09:59:30');
INSERT INTO `tb_deptor_log` VALUES (65, 39, 'ทำไข่ตก 1 แผง', 120, '2020-08-20 10:00:34');
INSERT INTO `tb_deptor_log` VALUES (66, 41, 'ปล้นร้าน', 100, '2020-08-20 10:08:59');
INSERT INTO `tb_deptor_log` VALUES (67, 41, 'ี', 1, '2020-08-20 10:09:39');
INSERT INTO `tb_deptor_log` VALUES (68, 41, 'น', 1, '2020-08-20 10:09:47');

-- ----------------------------
-- Table structure for tb_import_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_import_item`;
CREATE TABLE `tb_import_item`  (
  `import_id` int(20) NOT NULL AUTO_INCREMENT,
  `item_id` int(20) NULL DEFAULT NULL,
  `import_sum` int(6) NULL DEFAULT NULL,
  `time_reg` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`import_id`) USING BTREE,
  INDEX `item_id`(`item_id`) USING BTREE,
  CONSTRAINT `tb_import_item_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `tb_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_import_item
-- ----------------------------
INSERT INTO `tb_import_item` VALUES (1, 6, 15, '2020-06-18 00:16:44');
INSERT INTO `tb_import_item` VALUES (2, 7, 5, '2020-06-18 00:16:57');
INSERT INTO `tb_import_item` VALUES (3, 7, 41, '2020-06-18 00:17:06');
INSERT INTO `tb_import_item` VALUES (5, 7, 5, '2020-06-17 01:18:04');
INSERT INTO `tb_import_item` VALUES (6, 13, 5, '2020-06-17 10:08:55');
INSERT INTO `tb_import_item` VALUES (7, 7, 5, '2020-06-17 12:10:06');
INSERT INTO `tb_import_item` VALUES (8, 7, 566, '2020-06-18 12:35:56');
INSERT INTO `tb_import_item` VALUES (9, 14, 52, '2020-06-23 18:19:57');
INSERT INTO `tb_import_item` VALUES (10, 7, 8, '2020-06-23 18:20:17');
INSERT INTO `tb_import_item` VALUES (11, 16, 54, '2020-06-29 16:36:01');
INSERT INTO `tb_import_item` VALUES (12, 18, 56, '2020-06-29 16:36:25');
INSERT INTO `tb_import_item` VALUES (13, 14, 55, '2020-07-26 21:00:36');
INSERT INTO `tb_import_item` VALUES (14, 5, 45, '2020-08-17 23:11:34');
INSERT INTO `tb_import_item` VALUES (15, 5, 52, '2020-08-20 10:04:23');
INSERT INTO `tb_import_item` VALUES (16, 24, 60, '2020-08-20 10:17:39');
INSERT INTO `tb_import_item` VALUES (17, 16, 22, '2020-08-21 01:08:18');

-- ----------------------------
-- Table structure for tb_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_item`;
CREATE TABLE `tb_item`  (
  `item_id` int(20) NOT NULL AUTO_INCREMENT,
  `item_barcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `item_cost` decimal(10, 2) NULL DEFAULT NULL,
  `item_price` decimal(10, 2) NULL DEFAULT NULL,
  `item_stock` int(5) NULL DEFAULT NULL,
  `time_reg` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`item_id`) USING BTREE,
  UNIQUE INDEX `item_barcode`(`item_barcode`) USING BTREE COMMENT 'บาร์โค้ดห้ามซ้ำ'
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_item
-- ----------------------------
INSERT INTO `tb_item` VALUES (5, 'SDFASDFSD', 'แสนคแจ๊ค', 50.00, 56.00, 90, '2020-06-15 23:12:38');
INSERT INTO `tb_item` VALUES (6, 'fsdfsdf', 'เลย์', 50.00, 56.00, 10, '2020-06-15 23:12:49');
INSERT INTO `tb_item` VALUES (7, 'fsdfsd564', 'ข้าว', 50.00, 52.00, 47, '2020-06-15 23:13:15');
INSERT INTO `tb_item` VALUES (10, 'mama555', 'มาม่า', 5.20, 6.00, 20, '2020-06-16 22:29:37');
INSERT INTO `tb_item` VALUES (13, '1358', 'หมูทอด', 40.00, 43.00, 0, '2020-06-17 00:28:06');
INSERT INTO `tb_item` VALUES (14, '88888', 'ข้าวสาร', 55.00, 56.00, 97, '2020-06-18 14:19:53');
INSERT INTO `tb_item` VALUES (16, '111', 'ปืน', 11.00, 12.00, 131, '2020-06-19 21:50:10');
INSERT INTO `tb_item` VALUES (17, '5656', 'ขนมปังรสพริกเผา', 15.00, 17.00, -3, '2020-06-23 23:14:24');
INSERT INTO `tb_item` VALUES (18, '56569', 'หมา', 15.00, 16.00, 52, '2020-06-24 16:21:10');
INSERT INTO `tb_item` VALUES (20, '8989', 'กระเพราเขียว', 55.00, 58.00, -1, '2020-06-25 23:51:35');
INSERT INTO `tb_item` VALUES (22, '3333333', 'ไข่ขี้เกี้ยม', 10.00, 25.00, -2, '2020-08-18 00:18:53');
INSERT INTO `tb_item` VALUES (24, '789', 'ข้าวหลาม', 89.00, 100.00, 58, '2020-08-20 01:15:59');
INSERT INTO `tb_item` VALUES (25, '2000', 'เทวิน', 20.00, 25.00, 0, '2020-08-20 10:03:03');

-- ----------------------------
-- Table structure for tb_sale
-- ----------------------------
DROP TABLE IF EXISTS `tb_sale`;
CREATE TABLE `tb_sale`  (
  `sale_id` int(20) NOT NULL AUTO_INCREMENT,
  `sale_count` int(10) NULL DEFAULT NULL,
  `sale_sum` decimal(10, 2) NULL DEFAULT NULL,
  `sale_profit` decimal(10, 2) NULL DEFAULT NULL,
  `sale_date` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time_reg` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`sale_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sale
-- ----------------------------
INSERT INTO `tb_sale` VALUES (12, 1, 641.00, 486.00, '2020-06-22', '2020-06-24 11:06:51');
INSERT INTO `tb_sale` VALUES (15, 2, 500.00, 126.00, '2020-06-25', '2020-06-25 23:32:00');
INSERT INTO `tb_sale` VALUES (16, 8, 1479.00, 168.00, '2020-06-20', '2020-06-26 15:36:01');
INSERT INTO `tb_sale` VALUES (17, 6, 1296.00, 350.00, '2020-06-23', '2020-06-26 15:36:14');
INSERT INTO `tb_sale` VALUES (18, 2, 196.00, 6.00, '2020-06-26', '2020-06-27 22:24:50');
INSERT INTO `tb_sale` VALUES (19, 1, 322.00, 11.60, '2020-06-27', '2020-06-27 23:21:12');
INSERT INTO `tb_sale` VALUES (20, 2, 368.00, 22.80, '2020-06-29', '2020-06-29 16:17:16');
INSERT INTO `tb_sale` VALUES (21, 1, 129.00, 9.00, '2020-07-04', '2020-07-04 13:40:32');
INSERT INTO `tb_sale` VALUES (22, 1, 80.00, 3.00, '2020-07-08', '2020-07-08 08:38:38');
INSERT INTO `tb_sale` VALUES (23, 2, 132.00, 7.00, '2020-07-16', '2020-07-16 10:01:44');
INSERT INTO `tb_sale` VALUES (25, 2, 262.00, 12.00, '2020-07-26', '2020-08-19 18:12:23');
INSERT INTO `tb_sale` VALUES (26, 1, 49.00, 17.00, '2020-08-19', '2020-08-19 18:13:44');
INSERT INTO `tb_sale` VALUES (30, 9, 713.00, 83.80, '2020-08-20', '2020-08-21 00:34:41');

SET FOREIGN_KEY_CHECKS = 1;
