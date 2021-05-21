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



DROP TABLE IF EXISTS guns.`bi_device_info`;
CREATE TABLE bi_device_info (
  `uuid` varchar(36) NOT NULL,
  `device_uuid` varchar(36) NOT NULL,
  `mode` varchar(4) DEFAULT NULL,
  `create_user` varchar(128) NOT NULL,
  `create_ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_mod_user` varchar(128) DEFAULT NULL,
  `last_mod_ts` timestamp NULL DEFAULT NULL,
  `device_product_type_uuid` varchar(36) NOT NULL,
  `device_type_uuid` varchar(36) NOT NULL,
  `sts` varchar(4) DEFAULT NULL,
  `black_list_open` varchar(8) DEFAULT NULL,
  `black_list_tip` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `index_device_uuid` (`device_uuid`) USING BTREE,
  KEY `index_sts` (`sts`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS guns.`device`;
CREATE TABLE device.`device` (
  `uuid` varchar(36) NOT NULL,
  `device_serial_no` varchar(36) NOT NULL,
  `device_secret` varchar(128) DEFAULT NULL,
  `device_cn_name` varchar(128) NOT NULL,
  `device_en_name` varchar(128) DEFAULT NULL,
  `device_port` varchar(18) DEFAULT NULL,
  `device_ip` varchar(64) DEFAULT NULL,
  `device_uri` varchar(128) DEFAULT NULL,
  `device_version` varchar(18) NOT NULL DEFAULT '',
  `device_conn_type` varchar(4) DEFAULT NULL,
  `device_protocol` varchar(4) DEFAULT NULL,
  `last_checked_ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `product_typeuuid` varchar(36) NOT NULL,
  `device_typeuuid` varchar(36) NOT NULL,
  `device_tag` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `privilege` varchar(11) NOT NULL,
  `sts` smallint(4) NOT NULL,
  `create_user` varchar(18) NOT NULL,
  `create_ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_mod_user` varchar(18) DEFAULT NULL,
  `last_mod_ts` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `device_serial_no_idx` (`device_serial_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;