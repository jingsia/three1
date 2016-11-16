--����Ľ�������
function Task_Accept_00000158()
	local player = GetPlayer();
	if player:GetLev() < 75 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(158) or task:HasCompletedTask(158) or task:HasSubmitedTask(158) then
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
function Task_Can_Accept_00000158()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 75 then
		return false;
	end
	if task:HasAcceptedTask(158) or task:HasCompletedTask(158) or task:HasSubmitedTask(158) then
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
function Task_Submit_00000158()
	if GetPlayer():GetTaskMgr():HasCompletedTask(158) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000158(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(158) == npcId and Task_Accept_00000158 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 158
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2054;
	elseif task:GetTaskSubmitNpc(158) == npcId then
		if Task_Submit_00000158() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 158
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2055;
		elseif task:HasAcceptedTask(158) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 158
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2056;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000158_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2057;
	action.m_ActionMsg = task_msg_2058;
	return action;
end

function Task_00000158_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2059;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000158_step_table = {
		[1] = Task_00000158_step_01,
		[10] = Task_00000158_step_10,
		};

function Task_00000158_step(step)
	if Task_00000158_step_table[step] ~= nil then
		return Task_00000158_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000158_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000158() then
		return false;
	end
	if not task:AcceptTask(158) then
		return false;
	end
	task:AddTaskStep(158);
	return true;
end



--�ύ����
function Task_00000158_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(158) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000158_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(158);
end
