-- MySQL dump 10.13  Distrib 5.1.53, for pc-linux-gnu (x86_64)                                                                    
--
-- Host: localhost    Database: asss
-- ------------------------------------------------------
-- Server version   5.1.53-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

SET NAMES UTF8;
DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
    `id` bigint(20) unsigned NOT NULL,
    `name` varchar(255) NOT NULL,

    PRIMARY KEY (`id`),
    KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `gvar`;  
CREATE TABLE `gvar` (
    `id` int(10) unsigned NOT NULL,
    `data` int(10) unsigned NOT NULL,
    `over` int(10) unsigned NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `var`; 
CREATE TABLE `var` (
    `playerId` bigint(10) unsigned NOT NULL,
    `id` smallint(5) NOT NULL,
    `data` int(10) unsigned NOT NULL,
    `over` int(10) unsigned NOT NULL,
    PRIMARY KEY (`playerId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `player_id`; 
CREATE TABLE `player_id` (
    `id` bigint(20) unsigned NOT NULL,
    `phoneId` varchar(255) NOT NULL DEFAULT '',
    `accounts` varchar(255) NOT NULL DEFAULT '',   /*帐号*/
    /*PRIMARY KEY (`phoneId`,`accounts`)*/
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fvar`; 
CREATE TABLE `fvar` (
    `playerId` bigint(10) unsigned NOT NULL,
    `fighterId` int(10) unsigned NOT NULL,
    `id` smallint(5) NOT NULL,
    `data` int(10) unsigned NOT NULL,
    `over` int(10) unsigned NOT NULL,
    PRIMARY KEY (`playerId`,`fighterId`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `fighter`; 
CREATE TABLE `fighter` (
    `playerId` bigint(10) unsigned NOT NULL,
    `fighterId` int(10) unsigned NOT NULL,
    `experience` bigint(20) unsigned NOT NULL DEFAULT '0',
    `weapon` int(10) unsigned NOT NULL DEFAULT '0',
    `armor1` int(10) unsigned NOT NULL DEFAULT '0',
    `armor2` int(10) unsigned NOT NULL DEFAULT '0',
    `armor3` int(10) unsigned NOT NULL DEFAULT '0',
    `armor4` int(10) unsigned NOT NULL DEFAULT '0',
    `armor5` int(10) unsigned NOT NULL DEFAULT '0',
    `addTime` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`fighterId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `friends`; 
CREATE TABLE `friends` (
    `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `playerId` bigint(20) unsigned NOT NULL,
    `friendId` bigint(20) unsigned NOT NULL,
    PRIMARY KEY (`type`,`playerId`,`friendId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `item`; 
CREATE TABLE `item` (
    `playerId` bigint(20) unsigned NOT NULL,
    `itemId` int(10) unsigned NOT NULL DEFAULT '0',
    `count` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`itemId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `clan`; 
CREATE TABLE `clan` (
    `clanId` int(10) unsigned NOT NULL DEFAULT '0',
    `name` varchar(255) NOT NULL DEFAULT '',   /*帐号*/
    `picIndex` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `announcement` varchar(255) NOT NULL DEFAULT '',   /*帐号*/
    `announcement2` varchar(255) NOT NULL DEFAULT '',   /*帐号*/
    `creater` bigint(20) unsigned NOT NULL,
    `leader` bigint(20) unsigned NOT NULL,
    `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `contribute` int(10) unsigned NOT NULL DEFAULT '0',
    `personMax` tinyint(3) unsigned NOT NULL DEFAULT '50',
    `battleRoomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公会战房间id',
    `clanFame` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公会声望',
    `conquests` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公会战绩',
    `forceId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '公会战所属势力',
    PRIMARY KEY (`clanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `clan_player`; 
CREATE TABLE `clan_player` (
    `clanId` int(10) unsigned NOT NULL DEFAULT '0',
    `playerId` bigint(20) unsigned NOT NULL,
    `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `contribute` int(10) unsigned NOT NULL DEFAULT '0',
    `enterTime` int(10) unsigned NOT NULL DEFAULT '0',
    `isClanBattle` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否参加公会战',
    PRIMARY KEY (`clanId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `mail`; 
CREATE TABLE `mail` (
    `id` int(10) unsigned NOT NULL DEFAULT '0',
    `playerId` bigint(20) unsigned NOT NULL,
    `contextId` int(10) unsigned NOT NULL DEFAULT '0',
    `items` varchar(255) NOT NULL,
    `option` tinyint(3) NOT NULL DEFAULT '0',
    `overTime` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `player_apply_clan`; 
CREATE TABLE `player_apply_clan` (
    `clanId` int(10) unsigned NOT NULL DEFAULT '0',
    `playerId` bigint(20) unsigned NOT NULL,
    `time` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`ClanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `reportid`; 
CREATE TABLE `reportid` (
    `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `maxid` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `clan_battle_pos`; 
CREATE TABLE `clan_battle_pos` (
    `roomId`   int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间id',
    `mapId`    tinyint(3)  unsigned NOT NULL DEFAULT '0' COMMENT '地图id',
    `playerId` bigint(20) unsigned NOT NULL COMMENT '玩家Id',
    `fighterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '战将id',
    `posx`     int(3) unsigned NOT NULL DEFAULT '0' COMMENT '地图上的坐标x',
    `posy`     int(3) unsigned NOT NULL DEFAULT '0' COMMENT '地图上的坐标y',
    `mainFighterHP` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '主将血量',
    `soldiersHP` varchar(1024) NOT NULL DEFAULT '' COMMENT '小兵们的血量',
    PRIMARY KEY (`roomId`,`mapId`,`playerId`,`fighterId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `clan_battle_room`; 
CREATE TABLE `clan_battle_room` (
    `roomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间Id',
    `forceId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '势力Id',
    `battleId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '战役Id',
    `clans`    varchar(1024) NOT NULL DEFAULT '' COMMENT '军团id们',
    `fighterNum` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '某一势力的战将数量',
    `buildTime`  int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建房间的时间',
    PRIMARY KEY (`roomId`,`forceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `clan_battle_comment`; 
CREATE TABLE `clan_battle_comment` (
    `roomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间Id',
    `forceId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '势力Id',
    `mapId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '地图id',
    `playerId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '留言者Id',
    `message` varchar(1024) NOT NULL DEFAULT '' COMMENT '留言',
    PRIMARY KEY (`roomId`,`forceId`,`mapId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `clan_battle_order`; 
CREATE TABLE `clan_battle_order` (
    `roomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间Id',
    `forceId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '势力Id',
    `mapId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '地图id',
    `order` tinyint(3)  NOT NULL DEFAULT '0' COMMENT '军团令',
    PRIMARY KEY (`roomId`,`forceId`,`mapId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `report2id`; 
CREATE TABLE `report2id` (
    `roomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间Id',
    `cityId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '城市Id',
    `actId`  int(3) unsigned NOT NULL DEFAULT '0' COMMENT '回合Id',
    `reportId` int(10)  NOT NULL DEFAULT '0' COMMENT '战术战报Id',
    `time`  int(10) NOT NULL DEFAULT '0' COMMENT '战术发生时间',
    PRIMARY KEY (`roomId`,`cityId`,`actId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `clan_battle_citystatus`; 
CREATE TABLE `clan_battle_citystatus` (
    `roomId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房间Id',
    `battleId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '战役Id',
    `cityId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '城市Id',
    `ownforce`  tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '这座城被哪个势力占领了',
    PRIMARY KEY (`roomId`,`cityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `account_pwd` (
      `accounts` varchar(255) NOT NULL DEFAULT '',
      `password` varchar(255) NOT NULL DEFAULT '',
      PRIMARY KEY (`accounts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `arenaLayout`; 
CREATE TABLE `arenaLayout` (
    `playerId` bigint(20) unsigned NOT NULL,
    `index` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '战役Id',
    `fighterId`  int(10) NOT NULL DEFAULT '0' COMMENT '战术发生时间',
    PRIMARY KEY (`playerId`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `storeA`; 
CREATE TABLE `storeA` (
    `playerId` bigint(20) unsigned NOT NULL COMMENT '玩家Id',
    `pageId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '页面id',
    `index`  tinyint(10) NOT NULL DEFAULT '0' COMMENT '位置Id',
    `limitCount`  int(10) NOT NULL DEFAULT '0' COMMENT '剩余的物品数量',
    PRIMARY KEY (`playerId`,`pageId`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*竞技场信息*/
DROP TABLE IF EXISTS `arenaRobot`; 
CREATE TABLE `arenaRobot` (
    `index` int(10) unsigned NOT NULL,
    `firstIndex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '机器人初始编号',
    `robotId`  int(10) NOT NULL  COMMENT '机器人编号',
    PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `arenaBrp`; 
CREATE TABLE `arenaBrp` (
    `playerId` bigint(20) unsigned NOT NULL,
    `battleId` int(10) unsigned NOT NULL,
    `res` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '胜负',
    `name` varchar(255) NOT NULL,
    /*`playerId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '对象编号',*/
    `index` int(10) unsigned NOT NULL COMMENT '排名',
    `power` int(10) unsigned NOT NULL COMMENT '战斗力',
    PRIMARY KEY (`battleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*安民点信息*/
DROP TABLE IF EXISTS `quietPoints`; 
CREATE TABLE `quietPoints` (
    `id` tinyint(3) unsigned NOT NULL COMMENT '安民点编号',
    `playerId` bigint(20) unsigned NOT NULL COMMENT '玩家Id',
    `fighterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '战将id',
    `level`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '安民点等级',
    PRIMARY KEY (`id`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*采集点*/
DROP TABLE IF EXISTS `exploit`; 
CREATE TABLE `exploit` (
    `id` tinyint(3) unsigned NOT NULL COMMENT '采集点编号',
    `playerId` bigint(20) unsigned NOT NULL COMMENT '玩家Id',
    `level`  tinyint(3) NOT NULL DEFAULT '0' COMMENT '采集点等级',
    `fighterId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '战将id',
    PRIMARY KEY (`id`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*竞技场信息*/

/********************************************************************/
DROP TABLE IF EXISTS `equipment`
CREATE TABLE `equipment` (
	`id` int(10) unsigned NOT NULL,
	`itemId` int(10) unsigned NOT NULL,
	`enchant` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`tRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`maxTRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`trumpExp` int(10) unsigned NOT NULL DEFAULT '0',
	`attrType1` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`attrValue1` smallint(6) NOT NULL DEFAULT '0',
	`attrType2` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`attrValue2` smallint(6) NOT NULL DEFAULT '0',
	`attrType3` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`attrValue3` smallint(6) NOT NULL DEFAULT '0',
	`socket1` int(10) unsigned NOT NULL DEFAULT '0',
	`socket2` int(10) unsigned NOT NULL DEFAULT '0',
	`socket3` int(10) unsigned NOT NULL DEFAULT '0',
	`socket4` int(10) unsigned NOT NULL DEFAULT '0',
	`socket5` int(10) unsigned NOT NULL DEFAULT '0',
	`socket6` int(10) unsigned NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `item`; 
CREATE TABLE `item` (
    `playerId` bigint(20) unsigned NOT NULL,
    `itemId` int(10) unsigned NOT NULL DEFAULT '0',
    `count` int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`itemId`,`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `player`;
CREATE TABLE `player` (
	`id` bigint(20) unsigined NOT NULL,
	`name` varchar(255) NOT NULL,
	`gold` int(10) unsigned NOT NULL DEFAULT '0',
	`coupon` int(10) unsigned NOT NULL DEFAULT '0',
	`tael` int(10) unsigned NOT NULL DEFAULT '0',
	`coin` int(10) unsigned NOT NULL DEFAULT '100000',
	`prestige` int(10) unsigned NOT NULL DEFAULT '0',
	`status` int(10) unsigned NOT NULL DEFAULT '0',
	`country` tinyint(1) unsigned NOT NULL,
	`title` smallint(5) unsigned NOT NULL DEFAULT '0',
	`titleAll` varchar(2048) NOT NULL DEFAULT '',
	`archievement` int(10) unsigned NOT NULL DEFAULT '0',
	`attainment` int(10) unsigned NOT NULL DEFAULT '0',
	`qqVip1` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`qqVipYear` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`qqawardgot` int(11) unsigned NOT NULL DEFAULT '0',
	`qqawardEnd` int(10) unsigned NOT NULL DEFAULT '0',
	`ydGemId` int(10) unsigned NOT NULL DEFAULT '0',
	`location` smallint(5) unsigned NOT NULL,
	`inCity` tinyint(1) unsigned NOT NULL DEFAULT '1',
	`lastOnline` int(10) unsigned NOT NULL DEFAULT '0',
	`packSize` smallint(4) unsigned NOT NULL DEFAULT '100',
	`packSizeSoul` smallint(4) unsigned NOT NULL DEFAULT '200',
	`mounts` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`mainFighter` int(10) unsigned NOT NULL DEFAULT '0',
	`icCount` varchar(32) NOT NULL DEFAULT '',
	`piccount` tinyint(2) unsigned NOT NULL DEFAULT '0',
	`nextpicreset` int(10) unsigned NOT NULL DEFAULT '0',
	`formation` smallint(5) unsigned NOT NULL DEFAULT '0',
	`lineup` varchar(255) NOT NULL DEFAULT '',
	`bossLevel` smallint(4) unsigned NOT NULL DEFAULT '21',
	`totalRecharge` int(10) unsigned NOT NULL DEFAULT '0',
	`lastExp` int(10) unsigned NOT NULL DEFAULT '0',
	`lastResource` bigint(20) unsigned NOT NULL DEFAULT '0',
	`nextReward` varchar(32) NOT NULL DEFAULT '',
	`nextExtraReward` int(10) unsigned NOT NULL DEFAULT '0',
	`tavernId` varchar(255) NOT NULL DEFAULT '',
	`bookStore` varchar(255) NOT NULL DEFAULT '0',
	`shimen` varchar(255) NOT NULL DEFAULT '',
	`fshimen` varchar(255) NOT NULL DEFAULT '',
	`yamen` varchar(255) NOT NULL DEFAULT '',
	`fyamen` varchar(255) NOT NULL DEFAULT '',
	`clantask` varchar(255) NOT NULL DEFAULT '',
	`copyFreeCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`copyGoldCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`copyUpdate` int(10) unsigned NOT NULL DEFAULT '0',
	`frontFreeCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`frontGoldCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`frontUpdate` int(10) unsigned NOT NULL DEFAULT '0',
	`fromations` varchar(255) NOT NULL DEFAULT '',
	`zhenyuans` varchar(1024) NOT NULL DEFAULT '',
	`atohicfg` varchar(255) NOT NULL DEFAULT '',
	`gmLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`wallow` tinyint(1) unsigned NOT NULL DEFAULT '1',
	`dungeonCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`dungeonEnd` int(10) unsigned NOT NULL DEFAULT '0',
	`newGuild` bigint(20) unsigned NOT NULL DEFAULT '0',
	`created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`openid` varchar(1024) NOT NULL DEFAULT '',
	`canHirePet` varchar(2048) NOT NUL DEFAULT '',
	`dungeonCnt1` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`xifrontFreeCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`xifrontGoldCnt` tinyint(3) unsigned NOT NULL DEFAULT '0',
	`xifrontUpdate` int(10) unsigned NOT NULL DEFAULT '0',
	`clancontrishop` varchar(1024) NOT NULL DEFAULT '',
	`announcement` varchar(1024) NOT NULL DEFAULT '',
	`sscq2name` varchar(32) NOT NULL DEFAULT '',
	`TYssCirtFlag` tinyint(3) unsigned NOT NULL DEFAULT '0',
	PRIMARY KEY('id'),
	KEY `name` (`name`),
	KEY `mainFighter` (`mainFighter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `petEquipattr`
CREATE TABLE `petEquipattr` (
	`id` int(10) unsigned NOT NULL,
	`level` tinyint(3) unsigned NOT NULL,
	`exp` int(10) unsigned NOT NULL,
	`skillId` int(10) unsigned NOT NULL DEFAULT '0',
	`socket1` smallint(10) unsigned NOT NULL,
	`socket2` smallint(10) unsigned NOT NULL,
	`socket3` smallint(10) unsigned NOT NULL,
	`socket4` smallint(10) unsigned NOT NULL,
	`socket5` smallint(10) unsigned NOT NULL,
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
