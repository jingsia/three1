local TaelTrain = {
	{ 1,  170, 1000 }
};
	
local GoldTrain = {
	{ 1, 170,  10 }
};
	
local LevelTrainExp = {
{ 1, 175 },
{ 2, 175 },
{ 3, 175 },
{ 4, 175 },
{ 5, 175 },
{ 6, 175 },
{ 7, 175 },
{ 8, 175 },
{ 9, 175 },
{ 10, 175 },
{ 11, 175 },
{ 12, 175 },
{ 13, 175 },
{ 14, 175 },
{ 15, 175 },
{ 16, 175 },
{ 17, 175 },
{ 18, 175 },
{ 19, 175 },
{ 20, 175 },
{ 21, 175 },
{ 22, 175 },
{ 23, 175 },
{ 24, 175 },
{ 25, 175 },
{ 26, 185 },
{ 27, 195 },
{ 28, 205 },
{ 29, 215 },
{ 30, 325 },
{ 31, 340 },
{ 32, 355 },
{ 33, 370 },
{ 34, 385 },
{ 35, 400 },
{ 36, 415 },
{ 37, 430 },
{ 38, 445 },
{ 39, 460 },
{ 40, 625 },
{ 41, 645 },
{ 42, 665 },
{ 43, 685 },
{ 44, 705 },
{ 45, 725 },
{ 46, 745 },
{ 47, 765 },
{ 48, 785 },
{ 49, 805 },
{ 50, 1025 },
{ 51, 1050 },
{ 52, 1075 },
{ 53, 1100 },
{ 54, 1125 },
{ 55, 1150 },
{ 56, 1175 },
{ 57, 1200 },
{ 58, 1225 },
{ 59, 1250 },
{ 60, 1525 },
{ 61, 1555 },
{ 62, 1585 },
{ 63, 1615 },
{ 64, 1645 },
{ 65, 1675 },
{ 66, 1705 },
{ 67, 1735 },
{ 68, 1765 },
{ 69, 1795 },
{ 70, 2125 },
{ 71, 2160 },
{ 72, 2195 },
{ 73, 2230 },
{ 74, 2265 },
{ 75, 2300 },
{ 76, 2335 },
{ 77, 2370 },
{ 78, 2405 },
{ 79, 2440 },
{ 80, 2825 },
{ 81, 2865 },
{ 82, 2905 },
{ 83, 2945 },
{ 84, 2985 },
{ 85, 3025 },
{ 86, 3065 },
{ 87, 3105 },
{ 88, 3145 },
{ 89, 3185 },
{ 90, 3625 },
{ 91, 3670 },
{ 92, 3715 },
{ 93, 3760 },
{ 94, 3805 },
{ 95, 3850 },
{ 96, 3895 },
{ 97, 3940 },
{ 98, 3985 },
{ 99, 4030 },
{ 100, 4075 },
{ 101, 4120 },
{ 102, 4165 },
{ 103, 4210 },
{ 104, 4255 },
{ 105, 4300 },
{ 106, 4345 },
{ 107, 4390 },
{ 108, 4435 },
{ 109, 4480 },
{ 110, 4525 },
{ 111, 4570 },
{ 112, 4615 },
{ 113, 4660 },
{ 114, 4705 },
{ 115, 4750 },
{ 116, 4795 },
{ 117, 4840 },
{ 118, 4885 },
{ 119, 4930 },
{ 120, 4975 },
{ 121, 5020 },
{ 122, 5065 },
{ 123, 5110 },
{ 124, 5155 },
{ 125, 5200 },
{ 126, 5245 },
{ 127, 5290 },
{ 128, 5335 },
{ 129, 5380 },
{ 130, 5425 },
{ 131, 5470 },
{ 132, 5515 },
{ 133, 5560 },
{ 134, 5605 },
{ 135, 5650 },
{ 136, 5695 },
{ 137, 5740 },
{ 138, 5785 },
{ 139, 5830 },
{ 140, 5875 },
{ 141, 5920 },
{ 142, 5965 },
{ 143, 6010 },
{ 144, 6055 },
{ 145, 6100 },
{ 146, 6145 },
{ 147, 6190 },
{ 148, 6235 },
{ 149, 6280 },
{ 150, 6325 },
{ 151, 6370 },
{ 152, 6415 },
{ 153, 6460 },
{ 154, 6505 },
{ 155, 6550 },
{ 156, 6595 },
{ 157, 6640 },
{ 158, 6685 },
{ 159, 6730 },
{ 160, 6775 },
{ 161, 6820 },
{ 162, 6865 },
{ 163, 6910 },
{ 164, 6955 },
{ 165, 7000 },
{ 166, 7045 },
{ 167, 7090 },
{ 168, 7135 },
{ 169, 7180 },
{ 170, 7225 },
};

