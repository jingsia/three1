--����Ľ�������
function Task_Accept_00000009()
	local player = GetPlayer();
	if player:GetLev() < 7 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(9) or task:HasCompletedTask(9) or task:HasSubmitedTask(9) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000009()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 7 then
		return false;
	end
	if task:HasAcceptedTask(9) or task:HasCompletedTask(9) or task:HasSubmitedTask(9) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(8) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000009()
	if GetPlayer():GetTaskMgr():HasCompletedTask(9) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000009(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(9) == npcId and Task_Accept_00000009 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 9
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_96;
	elseif task:GetTaskSubmitNpc(9) == npcId then
		if Task_Submit_00000009() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 9
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_97;
		elseif task:HasAcceptedTask(9) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 9
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_98;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000009_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_99;
	action.m_ActionMsg = task_msg_100;
	return action;
end

function Task_00000009_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_101;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000009_step_table = {
		[1] = Task_00000009_step_01,
		[10] = Task_00000009_step_10,
		};

function Task_00000009_step(step)
	if Task_00000009_step_table[step] ~= nil then
		return Task_00000009_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000009_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000009() then
		return false;
	end
	if not task:AcceptTask(9) then
		return false;
	end
	task:AddTaskStep(9);
	return true;
end



--�ύ����
function Task_00000009_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	local fixReqGrid = package:GetItemUsedGrids(2006,1,1);
	if fixReqGrid > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1013, 0);
		return false;
	end
	if not player:GetTaskMgr():SubmitTask(9) then
		return false;
	end

	if IsEquipTypeId(2006) then
		for k = 1, 1 do
			package:AddEquip(2006, 1);
		end
	else 
		package:AddItem(2006,1,1);
	end

	player:AddExp(1100);
	player:getTael(200);
	return true;
end

--��������
function Task_00000009_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(9);
end
