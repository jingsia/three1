/*************************************************************************
	> File Name: AttrExtra.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Mar 2016 03:35:12 PM CST
 ************************************************************************/

#ifndef _ATTREXTRA_H_
#define _ATTREXTRA_H_

namespace GData
{
	struct SkillBase;

	class AttrExtra
	{
		AttrExtra() : strength(0), physique(0), agility(0), intelligence(0), will(0), soul(0),
		aura(0), auraMax(0), attack(0), magatk(0), defend(0), magdef(0),
		hp(0), tough(0), action(0), hitrate(0), evade(0), critical(0),
		criticaldmg(0), pierce(0), counter(0), magres(0), piercedmg(0), strengthP(0), physiqueP(0),
		/*=============*/
		attackpiere(0)
		{}

		AttrExtra& operator += (const AttrExtra& other)
		{
			strength += other.strength;
			/*================*/

			return *this;
		}

		AttrExtra& operator *= (const GObject::AttrFactor& af)
		{
			strength *= af.strength;
			/*================*/

			return *this;
		}

		AttrExtra& operator += (const CittaEffect& other)
		{
			strength += other.strength;
			/*=====*/

			return *this;
		}

		AttrExtra operator *(const float rate) const
		{
			AttrExtra aet = *this;
			aet.strength *= rate;
			aet.agility *= rate;
			/*======*/

			return aet;
		}

		float strength;
		float physique;
		/*===========*/

		std::vector<const SkillBase*> skills;
	};

	struct AttrExtraItem:
		public ObjectBaseNT<>
	{
		AttrExtraItem(UInt32 idx): ObjectBaseNT<>(idx) {}
		AttrExtra _extra;
		inline AttrExtra* operator ->() {return &_extra;}
		inline operator const AttrEtra*() const {return &_extra; }
	};

	typedef ObjectListT<AttrExtraItem> AttrExtraManager;

#define attrExtraManager AttrExtraManager::Instance();
}
#endif
