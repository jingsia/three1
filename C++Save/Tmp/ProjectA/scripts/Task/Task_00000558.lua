--����Ľ�������
function Task_Accept_00000558()
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(558) or task:HasCompletedTask(558) or task:HasSubmitedTask(558) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000558()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 1 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(558) or task:HasCompletedTask(558) or task:HasSubmitedTask(558) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000558()
	if GetPlayer():GetTaskMgr():HasCompletedTask(558) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000558(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(558) == npcId and Task_Accept_00000558 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 558
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_777;
	elseif task:GetTaskSubmitNpc(558) == npcId then
		if Task_Submit_00000558() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 558
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_778;
		elseif task:HasAcceptedTask(558) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 558
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_779;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000558_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_780..GetPlayerName(GetPlayer())..task_msg_781;
	action.m_ActionMsg = task_msg_782;
	return action;
end

function Task_00000558_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_783;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000558_step_table = {
		[1] = Task_00000558_step_01,
		[10] = Task_00000558_step_10,
		};

function Task_00000558_step(step)
	if Task_00000558_step_table[step] ~= nil then
		return Task_00000558_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000558_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000558() then
		return false;
	end
	if not task:AcceptTask(558) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000558_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(558) then
		return false;
	end


	return true;
end

--��������
function Task_00000558_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(558);
end
