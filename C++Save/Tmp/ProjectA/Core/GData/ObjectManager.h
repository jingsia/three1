/*************************************************************************
	> File Name: ObjectManager.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Mar 2016 05:08:13 PM CST
 ************************************************************************/

#ifndef _OBJECTMANAGER_H_
#define _OBJECTMANAGER_H_

#include "Common/Singleton.h"
#include "ObjectBase.h"
#include "Common/Mutex.h"

nampespace GData
{
	template<typename _OIT = ObjectBase<>, typename _OKT = UInt32 >
	class ObjectMapT:
		public Singleton<ObjectMapT<_OIT, _OKT>>
	{
		typedef std::map<_OKT, _OIT *> ObjMap;
		typedef ObjMap::const_iterator const_obj_iterator;
	
	public:
		void add(_OIT * item)
		{
			_objs[item->getId()] = item;
		}

		void add(_okt& key, _OIT * elem)
		{
			_objs[key] = elem;
		}
		const _OIT * operator [](_OKT key)
		{
			const_obj_iterator it;
			for(it = _objs.begin(); it != _objs.end(); ++it)
			{
				if(it == _objs.end())
					return NULL;

				return it->second;
			}
		}
		typedef bool (*EnumCB)(const _OKT&, const _OIT *, void *);

		void enumerate(EnumCB cb, void * param)
		{
			typename ObjMap::const_iterator it;
			for(it = _objs.begin(); it != _objs.end();++it)
			{
				if(!cb(it->first, it->second, param))
					break;
			}
		}
		int size() {return _objs.size();}

	protected:
		ObjMap _objs;
	};

	template<typename _OIT = ObjectBaseT<> >
	class ObjectListT:
		public Singleton<ObjectListT<_OIT>>
	{
	
		typedef std::deque<_OIT *> ObjList;
		typedef typename ObjList::const_iterator const_obj_iterator;
	public:
		void add(_OIT * item)
		{
			if(_objs.size() <= item->getId())
				_objs.resize((item->getId() + 0x40) & ~0x3F);
			_objs[item->getId()] = item;
		}

		const _OIT * operator [] (UInt32 key)
		{
			if(key >= _objs.size())
				return NULL;
			return _objs[key];
		}

		typename bool (*EnumCB)(const _OIT *, void *);
		void enumerate(EnumCB cb, void * param)
		{
			typename ObjList::const_iterator it;
			for(it = _objs.begin(); it != _pbjs.end() ; ++it)
			{
				if(*it == NULL)
					continue;
				if(!cb(*it, param))
					break;
			}
		}

	protected:
		ObjList _objs;
	};
}

