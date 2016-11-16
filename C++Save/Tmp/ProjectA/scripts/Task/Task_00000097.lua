--����Ľ�������
function Task_Accept_00000097()
	local player = GetPlayer();
	if player:GetLev() < 50 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(97) or task:HasCompletedTask(97) or task:HasSubmitedTask(97) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000097()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 50 then
		return false;
	end
	if task:HasAcceptedTask(97) or task:HasCompletedTask(97) or task:HasSubmitedTask(97) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(96) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000097()
	if GetPlayer():GetTaskMgr():HasCompletedTask(97) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000097(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(97) == npcId and Task_Accept_00000097 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 97
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_427;
	elseif task:GetTaskSubmitNpc(97) == npcId then
		if Task_Submit_00000097() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 97
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_428;
		elseif task:HasAcceptedTask(97) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 97
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_429;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000097_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_430..GetPlayerName(GetPlayer())..task_msg_431;
	action.m_ActionMsg = task_msg_432;
	return action;
end

function Task_00000097_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_433..GetPlayerName(GetPlayer())..task_msg_434;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000097_step_table = {
		[1] = Task_00000097_step_01,
		[10] = Task_00000097_step_10,
		};

function Task_00000097_step(step)
	if Task_00000097_step_table[step] ~= nil then
		return Task_00000097_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000097_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000097() then
		return false;
	end
	if not task:AcceptTask(97) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000097_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(97) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000097_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(97);
end
