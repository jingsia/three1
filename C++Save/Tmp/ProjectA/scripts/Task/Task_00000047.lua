--����Ľ�������
function Task_Accept_00000047()
	local player = GetPlayer();
	if player:GetLev() < 28 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(47) or task:HasCompletedTask(47) or task:HasSubmitedTask(47) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000047()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 28 then
		return false;
	end
	if task:HasAcceptedTask(47) or task:HasCompletedTask(47) or task:HasSubmitedTask(47) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(46) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000047()
	if GetPlayer():GetTaskMgr():HasCompletedTask(47) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000047(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(47) == npcId and Task_Accept_00000047 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 47
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_332;
	elseif task:GetTaskSubmitNpc(47) == npcId then
		if Task_Submit_00000047() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 47
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_333;
		elseif task:HasAcceptedTask(47) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 47
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_334;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000047_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_335;
	action.m_ActionMsg = task_msg_336;
	return action;
end

function Task_00000047_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_337;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000047_step_table = {
		[1] = Task_00000047_step_01,
		[10] = Task_00000047_step_10,
		};

function Task_00000047_step(step)
	if Task_00000047_step_table[step] ~= nil then
		return Task_00000047_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000047_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000047() then
		return false;
	end
	if not task:AcceptTask(47) then
		return false;
	end
	task:AddTaskStep(47);
	return true;
end



--�ύ����
function Task_00000047_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(47) then
		return false;
	end


	player:AddExp(8000);
	return true;
end

--��������
function Task_00000047_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(47);
end
