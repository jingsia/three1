--����Ľ�������
function Task_Accept_00000083()
	local player = GetPlayer();
	if player:GetLev() < 45 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(83) or task:HasCompletedTask(83) or task:HasSubmitedTask(83) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000083()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 45 then
		return false;
	end
	if task:HasAcceptedTask(83) or task:HasCompletedTask(83) or task:HasSubmitedTask(83) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(81) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000083()
	if GetPlayer():GetTaskMgr():HasCompletedTask(83) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000083(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(83) == npcId and Task_Accept_00000083 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 83
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_338;
	elseif task:GetTaskSubmitNpc(83) == npcId then
		if Task_Submit_00000083() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 83
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_339;
		elseif task:HasAcceptedTask(83) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 83
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_340;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000083_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_341;
	action.m_ActionMsg = task_msg_342;
	return action;
end

function Task_00000083_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_343..GetPlayerName(GetPlayer())..task_msg_344;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000083_step_table = {
		[1] = Task_00000083_step_01,
		[10] = Task_00000083_step_10,
		};

function Task_00000083_step(step)
	if Task_00000083_step_table[step] ~= nil then
		return Task_00000083_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000083_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000083() then
		return false;
	end
	if not task:AcceptTask(83) then
		return false;
	end
	local package = player:GetPackage();
	local itemNum = package:GetItemNum(808,1);
	if itemNum ~= 0 then
		if itemNum > 1 then
			itemNum = 1;
			package:SetItem(808, itemNum, 1);
		end
		task:AddTaskStep2(83, 1, itemNum);
	end
	return true;
end



--�ύ����
function Task_00000083_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();
	if package:GetItemNum(808,1) < 1 then
		return false;
	end

	if not player:GetTaskMgr():SubmitTask(83) then
		return false;
	end

	package:DelItemAll(808,1);

	player:AddExp(35000);
	return true;
end

--��������
function Task_00000083_abandon()
	local package = GetPlayer():GetPackage();
	local itemNum = 0;
	package:DelItemAll(808,1);
	return GetPlayer():GetTaskMgr():AbandonTask(83);
end
