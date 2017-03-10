/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `reason`
-- ----------------------------
DROP TABLE IF EXISTS `reason`;
CREATE TABLE `reason` (
  `reasonid` int(11) NOT NULL AUTO_INCREMENT,
  `reasonname` varchar(255) DEFAULT NULL,
  `reason_remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reasonid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reason
-- ----------------------------
INSERT INTO `reason` VALUES ('1', '客户采购', '客户采购...');
INSERT INTO `reason` VALUES ('2', '货物采购', '货物采购....');
INSERT INTO `reason` VALUES ('3', '其他借领', '其他！');
INSERT INTO `reason` VALUES ('4', '内部消化', '用于内部消化了');
INSERT INTO `reason` VALUES ('5', '内部借领', '内部人员借领');
INSERT INTO `reason` VALUES ('6', '库存初始', '原本就在仓库');
