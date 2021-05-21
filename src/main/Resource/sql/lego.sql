--  - - Lego前后置动作表：
create database
    if not exists AutoAPI CHARACTER
    SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

use AutoAPI;

CREATE TABLE `API_Actions` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ActionName` varchar(200) NOT NULL COMMENT '动作名称',
  `Status` int(2) NOT NULL DEFAULT '1' COMMENT '状态(1=正常；0=被删除)',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队',
  `Type` int(4) NOT NULL DEFAULT '1' COMMENT '类型(1SQL;2HTTP,3Swallow,4CASE,5JAVA,6WAIT,7Mafka,8手机号,9身份证,10中文名,11邮箱,12清Redis缓存,13Lion操作;14抵用券-定制;15立减-定制;16简化用例;17模拟支付)',
  `comment` varchar(400) NOT NULL DEFAULT '' COMMENT '备注',
  `Info` text COMMENT 'Json配置数据',
  `DBName` varchar(200) NOT NULL DEFAULT 'Beta20' COMMENT '数据库名称（对应DBinfo里的DBName）',
  `SQL` text COMMENT '动作',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown' COMMENT '创建人',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown' COMMENT '最后修改人',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `isRetry` int(2) NOT NULL DEFAULT '0' COMMENT '[重试配置] 是否使用三次重试',
  `isUseLastResult` int(2) NOT NULL DEFAULT '0' COMMENT '[使用上次结果] 是否使用上次执行结果',
  `Duration` int(11) NOT NULL DEFAULT '0' COMMENT '[使用上次结果] 上次执行结果持续时间（单位：min）',
  `LastExecTime` varchar(30) NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '[使用上次结果] 上次执行时间',
  `LastExecStatus` int(2) NOT NULL DEFAULT '-1' COMMENT '[使用上次结果] 上次执行状态(-1=未知,0=失败,1=成功)',
  `LastResult` longtext COMMENT '[使用上次结果] 上次执行结果',
  `ExecCount` int(11) NOT NULL DEFAULT '0' COMMENT '[统计] 执行次数',
  `isUseArgs` int(2) NOT NULL DEFAULT '0' COMMENT '[参数] 是否使用参数',
  `ArgsNum` int(4) NOT NULL DEFAULT '1' COMMENT '[参数] 内部参数个数',
  `ArgsDefaultValue` varchar(1000) NOT NULL DEFAULT '' COMMENT '[参数] 内部参数默认值',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ActionName` (`ActionName`)
) ENGINE=InnoDB AUTO_INCREMENT=4935 DEFAULT CHARSET=utf8 COMMENT='Lego前后置动作表\n创建人：陈永达';


