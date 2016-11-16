--����Ľ�������
function Task_Accept_00000066()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(66) or task:HasCompletedTask(66) or task:HasSubmitedTask(66) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000066()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(66) or task:HasCompletedTask(66) or task:HasSubmitedTask(66) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(65) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000066()
	if GetPlayer():GetTaskMgr():HasCompletedTask(66) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000066(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(66) == npcId and Task_Accept_00000066 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 66
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1935;
	elseif task:GetTaskSubmitNpc(66) == npcId then
		if Task_Submit_00000066() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 66
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1936;
		elseif task:HasAcceptedTask(66) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 66
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1937;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000066_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1938..GetPlayerName(GetPlayer())..task_msg_1939;
	action.m_ActionMsg = task_msg_1940;
	return action;
end

function Task_00000066_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1941;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000066_step_table = {
		[1] = Task_00000066_step_01,
		[10] = Task_00000066_step_10,
		};

function Task_00000066_step(step)
	if Task_00000066_step_table[step] ~= nil then
		return Task_00000066_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000066_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000066() then
		return false;
	end
	if not task:AcceptTask(66) then
		return false;
	end
	task:AddTaskStep(66);
	return true;
end



--�ύ����
function Task_00000066_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(66) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000066_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(66);
end
