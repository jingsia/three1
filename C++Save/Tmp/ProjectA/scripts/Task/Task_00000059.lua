--����Ľ�������
function Task_Accept_00000059()
	local player = GetPlayer();
	if player:GetLev() < 35 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(59) or task:HasCompletedTask(59) or task:HasSubmitedTask(59) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000059()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 35 then
		return false;
	end
	if task:HasAcceptedTask(59) or task:HasCompletedTask(59) or task:HasSubmitedTask(59) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(58) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000059()
	if GetPlayer():GetTaskMgr():HasCompletedTask(59) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000059(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(59) == npcId and Task_Accept_00000059 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 59
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1577;
	elseif task:GetTaskSubmitNpc(59) == npcId then
		if Task_Submit_00000059() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 59
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1578;
		elseif task:HasAcceptedTask(59) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 59
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1579;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000059_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1580;
	action.m_ActionMsg = task_msg_1581;
	return action;
end

function Task_00000059_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1582;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000059_step_table = {
		[1] = Task_00000059_step_01,
		[10] = Task_00000059_step_10,
		};

function Task_00000059_step(step)
	if Task_00000059_step_table[step] ~= nil then
		return Task_00000059_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000059_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000059() then
		return false;
	end
	if not task:AcceptTask(59) then
		return false;
	end
	task:AddTaskStep(59);
	return true;
end



--�ύ����
function Task_00000059_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(59) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000059_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(59);
end
