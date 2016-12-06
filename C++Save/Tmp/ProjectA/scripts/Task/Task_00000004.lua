--����Ľ�������
function Task_Accept_00000004()
	local player = GetPlayer();
	if player:GetLev() < 3 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(4) or task:HasCompletedTask(4) or task:HasSubmitedTask(4) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000004()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 3 then
		return false;
	end
	if task:HasAcceptedTask(4) or task:HasCompletedTask(4) or task:HasSubmitedTask(4) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(3) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000004()
	if GetPlayer():GetTaskMgr():HasCompletedTask(4) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000004(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(4) == npcId and Task_Accept_00000004 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 4
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_72;
	elseif task:GetTaskSubmitNpc(4) == npcId then
		if Task_Submit_00000004() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 4
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_73;
		elseif task:HasAcceptedTask(4) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 4
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_74;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000004_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_75;
	action.m_ActionMsg = task_msg_76;
	return action;
end

function Task_00000004_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_77;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000004_step_table = {
		[1] = Task_00000004_step_01,
		[10] = Task_00000004_step_10,
		};

function Task_00000004_step(step)
	if Task_00000004_step_table[step] ~= nil then
		return Task_00000004_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000004_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000004() then
		return false;
	end
	if not task:AcceptTask(4) then
		return false;
	end
	task:AddTaskStep(4);
	return true;
end



--�ύ����
function Task_00000004_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	local fixReqGrid = package:GetItemUsedGrids(2002,1,1);
	if fixReqGrid > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1013, 0);
		return false;
	end
	if not player:GetTaskMgr():SubmitTask(4) then
		return false;
	end

	if IsEquipTypeId(2002) then
		for k = 1, 1 do
			package:AddEquip(2002, 1);
		end
	else 
		package:AddItem(2002,1,1);
	end

	player:AddExp(530);
	player:getTael(150);
	return true;
end

--��������
function Task_00000004_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(4);
end
