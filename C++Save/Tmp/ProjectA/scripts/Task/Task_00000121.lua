--����Ľ�������
function Task_Accept_00000121()
	local player = GetPlayer();
	if player:GetLev() < 32 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(121) or task:HasCompletedTask(121) or task:HasSubmitedTask(121) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000121()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 32 then
		return false;
	end
	if task:HasAcceptedTask(121) or task:HasCompletedTask(121) or task:HasSubmitedTask(121) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(50) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000121()
	if GetPlayer():GetTaskMgr():HasCompletedTask(121) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000121(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(121) == npcId and Task_Accept_00000121 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 121
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_560;
	elseif task:GetTaskSubmitNpc(121) == npcId then
		if Task_Submit_00000121() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 121
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_561;
		elseif task:HasAcceptedTask(121) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 121
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_562;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000121_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_563;
	action.m_ActionMsg = task_msg_564;
	return action;
end

function Task_00000121_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_565..GetPlayerName(GetPlayer())..task_msg_566;
	action.m_ActionMsg = task_msg_567;
	return action;
end

function Task_00000121_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_568..GetPlayerName(GetPlayer())..task_msg_569;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000121_step_table = {
		[1] = Task_00000121_step_01,
		[2] = Task_00000121_step_02,
		[10] = Task_00000121_step_10,
		};

function Task_00000121_step(step)
	if Task_00000121_step_table[step] ~= nil then
		return Task_00000121_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000121_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000121() then
		return false;
	end
	if not task:AcceptTask(121) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000121_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(121) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000121_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(121);
end
