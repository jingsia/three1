--����Ľ�������
function Task_Accept_00000187()
	local player = GetPlayer();
	if player:GetLev() < 90 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(187) or task:HasCompletedTask(187) or task:HasSubmitedTask(187) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000187()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 90 then
		return false;
	end
	if task:HasAcceptedTask(187) or task:HasCompletedTask(187) or task:HasSubmitedTask(187) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(186) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000187()
	if GetPlayer():GetTaskMgr():HasCompletedTask(187) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000187(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(187) == npcId and Task_Accept_00000187 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 187
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1822;
	elseif task:GetTaskSubmitNpc(187) == npcId then
		if Task_Submit_00000187() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 187
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1823;
		elseif task:HasAcceptedTask(187) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 187
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1824;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000187_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1825;
	action.m_ActionMsg = task_msg_1826;
	return action;
end

function Task_00000187_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1827;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000187_step_table = {
		[1] = Task_00000187_step_01,
		[10] = Task_00000187_step_10,
		};

function Task_00000187_step(step)
	if Task_00000187_step_table[step] ~= nil then
		return Task_00000187_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000187_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000187() then
		return false;
	end
	if not task:AcceptTask(187) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000187_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(187) then
		return false;
	end


	player:AddExp(150000);
	return true;
end

--��������
function Task_00000187_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(187);
end
