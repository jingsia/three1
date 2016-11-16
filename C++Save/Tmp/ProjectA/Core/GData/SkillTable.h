/*************************************************************************
	> File Name: SkillTable.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 07 Apr 2016 05:54:32 AM CST
 ************************************************************************/

#ifndef SKILLTABLE_H_
#define SKILLTABLE_H_

#include "Config.h"
#include "ObjectManager.h"

namespace GData
{
#define SKILL_LEVEL_MAX 100
#define SKILL_LEVEL(x) (((UInt32)(x))%SKILL_LEVEL_MAX)
#define SKILL_ID(x) (((UInt32)(x)/SKILL_LEVEL_MAX)
#define SKILLANDLEVEL(s, l) (((UInt32)(s))*SKILL_LEVEL_MAX + ((UInt32)(l)))

#define CITTA_LEVEL_MAX 100
#define CITTA_LEVEL(x) (((UInt16)(x))%CITTA_LEVEL_MAX)
#define CITTA_ID(x) (((UInt16)(x))/CITTA_LEVEL_MAX)
#define CITTAANDLEVEL(c, l) (((UInt16)(c))*CITTA_LEVEL_MAX + ((UInt16)(l)))
#define CITTA_TO_ITEMID(x) ((UInt16)(x) / CITTA_LEVEL_MAX + LCITTA_ID - 1)
#define CITTA_TO_ITEMID(x) (x < 21100 ? CITTA_TO_ITEMID2(x) : CITTA_TO_ITEMID2(X) + 19591)

enum //技能出发方式
{
	SKILL_ACTIVE = 0,
	SKILL_PEERLESS,
	SKILL_PASSSTART,
	SKILL_PREATK = SKILL_PASSSTART,
	SKILL_AFTATK,
	SKILL_BEATKED,
	SKILL_AFTEVD,
	SKILL_AFTRES,
	SKILL_ENTER,
	SKILL_DEAD,
	SKILL_AFTNATK,
	SKILL_ONTHERAPY,
	SKILL_ONSKILLDMG,
	SKILL_ONOTHREADEAD,
	SKILL_ONCOUNTER,
	SKILL_ONATKBLEED,
	SKILL_ONATKDMG,
	SKILL_ONPETPROTECT,
	SKILL_ONGETDMG,		// 受到任何伤害触发
	SKILL_ONBEDMG,		// 被其他人攻击触发
	SKILL_ONBEPHYDMG,
	SKILL_ONBEMAGDMG,
	SKILL_ONHP10P,		// 生命剩余1/3
	SKILL_DEAD_FAKE,	// 复活
	SKILL_ABNORMAL_TYPE_DMG,	// 异常类状态伤害
	SKILL_BLEED_TYPE_DMG,		//流血类状态伤害
	SKILL_XMCZ,		//降魔禅杖
	SKILL_BLTY,		// 碧蓝天衣
	SKILL_AFTACTION,	// 行动后触发（包括被眩晕）
	SKILL_ONHPCHANGE,	// HP改变时触发
	SKILL_ONWITHSTAND,  // 招架
	SKILL_VIOLENT,		//狂暴
	SKILL_REVIVAL,		// 生生不息
	SKILL_LINGSHI,		// 灵石技能
	SKILL_ONOTHERCONFUSEFORGET, //其它人获得沉默和混乱
	SKILL_ENTER_LINGSHI,	// 灵石入场技能
	SKILL_ONATKSTUN,		// 攻击带眩晕的主目标后
	SKILL_ONATKCONFUSEFORGET,	//攻击带混乱沉默的主目标后
	SKILL_ONATKBLIND,		//攻击带致盲的主目标后
	SKILL_CONDITION,		// 达到条件100% 触发
	SKILL_EVOLUTION,		// 达到仙气
	SKILL_PASSIVES
};

enum
{
	SKILL_EFFECT_FALG_VALUE = 30000
};

enum
{
	e_battle_target_selfside		= 0,
	e_battle_target_otherside		= 1,
	e_battle_target_self			= 2,
	e_battle_target_otherside_max	= 3,
	e_battle_target_toherside_min	= 4,
	e_battle_target_selfside_max	= 5,
	e_battle_target_selfside_min	= 6,
	e_battle_target_selfside_atk_max	= 7,
	e_battle_target_selfside_atk_2nd	= 8,
	e_battle_target_otherside_random	= 9,
}；

// 技能附加特效类型 :
enum
{
	e_eft_hide = 1, 
	e_eft_double_hit = 2,
	e_eft_mark_hide_dhit = 3,
	e_eft_mark_hide_blind = 4,
	e_eft_selfside_ru_shi_magatk = 5,
	e_eft_selfside_dao_dmgreduce = 6,
	e_eft_hide_attack = 7,
	e_eft_mark_hide_week = 8,
	e_eft_hide_summon = 9,
	e_eft_rnd_fgt_buf_aura = 10,
	e_eft_evade100 = 11,
	e_eft_selfside_buf_aura = 12,
	e_eft_selfside_absorb = 13,
	e_eft_hide_aura = 14,
	e_eft_counter_hate = 15,
	e_eft_hp_shield = 16,
	e_eft_self_bleed = 17,
	e_eft_random_shield = 18,
	e_eft_self_attack = 19,
	e_eft_random_target_attack = 20,
	e_eft_mark_pet = 21,
	e_eft_atk_pet_mark_aura = 22,
	e_eft_atk_pet_mark_extra_dmg = 23,
	e_eft_prtect_pet_100 = 24,
	e_eft_pet_atk_100 = 25,
	e_eft_pet_protect_reduce = 26,
	e_eft_counter_spirit = 27,
	e_eft_fire_def = 28,
	e_eft_sneak_atk = 29,
	e_eft_dec_wave_dmg = 30,
	e_eft_lingqu = 31,
	e_eft_lingshi_bleed = 32,
	e_eft_lingyou_atk = 33,
	e_eft_lingyou_magatk = 34,
	e_eft_lingyou_def = 35,
	e_eft_lingyou_magdef = 36,
	e_eft_criticaldmgreduce = 37,
	e_eft_soul_out = 38,
	e_eft_abnormal_type_dmg = 39,
	e_eft_bleed_type_dmg = 40,
	e_eft_buddha_light = 41,
	e_eft_no_use = 42,
	e_eft_bi_lan_tian_yi = 43,
	e_eft_zhu_tian_bao_jian = 44,
	e_eft_trigger_count_max = 45,
	e_eft_hp_lostp = 46,
	e_eft_withstand = 47,
	e_eft_flaw = 48,
	e_eft_ru_red_carpet = 49,
	e_eft_shi_flower = 50,
	e_eft_dao_rose = 51,
	e_eft_mo_knot = 52,
	e_eft_prudent = 53,
	e_eft_silkworm = 54,
	e_eft_chaos_world = 55,
	e_eft_lingshi_enter = 56,
	e_eft_lingshi_mojian = 57,
	e_eft_lingshi_buqu = 58,
	e_eft_lingshi_mozhu = 59,
	e_eft_lingshi_gaoneng = 60,
	e_eft_round_add = 61,
	e_eft_round_sub = 62,
	e_eft_control_ball = 63,
	e_eft_dispeerless = 64,

