function Monster_00005010(num)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local package = player:GetPackage();
	if task:HasAcceptedTask(43) then
		task:AddTaskStep2(43,1,num);
	end
	if task:HasAcceptedTask(509) then
		task:AddTaskStep2(509,1,num);
	end
	if task:HasAcceptedTask(559) then
		task:AddTaskStep2(559,1,num);
	end
	if task:HasAcceptedTask(609) then
		task:AddTaskStep2(609,1,num);
	end
	if task:HasAcceptedTask(629) then
		task:AddTaskStep2(629,1,num);
	end
	if task:HasAcceptedTask(534) then
		task:AddTaskStep2(534,1,num);
	end
	if task:HasAcceptedTask(579) then
		task:AddTaskStep2(579,1,num);
	end
end