/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50513
Source Host           : localhost:3306
Source Database       : repository

Target Server Type    : MYSQL
Target Server Version : 50513
File Encoding         : 65001

Date: 2016-06-06 11:57:42
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
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_customers
-- ----------------------------
INSERT INTO `t_customers` VALUES ('1', 'lxf', 'ss', '12345678', '刚刚', '', '2015-10-15 13:50:17', '1', null);
INSERT INTO `t_customers` VALUES ('2', 'lxf62', 'ckl62', '123456', null, null, '2015-10-15 13:50:21', '1', null);
INSERT INTO `t_customers` VALUES ('66', 'wdd', 'dd', '1234', '45', '4o', '2015-10-11 12:33:49', '1', null);
INSERT INTO `t_customers` VALUES ('73', 'ppp', 'ppp', '345', '142', '12', '2015-11-01 12:15:28', '1', '0');
INSERT INTO `t_customers` VALUES ('74', '你好', '你好', '123456', '你好', '你h', '2015-11-01 12:16:00', '1', '0');
INSERT INTO `t_customers` VALUES ('116', '78', '', '123456', '', '', '2015-11-05 14:18:42', '1', '0');
INSERT INTO `t_customers` VALUES ('117', '3', '4', '123456', '', '', '2015-11-05 14:36:09', '1', '0');

