--����Ľ�������
function Task_Accept_00000203()
	local player = GetPlayer();
	if player:GetLev() < 25 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(203) or task:HasCompletedTask(203) or task:HasSubmitedTask(203) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000203()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 25 then
		return false;
	end
	if task:HasAcceptedTask(203) or task:HasCompletedTask(203) or task:HasSubmitedTask(203) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000203()
	if GetPlayer():GetTaskMgr():HasCompletedTask(203) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000203(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(203) == npcId and Task_Accept_00000203 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 203
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_2201;
	elseif task:GetTaskSubmitNpc(203) == npcId then
		if Task_Submit_00000203() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 203
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_2202;
		elseif task:HasAcceptedTask(203) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 203
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_2203;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000203_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_2204;
	action.m_ActionMsg = task_msg_2205;
	return action;
end

function Task_00000203_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2206;
	action.m_ActionMsg = task_msg_2207;
	return action;
end

function Task_00000203_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_2208;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000203_step_table = {
		[1] = Task_00000203_step_01,
		[2] = Task_00000203_step_02,
		[10] = Task_00000203_step_10,
		};

function Task_00000203_step(step)
	if Task_00000203_step_table[step] ~= nil then
		return Task_00000203_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000203_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000203() then
		return false;
	end
	if not task:AcceptTask(203) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000203_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(203) then
		return false;
	end


	player:AddExp(5000);
	return true;
end

--��������
function Task_00000203_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(203);
end
