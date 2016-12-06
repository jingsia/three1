--����Ľ�������
function Task_Accept_00000085()
	local player = GetPlayer();
	if player:GetLev() < 45 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(85) or task:HasCompletedTask(85) or task:HasSubmitedTask(85) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000085()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 45 then
		return false;
	end
	if task:HasAcceptedTask(85) or task:HasCompletedTask(85) or task:HasSubmitedTask(85) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(84) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000085()
	if GetPlayer():GetTaskMgr():HasCompletedTask(85) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000085(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(85) == npcId and Task_Accept_00000085 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 85
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_353;
	elseif task:GetTaskSubmitNpc(85) == npcId then
		if Task_Submit_00000085() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 85
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_354;
		elseif task:HasAcceptedTask(85) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 85
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_355;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000085_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_356;
	action.m_ActionMsg = task_msg_357;
	return action;
end

function Task_00000085_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_358;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000085_step_table = {
		[1] = Task_00000085_step_01,
		[10] = Task_00000085_step_10,
		};

function Task_00000085_step(step)
	if Task_00000085_step_table[step] ~= nil then
		return Task_00000085_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000085_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000085() then
		return false;
	end
	if not task:AcceptTask(85) then
		return false;
	end
	task:AddTaskStep(85);
	return true;
end



--�ύ����
function Task_00000085_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(85) then
		return false;
	end


	player:AddExp(25000);
	return true;
end

--��������
function Task_00000085_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(85);
end