-- 潜力{潜力(潜力/100为最终潜力值)，概率(概率/1000为最终概率值)}
local PotentialChance = {
    {110,0,100000},
    {120,0,80000},
    {130,0,60000},
    {140,0,40000},
    {140,3,45000},
    {150,0,5000},
    {150,2,15000},
    {150,4,33000},
    {150,6,45000},
    {150,8,60000},
    {160,0,100},
    {160,3,2500},
    {160,6,5000},
    {160,9,12000},
    {160,12,14000},
    {160,15,16000},
    {160,18,25000},
    {200,0,50},
    {200,5,100},
    {200,10,300},
    {200,15,1000},
    {200,20,4500},
    {200,25,10000},
    {200,30,15000},
    {200,35,25000},
    {240,0,25},
    {240,5,50},
    {240,10,100},
    {240,15,200},
    {240,20,300},
    {240,25,400},
    {240,30,900},
    {240,35,1200},
    {240,40,4500},
    {240,45,6000},
    {240,50,10000},
    {240,55,15000},
    {240,60,25000},
    {300,0,5},
    {300,10,25},
    {300,20,100},
    {300,30,500},
    {300,40,700},
    {300,50,1500},
    {300,60,2500},
    {300,70,8000},
    {300,80,12000},
    {300,90,18000},
    {300,100,25000},
}

-- 资质{资质(资质/100为最终资质值)，概率(概率/1000为最终概率值)}
local CapacityChance = {
    {550,0,100000},
    {600,0,80000},
    {650,0,60000},
    {700,0,40000},
    {700,3,45000},
    {750,0,5000},
    {750,2,10000},
    {750,4,18000},
    {750,6,25000},
    {750,8,45000},
    {800,0,100},
    {800,3,2500},
    {800,6,5000},
    {800,9,12000},
    {800,12,14000},
    {800,15,16000},
    {800,18,25000},
    {1000,0,50},
    {1000,5,100},
    {1000,10,300},
    {1000,15,1000},
    {1000,20,4500},
    {1000,25,10000},
    {1000,30,15000},
    {1000,35,25000},
}

local MinPotential = 70
local MaxPotential = 300
local MinCapacity = 500
local MaxCapacity = 1000

local Color_Fighter_Chance_Free = {

 {95500, 4500, 0, 0},
 {94000, 6000, 0, 0},
 {92000, 8000, 0, 0},
 {90000, 10000, 0, 0},
 {87999, 12000, 1, 0},
 {87998, 12000, 2, 0},
 {87996, 12000, 4, 0},
 {87993, 12000, 7, 0},
 {87988, 12000, 12, 0},
 {87950, 12000, 50, 0},
 {87000, 12000, 1000, 0},
 {86000, 12000, 2000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0},
 {83000, 12000, 5000, 0}

}

local Color_Fighter_Chance_Gold = {

 {92000, 8000, 0, 0},
 {87980, 12000, 20, 0},
 {83900, 16000, 100, 0},
 {77000, 20000, 3000, 0},
 {72000, 20000, 8000, 0},
 {71999, 20000, 8000, 1},
 {71998, 20000, 8000, 2},
 {71997, 20000, 8000, 3},
 {71996, 20000, 8000, 4},
 {71995, 20000, 8000, 5},
 {71994, 20000, 8000, 6},
 {71993, 20000, 8000, 7},
 {71992, 20000, 8000, 8},
 {71991, 20000, 8000, 9},
 {71990, 20000, 8000, 10},
 {71950, 20000, 8000, 50},
 {71900, 20000, 8000, 100},
 {71700, 20000, 8000, 300},
 {71500, 20000, 8000, 500},
 {70000, 20000, 8000, 2000},
 {68000, 20000, 8000, 4000},
 {66000, 20000, 8000, 6000},
 {66000, 20000, 8000, 6000},
 {66000, 20000, 8000, 6000},
 {66000, 20000, 8000, 6000}

}

function getColorFighterChance_Free()
    return Color_Fighter_Chance_Free
end

function getColorFighterChance_Gold()
    return Color_Fighter_Chance_Gold
end

function GetTaelTrain()
	return TaelTrain;
end

function GetGoldTrain()
	return GoldTrain;
end

function GetLevelTrainExp()
	return LevelTrainExp;
end

function getPotentialChance()
    return PotentialChance
end

function getCapacityChance()
    return CapacityChance
end

function getMinPotential()
    return MinPotential
end

function getMaxPotential()
    return MaxPotential
end

function getMinCapacity()
    return MinCapacity
end

function getMaxCapacity()
    return MaxCapacity
end
