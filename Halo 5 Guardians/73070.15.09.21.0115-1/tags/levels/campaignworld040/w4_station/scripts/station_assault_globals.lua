--## SERVER

global AssaultOnTheStation:table=
	{
		name = "w4_station_assault",
	
		mybreadCrumbs = { 

			},
		--description = "Chief is on a Search and Destroy mission on ONI Station Argent Moon",
		--profiles = {STARTING_PROFILES.default_chief, STARTING_PROFILES.default_musk_1, STARTING_PROFILES.default_musk_2, STARTING_PROFILES.default_musk_3},
		points = POINTS.ps_ass_stat_insertion,
		startFadeOut = "no",
		startGoals = {"goal_intro_halls"},
		 collectibles = {     
                       {objectName="w1_assaultunsc_datapad_01", collectibleName="w4_assault_collectible_1"},
                        {objectName="w1_assaultunsc_datapad_02", collectibleName="w4_assault_collectible_2"},
                        {objectName="w1_assaultunsc_datapad_03", collectibleName="w4_assault_collectible_3"},
                       {objectName="w1_assault_ship_audiolog", collectibleName="w4_assault_collectible_4"},
                     {objectName="w1_assault_stationlog_01", collectibleName="w4_assault_collectible_5"},
                     {objectName="w1_assault_stationlog_02", collectibleName="w4_assault_collectible_6"},
                        {objectName="w1_assault_stationlog_03", collectibleName="w4_assault_collectible_7"},
                        {objectName="w1_assault_stationlog_04", collectibleName="w4_assault_collectible_8"},
                        {objectName="w1_assault_stationlog_05", collectibleName="w4_assault_collectible_9"},
                        {objectName="skull_assault", collectibleName="collectible_skull_blackeye"},
                        },
	}

function StartAssaultOnTheStation()
	StartMission( AssaultOnTheStation );
end

function AssaultOnTheStation.Start()

	 
end

function AssaultOnTheStation.End()
	print ("ending assault on the station");
	print ("starting W1 Hub: Meridian");	
	fade_out( 0, 0, 0, 60 );
	sleep_s(1.1);
	ai_erase( AI.sg_hangar_all );
	object_destroy_folder( "crs_hangar" );
	--Switch Zonesets before starting the loom
	switch_zone_set(ZONE_SETS.cin050_exterior);
	LoomNextCampaignMission();
	CinematicPlay ("cin_050_awol");
	--set the mission global
	SetGlobalFlag ("AssaultOnTheStation_complete");
	sleep_s(0.25);
	sys_LoadCin_060();
end

