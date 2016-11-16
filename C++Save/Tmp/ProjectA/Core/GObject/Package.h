/*************************************************************************
	> File Name: Package.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 21 Mar 2016 09:58:13 AM CST
 ************************************************************************/

#ifndef _PACKAGE_H_
#define _PACKAGE_H_

namespace GObject
{

	struct LingbaoSmeltInfo
	{
		UInt16 gujiId;
		UInt16 itemId;
		UInt32 value;
		UInt32 maxValue;
		UInt8 bind;
		UInt8 counts;
		UInt8 purpleAdjVal;
		UInt8 orangeAdjVal;

		LingbaoSmeltInfo() : gujiId(0), itemId(0), value(0), maxValue(0), bind(0), counts(0), purpleAdjVal(0), orangeAdjVal(0) {}

		const LingbaoSmeltInfo& operator=(LingbaoSmeltInfo& other)
		{
			gujiId = other.gujiId;
			itemId = other.itemId;
			value = other.value;
			maxValue = other.maxValue;
			bind = other.bind;
			counts = other.counts;
			purpleAdjVal = other.purpleAdjVal;
			orangeAdjVal = other.orangeAdjVal;

			return *this;
		}
	};

}
