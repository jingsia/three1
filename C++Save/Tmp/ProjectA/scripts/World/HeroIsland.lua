
AttrExtra = {
    strength = 0,
    physique = 0,
    agility = 0,
    intelligence = 0,
    will = 0,
    soul = 0,
    aura = 0,
    auraMax = 0,
    attack = 0,
    magatk = 0,
    defend = 0,
    magdef = 0,
    hp = 0,
    tough = 0,
    action = 0,
    hitrate = 0,
    evade = 0,
    critical = 0,
    criticaldmg = 0,
    pierce = 0,
    counter = 0,
    magres = 0
};

function AttrExtra:Instance(o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;	
end

local minLevel = 40

local rareAnimals = {
    -- 力量 耐力 敏捷 智力 意志 元神 作用士气 最大灵气 物攻 法术攻击 物防 法术防御 HP 坚韧 身法 命中 闪避 暴击 暴击伤害 击破/护甲穿透 反击 法术抵抗
    [5489] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0},60,120,1},
    [5490] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0},120,330,1},
    [5491] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0},120,420,1},
    [5492] = {{0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0},120,510,1},
    [5493] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,0,15,0,0},180,600,1},
    [5494] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0},60,150,2},
    [5495] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0},60,240,2},
    [5496] = {{0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0},120,450,2},
    [5497] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0},120,540,2},
    [5498] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,15,0},180,630,2},
    [5499] = {{0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0},60,180,3},
    [5500] = {{0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0},60,270,3},
    [5501] = {{0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0},120,360,3},
    [5502] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0},120,570,3},
    [5503] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,0,15},180,660,3},
    [5504] = {{0,0,0,0,0,0,0,0,15,15,0,0,0,0,0,0,0,0,0,0,0,0},120,300,4},
    [5505] = {{0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,15,0,0,0,0,0,0},120,390,4},
    [5506] = {{0,0,0,0,0,0,0,0,0,0,15,15,0,0,0,0,0,0,0,0,0,0},120,480,4},
    [5507] = {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10},60,210,4},
    [5508] = {{0,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},180,690,4},
}

--  奖励
local awards = {
    -- 物品ID 物品个数 概率
    [1] = {
        {1,400,100},
        {1,500,100},
        {1,600,100},
        {1,700,100},
        {1,800,100},
        {2,6,100},
        {2,7,100},
        {2,8,100},
        {2,9,100},
        {2,10,100},
        {4,10,100},
        {51,1,50},
        {55,1,50},
        {0, 0, 0} --  这一行必不可少
    },
    [2] = {
        {1,1000,100},
        {1,1200,100},
        {1,1400,100},
        {1,1600,100},
        {1,1800,100},
        {2,12,100},
        {2,14,100},
        {2,16,100},
        {2,18,100},
        {2,20,100},
        {3,10,100},
        {3,20,100},
        {3,30,100},
        {4,20,100},
        {48,1,100},
        {55,1,100},
        {502,1,100},
        {510,1,100},
        {5001,1,6},
        {5011,1,6},
        {5021,1,6},
        {5031,1,6},
        {5041,1,6},
        {5051,1,6},
        {5061,1,6},
        {5071,1,6},
        {5081,1,6},
        {5091,1,6},
        {5101,1,6},
        {5111,1,6},
        {5121,1,6},
        {5131,1,6},
        {5141,1,6},
        {0, 0, 0} --  这一行必不可少
    },
    [3] = {
        {1,2000,100},
        {1,2400,100},
        {1,2800,100},
        {1,3200,100},
        {1,3600,100},
        {2,24,100},
        {2,28,100},
        {2,32,100},
        {2,36,100},
        {2,40,100},
        {3,50,100},
        {3,60,100},
        {3,70,100},
        {3,80,100},
        {3,90,100},
        {4,30,100},
        {4,40,100},
        {4,50,100},
        {49,1,100},
        {500,1,100},
        {502,1,100},
        {5001,1,6},
        {5011,1,6},
        {5021,1,6},
        {5031,1,6},
        {5041,1,6},
        {5051,1,6},
        {5061,1,6},
        {5071,1,6},
        {5081,1,6},
        {5091,1,6},
        {5101,1,6},
        {5111,1,6},
        {5121,1,6},
        {5131,1,6},
        {5141,1,6},
        {0, 0, 0} --  这一行必不可少
    },
    [4] = {
        {1,4000,100},
        {1,4600,100},
        {1,5200,100},
        {1,5800,100},
        {1,6400,100},
        {2,50,100},
        {2,60,100},
        {2,70,100},
        {2,80,100},
        {2,90,100},
        {3,100,100},
        {3,120,100},
        {3,140,100},
        {3,160,100},
        {3,180,100},
        {4,60,100},
        {4,70,100},
        {4,80,100},
        {30,1,100},
        {506,1,100},
        {508,1,100},
        {5003,1,3},
        {5013,1,3},
        {5023,1,3},
        {5033,1,3},
        {5043,1,3},
        {5053,1,3},
        {5063,1,3},
        {5073,1,3},
        {5083,1,3},
        {5093,1,3},
        {5103,1,3},
        {5113,1,3},
        {5123,1,3},
        {5133,1,3},
        {5143,1,3},
        {0, 0, 0} --  这一行必不可少
    },
}

