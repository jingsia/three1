--����Ľ�������
function Task_Accept_00000163()
	local player = GetPlayer();
	if player:GetLev() < 75 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(163) or task:HasCompletedTask(163) or task:HasSubmitedTask(163) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000163()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 75 then
		return false;
	end
	if task:HasAcceptedTask(163) or task:HasCompletedTask(163) or task:HasSubmitedTask(163) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(162) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000163()
	if GetPlayer():GetTaskMgr():HasCompletedTask(163) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000163(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(163) == npcId and Task_Accept_00000163 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 163
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1666;
	elseif task:GetTaskSubmitNpc(163) == npcId then
		if Task_Submit_00000163() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 163
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1667;
		elseif task:HasAcceptedTask(163) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 163
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1668;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000163_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1669;
	action.m_ActionMsg = task_msg_1670;
	return action;
end

function Task_00000163_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1671;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000163_step_table = {
		[1] = Task_00000163_step_01,
		[10] = Task_00000163_step_10,
		};

function Task_00000163_step(step)
	if Task_00000163_step_table[step] ~= nil then
		return Task_00000163_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000163_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000163() then
		return false;
	end
	if not task:AcceptTask(163) then
		return false;
	end
	task:AddTaskStep(163);
	return true;
end



--�ύ����
function Task_00000163_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(163) then
		return false;
	end


	player:AddExp(100000);
	return true;
end

--��������
function Task_00000163_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(163);
end
