require("scripts/taskmsg_vt")
------------------------------------------------------------------------
--TypeId, Name, Class, SubType, AcceptNpc, SubmitNpc, ReqTime, AcceptMaxNum, ReqStep, PreTask, ReqLev, Country(State)
------------------------------------------------------------------------
Task_Conf_Table = {
	{16,task_msg_002183,1,1,4105,4111,0,1,"1","15",11,2},
	{17,task_msg_002184,1,1,4111,4112,0,1,"1","16",11,2},
	{18,task_msg_002185,1,1,4112,4105,0,1,"1","17",11,2},
	{123,task_msg_002186,1,1,4114,4114,0,1,"1","",1,2},
	{1,task_msg_002187,1,2,4114,4104,0,1,"1","123",1,2},
	{126,task_msg_002188,2,9,4132,4132,0,1,"1","125",30,2},
	{127,task_msg_002189,1,1,4125,4125,0,1,"1","125",30,2},
	{48,task_msg_002190,1,1,4138,4139,0,1,"1","47",28,2},
	{2,task_msg_002191,1,2,4104,4104,0,1,"1","1",2,2},
	{3,task_msg_002192,1,1,4104,4106,0,1,"1","2",3,2},
	{4,task_msg_002193,1,1,4106,4107,0,1,"1","3",3,2},
	{5,task_msg_002194,1,1,4107,4107,0,1,"1","4",4,2},
	{6,task_msg_002195,1,1,4107,4106,0,1,"1","5",5,2},
	{7,task_msg_002196,1,1,4106,4106,0,1,"1","6",6,2},
	{8,task_msg_002197,1,1,4106,4113,0,1,"1","7",6,2},
	{9,task_msg_002198,1,1,4113,4108,0,1,"1","8",7,2},
	{10,task_msg_002199,1,1,4108,4167,0,1,"1","9",7,2},
	{11,task_msg_002200,1,1,4109,4110,0,1,"1","10",8,2},
	{12,task_msg_002201,1,6,4110,4109,0,1,"1","11",9,2},
	{13,task_msg_002202,1,1,4109,4110,0,1,"1","12",9,2},
	{14,task_msg_002203,1,9,4110,4109,0,1,"1","13",10,2},
	{15,task_msg_002204,1,1,4109,4105,0,1,"1","14",10,2},
	{19,task_msg_002205,1,2,4105,4105,0,1,"1","18",12,2},
	{20,task_msg_002206,1,1,4105,4105,0,1,"1","19",13,2},
	{21,task_msg_002207,1,1,4105,4115,0,1,"1","20",13,2},
	{22,task_msg_002208,1,2,4115,4115,0,1,"1","21",14,2},
	{23,task_msg_002209,1,1,4115,4116,0,1,"1","22",14,2},
	{25,task_msg_002210,1,1,4116,4116,0,1,"1","24",15,2},
	{26,task_msg_002211,1,1,4116,4117,0,1,"1","25",16,2},
	{27,task_msg_002212,1,2,4118,4118,0,1,"1","26",17,2},
	{28,task_msg_002213,1,1,4120,4121,0,1,"1","27",18,2},
	{29,task_msg_002214,1,2,4121,4121,0,1,"1","28",18,2},
	{30,task_msg_002215,1,1,4121,4126,0,1,"1","29",19,2},
	{31,task_msg_002216,1,1,4126,4122,0,1,"1","30",19,2},
	{32,task_msg_002217,1,1,4122,4122,0,1,"1","31",20,2},
	{33,task_msg_002218,1,1,4122,4123,0,1,"1","32",20,2},
	{34,task_msg_002219,1,1,4123,4124,0,1,"1","33",20,2},
	{35,task_msg_002220,1,2,4124,4124,0,1,"1","34",21,2},
	{36,task_msg_002221,1,1,4124,4125,0,1,"1","35",21,2},
	{38,task_msg_002222,1,1,4125,4124,0,1,"1","36",22,2},
	{39,task_msg_002223,1,1,4124,4133,0,1,"1","38",23,2},
	{40,task_msg_002224,1,1,4133,4127,0,1,"1","39",23,2},
	{41,task_msg_002225,1,1,4127,4133,0,1,"1","40",24,2},
	{42,task_msg_002226,1,1,4133,4135,0,1,"1","41",25,2},
	{43,task_msg_002227,1,2,4135,4135,0,1,"1","42",25,2},
	{44,task_msg_002228,1,2,4135,4135,0,1,"1","43",25,2},
	{45,task_msg_002229,1,7,4135,4137,0,1,"1","44",26,2},
	{46,task_msg_002230,1,2,4137,4137,0,1,"2","45",27,2},
	{47,task_msg_002231,1,1,4137,4138,0,1,"1","46",28,2},
	{83,task_msg_002232,2,6,4161,4161,0,1,"1","81",45,2},
	{84,task_msg_002233,1,1,4162,4163,0,1,"1","82",45,2},
	{85,task_msg_002234,1,1,4163,4164,0,1,"1","84",45,2},
	{86,task_msg_002235,1,2,4164,4164,0,1,"1","85",45,2},
	{87,task_msg_002236,1,2,4164,4164,0,1,"1","86",45,2},
	{88,task_msg_002237,1,2,4164,4164,0,1,"1","87",45,2},
	{89,task_msg_002238,1,2,4164,4164,0,1,"1","88",45,2},
	{90,task_msg_002239,2,2,4165,4165,0,1,"9","",46,2},
	{91,task_msg_002240,2,2,4165,4165,0,1,"1","90",46,2},
	{92,task_msg_002241,2,2,4165,4165,0,1,"5","91",46,2},
	{93,task_msg_002242,2,2,4165,4165,0,1,"1","92",46,2},
	{95,task_msg_002243,1,1,4164,4168,0,1,"1","",50,2},
	{96,task_msg_002244,1,2,4168,4168,0,1,"1","95",50,2},
	{97,task_msg_002245,1,2,4168,4168,0,1,"4","96",50,2},
	{98,task_msg_002246,1,2,4168,4168,0,1,"1","97",50,2},
	{99,task_msg_002247,1,1,4168,4169,0,1,"1","98",50,2},
	{100,task_msg_002248,1,1,4169,4168,0,1,"1","99",50,2},
	{101,task_msg_002249,2,1,4170,4171,0,1,"1","",52,2},
	{102,task_msg_002250,2,2,4171,4171,0,1,"1","101",52,2},
	{103,task_msg_002251,2,1,4171,4170,0,1,"1","102",52,2},
	{104,task_msg_002252,2,2,4170,4170,0,1,"1","103",52,2},
	{105,task_msg_002253,1,1,4168,4172,0,1,"1","",55,2},
	{106,task_msg_002254,1,2,4172,4172,0,1,"5","105",55,2},
	{107,task_msg_002255,1,2,4172,4172,0,1,"5","106",55,2},
	{108,task_msg_002256,1,2,4172,4172,0,1,"6","107",55,2},
	{109,task_msg_002257,1,2,4172,4172,0,1,"5","108",55,2},
	{110,task_msg_002258,1,2,4172,4172,0,1,"5","109",55,2},
	{111,task_msg_002259,1,2,4172,4172,0,1,"1","110",55,2},
	{113,task_msg_002260,1,1,4172,4173,0,1,"1","",60,2},
	{114,task_msg_002261,1,2,4173,4173,0,1,"2","113",60,2},
	{115,task_msg_002262,1,2,4173,4173,0,1,"1","114",60,2},
	{116,task_msg_002263,1,2,4173,4173,0,1,"6","115",60,2},
	{117,task_msg_002264,1,1,4173,4174,0,1,"1","116",60,2},
	{119,task_msg_002265,2,2,4174,4174,0,1,"1","118",61,2},
	{121,task_msg_002266,2,2,4139,4139,0,1,"1","50",32,2},
	{49,task_msg_002267,2,2,4139,4139,0,1,"1","50",32,2},
	{53,task_msg_002268,1,1,4140,4143,0,1,"1","51",35,1},
	{73,task_msg_002269,1,1,4146,4143,0,1,"1","71",35,1},
	{120,task_msg_002270,2,2,4139,4139,0,1,"1","50",32,2},
	{500,task_msg_002271,4,2,4140,4140,0,10,"1","",30,0},
	{501,task_msg_002272,4,1,4140,4141,0,10,"1","",30,0},
	{502,task_msg_002273,4,2,4140,4140,0,10,"1","",30,0},
	{503,task_msg_002274,4,2,4140,4140,0,10,"2","",30,0},
	{504,task_msg_002275,4,2,4140,4140,0,10,"1","",30,0},
	{505,task_msg_002276,4,2,4140,4140,0,10,"1","",30,0},
	{506,task_msg_002277,4,2,4140,4140,0,10,"1","",30,0},
	{507,task_msg_002278,4,2,4140,4140,0,10,"2","",30,0},
	{508,task_msg_002279,4,2,4140,4140,0,10,"1","",30,0},
	{509,task_msg_002280,4,2,4140,4140,0,10,"2","",30,0},
	{510,task_msg_002281,4,2,4140,4140,0,10,"2","",30,0},
	{511,task_msg_002282,4,1,4140,4125,0,10,"1","",30,0},
	{512,task_msg_002283,4,1,4140,4122,0,10,"1","",30,0},
	{513,task_msg_002284,4,1,4140,4105,0,10,"1","",30,0},
	{514,task_msg_002285,4,1,4140,4116,0,10,"1","",30,0},
	{515,task_msg_002286,4,1,4140,4121,0,10,"1","",30,0},
	{516,task_msg_002287,4,2,4140,4140,0,10,"1","",30,0},
	{517,task_msg_002288,4,2,4140,4140,0,10,"1","",30,0},
	{518,task_msg_002289,4,2,4140,4140,0,10,"4","",30,0},
	{519,task_msg_002290,4,2,4140,4140,0,10,"4","",30,0},
	{520,task_msg_002291,4,2,4140,4140,0,10,"1","",30,0},
	{550,task_msg_002292,4,2,4146,4146,0,10,"1","",30,1},
	{551,task_msg_002293,4,1,4146,4148,0,10,"1","",30,1},
	{552,task_msg_002294,4,2,4146,4146,0,10,"1","",30,1},
	{553,task_msg_002295,4,2,4146,4146,0,10,"2","",30,1},
	{554,task_msg_002296,4,2,4146,4146,0,10,"1","",30,1},
	{555,task_msg_002297,4,2,4146,4146,0,10,"1","",30,1},
	{556,task_msg_002298,4,2,4146,4146,0,10,"1","",30,1},
	{557,task_msg_002299,4,2,4146,4146,0,10,"2","",30,1},
	{558,task_msg_002300,4,2,4146,4146,0,10,"1","",30,1},
	{559,task_msg_002301,4,2,4146,4146,0,10,"2","",30,1},
	{560,task_msg_002302,4,2,4146,4146,0,10,"2","",30,1},
	{561,task_msg_002303,4,1,4146,4125,0,10,"1","",30,1},
	{562,task_msg_002304,4,1,4146,4122,0,10,"1","",30,1},
	{563,task_msg_002305,4,1,4146,4105,0,10,"1","",30,1},
	{564,task_msg_002306,4,1,4146,4116,0,10,"1","",30,1},
	{565,task_msg_002307,4,1,4146,4121,0,10,"1","",30,1},
	{566,task_msg_002308,4,2,4146,4146,0,10,"1","",30,1},
	{567,task_msg_002309,4,2,4146,4146,0,10,"1","",30,1},
	{568,task_msg_002310,4,2,4146,4146,0,10,"4","",30,1},
	{569,task_msg_002311,4,2,4146,4146,0,10,"4","",30,1},
	{570,task_msg_002312,4,2,4146,4146,0,10,"1","",30,1},
	{602,task_msg_002313,5,2,4132,4132,0,5,"1","",30,2},
	{603,task_msg_002314,5,2,4132,4132,0,5,"1","",30,2},
	{604,task_msg_002315,5,2,4132,4132,0,5,"1","",30,2},
	{605,task_msg_002316,5,2,4132,4132,0,5,"1","",30,2},
	{606,task_msg_002317,5,2,4132,4132,0,5,"1","",30,2},
	{607,task_msg_002318,5,2,4132,4132,0,5,"2","",30,2},
	{608,task_msg_002319,5,2,4132,4132,0,5,"1","",30,2},
	{609,task_msg_002320,5,2,4132,4132,0,5,"3","",30,2},
	{610,task_msg_002321,5,2,4132,4132,0,5,"2","",30,2},
	{611,task_msg_002322,5,2,4132,4132,0,5,"1","",30,2},
	{612,task_msg_002323,5,2,4132,4132,0,5,"4","",30,2},
	{613,task_msg_002324,5,2,4132,4132,0,5,"4","",30,2},
	{614,task_msg_002325,5,2,4132,4132,0,5,"1","",30,2},
	{615,task_msg_002326,5,2,4132,4132,0,5,"1","",30,2},
	{122,task_msg_002327,2,2,4163,4163,0,1,"1","",46,2},
	{37,task_msg_002328,2,2,4164,4164,0,1,"1","88",45,2},
	{94,task_msg_002329,2,6,4164,4164,0,1,"2","",47,2},
	{70,task_msg_002330,1,1,4139,4139,0,1,"1","48",30,2},
	{54,task_msg_002331,2,2,4143,4143,0,1,"1","",35,2},
	{112,task_msg_002332,1,2,4172,4172,0,1,"1","111",55,2},
	{69,task_msg_002333,1,1,4156,4154,0,1,"1","68",40,2},
	{72,task_msg_002334,1,1,4156,4159,0,1,"1","75",40,2},
	{75,task_msg_002335,1,1,4157,4154,0,1,"1","74",40,2},
	{76,task_msg_002336,2,1,4156,4158,0,1,"1","75",40,2},
	{78,task_msg_002337,1,1,4154,4160,0,1,"1","52",40,2},
	{82,task_msg_002338,1,1,4160,4162,0,1,"1","",45,2},
	{52,task_msg_002339,1,1,4155,4156,0,1,"1","77",40,2},
	{124,task_msg_002340,1,2,4139,4139,0,1,"50","70",30,2},
	{125,task_msg_002341,1,1,4139,4132,0,1,"1","124",30,2},
	{50,task_msg_002342,2,2,4139,4139,0,1,"3","127",32,2},
	{601,task_msg_002343,5,2,4132,4132,0,5,"2","",30,2},
	{600,task_msg_002344,5,2,4132,4132,0,10,"1","",30,2},
	{51,task_msg_002345,1,1,4139,4140,0,1,"1","127",30,0},
	{71,task_msg_002346,1,1,4139,4146,0,1,"1","127",30,1},
	{522,task_msg_002347,4,2,4140,4140,0,10,"1","",30,0},
	{523,task_msg_002348,4,2,4140,4140,0,10,"1","",30,0},
	{524,task_msg_002349,4,2,4140,4140,0,10,"1","",30,0},
	{521,task_msg_002350,4,2,4140,4140,0,10,"1","",30,0},
	{525,task_msg_002351,4,2,4140,4140,0,10,"1","",30,0},
	{571,task_msg_002352,4,2,4146,4146,0,10,"1","",30,1},
	{572,task_msg_002353,4,2,4146,4146,0,10,"1","",30,1},
	{573,task_msg_002354,4,2,4146,4146,0,10,"1","",30,1},
	{574,task_msg_002355,4,2,4146,4146,0,10,"1","",30,1},
	{575,task_msg_002356,4,2,4146,4146,0,10,"1","",30,1},
	{616,task_msg_002357,5,2,4132,4132,0,10,"1","",30,2},
	{617,task_msg_002358,5,2,4132,4132,0,10,"1","",30,2},
	{618,task_msg_002359,5,2,4132,4132,0,10,"1","",30,2},
	{619,task_msg_002360,5,2,4132,4132,0,10,"1","",30,2},
	{620,task_msg_002361,5,2,4132,4132,0,10,"1","",30,2},
	{621,task_msg_002362,5,2,4132,4132,0,10,"1","",30,2},
	{622,task_msg_002363,5,2,4132,4132,0,5,"2","",30,2},
	{623,task_msg_002364,5,2,4132,4132,0,5,"1","",30,2},
	{624,task_msg_002365,5,2,4132,4132,0,5,"1","",30,2},
	{625,task_msg_002366,5,2,4132,4132,0,5,"1","",30,2},
	{626,task_msg_002367,5,2,4132,4132,0,5,"1","",30,2},
	{627,task_msg_002368,5,2,4132,4132,0,5,"2","",30,2},
	{628,task_msg_002369,5,2,4132,4132,0,5,"1","",30,2},
	{629,task_msg_002370,5,2,4132,4132,0,5,"3","",30,2},
	{630,task_msg_002371,5,2,4132,4132,0,5,"2","",30,2},
	{631,task_msg_002372,5,2,4132,4132,0,5,"1","",30,2},
	{632,task_msg_002373,5,2,4132,4132,0,5,"4","",30,2},
	{633,task_msg_002374,5,2,4132,4132,0,5,"4","",30,2},
	{634,task_msg_002375,5,2,4132,4132,0,5,"1","",30,2},
	{635,task_msg_002376,5,2,4132,4132,0,5,"1","",30,2},
	{636,task_msg_002377,5,2,4132,4132,0,10,"1","",30,2},
	{637,task_msg_002378,5,2,4132,4132,0,10,"1","",30,2},
	{638,task_msg_002379,5,2,4132,4132,0,10,"1","",30,2},
	{639,task_msg_002380,5,2,4132,4132,0,10,"1","",30,2},
	{640,task_msg_002381,5,2,4132,4132,0,5,"1","",30,2},
	{526,task_msg_002382,4,1,4140,4141,0,10,"1","",30,0},
	{527,task_msg_002383,4,2,4140,4140,0,10,"1","",30,0},
	{528,task_msg_002384,4,2,4140,4140,0,10,"2","",30,0},
	{529,task_msg_002385,4,2,4140,4140,0,10,"1","",30,0},
	{530,task_msg_002386,4,2,4140,4140,0,10,"1","",30,0},
	{531,task_msg_002387,4,2,4140,4140,0,10,"1","",30,0},
	{532,task_msg_002388,4,2,4140,4140,0,10,"2","",30,0},
	{533,task_msg_002389,4,2,4140,4140,0,10,"1","",30,0},
	{534,task_msg_002390,4,2,4140,4140,0,10,"2","",30,0},
	{535,task_msg_002391,4,2,4140,4140,0,10,"2","",30,0},
	{536,task_msg_002392,4,1,4140,4125,0,10,"1","",30,0},
	{537,task_msg_002393,4,1,4140,4122,0,10,"1","",30,0},
	{538,task_msg_002394,4,1,4140,4105,0,10,"1","",30,0},
	{539,task_msg_002395,4,1,4140,4116,0,10,"1","",30,0},
	{540,task_msg_002396,4,1,4140,4121,0,10,"1","",30,0},
	{541,task_msg_002397,4,2,4140,4140,0,10,"1","",30,0},
	{542,task_msg_002398,4,2,4140,4140,0,10,"1","",30,0},
	{543,task_msg_002399,4,2,4140,4140,0,10,"4","",30,0},
	{544,task_msg_002400,4,2,4140,4140,0,10,"4","",30,0},
	{545,task_msg_002401,4,2,4140,4140,0,10,"1","",30,0},
	{576,task_msg_002402,4,2,4146,4146,0,10,"1","",30,1},
	{577,task_msg_002403,4,2,4146,4146,0,10,"2","",30,1},
	{578,task_msg_002404,4,2,4146,4146,0,10,"1","",30,1},
	{579,task_msg_002405,4,2,4146,4146,0,10,"2","",30,1},
	{580,task_msg_002406,4,2,4146,4146,0,10,"2","",30,1},
	{581,task_msg_002407,4,1,4146,4125,0,10,"1","",30,1},
	{582,task_msg_002408,4,1,4146,4122,0,10,"1","",30,1},
	{583,task_msg_002409,4,1,4146,4105,0,10,"1","",30,1},
	{584,task_msg_002410,4,1,4146,4116,0,10,"1","",30,1},
	{585,task_msg_002411,4,1,4146,4121,0,10,"1","",30,1},
	{586,task_msg_002412,4,2,4146,4146,0,10,"1","",30,1},
	{587,task_msg_002413,4,2,4146,4146,0,10,"1","",30,1},
	{588,task_msg_002414,4,2,4146,4146,0,10,"4","",30,1},
	{589,task_msg_002415,4,2,4146,4146,0,10,"4","",30,1},
	{590,task_msg_002416,4,2,4146,4146,0,10,"1","",30,1},
	{591,task_msg_002417,4,2,4146,4146,0,10,"1","",30,1},
	{592,task_msg_002418,4,2,4146,4146,0,10,"1","",30,1},
	{593,task_msg_002419,4,2,4146,4146,0,10,"1","",30,1},
	{594,task_msg_002420,4,2,4146,4146,0,10,"1","",30,1},
	{595,task_msg_002421,4,2,4146,4146,0,10,"1","",30,1},
	{141,task_msg_002422,1,2,4190,4190,0,1,"3","140",65,2},
	{142,task_msg_002423,1,2,4190,4190,0,1,"1","141",65,2},
	{140,task_msg_002424,1,1,4176,4190,0,1,"1","",65,2},
	{144,task_msg_002425,1,2,4190,4190,0,1,"1","143",65,2},
	{143,task_msg_002426,1,2,4190,4190,0,1,"1","142",65,2},
	{149,task_msg_002427,1,1,4190,4177,0,1,"1","",70,2},
	{150,task_msg_002428,1,2,4177,4177,0,1,"1","149",70,2},
	{151,task_msg_002429,1,1,4177,4178,0,1,"1","150",70,2},
	{152,task_msg_002430,1,2,4178,4178,0,1,"5","151",70,2},
	{153,task_msg_002431,1,2,4178,4178,0,1,"1","152",70,2},
	{60,task_msg_002432,1,2,4143,4143,0,1,"1","59",35,2},
	{63,task_msg_002433,2,2,4145,4145,0,1,"1","62",39,2},
	{66,task_msg_002434,1,1,4152,4153,0,1,"1","65",40,2},
	{65,task_msg_002435,1,1,4150,4151,0,1,"1","64",40,2},
	{64,task_msg_002436,1,1,4143,4149,0,1,"1","",40,2},
	{67,task_msg_002437,1,2,4153,4153,0,1,"1","66",40,2},
	{68,task_msg_002438,1,2,4153,4156,0,1,"1","67",40,2},
	{74,task_msg_002439,1,2,4154,4157,0,1,"2","69",40,2},
	{77,task_msg_002440,1,2,4222,4155,0,1,"1","75",40,2},
	{79,task_msg_002441,1,2,4160,4160,0,1,"4","78",40,2},
	{80,task_msg_002442,1,2,4160,4160,0,1,"1","79",40,2},
	{81,task_msg_002443,1,2,4160,4160,0,1,"1","80",40,2},
	{59,task_msg_002444,1,1,4144,4143,0,1,"1","58",35,2},
	{58,task_msg_002445,1,2,4144,4144,0,1,"1","57",35,2},
	{57,task_msg_002446,1,2,4144,4144,0,1,"1","56",35,2},
	{56,task_msg_002447,1,2,4144,4144,0,1,"4","55",35,2},
	{55,task_msg_002448,1,1,4143,4144,0,1,"1","54",35,2},
	{61,task_msg_002449,2,2,4143,4143,0,1,"1","",39,2},
	{62,task_msg_002450,2,2,4145,4145,0,1,"4","61",39,2},
	{128,task_msg_002451,1,1,4143,4143,0,1,"1","60",38,2},
	{129,task_msg_002452,1,2,4143,4143,0,1,"200","128",38,2},
	{154,task_msg_002453,2,2,4205,4205,0,1,"1","153",70,2},
	{155,task_msg_002454,2,2,4205,4205,0,1,"1","153",70,2},
	{158,task_msg_002455,1,1,4205,4242,0,1,"1","",75,2},
	{159,task_msg_002456,1,2,4242,4242,0,1,"1","158",75,2},
	{160,task_msg_002457,1,2,4242,4242,0,1,"1","159",75,2},
	{161,task_msg_002458,1,1,4242,4193,0,1,"1","160",75,2},
	{162,task_msg_002459,1,2,4193,4207,0,1,"5","161",75,2},
	{118,task_msg_002460,1,2,4174,4174,0,1,"1","117",60,2},
	{163,task_msg_002461,1,1,4207,4194,0,1,"1","162",75,2},
	{164,task_msg_002462,1,1,4193,4197,0,1,"1","",80,2},
	{165,task_msg_002463,1,2,4197,4197,0,1,"3","164",80,2},
	{167,task_msg_002464,1,1,4197,4189,0,1,"1","166",80,2},
	{166,task_msg_002465,1,2,4197,4197,0,1,"3","165",80,2},
	{168,task_msg_002466,1,2,4189,4189,0,1,"5","167",80,2},
	{169,task_msg_002467,1,2,4189,4189,0,1,"5","168",80,2},
	{170,task_msg_002468,1,1,4189,4198,0,1,"1","169",80,2},
	{171,task_msg_002469,1,2,4198,4198,0,1,"3","170",80,2},
	{157,task_msg_002470,2,2,4205,4205,0,1,"1","",70,2},
	{156,task_msg_002471,2,2,4205,4205,0,1,"1","",70,2},
	{146,task_msg_002472,2,2,4190,4190,0,1,"1","144",60,2},
	{147,task_msg_002473,2,2,4190,4190,0,1,"1","144",60,2},
	{148,task_msg_002474,2,2,4190,4190,0,1,"1","144",60,2},
	{145,task_msg_002475,2,2,4190,4190,0,1,"1","144",60,2},
	{173,task_msg_002476,2,2,4198,4198,0,1,"1","",80,2},
	{172,task_msg_002477,2,2,4198,4198,0,1,"1","",80,2},
	{176,task_msg_002478,2,2,4198,4198,0,1,"1","",80,2},
	{175,task_msg_002479,2,2,4198,4198,0,1,"1","",80,2},
	{174,task_msg_002480,2,2,4198,4198,0,1,"1","",80,2},
	{177,task_msg_002481,1,1,4198,4171,0,1,"1","",85,2},
	{178,task_msg_002482,1,2,4171,4171,0,1,"2","",85,2},
	{179,task_msg_002483,1,2,4171,4171,0,1,"2","178",85,2},
	{180,task_msg_002484,1,2,4171,4171,0,1,"2","179",85,2},
	{181,task_msg_002485,1,1,4171,4186,0,1,"1","180",85,2},
	{182,task_msg_002486,1,2,4186,4186,0,1,"1","181",85,2},
	{183,task_msg_002487,1,2,4186,4186,0,1,"1","182",85,2},
	{184,task_msg_002488,1,1,4186,4182,0,1,"1","",90,2},
	{185,task_msg_002489,1,2,4182,4182,0,1,"1","184",90,2},
	{186,task_msg_002490,1,2,4182,4182,0,1,"1","185",90,2},
	{187,task_msg_002491,1,2,4182,4182,0,1,"1","186",90,2},
	{188,task_msg_002492,1,1,4182,4181,0,1,"1","187",90,2},
	{189,task_msg_002493,1,2,4181,4181,0,1,"1","188",90,2},
	{650,task_msg_002494,6,2,4131,4131,0,10,"1","",30,2},
	{651,task_msg_002495,6,2,4131,4131,0,5,"2","",30,2},
	{652,task_msg_002496,6,2,4131,4131,0,5,"1","",30,2},
	{653,task_msg_002497,6,2,4131,4131,0,5,"1","",30,2},
	{654,task_msg_002498,6,2,4131,4131,0,5,"1","",30,2},
	{655,task_msg_002499,6,2,4131,4131,0,5,"1","",30,2},
	{656,task_msg_002500,6,2,4131,4131,0,5,"1","",30,2},
	{657,task_msg_002501,6,2,4131,4131,0,5,"2","",30,2},
	{24,task_msg_002502,1,2,4116,4116,0,1,"1","23",15,2},
	{190,task_msg_002503,1,2,4183,4183,0,1,"5","",95,2},
	{191,task_msg_002504,1,2,4183,4183,0,1,"5","190",95,2},
	{192,task_msg_002505,1,2,4183,4183,0,1,"5","191",95,2},
	{193,task_msg_002506,1,1,4183,4196,0,1,"1","192",95,2},
	{194,task_msg_002507,1,2,4196,4196,0,1,"3","193",95,2},
	};


function GetTaskConfTable()
	return Task_Conf_Table;
end
