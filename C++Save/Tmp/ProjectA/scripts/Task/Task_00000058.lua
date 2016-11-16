--����Ľ�������
function Task_Accept_00000058()
	local player = GetPlayer();
	if player:GetLev() < 35 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(58) or task:HasCompletedTask(58) or task:HasSubmitedTask(58) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000058()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 35 then
		return false;
	end
	if task:HasAcceptedTask(58) or task:HasCompletedTask(58) or task:HasSubmitedTask(58) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(57) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000058()
	if GetPlayer():GetTaskMgr():HasCompletedTask(58) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000058(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(58) == npcId and Task_Accept_00000058 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 58
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1583;
	elseif task:GetTaskSubmitNpc(58) == npcId then
		if Task_Submit_00000058() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 58
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1584;
		elseif task:HasAcceptedTask(58) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 58
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1585;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000058_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1586;
	action.m_ActionMsg = task_msg_1587;
	return action;
end

function Task_00000058_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1588;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000058_step_table = {
		[1] = Task_00000058_step_01,
		[10] = Task_00000058_step_10,
		};

function Task_00000058_step(step)
	if Task_00000058_step_table[step] ~= nil then
		return Task_00000058_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000058_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000058() then
		return false;
	end
	if not task:AcceptTask(58) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000058_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(58) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000058_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(58);
end
