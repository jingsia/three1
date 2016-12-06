local x = 1
local y = 2


for i=1,100 do
	local sum = 0

	for j = 1,y do
		sum = sum + x
		x = x + 1
	end

	y = y + 1
	print(sum)
	print("123")
end

