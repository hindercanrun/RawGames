--## SERVER

---- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 02 HUB*_*_*_*_*_*_*_*_*
---- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
global b_TalkedToPalmer:boolean = false;
global b_TalkedToHalsey:boolean = false;
global b_halsey_wave:boolean = false;
global b_halsey_wave2:boolean = false;
global b_palmer_wave:boolean = false;
global b_palmer_wave2:boolean = false;
global n_arbiter_advisors:number=0;
global n_medic_scenes:number=0;
global n_banshee_scenes:number=0;
global locke_banshee_scene:boolean = false;
global tanaka_banshee_scene:boolean = false;
global vale_banshee_scene:boolean = false;
global buck_banshee_scene:boolean = false;

global prepareCampsite:boolean = false;
global switchCampsite:boolean = false;

function startup.PlateauInit()
	ai_allegiance (TEAM.covenant, TEAM.player);
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_campsite);
		fade_out (0,0,0,0);
		StartW2hub1st();
	else
		print ("in editor, not starting, run StartW2hub1st to start hub mission");
	end
	
end

global W2Hub1st:table=
	{
		name = "w2_hub_1st_visit",
--		description = "World 2 Hub 1st Visit"
--		profiles = {STARTING_PROFILES.profile1, STARTING_PROFILES.profile2, STARTING_PROFILES.profile3, STARTING_PROFILES.profile4},
		--points = POINTS.points_w2hub_start,
		startGoals = {"goal_start_hub"},
		checkPoints = POINTS.points_w2hub_start,
		startFadeOut = "no",
		endFadeOut = "no",
		collectibles = {
			{objectName = "collect_arbiter", collectibleName = "sang_hub_col_arbiter"},
			{objectName = "collect_banshee", collectibleName = "sang_hub_col_banshee"},
			--{objectName = "collect_living_fallen", collectibleName = "sang_hub_col_hall"},
			{objectName = "collect_medical", collectibleName = "sang_hub_col_medic"},
--			{objectName = "collect_phantom", collectibleName = "sang_hub_col_phantom"},
			{objectName = "collect_receptacle", collectibleName = "sang_hub_col_recept"},
			{objectName = "collect_ruins", collectibleName = "sang_hub_col_ruins"},
			{objectName = "collect_statue", collectibleName = "sang_hub_col_statue"},
			{objectName = "collect_wraith", collectibleName = "sang_hub_col_wraith"},
			{objectName = "collect_door", collectibleName = "sang_hub_col_door"},
		},
	};



function blink_w2hubstart():void
     GoalBlink(W2Hub1st, "goal_halsey");
	 CreateThread(audio_campsite_stopallmusic);  --stopping all music in the event of blink
end

                                                               
-- *** START-UP ***
-- =================================================================================================


function StartW2hub1st()
	StartMission(W2Hub1st);
end


function W2Hub1st.Start()
	--starting w2hub1st

	-- disable AI dialogue
	ai_dialogue_enable(false);
	print("AI dialogue disabled");
	--CreateThread (MusketeerMovement);
end

function W2Hub1st.End()
	--destroying flocks so they don't interfere with the outro
	local fade_time:number = 1;
	fade_out (0,0,0,seconds_to_frames (fade_time));
	sleep_s (fade_time);
	flock_delete ("vig_bansh_v1_01");
	CinematicPlay("vin_campsite_outro");
	sys_LoadPlateau();
end



--  **GOALS**  
--  =====================================================================================================================

W2Hub1st.goal_start_hub = 
{
	--description = "start hub",
	zoneSet = ZONE_SETS.w2_campsite,
	next = {"goal_halsey"};

}     

