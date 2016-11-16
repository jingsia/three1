--����Ľ�������
function Task_Accept_00000105()
	local player = GetPlayer();
	if player:GetLev() < 55 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(105) or task:HasCompletedTask(105) or task:HasSubmitedTask(105) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000105()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 55 then
		return false;
	end
	if task:HasAcceptedTask(105) or task:HasCompletedTask(105) or task:HasSubmitedTask(105) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(100) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000105()
	if GetPlayer():GetTaskMgr():HasCompletedTask(105) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000105(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(105) == npcId and Task_Accept_00000105 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 105
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2073;
	elseif task:GetTaskSubmitNpc(105) == npcId then
		if Task_Submit_00000105() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 105
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2074;
		elseif task:HasAcceptedTask(105) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 105
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2075;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000105_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2076..GetPlayerName(GetPlayer())..task_msg_2077;
	action.m_ActionMsg = task_msg_2078;
	return action;
end

function Task_00000105_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_2079;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000105_step_table = {
		[1] = Task_00000105_step_01,
		[10] = Task_00000105_step_10,
		};

function Task_00000105_step(step)
	if Task_00000105_step_table[step] ~= nil then
		return Task_00000105_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000105_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000105() then
		return false;
	end
	if not task:AcceptTask(105) then
		return false;
	end
	task:AddTaskStep(105);
	return true;
end



--�ύ����
function Task_00000105_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(105) then
		return false;
	end


	player:AddExp(35000);
	return true;
end

--��������
function Task_00000105_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(105);
end
