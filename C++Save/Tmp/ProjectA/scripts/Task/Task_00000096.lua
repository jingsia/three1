--����Ľ�������
function Task_Accept_00000096()
	local player = GetPlayer();
	if player:GetLev() < 50 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(96) or task:HasCompletedTask(96) or task:HasSubmitedTask(96) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000096()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 50 then
		return false;
	end
	if task:HasAcceptedTask(96) or task:HasCompletedTask(96) or task:HasSubmitedTask(96) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(95) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000096()
	if GetPlayer():GetTaskMgr():HasCompletedTask(96) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000096(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(96) == npcId and Task_Accept_00000096 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 96
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_421;
	elseif task:GetTaskSubmitNpc(96) == npcId then
		if Task_Submit_00000096() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 96
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_422;
		elseif task:HasAcceptedTask(96) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 96
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_423;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000096_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_424;
	action.m_ActionMsg = task_msg_425;
	return action;
end

function Task_00000096_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_426;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000096_step_table = {
		[1] = Task_00000096_step_01,
		[10] = Task_00000096_step_10,
		};

function Task_00000096_step(step)
	if Task_00000096_step_table[step] ~= nil then
		return Task_00000096_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000096_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000096() then
		return false;
	end
	if not task:AcceptTask(96) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000096_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(96) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000096_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(96);
end
