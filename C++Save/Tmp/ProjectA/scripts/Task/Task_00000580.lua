--����Ľ�������
function Task_Accept_00000580()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(580) or task:HasCompletedTask(580) or task:HasSubmitedTask(580) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000580()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(580) or task:HasCompletedTask(580) or task:HasSubmitedTask(580) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000580()
	if GetPlayer():GetTaskMgr():HasCompletedTask(580) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000580(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(580) == npcId and Task_Accept_00000580 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 580
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1411;
	elseif task:GetTaskSubmitNpc(580) == npcId then
		if Task_Submit_00000580() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 580
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1412;
		elseif task:HasAcceptedTask(580) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 580
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1413;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000580_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1414..GetPlayerName(GetPlayer())..task_msg_1415;
	action.m_ActionMsg = task_msg_1416;
	return action;
end

function Task_00000580_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1417;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000580_step_table = {
		[1] = Task_00000580_step_01,
		[10] = Task_00000580_step_10,
		};

function Task_00000580_step(step)
	if Task_00000580_step_table[step] ~= nil then
		return Task_00000580_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000580_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000580() then
		return false;
	end
	if not task:AcceptTask(580) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000580_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(580) then
		return false;
	end


	return true;
end

--��������
function Task_00000580_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(580);
end
