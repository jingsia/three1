function Monster_00005009(num)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local package = player:GetPackage();
	if task:HasAcceptedTask(35) then
		task:AddTaskStep2(35,1,num);
	end
	if task:HasAcceptedTask(505) then
		task:AddTaskStep2(505,1,num);
	end
	if task:HasAcceptedTask(555) then
		task:AddTaskStep2(555,1,num);
	end
	if task:HasAcceptedTask(605) then
		task:AddTaskStep2(605,1,num);
	end
	if task:HasAcceptedTask(640) then
		task:AddTaskStep2(640,1,num);
	end
	if task:HasAcceptedTask(530) then
		task:AddTaskStep2(530,1,num);
	end
	if task:HasAcceptedTask(655) then
		task:AddTaskStep2(655,1,num);
	end
end