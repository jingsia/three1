--����Ľ�������
function Task_Accept_00000186()
	local player = GetPlayer();
	if player:GetLev() < 90 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(186) or task:HasCompletedTask(186) or task:HasSubmitedTask(186) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000186()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 90 then
		return false;
	end
	if task:HasAcceptedTask(186) or task:HasCompletedTask(186) or task:HasSubmitedTask(186) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(185) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000186()
	if GetPlayer():GetTaskMgr():HasCompletedTask(186) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000186(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(186) == npcId and Task_Accept_00000186 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 186
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1816;
	elseif task:GetTaskSubmitNpc(186) == npcId then
		if Task_Submit_00000186() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 186
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1817;
		elseif task:HasAcceptedTask(186) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 186
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1818;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000186_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1819;
	action.m_ActionMsg = task_msg_1820;
	return action;
end

function Task_00000186_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1821;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000186_step_table = {
		[1] = Task_00000186_step_01,
		[10] = Task_00000186_step_10,
		};

function Task_00000186_step(step)
	if Task_00000186_step_table[step] ~= nil then
		return Task_00000186_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000186_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000186() then
		return false;
	end
	if not task:AcceptTask(186) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000186_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(186) then
		return false;
	end


	player:AddExp(150000);
	return true;
end

--��������
function Task_00000186_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(186);
end
