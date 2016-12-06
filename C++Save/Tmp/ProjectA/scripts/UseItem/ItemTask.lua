--��Ʒ��������
-- ��Ʒ��������(��Ʒ15001)
function ItemTask_00015001()
	local country = GetPlayerData(6);
	if country == 0 then
		--����
		RunItemTaskAction(GetPlayer(), 60101, 10000+15001+4096);
	else
		--ħ��
		RunItemTaskAction(GetPlayer(), 60201, 10000+15001+4096);
	end
	
	return true;
end


-- ��Ʒ��������(��Ʒ15015)
function ItemTask_00015015()
	RunItemTaskAction(GetPlayer(), 61601, 10000+15015+4096);
	return true;
end

local ItemTask_Table = {
	[15001] = ItemTask_00015001;
	[15015] = ItemTask_00015015;
	};
	
function RunItemTaskUse(itemId)
	local trigger = ItemTask_Table[itemId];
	if trigger == nil then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 31 then
		player:sendMsgCode(1, 1010);
		return false;
	end
	return trigger();
end


function IsItemTaskItem(itemId)
	if ItemTask_Table[itemId] == nil then
		return false;
	end
	return true;
end

