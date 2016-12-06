require ("./scripts/taskmsg")
------------------------------------------------------------------------
--TypeId, Name, Class, SubType, AcceptNpc, SubmitNpc, ReqTime, AcceptMaxNum, ReqStep, PreTask, ReqLev, Country(State)
------------------------------------------------------------------------
Task_Conf_Table = {
	{16,"task_msg_2209",1,1,4105,4111,0,1,"1","15",11,2},
	{17,"task_msg_2210",1,1,4111,4112,0,1,"1","16",11,2},
	{18,"task_msg_2211",1,1,4112,4105,0,1,"1","17",11,2},
	{123,"task_msg_2212",1,1,4114,4114,0,1,"1","",1,2},
	{1,"task_msg_2213",1,2,4114,4104,0,1,"1","123",1,2},
	{126,"task_msg_2214",2,9,4132,4132,0,1,"1","125",30,2},
	{127,"task_msg_2215",1,1,4125,4125,0,1,"1","125",30,2},
	{48,"task_msg_2216",1,1,4138,4139,0,1,"1","47",28,2},
	{2,"task_msg_2217",1,2,4104,4104,0,1,"1","1",2,2},
	{3,"task_msg_2218",1,1,4104,4106,0,1,"1","2",3,2},
	{4,"task_msg_2219",1,1,4106,4107,0,1,"1","3",3,2},
	{6,"task_msg_2220",1,1,4107,4106,0,1,"1","5",5,2},
	{7,"task_msg_2221",1,1,4106,4106,0,1,"1","6",6,2},
	{8,"task_msg_2222",1,1,4106,4113,0,1,"1","7",6,2},
	{9,"task_msg_2223",1,1,4113,4108,0,1,"1","8",7,2},
	{10,"task_msg_2224",1,1,4108,4167,0,1,"1","9",7,2},
	{11,"task_msg_2225",1,1,4109,4110,0,1,"1","10",8,2},
	{12,"task_msg_2226",1,6,4110,4109,0,1,"1","11",9,2},
	{13,"task_msg_2227",1,1,4109,4110,0,1,"1","12",9,2},
	{14,"task_msg_2228",1,9,4110,4109,0,1,"1","13",10,2},
	{15,"task_msg_2229",1,1,4109,4105,0,1,"1","14",10,2},
	{19,"task_msg_2230",1,2,4105,4105,0,1,"1","18",12,2},
	{20,"task_msg_2231",1,1,4105,4105,0,1,"1","19",13,2},
	{21,"task_msg_2232",1,1,4105,4115,0,1,"1","20",13,2},
	{22,"task_msg_2233",1,2,4115,4115,0,1,"1","21",14,2},
	{23,"task_msg_2234",1,1,4115,4116,0,1,"1","22",14,2},
	{25,"task_msg_2235",1,1,4116,4116,0,1,"1","24",15,2},
	{26,"task_msg_2236",1,1,4116,4117,0,1,"1","25",16,2},
	{27,"task_msg_2237",1,2,4118,4118,0,1,"1","26",17,2},
	{28,"task_msg_2238",1,1,4120,4121,0,1,"1","27",18,2},
	{29,"task_msg_2239",1,2,4121,4121,0,1,"1","28",18,2},
	{30,"task_msg_2240",1,1,4121,4126,0,1,"1","29",19,2},
	{31,"task_msg_2241",1,1,4126,4122,0,1,"1","30",19,2},
	{32,"task_msg_2242",1,1,4122,4122,0,1,"1","31",20,2},
	{33,"task_msg_2243",1,1,4122,4123,0,1,"1","32",20,2},
	{34,"task_msg_2244",1,1,4123,4124,0,1,"1","33",20,2},
	{35,"task_msg_2245",1,2,4124,4124,0,1,"1","34",21,2},
	{36,"task_msg_2246",1,1,4124,4125,0,1,"1","35",21,2},
	{38,"task_msg_2247",1,1,4125,4124,0,1,"1","36",22,2},
	{39,"task_msg_2248",1,1,4124,4133,0,1,"1","38",23,2},
	{40,"task_msg_2249",1,1,4133,4127,0,1,"1","39",23,2},
	{41,"task_msg_2250",1,1,4127,4133,0,1,"1","40",24,2},
	{42,"task_msg_2251",1,1,4133,4135,0,1,"1","41",25,2},
	{43,"task_msg_2252",1,2,4135,4135,0,1,"1","42",25,2},
	{44,"task_msg_2253",1,2,4135,4135,0,1,"1","43",25,2},
	{45,"task_msg_2254",1,7,4135,4137,0,1,"1","44",26,2},
	{46,"task_msg_2255",1,2,4137,4137,0,1,"2","45",27,2},
	{47,"task_msg_2256",1,1,4137,4138,0,1,"1","46",28,2},
	{83,"task_msg_2257",2,6,4161,4161,0,1,"1","81",45,2},
	{84,"task_msg_2258",1,1,4162,4163,0,1,"1","82",45,2},
	{85,"task_msg_2259",1,1,4163,4164,0,1,"1","84",45,2},
	{86,"task_msg_2260",1,2,4164,4164,0,1,"1","85",45,2},
	{87,"task_msg_2261",1,2,4164,4164,0,1,"1","86",45,2},
	{88,"task_msg_2262",1,2,4164,4164,0,1,"1","87",45,2},
	{89,"task_msg_2263",1,2,4164,4164,0,1,"1","88",45,2},
	{90,"task_msg_2264",2,2,4165,4165,0,1,"9","",46,2},
	{91,"task_msg_2265",2,2,4165,4165,0,1,"1","90",46,2},
	{92,"task_msg_2266",2,2,4165,4165,0,1,"5","91",46,2},
	{93,"task_msg_2267",2,2,4165,4165,0,1,"1","92",46,2},
	{96,"task_msg_2268",1,2,4168,4168,0,1,"1","95",50,2},
	{97,"task_msg_2269",1,2,4168,4168,0,1,"4","96",50,2},
	{98,"task_msg_2270",1,2,4168,4168,0,1,"1","97",50,2},
	{99,"task_msg_2271",1,1,4168,4169,0,1,"1","98",50,2},
	{100,"task_msg_2272",1,1,4169,4168,0,1,"1","99",50,2},
	{101,"task_msg_2273",2,1,4170,4171,0,1,"1","",52,2},
	{102,"task_msg_2274",2,2,4171,4171,0,1,"1","101",52,2},
	{103,"task_msg_2275",2,1,4171,4170,0,1,"1","102",52,2},
	{104,"task_msg_2276",2,2,4170,4170,0,1,"1","103",52,2},
	{106,"task_msg_2277",1,2,4172,4172,0,1,"5","105",55,2},
	{107,"task_msg_2278",1,2,4172,4172,0,1,"5","106",55,2},
	{108,"task_msg_2279",1,2,4172,4172,0,1,"6","107",55,2},
	{109,"task_msg_2280",1,2,4172,4172,0,1,"5","108",55,2},
	{110,"task_msg_2281",1,2,4172,4172,0,1,"5","109",55,2},
	{111,"task_msg_2282",1,2,4172,4172,0,1,"1","110",55,2},
	{114,"task_msg_2283",1,2,4173,4173,0,1,"2","113",60,2},
	{115,"task_msg_2284",1,2,4173,4173,0,1,"1","114",60,2},
	{116,"task_msg_2285",1,2,4173,4173,0,1,"6","115",60,2},
	{117,"task_msg_2286",1,1,4173,4174,0,1,"1","116",60,2},
	{119,"task_msg_2287",2,2,4174,4174,0,1,"1","118",61,2},
	{121,"task_msg_2288",2,2,4139,4139,0,1,"1","50",32,2},
	{49,"task_msg_2289",2,2,4139,4139,0,1,"1","50",32,2},
	{120,"task_msg_2290",2,2,4139,4139,0,1,"1","50",32,2},
	{500,"task_msg_2291",4,2,4140,4140,0,10,"1","",30,0},
	{501,"task_msg_2292",4,1,4140,4141,0,10,"1","",30,0},
	{502,"task_msg_2293",4,2,4140,4140,0,10,"1","",30,0},
	{503,"task_msg_2294",4,2,4140,4140,0,10,"2","",30,0},
	{504,"task_msg_2295",4,2,4140,4140,0,10,"1","",30,0},
	{505,"task_msg_2296",4,2,4140,4140,0,10,"1","",30,0},
	{506,"task_msg_2297",4,2,4140,4140,0,10,"1","",30,0},
	{507,"task_msg_2298",4,2,4140,4140,0,10,"2","",30,0},
	{508,"task_msg_2299",4,2,4140,4140,0,10,"1","",30,0},
	{509,"task_msg_2300",4,2,4140,4140,0,10,"2","",30,0},
	{510,"task_msg_2301",4,2,4140,4140,0,10,"2","",30,0},
	{511,"task_msg_2302",4,1,4140,4125,0,10,"1","",30,0},
	{512,"task_msg_2303",4,1,4140,4122,0,10,"1","",30,0},
	{513,"task_msg_2304",4,1,4140,4105,0,10,"1","",30,0},
	{514,"task_msg_2305",4,1,4140,4116,0,10,"1","",30,0},
	{515,"task_msg_2306",4,1,4140,4121,0,10,"1","",30,0},
	{516,"task_msg_2307",4,2,4140,4140,0,10,"1","",30,0},
	{517,"task_msg_2308",4,2,4140,4140,0,10,"1","",30,0},
	{518,"task_msg_2309",4,2,4140,4140,0,10,"4","",30,0},
	{519,"task_msg_2310",4,2,4140,4140,0,10,"4","",30,0},
	{520,"task_msg_2311",4,2,4140,4140,0,10,"1","",30,0},
	{550,"task_msg_2312",4,2,4146,4146,0,10,"1","",30,1},
	{551,"task_msg_2313",4,1,4146,4148,0,10,"1","",30,1},
	{552,"task_msg_2314",4,2,4146,4146,0,10,"1","",30,1},
	{553,"task_msg_2315",4,2,4146,4146,0,10,"2","",30,1},
	{554,"task_msg_2316",4,2,4146,4146,0,10,"1","",30,1},
	{555,"task_msg_2317",4,2,4146,4146,0,10,"1","",30,1},
	{556,"task_msg_2318",4,2,4146,4146,0,10,"1","",30,1},
	{557,"task_msg_2319",4,2,4146,4146,0,10,"2","",30,1},
	{558,"task_msg_2320",4,2,4146,4146,0,10,"1","",30,1},
	{559,"task_msg_2321",4,2,4146,4146,0,10,"2","",30,1},
	{560,"task_msg_2322",4,2,4146,4146,0,10,"2","",30,1},
	{561,"task_msg_2323",4,1,4146,4125,0,10,"1","",30,1},
	{562,"task_msg_2324",4,1,4146,4122,0,10,"1","",30,1},
	{563,"task_msg_2325",4,1,4146,4105,0,10,"1","",30,1},
	{564,"task_msg_2326",4,1,4146,4116,0,10,"1","",30,1},
	{565,"task_msg_2327",4,1,4146,4121,0,10,"1","",30,1},
	{566,"task_msg_2328",4,2,4146,4146,0,10,"1","",30,1},
	{567,"task_msg_2329",4,2,4146,4146,0,10,"1","",30,1},
	{568,"task_msg_2330",4,2,4146,4146,0,10,"4","",30,1},
	{569,"task_msg_2331",4,2,4146,4146,0,10,"4","",30,1},
	{570,"task_msg_2332",4,2,4146,4146,0,10,"1","",30,1},
	{602,"task_msg_2333",5,2,4132,4132,0,5,"1","",30,2},
	{603,"task_msg_2334",5,2,4132,4132,0,5,"1","",30,2},
	{604,"task_msg_2335",5,2,4132,4132,0,5,"1","",30,2},
	{605,"task_msg_2336",5,2,4132,4132,0,5,"1","",30,2},
	{606,"task_msg_2337",5,2,4132,4132,0,5,"1","",30,2},
	{607,"task_msg_2338",5,2,4132,4132,0,5,"2","",30,2},
	{608,"task_msg_2339",5,2,4132,4132,0,5,"1","",30,2},
	{609,"task_msg_2340",5,2,4132,4132,0,5,"3","",30,2},
	{610,"task_msg_2341",5,2,4132,4132,0,5,"2","",30,2},
	{611,"task_msg_2342",5,2,4132,4132,0,5,"1","",30,2},
	{612,"task_msg_2343",5,2,4132,4132,0,5,"4","",30,2},
	{613,"task_msg_2344",5,2,4132,4132,0,5,"4","",30,2},
	{614,"task_msg_2345",5,2,4132,4132,0,5,"1","",30,2},
	{615,"task_msg_2346",5,2,4132,4132,0,5,"1","",30,2},
	{122,"task_msg_2347",2,2,4163,4163,0,1,"1","",46,2},
	{37,"task_msg_2348",2,2,4164,4164,0,1,"1","88",45,2},
	{94,"task_msg_2349",2,6,4164,4164,0,1,"2","",47,2},
	{70,"task_msg_2350",1,1,4139,4139,0,1,"1","48",30,2},
	{112,"task_msg_2351",1,2,4172,4172,0,1,"1","111",55,2},
	{52,"task_msg_2352",1,1,4155,4156,0,1,"1","77",40,2},
	{50,"task_msg_2353",2,2,4139,4139,0,1,"3","127",32,2},
	{601,"task_msg_2354",5,2,4132,4132,0,5,"2","",30,2},
	{600,"task_msg_2355",5,2,4132,4132,0,10,"1","",30,2},
	{522,"task_msg_2356",4,2,4140,4140,0,10,"1","",30,0},
	{523,"task_msg_2357",4,2,4140,4140,0,10,"1","",30,0},
	{524,"task_msg_2358",4,2,4140,4140,0,10,"1","",30,0},
	{521,"task_msg_2359",4,2,4140,4140,0,10,"1","",30,0},
	{525,"task_msg_2360",4,2,4140,4140,0,10,"1","",30,0},
	{571,"task_msg_2361",4,2,4146,4146,0,10,"1","",30,1},
	{572,"task_msg_2362",4,2,4146,4146,0,10,"1","",30,1},
	{573,"task_msg_2363",4,2,4146,4146,0,10,"1","",30,1},
	{574,"task_msg_2364",4,2,4146,4146,0,10,"1","",30,1},
	{575,"task_msg_2365",4,2,4146,4146,0,10,"1","",30,1},
	{616,"task_msg_2366",5,2,4132,4132,0,10,"1","",30,2},
	{617,"task_msg_2367",5,2,4132,4132,0,10,"1","",30,2},
	{618,"task_msg_2368",5,2,4132,4132,0,10,"1","",30,2},
	{619,"task_msg_2369",5,2,4132,4132,0,10,"1","",30,2},
	{620,"task_msg_2370",5,2,4132,4132,0,10,"1","",30,2},
	{621,"task_msg_2371",5,2,4132,4132,0,10,"1","",30,2},
	{622,"task_msg_2372",5,2,4132,4132,0,5,"2","",30,2},
	{623,"task_msg_2373",5,2,4132,4132,0,5,"1","",30,2},
	{624,"task_msg_2374",5,2,4132,4132,0,5,"1","",30,2},
	{625,"task_msg_2375",5,2,4132,4132,0,5,"1","",30,2},
	{626,"task_msg_2376",5,2,4132,4132,0,5,"1","",30,2},
	{627,"task_msg_2377",5,2,4132,4132,0,5,"2","",30,2},
	{628,"task_msg_2378",5,2,4132,4132,0,5,"1","",30,2},
	{629,"task_msg_2379",5,2,4132,4132,0,5,"3","",30,2},
	{630,"task_msg_2380",5,2,4132,4132,0,5,"2","",30,2},
	{631,"task_msg_2381",5,2,4132,4132,0,5,"1","",30,2},
	{632,"task_msg_2382",5,2,4132,4132,0,5,"4","",30,2},
	{633,"task_msg_2383",5,2,4132,4132,0,5,"4","",30,2},
	{634,"task_msg_2384",5,2,4132,4132,0,5,"1","",30,2},
	{635,"task_msg_2385",5,2,4132,4132,0,5,"1","",30,2},
	{636,"task_msg_2386",5,2,4132,4132,0,10,"1","",30,2},
	{637,"task_msg_2387",5,2,4132,4132,0,10,"1","",30,2},
	{638,"task_msg_2388",5,2,4132,4132,0,10,"1","",30,2},
	{639,"task_msg_2389",5,2,4132,4132,0,10,"1","",30,2},
	{640,"task_msg_2390",5,2,4132,4132,0,5,"1","",30,2},
	{526,"task_msg_2391",4,1,4140,4141,0,10,"1","",30,0},
	{527,"task_msg_2392",4,2,4140,4140,0,10,"1","",30,0},
	{528,"task_msg_2393",4,2,4140,4140,0,10,"2","",30,0},
	{529,"task_msg_2394",4,2,4140,4140,0,10,"1","",30,0},
	{530,"task_msg_2395",4,2,4140,4140,0,10,"1","",30,0},
	{531,"task_msg_2396",4,2,4140,4140,0,10,"1","",30,0},
	{532,"task_msg_2397",4,2,4140,4140,0,10,"2","",30,0},
	{533,"task_msg_2398",4,2,4140,4140,0,10,"1","",30,0},
	{534,"task_msg_2399",4,2,4140,4140,0,10,"2","",30,0},
	{535,"task_msg_2400",4,2,4140,4140,0,10,"2","",30,0},
	{536,"task_msg_2401",4,1,4140,4125,0,10,"1","",30,0},
	{537,"task_msg_2402",4,1,4140,4122,0,10,"1","",30,0},
	{538,"task_msg_2403",4,1,4140,4105,0,10,"1","",30,0},
	{539,"task_msg_2404",4,1,4140,4116,0,10,"1","",30,0},
	{540,"task_msg_2405",4,1,4140,4121,0,10,"1","",30,0},
	{541,"task_msg_2406",4,2,4140,4140,0,10,"1","",30,0},
	{542,"task_msg_2407",4,2,4140,4140,0,10,"1","",30,0},
	{543,"task_msg_2408",4,2,4140,4140,0,10,"4","",30,0},
	{544,"task_msg_2409",4,2,4140,4140,0,10,"4","",30,0},
	{545,"task_msg_2410",4,2,4140,4140,0,10,"1","",30,0},
	{576,"task_msg_2411",4,2,4146,4146,0,10,"1","",30,1},
	{577,"task_msg_2412",4,2,4146,4146,0,10,"2","",30,1},
	{578,"task_msg_2413",4,2,4146,4146,0,10,"1","",30,1},
	{579,"task_msg_2414",4,2,4146,4146,0,10,"2","",30,1},
	{580,"task_msg_2415",4,2,4146,4146,0,10,"2","",30,1},
	{581,"task_msg_2416",4,1,4146,4125,0,10,"1","",30,1},
	{582,"task_msg_2417",4,1,4146,4122,0,10,"1","",30,1},
	{583,"task_msg_2418",4,1,4146,4105,0,10,"1","",30,1},
	{584,"task_msg_2419",4,1,4146,4116,0,10,"1","",30,1},
	{585,"task_msg_2420",4,1,4146,4121,0,10,"1","",30,1},
	{586,"task_msg_2421",4,2,4146,4146,0,10,"1","",30,1},
	{587,"task_msg_2422",4,2,4146,4146,0,10,"1","",30,1},
	{588,"task_msg_2423",4,2,4146,4146,0,10,"4","",30,1},
	{589,"task_msg_2424",4,2,4146,4146,0,10,"4","",30,1},
	{590,"task_msg_2425",4,2,4146,4146,0,10,"1","",30,1},
	{591,"task_msg_2426",4,2,4146,4146,0,10,"1","",30,1},
	{592,"task_msg_2427",4,2,4146,4146,0,10,"1","",30,1},
	{593,"task_msg_2428",4,2,4146,4146,0,10,"1","",30,1},
	{594,"task_msg_2429",4,2,4146,4146,0,10,"1","",30,1},
	{595,"task_msg_2430",4,2,4146,4146,0,10,"1","",30,1},
	{141,"task_msg_2431",1,2,4190,4190,0,1,"3","140",65,2},
	{142,"task_msg_2432",1,2,4190,4190,0,1,"1","141",65,2},
	{144,"task_msg_2433",1,2,4190,4190,0,1,"1","143",65,2},
	{143,"task_msg_2434",1,2,4190,4190,0,1,"1","142",65,2},
	{150,"task_msg_2435",1,2,4177,4177,0,1,"1","149",70,2},
	{151,"task_msg_2436",1,1,4177,4178,0,1,"1","150",70,2},
	{152,"task_msg_2437",1,2,4178,4178,0,1,"5","151",70,2},
	{153,"task_msg_2438",1,2,4178,4178,0,1,"1","152",70,2},
	{60,"task_msg_2439",1,2,4143,4143,0,1,"1","59",35,2},
	{63,"task_msg_2440",2,2,4145,4145,0,1,"1","62",39,2},
	{59,"task_msg_2441",1,1,4144,4143,0,1,"1","58",35,2},
	{58,"task_msg_2442",1,2,4144,4144,0,1,"1","57",35,2},
	{57,"task_msg_2443",1,2,4144,4144,0,1,"1","56",35,2},
	{56,"task_msg_2444",1,2,4144,4144,0,1,"4","55",35,2},
	{55,"task_msg_2445",1,1,4143,4144,0,1,"1","54",35,2},
	{61,"task_msg_2446",2,2,4143,4143,0,1,"1","",39,2},
	{62,"task_msg_2447",2,2,4145,4145,0,1,"4","61",39,2},
	{154,"task_msg_2448",2,2,4205,4205,0,1,"1","153",70,2},
	{155,"task_msg_2449",2,2,4205,4205,0,1,"1","153",70,2},
	{159,"task_msg_2450",1,2,4242,4242,0,1,"1","158",75,2},
	{160,"task_msg_2451",1,2,4242,4242,0,1,"1","159",75,2},
	{161,"task_msg_2452",1,1,4242,4193,0,1,"1","160",75,2},
	{162,"task_msg_2453",1,2,4193,4207,0,1,"5","161",75,2},
	{118,"task_msg_2454",1,2,4174,4174,0,1,"1","117",60,2},
	{163,"task_msg_2455",1,1,4207,4194,0,1,"1","162",75,2},
	{165,"task_msg_2456",1,2,4197,4197,0,1,"3","164",80,2},
	{167,"task_msg_2457",1,1,4197,4189,0,1,"1","166",80,2},
	{166,"task_msg_2458",1,2,4197,4197,0,1,"3","165",80,2},
	{168,"task_msg_2459",1,2,4189,4189,0,1,"5","167",80,2},
	{169,"task_msg_2460",1,2,4189,4189,0,1,"5","168",80,2},
	{170,"task_msg_2461",1,1,4189,4198,0,1,"1","169",80,2},
	{171,"task_msg_2462",1,2,4198,4198,0,1,"3","170",80,2},
	{157,"task_msg_2463",2,2,4205,4205,0,1,"1","",70,2},
	{156,"task_msg_2464",2,2,4205,4205,0,1,"1","",70,2},
	{146,"task_msg_2465",2,2,4190,4190,0,1,"1","144",60,2},
	{147,"task_msg_2466",2,2,4190,4190,0,1,"1","144",60,2},
	{148,"task_msg_2467",2,2,4190,4190,0,1,"1","144",60,2},
	{145,"task_msg_2468",2,2,4190,4190,0,1,"1","144",60,2},
	{173,"task_msg_2469",2,2,4198,4198,0,1,"1","",80,2},
	{172,"task_msg_2470",2,2,4198,4198,0,1,"1","",80,2},
	{176,"task_msg_2471",2,2,4198,4198,0,1,"1","",80,2},
	{175,"task_msg_2472",2,2,4198,4198,0,1,"1","",80,2},
	{174,"task_msg_2473",2,2,4198,4198,0,1,"1","",80,2},
	{179,"task_msg_2474",1,2,4171,4171,0,1,"2","178",85,2},
	{180,"task_msg_2475",1,2,4171,4171,0,1,"2","179",85,2},
	{181,"task_msg_2476",1,1,4171,4186,0,1,"1","180",85,2},
	{182,"task_msg_2477",1,2,4186,4186,0,1,"1","181",85,2},
	{183,"task_msg_2478",1,2,4186,4186,0,1,"1","182",85,2},
	{185,"task_msg_2479",1,2,4182,4182,0,1,"1","184",90,2},
	{186,"task_msg_2480",1,2,4182,4182,0,1,"1","185",90,2},
	{187,"task_msg_2481",1,2,4182,4182,0,1,"1","186",90,2},
	{188,"task_msg_2482",1,1,4182,4181,0,1,"1","187",90,2},
	{189,"task_msg_2483",1,2,4181,4181,0,1,"1","188",90,2},
	{650,"task_msg_2484",6,2,4131,4131,0,10,"1","",30,2},
	{651,"task_msg_2485",6,2,4131,4131,0,5,"2","",30,2},
	{652,"task_msg_2486",6,2,4131,4131,0,5,"1","",30,2},
	{653,"task_msg_2487",6,2,4131,4131,0,5,"1","",30,2},
	{654,"task_msg_2488",6,2,4131,4131,0,5,"1","",30,2},
	{655,"task_msg_2489",6,2,4131,4131,0,5,"1","",30,2},
	{656,"task_msg_2490",6,2,4131,4131,0,5,"1","",30,2},
	{657,"task_msg_2491",6,2,4131,4131,0,5,"2","",30,2},
	{24,"task_msg_2492",1,2,4116,4116,0,1,"1","23",15,2},
	{191,"task_msg_2493",1,2,4183,4183,0,1,"5","190",95,2},
	{192,"task_msg_2494",1,2,4183,4183,0,1,"5","191",95,2},
	{193,"task_msg_2495",1,1,4183,4196,0,1,"1","192",95,2},
	{194,"task_msg_2496",1,2,4196,4196,0,1,"3","193",95,2},
	{65,"task_msg_2497",1,1,4150,4151,0,1,"1","64",40,2},
	{66,"task_msg_2498",1,1,4152,4153,0,1,"1","65",40,2},
	{67,"task_msg_2499",1,2,4153,4153,0,1,"1","66",40,2},
	{68,"task_msg_2500",1,2,4153,4156,0,1,"1","67",40,2},
	{69,"task_msg_2501",1,1,4156,4154,0,1,"1","68",40,2},
	{72,"task_msg_2502",1,1,4156,4159,0,1,"1","75",40,2},
	{74,"task_msg_2503",1,2,4154,4157,0,1,"2","69",40,2},
	{75,"task_msg_2504",1,1,4157,4154,0,1,"1","74",40,2},
	{76,"task_msg_2505",2,1,4156,4158,0,1,"1","75",40,2},
	{78,"task_msg_2506",1,1,4154,4160,0,1,"1","52",40,2},
	{79,"task_msg_2507",1,2,4160,4160,0,1,"4","78",40,2},
	{80,"task_msg_2508",1,2,4160,4160,0,1,"1","79",40,2},
	{81,"task_msg_2509",1,2,4160,4160,0,1,"1","80",40,2},
	{190,"task_msg_2510",1,2,4183,4183,0,1,"5","189",95,2},
	{184,"task_msg_2511",1,1,4186,4182,0,1,"1","183",90,2},
	{178,"task_msg_2512",1,2,4171,4171,0,1,"2","177",85,2},
	{177,"task_msg_2513",1,1,4198,4171,0,1,"1","171",85,2},
	{164,"task_msg_2514",1,1,4193,4197,0,1,"1","163",80,2},
	{158,"task_msg_2515",1,1,4205,4242,0,1,"1","153",75,2},
	{149,"task_msg_2516",1,1,4190,4177,0,1,"1","144",70,2},
	{113,"task_msg_2517",1,1,4172,4173,0,1,"1","112",60,2},
	{105,"task_msg_2518",1,1,4168,4172,0,1,"1","100",55,2},
	{95,"task_msg_2519",1,1,4164,4168,0,1,"1","89",50,2},
	{82,"task_msg_2520",1,1,4160,4162,0,1,"1","81",45,2},
	{51,"task_msg_2521",2,1,4139,4140,0,1,"1","127",500,0},
	{53,"task_msg_2522",2,1,4140,4143,0,1,"1","51",500,0},
	{71,"task_msg_2523",2,1,4139,4146,0,1,"1","127",500,1},
	{73,"task_msg_2524",2,1,4146,4143,0,1,"1","71",500,1},
	{54,"task_msg_2525",1,2,4143,4143,0,1,"1","127",35,2},
	{64,"task_msg_2526",1,1,4143,4149,0,1,"1","129",40,2},
	{77,"task_msg_2527",1,2,4222,4155,0,1,"1","72",40,2},
	{140,"task_msg_2528",1,1,4176,4190,0,1,"1","118",65,2},
	{129,"task_msg_2529",1,1,4143,4143,0,1,"1","128",38,2},
	{125,"task_msg_2530",1,1,4139,4132,0,1,"1","124",30,2},
	{128,"task_msg_2531",1,1,4143,4143,0,1,"1","60",38,2},
	{201,"task_msg_2532",2,10,4123,4123,0,1,"1","",30,2},
	{202,"task_msg_2533",2,10,4123,4123,0,1,"1","",40,2},
	{124,"task_msg_2534",1,1,4139,4139,0,1,"1","70",30,2},
	{200,"task_msg_2535",2,2,4143,4143,0,1,"1","",35,2},
	{5,"task_msg_2536",1,1,4107,4107,0,1,"1","4",4,2},
	{203,"task_msg_2537",2,10,4110,4110,0,0,"1","",25,2},
	};


function GetTaskConfTable()
	return Task_Conf_Table;
end