function W2Hub1st.goal_start_hub.Start()
	
	SleepUntil([| AllClientViewsActiveAndStable()], 1);
	RunClientScript("client_pin_texture");
	CreateThread(StreamCampsite);
	CreateThread(SwitchCampsite);
	CinematicPlay("cin_135_arbiter");
	RunClientScript("client_unpin_texture");	
		
	--FadeOutMission();
	--switch_zone_set(ZONE_SETS.w2_campsite);<<<<--------------------When this line is UNcommented, everything is fine...
	SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.w2_campsite ], 1);
	
	SleepUntil([| AllClientViewsActiveAndStable()], 1);
	print(":::Loading Hub1st Start:::");
	
	-- turn off Temp Text
	NarrativeQueue.instance.showBlurbs = false;
	
	-- Scene start threads
	print("::: W2 Hub Narrative Start Visit 1 :::");
	NarrativeQueue.QueueConversation(W2Hub1stVisit_Ext__Scouts_at_entrance);
	NarrativeQueue.QueueConversation(W2Hub1stVisit_KUPKUP);
	NarrativeQueue.QueueConversation(W2Hub1stVisit_Cliffside_overlook);
		--Critical path
	
	CreateThread(w2_hub_guns_down);
	
	-- Ambient threads
	CreateThread(w2_hub_courier);
	CreateThread(w2_story_grunt);
	CreateThread(w2_hub1st_datapad_colors);
	CreateThread(w2hub_cliff_grunt);
	CreateThread(w2_hub_arbiter);
	CreateThread(w2_hub_medical_base);
	CreateThread(w2_hub_banshee_fix);
	CreateThread(w2_hub_wraith_base);
	CreateThread (PhantomStart);
	
	--CreateThread(w2_elitegrunt);
	CreateThread(w2_hub_elites_talk_secretively);

	-- Collectible threads

	--scout and guards thread
	CreateThread(w2hub_guards_spawn);

	--audio
	--CreateThread(audio_campsite_start);
	
	--ending goal
	GoalCompleteCurrent();
end

-----Stream w2_campsite zone set-----
function remoteServer.EnableCampsiteStream()
	prepareCampsite = true;
end

function StreamCampsite()
	SleepUntil([| prepareCampsite == true], 1);
	prepare_to_switch_to_zone_set(ZONE_SETS.w2_campsite);
end

function remoteServer.EnableCampsiteSwitch()
	switchCampsite = true;
end

function SwitchCampsite()
	SleepUntil([| switchCampsite == true], 1);
	switch_zone_set(ZONE_SETS.w2_campsite);
end



function PhantomStart()
	--start phantom vignette here
	composer_play_show("comp_phantom_1st");
	SleepUntil ([| volume_test_players (VOLUMES.tv_phantom_start) ], 2);
	b_phantom_base_wake = true;
	
	--starting birds scared by phantom
	FlockStart();
	
end

function FlockStart()
	print ("create bird flocks");
	
	flock_create ("fly_birds_phantom");
	sleep_s (1);
	flock_stop ("fly_birds_phantom");
	
end

--command script for the phantom flying away
function cs_phantomgo()
	print ("phantom go");
	local ps = POINTS.ps_phantom;
	for i = 1, #ps do
		cs_fly_to (ps[i]);
		print ("got to point ", ps[i]);
	end
	print ("flown to point");
	object_destroy(ai_vehicle_get(ai_current_actor));
	--ai_erase (ai_current_actor);
end


	

-- ===================================
-- Goal: Halsey
-- ===================================

W2Hub1st.goal_halsey = 
{
	--description = "OBJECTIVE: Talk to Halsey",
	--useObject = "devcon_ask_halsey",
	zoneSet = ZONE_SETS.w2_campsite,
	
}           

function W2Hub1st.goal_halsey.Start():void
		-- start up files in w2_plateau.lua
	print(":::Starting goal halsey:::");
	
	--fadein -- gmu OSR-148898
	Sleep (1);
	--hud_show (false);
	RunClientScript ("HudShowClient",false);
	cinematic_show_letterbox_immediate (true);
	local fade_time:number = 1;
	fade_in (0,0,0,seconds_to_frames(fade_time));
	sleep_s (fade_time);
	print ("FADE IS DONE");
	
	CreateThread (f_chapter_title, TITLES.ch_campsite_intro);

	CreateThread(W2HubHalseyStart);
	W2HubPalmer();
	
	--complete the goal
	GoalCompleteCurrent();
end   

