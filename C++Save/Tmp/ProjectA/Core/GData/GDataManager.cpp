#include "Config.h"
#include "GDataManager.h"
#include "Area.h"
#include "WeaponDef.h"
#include "Formation.h"
#include "ExpTable.h"
#include "ClanLvlTable.h"
#include "LootTable.h"
#include "ClanTechTable.h"
#include "ClanSkillTable.h"
#include "ClanCopyTable.h"
#include "ClanStatueTable.h"
#include "ClanBuildingTable.h"
#include "GObject/Item.h"
#include "DB/DBConnectionMgr.h"
#include "GDataDBExecHelper.h"
#include "DB/DBExecutor.h"
#include "Server/ServerTypes.h"
#include "Server/Cfg.h"
#include "SkillTable.h"
#include "TablentTable.h"
#include "CittaTable.h"
#include "CopyTable.h"
#include "FrontMapTable.h"
#include "AcuPraTable.h"
#include "FighterProb.h"
#include "Money.h"
#include "Common/StringTokenizer.h"
#include "Common/URandom.h"
#include "EUpgrageTable.h"
#include "GObject/HeroMemo.h"
#include "Script/lua_tinker.h"
#include "SoulExpTable.h"
#include "SoulSkillTable.h"
#include "SkillStrengthen.h"
#include "DreamerTable.h"
#include "FairyPetTable.h"
#include "XingchenData.h"
#include "DrinkAttr.h"
#include "IncenseTable.h"
#include "PictureAttr.h"
#include "JiguanData.h"
#include "ZhanQiData.h"
#include "HunPoData.h"
#include "ErlkingTable.h"
#include "TeamArenaSkill.h"
#include "SevenSoul.h"
#include "RideConfig.h"
#include "GObject/Married.h"
#include "CoupleUpgrade.h"
#include "CoupleCopy.h"
#include "LingShiTable.h"
#include "CardSystem.h"
#include "NewQuestionsTable.h"
#include "ClanShop.h"
#include "TitleName.h"
#include "KettleNpc.h"
#include "lingbaoLevel.h"
#include "GObject/QuestionPaper.h"
#include "HorcruxHoldAttr.h"
#include "GObject/NinthFront.h"
#include "xianjiaLevel.h"
#include "zhyFenghunLevel.h"
#include "RelicGuard.h"
#include "DragonBall.h"
#include "GObject/DemonSpot.h"
#include "FingerGuess.h"
#include "ClanTreeA.h"
#include "ningshen.h"

namespace GData
{
	FingerGuess fingerGuessInfo;
	ClanTreeAttr clanTreeAttrData;
	NingshenData NingShenData;
	KettleNpc kettleAttrData;
	ItemBaseTypeManager itemBaseTypeManager;
	ItemBaseTypeNameManager itemBaseTypeNameManager;
	ObjectMapT<GObject::ItemWeapon> npcWeapons;
	std::vector<ItemGemType *> gemTypes(1000);
	std::vector<ItemGemType *> petGemTypes(1000);
	std::vector<ItemGemType *> mountTypes(1000);
	std::vector<ItemGemType *> lingshiTypes(1000);
	std::vector<ItemGemType *> lingzhuTypes(1000);
	std::vector<ItemGemType *> evolutionTypes(1000);
	std::vector<ItemGemType *> horcruxTypes(1000);
	std::vector<ItemGemType *> xingshiTypes(250);


	bool GDataManager::LoadAllData()
	{
		if(!LoadSkillEffect())
		{
			fprintf(stderr, "Load skill effect Error !\n");
			std::abort();
		}

		if(!LoadSkill())
		{
			fprintf(stderr, "Load skill Error !\n");
			std::abort();
		}
	}

