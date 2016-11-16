--����Ľ�������
function Task_Accept_00000017()
	local player = GetPlayer();
	if player:GetLev() < 11 then
		return false;
	end
	local task =  player:GetTaskMgr();
	if task:HasAcceptedTask(17) or task:HasCompletedTask(17) or task:HasSubmitedTask(17) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	return true;
end




-----�ɽ���������
function Task_Can_Accept_00000017()
	local player = GetPlayer();
	local task =  player:GetTaskMgr();
	if player:GetLev() < 11 then
		return false;
	end
	if task:HasAcceptedTask(17) or task:HasCompletedTask(17) or task:HasSubmitedTask(17) then
		return false;
	end
	local state = GetPlayerData(6);
	if state == 0 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	if state == 1 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	if state == 2 then
		if not task:HasSubmitedTask(16) then
			return false;
		end
	end
	return true;
end


--�����������
function Task_Submit_00000017()
	if GetPlayer():GetTaskMgr():HasCompletedTask(17) then
		return true;
	end
	return false;
end


---------------------------------------
------NPC����������ű�
---------------------------------------
function Task_00000017(npcId)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local action = ActionTable:Instance();

	if task:GetTaskAcceptNpc(17) == npcId and Task_Accept_00000017 () then
		action.m_ActionType = 0x0001;
		action.m_ActionID = 17
		action.m_ActionToken = 1;
		action.m_ActionStep = 01;
		action.m_ActionMsg = task_msg_7;
	elseif task:GetTaskSubmitNpc(17) == npcId then
		if Task_Submit_00000017() then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 17
			action.m_ActionToken = 2;
			action.m_ActionStep = 10;
			action.m_ActionMsg = task_msg_8;
		elseif task:HasAcceptedTask(17) then
			action.m_ActionType = 0x0001;
			action.m_ActionID = 17
			action.m_ActionToken = 0;
			action.m_ActionStep = 0;
			action.m_ActionMsg = task_msg_9;
		end
	end
	return action;
end

-------------------------------------------------
--------���񽻻�����
-------------------------------------------------
function Task_00000017_step_01()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = task_msg_10;
	action.m_ActionMsg = task_msg_11;
	return action;
end

function Task_00000017_step_10()
	local action = ActionTable:Instance();
	action.m_ActionType = 0x0001;
	action.m_ActionToken = 3;
	action.m_ActionStep = 0;
	action.m_NpcMsg = GetPlayerName(GetPlayer())..task_msg_12;
	action.m_ActionMsg = "";
	return action;
end

local Task_00000017_step_table = {
		[1] = Task_00000017_step_01,
		[10] = Task_00000017_step_10,
		};

function Task_00000017_step(step)
	if Task_00000017_step_table[step] ~= nil then
		return Task_00000017_step_table[step]();
	end
	return ActionTable:Instance();
end

--��������
function Task_00000017_accept()
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	if not Task_Accept_00000017() then
		return false;
	end
	local package = player:GetPackage();
	local reqGrids = 0;
	reqGrids = reqGrids + package:GetItemUsedGrids(802, 1, 1);
	if reqGrids > player:GetFreePackageSize() then
		player:sendMsgCode(2, 1012, 0);
		return false;
	end
	if not task:AcceptTask(17) then
		return false;
	end
	package:AddItem(802, 1, 1);
	task:AddTaskStep(17);
	return true;
end



--�ύ����
function Task_00000017_submit(itemId, itemNum)
	local player = GetPlayer();

	local package = player:GetPackage();
	if package:GetItemNum(802,1) < 1 then
		return false;
	end

	if not player:GetTaskMgr():SubmitTask(17) then
		return false;
	end

	package:DelItem(802,1,1);

	player:AddExp(2000);
	player:getCoupon(20);
	player:getTael(300);
	return true;
end

--��������
function Task_00000017_abandon()
	local package = GetPlayer():GetPackage();
	package:DelItem(802, 1, 1);
	local itemNum = 0;
	return GetPlayer():GetTaskMgr():AbandonTask(17);
end
