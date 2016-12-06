--����Ľ�������
function Task_Accept_00000012()
	local player = GetPlayer();
	if player:GetLev() < 9 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(12) or task:HasCompletedTask(12) or task:HasSubmitedTask(12) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000012()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 9 then
		return false;
	end
	if task:HasAcceptedTask(12) or task:HasCompletedTask(12) or task:HasSubmitedTask(12) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(11) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000012()
	if GetPlayer():GetTaskMgr():HasCompletedTask(12) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000012(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(12) == npcId and Task_Accept_00000012 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 12
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_122;
	elseif task:GetTaskSubmitNpc(12) == npcId then
		if Task_Submit_00000012() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 12
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_123;
		elseif task:HasAcceptedTask(12) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 12
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_124;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000012_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_125;
	action.m_ActionMsg = task_msg_126;
	return action;
end

function Task_00000012_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_127;
	action.m_ActionMsg = task_msg_128;
	return action;
end

function Task_00000012_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_129..GetPlayerName(GetPlayer())..task_msg_130;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000012_step_table = {
		[1] = Task_00000012_step_01,
		[2] = Task_00000012_step_02,
		[10] = Task_00000012_step_10,
		};

function Task_00000012_step(step)
	if Task_00000012_step_table[step] ~= nil then
		return Task_00000012_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000012_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000012() then
		return false;
	end
	if not task:AcceptTask(12) then
		return false;
	end
	local package = player:GetPackage();
	local itemNum = package:GetItemNum(801,1);
	if itemNum ~= 0 then
		if itemNum > 1 then
			itemNum = 1;
			package:SetItem(801, itemNum, 1);
		end
		task:AddTaskStep2(12, 1, itemNum);
	end
	return true;
end



--�ύ����
function Task_00000012_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();
	if package:GetItemNum(801,1) < 1 then
		return false;
	end

	if not player:GetTaskMgr():SubmitTask(12) then
		return false;
	end

	package:DelItemAll(801,1);

	player:AddExp(1400);
	player:getTael(500);
	player:AddPExp(1500);
	return true;
end

--��������
function Task_00000012_abandon()
	local package = GetPlayer():GetPackage();
	local itemNum = 0;
	package:DelItemAll(801,1);
	return GetPlayer():GetTaskMgr():AbandonTask(12);
end
