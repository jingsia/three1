--����Ľ�������
function Task_Accept_00000161()
	local player = GetPlayer();
	if player:GetLev() < 75 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(161) or task:HasCompletedTask(161) or task:HasSubmitedTask(161) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000161()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 75 then
		return false;
	end
	if task:HasAcceptedTask(161) or task:HasCompletedTask(161) or task:HasSubmitedTask(161) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(160) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000161()
	if GetPlayer():GetTaskMgr():HasCompletedTask(161) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000161(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(161) == npcId and Task_Accept_00000161 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 161
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1648;
	elseif task:GetTaskSubmitNpc(161) == npcId then
		if Task_Submit_00000161() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 161
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1649;
		elseif task:HasAcceptedTask(161) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 161
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1650;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000161_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1651;
	action.m_ActionMsg = task_msg_1652;
	return action;
end

function Task_00000161_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1653;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000161_step_table = {
		[1] = Task_00000161_step_01,
		[10] = Task_00000161_step_10,
		};

function Task_00000161_step(step)
	if Task_00000161_step_table[step] ~= nil then
		return Task_00000161_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000161_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000161() then
		return false;
	end
	if not task:AcceptTask(161) then
		return false;
	end
	task:AddTaskStep(161);
	return true;
end



--�ύ����
function Task_00000161_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(161) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000161_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(161);
end
