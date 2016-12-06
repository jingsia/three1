--����Ľ�������
function Task_Accept_00000076()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(76) or task:HasCompletedTask(76) or task:HasSubmitedTask(76) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000076()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(76) or task:HasCompletedTask(76) or task:HasSubmitedTask(76) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(75) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000076()
	if GetPlayer():GetTaskMgr():HasCompletedTask(76) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000076(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(76) == npcId and Task_Accept_00000076 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 76
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1986;
	elseif task:GetTaskSubmitNpc(76) == npcId then
		if Task_Submit_00000076() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 76
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1987;
		elseif task:HasAcceptedTask(76) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 76
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1988;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000076_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_1989;
	action.m_ActionMsg = task_msg_1990;
	return action;
end

function Task_00000076_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1991;
	action.m_ActionMsg = task_msg_1992;
	return action;
end

function Task_00000076_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1993;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000076_step_table = {
		[1] = Task_00000076_step_01,
		[2] = Task_00000076_step_02,
		[10] = Task_00000076_step_10,
		};

function Task_00000076_step(step)
	if Task_00000076_step_table[step] ~= nil then
		return Task_00000076_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000076_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000076() then
		return false;
	end
	if not task:AcceptTask(76) then
		return false;
	end
	task:AddTaskStep(76);
	return true;
end



--�ύ����
function Task_00000076_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(76) then
		return false;
	end


	player:AddExp(150000);
	return true;
end

--��������
function Task_00000076_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(76);
end