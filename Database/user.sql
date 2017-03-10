/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `userpwd` varchar(255) NOT NULL,
  `u_realname` varchar(255) DEFAULT NULL,
  `u_gender` int(1) DEFAULT NULL,
  `u_workid` int(11) DEFAULT NULL,
  `u_departmentid` int(11) DEFAULT NULL,
  `u_address` varchar(255) DEFAULT NULL,
  `u_remark` varchar(255) DEFAULT NULL,
  `u_phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'test', '1234', '邰思特', '1', '1', '1', 'Finninmaenkatu 4 C 24', '无', '465660517');
