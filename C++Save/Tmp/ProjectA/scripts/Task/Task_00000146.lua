--����Ľ�������
function Task_Accept_00000146()
	local player = GetPlayer();
	if player:GetLev() < 60 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(146) or task:HasCompletedTask(146) or task:HasSubmitedTask(146) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000146()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 60 then
		return false;
	end
	if task:HasAcceptedTask(146) or task:HasCompletedTask(146) or task:HasSubmitedTask(146) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(144) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000146()
	if GetPlayer():GetTaskMgr():HasCompletedTask(146) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000146(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(146) == npcId and Task_Accept_00000146 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 146
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1726;
	elseif task:GetTaskSubmitNpc(146) == npcId then
		if Task_Submit_00000146() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 146
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1727;
		elseif task:HasAcceptedTask(146) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 146
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1728;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000146_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1729;
	action.m_ActionMsg = task_msg_1730;
	return action;
end

function Task_00000146_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1731;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000146_step_table = {
		[1] = Task_00000146_step_01,
		[10] = Task_00000146_step_10,
		};

function Task_00000146_step(step)
	if Task_00000146_step_table[step] ~= nil then
		return Task_00000146_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000146_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000146() then
		return false;
	end
	if not task:AcceptTask(146) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000146_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(146) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000146_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(146);
end
