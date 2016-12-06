--����Ľ�������
function Task_Accept_00000521()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(521) or task:HasCompletedTask(521) or task:HasSubmitedTask(521) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000521()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(521) or task:HasCompletedTask(521) or task:HasSubmitedTask(521) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000521()
	if GetPlayer():GetTaskMgr():HasCompletedTask(521) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000521(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(521) == npcId and Task_Accept_00000521 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 521
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1039;
	elseif task:GetTaskSubmitNpc(521) == npcId then
		if Task_Submit_00000521() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 521
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1040;
		elseif task:HasAcceptedTask(521) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 521
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1041;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000521_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1042..GetPlayerName(GetPlayer())..task_msg_1043;
	action.m_ActionMsg = task_msg_1044;
	return action;
end

function Task_00000521_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1045;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000521_step_table = {
		[1] = Task_00000521_step_01,
		[10] = Task_00000521_step_10,
		};

function Task_00000521_step(step)
	if Task_00000521_step_table[step] ~= nil then
		return Task_00000521_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000521_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000521() then
		return false;
	end
	if not task:AcceptTask(521) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000521_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(521) then
		return false;
	end


	return true;
end

--��������
function Task_00000521_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(521);
end
