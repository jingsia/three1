/*************************************************************************
	> File Name: Player.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 15 Mar 2016 10:15:41 AM CST
 ************************************************************************/



class Player
{
	public:
		HoneyFall* getHoneyFall();
		void UpdatePvpRank(UInt32 goal);

	private:
		HoneyFall * m_hf;
}
