--����Ľ�������
function Task_Accept_00000106()
	local player = GetPlayer();
	if player:GetLev() < 55 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(106) or task:HasCompletedTask(106) or task:HasSubmitedTask(106) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000106()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 55 then
		return false;
	end
	if task:HasAcceptedTask(106) or task:HasCompletedTask(106) or task:HasSubmitedTask(106) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(105) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000106()
	if GetPlayer():GetTaskMgr():HasCompletedTask(106) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000106(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(106) == npcId and Task_Accept_00000106 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 106
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_481;
	elseif task:GetTaskSubmitNpc(106) == npcId then
		if Task_Submit_00000106() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 106
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_482;
		elseif task:HasAcceptedTask(106) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 106
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_483;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000106_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_484..GetPlayerName(GetPlayer())..task_msg_485;
	action.m_ActionMsg = task_msg_486;
	return action;
end

function Task_00000106_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_487;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000106_step_table = {
		[1] = Task_00000106_step_01,
		[10] = Task_00000106_step_10,
		};

function Task_00000106_step(step)
	if Task_00000106_step_table[step] ~= nil then
		return Task_00000106_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000106_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000106() then
		return false;
	end
	if not task:AcceptTask(106) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000106_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(106) then
		return false;
	end


	player:AddExp(35000);
	return true;
end

--��������
function Task_00000106_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(106);
end