	bool GDataManager::LoadSkillEffect()
	{
		std::unique_ptr<DB::DBExecutor> execu(DB::gDataDBConnectionMgr->GetExecutor());
		if(execu.get() == NULL || !execu->isConnected())  return false;
		DBSkillEffect effs;
		if(execu->Prepare("SELECT `id`, `state`, `immune`, `disperse`, `damage`, `adddam`, `magdam`, `addmag`, `crrdam`, `addcrr`, `hp`, `addhp`, `absorb`, `thorn`, `inj2hp`, `aura`, `atk`, `def`, `magatk`, `magdef`, `tough`, `action`, `hitrate`, `evade`, `critical`, `pierce`, `counter`, `magres`, `atkreduce`, `magatkreduce`, `eft`, `efl`, `efv`, `hppec`, `maxhpdampec` FROM `skill_effect`", effs) != DB::DB_OK)
			return false;
		while(execu->Next() == DB::DB_OK)
		{
			SkillEffect * ef = new SkillEffect(effs, id);
			if(!ef)
				return false;
			ef->state = effs.state;
			ef->immune = effs.immune;
			ef->disperse = effs.disperse;
			SetValOrPercent(ef->damage, ef->damageP, effs.damage);
			ef->adddam = effs.adddam;
			SetValOrPercent(ef->magdam, ef->magdamP, effs.magdam);
			ef->addmag = effs.addmag;
			SetValOrPercent(ef->crrdam, ef->crrdamP, effs.crrdam);
			ef->addcrr = effs.addcrr;
			SetValOrPercent(ef->hp, ef->hpP, effs.hp);
			ef->addhp = effs.addhp;
			SetValOrPercent(ef->absorb, ef->absorb, effs.absorb);
			SetValOrPercent(ef->thorn, ef->thornP, effs.thorn);
			SetValOrPercent(ef->inj2hp, ef->inj2hpP, effs.inj2hp);
			SetValOrPercent(ef->aura, ef->auraP, effs.aura);
			SetValOrPercent(ef->atk, ef->atkP, effs.atk);
			SetValOrPercent(ef->def, ef->defP, effs.def);
			SetValOrPercent(ef->magatk, ef->magatkP, effs.magatk);
			SetValOrPercent(ef->magdef, ef->magdefP, effs.magdef);
			ef->tough = effs.tough;
			SetValOrPercent(ef->action, ef->actionP, effs.action);
			ef->hitrate = effs.hitrate;
			ef->evade = effs.evade;
			ef->critical = effs.critical;
			ef->pierce = effs.pierce;
			ef->counter = effs.counter;
			ef->magres = effs.magres;
			ef->magatkreduce = effs.magatkreduce;
			{
				StringTokenizer tk(effs.eft, ",");
				if(tk.count())
				{
					for(size_t i = 0; i < tk.count(); ++i)
					{
						ef->eft.push_back(::atoi(tk[i].c_str()));
					}
				}
			}
			{
				StringTokenizer tk(effs.efl, ",");
				if(tk.count())
				{
					for(size_t i = 0; i < tk.count(); ++i)
					{
						ef->eft.push_back(::atoi(tk[i].c_str()));
					}
				}
			}
			{
				StringTokenizer tk(effs.efv, ",");
				if(tk.count())
				{
					for(size_t i = 0; i < tk.count(); ++i)
					{
						ef->eft.push_back(::atoi(tk[i].c_str()));
					}
				}
			}
			ef->hppec = effs.hppec;
			ef->maxhpdampec = effs.maxhpdampec;
			skillEffectManager.add(ef);
		}
		return true;
	}

	bool GDataManager::LoadSkills()
	{
		std::unique_ptr<DB::DBExecutor> execu(DB::gDataDBConnectionMgr->GetExecutor());
		if(execu.get() == NULL || !execu->isConnected()) return false;
		DBSkill skills;
		if(execu->Prepare("SELECT `id`, `name`, `color`, `target`, `cond`, `prob`, `area`, `factor`, `last`, `cd`, `effectid` FROM `skills`", skills) != DB::DB_OK)
			return false;
		while(execu->Next() == DB::DB_OK)
		{
			SkillBase* skill = new SkillBase(skills.id, skills.name);
			if(!skill)
				return false;
			skill->color = skills.color;
			skill->target = skills.target;
			skill->cond = skills.cond;
			skill->prob = skills.prob;
			skill->area = skills.area;
			StringTokenizer tk(skills.factor, ",");
			if(tk.count())
			{
				for(size_t i = 0; i < tk.count(); ++i)
				{
					skill->factor.push_back(::atoi(tk[i].c_str()));
				}
			}
			skill->last = skills.last;
			skill->cd = skills.cd;
			skill->effect = skillEffectManager[skills.effectid];
			skillManager.add(skill);
		}
		return true;
	}

	bool GDataManager::LoadDreamer()
	{
		std::unique_ptr<DB::DBExecutor> execu(DB::gDataDBConnectionMgr->GetExecutor());
		if(execu.get() == NULL || !execu->isConnected()) return false;

		DBDreamer dbd;
		if(execu->Prepare("SELECT `level`, `floor`, `maxX`, `maxY`, `gridCount`, `timeConsume`, `typeCount`, FROM `dreamer_template` ORDER BY `level`, `floor`", dbd) != DB::DB_OK)
			return false;

		while(execu->Next() == DB::DB_OK)
		{
			DreamerLevelData dreamerLevelData(dbd.maxX, dbd.maxY, dbd.gridCount, dbd.timeConsume, dbd.typeCount);
			if(dbd.level >= dreamerDataTable.size())
			{
				dreamerDataTable.resize(dbd.level + 1);
			}
			if(dbd.floor >= dreamerDataTable[dbd.level]).size()
			{
				dreamerDataTable[dbd.level].resize(dbd.floor + 1);
				dreamerDataTable[dbd.level].resize(dbd.floor + 1);
			}
			dreamerDataTable[dbd.level][dbd.floor] = dreamerLevelData;
		}
		return true;
	}
}

