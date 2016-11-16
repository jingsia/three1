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
        //��ƷID���ɹ���
        public:
            PlayerIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };

    class ItemIDGen:
        public IDGen
    {
        //��ƷID���ɹ���
        public:
            ItemIDGen(UInt32 maxid = 30000): IDGen(maxid) {}
    };

    class ChatFgtIDGen:
        public IDGen
    {
        //��ƷID���ɹ���
        public:
            ChatFgtIDGen(UInt32 maxid = 0x1000): IDGen(maxid) {}
    };

    class MailIDGen:
        public IDGen
    {
        //��ƷID���ɹ���
        public:
            MailIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };
    class SalesIDGen:
        public IDGen
    {
        //��ƷID���ɹ���
        public:
            SalesIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };

    class BattleIDGen:
        public IDGen
    {
        //ս��ID���ɹ���
        public:
            BattleIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };

    class ClanIDGen:
        public IDGen
    {
        //����ID���ɹ���
        public:
            ClanIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };

    class TradeIDGen:
        public IDGen
    {
        public:
            TradeIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class SaleIDGen:
        public IDGen
    {
        public:
            SaleIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class AthleticsRecordIDGen:
        public IDGen
    {
        public:
            AthleticsRecordIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class AthleticsEventIDGen:
        public IDGen
    {
        public:
            AthleticsEventIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class ClanBatterRecordIDGen:
        public IDGen
    {
        public:
            ClanBatterRecordIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class TeamArenaIDGen:
        public IDGen
    {
        public:
            TeamArenaIDGen(UInt32 maxid = 0) : IDGen(maxid) {}
    };

    class SeedIDGen:
        public IDGen
    {
        //�������ID���ɹ���
        public:
            SeedIDGen(UInt32 maxid = static_cast<UInt32>(time(NULL))): IDGen(maxid) {}
            virtual UInt32 genID() { _maxID += static_cast<UInt32>(time(NULL)); return _maxID; }
    };

    class CardIDGen:
        public IDGen
    {
        public:
            CardIDGen(UInt32 maxid = 0): IDGen(maxid) {}
    };

    template <typename GenType>
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
    typedef OidGenerator<ItemIDGen> ItemOidGenerator;
    typedef OidGenerator<ChatFgtIDGen> ChatFgtOidGenerator;
    typedef OidGenerator<MailIDGen> MailOidGenerator;
    typedef OidGenerator<SalesIDGen> SalesOidGenerator;
    typedef OidGenerator<BattleIDGen> BattleOidGenerator;
    typedef OidGenerator<ClanIDGen> ClanOidGenerator;
    typedef OidGenerator<SeedIDGen> SeedOidGenerator;
    typedef OidGenerator<TradeIDGen> TradeOidGenerator;
    typedef OidGenerator<SaleIDGen> SaleOidGenerator;
    typedef OidGenerator<AthleticsRecordIDGen> AthleticsRecordOidGenerator;
    typedef OidGenerator<ClanBatterRecordIDGen> ClanBatterRecordIDGenerator;
    typedef OidGenerator<AthleticsEventIDGen> AthleticsEventOidGenerator;
    typedef OidGenerator<TeamArenaIDGen> TeamArenaOidGenerator;
    typedef OidGenerator<CardIDGen> CardOidGenerator;

    extern PlayerOidGenerator gPlayerOidGenerator;
    extern ItemOidGenerator gItemOidGenerator;
    extern ChatFgtOidGenerator gChatFgtOidGenerator;
    extern MailOidGenerator gMailOidGenerator;
    extern SalesOidGenerator gSalesOidGenerator;
    extern BattleOidGenerator gBattleOidGenerator0;
    extern BattleOidGenerator gBattleOidGenerator1;
    extern ClanOidGenerator gClanOidGenerator;
    extern SeedOidGenerator gSeedOidGenerator;
    extern TradeOidGenerator gTradeOidGenerator;
    extern SaleOidGenerator gSaleOidGenerator;
    extern AthleticsRecordOidGenerator gAthleticsRecordOidGenerator;
    extern ClanBatterRecordIDGenerator gClanBatterRecordIDGenerator;
    extern AthleticsEventOidGenerator gAthleticsEventOidGenerator;
    extern TeamArenaOidGenerator gTeamArenaOidGenerator;
    extern CardOidGenerator gCardOidGenerator;
}


#endif