	e_eft_evolution1 = 65,
	e_eft_evolution2 = 66,
	e_eft_evolution3 = 67,
	e_eft_evolution4 = 68,
	e_eft_evolution5 = 69,
	e_eft_bimutianluo = 70,
	e_eft_add_aura_average = 71,
	e_eft_add_atkreduce_all = 72,
	e_eft_luyishuiyanluo = 73,
	e_eft_revive = 74,
	e_eft_evade100_lingshi = 75,
	e_eft_selfside_hp_shield = 76,
	e_eft_therapyreduce = 77,
	e_eft_add_attr = 78,
	e_eft_regen_hp = 79,
	e_eft_shangheng = 80,
	e_eft_choucheng = 81,
	e_eft_cihang = 82,
	e_eft_xuanji = 83,
	e_eft_counter_dmg = 84,
	e_eft_dmg_therapy = 85,
	e_eft_zhetian = 86,
	e_eft_reduce_shield = 87,
	e_eft_reduce_piercedmgimmune = 88,
	e_eft_max
};

enum
{
	e_state_poison		= 0x1,		//中毒
	e_state_confuse		= 0x2,		//混乱
	e_state_stun		= 0x4,		//眩晕
	e_state_forget		= 0x8,		//封印
	e_state_dmgback		= 0x10,		//伤害反弹
	e_state_weak		= 0x20,		//虚弱
	e_state_dec_aura	= 0x40,		//减灵气
	e_state_mark_mo		= 0x80,		//墨印
	e_state_blind		= 0x100,	//致盲
	e_state_frozen		= 0x200,	//冰冻
	e_state_forbidmagic = 0x400,	//禁魔
	e_state_unBenevolent = 0x800,	//慈悲

