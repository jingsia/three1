--����Ľ�������
function Task_Accept_00000065()
	local player = GetPlayer();
	if player:GetLev() < 40 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(65) or task:HasCompletedTask(65) or task:HasSubmitedTask(65) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000065()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 40 then
		return false;
	end
	if task:HasAcceptedTask(65) or task:HasCompletedTask(65) or task:HasSubmitedTask(65) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(64) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000065()
	if GetPlayer():GetTaskMgr():HasCompletedTask(65) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000065(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(65) == npcId and Task_Accept_00000065 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 65
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1927;
	elseif task:GetTaskSubmitNpc(65) == npcId then
		if Task_Submit_00000065() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 65
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1928;
		elseif task:HasAcceptedTask(65) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 65
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1929;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000065_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_1930;
	action.m_ActionMsg = task_msg_1931;
	return action;
end

function Task_00000065_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1932;
	action.m_ActionMsg = task_msg_1933;
	return action;
end

function Task_00000065_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1934;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000065_step_table = {
		[1] = Task_00000065_step_01,
		[2] = Task_00000065_step_02,
		[10] = Task_00000065_step_10,
		};

function Task_00000065_step(step)
	if Task_00000065_step_table[step] ~= nil then
		return Task_00000065_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000065_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000065() then
		return false;
	end
	local package = player:GetPackage();
	local reqGrids = 0;
	reqGrids = reqGrids + package:GetItemUsedGrids(807, 1, 1);
	if reqGrids > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1012, 0);
		return false;
	end
	if not task:AcceptTask(65) then
		return false;
	end
	package:AddItem(807, 1, 1);
	task:AddTaskStep(65);
	return true;
end



--�ύ����
function Task_00000065_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();
	if package:GetItemNum(807,1) < 1 then
		return false;
	end

	if not player:GetTaskMgr():SubmitTask(65) then
		return false;
	end

	package:DelItem(807,1,1);

	player:AddExp(80000);
	return true;
end

--��������
function Task_00000065_abandon()
	local package = GetPlayer():GetPackage();
	package:DelItem(807, 1, 1);
	local itemNum = 0;
	return GetPlayer():GetTaskMgr():AbandonTask(65);
end
