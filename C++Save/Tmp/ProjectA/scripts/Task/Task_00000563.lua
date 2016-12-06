--����Ľ�������
function Task_Accept_00000563()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(563) or task:HasCompletedTask(563) or task:HasSubmitedTask(563) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000563()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(563) or task:HasCompletedTask(563) or task:HasSubmitedTask(563) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000563()
	if GetPlayer():GetTaskMgr():HasCompletedTask(563) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000563(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(563) == npcId and Task_Accept_00000563 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 563
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_811;
	elseif task:GetTaskSubmitNpc(563) == npcId then
		if Task_Submit_00000563() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 563
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_812;
		elseif task:HasAcceptedTask(563) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 563
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_813;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000563_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_814;
	action.m_ActionMsg = task_msg_815;
	return action;
end

function Task_00000563_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_816;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000563_step_table = {
		[1] = Task_00000563_step_01,
		[10] = Task_00000563_step_10,
		};

function Task_00000563_step(step)
	if Task_00000563_step_table[step] ~= nil then
		return Task_00000563_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000563_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000563() then
		return false;
	end
	if not task:AcceptTask(563) then
		return false;
	end
	task:AddTaskStep(563);
	return true;
end



--�ύ����
function Task_00000563_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(563) then
		return false;
	end


	return true;
end

--��������
function Task_00000563_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(563);
end
