function Monster_00005017(num)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local package = player:GetPackage();
	if task:HasAcceptedTask(518) then
		task:AddTaskStep2(518,1,num);
	end
	if task:HasAcceptedTask(568) then
		task:AddTaskStep2(568,1,num);
	end
	if task:HasAcceptedTask(613) then
		task:AddTaskStep2(613,1,num);
	end
	if task:HasAcceptedTask(633) then
		task:AddTaskStep2(633,1,num);
	end
	if task:HasAcceptedTask(543) then
		task:AddTaskStep2(543,1,num);
	end
	if task:HasAcceptedTask(588) then
		task:AddTaskStep2(588,1,num);
	end
	if task:HasAcceptedTask(57) then
		task:AddTaskStep2(57,1,num);
	end
end