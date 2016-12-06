--����Ľ�������
function Task_Accept_00000623()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(623) or task:HasCompletedTask(623) or task:HasSubmitedTask(623) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000623()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(623) or task:HasCompletedTask(623) or task:HasSubmitedTask(623) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000623()
	if GetPlayer():GetTaskMgr():HasCompletedTask(623) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000623(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(623) == npcId and Task_Accept_00000623 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 623
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1133;
	elseif task:GetTaskSubmitNpc(623) == npcId then
		if Task_Submit_00000623() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 623
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1134;
		elseif task:HasAcceptedTask(623) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 623
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1135;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000623_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1136..GetPlayerName(GetPlayer())..task_msg_1137;
	action.m_ActionMsg = task_msg_1138;
	return action;
end

function Task_00000623_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1139;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000623_step_table = {
		[1] = Task_00000623_step_01,
		[10] = Task_00000623_step_10,
		};

function Task_00000623_step(step)
	if Task_00000623_step_table[step] ~= nil then
		return Task_00000623_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000623_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000623() then
		return false;
	end
	if not task:AcceptTask(623) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000623_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(623) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000623_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(623);
end
