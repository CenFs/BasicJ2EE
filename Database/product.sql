/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pdtid` int(11) NOT NULL AUTO_INCREMENT,
  `pdtname` varchar(255) NOT NULL,
  `pdt_wareroom` int(11) DEFAULT NULL,
  `pdt_register_time` datetime NOT NULL,
  `pdt_register_person` varchar(255) NOT NULL,
  `pdt_remark` varchar(255) DEFAULT NULL,
  `pdt_price` double DEFAULT NULL,
  `pdt_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`pdtid`),
  KEY `pdt_register_person` (`pdt_register_person`),
  KEY `pdt_wareroom` (`pdt_wareroom`),
  CONSTRAINT `pdt_register_person` FOREIGN KEY (`pdt_register_person`) REFERENCES `user` (`username`),
  CONSTRAINT `pdt_wareroom` FOREIGN KEY (`pdt_wareroom`) REFERENCES `wareroom` (`wrid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', 'testpdt1', '2', '2016-04-21 01:04:21', 'test', 'just test!', '6.25', '60');
INSERT INTO `product` VALUES ('2', 'testpdt2', '1', '2016-04-13 19:29:42', 'test', 'it\'s okay.', '4.25', '40');
INSERT INTO `product` VALUES ('3', 'testpdt3', '2', '2016-04-14 19:58:23', 'test', '1232112', '34.75', '20');
INSERT INTO `product` VALUES ('4', 'testpdt4', '2', '2016-04-16 00:27:00', 'test', '454333455', '5.97', '10');
INSERT INTO `product` VALUES ('5', 'testpdt2', '2', '2016-04-13 19:29:42', 'test', 'it\'s okay.', '4.25', '10');
INSERT INTO `product` VALUES ('7', '111222333', '3', '2016-05-21 00:13:16', 'test', '111123123', '1.12', '1');
INSERT INTO `product` VALUES ('8', '222', '3', '2016-05-14 03:56:12', 'test', '222', '2.22', '2');
INSERT INTO `product` VALUES ('11', '测试产品', '2', '2016-05-21 00:50:57', 'test', '描述1', '5.2', '30');
