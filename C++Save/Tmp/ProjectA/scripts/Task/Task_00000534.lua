--����Ľ�������
function Task_Accept_00000534()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(534) or task:HasCompletedTask(534) or task:HasSubmitedTask(534) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000534()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(534) or task:HasCompletedTask(534) or task:HasSubmitedTask(534) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000534()
	if GetPlayer():GetTaskMgr():HasCompletedTask(534) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000534(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(534) == npcId and Task_Accept_00000534 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 534
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1307;
	elseif task:GetTaskSubmitNpc(534) == npcId then
		if Task_Submit_00000534() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 534
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1308;
		elseif task:HasAcceptedTask(534) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 534
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1309;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000534_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1310..GetPlayerName(GetPlayer())..task_msg_1311;
	action.m_ActionMsg = task_msg_1312;
	return action;
end

function Task_00000534_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1313;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000534_step_table = {
		[1] = Task_00000534_step_01,
		[10] = Task_00000534_step_10,
		};

function Task_00000534_step(step)
	if Task_00000534_step_table[step] ~= nil then
		return Task_00000534_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000534_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000534() then
		return false;
	end
	if not task:AcceptTask(534) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000534_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(534) then
		return false;
	end


	return true;
end

--��������
function Task_00000534_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(534);
end
