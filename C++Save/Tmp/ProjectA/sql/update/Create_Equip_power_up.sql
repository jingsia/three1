DROP TABLE IF EXISTS `equip_power_up`;
CREATE TABLE `equip_power_up`(
	`id` smallint(5) NOT NULL DEFAULT '0',
	`lvl` tinyint(3) NOT NULL DEFAULT '0',
	`powerUp` tinyint(3) NOT NULL DEFAULT '0' COMMENT '百分值',
	`cost` varchar(255) NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
