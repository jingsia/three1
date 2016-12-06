--����Ľ�������
function Task_Accept_00000087()
	local player = GetPlayer();
	if player:GetLev() < 45 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(87) or task:HasCompletedTask(87) or task:HasSubmitedTask(87) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000087()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 45 then
		return false;
	end
	if task:HasAcceptedTask(87) or task:HasCompletedTask(87) or task:HasSubmitedTask(87) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(86) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000087()
	if GetPlayer():GetTaskMgr():HasCompletedTask(87) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000087(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(87) == npcId and Task_Accept_00000087 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 87
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_367;
	elseif task:GetTaskSubmitNpc(87) == npcId then
		if Task_Submit_00000087() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 87
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_368;
		elseif task:HasAcceptedTask(87) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 87
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_369;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000087_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_370;
	action.m_ActionMsg = task_msg_371;
	return action;
end

function Task_00000087_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_372;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000087_step_table = {
		[1] = Task_00000087_step_01,
		[10] = Task_00000087_step_10,
		};

function Task_00000087_step(step)
	if Task_00000087_step_table[step] ~= nil then
		return Task_00000087_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000087_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000087() then
		return false;
	end
	if not task:AcceptTask(87) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000087_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(87) then
		return false;
	end


	player:AddExp(27000);
	return true;
end

--��������
function Task_00000087_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(87);
end
