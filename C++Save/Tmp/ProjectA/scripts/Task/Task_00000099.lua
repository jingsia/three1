--����Ľ�������
function Task_Accept_00000099()
	local player = GetPlayer();
	if player:GetLev() < 50 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(99) or task:HasCompletedTask(99) or task:HasSubmitedTask(99) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000099()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 50 then
		return false;
	end
	if task:HasAcceptedTask(99) or task:HasCompletedTask(99) or task:HasSubmitedTask(99) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(98) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000099()
	if GetPlayer():GetTaskMgr():HasCompletedTask(99) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000099(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(99) == npcId and Task_Accept_00000099 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 99
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_441;
	elseif task:GetTaskSubmitNpc(99) == npcId then
		if Task_Submit_00000099() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 99
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_442;
		elseif task:HasAcceptedTask(99) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 99
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_443;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000099_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_444..GetPlayerName(GetPlayer())..task_msg_445;
	action.m_ActionMsg = task_msg_446;
	return action;
end

function Task_00000099_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_447;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000099_step_table = {
		[1] = Task_00000099_step_01,
		[10] = Task_00000099_step_10,
		};

function Task_00000099_step(step)
	if Task_00000099_step_table[step] ~= nil then
		return Task_00000099_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000099_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000099() then
		return false;
	end
	if not task:AcceptTask(99) then
		return false;
	end
	task:AddTaskStep(99);
	return true;
end



--�ύ����
function Task_00000099_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(99) then
		return false;
	end


	player:AddExp(31000);
	return true;
end

--��������
function Task_00000099_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(99);
end
