--����Ľ�������
function Task_Accept_00000073()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 500 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(73) or task:HasCompletedTask(73) or task:HasSubmitedTask(73) then
		return false;
	end
	if not task:HasSubmitedTask(71) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000073()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 500 then
		return false;
	end
	if task:HasAcceptedTask(73) or task:HasCompletedTask(73) or task:HasSubmitedTask(73) then
		return false;
	end
	if not task:HasSubmitedTask(71) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000073()
	if GetPlayer():GetTaskMgr():HasCompletedTask(73) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000073(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(73) == npcId and Task_Accept_00000073 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 73
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2114;
	elseif task:GetTaskSubmitNpc(73) == npcId then
		if Task_Submit_00000073() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 73
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2115;
		elseif task:HasAcceptedTask(73) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 73
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2116;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000073_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2117;
	action.m_ActionMsg = task_msg_2118;
	return action;
end

function Task_00000073_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2119;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000073_step_table = {
		[1] = Task_00000073_step_01,
		[10] = Task_00000073_step_10,
		};

function Task_00000073_step(step)
	if Task_00000073_step_table[step] ~= nil then
		return Task_00000073_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000073_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000073() then
		return false;
	end
	if not task:AcceptTask(73) then
		return false;
	end
	task:AddTaskStep(73);
	return true;
end



--�ύ����
function Task_00000073_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(73) then
		return false;
	end


	player:AddExp(10000);
	return true;
end

--��������
function Task_00000073_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(73);
end
