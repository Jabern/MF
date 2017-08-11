/*
	MINING SYSTEM FRAMEWORK - UTILS
	Last Update - 8/9/2017
	Script Version - 0.1
	Created By Amagida (2017)
*/

#include <a_samp>
#include <YSI\y_hooks>
#include <streamer>

#define PICKAXEOBJ 18635

#define MAINSTONEOBJECT 3930

#define MAX_STONES 500

#if !defined MAX_STONE_NAME
	#define MAX_STONE_NAME		(32)
#endif

enum Stone
{

Float:sX,

Float:sY,

Float:sZ,

	sClass,

Float:sHP,

Text3D:sLabel,

	sObject,

bool:SomeoneMining

}	

new Stones[MAX_STONES][Stone];


static Stone_Name[4][MAX_STONE_NAME];

new CreatedStones = 0;

/* FORWARDS */
forward CreateGoldStone(Float:x, Float:y, Float:z, name = 2);
forward CreateNormalStone(Float:x, Float:y, Float:z, name = 1);
forward SetStoneName(class, name[]);
forward GetStoneDefaultName(class, out[], length = sizeof(out));
forward GetStoneName(class, out[], length = sizeof(out));
forward CreateStone(class, Float:x, Float:y, Float:z);
forward DestroyStone(stoneid);
forward IsValidStoneID(stoneid);
<<<<<<< HEAD
=======
=======
>>>>>>> 121b88868e048d562b8105d966f50cb3c951ed47
/* END OF FORWARDS */

/* USED TOOLS */
stock Float:frandom(Float:max, Float:min = 0.0, dp = 4)
{
    new
        Float:mul = floatpower(10.0, dp),
        imin = floatround(min * mul),
        imax = floatround(max * mul);
    return float(random(imax - imin) + imin) / mul;
}
/* END OF USED TOOLS */


stock CreateStone(class,Float:x, Float:y, Float:z)
{
	if(class < 1) return printf("Class Can't Be Less Then 1!");
	CreatedStones++;
	switch(class)
	{
		case 1: CreateNormalStone(x,y,z);
		case 2: CreateGoldStone(x,y,z);
	}

	return 1;
} 


stock CreateGoldStone(Float:x, Float:y, Float:z, name = 2)
{
	
	new stonename[36];

	Stones[CreatedStones][sX] = x;

	Stones[CreatedStones][sY] = y;

	Stones[CreatedStones][sZ] = z;

	Stones[CreatedStones][sClass] = 2;

	Stones[CreatedStones][sHP] = frandom(100.0, 10.0);

	Stones[CreatedStones][sObject] = CreateDynamicObject(MAINSTONEOBJECT,x,y,z,0.000,5.000,0.000,-1,-1,-1,7777.777,7777.777);

	SetDynamicObjectMaterial(Stones[CreatedStones][sObject], 0, 16640, "a51", "concreteyellow256 copy", 0);
	
	GetStoneName(name, stonename);	
	
	printf("STONE NAME %s", stonename);

	Stones[CreatedStones][sLabel] = CreateDynamic3DTextLabel(stonename, 0xFFFF00FF, x, y, z, 15.0);

}

stock DestroyStone(stoneid)
{

	if(!IsValidStoneID(stoneid)) return printf("[MINING ERROR] Stone ID Is Not Correct");

	Stones[CreatedStones][sX] = 0.0;
	
	Stones[CreatedStones][sY] = 0.0;
	
	Stones[CreatedStones][sZ] = 0.0;

	Stones[CreatedStones][sHP] = 0.0;

	DestroyDynamicObject(Stones[CreatedStones][sObject]);

	DestroyDynamic3DTextLabel(Stones[CreatedStones][sLabel]);

	CreatedStones--;

}


stock IsValidStoneID(stoneid)
{

	if(stoneid > CreatedStones && !> 1) return true;
	else false;

}



stock CreateNormalStone(Float:x, Float:y, Float:z, name = 1)
{
	new stonename[36];

	Stones[CreatedStones][sX] = x;

	Stones[CreatedStones][sY] = y;

	Stones[CreatedStones][sZ] = z;

	Stones[CreatedStones][sClass] = 1;

	Stones[CreatedStones][sHP] = frandom(100.0, 10.0);

	Stones[CreatedStones][sObject] = CreateDynamicObject(MAINSTONEOBJECT,x,y,z,0.000,5.000,0.000,-1,-1,-1,7777.777,7777.777);
	
	GetStoneName(name, stonename);	
	
	printf("STONE NAME %s", stonename);

	Stones[CreatedStones][sLabel] = CreateDynamic3DTextLabel(stonename, 0xFFFF00FF, x, y, z, 15.0);
}


stock SetStoneName(class, name[])
{
	strcat(Stone_Name[class], name);
}


stock GetStoneName(class, out[], length = sizeof(out))
{
    if(isnull(Stone_Name[class]))
    {
        printf("[MINEING ERROR] Stone Name For Class ID: %d, Not Found! Setting Stone Name To Default!", class);
        
        GetStoneDefaultName(class, out,length);
    }
    else
    {
        strcat(out, Stone_Name[class], length);
    }
}


stock GetStoneDefaultName(class, out[], length = sizeof(out))
{
	if(class > 4) 
	{
		printf("[MINEING ERROR] Theres Class With ID %d",class);
	}
	else
	{
		switch(class)
		{
			case 1:
			{
				strcat(out, "Normal Rock",length);
			}

			case 2:
			{
				strcat(out, "Gold Ore", length);
			} 
		}
	}
}
