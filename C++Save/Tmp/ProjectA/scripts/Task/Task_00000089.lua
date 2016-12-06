--����Ľ�������
function Task_Accept_00000089()
	local player = GetPlayer();
	if player:GetLev() < 45 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(89) or task:HasCompletedTask(89) or task:HasSubmitedTask(89) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000089()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 45 then
		return false;
	end
	if task:HasAcceptedTask(89) or task:HasCompletedTask(89) or task:HasSubmitedTask(89) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(88) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000089()
	if GetPlayer():GetTaskMgr():HasCompletedTask(89) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000089(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(89) == npcId and Task_Accept_00000089 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 89
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_381;
	elseif task:GetTaskSubmitNpc(89) == npcId then
		if Task_Submit_00000089() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 89
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_382;
		elseif task:HasAcceptedTask(89) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 89
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_383;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000089_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 2;
	action.m_NpcMsg = task_msg_384;
	action.m_ActionMsg = task_msg_385;
	return action;
end

function Task_00000089_step_02()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_386..GetPlayerName(GetPlayer())..task_msg_387;
	action.m_ActionMsg = task_msg_388;
	return action;
end

function Task_00000089_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_389..GetPlayerName(GetPlayer())..task_msg_390;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000089_step_table = {
		[1] = Task_00000089_step_01,
		[2] = Task_00000089_step_02,
		[10] = Task_00000089_step_10,
		};

function Task_00000089_step(step)
	if Task_00000089_step_table[step] ~= nil then
		return Task_00000089_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000089_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000089() then
		return false;
	end
	if not task:AcceptTask(89) then
		return false;
	end
	return true;
end



--�ύ����
function Task_00000089_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();

	if not player:GetTaskMgr():SubmitTask(89) then
		return false;
	end


	player:AddExp(25000);
	return true;
end

--��������
function Task_00000089_abandon()
	local package = GetPlayer():GetPackage();
	return GetPlayer():GetTaskMgr():AbandonTask(89);
end
