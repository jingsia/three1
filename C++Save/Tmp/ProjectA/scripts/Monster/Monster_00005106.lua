function Monster_00005106(num)
	local player = GetPlayer();
	local task = player:GetTaskMgr();
	local package = player:GetPackage();
	if task:HasAcceptedTask(116) then
		task:AddTaskStep2(116,1,num);
	end
end