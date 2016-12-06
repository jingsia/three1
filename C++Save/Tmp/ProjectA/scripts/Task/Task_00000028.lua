--����Ľ�������
function Task_Accept_00000028()
	local player = GetPlayer();
	if player:GetLev() < 18 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(28) or task:HasCompletedTask(28) or task:HasSubmitedTask(28) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000028()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 18 then
		return false;
	end
	if task:HasAcceptedTask(28) or task:HasCompletedTask(28) or task:HasSubmitedTask(28) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(27) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000028()
	if GetPlayer():GetTaskMgr():HasCompletedTask(28) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000028(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(28) == npcId and Task_Accept_00000028 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 28
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_207;
	elseif task:GetTaskSubmitNpc(28) == npcId then
		if Task_Submit_00000028() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 28
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_208;
		elseif task:HasAcceptedTask(28) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 28
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_209;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000028_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_210;
	action.m_ActionMsg = task_msg_211;
	return action;
end

function Task_00000028_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_212;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000028_step_table = {
		[1] = Task_00000028_step_01,
		[10] = Task_00000028_step_10,
		};

function Task_00000028_step(step)
	if Task_00000028_step_table[step] ~= nil then
		return Task_00000028_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000028_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000028() then
		return false;
	end
	if not task:AcceptTask(28) then
		return false;
	end
	task:AddTaskStep(28);
	return true;
end



--�ύ����
function Task_00000028_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(28) then
		return false;
	end


	player:AddExp(2200);
	return true;
end

--��������
function Task_00000028_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(28);
end
