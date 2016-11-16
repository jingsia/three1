--����Ľ�������
function Task_Accept_00000054()
	local player = GetPlayer();
	if player:GetLev() < 35 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(54) or task:HasCompletedTask(54) or task:HasSubmitedTask(54) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000054()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 35 then
		return false;
	end
	if task:HasAcceptedTask(54) or task:HasCompletedTask(54) or task:HasSubmitedTask(54) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(127) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000054()
	if GetPlayer():GetTaskMgr():HasCompletedTask(54) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000054(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(54) == npcId and Task_Accept_00000054 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 54
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2120;
	elseif task:GetTaskSubmitNpc(54) == npcId then
		if Task_Submit_00000054() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 54
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2121;
		elseif task:HasAcceptedTask(54) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 54
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2122;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000054_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2123;
	action.m_ActionMsg = task_msg_2124;
	return action;
end

function Task_00000054_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2125;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000054_step_table = {
		[1] = Task_00000054_step_01,
		[10] = Task_00000054_step_10,
		};

function Task_00000054_step(step)
	if Task_00000054_step_table[step] ~= nil then
		return Task_00000054_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000054_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000054() then
		return false;
	end
	if not task:AcceptTask(54) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000054_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(54) then
		return false;
	end


	player:AddExp(15000);
	return true;
end

--��������
function Task_00000054_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(54);
end