--  - -Lego数据库信息表
CREATE TABLE `API_DBinfo` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT '0' COMMENT 'QA团队',
  `DBName` varchar(200) DEFAULT '' COMMENT '数据库名称',
  `ip` varchar(200) DEFAULT '' COMMENT 'ip',
  `port` varchar(200) DEFAULT '' COMMENT '端口',
  `baseName` varchar(200) DEFAULT '' COMMENT '数据库名称',
  `userName` varchar(200) DEFAULT '' COMMENT '账号',
  `password` varchar(200) DEFAULT '' COMMENT '密码',
  `Creator` varchar(50) DEFAULT 'unknown' COMMENT '创建人',
  `Modifier` varchar(50) DEFAULT 'unknown' COMMENT '修改人',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `DBname` (`DBName`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8 COMMENT='Lego数据库信息表\n创建人：陈永达';



--  - -Lego Http测试用例表
CREATE TABLE `API_HttpCases` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号（自动）',
  `isRun` int(11) NOT NULL DEFAULT '0' COMMENT '是否执行测试（0=不测试，1=执行测试，-1=删除）',
  `team_id` int(11) DEFAULT '0' COMMENT 'QA团队',
  `ServiceName` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '服务名称',
  `Env` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT 'beta' COMMENT '测试环境（product、ppe、beta）',
  `Tags` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标签',
  `Comment` varchar(800) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  `Type` int(2) NOT NULL DEFAULT '1' COMMENT 'http-请求类型（1=GET;2=POST;3=PUT;4=DELETE;5=PATCH）',
  `DataType` int(2) NOT NULL DEFAULT '1' COMMENT 'http-数据方式（1=formData;2=raw）',
  `Path` text CHARACTER SET utf8 COMMENT 'http-Path',
  `Parameters` text CHARACTER SET utf8 COMMENT 'http-参数（多个用&&分割）（支持全局${参数}替换，对应表为APITest_CaseParameters）',
  `headers` text CHARACTER SET utf8 COMMENT 'http-header',
  `responseType` int(4) NOT NULL DEFAULT '1' COMMENT 'http-返回结果类型(1=Json;2=html;3=Jsonp;4=header)',
  `JsonpLeft` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'http-去左边字符',
  `JsonpRight` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'http-去右边字符',
  `PreActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-前置动作（写Acrtions表中ActionName）',
  `AfterTestActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-测试后动作（写Acrtions表中ActionName）',
  `PostActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-后置动作（写Acrtions表中ActionName）',
  `CHECK_Exception` int(2) NOT NULL DEFAULT '1' COMMENT 'checkPoint-异常检查（0=不检查,1=检查）',
  `CHECK_NotNULL` int(2) NOT NULL DEFAULT '1' COMMENT 'checkPoint-判空检查（0=不开启,1=不为空检查,2=为空检查)',
  `CHECK_Contains` text CHARACTER SET utf8 COMMENT 'checkPoint-应包含字段',
  `CHECK_NotContain` text CHARACTER SET utf8 COMMENT 'checkPoint-不应包含字段',
  `CHECK_PreciseJson` text CHARACTER SET utf8 COMMENT 'checkPoint-JsonPath检查点',
  `CHECK_DBParam` text CHARACTER SET utf8 COMMENT 'checkPoint-参数检查点',
  `Score` int(4) NOT NULL DEFAULT '0' COMMENT 'score-用例得分',
  `Tips` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'score-小提示',
  `Radar` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'score-雷达图数据',
  `RunTimes` int(3) NOT NULL DEFAULT '1' COMMENT '执行次数',
  `OtherMessage` text CHARACTER SET utf8 COMMENT '其他需要记录的信息',
  `isCustomIP` int(2) NOT NULL DEFAULT '0' COMMENT '是否使用自定义IP',
  `CustomIP` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '自定义IP',
  `CustomPort` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '自定义端口',
  `Creator` varchar(50) CHARACTER SET utf8 DEFAULT 'unknown',
  `Modifier` varchar(50) CHARACTER SET utf8 DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8396 DEFAULT CHARSET=utf8mb4 COMMENT='Lego Http测试用例表\n创建人：陈永达';


-- - - Lego Mapi测试用例表
CREATE TABLE `API_MapiCases` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号（自动）',
  `isRun` int(11) NOT NULL DEFAULT '0' COMMENT '是否执行测试（0=不测试，1=执行测试，-1=删除）',
  `team_id` int(11) DEFAULT '0' COMMENT 'QA团队',
  `Service` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '服务名称',
  `Env` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT 'beta' COMMENT '测试环境（product、ppe、beta）',
  `Tags` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标签',
  `Comment` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  `Type` int(2) NOT NULL DEFAULT '1' COMMENT 'mapi-请求类型（1=GET;2=POST）',
  `ApiName` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'mapi-接口名',
  `Parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'mapi-参数',
  `Headers` text CHARACTER SET utf8 COMMENT 'mapi-headers',
  `PreActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-前置动作（写Acrtions表中ActionName）',
  `AfterTestActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-测试后动作（写Acrtions表中ActionName）',
  `PostActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'actions-后置动作（写Acrtions表中ActionName）',
  `CHECK_Exception` int(2) NOT NULL DEFAULT '1' COMMENT 'checkPoint-异常检查（1=检查，0=不检查）',
  `CHECK_NotNULL` int(2) NOT NULL DEFAULT '1' COMMENT 'checkPoint-判空检查（1=不为空检查，2=为空检查，0=不开启）',
  `CHECK_Contains` text CHARACTER SET utf8 COMMENT 'checkPoint-应包含字段（多个用&&分割）',
  `CHECK_NotContain` text CHARACTER SET utf8 COMMENT 'checkPoint-不应包含字段',
  `CHECK_PreciseJson` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'checkPoint-JsonPath检查点',
  `CHECK_DBParam` text CHARACTER SET utf8 COMMENT 'checkPoint-参数检查点',
  `Score` int(4) NOT NULL DEFAULT '0' COMMENT 'score-用例得分',
  `Tips` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'score-小提示',
  `Radar` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'score-雷达图数据',
  `RunTimes` int(3) DEFAULT '1' COMMENT '执行次数',
  `OtherMessage` text CHARACTER SET utf8 COMMENT '其他需要记录的信息',
  `isCustomIP` int(2) NOT NULL DEFAULT '0' COMMENT '是否使用自定义IP',
  `CustomIP` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '自定义IP',
  `CustomPort` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '自定义端口',
  `Creator` varchar(50) CHARACTER SET utf8 DEFAULT 'unknown',
  `Modifier` varchar(50) CHARACTER SET utf8 DEFAULT 'unknown',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6145 DEFAULT CHARSET=utf8mb4 COMMENT='Lego Mapi测试用例表\n创建人：陈永达';



--  - - Lego 参数化维护表
CREATE TABLE `API_Parameters` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ParamName` varchar(200) NOT NULL DEFAULT '' COMMENT '参数名称',
  `Status` int(2) NOT NULL DEFAULT '1' COMMENT '状态(1=正常；0=被删除)',
  `team_id` int(11) DEFAULT '0' COMMENT '团队',
  `comment` varchar(800) DEFAULT '无备注' COMMENT '备注',
  `Type` int(2) NOT NULL DEFAULT '1' COMMENT '1.KV,2.SQL,3.AccountToken,4.shopIDToken,5.Case,6.SSOToken,7.qrCode,8.券服务web参数加密,9=手机号,10=身份证号,11=结算与券组AES加密,12=中文名,13=邮箱',
  `Env` int(2) DEFAULT '0' COMMENT '(P3 P4 P7使用)1=beta,2=ppe,3=product,4=test,5=staging',
  `Info` text COMMENT '配置Json',
  `DBName` varchar(200) DEFAULT '' COMMENT '[Type=2] 数据库名称（DBinfo表中的DBname值）',
  `Sql` text COMMENT '[Type=2] 需要执行的Select语句（返回为唯一数据）',
  `DBColumnName` varchar(200) DEFAULT '' COMMENT '[Type=2] 执行sql后需要的值的列名',
  `GetType` int(4) DEFAULT '1' COMMENT '[Type=2] 结果获取方式(1=单个值 2=一列存入列表)',
  `Creator` varchar(50) DEFAULT 'unknown' COMMENT '创建人',
  `Modifier` varchar(50) DEFAULT 'unknown' COMMENT '最后修改人',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `Retry` int(2) NOT NULL DEFAULT '0' COMMENT '[重试配置] 是否重试',
  `UseLastResult` int(2) NOT NULL DEFAULT '0' COMMENT '[使用上次结果] 是否使用上次结果',
  `Duration` int(11) NOT NULL DEFAULT '0' COMMENT '[使用上次结果] 上次执行结果持续时间（单位：min）',
  `LastExecTime` varchar(30) NOT NULL DEFAULT '' COMMENT '[使用上次结果] 上次执行时间',
  `LastExecStatus` int(2) NOT NULL DEFAULT '-1' COMMENT '[使用上次结果] 上次执行状态(-1=未知,0=失败,1=成功)',
  `LastResult` text COMMENT '[使用上次结果] 上次执行结果',
  `ExecCount` int(11) NOT NULL DEFAULT '0' COMMENT '[统计] 执行次数',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ParamName` (`ParamName`)
) ENGINE=InnoDB AUTO_INCREMENT=2233 DEFAULT CHARSET=utf8 COMMENT='Lego 参数化维护表\n创建人：陈永达';




--  - -Lego Pigeon用例表
CREATE TABLE `API_PigeonCases` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '[Base]编号（自动）',
  `isRun` int(11) NOT NULL DEFAULT '0' COMMENT '[Base]是否每日构建（0:不，1=构建，-1=删除）',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '[Base]团队',
  `ServiceName` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Base]应用名',
  `Env` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT 'beta' COMMENT '[Base]测试环境（product、ppe、beta）',
  `comment` text CHARACTER SET utf8 NOT NULL COMMENT '[Base]备注',
  `Tags` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Base]标签',
  `OtherMessage` text CHARACTER SET utf8 COMMENT '[Base]其他需要记录的信息',
  `RequestMethod` int(2) NOT NULL DEFAULT '1' COMMENT '[Pigeon]请求方法(1=GET,2=POST)',
  `Version` int(2) NOT NULL DEFAULT '1' COMMENT '[Pigeon]版本(1,2)',
  `Method` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Pigeon]方法',
  `Direct` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'false' COMMENT '[Pigeon]用来记录是否上报CAT的，false为上报',
  `Url` varchar(1000) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Pigeon]服务Url',
  `ParameterTypes` varchar(2000) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Pigeon]参数类型',
  `Parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '[Pigeon]参数',
  `PreActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Actions]前置动作',
  `AfterTestActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Actions]测试后动作',
  `PostActions` varchar(1500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Actions]后置动作',
  `CHECK_Exception` int(2) NOT NULL DEFAULT '1' COMMENT '[CheckPoint]异常检查（1=检查,0=不检查）',
  `CHECK_NotNULL` int(2) NOT NULL DEFAULT '1' COMMENT '[CheckPoint]判空检查（0=不开启,1=不为空检查,2=为空检查）',
  `CHECK_Contains` text CHARACTER SET utf8 COMMENT '[CheckPoint]应包含字段',
  `CHECK_NotContain` text CHARACTER SET utf8 COMMENT '[CheckPoint]不应包含字段',
  `CHECK_PreciseJson` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '[CheckPoint]JsonPath检查点',
  `CHECK_DBParam` text CHARACTER SET utf8 COMMENT '[CheckPoint]数据参数检查点',
  `Score` int(4) NOT NULL DEFAULT '-1' COMMENT '[Score] 用例得分',
  `Tips` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Score] 用例建议',
  `Radar` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Score] 用例得分雷达图',
  `RunTimes` int(3) NOT NULL DEFAULT '1' COMMENT '[Special] 执行次数',
  `isCustomIP` int(2) NOT NULL DEFAULT '0' COMMENT '[Special] 是否使用自定义IP',
  `CustomIP` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Special] 自定义IP',
  `CustomPort` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[Special] 自定义端口',
  `Creator` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT 'unknown' COMMENT '[Base]创建人',
  `Modifier` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT 'unknown' COMMENT '[Base]修改人',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '[Base]新增时间（自动）',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '[Base]更新时间（自动）',
  PRIMARY KEY (`ID`),
  KEY `index_UpdateTime` (`UpdateTime`),
  KEY `index_ServiceName_team_id_Method` (`ServiceName`,`team_id`,`Method`),
  KEY `index_comment` (`comment`(255))
) ENGINE=InnoDB AUTO_INCREMENT=42329 DEFAULT CHARSET=utf8mb4 COMMENT='Lego Pigeon用例表\n创建人：陈永达';



