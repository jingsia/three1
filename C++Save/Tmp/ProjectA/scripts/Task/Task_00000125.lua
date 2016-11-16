--����Ľ�������
function Task_Accept_00000125()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(125) or task:HasCompletedTask(125) or task:HasSubmitedTask(125) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000125()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(125) or task:HasCompletedTask(125) or task:HasSubmitedTask(125) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(124) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000125()
	if GetPlayer():GetTaskMgr():HasCompletedTask(125) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000125(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(125) == npcId and Task_Accept_00000125 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 125
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2156;
	elseif task:GetTaskSubmitNpc(125) == npcId then
		if Task_Submit_00000125() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 125
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2157;
		elseif task:HasAcceptedTask(125) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 125
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2158;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000125_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_2159;
	action.m_ActionMsg = task_msg_2160;
	return action;
end

function Task_00000125_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_2161;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000125_step_table = {
		[1] = Task_00000125_step_01,
		[10] = Task_00000125_step_10,
		};

function Task_00000125_step(step)
	if Task_00000125_step_table[step] ~= nil then
		return Task_00000125_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000125_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000125() then
		return false;
	end
	if not task:AcceptTask(125) then
		return false;
	end
	task:AddTaskStep(125);
	return true;
end



--�ύ����
function Task_00000125_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(125) then
		return false;
	end


	player:AddExp(5000);
	return true;
end

--��������
function Task_00000125_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(125);
end
