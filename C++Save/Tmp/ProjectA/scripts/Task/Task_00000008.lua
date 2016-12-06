--任务的接受条件
function Task_Accept_00000008()
	local player = GetPlayer();
	if player:GetLev() < 6 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(8) or task:HasCompletedTask(8) or task:HasSubmitedTask(8) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	return true;
end




-----可接任务条件
function Task_Can_Accept_00000008()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 6 then
		return false;
	end
	if task:HasAcceptedTask(8) or task:HasCompletedTask(8) or task:HasSubmitedTask(8) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(7) then
			return false;
		end
	end
	return true;
end


--任务完成条件
function Task_Submit_00000008()
	if GetPlayer():GetTaskMgr():HasCompletedTask(8) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC交互的任务脚本
---------------------------------------
function Task_00000008(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(8) == npcId and Task_Accept_00000008 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 8
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_90;
	elseif task:GetTaskSubmitNpc(8) == npcId then
		if Task_Submit_00000008() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 8
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_91;
		elseif task:HasAcceptedTask(8) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 8
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_92;
		end
	end
	return action;
end

-------------------------------------------------
--------任务交互步骤
-------------------------------------------------
function Task_00000008_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_93;
	action.m_ActionMsg = task_msg_94;
	return action;
end

function Task_00000008_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_95;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000008_step_table = {
		[1] = Task_00000008_step_01,
		[10] = Task_00000008_step_10,
		};

function Task_00000008_step(step)
	if Task_00000008_step_table[step] ~= nil then
		return Task_00000008_step_table[step]();
	end
	return ActionTable:Instance();
end

--接受任务
function Task_00000008_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000008() then
		return false;
	end
	if not task:AcceptTask(8) then
		return false;
	end
	task:AddTaskStep(8);
	return true;
end



--提交任务
function Task_00000008_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	local fixReqGrid = package:GetItemUsedGrids(2003,1,1);
	if fixReqGrid > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1013, 0);
		return false;
	end
	if not player:GetTaskMgr():SubmitTask(8) then
		return false;
	end

	if IsEquipTypeId(2003) then
		for k = 1, 1 do
			package:AddEquip(2003, 1);
		end
	else 
		package:AddItem(2003,1,1);
	end

	player:AddExp(1100);
	return true;
end

--放弃任务
function Task_00000008_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(8);
end
