--����Ľ�������
function Task_Accept_00000037()
	local player = GetPlayer();
	if player:GetLev() < 45 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(37) or task:HasCompletedTask(37) or task:HasSubmitedTask(37) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000037()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 45 then
		return false;
	end
	if task:HasAcceptedTask(37) or task:HasCompletedTask(37) or task:HasSubmitedTask(37) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000037()
	if GetPlayer():GetTaskMgr():HasCompletedTask(37) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000037(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(37) == npcId and Task_Accept_00000037 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 37
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_960;
	elseif task:GetTaskSubmitNpc(37) == npcId then
		if Task_Submit_00000037() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 37
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_961;
		elseif task:HasAcceptedTask(37) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 37
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_962;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000037_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_963..GetPlayerName(GetPlayer())..task_msg_964;
	action.m_ActionMsg = task_msg_965;
	return action;
end

function Task_00000037_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_966;
	action.m_ActionMsg = task_msg_967;
	return action;
end

function Task_00000037_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_968;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000037_step_table = {
		[1] = Task_00000037_step_01,
		[2] = Task_00000037_step_02,
		[10] = Task_00000037_step_10,
		};

function Task_00000037_step(step)
	if Task_00000037_step_table[step] ~= nil then
		return Task_00000037_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000037_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000037() then
		return false;
	end
	if not task:AcceptTask(37) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000037_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(37) then
		return false;
	end


	player:AddExp(30000);
	return true;
end

--��������
function Task_00000037_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(37);
end
