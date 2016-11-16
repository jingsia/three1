
SET NAMES UTF8;

source lvlexp

LOCK TABLES `map` WRITE;
source map
UNLOCK TABLES;

LOCK TABLES `special_fighter_template` WRITE;
source npc
UNLOCK TABLES;

LOCK TABLES `weapon_def` WRITE;
INSERT INTO `weapon_def` VALUES
(1,'剑',3,1,1),
(2,'锤',1,3,1),
(3,'枪',1,4,1),
(4,'弓',2,7,0),
(5,'飞刀',2,5,0),
(6,'鞭',4,2,1),
(7,'军扇',4,6,0),
(10,'全屏',0,10,0),
(11,'怪物1',0,1,1),
(12,'怪物2',0,1,1),
(13,'怪物3',0,1,1),
(14,'怪物4',0,1,1),
(15,'怪物5',0,1,1),
(129,'NPC剑',0,1,1),
(130,'NPC锤',0,3,1),
(131,'NPC枪',0,4,1),
(133,'NPC飞刀',0,5,0),
(134,'NPC鞭',0,2,1),
(135,'NPC军扇',0,6,0),
(146,'全屏锤',0,10,1),
(147,'全屏枪',0,10,1),
(150,'全屏鞭',0,10,1);
UNLOCK TABLES;

LOCK TABLES `attr_extra` WRITE;
source attrextra
UNLOCK TABLES;

LOCK TABLES `item_template` WRITE;
source itemtemplate
UNLOCK TABLES;

LOCK TABLES `npc_group` WRITE;
source npcgroup
UNLOCK TABLES;

LOCK TABLES `map_spot` WRITE;
source mapspot
UNLOCK TABLES;

LOCK TABLES `map_object` WRITE;
source mapobject
UNLOCK TABLES;

LOCK TABLES `loot` WRITE;
source loot
UNLOCK TABLES;

LOCK TABLES `skills` WRITE;
source skills
UNLOCK TABLES;

LOCK TABLES `skill_effect` WRITE;
source skilleffect
UNLOCK TABLES;

LOCK TABLES `cittas` WRITE;
source cittas 
UNLOCK TABLES;

LOCK TABLES `citta_effect` WRITE;
source cittaeffect
UNLOCK TABLES;

LOCK TABLES `area` WRITE;
source area
UNLOCK TABLES;

LOCK TABLES `fighter_prob` WRITE;
source fighterprob
UNLOCK TABLES;

LOCK TABLES `acupra` WRITE;
source acupra
UNLOCK TABLES;

LOCK TABLES `clan_skill_template` WRITE;
source clanskill
UNLOCK TABLES;

LOCK TABLES `clan_tech_template` WRITE;
source clantech
UNLOCK TABLES;

LOCK TABLES `clan_lvl` WRITE;
source clanlvl
UNLOCK TABLES;


LOCK TABLES `dungeon` WRITE;
source dungeon
UNLOCK TABLES;

LOCK TABLES `dungeon_level` WRITE;
source dungeonlevel
UNLOCK TABLES;

LOCK TABLES `dungeon_monster` WRITE;
source dungeonmonster
UNLOCK TABLES;

LOCK TABLES `formation` WRITE;
source formation
UNLOCK TABLES;

LOCK TABLES `copy` WRITE;
source copy
UNLOCK TABLES;

LOCK TABLES `frontmap` WRITE;
source frontmap
UNLOCK TABLES;

LOCK TABLES `equipment_set` WRITE;
source equipmentset
UNLOCK TABLES;

LOCK TABLES `towndeamon_monster` WRITE;
source towndeamonmonster
UNLOCK TABLES;

LOCK TABLES `team_copy` WRITE;
source teamcopy
UNLOCK TABLES;

LOCK TABLES `soul_skill_template` WRITE;
source soulskilltemplate
UNLOCK TABLES;

LOCK TABLES `soul_lvl_exp` WRITE;
source soullvlexp
UNLOCK TABLES;

LOCK TABLES `soul_item_exp` WRITE;
source soulitemexp
UNLOCK TABLES;

LOCK TABLES `eupgrade` WRITE;
source eupgrade
UNLOCK TABLES;

LOCK TABLES `spirit_attr` WRITE;
source spiritattr
UNLOCK TABLES;

LOCK TABLES `skillstrengthen` WRITE;
source skillstrengthen
UNLOCK TABLES;

LOCK TABLES `skillstrengthenprob` WRITE;
source skillstrengthenprob
UNLOCK TABLES;

LOCK TABLES `skillstrengthen_skill` WRITE;
source skillstrengthen_skill
UNLOCK TABLES;

LOCK TABLES `skillstrengthen_effect` WRITE;
source skillstrengthen_effect
UNLOCK TABLES;

LOCK TABLES `clan_statue_template` WRITE;
source clanstatuetemplate
UNLOCK TABLES;

LOCK TABLES `clan_copy_monster_template` WRITE;
source clancopymonstertemplate
UNLOCK TABLES;

LOCK TABLES `clan_copy_template` WRITE;
source clancopytemplate
UNLOCK TABLES;

LOCK TABLES `lbskills` WRITE;
source lbskills
UNLOCK TABLES;

LOCK TABLES `dreamer_template` WRITE;
source dreamer_template
UNLOCK TABLES;

LOCK TABLES `pet_pinjie` WRITE;
source pet_pinjie
UNLOCK TABLES;

LOCK TABLES `pet_gengu` WRITE;
source pet_gengu
UNLOCK TABLES;

LOCK TABLES `pet_pressure` WRITE;
source pet_pressure
UNLOCK TABLES;

LOCK TABLES `pet_levelup` WRITE;
source pet_levelup;
UNLOCK TABLES;

LOCK TABLES `pet_neidan` WRITE;
source pet_neidan;
UNLOCK TABLES;

LOCK TABLES `xingchen` WRITE;
source xingchen;
UNLOCK TABLES;

LOCK TABLES `jiguanshu` WRITE;
source jiguanshu;
UNLOCK TABLES;

LOCK TABLES `jiguanyu` WRITE;
source jiguanyu;
UNLOCK TABLES;

LOCK TABLES `tuzhi` WRITE;
source tuzhi;
UNLOCK TABLES;

LOCK TABLES `signet` WRITE;
source signet;
UNLOCK TABLES;

LOCK TABLES `pet_sanhun` WRITE;
source pet_sanhun;
UNLOCK TABLES;

LOCK TABLES `zhenwei` WRITE;
source zhenwei;
UNLOCK TABLES;

LOCK TABLES `acupragold` WRITE;
source acupragold
UNLOCK TABLES;

LOCK TABLES `coupleinfo` WRITE;
source coupleinfo;
UNLOCK TABLES;

LOCK TABLES `petteamcopy` WRITE;
source petteamcopy;
UNLOCK TABLES;


LOCK TABLES `cardInfo` WRITE;
source cardInfo;
UNLOCK TABLES;

LOCK TABLES `cardupgrade` WRITE;
source cardupgrade;
UNLOCK TABLES;

LOCK TABLES `erlking` WRITE;
source erlking;
UNLOCK TABLES;

LOCK TABLES `newquestions` WRITE;
source newquestions;
UNLOCK TABLES;

LOCK TABLES `gear` WRITE;
source gear;
UNLOCK TABLES;

LOCK TABLES `geartree` WRITE;
source geartree;
UNLOCK TABLES;
