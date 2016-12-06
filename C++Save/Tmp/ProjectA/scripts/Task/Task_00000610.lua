--����Ľ�������
function Task_Accept_00000610()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(610) or task:HasCompletedTask(610) or task:HasSubmitedTask(610) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000610()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(610) or task:HasCompletedTask(610) or task:HasSubmitedTask(610) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000610()
	if GetPlayer():GetTaskMgr():HasCompletedTask(610) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000610(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(610) == npcId and Task_Accept_00000610 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 610
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_916;
	elseif task:GetTaskSubmitNpc(610) == npcId then
		if Task_Submit_00000610() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 610
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_917;
		elseif task:HasAcceptedTask(610) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 610
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_918;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000610_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_919..GetPlayerName(GetPlayer())..task_msg_920;
	action.m_ActionMsg = task_msg_921;
	return action;
end

function Task_00000610_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_922;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000610_step_table = {
		[1] = Task_00000610_step_01,
		[10] = Task_00000610_step_10,
		};

function Task_00000610_step(step)
	if Task_00000610_step_table[step] ~= nil then
		return Task_00000610_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000610_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000610() then
		return false;
	end
	if not task:AcceptTask(610) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000610_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(610) then
		return false;
	end


	player:AddExp(3000);
	return true;
end

--��������
function Task_00000610_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(610);
end
