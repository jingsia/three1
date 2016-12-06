--����Ľ�������
function Task_Accept_00000622()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(622) or task:HasCompletedTask(622) or task:HasSubmitedTask(622) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000622()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(622) or task:HasCompletedTask(622) or task:HasSubmitedTask(622) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000622()
	if GetPlayer():GetTaskMgr():HasCompletedTask(622) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000622(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(622) == npcId and Task_Accept_00000622 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 622
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1127;
	elseif task:GetTaskSubmitNpc(622) == npcId then
		if Task_Submit_00000622() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 622
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1128;
		elseif task:HasAcceptedTask(622) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 622
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1129;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000622_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1130;
	action.m_ActionMsg = task_msg_1131;
	return action;
end

function Task_00000622_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1132;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000622_step_table = {
		[1] = Task_00000622_step_01,
		[10] = Task_00000622_step_10,
		};

function Task_00000622_step(step)
	if Task_00000622_step_table[step] ~= nil then
		return Task_00000622_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000622_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000622() then
		return false;
	end
	if not task:AcceptTask(622) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000622_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(622) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000622_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(622);
end