--  - - Lego 应用/服务数据维护表
CREATE TABLE `API_ServiceInfo` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL DEFAULT '0',
  `Type` int(11) NOT NULL COMMENT '1:pigeon; 2:mapi; 3: http',
  `Service` varchar(200) NOT NULL DEFAULT '',
  `CmdbAppName` varchar(200) NOT NULL DEFAULT '' COMMENT 'CMDB系统上应用名称',
  `isCore` int(2) NOT NULL DEFAULT '0' COMMENT '是否核心(-1=未设置，0=非核心，1=核心)',
  `Level` int(4) NOT NULL DEFAULT '3' COMMENT '服务等级',
  `Env` varchar(200) NOT NULL DEFAULT '',
  `Comment` varchar(200) NOT NULL DEFAULT '',
  `ServiceStatus` int(4) NOT NULL DEFAULT '2' COMMENT '服务状态(0=下线 1=待下线 2=正常)',
  `IP` varchar(200) NOT NULL DEFAULT '' COMMENT 'ip',
  `Port` varchar(200) NOT NULL DEFAULT '' COMMENT '端口',
  `Domain` varchar(200) NOT NULL DEFAULT '',
  `AutoIP` varchar(200) NOT NULL DEFAULT '' COMMENT '参考IP(自动获取)',
  `isUseCargoIp` int(2) NOT NULL DEFAULT '0' COMMENT '是否使用Cargo机器的IP',
  `isUseGroup1` int(2) NOT NULL DEFAULT '1' COMMENT '是否使用Group1 IP(只针对线上)',
  `isUseAutoIp` int(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否用Lego自动获取的IP',
  `CustomGroup1Name` varchar(100) NOT NULL DEFAULT 'group1' COMMENT '自定义Group1机器',
  `isOpenPigeonEncrypt` int(2) NOT NULL DEFAULT '0' COMMENT '是否开启Pigeon鉴权',
  `SecretApp` varchar(200) NOT NULL DEFAULT '',
  `Secret` varchar(100) NOT NULL DEFAULT '',
  `CoverageServiceName` varchar(200) NOT NULL COMMENT '覆盖率上配置的服务名',
  `Score` int(4) NOT NULL DEFAULT '0' COMMENT '服务配置得分',
  `Tips` varchar(3) NOT NULL DEFAULT '',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  `flag` int(2) NOT NULL DEFAULT '0' COMMENT '陈永达检查确认标记',
  `Tag` int(2) NOT NULL DEFAULT '0' COMMENT '1=商家端用来动态修改IP用',
  `Detail` varchar(1000) NOT NULL DEFAULT '' COMMENT '从Catalog获取的信息',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1813 DEFAULT CHARSET=utf8 COMMENT='Lego 应用/服务数据维护表\n创建人：陈永达';



--  - - 创建人：戴传飞
CREATE TABLE `API_TagRule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TagID` int(11) DEFAULT '0',
  `Type` int(11) DEFAULT '0' COMMENT '1=服务',
  `ServiceID` int(11) DEFAULT '0' COMMENT '服务ID',
  `Creator` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `Modifier` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='创建人：戴传飞';

--  - - 标签维护表
CREATE TABLE `API_Tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TagName` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Team_id` text COLLATE utf8mb4_unicode_ci,
  `Creator` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建人',
  `Modifier` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='创建人：戴传飞\n标签维护表';

-- - - Lego Mapi测试用例白名单
CREATE TABLE `API_WhiteList` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL,
  `Service` varchar(200) NOT NULL DEFAULT '',
  `ApiName` varchar(200) NOT NULL DEFAULT '',
  `OldJavaName` varchar(200) NOT NULL DEFAULT '',
  `NewJavaName` varchar(200) NOT NULL DEFAULT '',
  `Creator` varchar(50) DEFAULT 'unknown',
  `Modifier` varchar(50) DEFAULT 'unknown',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COMMENT='Lego Mapi测试用例白名单\n创建人：陈永达';



-- - - 【应用信息】从公司的其他平台上爬取AppKey的详细信息
CREATE TABLE `AppKeyDetail` (
  `AppKey` varchar(100) NOT NULL DEFAULT '' COMMENT 'appName',
  `team_id` int(11) NOT NULL,
  `CmdbBuName` varchar(200) NOT NULL COMMENT 'CMDB-团队名',
  `TeamName` varchar(200) NOT NULL COMMENT 'ServiceCatalog-开发团队',
  `TeamDisplayName` varchar(200) NOT NULL COMMENT 'ServiceCatalog-开发团队',
  `Desc` varchar(1000) NOT NULL DEFAULT '' COMMENT 'ServiceCatalog-描述',
  `AdminName` varchar(30) NOT NULL COMMENT 'ServiceCatalog-服务负责人中文名',
  `AdminMis` varchar(30) NOT NULL COMMENT 'ServiceCatalog-服务负责人Mis',
  `SLA` varchar(500) NOT NULL DEFAULT '' COMMENT 'ServiceCatalog-SLA',
  `Language` varchar(30) NOT NULL DEFAULT '' COMMENT 'ServiceCatalog-语言',
  `InvokedAppCount` int(11) NOT NULL DEFAULT '-1' COMMENT '调用方应用数量',
  `isWebService` int(2) NOT NULL DEFAULT '0',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  UNIQUE KEY `team_id` (`team_id`,`AppKey`),
  KEY `AppKey` (`AppKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='【应用信息】从公司的其他平台上爬取AppKey的详细信息\n创建人：陈永达';


#  - -【应用信息】对AppKeyDetail标的信息，做标记用
CREATE TABLE `AppKeyMark` (
  `AppKey` varchar(100) NOT NULL DEFAULT '' COMMENT 'appName',
  `team_id` int(11) NOT NULL,
  `isCoreService` int(2) NOT NULL DEFAULT '0' COMMENT '是否核心',
  `AppLevel` int(2) NOT NULL DEFAULT '3' COMMENT '服务等级',
  `isAboutMoney` int(2) NOT NULL DEFAULT '0' COMMENT '是否和钱相关',
  `PriorityScore` int(4) NOT NULL DEFAULT '0' COMMENT '得分',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='【应用信息】对AppKeyDetail标的信息，做标记用\n创建人：陈永达';



 CREATE TABLE `APPScheme_Pics` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `FileNo` int(11) DEFAULT NULL,
  `Scheme` varchar(100) DEFAULT NULL,
  `Bu` int(11) DEFAULT NULL,
  `Filename` varchar(100) DEFAULT NULL COMMENT '所属文件名',
  `PicId` int(11) DEFAULT NULL COMMENT '图片id',
  `PicPath` varchar(100) DEFAULT NULL COMMENT '图片在美团云的路径',
  `OrderNo` int(11) DEFAULT NULL COMMENT '截图顺序',
  `Type` int(11) DEFAULT NULL COMMENT '1：old;2:new ;3:result',
  `Version` varchar(100) DEFAULT NULL COMMENT '版本',
  `Result` int(11) DEFAULT NULL,
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13200 DEFAULT CHARSET=utf8;



CREATE TABLE `AUTO_ServiceInterFaceInfo` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `SID` int(11) DEFAULT NULL COMMENT 'Auto_ServiceInfo.ID',
  `Url` varchar(1000) DEFAULT '1',
  `Method` varchar(200) DEFAULT '',
  `ParameterTypes` varchar(2000) DEFAULT NULL,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31209 DEFAULT CHARSET=utf8 COMMENT='创建人：陈永达';




CREATE TABLE `CAT_AppModule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(200) DEFAULT NULL COMMENT '模块名',
  `platform` int(11) DEFAULT NULL COMMENT '平台，1：点评；2：美团',
  `mobilePlatform` varchar(100) DEFAULT NULL COMMENT 'ios  or  android',
  `bu` varchar(100) DEFAULT NULL COMMENT '所属业务线',
  `devowner` varchar(100) DEFAULT NULL,
  `qaowner` varchar(100) DEFAULT NULL,
  `addTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6405 DEFAULT CHARSET=utf8;



CREATE TABLE `CAT_H5PagePerformance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appName` varchar(100) DEFAULT NULL COMMENT '点评或美团',
  `projectName` varchar(100) DEFAULT NULL,
  `pageUrl` varchar(200) DEFAULT NULL,
  `requestCount` int(11) DEFAULT NULL COMMENT '请求量',
  `avg` int(11) DEFAULT NULL COMMENT '平均响应时间',
  `percent50Performance` int(11) DEFAULT NULL COMMENT '50线响应时间，单位ms',
  `percent90Performance` int(11) DEFAULT NULL COMMENT '90线响应时间，单位ms',
  `percent95Performance` int(11) DEFAULT NULL COMMENT '95线响应时间，单位ms',
  `percent99Performance` int(11) DEFAULT NULL COMMENT '99线响应时间，单位ms',
  `date` datetime DEFAULT NULL COMMENT '统计时间',
  `addTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `business` varchar(100) DEFAULT NULL COMMENT '业务线',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9104 DEFAULT CHARSET=utf8;



CREATE TABLE `CAT_InvokeCount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `AppName` varchar(50) DEFAULT NULL COMMENT '应用名',
  `SName` varchar(100) DEFAULT NULL COMMENT '服务名',
  `ApiName` varchar(500) DEFAULT NULL COMMENT '接口名',
  `Count` bigint(11) DEFAULT NULL COMMENT '接口调用量',
  `IsCovered` int(11) DEFAULT NULL COMMENT '是否覆盖自动化用例，0：未覆盖；1：已覆盖',
  `CaseCount` int(11) DEFAULT NULL COMMENT '用例数量（beta+product）',
  `ApiType` int(11) DEFAULT NULL COMMENT '接口类型，1： pigeon；2：mapi ；3：Http',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=295936 DEFAULT CHARSET=utf8;



CREATE TABLE `DATA_AnalysisCase` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `Type` int(11) NOT NULL COMMENT '1=用例失败来源',
  `BusinessId` int(11) NOT NULL COMMENT 'Type=1时，用DATA_CIResults表的ID字段',
  `team_id` int(11) DEFAULT NULL COMMENT '团队编号',
  `ServiceName` varchar(100) DEFAULT NULL,
  `OldReasonType` int(11) DEFAULT NULL COMMENT '0=其他 1=服务异常(非业务缺陷) 2=服务缺陷 3=测试数据问题 4=服务功能变动 5=需要优化脚本 6=依赖服务异常 7=Lego工具平台的问题 8=不可抗力(网络变更、机房变动、环境不稳等) 9=服务IP变更',
  `ReasonType` int(11) DEFAULT NULL,
  `Reason` varchar(1024) DEFAULT NULL COMMENT '分析原因',
  `Mis` varchar(100) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL COMMENT '0=未处理，1=处理中，2=已解决，-1=不解决',
  `Url` varchar(400) DEFAULT '' COMMENT 'tapd链接',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4385 DEFAULT CHARSET=utf8 COMMENT='Lego1.0失败原因分析\n创建者：侯顺乐';



-- - -Lego1.0失败原因分析
CREATE TABLE `DATA_AnalysisCase` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `Type` int(11) NOT NULL COMMENT '1=用例失败来源',
  `BusinessId` int(11) NOT NULL COMMENT 'Type=1时，用DATA_CIResults表的ID字段',
  `team_id` int(11) DEFAULT NULL COMMENT '团队编号',
  `ServiceName` varchar(100) DEFAULT NULL,
  `OldReasonType` int(11) DEFAULT NULL COMMENT '0=其他 1=服务异常(非业务缺陷) 2=服务缺陷 3=测试数据问题 4=服务功能变动 5=需要优化脚本 6=依赖服务异常 7=Lego工具平台的问题 8=不可抗力(网络变更、机房变动、环境不稳等) 9=服务IP变更',
  `ReasonType` int(11) DEFAULT NULL,
  `Reason` varchar(1024) DEFAULT NULL COMMENT '分析原因',
  `Mis` varchar(100) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL COMMENT '0=未处理，1=处理中，2=已解决，-1=不解决',
  `Url` varchar(400) DEFAULT '' COMMENT 'tapd链接',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4385 DEFAULT CHARSET=utf8 COMMENT='Lego1.0失败原因分析\n创建者：侯顺乐';



CREATE TABLE `DATA_APPSchemes` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号（自动）',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT 'QA团队',
  `Version` varchar(20) NOT NULL DEFAULT '-' COMMENT '起始版本',
  `Name` text NOT NULL COMMENT '页面名称',
  `Scheme` varchar(500) DEFAULT NULL,
  `Comment` varchar(800) DEFAULT NULL COMMENT '备注',
  `Viewname` varchar(100) DEFAULT NULL COMMENT '对应appkit中的view名称',
  `Status` int(1) NOT NULL DEFAULT '0' COMMENT '状态 0-有效 1-删除',
  `Owner` varchar(100) DEFAULT NULL COMMENT '创建人',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  `Platform` varchar(20) NOT NULL DEFAULT '' COMMENT 'APP名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;



-- - -计划
CREATE TABLE `DATA_AutoCasePlan` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ServiceInfoID` int(11) DEFAULT NULL COMMENT 'DATA_AutoServicePlan',
  `PigeonUrl` varchar(200) DEFAULT NULL,
  `ApiName` varchar(200) DEFAULT NULL COMMENT '接口名称',
  `planOwner` varchar(20) DEFAULT NULL COMMENT 'case编写计划负责人',
  `planCaseCount` varchar(11) DEFAULT NULL,
  `finishCaseCount` varchar(11) DEFAULT NULL,
  `endTime` datetime DEFAULT NULL COMMENT 'case编写计划完成时间',
  `planningFinishRate` varchar(11) DEFAULT NULL COMMENT '接口自动化完成率',
  `status` int(11) DEFAULT NULL COMMENT '状态 1: 进行中 2：规划中 3：完成',
  `mark` varchar(200) DEFAULT NULL COMMENT '接口计划目标',
  `addTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `dataType` int(11) DEFAULT NULL COMMENT '0：接口级别的数据；1：服务级别的数据',
  `isHide` int(11) DEFAULT '0' COMMENT '0:未归档 1：已归档',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='计划\n创建者：侯顺乐';



-- - - 用户端和商家端 测试结果-成功率数据汇总表
CREATE TABLE `DATA_CasePassRate` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `team_id` int(11) NOT NULL COMMENT '团队名称，对应的是QATeams那张表的ID',
  `Pass` int(11) DEFAULT NULL COMMENT '通过数量',
  `Fail` int(11) DEFAULT NULL COMMENT '失败数量',
  `Total` int(11) DEFAULT NULL COMMENT '执行总数',
  `CountDate` varchar(100) DEFAULT NULL COMMENT '统计日期',
  `Source` int(4) DEFAULT NULL COMMENT '数据来源1=lego；2=testNG',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19450 DEFAULT CHARSET=utf8 COMMENT='用户端和商家端 测试结果-成功率数据汇总表\n创建者：侯顺乐';


-- - - Lego Ci 覆盖率原始数据表
CREATE TABLE `DATA_CICoverage` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队id',
  `ciproject_id` int(11) NOT NULL COMMENT 'CIProjects表对应id',
  `serviceName` varchar(200) NOT NULL COMMENT '服务名',
  `ci_buildID` varchar(20) NOT NULL DEFAULT '' COMMENT 'ci构建编号',
  `ci_testTime` varchar(200) DEFAULT NULL COMMENT 'CI执行的时间',
  `Instructions` int(3) NOT NULL DEFAULT '0' COMMENT '代码覆盖率',
  `Branches` int(3) NOT NULL DEFAULT '0' COMMENT '分支覆盖率',
  `InsLines` varchar(200) DEFAULT '0 of 0',
  `BraLines` varchar(200) DEFAULT '0 of 0',
  `Comment` varchar(200) NOT NULL DEFAULT '',
  `isHistory` int(11) DEFAULT '0',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=71889 DEFAULT CHARSET=utf8 COMMENT='Lego Ci 覆盖率原始数据表\n创建人：yongda.chen';




--  - -Lego Ci 项目记录表
CREATE TABLE `DATA_CIProjects` (
  `ciproject_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队id',
  `projectName` varchar(200) NOT NULL DEFAULT '' COMMENT 'CI项目名称',
  `Desc` varchar(2000) NOT NULL COMMENT '描述',
  `isCoverage` int(1) NOT NULL DEFAULT '0' COMMENT '是否配置覆盖率',
  `projectUrl` varchar(300) NOT NULL DEFAULT '' COMMENT 'CI项目地址',
  `DataSrc` int(2) NOT NULL DEFAULT '1' COMMENT '废弃字段',
  `status` int(2) NOT NULL DEFAULT '-1' COMMENT '1=可用，0=不可用，-1=带扫描',
  `isConfig` int(2) NOT NULL DEFAULT '-1' COMMENT '1=已经配置获取BuildNum、URL值、JobName，0=未配置',
  `OwnerName` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人',
  `OwnerMis` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown' COMMENT '创建人',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown' COMMENT '修改者',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ciproject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=583 DEFAULT CHARSET=utf8 COMMENT='Lego Ci 项目记录表\n创建人：yongda.chen';





-- - - Lego Ci 执行结果原始数据表
CREATE TABLE `DATA_CIResults` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队id',
  `ciproject_id` int(11) NOT NULL COMMENT 'CIProjects表对应id',
  `ci_id` varchar(20) NOT NULL DEFAULT '' COMMENT 'ci构建编号',
  `ci_testTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'CI执行的时间',
  `total` varchar(20) NOT NULL DEFAULT '' COMMENT '用例执行总数',
  `fail` varchar(20) NOT NULL DEFAULT '' COMMENT '用例执行失败数',
  `Comment` varchar(200) NOT NULL DEFAULT '',
  `isHistory` int(11) DEFAULT '0' COMMENT '1=历史数据，为1则不再删改',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=136245 DEFAULT CHARSET=utf8 COMMENT='Lego Ci 执行结果原始数据表\n创建人：yongda.chen';




-- - - 用户端和商家端 代码覆盖率数据汇总表
CREATE TABLE `DATA_CodeCoverage` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `team_id` int(11) NOT NULL COMMENT '团队名称，对应的是QATeams那张表的ID',
  `Service` varchar(100) DEFAULT NULL COMMENT '服务名称',
  `Instructions` int(11) DEFAULT NULL COMMENT '代码覆盖率',
  `Branches` int(11) DEFAULT NULL COMMENT '分支覆盖率',
  `Source` int(4) DEFAULT NULL COMMENT '数据来源（1=lego, 2=testNG）',
  `AddTime` timestamp NULL DEFAULT NULL,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=42782 DEFAULT CHARSET=utf8 COMMENT='用户端和商家端 代码覆盖率数据汇总表\n创建者：侯顺乐';



-- - - 云测平台UI自动化测试结果汇总
CREATE TABLE `DATA_ConanCIProjects` (
  `ConanCIProjectID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队id',
  `ProjectName` varchar(200) NOT NULL DEFAULT '' COMMENT 'CI项目名称',
  `ProjectUrl` varchar(300) NOT NULL DEFAULT '' COMMENT 'CI项目地址',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ConanCIProjectID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='云测平台UI自动化测试结果汇总\nfor 郭贝\n创建者：陈永达';



-- - - 云测平台UI自动化测试结果汇总
CREATE TABLE `DATA_ConanResults` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `team_id` int(11) NOT NULL DEFAULT '0' COMMENT '团队id',
  `ConanCIProjectID` int(11) NOT NULL DEFAULT '0' COMMENT '编号',
  `BuildID` varchar(200) NOT NULL DEFAULT '' COMMENT '构建编号',
  `CiTime` varchar(200) NOT NULL DEFAULT '' COMMENT '测试时间',
  `ConanReportID` varchar(11) DEFAULT '0',
  `Pass` varchar(10) NOT NULL DEFAULT '' COMMENT 'conan-pass',
  `Fail` varchar(10) NOT NULL DEFAULT '' COMMENT 'conan-fail',
  `Skip` varchar(10) NOT NULL DEFAULT '' COMMENT 'conan-skip',
  `AppName` varchar(100) NOT NULL COMMENT 'conan-appName',
  `AppVersion` varchar(100) NOT NULL DEFAULT '' COMMENT 'conan-appVersion',
  `Platform` varchar(50) NOT NULL DEFAULT '' COMMENT 'conan-platform',
  `Crash` varchar(100) NOT NULL DEFAULT '' COMMENT 'conan-crash',
  `Time` varchar(200) NOT NULL DEFAULT '' COMMENT 'conan-time',
  `PhoneCount` int(5) DEFAULT '-1' COMMENT '手机数量',
  `CaseCount` int(5) DEFAULT '-1' COMMENT '用例数量',
  `isHistory` int(11) DEFAULT '0' COMMENT '1=历史数据，为1则不再删改',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=utf8 COMMENT='云测平台UI自动化测试结果汇总\nfor 郭贝\n创建者：陈永达';




-- - - 失败原因类型属性
CREATE TABLE `DATA_FailedReasonTypeAttr` (
  `ReasonTypeID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `ReasonName` varchar(100) NOT NULL COMMENT '原因名',
  `ReasonDesc` varchar(100) DEFAULT '' COMMENT '原因描述',
  `Creator` varchar(50) DEFAULT 'unknown',
  `Modifier` varchar(50) DEFAULT 'unknown',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ReasonTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='失败原因类型属性\n创建者：陈永达';




-- - - Lego2.0 失败原因
CREATE TABLE `DATA_FailReason` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CaseID` int(11) DEFAULT '0' COMMENT '用例ID',
  `CaseType` int(11) DEFAULT '0' COMMENT '用例类型1=Pigeon 2=Mapi 3=Http',
  `CaseName` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'case名；testng',
  `team_id` int(11) DEFAULT '-1',
  `ResCaseID` int(11) DEFAULT '0' COMMENT '与Res_CaseID 关联',
  `BuildNum` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'job构建号',
  `Xml` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `ReasonType` int(11) DEFAULT '-1' COMMENT '2=测试数据问题 3=业务功能变动 4=自动化测试用例/脚本问题 5=发现了bug 6=case已废弃 7=被测服务异常 8=依赖服务异常 9=Lego工具平台问题 10-其它 11-偶发性问题',
  `Reason` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Url` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Status` int(2) DEFAULT '-1' COMMENT '0=未修复，1=修复中，2=已修复，3=不修复，-1=未知',
  `Operator` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '处理人',
  `Source` int(2) DEFAULT '-1' COMMENT '1-lego平台 2-hook平台(base) 3-hook平台(testNG)',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `HookID` int(11) DEFAULT '-1' COMMENT 'hook方表主键',
  `ServiceName` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '服务名hook方提供',
  `BugLevel` int(11) DEFAULT '0' COMMENT '维护bug用，bug严重程度 1=P1,2=P2,3=P3',
  `QAOwner` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'QA负责人',
  `RDOwner` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '开发负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23980 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lego2.0 失败原因\n创建者：戴传飞';




-- - - 用户端和商家端 接口覆盖率数据汇总表
CREATE TABLE `DATA_InterfaceCoverage` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `team_id` int(11) NOT NULL COMMENT '团队名称，对应的是QATeams那张表的ID',
  `Service` varchar(100) DEFAULT NULL COMMENT '服务名称',
  `Type` int(2) DEFAULT NULL COMMENT '服务类型(1.pigeon,2=mapi)',
  `Env` int(2) DEFAULT NULL COMMENT '测试环境(1=beta,2=ppe,3=线上)',
  `InterfaceTotal` int(11) DEFAULT NULL COMMENT '服务共有接口数',
  `CoveredCount` int(11) DEFAULT '0' COMMENT '已覆盖接口数量',
  `Source` int(4) DEFAULT NULL COMMENT '数据来源（1=lego, 2=testNG）',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Teamid_Service_Source_Env` (`team_id`,`Service`,`Source`,`Env`)
) ENGINE=InnoDB AUTO_INCREMENT=22624 DEFAULT CHARSET=utf8 COMMENT='用户端和商家端 接口覆盖率数据汇总表\n创建者：侯顺乐';



CREATE TABLE `DATA_InvokeCoverage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `AppName` varchar(50) DEFAULT NULL COMMENT '应用名',
  `SName` varchar(200) DEFAULT NULL COMMENT '服务名',
  `ApiName` varchar(500) DEFAULT NULL COMMENT '接口名',
  `ServicePriority` varchar(10) DEFAULT NULL COMMENT '服务的优先级 P1-P4',
  `ApiPriority` varchar(10) DEFAULT 'P3' COMMENT '接口的优先级 P1-P4',
  `Module` varchar(20) DEFAULT NULL COMMENT '模块分类',
  `ExternalService` int(11) DEFAULT '0' COMMENT '外部服务 1-是,2-否',
  `FundsRelated` int(11) DEFAULT '0' COMMENT '资金相关 1-是,2-否',
  `Count` bigint(11) NOT NULL DEFAULT '0' COMMENT '接口调用量',
  `IsCovered` int(11) DEFAULT '0' COMMENT '是否覆盖自动化用例，0：未覆盖；1：已覆盖',
  `CaseCount` int(11) DEFAULT '0' COMMENT '用例数量（beta+product）',
  `ReadOrWrite` varchar(20) DEFAULT '未设置',
  `ApiType` int(11) DEFAULT '1' COMMENT '接口类型，1： pigeon；2：mapi ；3：Http',
  `Team_id` int(11) DEFAULT NULL,
  `ip` varchar(11) DEFAULT NULL COMMENT '服务地址 ip',
  `Description` varchar(255) DEFAULT NULL COMMENT '接口描述',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `PlanTime` timestamp NULL DEFAULT NULL COMMENT '计划完成时间',
  `FinishTime` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`Team_id`,`AppName`,`SName`,`ApiName`)
) ENGINE=InnoDB AUTO_INCREMENT=8139 DEFAULT CHARSET=utf8;





-- - -用户端和商户端用例统计数据整合表
CREATE TABLE `DATA_NewCaseCount` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `Owner` varchar(100) NOT NULL DEFAULT '' COMMENT '用例Owner，即用例表中的creator',
  `team_id` int(11) NOT NULL COMMENT '团队名称，对应的是QATeams那张表的ID',
  `NewCaseNum` int(11) DEFAULT NULL COMMENT '新增用例数',
  `CountDate` varchar(100) DEFAULT NULL COMMENT '统计日期',
  `CaseType` int(4) DEFAULT NULL COMMENT '暂时不用，1 pigeon服务用例，2 mapi接口用例 3 http用例',
  `Source` int(4) DEFAULT NULL COMMENT '1=lego；2=testNG',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=30889 DEFAULT CHARSET=utf8 COMMENT='用户端和商户端用例统计数据整合表\n创建人：shunle.hou';




-- - - 存放服务的接口
-- - -创建人：戴传飞
-- - -貌似已经有表了AUTO_ServiceInterFaceInfo
CREATE TABLE `DATA_ServiceMethods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ServiceID` int(11) DEFAULT '0' COMMENT '与API_ServiceInfo关联的候选键',
  `Method` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47088 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='存放服务的接口\n创建人：戴传飞\n貌似已经有表了AUTO_ServiceInterFaceInfo';


CREATE TABLE `DISPLAY_LastSuccessRate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT '-1' COMMENT '团队ID',
  `JobID` int(11) DEFAULT '-1' COMMENT '关联RES_Job表的id',
  `Xml` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Fail` int(11) DEFAULT '0' COMMENT '执行失败用例数',
  `Pass` int(11) DEFAULT '0' COMMENT '执行成功用例数',
  `PigeonTestTag` int(11) DEFAULT '0',
  `MapiTestTag` int(11) DEFAULT '0',
  `HttpTestTag` int(11) DEFAULT '0',
  `PigeonFailCaseID` text COLLATE utf8mb4_unicode_ci COMMENT '失败caseID',
  `MapiFailCaseID` text COLLATE utf8mb4_unicode_ci,
  `HttpFailCaseID` text COLLATE utf8mb4_unicode_ci,
  `BuildNum` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '构建号',
  `ProjectUrl` text COLLATE utf8mb4_unicode_ci COMMENT 'job链接',
  `Source` int(11) DEFAULT '0' COMMENT '用于区分job来源，6=lego job；7=hook job',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=655 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='统计Job最新一次构建的结果\n创建者：戴传飞';



CREATE TABLE `DOC_CaseResultByDay` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT '-1' COMMENT '团队ID',
  `CaseID` int(11) DEFAULT '-1' COMMENT '用例ID',
  `CaseType` int(11) DEFAULT '-1' COMMENT '用例类型1=Pigeon 2=Mapi 3=Http',
  `Pass` int(11) DEFAULT '0' COMMENT '成功次数',
  `Fail` int(11) DEFAULT '0' COMMENT '失败次数',
  `Date` date DEFAULT '1000-01-01' COMMENT '用例执行的时间YYYY-MM-DD',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1292206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='归档-用于统计每个case一天的执行情况\n创建者：戴传飞';



CREATE TABLE `DOC_PageStatisticsByDay` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Date` date DEFAULT '1000-01-01',
  `Count` int(11) DEFAULT '0' COMMENT '访问的次数',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14506 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用于归档-统计每一个页面每天被访问的次数\n创建者：戴传飞';




CREATE TABLE `DOC_ServiceResultByDay` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT '-1' COMMENT '团队ID',
  `ServiceID` int(11) DEFAULT '-1' COMMENT '服务ID',
  `Pass` int(11) DEFAULT '0' COMMENT '执行成功用例数',
  `Fail` int(11) DEFAULT '0' COMMENT '执行失败用例数',
  `Date` date DEFAULT '1000-01-01',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用于归档-统计一个服务每天case执行情况\n创建者：戴传飞';



CREATE TABLE `DOC_UserPageStatisticsByDay` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Count` int(11) DEFAULT '0' COMMENT '用户访问某个页面的次数',
  `Date` date DEFAULT '1000-01-01',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71564 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用于归档-统计每个页面被每个人每天访问的次数\n创建者：戴传飞';



CREATE TABLE `DOC_UserStatisticsByDay` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Count` int(11) DEFAULT '0' COMMENT '用户访问lego的次数',
  `Date` date DEFAULT '1000-01-01',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用于归档-用户每一天访问lego的次数\n创建者：戴传飞';





CREATE TABLE `FrontendProject` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `business` varchar(100) DEFAULT NULL COMMENT '业务线',
  `projectName` varchar(100) DEFAULT NULL COMMENT '前端项目',
  `pageUrl` varchar(100) DEFAULT NULL COMMENT '页面url',
  `appName` varchar(100) DEFAULT NULL COMMENT 'app名称；dianping or meituan',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='各业务线前端项目信息';




CREATE TABLE `GA_Cases` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号（自动）',
  `isRun` int(11) DEFAULT '1',
  `team_id` int(11) DEFAULT '0' COMMENT 'QA团队',
  `DeviceID` varchar(200) DEFAULT '',
  `Comment` varchar(1000) DEFAULT '' COMMENT '备注',
  `Type` int(2) DEFAULT '1' COMMENT '请求类型（1=第一条;2=所有）',
  `PreActions` varchar(1500) DEFAULT '' COMMENT '前置动作（写Acrtions表中ActionName）（多个用&&分割）',
  `AfterTestActions` varchar(1500) DEFAULT '' COMMENT '测试后动作（写Acrtions表中ActionName）（多个用&&分割）',
  `PostActions` varchar(1500) DEFAULT '' COMMENT '后置动作（写Acrtions表中ActionName）（多个用&&分割）',
  `CHECK_Contains` text COMMENT '检查点-应包含字段（多个用&&分割）',
  `CHECK_NotContain` text COMMENT '检查点-不应包含字段（多个用&&分割）',
  `CHECK_PreciseJson` text COMMENT '检查点-JsonPath检查点（多个用&&分割）',
  `Creator` varchar(50) DEFAULT 'unknown',
  `Modifier` varchar(50) DEFAULT 'unknown',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;





CREATE TABLE `GA_Info` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DeviceID` varchar(200) DEFAULT '',
  `Info` text COMMENT '上报信息',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;



CREATE TABLE `LOG_Exception` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PackageName` varchar(300) NOT NULL DEFAULT '' COMMENT '类所在的包路径',
  `ClassName` varchar(200) NOT NULL DEFAULT '' COMMENT '类名',
  `MethodName` varchar(200) NOT NULL DEFAULT '' COMMENT '调用方法名',
  `LineNum` varchar(50) NOT NULL,
  `ExceptionMsg` text NOT NULL COMMENT '堆栈信息',
  `InvokeInfo` varchar(500) NOT NULL,
  `Comment` varchar(200) NOT NULL DEFAULT '' COMMENT '自定义信息',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8 COMMENT='Lego的异常情况记录\n创建者：戴传飞';




CREATE TABLE `LOG_JobResult` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `JobName` varchar(200) DEFAULT '' COMMENT '接口类型1=Pigeon 2=Mapi 3=Http',
  `BuildNum` varchar(20) DEFAULT '' COMMENT 'key',
  `BuildUrl` varchar(500) DEFAULT '' COMMENT '成功个数',
  `Fail` int(11) DEFAULT '0',
  `Skip` int(11) DEFAULT '0',
  `Total` int(11) DEFAULT '0',
  `FailCaseListUrl` varchar(1000) DEFAULT '',
  `FailMsg` text,
  `Mis` varchar(1000) DEFAULT '',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5296 DEFAULT CHARSET=utf8 COMMENT='创建者：陈永达\njob上配置的shell脚本，调用了Lego的接口';






CREATE TABLE `LOG_PageView` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `Username` varchar(100) DEFAULT 'unknown' COMMENT 'User',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Host` varchar(500) DEFAULT '',
  `Path` varchar(500) DEFAULT '',
  `Title` varchar(200) DEFAULT '',
  `Ip` varchar(100) DEFAULT '',
  `Referrer` text,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `Result` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=737663 DEFAULT CHARSET=utf8 COMMENT='创建者：陈永达\nweb页面操作记录';






CREATE TABLE `Pages` (
  `ID` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `pageName` varchar(20) DEFAULT '' COMMENT '页面名称',
  `index` int(4) DEFAULT '1' COMMENT '在页面上第几个位置出现',
  `command` varchar(200) DEFAULT '' COMMENT '备注',
  `html` text COMMENT 'html编码',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='创建者：陈永达\n页面html';



CREATE TABLE `PLAN_CompleteGoal` (
  `AppKey` varchar(100) NOT NULL DEFAULT '' COMMENT 'AppKey',
  `team_id` int(11) NOT NULL,
  `FinishTime` varchar(50) NOT NULL DEFAULT '' COMMENT '完成时间',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录目标完成过的情况\n创建人：yongda.chen';





CREATE TABLE `PLAN_CoverageGoal` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号（自动）',
  `ServiceInfoID` int(11) NOT NULL DEFAULT '0' COMMENT 'ServiceInfo表ID',
  `Owner` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人',
  `OwnerName` varchar(50) NOT NULL DEFAULT '' COMMENT '负责人中文名',
  `Comment` text COMMENT '备注',
  `TimePoint` varchar(200) NOT NULL DEFAULT '' COMMENT '时间点',
  `GoalRate` int(11) NOT NULL DEFAULT '65',
  `Creator` varchar(50) NOT NULL DEFAULT 'unknown',
  `Modifier` varchar(50) NOT NULL DEFAULT 'unknown',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间（自动）',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=823 DEFAULT CHARSET=utf8 COMMENT='历史已完成目标的服务\n创建人：yongda.chen';





CREATE TABLE `QATeams` (
  `team_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `BG` varchar(200) NOT NULL DEFAULT '' COMMENT 'BG',
  `BU` varchar(200) NOT NULL DEFAULT '' COMMENT 'BU',
  `IsPlatform` int(2) DEFAULT '0' COMMENT '是否为平台类团队',
  `Members` varchar(300) NOT NULL DEFAULT '' COMMENT '成员',
  `Mis` varchar(400) DEFAULT '',
  `CMDBname` varchar(200) DEFAULT '',
  `Creator` varchar(50) DEFAULT 'unknown',
  `Modifier` varchar(50) DEFAULT 'unknown',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（自动）',
  `Enname` varchar(50) DEFAULT '',
  `business_group` varchar(100) DEFAULT '' COMMENT 'OPS BG',
  `owt_name` varchar(100) DEFAULT '' COMMENT 'OPS owt_name',
  `owt_key` varchar(100) DEFAULT '' COMMENT 'OPS owt_key',
  `pdl_name` varchar(100) DEFAULT '' COMMENT 'OPS pdl_name',
  `pdl_key` varchar(100) DEFAULT '' COMMENT 'OPS pdl_key',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 COMMENT='测试团队\n创建人：yongda.chen';



CREATE TABLE `QD_HookResult` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `RequestId` int(11) DEFAULT '0',
  `CaseName` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `ErrorDetail` text COLLATE utf8mb4_unicode_ci,
  `ReasonID` tinyint(4) DEFAULT NULL,
  `Comment` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Errorlink` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Operator` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=212216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='暂留\n创建者：戴传飞';



CREATE TABLE `RES_Case` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CaseID` int(11) DEFAULT '-1',
  `UniqueID` varchar(50) DEFAULT '',
  `team_id` int(4) DEFAULT '0' COMMENT 'QA团队',
  `CaseType` int(2) DEFAULT '-1' COMMENT '用例类型1=Pigeon 2=Mapi 3=Http',
  `Source` int(2) DEFAULT '0' COMMENT '执行来源(0=未知,1=mvn,2=sql,3=web,4=api,5=testflow,6=lego job,7=hook job)',
  `Xml` text COMMENT 'xml文件',
  `Sql` text COMMENT '执行的sql',
  `TestID` int(10) DEFAULT '-1',
  `Report` mediumtext COMMENT 'case执行结果',
  `FailReason` text,
  `Result` int(2) DEFAULT '-1' COMMENT '测试结果(-1=异常,0=FAIL,1=PASS)',
  `ServiceID` text,
  `Mis` varchar(50) DEFAULT 'TestNG',
  `BuildNum` varchar(200) DEFAULT '' COMMENT 'job构建号',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `CaseID` (`CaseID`)
) ENGINE=InnoDB AUTO_INCREMENT=6056618 DEFAULT CHARSET=utf8 COMMENT='Case维度的执行Log\n备注：Report和FailReason字段未用到\n创建者：戴传飞';



CREATE TABLE `RES_CaseExec` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CaseID` int(11) DEFAULT '0',
  `CaseType` int(11) DEFAULT '0' COMMENT '1-pigeon 2-mapi 3-http 0-未知',
  `Success` int(11) DEFAULT '0' COMMENT '成功执行次数',
  `Fail` int(11) DEFAULT '0' COMMENT '失败执行次数',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '生成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33797 DEFAULT CHARSET=utf8 COMMENT='单个Case执行的成功失败次数\n创建者：戴传飞';



CREATE TABLE `RES_CovClass` (
  `ClassID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PackageID` int(11) DEFAULT '-1' COMMENT '与RES_CovPackage关联',
  `ClassName` varchar(200) DEFAULT '',
  `InstructionRate` int(3) DEFAULT '0',
  `BranchRate` int(3) DEFAULT '0',
  `LinesMis` int(11) DEFAULT NULL,
  `Lines` int(11) DEFAULT NULL,
  `CxtyMis` int(11) DEFAULT NULL,
  `Cxty` int(11) DEFAULT NULL,
  `ClassesMis` int(11) DEFAULT NULL,
  `Classes` int(11) DEFAULT NULL,
  `MethodsMis` int(11) DEFAULT NULL,
  `Methods` varchar(200) DEFAULT '',
  `BuildNum` varchar(20) DEFAULT '' COMMENT '构建号',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ClassID`)
) ENGINE=InnoDB AUTO_INCREMENT=966040 DEFAULT CHARSET=utf8 COMMENT='覆盖率数据-Class维度\n创建者：戴传飞';




CREATE TABLE `RES_CovMethod` (
  `MethodID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ClassID` int(11) DEFAULT '-1' COMMENT '与RES_CovClass表关联',
  `MethodName` varchar(200) DEFAULT '',
  `InstructionRate` int(3) DEFAULT '0',
  `BranchRate` int(3) DEFAULT '0',
  `LinesMis` int(11) DEFAULT NULL,
  `Lines` int(11) DEFAULT NULL,
  `CxtyMis` int(11) DEFAULT NULL,
  `Cxty` int(11) DEFAULT NULL,
  `MethodsMis` int(11) DEFAULT NULL,
  `Methods` int(11) DEFAULT NULL,
  `BuildNum` varchar(20) DEFAULT '',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MethodID`)
) ENGINE=InnoDB AUTO_INCREMENT=9757922 DEFAULT CHARSET=utf8 COMMENT='覆盖率数据-Method维度\n创建者：戴传飞';




CREATE TABLE `RES_CovOverall` (
  `OverallID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Team_ID` int(11) DEFAULT '-1',
  `JobID` int(11) DEFAULT '0' COMMENT '与RES_Job表的JobID字段关联',
  `AppName` varchar(200) DEFAULT '' COMMENT '与json文件的appname对应',
  `InstructionRate` int(11) DEFAULT '0' COMMENT '指令覆盖率',
  `BranchRate` int(11) DEFAULT '0' COMMENT '分支覆盖率',
  `Instructions` varchar(100) DEFAULT '' COMMENT '指令miss',
  `Branches` varchar(100) DEFAULT '' COMMENT '分支miss',
  `LinesMis` int(11) DEFAULT '0',
  `Lines` int(11) DEFAULT '0' COMMENT '行miss',
  `CxtyMis` int(11) DEFAULT '0',
  `Cxty` int(11) DEFAULT '0' COMMENT '复杂度',
  `ClassesMis` int(11) DEFAULT '0',
  `Classes` varchar(11) DEFAULT '',
  `MethodsMis` int(11) DEFAULT '0',
  `Methods` int(11) DEFAULT '0',
  `BuildNum` varchar(20) DEFAULT '' COMMENT '构建号',
  `CiTestTime` varchar(100) DEFAULT '',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OverallID`)
) ENGINE=InnoDB AUTO_INCREMENT=18109 DEFAULT CHARSET=utf8 COMMENT='覆盖率数据-汇总页维度\n创建者：戴传飞';




CREATE TABLE `RES_CovPackage` (
  `PackageID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `OverallID` int(11) DEFAULT '-1' COMMENT '与表RES_CovOverall关联',
  `PackageName` varchar(300) DEFAULT '',
  `InstructionRate` int(3) DEFAULT '0',
  `BranchRate` int(3) DEFAULT '0',
  `LinesMis` int(11) DEFAULT NULL,
  `Lines` int(11) DEFAULT NULL,
  `CxtyMis` int(11) DEFAULT NULL,
  `Cxty` int(11) DEFAULT NULL,
  `ClassesMis` int(11) DEFAULT NULL,
  `Classes` int(11) DEFAULT NULL,
  `MethodsMis` int(11) DEFAULT NULL,
  `Methods` int(11) DEFAULT NULL,
  `BuildNum` varchar(20) DEFAULT '',
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PackageID`)
) ENGINE=InnoDB AUTO_INCREMENT=213670 DEFAULT CHARSET=utf8 COMMENT='覆盖率数据-Package维度\n创建者：戴传飞';




CREATE TABLE `RES_FailReport` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ResCaseID` int(11) DEFAULT '0',
  `Report` longtext CHARACTER SET utf8mb4,
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=546309 DEFAULT CHARSET=utf8 COMMENT='执行失败的用例详细报告\nJob执行+本地执行，无web执行结果\n创建者：戴传飞';




CREATE TABLE `RES_Job` (
  `JobID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ProjectName` varchar(200) DEFAULT '',
  `team_id` int(4) DEFAULT '0' COMMENT 'QA团队',
  `Xml` varchar(200) DEFAULT '' COMMENT 'xml文件名',
  `ProjectUrl` text COMMENT 'CI链接',
  `Type` int(2) DEFAULT '0' COMMENT 'job类型(0=未知,1=lego job,2=hook job',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`JobID`)
) ENGINE=InnoDB AUTO_INCREMENT=737 DEFAULT CHARSET=utf8 COMMENT='Job信息，一个Url只有一条记录\n创建者：戴传飞';




CREATE TABLE `RES_Test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(4) DEFAULT '0' COMMENT 'QA团队',
  `JobID` int(11) DEFAULT '-1' COMMENT '关联RES_Job表的id',
  `CaseType` int(2) DEFAULT '-1' COMMENT '用例类型1=Pigeon 2=Mapi 3=Http',
  `Source` int(2) DEFAULT '0' COMMENT '执行来源(0=未知,1=mvn,2=sql,3=web,4=api,5=testflow,6=lego job,7=hook job)',
  `Xml` varchar(200) DEFAULT '' COMMENT 'xml文件名',
  `Sql` text COMMENT '执行的sql',
  `FailCaseID` text COMMENT '失败的ID集',
  `PassCaseID` text COMMENT '成功的ID集',
  `Fail` int(11) DEFAULT '0' COMMENT '失败case数',
  `Pass` int(11) DEFAULT '0' COMMENT '成功case数',
  `BuildNum` varchar(200) DEFAULT '' COMMENT 'Job构建号',
  `ProjectUrl` text COMMENT 'CI链接',
  `Result` int(2) DEFAULT '-1' COMMENT '测试结果(-1=异常,0=FAIL,1=PASS)',
  `ServiceID` text COMMENT '测试到的服务',
  `Mis` varchar(100) DEFAULT 'TestNG' COMMENT '操作者',
  `AddTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=839060 DEFAULT CHARSET=utf8 COMMENT='Test标签的执行结果Log数据\n创建者：戴传飞';



CREATE TABLE `SchemePics_Result` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `version1` varchar(11) DEFAULT NULL,
  `version2` varchar(11) DEFAULT NULL,
  `bu` int(11) DEFAULT NULL,
  `paltform` varchar(100) DEFAULT NULL,
  `AddTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;







