--����Ľ�������
function Task_Accept_00000522()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(522) or task:HasCompletedTask(522) or task:HasSubmitedTask(522) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000522()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(522) or task:HasCompletedTask(522) or task:HasSubmitedTask(522) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000522()
	if GetPlayer():GetTaskMgr():HasCompletedTask(522) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000522(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(522) == npcId and Task_Accept_00000522 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 522
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1019;
	elseif task:GetTaskSubmitNpc(522) == npcId then
		if Task_Submit_00000522() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 522
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1020;
		elseif task:HasAcceptedTask(522) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 522
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1021;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000522_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1022;
	action.m_ActionMsg = task_msg_1023;
	return action;
end

function Task_00000522_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1024;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000522_step_table = {
		[1] = Task_00000522_step_01,
		[10] = Task_00000522_step_10,
		};

function Task_00000522_step(step)
	if Task_00000522_step_table[step] ~= nil then
		return Task_00000522_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000522_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000522() then
		return false;
	end
	if not task:AcceptTask(522) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000522_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(522) then
		return false;
	end


	return true;
end

--��������
function Task_00000522_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(522);
end
