--任务的接受条件
function Task_Accept_00000525()
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(525) or task:HasCompletedTask(525) or task:HasSubmitedTask(525) then
		return false;
	end
	return true;
end




-----可接任务条件
function Task_Can_Accept_00000525()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if GetPlayerData(6) ~= 0 then
		return false;
	end
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(525) or task:HasCompletedTask(525) or task:HasSubmitedTask(525) then
		return false;
	end
	return true;
end


--任务完成条件
function Task_Submit_00000525()
	if GetPlayer():GetTaskMgr():HasCompletedTask(525) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC交互的任务脚本
---------------------------------------
function Task_00000525(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(525) == npcId and Task_Accept_00000525 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 525
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1046;
	elseif task:GetTaskSubmitNpc(525) == npcId then
		if Task_Submit_00000525() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 525
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1047;
		elseif task:HasAcceptedTask(525) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 525
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1048;
		end
	end
	return action;
end

-------------------------------------------------
--------任务交互步骤
-------------------------------------------------
function Task_00000525_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1049..GetPlayerName(GetPlayer())..task_msg_1050;
	action.m_ActionMsg = task_msg_1051;
	return action;
end

function Task_00000525_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1052;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000525_step_table = {
		[1] = Task_00000525_step_01,
		[10] = Task_00000525_step_10,
		};

function Task_00000525_step(step)
	if Task_00000525_step_table[step] ~= nil then
		return Task_00000525_step_table[step]();
	end
	return ActionTable:Instance();
end

--接受任务
function Task_00000525_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000525() then
		return false;
	end
	if not task:AcceptTask(525) then
		return false;
	end
	return true;
end



--提交任务
function Task_00000525_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(525) then
		return false;
	end


	return true;
end

--放弃任务
function Task_00000525_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(525);
end