-- 声望奖励
local awards1 = {
    120,
    110,
    100,
    90,
    80,
    70,
    60,
    50,
    40,
    30,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
    20,
}

function loadRareAnimals()
    clearAllHICfg()
    local attr = AttrExtra:Instance(AttrExtra)
    for k,v in pairs(rareAnimals)
    do
        attr.strength = v[1][1]
        attr.physique = v[1][2]
        attr.agility = v[1][3]
        attr.intelligence = v[1][4]
        attr.will = v[1][5]
        attr.soul = v[1][6]
        attr.aura = v[1][7]
        attr.auraMax = v[1][8]
        attr.attack = v[1][9]
        attr.magatk = v[1][10]
        attr.defend = v[1][11]
        attr.magdef = v[1][12]
        attr.hp = v[1][13]
        attr.tough = v[1][14]
        attr.action = v[1][15]
        attr.hitrate = v[1][16]
        attr.evade = v[1][17]
        attr.critical = v[1][18]
        attr.criticaldmg = v[1][19]
        attr.pierce = v[1][20]
        attr.counter = v[1][21]
        attr.magres = v[1][22]
        setRareAnimals(v[4], k, attr, v[2], v[3]);
    end

    -- here ^_^
    loadHIAwardsCfg()
    loadRankAwards()
end

function loadHIAwardsCfg()
    for k1,v1 in pairs(awards)
    do
        for k,v in pairs(v1)
        do
            addHIAwardsCfg(k1, v[1], v[2], v[3]);
        end
    end
end

function loadRankAwards()
    for k,v in pairs(awards1)
    do
        addRankAwards(v);
    end
end

--新英雄岛技能
local NewHeroIslandBuffs = {
--CD(秒) 攻击%  防御%   生命%  身法%   命中%   闪避%   暴击%   暴击伤害% 破击%  反击% 法术抵抗% 入场灵气(值) 持续cd(秒)
  {600,  0,   0,   10,  0,   0,   0,  0,   0,   0,   0,  0,   0,  30},
  {600,  30,  0,   0,   0,   0,   0,  0,   0,   0,   0,  0,   0,  30},
  {600,  0,   30,  0,   0,   0,   0,  0,   0,   0,   0,  0,   0,  30},
  {600,  0,   0,   0,   0,   0,   0,  0,   0,   0,   0,  0,   25, 30},
  {600,  0,   0,   0,   10,  10,  0,  10,  30,  10,  0,  0,   0,  30},

}

function getNewHeroIslandBuffs()
    return NewHeroIslandBuffs
end