function W2Hub1st.goal_halsey.End()
	print ("counting down to start the mission");
	CreateThread(audio_pelican_ride_startup);		-- pelican ride startup sfx
	CreateThread(audio_campsite_briefings_palmer);   
	--sleep_s (1);

	--DISPLAY 3 SECOND COUNTDOWN--
	--Hub1PelicanCountdown();
	
	--FadeOutMission();
	EndMission(W2Hub1st);
end
--TELLS PLAYERS TO GO TO Halsey
function W2HubHalseyStart()
		--turn on Halsey composition
	HalseyReceptacle();
	
	--turn on Halsey tracking, Directors want this turned on first thing (gets repeated in HubReturnDeviceControl function later)
	ObjectSetSpartanTrackingEnabled (ai_get_object (AI.sq_receptacle.sp_halsey), true);
	
	--pause for dramatic effect
	sleep_s (1.5);
	--tell players to go to Halsey (the rest of the titles, etc are in this function -- this should probably change)
	HalseyStartupVO();

	--pause for dramatic effect
	sleep_s (1.5);
	ObjectiveShow(TITLES.ch_report_to_halsey);
	
	--pause for dramatic effect
	sleep_s (6);
	
	--show tutorial to locate halsey through tracking every 60 seconds until Halsey is talked to
	CreateThread (TutorialRepeat, "training_tracking_halsey", "b_halsey_wake");
	
	--wait for players to "talk to halsey" and then tells player to go to palmer
	HubReturnDeviceControl (HalseyObjVO);
	CreateThread(audio_campsite_briefings_halsey);
	
	--VO lines post Talking to Halsey
	--add once we get lines
	VONearVol (HalseyObjVO.volume, HalseyObjVO.VOAfterObj, "b_TalkedToPalmer", 10);
	
end

function HalseyStartupVO()

	NarrativeQueue.QueueConversation(W2Hub1stVisit_Ext__Level_start);
	SleepUntil([| NarrativeQueue.HasConversationFinished(W2Hub1stVisit_Ext__Level_start) ], 15);
end


function HalseyReceptacle()
	-- start Halsey show
	composer_play_show("comp_halsey_1st");
	--object_create_anew("cr_temp_hologram");
end
  


--TELLS PLAYERS TO GO TO PALMER
function W2HubPalmer()
	W2HubPalmerComp();
	--Palmer says to see halsey until players have talked with Halsey
	VONearVol (PalmerObjVO.volume, PalmerObjVO.VOPre, "b_TalkedToHalsey");
	
	--sleep until halsey is done talking
	SleepUntil([| NarrativeQueue.HasConversationFinished(HalseyObjVO.VOObj) ], 15);
	--make this match the VO -- don't turn on the DC until the VO is done
	sleep_s (1);
	ObjectiveShow(TITLES.ch_report_to_palmer);
	LoomNextCampaignMission();
	sleep_s (6);
	
	--show tutorial to locate Palmer through tracking every 60 seconds until Palmer is talked to
	CreateThread (TutorialRepeat, "training_tracking_palmer", "b_palmer_wake");
	
	--wait for players to interact with palmer
	HubReturnDeviceControl (PalmerObjVO);

end

--this starts at the beginning of this mission
function W2HubPalmerComp()
	-- Palmer is ready to take you to the next mission
	composer_play_show("comp_palmer_visit1");
end

--
----TELLS PLAYERS TO GO TO PELICAN
--function W2HubPalmerPelican()
--	--OPEN THE PELICAN
--	print("opening the pelican and activiting the pelican device control");
--	object_set_function_variable(OBJECTS.v_pelican_flight, "bay_door", 1, 3);
--	object_wake_physics(OBJECTS.v_pelican_flight);
--end




--DEVICE FUNCTION



-- HELPER FUNCTIONS
function HubReturnDeviceControl(objTable:table)
	local dev = ObjectFromName (objTable.dev);
	local trackedObj = objTable.trackedObj;
	local vol = objTable.volume;
	
--	local state:table = {near = false};
--	composer_play_show (objTable.show, state);
	--turn on tracking and the device
	device_set_power (dev, 1);
