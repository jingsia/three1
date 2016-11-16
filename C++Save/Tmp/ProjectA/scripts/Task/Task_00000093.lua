--����Ľ�������
function Task_Accept_00000093()
	local player = GetPlayer();
	if player:GetLev() < 46 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(93) or task:HasCompletedTask(93) or task:HasSubmitedTask(93) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000093()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 46 then
		return false;
	end
	if task:HasAcceptedTask(93) or task:HasCompletedTask(93) or task:HasSubmitedTask(93) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(92) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000093()
	if GetPlayer():GetTaskMgr():HasCompletedTask(93) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000093(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(93) == npcId and Task_Accept_00000093 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 93
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_411;
	elseif task:GetTaskSubmitNpc(93) == npcId then
		if Task_Submit_00000093() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 93
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_412;
		elseif task:HasAcceptedTask(93) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 93
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_413;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000093_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_414;
	action.m_ActionMsg = task_msg_415;
	return action;
end

function Task_00000093_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 3;
	action.m_NpcMsg = task_msg_416;
	action.m_ActionMsg = task_msg_417;
	return action;
end

function Task_00000093_step_03()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_418;
	action.m_ActionMsg = task_msg_419;
	return action;
end

function Task_00000093_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_420;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000093_step_table = {
		[1] = Task_00000093_step_01,
		[2] = Task_00000093_step_02,
		[3] = Task_00000093_step_03,
		[10] = Task_00000093_step_10,
		};

function Task_00000093_step(step)
	if Task_00000093_step_table[step] ~= nil then
		return Task_00000093_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000093_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000093() then
		return false;
	end
	if not task:AcceptTask(93) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000093_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(93) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000093_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(93);
end
