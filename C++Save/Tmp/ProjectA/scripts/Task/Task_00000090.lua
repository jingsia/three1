--����Ľ�������
function Task_Accept_00000090()
	local player = GetPlayer();
	if player:GetLev() < 46 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(90) or task:HasCompletedTask(90) or task:HasSubmitedTask(90) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000090()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 46 then
		return false;
	end
	if task:HasAcceptedTask(90) or task:HasCompletedTask(90) or task:HasSubmitedTask(90) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000090()
	if GetPlayer():GetTaskMgr():HasCompletedTask(90) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000090(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(90) == npcId and Task_Accept_00000090 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 90
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_391;
	elseif task:GetTaskSubmitNpc(90) == npcId then
		if Task_Submit_00000090() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 90
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_392;
		elseif task:HasAcceptedTask(90) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 90
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_393;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000090_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_394;
	action.m_ActionMsg = task_msg_395;
	return action;
end

function Task_00000090_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_396;
	action.m_ActionMsg = task_msg_397;
	return action;
end

function Task_00000090_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_398;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000090_step_table = {
		[1] = Task_00000090_step_01,
		[2] = Task_00000090_step_02,
		[10] = Task_00000090_step_10,
		};

function Task_00000090_step(step)
	if Task_00000090_step_table[step] ~= nil then
		return Task_00000090_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000090_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000090() then
		return false;
	end
	if not task:AcceptTask(90) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000090_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	local fixReqGrid = package:GetItemUsedGrids(1548,1,1);
	if fixReqGrid > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1013, 0);
		return false;
	end
	if not player:GetTaskMgr():SubmitTask(90) then
		return false;
	end

	if IsEquipTypeId(1548) then
		for k = 1, 1 do
			package:AddEquip(1548, 1);
		end
	else 
		package:AddItem(1548,1,1);
	end

	player:AddExp(20000);
	return true;
end

--��������
function Task_00000090_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(90);
end