--	navpoint_track_object (dev, true);
	SleepUntil ([| object_index_valid (trackedObj())], 1);
	ObjectSetSpartanTrackingEnabled (trackedObj(), true);
	RegisterSpartanTrackingPingObjectEvent(TrackingOnPing, trackedObj());
	objects_attach (trackedObj(), "target_main", dev, "");
	game_save_no_timeout();
	
	--check if the player is in volume and play the VO, end once the control is activated
	repeat
		SleepUntil ([| volume_test_players (vol) ], 10);
		if not NarrativeQueue.IsConversationQueued(objTable.VONearby) then
			print ("should play VO nearby");
			NarrativeQueue.QueueConversation(objTable.VONearby);
		else
			print ("not playing VO Nearby because it's already playing");
		end
		--wait until a player presses X or out of volume, if pressed X continue on
		SleepUntil ([| (not volume_test_players (vol) or DeviceUsed(dev) )], 3);
	until DeviceUsed(dev);
	
	--turn off the blip
--	navpoint_track_object (dev, false);
	ObjectSetSpartanTrackingEnabled (trackedObj(), false);
	UnregisterSpartanTrackingPingObjectEvent(TrackingOnPing, trackedObj());
	
	--turn off the device just in case
	device_set_power (dev, 0);
	
	--turn off any tutorials
	TutorialStopAll();
	
	--state.near = true;
	--play the objective VO	
	NarrativeQueue.QueueConversation(objTable.VOObj);
	SleepUntil([| NarrativeQueue.HasConversationFinished(objTable.VOObj) ], 15);
	sleep_s (0.5);
end

function DeviceUsed(dev:object):boolean
	if device_get_position (dev) > 0 then
		return true;
	end
end

function VONearVol(vol:volume, VO:table, ending:string, sleepTime:number)
	--tell players to go to next objective
	repeat
		--wait until players are out of volume
		SleepUntil ([| not volume_test_players (vol) or _G[ending]], 10);
		SleepUntil ([| volume_test_players (vol) or _G[ending]], 10);
		--remove from queue somehow
		if not _G[ending] then
			print ("vo pre or post obj playing");
			NarrativeQueue.QueueConversation(VO);
			SleepUntil([| NarrativeQueue.HasConversationFinished(VO) ], 15);
			sleep_s (sleepTime);
		end
	until _G[ending];
	print (ending, " is true");
end

--shows the tutorial text to talk to the NPC's on a loop until talking to the NPC
function TutorialRepeat(text:string, ending:string)
	repeat
		TutorialShowAll (text, 15);
		sleep_s (60);
	until _G[ending];
end

--stops the tutorial playing on a client if they ping while the tutorial text is up
function TrackingOnPing(playerUnit:object, PingedObj:object):void
	print(PingedObj, " was pinged by ", playerUnit);
	TutorialStop(unit_get_player(playerUnit));
end

--musketeer movement
--called from the musketeer objective
function musketeerhelperhalsey()
	MusketeerUtil_SetMusketeerGoal(FLAGS.fl_musketeer_halsey, 5);
	for _,musk in ipairs (ai_actors(GetMusketeerSquad())) do
		MusketeerDestAddWayPoint (musk, FLAGS.fl_musketeer_halsey01);
		MusketeerDestAddWayPoint (musk, FLAGS.fl_musketeer_halsey02);
		MusketeerDestAddWayPoint (musk, FLAGS.fl_musketeer_halsey03);
	end
end

function musketeerhelperpalmer()
	MusketeerUtil_SetMusketeerGoal(FLAGS.fl_musketeer_palmer, 5);
end

function MusketeerMovement()
	--sleepuntil player walks down path
	SleepUntil ([| volume_test_players (VOLUMES.tv_musketeer_movement02)], 10);
	
	--musketeers go to middle by Halsey
	print ("musketeers are going to Halsey");
	MusketeerUtil_SetMusketeerGoal (FLAGS.fl_musketeer_halsey, 3);
	
	--sleepuntil player talks to Halsey
	SleepUntil ([| b_TalkedToHalsey], 10);
	
	--musketeers go to pelican by Palmer
	print ("musketeers are going to Palmer");
	MusketeerUtil_SetMusketeerGoal (FLAGS.fl_musketeer_palmer, 3);
