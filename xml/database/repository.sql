/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50513
Source Host           : localhost:3306
Source Database       : repository

Target Server Type    : MYSQL
Target Server Version : 50513
File Encoding         : 65001

Date: 2015-10-29 17:36:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_customers
-- ----------------------------
DROP TABLE IF EXISTS `t_customers`;
CREATE TABLE `t_customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商id',
  `customer_name` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '供应商名称',
  `customer_contact` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系人',
  `customer_tel` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `customer_address` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `customer_other` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `customer_addtime` datetime DEFAULT NULL,
  `state` int(2) NOT NULL DEFAULT '1' COMMENT '是否删除，1:正常，0：删除',
  `customer_type` int(2) DEFAULT '0' COMMENT '供应商，还是消费',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_customers
-- ----------------------------
INSERT INTO `t_customers` VALUES ('1', 'lxf', 'ss', '12345678', '刚刚', '', '2015-10-15 13:50:17', '1', null);
INSERT INTO `t_customers` VALUES ('2', 'lxf62', 'ckl62', null, null, null, '2015-10-15 13:50:21', '1', null);
INSERT INTO `t_customers` VALUES ('3', 'lxf61', 'ckl61', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('4', 'lxf60', 'ckl60', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('5', 'lxf59', 'ckl59', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('6', 'lxf58', 'ckl58', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('7', 'lxf57', 'ckl57', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('8', 'lxf56', 'ckl56', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('10', 'lxf54', 'ckl54', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('11', 'lxf53', 'ckl53', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('12', 'lxf52', 'ckl52', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('13', 'lxf51', 'ckl51', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('14', 'lxf50', 'ckl50', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('15', 'lxf49', 'ckl49', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('16', 'lxf48', 'ckl48', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('17', 'lxf47', 'ckl47', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('18', 'lxf46', 'ckl46', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('19', 'lxf45', 'ckl45', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('20', 'lxf44', 'ckl44', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('21', 'lxf43', 'ckl43', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('22', 'lxf42', 'ckl42', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('23', 'lxf41', 'ckl41', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('24', 'lxf40', 'ckl40', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('26', 'lxf38', 'ckl38', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('28', 'lxf36', 'ckl36', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('29', 'lxf35', 'ckl35', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('31', 'lxf33', 'ckl33', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('32', 'lxf32', 'ckl32', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('33', 'lxf31', 'ckl31', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('34', 'lxf30', 'ckl30', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('35', 'lxf29', 'ckl29', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('37', 'lxf27', 'ckl27', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('39', 'lxf25', 'ckl25', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('40', 'lxf24', 'ckl24', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('42', 'lxf22', 'ckl22', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('44', '45', 'ckl20', '', '', '', null, '0', null);
INSERT INTO `t_customers` VALUES ('51', 'lxf13', 'ckl13', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('52', 'lxf12', 'ckl12', null, null, null, null, '1', null);
INSERT INTO `t_customers` VALUES ('53', 'lxf11', 'ckl11', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('54', 'lxf10', 'ckl10', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('56', 'lxf8', 'ckl8', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('60', 'lxf4', 'ckl4', null, null, null, null, '0', null);
INSERT INTO `t_customers` VALUES ('64', 'kjh', 'gh', '123456', '', '', null, '1', null);
INSERT INTO `t_customers` VALUES ('65', 'lio', '0', '0', '', '', null, '1', null);
INSERT INTO `t_customers` VALUES ('66', 'wdd', 'dd', '1234', '', '', '2015-10-11 12:33:49', '1', null);
INSERT INTO `t_customers` VALUES ('67', '???', '', '', '', '', '2015-10-29 16:52:33', '0', '0');
INSERT INTO `t_customers` VALUES ('68', '???', '', '', '', '', '2015-10-29 16:53:48', '0', '0');
INSERT INTO `t_customers` VALUES ('69', '社二哥', '', '', '', '', '2015-10-29 16:54:09', '1', '0');
INSERT INTO `t_customers` VALUES ('70', '????', '??', '', '', '', '2015-10-29 16:56:08', '0', '0');
INSERT INTO `t_customers` VALUES ('71', '水平Serbia', '三个', '', '', '', '2015-10-29 16:59:17', '1', '0');

-- ----------------------------
-- Table structure for t_orders
-- ----------------------------
DROP TABLE IF EXISTS `t_orders`;
CREATE TABLE `t_orders` (
  `order_id` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '进货id',
  `customer_id` int(11) NOT NULL COMMENT '供应商id',
  `order_date` datetime DEFAULT NULL COMMENT '出货时间',
  `state` int(2) NOT NULL DEFAULT '1' COMMENT '1可用,0删除',
  `order_type` int(2) DEFAULT '0' COMMENT '0:订单，1：出货单',
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `t_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `t_customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_orders
-- ----------------------------
INSERT INTO `t_orders` VALUES ('20151026141839', '2', '2015-10-26 14:18:39', '0', '0');
INSERT INTO `t_orders` VALUES ('20151026162918', '4', '2015-10-26 16:29:18', '0', '0');
INSERT INTO `t_orders` VALUES ('20151026162950', '3', '2015-10-26 16:29:50', '0', '0');
INSERT INTO `t_orders` VALUES ('20151026163139', '4', '2015-10-26 16:31:39', '1', '0');
INSERT INTO `t_orders` VALUES ('20151026163356', '3', '2015-10-26 16:33:56', '1', '0');
INSERT INTO `t_orders` VALUES ('20151026163432', '3', '2015-10-26 16:34:32', '1', '0');
INSERT INTO `t_orders` VALUES ('20151027095507', '3', '2015-10-27 09:55:07', '1', '0');
INSERT INTO `t_orders` VALUES ('20151029173430', '52', '2015-10-29 17:34:30', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022135949', '2', '2015-10-22 13:59:49', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151022140944', '2', '2015-10-22 14:09:44', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151022141446', '1', '2015-10-22 14:14:46', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151022141756', '3', '2015-10-22 14:17:56', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022142542', '5', '2015-10-22 14:25:42', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022142812', '5', '2015-10-22 14:28:12', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022143031', '2', '2015-10-22 14:30:31', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022164201', '51', '2015-10-22 16:42:01', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022164953', '2', '2015-10-22 16:49:53', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022165131', '4', '2015-10-22 16:51:31', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151022172615', '2', '2015-10-22 17:26:15', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151022174651', '2', '2015-10-22 17:46:51', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151022174934', '2', '2015-10-22 17:49:34', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151023090222', '2', '2015-10-23 09:02:22', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151023092734', '2', '2015-10-23 09:27:34', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151023093845', '3', '2015-10-23 09:38:45', '1', '0');
INSERT INTO `t_orders` VALUES ('dd20151023094125', '5', '2015-10-23 09:41:25', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151023094228', '2', '2015-10-23 09:42:28', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151023095207', '3', '2015-10-23 09:52:07', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151023095253', '2', '2015-10-23 09:52:53', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151023100345', '3', '2015-10-23 10:03:45', '0', '0');
INSERT INTO `t_orders` VALUES ('dd20151023165703', '1', '2015-10-23 16:57:03', '0', '0');

-- ----------------------------
-- Table structure for t_orders_products
-- ----------------------------
DROP TABLE IF EXISTS `t_orders_products`;
CREATE TABLE `t_orders_products` (
  `order_id` varchar(50) NOT NULL COMMENT '订单号',
  `product_id` int(50) NOT NULL,
  `product_num` int(10) DEFAULT '0' COMMENT '物品数量',
  `product_real_price` decimal(10,2) DEFAULT NULL,
  `real_total_cost` decimal(10,2) DEFAULT '0.00' COMMENT '实际消费',
  `state` int(2) DEFAULT '1' COMMENT '1:正常；0：删除',
  PRIMARY KEY (`product_id`,`order_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `t_orders_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_products` (`p_id`),
  CONSTRAINT `t_orders_products_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `t_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orders_products
