--����Ľ�������
function Task_Accept_00000606()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(606) or task:HasCompletedTask(606) or task:HasSubmitedTask(606) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000606()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(606) or task:HasCompletedTask(606) or task:HasSubmitedTask(606) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000606()
	if GetPlayer():GetTaskMgr():HasCompletedTask(606) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000606(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(606) == npcId and Task_Accept_00000606 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 606
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_888;
	elseif task:GetTaskSubmitNpc(606) == npcId then
		if Task_Submit_00000606() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 606
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_889;
		elseif task:HasAcceptedTask(606) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 606
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_890;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000606_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_891..GetPlayerName(GetPlayer())..task_msg_892;
	action.m_ActionMsg = task_msg_893;
	return action;
end

function Task_00000606_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_894;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000606_step_table = {
		[1] = Task_00000606_step_01,
		[10] = Task_00000606_step_10,
		};

function Task_00000606_step(step)
	if Task_00000606_step_table[step] ~= nil then
		return Task_00000606_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000606_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000606() then
		return false;
	end
	if not task:AcceptTask(606) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000606_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(606) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000606_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(606);
end
