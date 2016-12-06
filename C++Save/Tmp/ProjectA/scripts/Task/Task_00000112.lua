--����Ľ�������
function Task_Accept_00000112()
	local player = GetPlayer();
	if player:GetLev() < 55 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(112) or task:HasCompletedTask(112) or task:HasSubmitedTask(112) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000112()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 55 then
		return false;
	end
	if task:HasAcceptedTask(112) or task:HasCompletedTask(112) or task:HasSubmitedTask(112) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(111) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000112()
	if GetPlayer():GetTaskMgr():HasCompletedTask(112) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000112(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(112) == npcId and Task_Accept_00000112 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 112
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_987;
	elseif task:GetTaskSubmitNpc(112) == npcId then
		if Task_Submit_00000112() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 112
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_988;
		elseif task:HasAcceptedTask(112) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 112
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_989;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000112_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_990..GetPlayerName(GetPlayer())..task_msg_991;
	action.m_ActionMsg = task_msg_992;
	return action;
end

function Task_00000112_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_993;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000112_step_table = {
		[1] = Task_00000112_step_01,
		[10] = Task_00000112_step_10,
		};

function Task_00000112_step(step)
	if Task_00000112_step_table[step] ~= nil then
		return Task_00000112_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000112_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000112() then
		return false;
	end
	if not task:AcceptTask(112) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000112_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(112) then
		return false;
	end


	player:AddExp(50000);
	return true;
end

--��������
function Task_00000112_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(112);
end
