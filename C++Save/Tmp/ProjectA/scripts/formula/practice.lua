
capfactor = 0.16 -- 资质加成
prabase = 5 -- 基础增长点数
potentialbase = 5 -- 

-- TODO: 山头据点
local addons = {
    [1] = 0.5,
    [2] = 0.4,
    [3] = 0.4,
    [4] = 0.3,
    [5] = 0.3,
    [6] = 0.3,
    [7] = 0,
    [8] = 0.3,
    [9] = 0.2,
    [10] = 0.2,
    [11] = 0.1,
    [12] = 0.1,
    [13] = 0.1
}

function calcPracticeInc( fgt , merged)
    if fgt == nil then
        return 0
    end

    place = fgt:getPracticePlace();
    if not place or place > 13 then
        return 0
    end
    placeadd = addons[place]
    if placeadd == nil then
        placeadd = 0
    end

    if not merged then
        if place < 7 then
            placeadd = addons[place + 7]
        end
    end

    if place ~= 7 then
        clantechaddon = fgt:getClanTechAddon(place)
    else
        clantechaddon = 0
    end

    capacity = fgt:getCapacity()
    if capacity < 5 then
        capacity = 5
    end

    buffactor = fgt:getPracticeBufFactor()

    soulPracticeAdd = fgt:getSoulPracticeAddOn()
    soulPracticeFactor = fgt:getSoulPracticeFactor()

    diamondFactor = fgt:getPracticeIncByDiamond()
--[[print(prabase+fgt:getAcuPraAdd()+soulPracticeAdd)
print(1 + (capacity - 5))
print(capfactor)
print(clantechaddon)
print(placeadd)
print(buffactor)
print(soulPracticeFactor)
print(diamondFactor)
    ]]
    -- (基础 + 穴道加成) * (1 + ((资质 - 5) * 0.16 + 山头加成 + 帮派加成 + BUFF加成 + ... + 蓝黄砖加成))
    --return ((prabase+fgt:getAcuPraAdd()+soulPracticeAdd) * (1 + (capacity - 5) * capfactor + placeadd + clantechaddon + buffactor + soulPracticeFactor))
    return ((prabase+fgt:getAcuPraAdd()+soulPracticeAdd) * (1 + (capacity - 5) * capfactor + placeadd + clantechaddon + buffactor + soulPracticeFactor + diamondFactor))
end

function calcBasePExp(fgt)
    if fgt == nil then
        return 0;
    end

    soulPracticeAdd = fgt:getSoulPracticeAddOn()
    return (prabase+fgt:getAcuPraAdd()+soulPracticeAdd)
end

function calcPExpNoBuf(fgt)
    if fgt == nil then
        return 0;
    end

    clantechaddon = fgt:getClanTechAddon(place)
    capacity = fgt:getCapacity()
    if capacity < 5 then
        capacity = 5
    end

    soulPracticeAdd = fgt:getSoulPracticeAddOn()
    soulPracticeFactor = fgt:getSoulPracticeFactor()

    return ((prabase+fgt:getAcuPraAdd()+soulPracticeAdd) * (1 + (capacity - 5) * capfactor + clantechaddon + soulPracticeFactor))
end

function GetPlaceAddons()
    return addons;
end


local PracticeTael = {
    5,
    10
}

local PracticeGold = {
}

local OpenSlotGold = {
    5,10,100,200,400,600,800,100,1200,1400,1600,1800,2000,2200,2400,2600,2800,3000,3200,3400
}

function GetTaelPractice()
    return PracticeTael;
end

function GetGoldPractice()
    return PracticeGold;
end

function GetGoldOpenSlot()
	return OpenSlotGold;
end

