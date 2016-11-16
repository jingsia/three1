--����Ľ�������
function Task_Accept_00000061()
	local player = GetPlayer();
	if player:GetLev() < 39 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(61) or task:HasCompletedTask(61) or task:HasSubmitedTask(61) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000061()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 39 then
		return false;
	end
	if task:HasAcceptedTask(61) or task:HasCompletedTask(61) or task:HasSubmitedTask(61) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000061()
	if GetPlayer():GetTaskMgr():HasCompletedTask(61) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000061(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(61) == npcId and Task_Accept_00000061 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 61
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1607;
	elseif task:GetTaskSubmitNpc(61) == npcId then
		if Task_Submit_00000061() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 61
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1608;
		elseif task:HasAcceptedTask(61) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 61
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1609;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000061_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_1610;
	action.m_ActionMsg = task_msg_1611;
	return action;
end

function Task_00000061_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1612..GetPlayerName(GetPlayer())..task_msg_1613;
	action.m_ActionMsg = task_msg_1614;
	return action;
end

function Task_00000061_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1615;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000061_step_table = {
		[1] = Task_00000061_step_01,
		[2] = Task_00000061_step_02,
		[10] = Task_00000061_step_10,
		};

function Task_00000061_step(step)
	if Task_00000061_step_table[step] ~= nil then
		return Task_00000061_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000061_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000061() then
		return false;
	end
	if not task:AcceptTask(61) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000061_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(61) then
		return false;
	end


	player:AddExp(20000);
	return true;
end

--��������
function Task_00000061_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(61);
end
