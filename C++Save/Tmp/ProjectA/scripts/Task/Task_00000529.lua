--����Ľ�������
function Task_Accept_00000529()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(529) or task:HasCompletedTask(529) or task:HasSubmitedTask(529) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000529()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(529) or task:HasCompletedTask(529) or task:HasSubmitedTask(529) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000529()
	if GetPlayer():GetTaskMgr():HasCompletedTask(529) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000529(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(529) == npcId and Task_Accept_00000529 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 529
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1272;
	elseif task:GetTaskSubmitNpc(529) == npcId then
		if Task_Submit_00000529() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 529
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1273;
		elseif task:HasAcceptedTask(529) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 529
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1274;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000529_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1275..GetPlayerName(GetPlayer())..task_msg_1276;
	action.m_ActionMsg = task_msg_1277;
	return action;
end

function Task_00000529_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1278;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000529_step_table = {
		[1] = Task_00000529_step_01,
		[10] = Task_00000529_step_10,
		};

function Task_00000529_step(step)
	if Task_00000529_step_table[step] ~= nil then
		return Task_00000529_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000529_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000529() then
		return false;
	end
	if not task:AcceptTask(529) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000529_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(529) then
		return false;
	end


	return true;
end

--��������
function Task_00000529_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(529);
end
