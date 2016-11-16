--����Ľ�������
function Task_Accept_00000080()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(80) or task:HasCompletedTask(80) or task:HasSubmitedTask(80) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000080()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(80) or task:HasCompletedTask(80) or task:HasSubmitedTask(80) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(79) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000080()
	if GetPlayer():GetTaskMgr():HasCompletedTask(80) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000080(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(80) == npcId and Task_Accept_00000080 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 80
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2008;
	elseif task:GetTaskSubmitNpc(80) == npcId then
		if Task_Submit_00000080() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 80
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2009;
		elseif task:HasAcceptedTask(80) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 80
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2010;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000080_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_2011;
	action.m_ActionMsg = task_msg_2012;
	return action;
end

function Task_00000080_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2013;
	action.m_ActionMsg = task_msg_2014;
	return action;
end

function Task_00000080_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2015;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000080_step_table = {
		[1] = Task_00000080_step_01,
		[2] = Task_00000080_step_02,
		[10] = Task_00000080_step_10,
		};

function Task_00000080_step(step)
	if Task_00000080_step_table[step] ~= nil then
		return Task_00000080_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000080_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000080() then
		return false;
	end
	if not task:AcceptTask(80) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000080_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(80) then
		return false;
	end


	player:AddExp(260000);
	return true;
end

--��������
function Task_00000080_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(80);
end
