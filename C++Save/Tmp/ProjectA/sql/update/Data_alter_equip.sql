alter TABLE `equip` add column `hp` int(10) NOT NULL DEFAULT '0' after `id`;
alter table `equip` change  column `konck` `knock` int(10);
