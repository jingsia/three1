--ս��ѭ������
function DayTaskAward_00001006(count, color)   --count:������ɵĴ��� color:��ǰ������ɫ��Ϊ0���ʾ��ˢ��������ɫ����
	local player = GetPlayer();	
	local playerLev = player:GetLev();
	if playerLev >= 40 and playerLev <= 59 then
		player:getAchievement(5);
	else
		if playerLev >= 60 and playerLev <= 100 then
			player:getAchievement(10);
		end
	end
	
	return true;
end
