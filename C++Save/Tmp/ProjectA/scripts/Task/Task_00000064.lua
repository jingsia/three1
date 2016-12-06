--����Ľ�������
function Task_Accept_00000064()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(64) or task:HasCompletedTask(64) or task:HasSubmitedTask(64) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000064()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(64) or task:HasCompletedTask(64) or task:HasSubmitedTask(64) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(129) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000064()
	if GetPlayer():GetTaskMgr():HasCompletedTask(64) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000064(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(64) == npcId and Task_Accept_00000064 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 64
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2126;
	elseif task:GetTaskSubmitNpc(64) == npcId then
		if Task_Submit_00000064() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 64
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2127;
		elseif task:HasAcceptedTask(64) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 64
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2128;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000064_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2129..GetPlayerName(GetPlayer())..task_msg_2130;
	action.m_ActionMsg = task_msg_2131;
	return action;
end

function Task_00000064_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2132;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000064_step_table = {
		[1] = Task_00000064_step_01,
		[10] = Task_00000064_step_10,
		};

function Task_00000064_step(step)
	if Task_00000064_step_table[step] ~= nil then
		return Task_00000064_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000064_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000064() then
		return false;
	end
	if not task:AcceptTask(64) then
		return false;
	end
	task:AddTaskStep(64);
	return true;
end



--�ύ����
function Task_00000064_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(64) then
		return false;
	end


	player:AddExp(80000);
	return true;
end

--��������
function Task_00000064_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(64);
end
