/*************************************************************************
	> File Name: OidGenerator.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 10 Nov 2016 11:47:54 AM CST
 ************************************************************************/

#ifndef _OIDGENERATOR_H_
#define _OIDGENERATOR_H_

#include "Common/AtomicVal.h"

namespace IDGenerator
{
	class IDGen
	{
	public:
		IDGen(UInt32 maxid = 0): _maxID(maxid) {}
	protected:
		virtual UInt32 genID()
		{
			return ++ _maxID;
		}
		inline void setMaxID(UInt32 id)
		{
			if(_maxID < id)
				_maxID = id;
		}
		AtomicVal<UInt32> _maxID;
	};

	class PlayerIDGen:
		public IDGen
	{
		public:
			PlayerIDGen(UInt32 maxid = 0): IDGen(maxid) {}
	};

	template<typename GenType>
	class OidGenerator : public GenType
	{
		public:
			UInt32 ID()
			{
				return GenType::genID();
			}
			void Init(UInt32 maxid)
			{
				GenType::setMaxID(maxid);
			}
	};

	typedef OidGenerator<PlayerIDGen> PlayerOidGenerator;

	extern PlayerOidGenerator gPlayerOidGenerator;
}
