/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `export`
-- ----------------------------
DROP TABLE IF EXISTS `export`;
CREATE TABLE `export` (
  `exportid` int(11) NOT NULL AUTO_INCREMENT,
  `exportname` varchar(255) DEFAULT NULL,
  `export_person` varchar(255) DEFAULT NULL,
  `export_time` datetime DEFAULT NULL,
  `export_remark` varchar(255) DEFAULT NULL,
  `export_pdtid` int(11) DEFAULT NULL,
  `export_wrid` int(11) DEFAULT NULL,
  `export_reasonid` int(11) DEFAULT NULL,
  `export_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`exportid`),
  KEY `export_pdtid` (`export_pdtid`),
  KEY `export_person` (`export_person`),
  KEY `export_reasonid` (`export_reasonid`),
  KEY `export_wrid` (`export_wrid`),
  CONSTRAINT `export_pdtid` FOREIGN KEY (`export_pdtid`) REFERENCES `product` (`pdtid`),
  CONSTRAINT `export_person` FOREIGN KEY (`export_person`) REFERENCES `user` (`username`),
  CONSTRAINT `export_reasonid` FOREIGN KEY (`export_reasonid`) REFERENCES `reason` (`reasonid`),
  CONSTRAINT `export_wrid` FOREIGN KEY (`export_wrid`) REFERENCES `wareroom` (`wrid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of export
-- ----------------------------
