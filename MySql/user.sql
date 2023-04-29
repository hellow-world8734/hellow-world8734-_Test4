CREATE DATABASE IF not EXISTS `mydatabase`;

USE `mydatabase`;

CREATE TABLE `user` (
  `Id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
INSERT INTO `user` VALUES (1,'李国华','admin');
INSERT INTO `user` VALUES (2,'王老五','wlw');
INSERT INTO `user` VALUES (3,'张淑芳','zsf');
UNLOCK TABLES;

