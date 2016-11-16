--����Ľ�������
function Task_Accept_00000508()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(508) or task:HasCompletedTask(508) or task:HasSubmitedTask(508) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000508()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(508) or task:HasCompletedTask(508) or task:HasSubmitedTask(508) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000508()
	if GetPlayer():GetTaskMgr():HasCompletedTask(508) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000508(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(508) == npcId and Task_Accept_00000508 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 508
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_639;
	elseif task:GetTaskSubmitNpc(508) == npcId then
		if Task_Submit_00000508() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 508
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_640;
		elseif task:HasAcceptedTask(508) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 508
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_641;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000508_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_642..GetPlayerName(GetPlayer())..task_msg_643;
	action.m_ActionMsg = task_msg_644;
	return action;
end

function Task_00000508_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_645;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000508_step_table = {
		[1] = Task_00000508_step_01,
		[10] = Task_00000508_step_10,
		};

function Task_00000508_step(step)
	if Task_00000508_step_table[step] ~= nil then
		return Task_00000508_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000508_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000508() then
		return false;
	end
	if not task:AcceptTask(508) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000508_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(508) then
		return false;
	end


	return true;
end

--��������
function Task_00000508_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(508);
end
