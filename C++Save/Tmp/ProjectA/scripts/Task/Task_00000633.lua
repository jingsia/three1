--����Ľ�������
function Task_Accept_00000633()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(633) or task:HasCompletedTask(633) or task:HasSubmitedTask(633) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000633()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(633) or task:HasCompletedTask(633) or task:HasSubmitedTask(633) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000633()
	if GetPlayer():GetTaskMgr():HasCompletedTask(633) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000633(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(633) == npcId and Task_Accept_00000633 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 633
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1201;
	elseif task:GetTaskSubmitNpc(633) == npcId then
		if Task_Submit_00000633() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 633
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1202;
		elseif task:HasAcceptedTask(633) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 633
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1203;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000633_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1204;
	action.m_ActionMsg = task_msg_1205;
	return action;
end

function Task_00000633_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1206;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000633_step_table = {
		[1] = Task_00000633_step_01,
		[10] = Task_00000633_step_10,
		};

function Task_00000633_step(step)
	if Task_00000633_step_table[step] ~= nil then
		return Task_00000633_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000633_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000633() then
		return false;
	end
	if not task:AcceptTask(633) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000633_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(633) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000633_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(633);
end