-- ----------------------------
-- Table structure for t_orders
-- ----------------------------
DROP TABLE IF EXISTS `t_orders`;
CREATE TABLE `t_orders` (
  `order_id` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '进货id',
  `customer_id` int(11) NOT NULL COMMENT '供应商id',
  `order_date` datetime DEFAULT NULL COMMENT '出货时间',
  `state` int(2) NOT NULL DEFAULT '1' COMMENT '1可用,0删除',
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `t_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `t_customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_orders
-- ----------------------------
INSERT INTO `t_orders` VALUES ('20151101124755', '1', '2015-11-01 12:47:55', '0');
INSERT INTO `t_orders` VALUES ('20151101125425', '2', '2015-11-01 12:54:25', '1');
INSERT INTO `t_orders` VALUES ('20151101133130', '2', '2015-11-01 13:31:30', '0');
INSERT INTO `t_orders` VALUES ('20151101133306', '2', '2015-11-01 13:33:06', '1');
INSERT INTO `t_orders` VALUES ('20151101133601', '2', '2015-11-01 13:36:01', '1');
INSERT INTO `t_orders` VALUES ('20151101134113', '2', '2015-11-01 13:41:13', '1');
INSERT INTO `t_orders` VALUES ('20151101161725', '2', '2015-11-01 16:17:25', '0');
INSERT INTO `t_orders` VALUES ('20151102085737', '1', '2015-11-02 08:57:37', '0');
INSERT INTO `t_orders` VALUES ('20151102090401', '2', '2015-11-02 09:04:01', '0');
INSERT INTO `t_orders` VALUES ('20151102091340', '1', '2015-11-02 09:13:40', '0');
INSERT INTO `t_orders` VALUES ('20151102092008', '2', '2015-11-02 09:20:08', '1');
INSERT INTO `t_orders` VALUES ('20151102092524', '1', '2015-11-02 09:25:24', '1');
INSERT INTO `t_orders` VALUES ('20151104103142', '2', '2015-11-04 10:31:42', '0');
INSERT INTO `t_orders` VALUES ('20151104160727', '1', '2015-11-04 16:07:27', '1');
INSERT INTO `t_orders` VALUES ('20151104161402', '2', '2015-11-04 16:14:02', '1');
INSERT INTO `t_orders` VALUES ('20151104161549', '2', '2015-11-04 16:15:49', '1');
INSERT INTO `t_orders` VALUES ('20151104161900', '2', '2015-11-04 16:19:00', '1');
INSERT INTO `t_orders` VALUES ('20151104162058', '1', '2015-11-04 16:20:58', '1');
INSERT INTO `t_orders` VALUES ('20151104162242', '1', '2015-11-04 16:22:42', '0');
INSERT INTO `t_orders` VALUES ('20151105141658', '1', '2015-11-05 14:16:58', '0');
INSERT INTO `t_orders` VALUES ('20151105143932', '2', '2015-11-05 14:39:32', '0');
INSERT INTO `t_orders` VALUES ('20151105144008', '2', '2015-11-05 14:40:08', '1');
INSERT INTO `t_orders` VALUES ('20151110154414', '2', '2015-11-10 15:44:14', '0');
INSERT INTO `t_orders` VALUES ('20151110154553', '2', '2015-11-10 15:45:53', '1');
INSERT INTO `t_orders` VALUES ('20151112135232', '2', '2015-11-12 13:52:32', '1');
INSERT INTO `t_orders` VALUES ('20151112135316', '2', '2015-11-12 13:53:16', '1');
INSERT INTO `t_orders` VALUES ('20151113092544', '1', '2015-11-13 09:25:44', '1');

-- ----------------------------
-- Table structure for t_orders_jhd
-- ----------------------------
DROP TABLE IF EXISTS `t_orders_jhd`;
CREATE TABLE `t_orders_jhd` (
  `order_id` varchar(50) NOT NULL COMMENT '进货单号',
  `product_id` int(50) NOT NULL,
  `product_num` int(10) DEFAULT '0' COMMENT '物品数量',
  `product_real_price` decimal(10,2) DEFAULT NULL,
  `real_total_cost` decimal(10,2) DEFAULT '0.00' COMMENT '实际消费',
  `state` int(2) DEFAULT '1' COMMENT '1:正常；0：删除',
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `t_orders_jhd_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `t_orders` (`order_id`),
  CONSTRAINT `t_orders_jhd_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `t_products` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orders_jhd
-- ----------------------------
INSERT INTO `t_orders_jhd` VALUES ('20151102085737', '1', '3', '3.00', '3.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151102085737', '2', '3', '3.00', '3.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151102085737', '3', '3', '3.00', '3.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151102091340', '1', '2', '2.00', '2.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151102092008', '3', '5', '4.00', '4.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151102092524', '1', '2', '2.00', '2.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151104160727', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151104160727', '3', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151104161402', '2', '3', '3.00', '3.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151104161549', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151104161900', '2', '2', '2.00', '2.00', '1');
INSERT INTO `t_orders_jhd` VALUES ('20151104162058', '3', '4', '4.00', '4.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151104162242', '3', '12', '12.00', '12.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151105141658', '2', '2', '2.00', '2.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151105143932', '8', '45', '45.00', '45.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151110154414', '13', '10', '10.00', '100.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151110154553', '10', '10', '34.00', '10.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151110154553', '13', '10', '10.00', '10.00', '0');
INSERT INTO `t_orders_jhd` VALUES ('20151112135316', '2', '34', '34.00', '34.00', '0');

-- ----------------------------
-- Table structure for t_orders_shd
-- ----------------------------
DROP TABLE IF EXISTS `t_orders_shd`;
CREATE TABLE `t_orders_shd` (
  `order_id` varchar(50) NOT NULL COMMENT '进货单号',
  `product_id` int(50) NOT NULL,
  `product_num` int(10) DEFAULT '0' COMMENT '物品数量',
  `product_real_price` decimal(10,2) DEFAULT NULL,
  `real_total_cost` decimal(10,2) DEFAULT '0.00' COMMENT '实际消费',
  `state` int(2) DEFAULT '1' COMMENT '1:正常；0：删除',
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `t_orders_shd_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_products` (`p_id`),
  CONSTRAINT `t_orders_shd_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `t_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orders_shd
-- ----------------------------
INSERT INTO `t_orders_shd` VALUES ('20151101133130', '2', '363', '79.00', '10.00', '1');
INSERT INTO `t_orders_shd` VALUES ('20151102090401', '1', '10', '10.00', '53.00', '0');
INSERT INTO `t_orders_shd` VALUES ('20151104103142', '1', '2', '2.00', '3.00', '1');
INSERT INTO `t_orders_shd` VALUES ('20151105144008', '3', '34', '34.00', '34.00', '1');
INSERT INTO `t_orders_shd` VALUES ('20151112135232', '3', '45', '2.00', '57.00', '0');
INSERT INTO `t_orders_shd` VALUES ('20151113092544', '3', '10', '10.00', '10.00', '1');

-- ----------------------------
-- Table structure for t_orders_td
-- ----------------------------
DROP TABLE IF EXISTS `t_orders_td`;
CREATE TABLE `t_orders_td` (
  `order_id` varchar(50) NOT NULL COMMENT '进货单号',
  `product_id` int(50) NOT NULL,
  `product_num` int(10) DEFAULT '0' COMMENT '物品数量',
  `product_real_price` decimal(10,2) DEFAULT NULL,
  `real_total_cost` decimal(10,2) DEFAULT '0.00' COMMENT '实际消费',
  `td_time` datetime DEFAULT NULL COMMENT '退单时间',
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`) USING BTREE,
  CONSTRAINT `t_orders_td_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_products` (`p_id`),
  CONSTRAINT `t_orders_td_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `t_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orders_td
-- ----------------------------
INSERT INTO `t_orders_td` VALUES ('20151104162058', '3', '4', '4.00', '4.00', '2015-11-12 13:44:00');
INSERT INTO `t_orders_td` VALUES ('20151104162242', '3', '12', '12.00', '12.00', '2015-11-10 17:23:06');
INSERT INTO `t_orders_td` VALUES ('20151105141658', '2', '2', '2.00', '2.00', '2015-11-10 17:24:39');
INSERT INTO `t_orders_td` VALUES ('20151112135316', '2', '34', '34.00', '34.00', '2015-11-12 14:53:23');

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
  PRIMARY KEY (`p_id`),
  KEY `p_part_no` (`p_part_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_products
-- ----------------------------
INSERT INTO `t_products` VALUES ('1', '10001', '茶叶', '35', '1.00', '0');
INSERT INTO `t_products` VALUES ('2', '10002', '面包', '-33', '1.00', '1');
INSERT INTO `t_products` VALUES ('3', '10003', 'stg', '-29', '13.00', '1');
INSERT INTO `t_products` VALUES ('4', '2', '2', '4', '3.00', '0');
INSERT INTO `t_products` VALUES ('5', '34', 'er', '343', '0.00', '0');
INSERT INTO `t_products` VALUES ('6', '56', '56', '0', '0.00', '0');
INSERT INTO `t_products` VALUES ('7', '34', '34', '0', '0.00', '0');
INSERT INTO `t_products` VALUES ('8', '56', '56', '0', '0.00', '1');
INSERT INTO `t_products` VALUES ('9', '78', '78', '0', '0.00', '1');
INSERT INTO `t_products` VALUES ('10', '34', '34', '0', '0.00', '1');
INSERT INTO `t_products` VALUES ('11', '3444', '344', '0', '0.00', '1');
INSERT INTO `t_products` VALUES ('12', '2', '342', '0', '0.00', '1');
INSERT INTO `t_products` VALUES ('13', '45', '45', '0', '0.00', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES ('1', 'admin', 'admin', '1');
INSERT INTO `t_users` VALUES ('2', 'lxf', 'lxf', '1');

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
DROP TRIGGER IF EXISTS `t_after_insert_on_jhd`;
DELIMITER ;;
CREATE TRIGGER `t_after_insert_on_jhd` AFTER INSERT ON `t_orders_jhd` FOR EACH ROW begin
	update t_products t
	set t.p_total_num = t.p_total_num + new.product_num
               where t.p_id = new.product_id;	
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `t_after_update_on_jhd`;
DELIMITER ;;
CREATE TRIGGER `t_after_update_on_jhd` AFTER UPDATE ON `t_orders_jhd` FOR EACH ROW begin 
	if new.state = 0/*进货，如果逻辑删除*/
		then update t_products set p_total_num = p_total_num -  new.product_num
				 where p_id = new.product_id;
	elseif new.product_num != old.product_num /*如果product_num更新，先减旧的进货量，再加新的*/
		then update t_products set p_total_num = p_total_num - old.product_num + new.product_num
				 where p_id = new.product_id;
	end if; 
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `t_after_insert_on_jhd_copy`;
DELIMITER ;;
CREATE TRIGGER `t_after_insert_on_jhd_copy` AFTER INSERT ON `t_orders_shd` FOR EACH ROW begin
	update t_products t
	set t.p_total_num = t.p_total_num - new.product_num
               where t.p_id = new.product_id;	
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `t_after_update_on_jhd_copy`;
DELIMITER ;;
CREATE TRIGGER `t_after_update_on_jhd_copy` AFTER UPDATE ON `t_orders_shd` FOR EACH ROW begin 
	if new.state = 0/*出货，如果逻辑删除*/
		then update t_products set p_total_num = p_total_num +  new.product_num
				 where p_id = new.product_id;
	elseif new.product_num != old.product_num /*如果product_num更新，先加旧的出货量，再减新的*/
		then update t_products set p_total_num = p_total_num + old.product_num - new.product_num
				 where p_id = new.product_id;
	end if; 
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `t_after_insert_on_jhd_copy_copy`;
DELIMITER ;;
CREATE TRIGGER `t_after_insert_on_jhd_copy_copy` AFTER INSERT ON `t_orders_td` FOR EACH ROW begin
	update t_products t
	set t.p_total_num = t.p_total_num - new.product_num
               where t.p_id = new.product_id;	
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `t_after_update_on_jhd_copy_copy`;
DELIMITER ;;
CREATE TRIGGER `t_after_update_on_jhd_copy_copy` AFTER UPDATE ON `t_orders_td` FOR EACH ROW begin 
	if new.state = 0/*出货，如果逻辑删除*/
		then update t_products set p_total_num = p_total_num +  new.product_num
				 where p_id = new.product_id;
	elseif new.product_num != old.product_num /*如果product_num更新，先加旧的出货量，再减新的*/
		then update t_products set p_total_num = p_total_num + old.product_num - new.product_num
				 where p_id = new.product_id;
	end if; 
end
;;
DELIMITER ;