end

--  =================================================================================
--  AUDIO
--  =================================================================================


function audio_pelican_ride_startup():void
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_pelican\018_vin_cp_w2plateau_pelican_rideics_startup.sound'), nil, 1);
end

function audio_missionstart_countdown():void
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_missionstart_countdown.sound'), nil, 1);
end

function audio_cinematic_mute_campsite()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--  =================================================================================
--  CLIENT SCRIPTS
--  =================================================================================
--## CLIENT
function remoteClient.client_pin_texture():void
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_rock_plating_a\materials\sanp_organic_rock_plating_a_03.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_rock_plateau_column_b\sanp_organic_rock_plateau_column_b.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_damaged_a\sanp_building_monolith_tower_damaged_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_a\sanp_building_monolith_tower_b.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_a\sanp_building_monolith_tower_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_entry_large_a\materials\sanp_building_entry_large_a_01_c.material'));
	streamer_pin_tag(TAG('levels\campaignworld020\w2_terrain\w2_plateau_generic_terrain\materials\sanp_plateau_caverns_generic.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_arbiter_tent\cov_arbiter_tent_top.material'));
	streamer_pin_tag(TAG('levels\campaignworld020\w2_terrain\w2_plateau_generic_terrain\materials\sanp_plateau_caverns_cin.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_rough_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_blend_sediment_rough_wall_test_.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_plateau_wall_tile_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_ring_a\sanp_building_monolith_ring_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_plants_a_anim.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_plant_grass_cliff_a\material\sanp_organic_plant_grass_cliff_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_a\bitmaps\cin135_tent_drape_set_a.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_b\bitmaps\cin135_tent_drape_set_b.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_c\bitmaps\cin135_tent_drape_set_c.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_d\bitmaps\cin135_tent_drape_set_d.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_e\bitmaps\cin135_tent_drape_set_e.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_f\bitmaps\cin135_tent_drape_set_f.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_h\bitmaps\cin135_tent_drape_set_h.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_g\bitmaps\cin135_tent_drape_set_g.material'));
end

function remoteClient.client_unpin_texture():void
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_rock_plating_a\materials\sanp_organic_rock_plating_a_03.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_rock_plateau_column_b\sanp_organic_rock_plateau_column_b.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_damaged_a\sanp_building_monolith_tower_damaged_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_a\sanp_building_monolith_tower_b.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_tower_a\sanp_building_monolith_tower_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_entry_large_a\materials\sanp_building_entry_large_a_01_c.material'));
	streamer_unpin_tag(TAG('levels\campaignworld020\w2_terrain\w2_plateau_generic_terrain\materials\sanp_plateau_caverns_generic.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_arbiter_tent\cov_arbiter_tent_top.material'));
	streamer_unpin_tag(TAG('levels\campaignworld020\w2_terrain\w2_plateau_generic_terrain\materials\sanp_plateau_caverns_cin.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_rough_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_blend_sediment_rough_wall_test_.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_rock_plateau_wall_tile_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\sangheli\planet_sanghelios\sanp_building_monolith_ring_a\sanp_building_monolith_ring_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\material_tiles\organic\planet_sanghelios\sanp_organic_plants_a_anim.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\prefabs\organic\planet_sanghelios\sanp_organic_plant_grass_cliff_a\material\sanp_organic_plant_grass_cliff_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_a\bitmaps\cin135_tent_drape_set_a.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_b\bitmaps\cin135_tent_drape_set_b.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_c\bitmaps\cin135_tent_drape_set_c.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_d\bitmaps\cin135_tent_drape_set_d.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_e\bitmaps\cin135_tent_drape_set_e.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_f\bitmaps\cin135_tent_drape_set_f.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_h\bitmaps\cin135_tent_drape_set_h.material'));
	streamer_unpin_tag(TAG('levels\assets\osiris\props\cinematics\cin135_tent_drape_set_g\bitmaps\cin135_tent_drape_set_g.material'));
end