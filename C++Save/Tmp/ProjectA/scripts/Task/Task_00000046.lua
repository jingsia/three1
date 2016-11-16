--����Ľ�������
function Task_Accept_00000046()
	local player = GetPlayer();
	if player:GetLev() < 27 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(46) or task:HasCompletedTask(46) or task:HasSubmitedTask(46) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000046()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 27 then
		return false;
	end
	if task:HasAcceptedTask(46) or task:HasCompletedTask(46) or task:HasSubmitedTask(46) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(45) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000046()
	if GetPlayer():GetTaskMgr():HasCompletedTask(46) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000046(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(46) == npcId and Task_Accept_00000046 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 46
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_326;
	elseif task:GetTaskSubmitNpc(46) == npcId then
		if Task_Submit_00000046() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 46
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_327;
		elseif task:HasAcceptedTask(46) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 46
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_328;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000046_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_329;
	action.m_ActionMsg = task_msg_330;
	return action;
end

function Task_00000046_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_331;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000046_step_table = {
		[1] = Task_00000046_step_01,
		[10] = Task_00000046_step_10,
		};

function Task_00000046_step(step)
	if Task_00000046_step_table[step] ~= nil then
		return Task_00000046_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000046_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000046() then
		return false;
	end
	if not task:AcceptTask(46) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000046_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(46) then
		return false;
	end


	player:AddExp(9500);
	player:getTael(500);
	return true;
end

--��������
function Task_00000046_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(46);
end
