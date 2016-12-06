--����Ľ�������
function Task_Accept_00000651()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(651) or task:HasCompletedTask(651) or task:HasSubmitedTask(651) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000651()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(651) or task:HasCompletedTask(651) or task:HasSubmitedTask(651) or not player:isClanTask(651) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000651()
	if GetPlayer():GetTaskMgr():HasCompletedTask(651) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000651(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(651) == npcId and Task_Accept_00000651 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 651
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1847;
	elseif task:GetTaskSubmitNpc(651) == npcId then
		if Task_Submit_00000651() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 651
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1848;
		elseif task:HasAcceptedTask(651) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 651
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1849;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000651_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1850;
	action.m_ActionMsg = task_msg_1851;
	return action;
end

function Task_00000651_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1852;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000651_step_table = {
		[1] = Task_00000651_step_01,
		[10] = Task_00000651_step_10,
		};

function Task_00000651_step(step)
	if Task_00000651_step_table[step] ~= nil then
		return Task_00000651_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000651_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000651() then
		return false;
	end
	if not task:AcceptTask(651) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000651_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(651) then
		return false;
	end


	player:AddExp(5000);
	player:AddClanBuilding(200);
	player:AddClanContrib(300);
	return true;
end

--��������
function Task_00000651_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(651);
end
