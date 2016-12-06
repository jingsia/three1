DROP TABLE IF EXISTS `equip`;
CREATE TABLE `equip`(
	`id` int(10) NOT NULL,
	`attPhy` int(10) NOT NULL DEFAULT '0',
	`defPhy` int(10) NOT NULL DEFAULT '0',
	`attMag` int(10) NOT NULL DEFAULT '0',
	`defMag` int(10) NOT NULL DEFAULT '0',
	`konck`  int(10) NOT NULL DEFAULT '0',
	`defKnock` int(10) NOT NULL DEFAULT '0',
	`hit` int(10) NOT NULL DEFAULT '0',
	`dodge` int(10) NOT NULL DEFAULT '0',
	PRIMARY KEY(`id`)
)ENGINE=MyISAM DEFAULT CHARSET=utf8;
