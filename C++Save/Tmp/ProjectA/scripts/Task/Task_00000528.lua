--����Ľ�������
function Task_Accept_00000528()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(528) or task:HasCompletedTask(528) or task:HasSubmitedTask(528) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000528()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(528) or task:HasCompletedTask(528) or task:HasSubmitedTask(528) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000528()
	if GetPlayer():GetTaskMgr():HasCompletedTask(528) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000528(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(528) == npcId and Task_Accept_00000528 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 528
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1265;
	elseif task:GetTaskSubmitNpc(528) == npcId then
		if Task_Submit_00000528() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 528
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1266;
		elseif task:HasAcceptedTask(528) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 528
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1267;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000528_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1268..GetPlayerName(GetPlayer())..task_msg_1269;
	action.m_ActionMsg = task_msg_1270;
	return action;
end

function Task_00000528_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1271;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000528_step_table = {
		[1] = Task_00000528_step_01,
		[10] = Task_00000528_step_10,
		};

function Task_00000528_step(step)
	if Task_00000528_step_table[step] ~= nil then
		return Task_00000528_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000528_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000528() then
		return false;
	end
	if not task:AcceptTask(528) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000528_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(528) then
		return false;
	end


	return true;
end

--��������
function Task_00000528_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(528);
end
