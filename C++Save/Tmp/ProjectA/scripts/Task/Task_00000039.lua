--����Ľ�������
function Task_Accept_00000039()
	local player = GetPlayer();
	if player:GetLev() < 23 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(39) or task:HasCompletedTask(39) or task:HasSubmitedTask(39) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000039()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 23 then
		return false;
	end
	if task:HasAcceptedTask(39) or task:HasCompletedTask(39) or task:HasSubmitedTask(39) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(38) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000039()
	if GetPlayer():GetTaskMgr():HasCompletedTask(39) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000039(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(39) == npcId and Task_Accept_00000039 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 39
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_274;
	elseif task:GetTaskSubmitNpc(39) == npcId then
		if Task_Submit_00000039() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 39
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_275;
		elseif task:HasAcceptedTask(39) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 39
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_276;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000039_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_277;
	action.m_ActionMsg = task_msg_278;
	return action;
end

function Task_00000039_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_279;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000039_step_table = {
		[1] = Task_00000039_step_01,
		[10] = Task_00000039_step_10,
		};

function Task_00000039_step(step)
	if Task_00000039_step_table[step] ~= nil then
		return Task_00000039_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000039_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000039() then
		return false;
	end
	if not task:AcceptTask(39) then
		return false;
	end
	task:AddTaskStep(39);
	return true;
end



--�ύ����
function Task_00000039_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(39) then
		return false;
	end


	player:AddExp(6000);
	return true;
end

--��������
function Task_00000039_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(39);
end
