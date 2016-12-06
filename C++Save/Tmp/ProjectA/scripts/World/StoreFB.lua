
function resetDiscount()
    local store = GetStore()

    local discount_num = {
        1,2,4,
    }

    local discounts = {
        3,5,8,
    }

    local discount_items = {
        465,466,516,547,57,56,500,15,501,503,505,506,508,511,512,513,514,515,517,
    };

    for d = 1, #discounts do
        local nr = math.random(1, #discount_num)
        local num = discount_num[nr]
        for i = 1, num do
            local n = math.random(1, #discount_items)
            store:add(1, discount_items[n], discounts[d])
            table.remove(discount_items, n);
        end
    end
    store:storeDiscount()
end

function loadStore()
local store = GetStore()
store:clear()

if store:needResetDiscount() then
    resetDiscount()
end

store:discountLimit()

addSpecialDiscount()

store:add(2,549,80)
store:add(2,9083,50)

if is6_29() then
store:add(2,9076,100)
end

if isNewServer() then
store:add(2,9067,50)
end

if is6_22() then
store:add(2,1700,500)
store:add(2,1701,500)
store:add(2,1527,25)
end

if is6_22() then
store:add(2,493,10)
store:add(2,494,20)
store:add(2,495,50)
store:add(5,492,1000)
end

store:add(2,33,10)
store:add(2,8000,15)
store:add(2,72,720)
store:add(2,78,120)
store:add(2,79,200)
store:add(2,80,450)
store:add(2,81,110)
store:add(2,548,1)
store:add(2,465,20)
store:add(2,466,10)
store:add(2,440,50)
store:add(2,516,30)
store:add(2,547,15)
store:add(2,47,100)
store:add(2,49,80)
store:add(2,50,90)
store:add(2,57,10)
store:add(2,56,10)
store:add(2,500,10)
store:add(2,15,10)
store:add(2,16,10)
store:add(2,501,15)
store:add(2,503,20)
store:add(2,505,15)
store:add(2,506,10)
store:add(2,508,10)
store:add(2,511,5)
store:add(2,512,10)
store:add(2,513,15)
store:add(2,514,10)
store:add(2,515,80)
store:add(2,517,10)
store:add(3,5005,100)
store:add(3,5015,100)
store:add(3,5025,100)
store:add(3,5035,100)
store:add(3,5045,100)
store:add(3,5055,100)
store:add(3,5065,200)
store:add(3,5075,150)
store:add(3,5085,200)
store:add(3,5095,200)
store:add(3,5105,200)
store:add(3,5115,200)
store:add(3,5125,200)
store:add(3,5135,150)
store:add(3,5145,200)
store:add(3,5003,10)
store:add(3,5013,10)
store:add(3,5023,10)
store:add(3,5033,10)
store:add(3,5043,10)
store:add(3,5053,10)
store:add(3,5063,20)
store:add(3,5073,15)
store:add(3,5083,20)
store:add(3,5093,20)
store:add(3,5103,20)
store:add(3,5113,20)
store:add(3,5123,20)
store:add(3,5133,15)
store:add(3,5143,20)
store:add(4,57,10)
store:add(4,511,5)
store:add(4,56,10)
store:add(4,500,10)
store:add(4,503,20)
store:add(4,505,15)
store:add(4,5003,10)
store:add(4,5013,10)
store:add(4,5023,10)
store:add(4,5033,10)
store:add(4,5043,10)
store:add(4,5053,10)
store:add(4,5063,20)
store:add(4,5073,15)
store:add(4,5083,20)
store:add(4,5093,20)
store:add(4,5103,20)
store:add(4,5113,20)
store:add(4,5123,20)
store:add(4,5133,15)
store:add(4,5143,20)
store:add(5,489,2000)
store:add(5,490,2000)
store:add(5,491,2000)
store:add(5,502,1000)
--store:add(5,504,1000)
store:add(5,510,800)
store:add(5,55,400)
store:add(5,5001,300)
store:add(5,5011,300)
store:add(5,5021,300)
store:add(5,5031,300)
store:add(5,5041,300)
store:add(5,5051,300)
store:add(5,5061,500)
store:add(5,5071,400)
store:add(5,5081,500)
store:add(5,5091,500)
store:add(5,5101,500)
store:add(5,5111,500)
store:add(5,5121,500)
store:add(5,5131,400)
store:add(5,5141,500)
store:add(6,74,12000)
store:add(6,76,2000)
store:add(6,15,500)
store:add(6,503,800)
store:add(6,514,1000)
store:add(6,48,600)
store:add(6,49,1000)
store:add(6,50,1000)
store:add(6,51,600)
store:add(6,506,1000)
store:add(6,508,1000)
store:add(6,507,2000)
store:add(6,509,2000)
store:add(7,73,18000)
store:add(7,75,4500)
store:add(7,77,4500)
store:add(7,1526,1000)
store:add(7,2545,3000)
store:add(7,2546,3000)
store:add(7,2548,3000)
store:add(7,2549,3000)
store:add(7,2553,3000)
store:add(7,2554,3000)
store:add(7,2556,3000)
store:add(7,2557,3000)
store:add(7,2561,3000)
store:add(7,2562,3000)
store:add(7,2564,3000)
store:add(7,2565,3000)
store:add(7,2569,4000)
store:add(7,2570,4000)
store:add(7,2572,4000)
store:add(7,2573,4000)
store:add(7,2577,4000)
store:add(7,2578,4000)
store:add(7,2580,4000)
store:add(7,2581,4000)
store:add(7,2585,4000)
store:add(7,2586,4000)
store:add(7,2588,4000)
store:add(7,2589,4000)
store:add(7,2593,5000)
store:add(7,2594,5000)
store:add(7,2596,5000)
store:add(7,2597,5000)
store:add(7,2601,5000)
store:add(7,2602,5000)
store:add(7,2604,5000)
store:add(7,2605,5000)
store:add(7,2609,5000)
store:add(7,2610,5000)
store:add(7,2612,5000)
store:add(7,2613,5000)
store:add(7,2617,6000)
store:add(7,2618,6000)
store:add(7,2620,6000)
store:add(7,2621,6000)
store:add(7,2625,6000)
store:add(7,2626,6000)
store:add(7,2628,6000)
store:add(7,2629,6000)
store:add(7,2633,6000)
store:add(7,2634,6000)
store:add(7,2636,6000)
store:add(7,2637,6000)
store:addExchange(8,519,526,2)
store:addExchange(8,520,527,2)
store:addExchange(8,521,528,2)
store:addExchange(8,522,529,2)
store:addExchange(8,523,530,2)
store:addExchange(8,524,531,2)
store:addExchange(8,527,526,10)
store:addExchange(8,528,527,10)
store:addExchange(8,529,528,10)
store:addExchange(8,530,529,10)
store:addExchange(8,531,530,10)
store:update()
end