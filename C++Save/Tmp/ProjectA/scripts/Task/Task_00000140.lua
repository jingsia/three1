--����Ľ�������
function Task_Accept_00000140()
	local player = GetPlayer();
	if player:GetLev() < 65 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(140) or task:HasCompletedTask(140) or task:HasSubmitedTask(140) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000140()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 65 then
		return false;
	end
	if task:HasAcceptedTask(140) or task:HasCompletedTask(140) or task:HasSubmitedTask(140) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(118) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000140()
	if GetPlayer():GetTaskMgr():HasCompletedTask(140) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000140(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(140) == npcId and Task_Accept_00000140 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 140
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2142;
	elseif task:GetTaskSubmitNpc(140) == npcId then
		if Task_Submit_00000140() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 140
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2143;
		elseif task:HasAcceptedTask(140) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 140
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2144;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000140_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_2145;
	action.m_ActionMsg = task_msg_2146;
	return action;
end

function Task_00000140_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2147;
	action.m_ActionMsg = task_msg_2148;
	return action;
end

function Task_00000140_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_2149;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000140_step_table = {
		[1] = Task_00000140_step_01,
		[2] = Task_00000140_step_02,
		[10] = Task_00000140_step_10,
		};

function Task_00000140_step(step)
	if Task_00000140_step_table[step] ~= nil then
		return Task_00000140_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000140_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000140() then
		return false;
	end
	if not task:AcceptTask(140) then
		return false;
	end
	task:AddTaskStep(140);
	return true;
end



--�ύ����
function Task_00000140_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(140) then
		return false;
	end


	player:AddExp(50000);
	return true;
end

--��������
function Task_00000140_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(140);
end
