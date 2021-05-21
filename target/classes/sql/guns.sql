 create database
if not exists guns CHARACTER
SET utf8mb4
COLLATE utf8mb4_unicode_ci;


 DROP TABLE IF EXISTS guns.user;
    CREATE TABLE guns.user (
  `id` int
    (11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar
    (255) DEFAULT NULL,
  `account` varchar
    (45) DEFAULT NULL,
  `password` varchar
    (45) DEFAULT NULL,
  `salt` varchar
    (45) DEFAULT NULL,
  `account_type` varchar
    (4) DEFAULT NULL,
  `name` varchar
    (45) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `sex` int
    (11) DEFAULT NULL,
  `email` varchar
    (255) DEFAULT NULL,
  `phone` varchar
    (45) DEFAULT NULL,
  `roleid` varchar
    (255) DEFAULT NULL,
  `deptid` int
    (11) DEFAULT NULL,
  `status` int
    (11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `version` int
    (11) DEFAULT NULL,
  `create_user` int
    ( 11 ) DEFAULT NULL,
  PRIMARY KEY
    (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4;

