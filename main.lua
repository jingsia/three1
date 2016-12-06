function initSeed(seed)
    math.randomseed(seed)
end
--[[
if isFBVersion() then
    require("World/StoreFB")
else
    require("World/Store")
end
--]]
require("World/Title")
require("World/Activity")
require("World/HeroIsland")
require("World/TeamCopyAwards")
require("World/gm")
require("World/FighterForge")
require("World/UdpItem")

package.path = package.path .. '../?.lua'
--require("scripts/utils/functions")
require("scripts/core/functions")
 
local BattleConstant = require("core.view.battle.BattleConstant")

function loadBattleConfig()
	--require("core.config.ConfigParser")()
	local BattleArmy = require("config.BattleArmy")
	print(BattleArmy[1].name)

	require("core.config.BarrierConfig").new():load()
	require("core.config.SkillConfig").new():load()
	require("core.config.HeroConfig").new():load()
	require("core.config.EquipClassUpConfig").new():load()
	require("core.config.EquipPowerUpConfig").new():load()
	require("core.config.EquipConfig").new():load()
	require("core.config.HeroStarUpConfig").new():load()

	require("core.config.BattleArmy").new():load()
	require("core.config.battle.BattleMapConfig").new():load()
end

function launchBattle( bf1, bf2, mapId1, mapId2, distance )

	local BattleProxy = require("core.view.battle.BattleProxy")
	local General = require("core.data.General")
	local Role = require("core.data.Role")

	--战斗前
	print("bf1ID-->", bf1:GetId(), "bf2ID-->", bf2:GetId())
	local general_1 = General.new(bf1:GetId())
	local general_2 = General.new(bf2:GetId())
	local role_1 = Role.new()
	local role_2 = Role.new()

	print("isFirst_1-->", bf1:GetIsFirstBattle(), "isFirst_2-->", bf2:GetIsFirstBattle())
	local isFirst_1 = bf1:GetIsFirstBattle()
	local isFirst_2 = bf2:GetIsFirstBattle()

	general_1:setStar(bf1:getStar())
	general_2:setStar(bf2:getStar())
	general_1:setMapId(mapId1)
	general_2:setMapId(mapId2)

	local Equip = require("core.data.Equip")

	local Equips_1 = heroConfig:getEquips(bf1:GetId())
	local equipList_1 = {}
	for i = 1,4 do
		local equipObj = Equip.new(Equips_1[i])
		local k = 0;
		local fgt = bf1:GetFighter()
		if fgt == nil then
			k = 0
		else
			if i == 1 then
				k = fgt:GetClothLvl()
			elseif i == 2 then
				k = fgt:GetHeadLvl()
			elseif i == 3 then
				k = fgt:GetShoesLvl()
			elseif i == 4 then
				k = fgt:GetDWeaponLvl()
			end
		end

		equipObj:setLevel(fgt:GetEquipPowerUpLvl(k))
		equipObj:setRank(fgt:GetEquipPowerUpRank(k))
		equipList_1[i] = equipObj
	end
	general_1:setEquipList(equipList_1)

	local Equips_2 = heroConfig:getEquips(bf2:GetId())
	local equipList_2 = {}
	for i = 1,4 do
		local equipObj = Equip.new(Equips_2[i])
		local k = 0;
		local fgt = bf2:GetFighter()
		if fgt == nil then
			k = 0
		else
			if i == 1 then
				k = fgt:GetClothLvl()
			elseif i == 2 then
				k = fgt:GetHeadLvl()
			elseif i == 3 then
				k = fgt:GetShoesLvl()
			elseif i == 4 then
				k = fgt:GetDWeaponLvl()
			end
		end

		equipObj:setLevel(k%10)
		equipObj:setRank((k- k%10)/10)
		equipList_2[i] = equipObj
	end
	general_2:setEquipList(equipList_2)

if not isFirst_1 then
	print("isFirst_1 true ----------begin")
	local soldierList_1 = {}
	for i = 1, 10 do
		local soldier_1 = Role.new()
		print("bf1 number-->", i)
		print("bf1 soldierHp-->", bf1:GetSoldierHp(i-1))

		soldier_1:setNumber(i)
		soldier_1:setHp(bf1:GetSoldierHp(i-1))
		soldier_1:setMp(bf1:GetSoldierMp(i-1))
		soldierList_1[i] = soldier_1
	end

	print("bf1 role hp-->", bf1:getHP())
	print("bf1 role mp-->", bf1:getMP())
	print("bf1 role energy-->", bf1:GetEnergy())
	role_1:setHp(bf1:getHP())
	role_1:setMp(bf1:getMP())
	role_1:setEnergy(bf1:GetEnergy())

	local battleInfo_1 = {}
	battleInfo_1._mainFighter = role_1
	battleInfo_1._children = soldierList_1
	general_1:setBattleInfo(battleInfo_1)
end