	e_state_c_s_f		= 0x0E,		//混乱，眩晕， 沉默
	e_state_c_s_f_w		= 0x23,		//混乱，眩晕,  封印， 虚弱
	e_state_c_s_f_m_b	= 0x18e,    //混乱，眩晕，封印，墨印，致盲
	e_state_c_s_f_b		= 0x10e,
	e_state_c_s_f_w_m_b = 0x1ae,
	e_state_c_s_f_w_m_b_f_f = 0x7ae,
};

struct SkillEffect : public ObjectBaseNT<UInt32>
{
	SkillEffect(UInt32 id)
		： ObjectBaseNT<UInt32>(id), state(0), immune(0), disperse(0), damage(0), damageP(0), adddam(0), magdam(0), magdamP(0), addmag(0), crrdam(0), crrdamP(0), addcrr(0), hp(0), hpP(0), addhp(0), absorb(0), absorbP(0), thorn(0), thornP(0), inj2hp(0), inj2hpP(0), aura(0), auraP(0), atk(0), atkP(0), def(0), defP(0), magatk(0), magatkP(0), magdef(0), magdef(0), magdefP(0), tough(0), action(0), actionP(0),
hitrate(0), avade(0), critical(0), pierce(0), counter(0), magres(0), atkreduce(0), magatkreduce(0), hppec(0), maxhpdampec(0) {}
	~SkillEffect() {}

	UInt16 state;  //状态: 0-无状态 1-中毒 2-混乱 4-眩晕 8-无法使用技能 16-反伤 32-虚弱 64-降灵气 有等级之分
	UInt16 immune;	//对状态技能的免疫 只能免疫比自己技能低的技能
	UInt16 disperse; // 驱散状态，只对友方使用， 除自己外， 是状态的值的和
	UInt16 damage;	//物理上海
	float damageP;
	float adddam;	//物理上海附加
	Int16 magdam;	//法术伤害 num/num%
	float magdamP;
	float addmag;	//法术伤害附加
	Int16 crrdam;	//职业伤害
	float crrdamP;
	float addcrr;	//职业伤害附加
	Int16 hp;		//hp改变
	float hpP;
	float addhp;	//hp改变附加
	Int16 absorb;	//上海吸血
	float absorbP;
	Int16 thorn;	//反弹
	float thornP;
	Int16 inj2hp;	//受伤回扣
	float inj2hpP;
	Int16 aura;		//作用士气
	float auraP;
	Int16 atk;		//物理攻击
	float atkP;
	Int16 def;		// 物理防御
	float defP;
	Int16 magatk;	//法术攻击
	float magatkP;
	Int16 magdef;
	float magdefP;
	float tough;	//坚韧
	float action;	//身法
	float actionP;
	float hitrate;	//命中
	float evade;	//闪避
	float critical;	//暴击
	float pierce;	//击破
	float counter;	//反击
	float magres;	//法术抵抗
	float atkreduce;//物理伤害减免
	float magatkreduce;//法术上海减免
	float hppec;	//最大生命值伤害百分比
	float maxhpdampec;//最大生命值伤害百分比最大值

	// 技能附加特效类型
	std::vector<UInt16> eft;
	std::vector<UInt8> efl; // 技能附加特效持续回合
	std::vector<float> efv;	// 技能附加特效值 
};

struct SkillBase : public ObjectBaseT<UInt32>
{
	SkillBase(UInt32 id, const std::string& name)
		: ObjectBaseT<UInt32>(id, name), target(0), cond(0),
		prob(0), area(0), last(0), cd(0), effect(0) {}
	~SkillBase() {if (effect) delete effect; }

	UInt8 color;				// 技能颜色 1-白色 2-绿色 3-蓝色 4-紫色 5-橙色
	UInt8 target;				// 使用对象 0-友方 1-敌方 2-自己 3-敌方血量最高 4-敌方血量最低 5-我方血量最高 6-我方血量最低
	UInt8 cond;					// 触发条件 SKILL_ACTIVE	- 主动
								//			SKILL_PEERLESS  - 无双技能
								//			SKILL_PREATK	- 攻击前被动触发
								//			SKILL_AFTATK  - 攻击后被动触发
								//			SKILL_AFTMATK  -普通攻击后被动触发
								//			and so on...
	float prob;					//	主动状态触发概率 或 被动触发概率
	UInt8 area;					//	伤害范围：0-单体 1-全体 2-横排 3-竖列 4-十字 5-v字 6-T字 12-X字
	std::vector<float> factor;	//	伤害倍率 如 横排伤害 1, 0.3, 0.5, 1, 0 距离攻击目标为0的伤害系数是1， 距离为2的伤害系数为0.5
	Int16 last;					//	持续时间： -1-一直有效 0-非持续， N-持续次数
	UInt16 cd;					//	冷却回合
	const SkillEffect* effect;
};

struct SkillItem
{
	const SkillBase* base;
	float rateExtent;
	UInt16 cd;
};

typedef ObjectMapT<SkillBase, UInt16> SkillManager;
#define skillManager SkillManager::Instance()

typedef ObjectMapT<SkillEffect, UInt16> SkillEffectManager;
#define skillEffectManager SkillEffectManager::Instance()

}

#endif
