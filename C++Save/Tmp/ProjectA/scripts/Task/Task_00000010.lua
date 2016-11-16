--����Ľ�������
function Task_Accept_00000010()
	local player = GetPlayer();
	if player:GetLev() < 7 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(10) or task:HasCompletedTask(10) or task:HasSubmitedTask(10) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000010()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 7 then
		return false;
	end
	if task:HasAcceptedTask(10) or task:HasCompletedTask(10) or task:HasSubmitedTask(10) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(9) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000010()
	if GetPlayer():GetTaskMgr():HasCompletedTask(10) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000010(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(10) == npcId and Task_Accept_00000010 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 10
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_102;
	elseif task:GetTaskSubmitNpc(10) == npcId then
		if Task_Submit_00000010() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 10
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_103;
		elseif task:HasAcceptedTask(10) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 10
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_104;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000010_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_105;
	action.m_ActionMsg = task_msg_106;
	return action;
end

function Task_00000010_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_107;
	action.m_ActionMsg = task_msg_108;
	return action;
end

function Task_00000010_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_109;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000010_step_table = {
		[1] = Task_00000010_step_01,
		[2] = Task_00000010_step_02,
		[10] = Task_00000010_step_10,
		};

function Task_00000010_step(step)
	if Task_00000010_step_table[step] ~= nil then
		return Task_00000010_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000010_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000010() then
		return false;
	end
	if not task:AcceptTask(10) then
		return false;
	end
	task:AddTaskStep(10);
	return true;
end



--�ύ����
function Task_00000010_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	local fixReqGrid = package:GetItemUsedGrids(2004,1,1);
	if fixReqGrid > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1013, 0);
		return false;
	end
	if not player:GetTaskMgr():SubmitTask(10) then
		return false;
	end

	if IsEquipTypeId(2004) then
		for k = 1, 1 do
			package:AddEquip(2004, 1);
		end
	else 
		package:AddItem(2004,1,1);
	end

	player:AddExp(2500);
	player:getTael(500);
	return true;
end

--��������
function Task_00000010_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(10);
end
