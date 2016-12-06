--����Ľ�������
function Task_Accept_00000154()
	local player = GetPlayer();
	if player:GetLev() < 70 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(154) or task:HasCompletedTask(154) or task:HasSubmitedTask(154) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000154()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 70 then
		return false;
	end
	if task:HasAcceptedTask(154) or task:HasCompletedTask(154) or task:HasSubmitedTask(154) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(153) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000154()
	if GetPlayer():GetTaskMgr():HasCompletedTask(154) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000154(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(154) == npcId and Task_Accept_00000154 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 154
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1624;
	elseif task:GetTaskSubmitNpc(154) == npcId then
		if Task_Submit_00000154() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 154
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1625;
		elseif task:HasAcceptedTask(154) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 154
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1626;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000154_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1627;
	action.m_ActionMsg = task_msg_1628;
	return action;
end

function Task_00000154_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1629;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000154_step_table = {
		[1] = Task_00000154_step_01,
		[10] = Task_00000154_step_10,
		};

function Task_00000154_step(step)
	if Task_00000154_step_table[step] ~= nil then
		return Task_00000154_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000154_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000154() then
		return false;
	end
	if not task:AcceptTask(154) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000154_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(154) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000154_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(154);
end
