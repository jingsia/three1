--����Ľ�������
function Task_Accept_00000104()
	local player = GetPlayer();
	if player:GetLev() < 52 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(104) or task:HasCompletedTask(104) or task:HasSubmitedTask(104) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000104()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 52 then
		return false;
	end
	if task:HasAcceptedTask(104) or task:HasCompletedTask(104) or task:HasSubmitedTask(104) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(103) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000104()
	if GetPlayer():GetTaskMgr():HasCompletedTask(104) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000104(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(104) == npcId and Task_Accept_00000104 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 104
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_474;
	elseif task:GetTaskSubmitNpc(104) == npcId then
		if Task_Submit_00000104() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 104
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_475;
		elseif task:HasAcceptedTask(104) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 104
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_476;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000104_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_477..GetPlayerName(GetPlayer())..task_msg_478;
	action.m_ActionMsg = task_msg_479;
	return action;
end

function Task_00000104_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_480;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000104_step_table = {
		[1] = Task_00000104_step_01,
		[10] = Task_00000104_step_10,
		};

function Task_00000104_step(step)
	if Task_00000104_step_table[step] ~= nil then
		return Task_00000104_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000104_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000104() then
		return false;
	end
	if not task:AcceptTask(104) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000104_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(104) then
		return false;
	end


	player:AddExp(28000);
	return true;
end

--��������
function Task_00000104_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(104);
end
