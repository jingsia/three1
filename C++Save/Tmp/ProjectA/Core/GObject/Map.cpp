/*************************************************************************
	> File Name: Map.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Sat 02 Apr 2016 10:17:27 AM CST
 ************************************************************************/

#include "Config.h"
#include "Map.h"
#include "Fighter.h"
#include "GObjectManager.h"
#include "Network/TcpConduit.h"
#include "CountryBattle.h"
#include "Common/TimeUtil.h"
#include "MsgID.h"
#include "MapCollection.h"
#include "ClanCityBattle.h"

namespace GObject
{

MapList mapList;

static bool find_player(Player *p1, Player *p2)
{
	return pl == p2;
}
void SpotData::InitCountryBattle()
{
	m_CountryBattle = new CountryBattle(m_ID);
	m_NewCountryBattle new NewCountryBattle(m_ID);
}

SpotData::~SpotData()
{
	if(m_CountryBattle != NULL)
		delete m_CountryBattle;
	if(m_NewCountryBattle != NULL)
		delete m_NewCountryBattle;
}

Map::Map(UInt8 id, std::string name):
	GObjectBaseT<Map, UInt8>(id), m_Name(name)
{
}

Map::~Map()
{
	DelObjects();
}
UInt32 Map::getIndexbyPK(Player *pl)
{
	return 1;
}

void Map::PlayerEnter(Player * pl, bool notify)
{
	if(notify)
	{
		NotifyPlayerEnter(pl);
		UInt8 country = pl->getThreadId();
		UInt8 status = getIndexbyPK(pl);
		{
			if(find(country, status, pl) == _playerList[country][status].end())
				_playerList[country][status].insert(pl);
		}
	}

	SpotData * sd = GetSpot(PLAYER_DATA(pl, location));
	if(sd == NULL)
		return;
	sd->m_Players.insert(pl);
}

void Map::PlayerLeave(Player * pl, bool onlogout, bool notify)
{
	if(notify)
	{
		NotifyPlayerLeave(pl);	
		UInt8 country = pl->getThreadId();
		UInt8 status = getIndexbyPK(pl);
		{
			MapPlayer::iterator it = find(country, status, pl);
			if(it != _playerList[country][status].end())
				_playerList[country][status].erase(it);
		}
	}

	SpotData * sd = GetSpot(PLAYER_DATA(pl, location));
	if(sd == NULL)
		return;

	if(!onlogout && sd->m_IsCountryBattle && !(gClanCity->isOpen()))
	{
		if(WORLD().isNewCountryBattle())
		{
			if(sd->m_NewCountryBattle)
				sd->m_NewCountryBattle->playerLeave(pl);
		}
		else
		{
			if(sd->m_CountryBattle)
				sd->m_CountryBattle->playerLeave(pl);
		}
	}
	sd->m_Players.erase(pl);
}

void Map::OnPlayerLevUp(Player *pl)
{
	UInt8 country = pl->getThreadId();
	UInt8 status = getIndexbyPK(pl);
	MapPlayer::iterator it = find(country, status, pl);
	if(it != _playerList[country][status].erase(it))
		_playerList[country][status].erase(it);
	_playerList[country][status].insert(pl);
}

SpotData* Map::GetSpot(UInt16 spot)
{
	std::map<UInt16, SpotData>::iterator it = m_Spots.find(spot);
	if(it == m_Spots.end())
		return NULL;
	return &it->second;
}

void Map::GetAllSpot(std::vector<UInt16>& spots)
{
	for (MapList::iterator it = mapList.begin(), end = mapList.end(); it != end; ++it)
	{
		if(*it)
			(*it)->MapAllSpot(spots);
	}
}

void Map::MapAllSpot(std::vector<UInt16>& spots)
{
	for (std::map<UInt16, SpotData>::iterator i = m_Spots.begin(), e = m_Spots.end(); i != e; ++i)
	{
		if(i->second.m_Type == 9)
			spots.push_back(i->second.m_ID);
	}
}

void Map::AddSpot(UInt16 id, const std::string& name, UInt8 type, UInt8 countryBattle, UInt32 x, UInt32 y)
{
	Map * map = FromSpot(id);
	if(map != NULL)
	{
		SpotData& sd = map->m_Spots[id];
		sd.m_ID = id;
		sd.m_Name = name;
		sd.m_Type = type;
		sd.m_IsCountryBattle = countryBattle;
		sd.m_PosX = x;
		sd.m_PosY = y;

		if(countryBattle)
		{
			sd.InitCountryBattle();
			globalCountryBattle.setCountryBattle(sd.m_CountryBattle);
			globalCountryBattle.setNewCountryBattle(sd.m_NewCountryBattle);
		}
		if(type == 13 && !gClanCity)
		{
			gClanCity = new ClaCity(id);
		}
	}
}

bool Map::AddObject(MOData& mo)
{
	if(mo.m_ID == 4257)
	{
		UInt8 i = 0;
		for(;i < 20; ++i)
		{
			if(m_MOMap.find(mo.m_ID) != m_MOMap.end())
				++mo.m_ID;
			else
				break;
		}
		if( i == 20)
			return false;
	}
	else if(mo_m_ID == 4247)
	{
		UInt8 i = 0;
		for(;i < 10; ++i)
		{
			if(m_MOMap.find(mo.m_ID) != m_MOMap.end())
				++mo.m_ID;
			else
				break;
		}
		if( i == 10)
			return false;
	}
	else if(m_MOMap.find(mo.m_ID) != m_MOMap.end())
		return false;

	MapObject* mapObject = new(std::nothrow) MapObject(mo);
	if(mapObject == NULL)
		return NULL;

	m_MOMap[mo.m_ID] = mapObject;
	return true;
}

UInt32 Map::DelObject(UInt32 id, UInt16 spot)
{
	MOMap::iterator it = m_MOMap.find(id);
	if(id == 4257)
	{
		for(UInt8 i = 0; i < 20; ++i)
		{
			if(it == m_MOMap.end() || it->second->GetSpot() != spot)
				it = m_MOMap.find(++id);
			else
				break;
		}
	}
	if(id == 4247)
	{
		for(UInt8 i = 0; i < 10; ++i)
		{
			if(it == m_MOMap.end() || it->second->GetSpot() != spot)
				it = m_MOMap.find(++id);
			else
				break;
		}
	}
	if(it != m_MOMap.end())
	{
		SAFE_DELETE(it->second);
		m_MOMap.erase(it);
	}

	return id;
}

void Map::DelObjects()
{
	MOMap::iterator it;
	for(it = m_MOMap.begin(); it != m_MOMap.end(); ++it)
	{
		SAFE_DELETE(it->second);
	}
	m_MOMap.clear();
}

MapObject* Map::GetObject(UInt32 id)
{
	MOMap::iterator it = m_MOMap.find(id);
	return it != m_MOMap.end() ? it->second : NULL;
}

Map *Map::FromSpot(UInt16 spotID)
{
	UInt16 mid = spotID >> 8;
	return mapList[mid];
}

SpotData * Map::Spot(UInt16 spotID)
{
	Map * map = FromSpot(spotID);
	if(map == NULL)
		return NULL;
	return map->GetSpot(spotID);
}

Map * Map::FromID(UInt8 mapID)
{
	return mapList[mapID];
}

void Map::SendCityNPCs(Player * pl)
{
	Stream st(REP::MAPTRANSPORT);
	st << getId() << static_cast<UInt8>(0);
	UInt8 c = 0;
	MOMap::const_iterator it;
	for(it = m_MOMap.begin(); it != m_MOMap.end(); ++it)
	{
		if(it->second->IsHide())
			continue;
		UInt32 id = it->second->GetID();
		if(id <= GREAT_FIGHTER_MAX)
		{
			if(pl->hasFighter(id))
				continue;
		}
		st << it->second->GetID() << it->second->GetSpot() << it->second->GetType() << static_cast<UInt8>(0);
		++ c;
	}
	st.data<UInt8>(5) = c;
	st << Stream::eos;
	pl->second(st);
}

void Map::SendOnSpot( Player * pl)
{
	UInt16 loc = PLAYER_DATA(pl, location);
#pragma pack(push, 1)
	struct SpotPacket
	{
		UInt16 size;
		UInt16 op;
		UInt16 spotid;
	} ATTR_PACKED();
#pragma pack(pop)
	SpotPacket packet;
	packet.size = 2;
	packet.op = REP::CITY_INSIDE_MOVE<<8|0xFF;
	pl->send(&packet, 6);
}

void Map::SendOnMap( Player * pl)
{
#pragma pack(push, 1)
	struct MapPacket
	{
		UInt16 size;
		UInt16 op;
		UInt8 mapid;
	} ATTR_PACKED();
#pragma pack(pop)
	MapPacket packet;
	packet.size = 1;
	packet.op = REP::CITY_INSIDE_MOVE<<8|0xFF;
	packet.mapid = getId();
	pl->send(&packet, 5);
}

void Map::SendAtCity(Player * pl, bool inCity, bool notify)
{
	if(inCity)
		SendOnSpot(pl);
	else
		SendOnMap(pl);
	if(notify)
	{
		UInt8 c = 0;
		Stream st(REP::MAP_SAMPLEUSER);

		st << static_cast<UInt8>(0);
		for(UInt32 i = 0; i < COUNTRY_MAX && c <= MAX_NUM; ++i)
		{
			for(UInt32 j = 0; j < 2 && c <= MAX_NUM; ++j)
			{
				if(pl->getCountry() == 1)
				{
					const MapPlayer& playerList = _playerList[i][j];
					for(MapPlayer::const_iterator plIter = playerList.begin(); plIter != playerList.end() && c <= MAX_NUM; ++plIter)
					{
						Player * player = (*plIter);
						if(player != pl && (player)->isOnline())
						{
							st << player->getName() << player->getPF() << player->GetClassAndSex() << player->getCountry() << player->GetLev() << static_cast<UInt8>(PLAYER_DATA(player, status));
							++ c;
						}
					}
				}
				else if (pl->getCountry() == 0)
				{
					if(i < 2)
					{
						const MapPlayer& playerList = _playerList[1-i][j];
						for(MapPlayer::const_iterator plIter = playerList.begin(); plIter != playerList.end() && c <= MAX_NUM; ++plIter)
						{
							Player * player = (*plIter);
							if(player != pl && (player)->isOnline())
							{
								st << player->getName() << player->getPF() << player->GetClassAndSex() << player->getCountry() << player->GetLev() << static_cast<UInt8>(PLAYER_DATA(player, status));
								++ c;
							}
						}
					}
					else
					{
						const MapPlayer& playerList = _playerList[2][j];
						for(MapPlayer::const_iterator plIter = playerList.begin(); plIter != playerList.end() && c <= MAX_NUM; ++plIter)
						{
							Player * player = (*plIter);
							if(player != pl && (player)->isOnline())
							{
								st << player->getName() << player->getPF() << player->GetClassAndSex() << player->getCountry() << player->GetLev() << static_cast<UInt8>(PLAYER_DATA(player, status));
								++ c;
							}
						}
					}
				}
				else
				{
					const MapPlayer& playerList = _playerList[2-i][j];
					for(MapPlayer::const_iterator plIter = playerList.begin(); plIter != playerList.end() && c <= MAX_NUM; ++plIter)
					{
						Player * player = (*plIter);
						if(player != pl && (player)->isOnline())
						{
							st << player->getName() << player->getPF() << player->GetClassAndSex() << player->getCountry() << player->GetLev() << static_cast<UInt8>(PLAYER_DATA(player, status));
							++ c;
						}
					}
				}
			}
		}
		st.data<UInt8>(4) = c;
		st << Stream::eos;
		pl->send(st);
	}

	SpotData * sd = GetSpot(PLAYER_DATA(pl, location));
	if(sd == NULL)
		return;
	if(sd->m_IsCountryBattle && WORLD().isNewCountryBattle() && !(gClanCity && gClanCity->isOpen()))
	{
		if(sd->m_CountryBattle)
			sd->m_CountryBattle->sendInfo(pl);
	}
}

MapPlayer::iterator Map::find(UInt8 country, UInt8 status, Player* player)
{
	using namespace std::placeholders;
	MapPlayer::iterator it = std::find_if(_playerList[country][status].begin(), _playerList[country][status].end(), std::bind(find_player, _l, player));
	return it;
}

UInt32 Map::getCityPlayerNum()
{
	UInt32 count = 0;
	for(UInt32 i = 0; i < COUNTRY_MAX; i++)
	{
		for(UInt32 j = 0; j < 2; j++)
		{
			count += _playerList[i][j].size();
		}
	}

	return count;
}

void Map::Broadcast( SpotData * sd, Stream& st, Player * pl)
{
	if(sd == NULL)
		return;
	const void * buf = &st[0];
	size_t size = st.size();
	if(pl == NULL)
	{
		std::set<Player *>::iterator it;
		for(it = sd->m_Players.begin(); it != sd->m_Players.end(); ++ it)
		{
			if(*it)
				(*it)->send(buf, size);
		}
	}
	else
	{
		std::set<Player *>::iterator it;
		for(it = sd->m_Players.begin(); it != sd->m_Players.end(); ++ it)
		{
			if(*it != pl)
				(*it)->send(buf, size);
		}
	}
}

void Map::Broadcast2(const void *buf, int size, UInt8 cny, Player *pl)
{
	if(pl == NULL)
	{
		for(UInt32 j = 0; j < 2; ++j)
		{
			const MapPlayer& playerList = _playerList[cny][j];
			MapPlayer::const_iterator it;
			for(it = playerList.begin(); it != playerList.end(); ++it)
			{
				if(*it)
					(*it)->send(buf, size);
			}
		}
	}
	else
	{
		for(UInt32 j = 0; j < 2; ++j)
		{
			const MapPlayer& playerList = _playerList[cny][j];
			MapPlayer::const_iterator it;
			for(it = playerList.begin(); it != playerList.end(); ++it)
			{
				if(*it && *it != pl)
					(*it)->send(buf, size);
			}
		}
	}
}

void Map::Broadcast(const void * buf, int size, Player * pl)
{
	if(pl == NULL)
	{
		UInt32 i = mapCollection.getCountry(getId());
		{
			for(UInt32 j = 0; j < 2; j++)
			{
				const MapPlayer& playerList = _playerList[cny][j];
				MapPlayer::const_iterator it;
				for(it = playerList.begin(); it != playerList.end(); ++it)
				{
					if(*it)
						(*it)->send(buf, size);
				}
			}
		}
	}
	else
	{
		UInt32 i = mapCollection.getCountry(getId());
		{
			for(UInt32 j = 0; j < 2; j++)
			{
				const MapPlayer& playerList = _playerList[cny][j];
				MapPlayer::const_iterator it;
				for(it = playerList.begin(); it != playerList.end(); ++it)
				{
					if(*it && *it != pl)
						(*it)->send(buf, size);
				}
			}
		}
	}
}

void Map::NotifyPlayerEnter(Player *pl)
{
	GObject::Map * map = pl->GetMap();
	if(map == NULL)
		return;
	if(map != this)
		return;
	Stream st(REP::MAP_POINT_JOIN);
	st << static_cast<UInt8>(0) << pl->getName() << pl->getPF() << pl->GetClassAndSex() << pl->getCountry() << pl->GetLev() << static_cast<UInt8>(PLAYER_DATA(pl, status)) << Stream::eos;
	map->Broadcast(st, pl);
}

void Map::NotifyPlayerLeave(Player * pl)
{
	GObject::Map * map = pl->GetMap();
	if(map == NULL)
		return;
	if(map != this)
		return;
	Stream st(REP::MAP_POINT_JOIN)
	st << static_cast<UInt8>(1) << pl->getName() << Stream::eos;
	map->Broadcast(st, pl);
}

void Map::Hide(UInt32 id, bool motify)
{
	MapObject * mo = GetObject(id);
	if(mo != NULL)
	{
		mo->GetMOData().m_Hide = true;
		if(notify)
			return;
		Stream st(REP::MAP_TRANSPORT_UPDATE);
		st << static_cast<UInt8>(1) << id << mo->GetSpot() << mo->GetType() << mo->GetActionType() << Stream::eos;
		Broadcast(&st[0], st.size());
	}
}

void Map::SendHide(UInt32 id, Player * player)
{
	MapObject * mo = GetObject(id);
	if(mo != NULL)
	{
		Stream st(REP:;MAP_TRANSPORT_UPDATE);
		st << static_cast<UInt8>(1) << id << mo->GetSpot() << mo->GetType() << mo->GetActionType() << Stream::eos;
		player->send(st);
	}
}

void Map::Show(UInt32 id, bool notify, UInt8 type)
{
	MapObject * mo = GetObject(id);
	if(mo != NULL)
	{
		mo->GetMOData().m_Hide = false;
		if(!notify)
			return;
		Stream st(REP:;MAP_TRANSPORT_UPDATE);
		if(type)
			st << static_cast<UInt8>(2) << id << mo->GetSpot() << mo->GetType() << mo->GetActionType() << Stream::eos;
		else
			st << static_cast<UInt8>(2) << id << mo->GetSpot() << type << mo->GetActionType() << Stream::eos;
		Broadcast(&st[0], st.size());
	}
	
}

void Map::VistitPlayers(PlayerVisitor& visitor, UInt16 location)
{
	SpotData* spot = GetSpot(location);
	if(spot == NULL) return;

	for(std::set<Player*>::iterator iter = spot->m_Player.begin(); iter != spot->m_Player.end(); ++ iter)
	{
		if(!visitor(*iter)) return;
	}
}

UInt16 Map::GetRandomSpot(UInt8 type)
{
	std::Map<UInt16, SpotData>::iterator it;
	UInt16 count = 0;
	for ( it = m_Spots.begin(); it != m_Spots.end(); ++it)
	{
		if((it->second).m_Type ==type )
			++count;
	}

	UInt16 index = uRand(count);
	count = 0;
	for(it = m_Spots.begin(); it != m_Spots.end(); ++it)
	{
		if((it->second).m_Type ==type )
		{
			if(count ++ == index)
				return it->first;
		}
	}

	return 0;
}

}
