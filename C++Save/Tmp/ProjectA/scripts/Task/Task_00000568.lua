--����Ľ�������
function Task_Accept_00000568()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(568) or task:HasCompletedTask(568) or task:HasSubmitedTask(568) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000568()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(568) or task:HasCompletedTask(568) or task:HasSubmitedTask(568) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000568()
	if GetPlayer():GetTaskMgr():HasCompletedTask(568) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000568(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(568) == npcId and Task_Accept_00000568 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 568
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_841;
	elseif task:GetTaskSubmitNpc(568) == npcId then
		if Task_Submit_00000568() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 568
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_842;
		elseif task:HasAcceptedTask(568) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 568
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_843;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000568_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_844..GetPlayerName(GetPlayer())..task_msg_845;
	action.m_ActionMsg = task_msg_846;
	return action;
end

function Task_00000568_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_847;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000568_step_table = {
		[1] = Task_00000568_step_01,
		[10] = Task_00000568_step_10,
		};

function Task_00000568_step(step)
	if Task_00000568_step_table[step] ~= nil then
		return Task_00000568_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000568_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000568() then
		return false;
	end
	if not task:AcceptTask(568) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000568_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(568) then
		return false;
	end


	return true;
end

--��������
function Task_00000568_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(568);
end
