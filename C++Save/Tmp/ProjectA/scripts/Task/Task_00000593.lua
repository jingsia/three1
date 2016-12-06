--����Ľ�������
function Task_Accept_00000593()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(593) or task:HasCompletedTask(593) or task:HasSubmitedTask(593) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000593()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(593) or task:HasCompletedTask(593) or task:HasSubmitedTask(593) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000593()
	if GetPlayer():GetTaskMgr():HasCompletedTask(593) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000593(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(593) == npcId and Task_Accept_00000593 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 593
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1493;
	elseif task:GetTaskSubmitNpc(593) == npcId then
		if Task_Submit_00000593() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 593
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1494;
		elseif task:HasAcceptedTask(593) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 593
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1495;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000593_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1496..GetPlayerName(GetPlayer())..task_msg_1497;
	action.m_ActionMsg = task_msg_1498;
	return action;
end

function Task_00000593_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1499;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000593_step_table = {
		[1] = Task_00000593_step_01,
		[10] = Task_00000593_step_10,
		};

function Task_00000593_step(step)
	if Task_00000593_step_table[step] ~= nil then
		return Task_00000593_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000593_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000593() then
		return false;
	end
	if not task:AcceptTask(593) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000593_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(593) then
		return false;
	end


	return true;
end

--��������
function Task_00000593_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(593);
end
