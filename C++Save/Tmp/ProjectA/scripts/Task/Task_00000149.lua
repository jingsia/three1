--����Ľ�������
function Task_Accept_00000149()
	local player = GetPlayer();
	if player:GetLev() < 70 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(149) or task:HasCompletedTask(149) or task:HasSubmitedTask(149) then
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
function Task_Can_Accept_00000149()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 70 then
		return false;
	end
	if task:HasAcceptedTask(149) or task:HasCompletedTask(149) or task:HasSubmitedTask(149) then
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
function Task_Submit_00000149()
	if GetPlayer():GetTaskMgr():HasCompletedTask(149) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000149(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(149) == npcId and Task_Accept_00000149 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 149
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2060;
	elseif task:GetTaskSubmitNpc(149) == npcId then
		if Task_Submit_00000149() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 149
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2061;
		elseif task:HasAcceptedTask(149) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 149
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2062;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000149_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2063;
	action.m_ActionMsg = task_msg_2064;
	return action;
end

function Task_00000149_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_2065;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000149_step_table = {
		[1] = Task_00000149_step_01,
		[10] = Task_00000149_step_10,
		};

function Task_00000149_step(step)
	if Task_00000149_step_table[step] ~= nil then
		return Task_00000149_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000149_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000149() then
		return false;
	end
	if not task:AcceptTask(149) then
		return false;
	end
	task:AddTaskStep(149);
	return true;
end



--�ύ����
function Task_00000149_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(149) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000149_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(149);
end