-- ----------------------------
INSERT INTO `t_orders_products` VALUES ('20151026141839', '1', '3', '23.00', '3.00', '1');
INSERT INTO `t_orders_products` VALUES ('20151026162950', '1', '23', '23.00', '23.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151026163356', '1', '1', '12.00', '1.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151027095507', '1', '3', '2.00', '3.00', '1');
INSERT INTO `t_orders_products` VALUES ('20151029173430', '1', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022141756', '1', '11', '12.00', '11.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151022142542', '1', '1', '1.00', '1.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151022142812', '1', '23', '23.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022143031', '1', '1', '1.00', '1.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022164201', '1', '2', '2.00', '2.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151022165131', '1', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022174934', '1', '99', '99.00', '99.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151023090222', '1', '2', '1.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151023092734', '1', '2', '11.00', '1.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151023093845', '1', '3', '3.00', '3.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151023094125', '1', '3', '3.00', '3.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151023094228', '1', '3', '2.00', '2.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151023095207', '1', '4', '4.00', '4.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151023095253', '1', '2', '2.00', '2.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151023100345', '1', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151023165703', '1', '6', '34.00', '44.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151026162918', '2', '3', '3.00', '3.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151026163139', '2', '343', '34.00', '343.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151026163432', '2', '1', '12.00', '1.00', '0');
INSERT INTO `t_orders_products` VALUES ('20151029173430', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022141756', '2', '12', '12.00', '12.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022142542', '2', '12', '12.00', '1.00', '0');
INSERT INTO `t_orders_products` VALUES ('dd20151022142812', '2', '23', '23.00', '23.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022164201', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022164953', '2', '3', '3.00', '3.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022172615', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151022174651', '2', '66', '56.00', '66.00', '1');
INSERT INTO `t_orders_products` VALUES ('dd20151023090222', '2', '3', '12.00', '3.00', '0');

-- ----------------------------
-- Table structure for t_products
-- ----------------------------
DROP TABLE IF EXISTS `t_products`;
CREATE TABLE `t_products` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `p_part_no` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '件号',
  `p_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '产品名称',
  `p_total_num` int(20) DEFAULT '0' COMMENT '物品剩余量',
  `p_price` decimal(10,2) DEFAULT '0.00' COMMENT '市场价格',
  `state` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_products
-- ----------------------------
INSERT INTO `t_products` VALUES ('1', '10001', '茶叶', '0', null, '1');
INSERT INTO `t_products` VALUES ('2', '10002', '面包', '0', null, '1');

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `u_id` int(20) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(50) DEFAULT NULL,
  `u_password` varchar(50) DEFAULT NULL,
  `state` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'admin', '1');

-- ----------------------------
-- Procedure structure for pro_while
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_while`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pro_while`()
begin
declare cnum int;
set cnum = 62;
while cnum > 0 do 
	insert into suppliers (s_name,s_contact) values(concat('lxf',cnum),concat('ckl',cnum));
	set cnum = cnum - 1;
end while;
end
;;
DELIMITER ;
