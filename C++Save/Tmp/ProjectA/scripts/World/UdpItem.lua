
local items =
{
    9,
    15,
    16,
    27,
    28,
    33,
    47,
    49,
    50,
    56,
    57,
    72,
    78,
    79,
    80,
    81,
    134,
    440,
    465,
    466,
    493,
    494,
    495,
    496,
    497,
    500,
    501,
    503,
    505,
    506,
    508,
    511,
    512,
    513,
    514,
    515,
    516,
    517,
    547,
    548,
    1526,
    1527,
    1700,
    1701,
    1704,
    1705,
    5003,
    5005,
    5013,
    5015,
    5023,
    5025,
    5033,
    5035,
    5043,
    5045,
    5053,
    5055,
    5063,
    5065,
    5073,
    5075,
    5083,
    5085,
    5093,
    5095,
    5103,
    5105,
    5113,
    5115,
    5123,
    5125,
    5133,
    5135,
    5143,
    5145,
    8000,
    9076,
    9085,
    9086,
    9087,
    9088,
}
--[[
function loadUdpItem()
    clearUdpItem()
    for n=1,#items do
        addUdpItem(items[n])
    end
end

loadUdpItem()
--]]
