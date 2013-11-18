	#define DEBUG

//	shows "Test Server" in the title bar
	#define DEVMODE false

//	shows "Official Server" in the title bar
	#define OFFICIALSERVER true
	#define BUILD 6030

//	Set this instead of the var to get a warning
	#define MAPSAVE	ALL_FLAG

	#define PLAYERSAVE true

//	Experimental
	#define LIGHTING false
	#define ITEM_DECAY true
	#define ITEM_DURABILITY true
	#define ITEM_WEIGHT true
	#define WORK_STAMINA true
	#define FURN_GRAB true

#if !MAPSAVE
	#warning - Map Save is OFF!
#endif

#if !PLAYERSAVE
	#warning - Player Saving is OFF!
#endif


#if DEVMODE
	#warning - Development Mode enabled
#endif

#if !OFFICIALSERVER
	#warning - Unofficial Server build
#endif

#if LIGHTING
	#warning - Lighting is ON!
#endif

#if !PIXEL_MOVEMENT
	#warning - Pixel movement is OFF!
#endif