--����Ľ�������
function Task_Accept_00000607()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(607) or task:HasCompletedTask(607) or task:HasSubmitedTask(607) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000607()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(607) or task:HasCompletedTask(607) or task:HasSubmitedTask(607) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000607()
	if GetPlayer():GetTaskMgr():HasCompletedTask(607) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000607(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(607) == npcId and Task_Accept_00000607 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 607
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_895;
	elseif task:GetTaskSubmitNpc(607) == npcId then
		if Task_Submit_00000607() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 607
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_896;
		elseif task:HasAcceptedTask(607) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 607
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_897;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000607_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_898..GetPlayerName(GetPlayer())..task_msg_899;
	action.m_ActionMsg = task_msg_900;
	return action;
end

function Task_00000607_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_901;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000607_step_table = {
		[1] = Task_00000607_step_01,
		[10] = Task_00000607_step_10,
		};

function Task_00000607_step(step)
	if Task_00000607_step_table[step] ~= nil then
		return Task_00000607_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000607_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000607() then
		return false;
	end
	if not task:AcceptTask(607) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000607_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(607) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000607_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(607);
end
