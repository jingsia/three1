--����Ľ�������
function Task_Accept_00000653()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(653) or task:HasCompletedTask(653) or task:HasSubmitedTask(653) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000653()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(653) or task:HasCompletedTask(653) or task:HasSubmitedTask(653) or not player:isClanTask(653) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000653()
	if GetPlayer():GetTaskMgr():HasCompletedTask(653) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000653(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(653) == npcId and Task_Accept_00000653 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 653
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1860;
	elseif task:GetTaskSubmitNpc(653) == npcId then
		if Task_Submit_00000653() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 653
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1861;
		elseif task:HasAcceptedTask(653) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 653
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1862;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000653_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1863..GetPlayerName(GetPlayer())..task_msg_1864;
	action.m_ActionMsg = task_msg_1865;
	return action;
end

function Task_00000653_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1866;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000653_step_table = {
		[1] = Task_00000653_step_01,
		[10] = Task_00000653_step_10,
		};

function Task_00000653_step(step)
	if Task_00000653_step_table[step] ~= nil then
		return Task_00000653_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000653_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000653() then
		return false;
	end
	if not task:AcceptTask(653) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000653_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(653) then
		return false;
	end


	player:AddExp(5000);
	player:AddClanBuilding(200);
	player:AddClanContrib(300);
	return true;
end

--��������
function Task_00000653_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(653);
end
