--����Ľ�������
function Task_Accept_00000036()
	local player = GetPlayer();
	if player:GetLev() < 21 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(36) or task:HasCompletedTask(36) or task:HasSubmitedTask(36) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000036()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 21 then
		return false;
	end
	if task:HasAcceptedTask(36) or task:HasCompletedTask(36) or task:HasSubmitedTask(36) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(35) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000036()
	if GetPlayer():GetTaskMgr():HasCompletedTask(36) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000036(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(36) == npcId and Task_Accept_00000036 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 36
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_262;
	elseif task:GetTaskSubmitNpc(36) == npcId then
		if Task_Submit_00000036() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 36
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_263;
		elseif task:HasAcceptedTask(36) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 36
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_264;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000036_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_265;
	action.m_ActionMsg = task_msg_266;
	return action;
end

function Task_00000036_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_267;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000036_step_table = {
		[1] = Task_00000036_step_01,
		[10] = Task_00000036_step_10,
		};

function Task_00000036_step(step)
	if Task_00000036_step_table[step] ~= nil then
		return Task_00000036_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000036_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000036() then
		return false;
	end
	if not task:AcceptTask(36) then
		return false;
	end
	task:AddTaskStep(36);
	return true;
end



--�ύ����
function Task_00000036_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(36) then
		return false;
	end


	player:AddExp(4400);
	player:getTael(500);
	return true;
end

--��������
function Task_00000036_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(36);
end
