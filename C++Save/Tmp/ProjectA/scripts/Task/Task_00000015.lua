--����Ľ�������
function Task_Accept_00000015()
	local player = GetPlayer();
	if player:GetLev() < 10 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(15) or task:HasCompletedTask(15) or task:HasSubmitedTask(15) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000015()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 10 then
		return false;
	end
	if task:HasAcceptedTask(15) or task:HasCompletedTask(15) or task:HasSubmitedTask(15) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(14) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000015()
	if GetPlayer():GetTaskMgr():HasCompletedTask(15) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000015(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(15) == npcId and Task_Accept_00000015 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 15
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_146;
	elseif task:GetTaskSubmitNpc(15) == npcId then
		if Task_Submit_00000015() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 15
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_147;
		elseif task:HasAcceptedTask(15) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 15
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_148;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000015_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_149;
	action.m_ActionMsg = task_msg_150;
	return action;
end

function Task_00000015_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_151;
	action.m_ActionMsg = task_msg_152;
	return action;
end

function Task_00000015_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_153;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000015_step_table = {
		[1] = Task_00000015_step_01,
		[2] = Task_00000015_step_02,
		[10] = Task_00000015_step_10,
		};

function Task_00000015_step(step)
	if Task_00000015_step_table[step] ~= nil then
		return Task_00000015_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000015_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000015() then
		return false;
	end
	if not task:AcceptTask(15) then
		return false;
	end
	task:AddTaskStep(15);
	return true;
end



--�ύ����
function Task_00000015_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(15) then
		return false;
	end


	player:AddExp(1800);
	return true;
end

--��������
function Task_00000015_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(15);
end