if not isFirst_2 then
	print("isFirst_2 true ----------begin")
	local soldierList_1 = {}
	local soldierList_2 = {}
	for i = 1, 10 do
		local soldier_2 = Role.new()
		print("bf2 number-->", i)
		print("bf2 soldierHp-->", bf2:GetSoldierHp(i-1))
		soldier_2:setNumber(i)
		soldier_2:setHp(bf2:GetSoldierHp(i-1))
		soldier_2:setMp(bf2:GetSoldierMp(i-1))
		soldierList_2[i] = soldier_2
	end

	print("bf2 role hp-->", bf2:getHP())
	print("bf2 role mp-->", bf2:getMP())
	print("bf2 role energy-->", bf2:GetEnergy())
	role_2:setHp(bf2:getHP())
	role_2:setMp(bf2:getMP())
	role_2:setEnergy(bf2:GetEnergy())

	local battleInfo_2 = {}
	battleInfo_2._mainFighter = role_2
	battleInfo_2._children = soldierList_2
	general_2:setBattleInfo(battleInfo_2)
	print("isfirst_2 end------------")
end
	--------------------------------

	local bproxy = BattleProxy.new(0)

	local mineHero = general_1
	local enemyHero = general_2

	bproxy:putMineBattleHero(mineHero)
	bproxy:putEnemyBattleHero(enemyHero)

	local disNear = false
	if distance == 1 then
		disNear = true
	else
		disNear = false
	end
	bproxy:putBattleMap(disNear, mapId1, mapId2)
	print("disNear==", disNear)
	print("map1id ==", mapId1)
	print("map2id ==", mapId2)

	print("++++++++++ battle start ++++++++++++")
	--战斗
	--win: 1 敌方胜  2超时 3平局  0我方胜
	local win, bp = bproxy:start()

	--战后
	print("++++++++++ battle after ++++++++++++")
	--BF1
	local battleInfoA_1 = mineHero:getBattleInfo()

	if battleInfoA_1 ~= nil then
		local children_1 = battleInfoA_1._children;
		local mainFighter_1 = battleInfoA_1._mainFighter

		bf1:setHP(mainFighter_1:getHp())
		bf1:setMP(mainFighter_1:getMp())
		bf1:SetEnergy(mainFighter_1:getEnergy())
		print("主将信息")
		print("血量:", mainFighter_1:getHp())
		print("蓝量:", mainFighter_1:getMp())
		print("能量值:", mainFighter_1:getEnergy())

		print("小兵信息")
		for k = 1, 10 do
			local isFind = false
			for _, v in pairs(children_1) do
				if v:getNumber() == k then
					isFind = true
					bf1:SetSoldierHp((k-1), v:getHp())
					bf1:SetSoldierMp((k-1), v:getMp())
					break
				end
			end

			if not isFind then
					bf1:SetSoldierHp((k-1), 0)
					bf1:SetSoldierMp((k-1), 0)
			end
	
			print("编号:", k-1)
			print("bf1 --GetSoldierHp：", bf1:GetSoldierHp(k-1))
		end
	else
		print("get general after battle nil bf1")
		bf1:setHP(0)
		bf1:setMP(0)
		bf1:SetEnergy(0)
	end

	--BF2
	local battleInfoA_2 = enemyHero:getBattleInfo()

	if battleInfoA_2 ~= nil then
		local children_2 = battleInfoA_2._children;
		local mainFighter_2 = battleInfoA_2._mainFighter

		bf2:setHP(mainFighter_2:getHp())
		bf2:setMP(mainFighter_2:getMp())
		bf2:SetEnergy(mainFighter_2:getEnergy())
		print("主将信息")
		print("血量:", mainFighter_2:getHp())
		print("蓝量:", mainFighter_2:getMp())
		print("能量值:", mainFighter_2:getEnergy())

		print("小兵信息")
		for k = 1, 10 do
			local isFind = false
			for _, v in pairs(children_2) do
				if v:getNumber() == k then
					isFind = true
					bf2:SetSoldierHp((k-1), v:getHp())
					bf2:SetSoldierMp((k-1), v:getMp())
					break
				end
			end

			if not isFind then
					bf2:SetSoldierHp((k-1), 0)
					bf2:SetSoldierMp((k-1), 0)
			end
	
			print("编号:", k-1)
			print("bf2 --GetSoldierHp：", bf2:GetSoldierHp(k-1))
		end
	else
		print("get general after battle nil bf2")
		bf2:setHP(0)
		bf2:setMP(0)
		bf2:SetEnergy(0)
	end

	local Ysbp = bp:serialize()
	print("战斗战报size---lua:====", string.len(Ysbp))
	local retMsg = {}
	retMsg[1] = win
	retMsg[2] = Ysbp
	--return win, Ysbp
	return retMsg
end

function forceCommitArena()
    local str = "World/forceCommitArena"
    local path = "scripts/"..str..".lua"
    local file = io.open(path, "rb")
    if file then
        file:close()
        require(str)
        os.execute("rm "..path)
    end
end

loadBattleConfig()
forceCommitArena()

