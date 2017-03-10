/*
Navicat MySQL Data Transfer

Source Server         : Test
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : bjy2016gp

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-05-23 23:54:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `import`
-- ----------------------------
DROP TABLE IF EXISTS `import`;
CREATE TABLE `import` (
  `importid` int(11) NOT NULL AUTO_INCREMENT,
  `importname` varchar(255) DEFAULT NULL,
  `import_person` varchar(255) DEFAULT NULL,
  `import_time` datetime DEFAULT NULL,
  `import_remark` varchar(255) DEFAULT NULL,
  `import_pdtid` int(11) DEFAULT NULL,
  `import_wrid` int(11) DEFAULT NULL,
  `import_reasonid` int(11) DEFAULT NULL,
  `import_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`importid`),
  KEY `import_person` (`import_person`),
  KEY `import_pdtid` (`import_pdtid`),
  KEY `import_wrid` (`import_wrid`),
  KEY `import_reasonid` (`import_reasonid`),
  CONSTRAINT `import_pdtid` FOREIGN KEY (`import_pdtid`) REFERENCES `product` (`pdtid`),
  CONSTRAINT `import_person` FOREIGN KEY (`import_person`) REFERENCES `user` (`username`),
  CONSTRAINT `import_reasonid` FOREIGN KEY (`import_reasonid`) REFERENCES `reason` (`reasonid`),
  CONSTRAINT `import_wrid` FOREIGN KEY (`import_wrid`) REFERENCES `wareroom` (`wrid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of import
-- ----------------------------
INSERT INTO `import` VALUES ('1', 'rk1', 'test', '2016-03-16 00:27:51', 'test1', '1', '1', '6', '10');
INSERT INTO `import` VALUES ('2', 'rk2', 'test', '2016-04-16 00:47:55', 'test2', '5', '2', '3', '10');
INSERT INTO `import` VALUES ('6', '入库测试', 'test', '2016-05-21 00:53:46', '测试', '11', '2', '1', '10');
