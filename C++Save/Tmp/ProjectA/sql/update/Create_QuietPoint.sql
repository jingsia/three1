DROP TABLE IF EXISTS `quietPoints`; 
CREATE TABLE `quietPoints` (
    `id` tinyint(3) unsigned NOT NULL COMMENT '安民点编号',                                                                                                                
    `playerId` bigint(20) unsigned NOT NULL COMMENT '玩家Id',
    `fighterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '战将id',
    `level`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '安民点等级',
    PRIMARY KEY (`id`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

