/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wareroom`
-- ----------------------------
DROP TABLE IF EXISTS `wareroom`;
CREATE TABLE `wareroom` (
  `wrid` int(11) NOT NULL AUTO_INCREMENT,
  `wrname` varchar(255) NOT NULL,
  `wr_person_in_charge` varchar(255) NOT NULL,
  `wr_capacity` int(11) NOT NULL,
  `wr_margin` int(11) DEFAULT NULL,
  `wr_remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`wrid`),
  KEY `wr_person_in_charge` (`wr_person_in_charge`),
  CONSTRAINT `wr_person_in_charge` FOREIGN KEY (`wr_person_in_charge`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wareroom
-- ----------------------------
INSERT INTO `wareroom` VALUES ('1', 'testroom1', 'test', '100', '60', '123321');
INSERT INTO `wareroom` VALUES ('2', 'testroom2', 'test', '200', '40', '333333');
INSERT INTO `wareroom` VALUES ('3', '测试用例仓库', 'test', '30', '27', '描述一下');
