--����Ľ�������
function Task_Accept_00000524()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(524) or task:HasCompletedTask(524) or task:HasSubmitedTask(524) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000524()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(524) or task:HasCompletedTask(524) or task:HasSubmitedTask(524) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000524()
	if GetPlayer():GetTaskMgr():HasCompletedTask(524) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000524(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(524) == npcId and Task_Accept_00000524 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 524
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1032;
	elseif task:GetTaskSubmitNpc(524) == npcId then
		if Task_Submit_00000524() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 524
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1033;
		elseif task:HasAcceptedTask(524) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 524
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1034;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000524_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1035..GetPlayerName(GetPlayer())..task_msg_1036;
	action.m_ActionMsg = task_msg_1037;
	return action;
end

function Task_00000524_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1038;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000524_step_table = {
		[1] = Task_00000524_step_01,
		[10] = Task_00000524_step_10,
		};

function Task_00000524_step(step)
	if Task_00000524_step_table[step] ~= nil then
		return Task_00000524_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000524_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000524() then
		return false;
	end
	if not task:AcceptTask(524) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000524_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(524) then
		return false;
	end


	return true;
end

--��������
function Task_00000524_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(524);
end
