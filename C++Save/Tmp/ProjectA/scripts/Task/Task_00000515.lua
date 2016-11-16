--����Ľ�������
function Task_Accept_00000515()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(515) or task:HasCompletedTask(515) or task:HasSubmitedTask(515) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000515()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(515) or task:HasCompletedTask(515) or task:HasSubmitedTask(515) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000515()
	if GetPlayer():GetTaskMgr():HasCompletedTask(515) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000515(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(515) == npcId and Task_Accept_00000515 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 515
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_685;
	elseif task:GetTaskSubmitNpc(515) == npcId then
		if Task_Submit_00000515() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 515
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_686;
		elseif task:HasAcceptedTask(515) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 515
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_687;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000515_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_688;
	action.m_ActionMsg = task_msg_689;
	return action;
end

function Task_00000515_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_690;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000515_step_table = {
		[1] = Task_00000515_step_01,
		[10] = Task_00000515_step_10,
		};

function Task_00000515_step(step)
	if Task_00000515_step_table[step] ~= nil then
		return Task_00000515_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000515_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000515() then
		return false;
	end
	if not task:AcceptTask(515) then
		return false;
	end
	task:AddTaskStep(515);
	return true;
end



--�ύ����
function Task_00000515_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(515) then
		return false;
	end


	return true;
end

--��������
function Task_00000515_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(515);
end
