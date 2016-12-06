--����Ľ�������
function Task_Accept_00000192()
	local player = GetPlayer();
	if player:GetLev() < 95 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(192) or task:HasCompletedTask(192) or task:HasSubmitedTask(192) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000192()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 95 then
		return false;
	end
	if task:HasAcceptedTask(192) or task:HasCompletedTask(192) or task:HasSubmitedTask(192) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(191) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000192()
	if GetPlayer():GetTaskMgr():HasCompletedTask(192) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000192(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(192) == npcId and Task_Accept_00000192 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 192
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1909;
	elseif task:GetTaskSubmitNpc(192) == npcId then
		if Task_Submit_00000192() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 192
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1910;
		elseif task:HasAcceptedTask(192) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 192
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1911;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000192_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1912;
	action.m_ActionMsg = task_msg_1913;
	return action;
end

function Task_00000192_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1914;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000192_step_table = {
		[1] = Task_00000192_step_01,
		[10] = Task_00000192_step_10,
		};

function Task_00000192_step(step)
	if Task_00000192_step_table[step] ~= nil then
		return Task_00000192_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000192_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000192() then
		return false;
	end
	if not task:AcceptTask(192) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000192_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(192) then
		return false;
	end


	player:AddExp(180000);
	return true;
end

--��������
function Task_00000192_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(192);
end
