--����Ľ�������
function Task_Accept_00000656()
	local player = GetPlayer();
	if player:GetLev() < 30 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(656) or task:HasCompletedTask(656) or task:HasSubmitedTask(656) then
		return false;
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000656()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 30 then
		return false;
	end
	if task:HasAcceptedTask(656) or task:HasCompletedTask(656) or task:HasSubmitedTask(656) or not player:isClanTask(656) then
		return false;
	end
	return true;
end


--�����������
function Task_Submit_00000656()
	if GetPlayer():GetTaskMgr():HasCompletedTask(656) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000656(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(656) == npcId and Task_Accept_00000656 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 656
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_1881;
	elseif task:GetTaskSubmitNpc(656) == npcId then
		if Task_Submit_00000656() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 656
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_1882;
		elseif task:HasAcceptedTask(656) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 656
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_1883;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000656_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_1884..GetPlayerName(GetPlayer())..task_msg_1885;
	action.m_ActionMsg = task_msg_1886;
	return action;
end

function Task_00000656_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_1887;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000656_step_table = {
		[1] = Task_00000656_step_01,
		[10] = Task_00000656_step_10,
		};

function Task_00000656_step(step)
	if Task_00000656_step_table[step] ~= nil then
		return Task_00000656_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000656_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000656() then
		return false;
	end
	if not task:AcceptTask(656) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000656_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(656) then
		return false;
	end


	player:AddExp(5000);
	player:AddClanBuilding(200);
	player:AddClanContrib(300);
	return true;
end

--��������
function Task_00000656_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(656);
end
