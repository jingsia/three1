--����Ľ�������
function Task_Accept_00000091()
	local player = GetPlayer();
	if player:GetLev() < 46 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(91) or task:HasCompletedTask(91) or task:HasSubmitedTask(91) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000091()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 46 then
		return false;
	end
	if task:HasAcceptedTask(91) or task:HasCompletedTask(91) or task:HasSubmitedTask(91) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(90) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000091()
	if GetPlayer():GetTaskMgr():HasCompletedTask(91) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000091(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(91) == npcId and Task_Accept_00000091 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 91
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_399;
	elseif task:GetTaskSubmitNpc(91) == npcId then
		if Task_Submit_00000091() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 91
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_400;
		elseif task:HasAcceptedTask(91) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 91
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_401;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000091_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_402;
	action.m_ActionMsg = task_msg_403;
	return action;
end

function Task_00000091_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_404;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000091_step_table = {
		[1] = Task_00000091_step_01,
		[10] = Task_00000091_step_10,
		};

function Task_00000091_step(step)
	if Task_00000091_step_table[step] ~= nil then
		return Task_00000091_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000091_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000091() then
		return false;
	end
	if not task:AcceptTask(91) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000091_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(91) then
		return false;
	end


	player:AddExp(20000);
	return true;
end

--��������
function Task_00000091_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(91);
end
