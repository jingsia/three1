--����Ľ�������
function Task_Accept_00000040()
	local player = GetPlayer();
	if player:GetLev() < 23 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(40) or task:HasCompletedTask(40) or task:HasSubmitedTask(40) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000040()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 23 then
		return false;
	end
	if task:HasAcceptedTask(40) or task:HasCompletedTask(40) or task:HasSubmitedTask(40) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(39) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000040()
	if GetPlayer():GetTaskMgr():HasCompletedTask(40) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000040(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(40) == npcId and Task_Accept_00000040 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 40
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_280;
	elseif task:GetTaskSubmitNpc(40) == npcId then
		if Task_Submit_00000040() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 40
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_281;
		elseif task:HasAcceptedTask(40) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 40
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_282;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000040_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_283;
	action.m_ActionMsg = task_msg_284;
	return action;
end

function Task_00000040_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_285;
	action.m_ActionMsg = task_msg_286;
	return action;
end

function Task_00000040_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_287;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000040_step_table = {
		[1] = Task_00000040_step_01,
		[2] = Task_00000040_step_02,
		[10] = Task_00000040_step_10,
		};

function Task_00000040_step(step)
	if Task_00000040_step_table[step] ~= nil then
		return Task_00000040_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000040_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000040() then
		return false;
	end
	if not task:AcceptTask(40) then
		return false;
	end
	task:AddTaskStep(40);
	return true;
end



--�ύ����
function Task_00000040_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(40) then
		return false;
	end


	player:AddExp(6000);
	return true;
end

--��������
function Task_00000040_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(40);
end
