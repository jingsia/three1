function Monster_00005016(num)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local package = player:GetPackage();
	if task:HasAcceptedTask(519) then
		task:AddTaskStep2(519,1,num);
	end
	if task:HasAcceptedTask(569) then
		task:AddTaskStep2(569,1,num);
	end
	if task:HasAcceptedTask(612) then
		task:AddTaskStep2(612,1,num);
	end
	if task:HasAcceptedTask(632) then
		task:AddTaskStep2(632,1,num);
	end
	if task:HasAcceptedTask(544) then
		task:AddTaskStep2(544,1,num);
	end
	if task:HasAcceptedTask(589) then
		task:AddTaskStep2(589,1,num);
	end
	if task:HasAcceptedTask(56) then
		task:AddTaskStep2(56,1,num);
	end
end