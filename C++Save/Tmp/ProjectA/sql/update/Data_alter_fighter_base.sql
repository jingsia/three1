alter TABLE `fighter_base` add column `mp` int(10) NOT NULL DEFAULT '0' after `hp`;
alter TABLE `fighter_base` add column `cloth` int(10) NOT NULL DEFAULT '0' after `evade`;
alter TABLE `fighter_base` add column `head` int(10) NOT NULL DEFAULT '0' after `cloth`;
alter TABLE `fighter_base` add column `shoes` int(10) NOT NULL DEFAULT '0' after `head`;
alter TABLE `fighter_base` add column `weapon` int(10) NOT NULL DEFAULT '0' after `shoes`;
