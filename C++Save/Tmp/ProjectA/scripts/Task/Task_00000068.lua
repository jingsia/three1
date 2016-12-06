--����Ľ�������
function Task_Accept_00000068()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(68) or task:HasCompletedTask(68) or task:HasSubmitedTask(68) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000068()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(68) or task:HasCompletedTask(68) or task:HasSubmitedTask(68) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(67) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000068()
	if GetPlayer():GetTaskMgr():HasCompletedTask(68) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000068(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(68) == npcId and Task_Accept_00000068 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 68
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1949;
	elseif task:GetTaskSubmitNpc(68) == npcId then
		if Task_Submit_00000068() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 68
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1950;
		elseif task:HasAcceptedTask(68) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 68
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1951;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000068_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1952;
	action.m_ActionMsg = task_msg_1953;
	return action;
end

function Task_00000068_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1954;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000068_step_table = {
		[1] = Task_00000068_step_01,
		[10] = Task_00000068_step_10,
		};

function Task_00000068_step(step)
	if Task_00000068_step_table[step] ~= nil then
		return Task_00000068_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000068_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000068() then
		return false;
	end
	if not task:AcceptTask(68) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000068_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(68) then
		return false;
	end


	player:AddExp(95000);
	return true;
end

--��������
function Task_00000068_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(68);
end
