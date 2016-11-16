/*************************************************************************
	> File Name: ObjectBase.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Mar 2016 01:43:15 PM CST
 ************************************************************************/
#ifndef _OBJECTBASE_H_
#define _OBJECTBASE_H_

namespace GData
{
	template<typename _OKT = UInt32>
	class ObjectBaseT
	{
	public:
		ObjectBaseT(_OKT id, std::string& name = ""):_id(id), _name(name){}
		inline const _OKT getId() const {return _id;}
		inline const std::string getName() const { return _name;};
		inline void std::string setName(const std::string& n) {_name = n;}
	protected:
		_OKT _id;
		std::string _name;
	};

	template<typename _OKT = UInt32>
	class ObjectBaseNT
	{
	public:
		ObjectBaseNT(UInt32 id):_id(id){}
		inline const getId() const {return _id;}
	protected:
		_OKT _id;
	}
}
