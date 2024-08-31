--## SERVER

--[[
████████╗███████╗██╗   ██╗███╗   ██╗ █████╗ ███╗   ███╗██╗    ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
╚══██╔══╝██╔════╝██║   ██║████╗  ██║██╔══██╗████╗ ████║██║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
   ██║   ███████╗██║   ██║██╔██╗ ██║███████║██╔████╔██║██║    ███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║
   ██║   ╚════██║██║   ██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║    ╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
   ██║   ███████║╚██████╔╝██║ ╚████║██║  ██║██║ ╚═╝ ██║██║    ███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
------------------------------------------------------------------------------------
--]]
global g_ics_player:object = nil;
global tsunami_startup:number=0;
global palmer_arrival:number=0;
global ff_objcon:number=0;
global v_ub2_objcon:number=0;
global intro_objcon:number=0;
global b_topwater_on:boolean=false;
global b_botwater_on:boolean=false;
global b_tsu_collectible_1:boolean = false;
global b_tsu_collectible_2:boolean = false;
global b_tsu_collectible_3:boolean = false;
global b_tsu_collectible_4:boolean = false;
global b_tsu_collectible_5:boolean = false;
global b_tsu_collectible_6:boolean = false;
global b_tsu_collectible_7:boolean = false;
global b_tsu_collectible_8:boolean = false;
global b_tsu_collectible_9:boolean = false;
global b_tsu_collectible_10:boolean = false;
global b_tsu_collectible_11:boolean = false;
global b_tsu_collectible_12:boolean = false;
global b_tsu_collectible_13:boolean = false;
global var_elevator1_state = 0;
global var_elevator2_state = 0;
global ub1_objcon:number = 0;
global b_guardian_phase2:boolean=false;
global b_hunter_form_now:boolean=false
global b_hunter_form_now_2:boolean=false
global ff_arbiterfollow:boolean=false;
global ff_arbiterstayback:boolean=false;
global finalfight_encounter_end:boolean=false;
global ff_finalchaser:boolean=false;
global ff_cavalierarrival:boolean=false;
global b_fft_arbyfollow:boolean=false;
global var_ff_objcon:number = 0;
global b_turrettown_enemy_limit:number=8;
global b_arcade_go:boolean=false;
global b_guardian_rise:boolean = false;
global b_arb_kills_knight:boolean=false;
global thread_deathcube:thread = nil;
global thread_slide:thread=nil;
global thread_rescuebox:thread = nil;

global v_is_demo:boolean = false;
global demo_crawlers_respawn:boolean = true;
global demo_soldiers_respawn:boolean = true;
global demo_knights_respawn:boolean = true;

--Zoneset streaming stuff so we don't go out of sync
global prepareToSwitch_cin155:boolean = false;
global prepareToSwitch_intro:boolean = false;
global switchZoneSet_cin155:boolean = false;
global switchZoneSet_intro:boolean = false;

--[[
███████╗████████╗ █████╗ ██████╗ ████████╗██╗   ██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
███████╗   ██║   ███████║██████╔╝   ██║   ██║   ██║██████╔╝    ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██║   ██║██╔═══╝     ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
███████║   ██║   ██║  ██║██║  ██║   ██║   ╚██████╔╝██║         ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝         ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Table and Startup Scripts
------------------------------------------------------------------------------------
--]]

global w2_tsunami_station:table=
	{
		name = "w2_tsunami_station",
		description = "",
		profiles = {STARTING_PROFILES.profile1, STARTING_PROFILES.profile2, STARTING_PROFILES.profile3, STARTING_PROFILES.profile4},
		--points = POINTS.ps_lockestart,
		--Starting 1st Goal--
		startGoals = {"goal_start"},
		collectibles = {
						{objectName="w2_tsu_skull", collectibleName="collectible_skull_cowbell"},
						{objectName="tsu_collect_01", collectibleName="tsu_collect_01"},
						{objectName="tsu_collect_02", collectibleName="tsu_collect_02"},
						{objectName="tsu_collect_03", collectibleName="tsu_collect_03"},
						{objectName="tsu_collect_04", collectibleName="tsu_collect_04"},
						{objectName="tsu_collect_05", collectibleName="tsu_collect_05"},
						--	{objectName="tsu_collect_06", collectibleName="tsu_collect_06"},		DELETED
						--	{objectName="tsu_collect_07", collectibleName="tsu_collect_07"},		DELETED
						{objectName="tsu_collect_08", collectibleName="tsu_collect_08"},
						{objectName="tsu_collect_09", collectibleName="tsu_collect_09"},
						{objectName="tsu_collect_10", collectibleName="tsu_collect_10"},
						}
	}

function startup.locke_tsunami()
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_tsunami);
		StartTsunamiStation();
	end
	print("Locke Tsunami Mission Started Up!");
	
end

function StartTsunamiStation()
	fade_out(0,0,0,0);
	StartMission(w2_tsunami_station);
end

--//=========//	Overall Mission Start and Endgame functions	//=========//--

function w2_tsunami_station.Start()
		print ("Locke Tsunami .start ");
		ai_allegiance (TEAM.covenant_player, TEAM.player);
		ai_allegiance (TEAM.player, TEAM.covenant_player);
		kill_volume_disable(VOLUMES.kill_destruction_kill_zone);
		-- NARRATIVE CALL
		CreateThread (tsunami_narrative_startup);
end

function w2_tsunami_station.End()
	print ("Locke Tsunami End");
	SetGlobalFlag("TsunamiLocke_complete");
	print ("end of Locke Tsunami");
	if not editor_mode() then
		sys_LoadArrival();
	else
		print ("in editor not loading the next level (forerunner arrival)");
	end
end

--[[
███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗    ███████╗████████╗ █████╗ ██████╗ ████████╗
████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝
██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║    ███████╗   ██║   ███████║██████╔╝   ██║   
██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║    ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   
██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║    ███████║   ██║   ██║  ██║██║  ██║   ██║   
╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
Mission Start
------------------------------------------------------------------------------------
--]]

w2_tsunami_station.goal_start = 
{
	--description = "TEMP DESC - Mission Start",
	gotoVolume = VOLUMES.tv_end_missionstart,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_intro,	
	next = {"goal_burgertown"};
	startFadeOut = "yes"
}

function w2_tsunami_station.goal_start.Start():void

	--Create threads for zoneset swapping in the intro cinematic
	CreateThread(ServerCommandToPrepareZoneSet_cin155);
	CreateThread(ServerCommandToSwitchZoneSet_cin155);
	CreateThread(ServerCommandToPrepareZoneSet_intro);
	CreateThread(ServerCommandToSwitchZoneSet_intro);

	RunClientScript("client_pin_155_textures");														--		drastic measure for ZBR 8/16/15
	CinematicPlay ("cin_155_sunaion");											--	--	--	--	--		Opening Cinematic (cin_155_sunaion)
	RunClientScript("client_unpin_155_textures");

	CreateThread (player_start);
	switch_zone_set (ZONE_SETS.w2_tsunami_intro);
--	_G.render_decals = false;																	--		drastic measure for UR 3/26/15
	SleepUntil ([| player_valid_count() > 0 ], 1);
	CreateThread(aa_fx_sequence_intro);
	CreateThread(musk_intro);
	object_create_folder(MODULES.cr_weap_intro);
	object_create_folder (MODULES.cr_turret0);
	CreateThread (theater_of_war);
	CreateThread (dogfight_05);
	CreateThread (tsunami_theater_intro);
	CreateThread (tsunami_theater_burger);
	CreateThread (ff_arbiter_replacemecator);
	CreateThread ( ff_arbiter_catcher );
	CreateThread (tsunami_theater_turret);
	CreateThread (tsunami_theater_slip);
	CreateThread (missionstart_spawner);
	--object_create_folder (MODULES.cr_turret_powersources);
	object_create("dm_tsu_door_01");
	CreateThread (tsu_door_checker);
--	CreateThread (shriketurret_animate, OBJECTS.dm_shriketurret_00, OBJECTS.shrike_power_source_0);
	--	NARRATIVE CALL
	CreateThread (tsunami_missionstart_load);
--	CreateThread (dogfight_06);
	CreateThread (dogfight_07);
	CreateThread (audio_mission_start);
	CreateThread (cruiser_crash);
	CreateThread (track_burgertown);
	Sleep(5);
	CreateThread(intro_objcon_10);
	CreateThread(intro_objcon_20);
	CreateThread(intro_objcon_30);
	CreateThread(intro_grunt_scramble);
	thread_rescuebox = CreateThread(rescuebox_intro);
	game_save_immediate();			--tjp 8/27/2015 DEFCON 5
end

--Functions for controlling zoneset swaps in the intro cinematic
function remoteServer.FlipStreamingBoolean_cin155()
	prepareToSwitch_cin155 = true;
end

function ServerCommandToPrepareZoneSet_cin155()
	SleepUntil([| prepareToSwitch_cin155 == true], 1);
	print ("PREPARING TO SWITCH TO CIN 155")
	print ("PREPARING TO SWITCH TO CIN 155")
	print ("PREPARING TO SWITCH TO CIN 155")
	print ("PREPARING TO SWITCH TO CIN 155")
	print ("PREPARING TO SWITCH TO CIN 155")
	prepare_to_switch_to_zone_set(ZONE_SETS.cin_155);
end

function remoteServer.FlipZonsetSwitchBoolean_cin155()
	switchZoneSet_cin155 = true;
end

function ServerCommandToSwitchZoneSet_cin155()
	SleepUntil([| switchZoneSet_cin155 == true], 1);
	print ("SWITCHING TO CIN 155")
	print ("SWITCHING TO CIN 155")
	print ("SWITCHING TO CIN 155")
	print ("SWITCHING TO CIN 155")
	print ("SWITCHING TO CIN 155")
	switch_zone_set(ZONE_SETS.cin_155)
end

function remoteServer.FlipStreamingBoolean_intro()
	prepareToSwitch_intro = true;
end

function ServerCommandToPrepareZoneSet_intro()
	SleepUntil([| prepareToSwitch_intro == true], 1);
	print ("PREPARING TO SWITCH TO INTRO")
	print ("PREPARING TO SWITCH TO INTRO")
	print ("PREPARING TO SWITCH TO INTRO")
	print ("PREPARING TO SWITCH TO INTRO")
	print ("PREPARING TO SWITCH TO INTRO")
	prepare_to_switch_to_zone_set(ZONE_SETS.w2_tsunami_intro);
end

function remoteServer.FlipZonesetSwitchBoolean_intro()
	switchZoneSet_intro = true;
end

function ServerCommandToSwitchZoneSet_intro()
	SleepUntil([| switchZoneSet_intro == true], 1);
	print ("SWITCHING TO INTRO")
	print ("SWITCHING TO INTRO")
	print ("SWITCHING TO INTRO")
	print ("SWITCHING TO INTRO")
	print ("SWITCHING TO INTRO")
	switch_zone_set(ZONE_SETS.w2_tsunami_intro);
end
--End functions for controlling zoneset swaps in the intro cinematic

function musk_intro():void
		CreateThread(muskbox, VOLUMES.mxv_1, FLAGS.mxf_1a, 2, FLAGS.mxf_1b, 2, w2_tsunami_station.goal_start);
		CreateThread(muskbox, VOLUMES.mxv_2, FLAGS.mxf_2a, 2, FLAGS.mxf_2b, 2, w2_tsunami_station.goal_start);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mxv_3, FLAGS.mxf_3a, 2, FLAGS.mxf_3b, 2, w2_tsunami_station.goal_start);
		CreateThread(muskbox, VOLUMES.mxv_4, FLAGS.mxf_4a, 2, FLAGS.mxf_4b, 2, w2_tsunami_station.goal_start);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mxv_5, FLAGS.mxf_5a, 2, FLAGS.mxf_5b, 2, w2_tsunami_station.goal_start);
		CreateThread(muskbox, VOLUMES.mxv_6, FLAGS.mxf_6a, 2, FLAGS.mxf_6b, 2, w2_tsunami_station.goal_start);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mxv_7, FLAGS.mxf_7a, 2, FLAGS.mxf_7b, 2, w2_tsunami_station.goal_start);
		CreateThread(muskbox, VOLUMES.mxv_8, FLAGS.mxf_8a, 2, FLAGS.mxf_8b, 2, w2_tsunami_station.goal_start);
end
function player_start():void
-- DELETE ME WHEN POSSIBLE
	-- fade_out(0,0,0,0);
	player_control_fade_out_all_input(0);
	SleepUntil(	[|	ai_living_count(AI.gr_turret0_all) >= 3
				and	object_valid("dm_shriketurret_01")
				],1);
	player_control_fade_in_all_input(0);
		for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
			object_teleport(obj, FLAGS.fl_musk_start);
		end
	fade_in(0,0,0, seconds_to_frames(1));
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen_off.sound'), nil, 1);
	-- fade_in(0,0,0,0);
	CreateThread (title_ambient_titanattsunaion);
	CreateThread (lich_dropoff);
	sleep_s(4);
	CreateThread(title_objective_defense);																-- "BOARD GUARDIAN"
end
function track_intro_aa():void																			-- called from dialog script
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_00, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_0, true);
	SleepUntil(		[| b_shrike_0 == false
					or IsGoalActive(w2_tsunami_station.goal_start) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_00, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_0, false);
end
function intro_objcon_10():void
	SleepUntil([|	(volume_test_players(VOLUMES.tv_turr0_objcon_10))
				or	(ai_living_count(AI.gr_turret0_all) <= (var_intro_ai_count - 2))
				], 2);
	if(intro_objcon <= 10)then
		intro_objcon = 10;
	end
end
function intro_objcon_20():void
	SleepUntil([|	(volume_test_players(VOLUMES.tv_turr0_objcon_20))
				or	(ai_living_count(AI.gr_turret0_all) <= (var_intro_ai_count - 4))
				], 2);
	if(intro_objcon <= 20)then
		intro_objcon = 20;
	end
end
function intro_objcon_30():void
	SleepUntil([|	(volume_test_players(VOLUMES.tv_turr0_objcon_30))
				or	(ai_living_count(AI.gr_turret0_all) <= (var_intro_ai_count - 6))
				], 2);
	if(intro_objcon <= 30)then
		intro_objcon = 30;
	end
end

function goose_arbiter():void			-- this... it shouldn't be like this.
	damage_object(ai_get_object(AI.sq_turr0_arbiter_a.spawnpoint81), "default", 10);
end

function ff_arbiter_catcher()
		repeat
			SleepUntil([| volume_test_objects( VOLUMES.tv_arby_catcher,  AI.sq_turr0_arbiter_a.spawnpoint81) or b_arbycanleave ], 2);
				if not b_arbycanleave then
					object_teleport( AI.sq_turr0_arbiter_a.spawnpoint81, FLAGS.fl_arby_teleporter );
				end
		until b_arbycanleave;
end

function ff_arbiter_replacemecator():void
	repeat
		SleepUntil([| ai_living_count(AI.sq_turr0_arbiter_a.spawnpoint81) <= 0], 30);
		Sleep(2);
		if(b_arbycanleave ~= true)then
			ai_place(AI.sq_turr0_arbiter_a.spawnpoint81);
			object_create_if_necessary ("w_arbysword");
			unit_add_weapon (AI.sq_turr0_arbiter_a.spawnpoint81, OBJECTS.w_arbysword, 2);
		end
	until	(	IsGoalActive(w2_tsunami_station.goal_start) == false
			or	b_arbycanleave == true
			);
end
function w2_tsunami_station.goal_start.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Start - Complete!");	
end
function rescuebox_intro():void
	repeat
	for _, spartan in ipairs (spartans()) do
		if	(volume_test_object(VOLUMES.tv_rescue_intro, spartan))
		then
				object_teleport(spartan, FLAGS.fl_safety_intro);
				Sleep(2);
				print("knock that off aubrey!");
				game_save_no_timeout();
		end
		Sleep(10);
	end
	Sleep(10);
	until(false);
end

--[[
██████╗ ██╗   ██╗██████╗  ██████╗ ███████╗██████╗     ████████╗ ██████╗ ██╗    ██╗███╗   ██╗
██╔══██╗██║   ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗    ╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
██████╔╝██║   ██║██████╔╝██║  ███╗█████╗  ██████╔╝       ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
██╔══██╗██║   ██║██╔══██╗██║   ██║██╔══╝  ██╔══██╗       ██║   ██║   ██║██║███╗██║██║╚██╗██║
██████╔╝╚██████╔╝██║  ██║╚██████╔╝███████╗██║  ██║       ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝       ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
Burger Town
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_burgertown = 
{
	--description = "TEMP DESC - Burger Town",
	gotoVolume = VOLUMES.tv_burgertown_complete,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_burgertown,
	next = {"goal_tangletown"};
}

function w2_tsunami_station.goal_burgertown.Start():void
--	CreateThread (shriketurret_animate, OBJECTS.dm_shriketurret_01, OBJECTS.shrike_power_source_1);
	CreateThread (burgertown);
end

function track_burgertown():void
	--	Starting up blip to Burgertown
	SleepUntil ([| device_get_position (OBJECTS.dm_tsu_door_01) > 0.0
				or	IsGoalActive(w2_tsunami_station.goal_start) == false
				], 5);
	sleep_s (1);
	CreateThread(musk_burger);
	object_create ("tracking_to_burgertown");
	object_create ("tracking_cache_burgertown");
	object_create ("tracking_cache_burgertown_2");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_off)
				or	(	IsGoalActive(w2_tsunami_station.goal_start) == false
					and IsGoalActive(w2_tsunami_station.goal_burgertown) == false
					)
				], 5);
	object_destroy (OBJECTS.tracking_to_burgertown);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_01, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_1, true);
	SleepUntil(		[| b_shrike_1 == false
					or IsGoalActive(w2_tsunami_station.goal_burgertown) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_01, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_1, false);
	object_create ("tracking_to_tangletown");
	SleepUntil(		[| volume_test_players(VOLUMES.tv_burgertown_complete)
					or IsGoalActive(w2_tsunami_station.goal_burgertown) == false
					], 5);
	object_destroy (OBJECTS.tracking_to_tangletown);
	object_destroy (OBJECTS.tracking_cache_burgertown);
	object_destroy (OBJECTS.tracking_cache_burgertown_2);
end
function musk_burger():void
		CreateThread(muskbox, VOLUMES.mxv_bt1, FLAGS.mxf_bt1a, 2, FLAGS.mxf_bt1b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt2, FLAGS.mxf_bt2a, 2, FLAGS.mxf_bt2b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt3, FLAGS.mxf_bt3a, 2, FLAGS.mxf_bt3b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt4, FLAGS.mxf_bt4a, 2, FLAGS.mxf_bt4b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt5, FLAGS.mxf_bt5a, 2, FLAGS.mxf_bt5b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt6, FLAGS.mxf_bt6a, 2, FLAGS.mxf_bt6b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt7, FLAGS.mxf_bt7a, 2, FLAGS.mxf_bt7b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt8, FLAGS.mxf_bt8a, 2, FLAGS.mxf_bt8b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt9, FLAGS.mxf_bt9a, 2, FLAGS.mxf_bt9b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt10, FLAGS.mxf_bt10a, 2, FLAGS.mxf_bt10b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt11, FLAGS.mxf_bt11a, 2, FLAGS.mxf_bt11b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt12, FLAGS.mxf_bt12a, 2, FLAGS.mxf_bt12b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt13, FLAGS.mxf_bt13a, 2, FLAGS.mxf_bt13b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt14, FLAGS.mxf_bt14a, 2, FLAGS.mxf_bt14b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt15, FLAGS.mxf_bt15a, 2, FLAGS.mxf_bt15b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt16, FLAGS.mxf_bt16a, 2, FLAGS.mxf_bt16b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt17, FLAGS.mxf_bt17a, 2, FLAGS.mxf_bt17b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt18, FLAGS.mxf_bt18a, 2, FLAGS.mxf_bt18b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt19, FLAGS.mxf_bt19a, 2, FLAGS.mxf_bt19b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt20, FLAGS.mxf_bt20a, 2, FLAGS.mxf_bt20b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt21, FLAGS.mxf_bt21a, 2, FLAGS.mxf_bt21b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt22, FLAGS.mxf_bt22a, 2, FLAGS.mxf_bt22b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt23, FLAGS.mxf_bt23a, 2, FLAGS.mxf_bt23b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt24, FLAGS.mxf_bt24a, 2, FLAGS.mxf_bt24b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt25, FLAGS.mxf_bt25a, 2, FLAGS.mxf_bt25b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt26, FLAGS.mxf_bt26a, 2, FLAGS.mxf_bt26b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt27, FLAGS.mxf_bt27a, 2, FLAGS.mxf_bt27b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
		CreateThread(muskbox, VOLUMES.mxv_bt28, FLAGS.mxf_bt28a, 2, FLAGS.mxf_bt28b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt29, FLAGS.mxf_bt29a, 2, FLAGS.mxf_bt29b, 2, w2_tsunami_station.goal_burgertown);
		CreateThread(muskbox, VOLUMES.mxv_bt30, FLAGS.mxf_bt30a, 2, FLAGS.mxf_bt30b, 2, w2_tsunami_station.goal_burgertown);
		Sleep(2);
end
function burgertown_crates():void
	object_create_folder (MODULES.cr_burgertown);
	object_create_folder (MODULES.veh_burger);
	SleepUntil([| volume_test_players(VOLUMES.tv_burgertown_objcon_20)],2);
	object_create_folder (MODULES.cr_burgertown_2);
	--object_create_folder (MODULES.cr_weapons_burgertown);
end
function w2_tsunami_station.goal_burgertown.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Burger Town - Complete!");	
end
function burgertown_cleanup():void
end

--[[

████████╗ █████╗ ███╗   ██╗ ██████╗ ██╗     ███████╗    ████████╗ ██████╗ ██╗    ██╗███╗   ██╗
╚══██╔══╝██╔══██╗████╗  ██║██╔════╝ ██║     ██╔════╝    ╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
   ██║   ███████║██╔██╗ ██║██║  ███╗██║     █████╗         ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
   ██║   ██╔══██║██║╚██╗██║██║   ██║██║     ██╔══╝         ██║   ██║   ██║██║███╗██║██║╚██╗██║
   ██║   ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗       ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
--]]

w2_tsunami_station.goal_tangletown = 
{
	--description = "TEMP DESC - Tangle Town",
	gotoVolume = VOLUMES.tv_end_tangletown,
	zoneSet = ZONE_SETS.w2_tsunami_burgertown,
	next = {"goal_turrettown"};
}

function w2_tsunami_station.goal_tangletown.Start():void
--	CreateThread (shriketurret_animate, OBJECTS.dm_shriketurret_02, OBJECTS.shrike_power_source_2);
	CreateThread (tangletown);
	CreateThread (musk_tangle);
	CreateThread (aa_fx_sequence_tngl);
	CreateThread (pretangle_drop_listener);
	CreateThread (track_tangletown);
	CreateThread (tow_aa_battery_4);
	CreateThread (flock_burgertown_final_cull_client);
	CreateThread (flock_tangletown_client);
	--CreateThread (burgertown_musicend);
	--CreateThread (tangletown_musicstart);
	--CreateThread (tangletown_musicend);
	CreateThread (dogfight_11);
	CreateThread (dogfight_13);
	CreateThread (f_proxy_turrettown_add);
	CreateThread (f_proxy_burgertown_remove);
	ai_object_set_team(OBJECTS.dm_shriketurret_02, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dm_shriketurret_02, true);
	ai_object_set_team(OBJECTS.shrike_power_source_2, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.shrike_power_source_2, true);
	--ai_place (AI.sq_pretangle);
		--	NARRATIVE CALL
		CreateThread(tsunami_tangletown_load);
end

function f_proxy_turrettown_add()
	--Trigger when begin zone set trigger is hit
	SleepUntil([|volume_test_players(VOLUMES["begin_zone_set:w2_tsunami_turrettown"])], 1);

	--Create proxy scenery objects
	object_create("w2_tsunami_turrettown_bowl_proxy_scenery_bsp");
	object_create("w2_tsunami_burgertown_proxy_scenery_bsp");
end

function f_proxy_turrettown_remove()
	--Destroy proxy scenery objects, this is called manually when the zoneset swaps
	object_destroy(OBJECTS.w2_tsunami_turrettown_bowl_proxy_scenery_bsp);
end

function f_proxy_burgertown_remove()
	--Trigger when the begin zone set trigger is hit for underbelly (in elevator)
	SleepUntil([|volume_test_players(VOLUMES["begin_zone_set:w2_tsunami_underbelly"])], 1);

	-- Destroy proxy scenery objects
	object_destroy(OBJECTS.w2_tsunami_burgertown_proxy_scenery_bsp);
end

function track_tangletown():void
	object_create ("tracking_to_tangletown_x");
	SleepUntil(		[| volume_test_players(VOLUMES.tv_tangletown) 
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 3);
	object_destroy (OBJECTS.tracking_to_tangletown_x);
	object_create ("tracking_to_tangletown_2");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_tangletown_entrance)
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 3);
	object_destroy (OBJECTS.tracking_to_tangletown_2);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_02, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_2, true);
	SleepUntil(		[| b_shrike_2 == false
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_02, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_2, false);
	SleepUntil (	[| device_get_position(OBJECTS.dm_tsu_door_02) > 0
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 3);
	object_create	("tracking_to_turrettown");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_end_tangletown)
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 3);
	object_destroy	(OBJECTS.tracking_to_turrettown);
end
function musk_tangle():void
	CreateThread(muskbox, VOLUMES.mxv_tangle_1, FLAGS.mxf_tangle_1a, 2, FLAGS.mxf_tangle_1a, 2, w2_tsunami_station.goal_tangletown);
	CreateThread(muskbox, VOLUMES.mxv_tangle_2, FLAGS.mxf_tangle_2a, 2, FLAGS.mxf_tangle_2a, 2, w2_tsunami_station.goal_tangletown);
	Sleep(15);
	CreateThread(muskbox, VOLUMES.mxv_tangle_3, FLAGS.mxf_tangle_3a, 2, FLAGS.mxf_tangle_3a, 2, w2_tsunami_station.goal_tangletown);
	CreateThread(muskbox, VOLUMES.mxv_tangle_4, FLAGS.mxf_tangle_4a, 2, FLAGS.mxf_tangle_4a, 2, w2_tsunami_station.goal_tangletown);
	Sleep(15);
	CreateThread(muskbox, VOLUMES.mxv_tangle_5, FLAGS.mxf_tangle_5a, 2, FLAGS.mxf_tangle_5a, 2, w2_tsunami_station.goal_tangletown);
	CreateThread(muskbox, VOLUMES.mxv_tangle_6, FLAGS.mxf_tangle_6a, 2, FLAGS.mxf_tangle_6a, 2, w2_tsunami_station.goal_tangletown);
	Sleep(15);
	CreateThread(muskbox, VOLUMES.mxv_tangle_7, FLAGS.mxf_tangle_7a, 2, FLAGS.mxf_tangle_7a, 2, w2_tsunami_station.goal_tangletown);
	CreateThread(muskbox, VOLUMES.mxv_tangle_8, FLAGS.mxf_tangle_8a, 2, FLAGS.mxf_tangle_8a, 2, w2_tsunami_station.goal_tangletown);
end

--[[
████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗    ████████╗ ██████╗ ██╗    ██╗███╗   ██╗
╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝    ╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
   ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║          ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
   ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║          ██║   ██║   ██║██║███╗██║██║╚██╗██║
   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║          ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
Turret Town
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_turrettown = 
{
	zoneSet = ZONE_SETS.w2_tsunami_turrettown,
	next = {"goal_trans_underbelly"};
}

function w2_tsunami_station.goal_turrettown.Start():void
	CreateThread (track_turrettown);
	CreateThread (w2_turrettown_flock_culling)
	CreateThread (shrikes_of_turrettown);
	CreateThread (flock_tangletown_final_cull_client);
	CreateThread (flock_turrettown_client);
	CreateThread (tow_aa_battery_5);
	CreateThread (turret_town);
	CreateThread (guardian_rise);
	CreateThread (cpb_jump_hint_listener);
	game_save_no_timeout();
	--	NARRATIVE CALL
	CreateThread(tsunami_turrettown_load);
	print ("waiting for all shrikes to be destroyed");
	object_create ("turrettown_deadgrunt");
	ai_object_set_team(OBJECTS.dm_shriketurret_03, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dm_shriketurret_03, true);
	ai_object_set_team(OBJECTS.shrike_power_source_3, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.shrike_power_source_3, true);
	ai_object_set_team(OBJECTS.dm_shriketurret_04, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dm_shriketurret_04, true);
	ai_object_set_team(OBJECTS.shrike_power_source_4, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.shrike_power_source_4, true);
	ai_object_set_team(OBJECTS.dm_shriketurret_05, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dm_shriketurret_05, true);
	ai_object_set_team(OBJECTS.shrike_power_source_5, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.shrike_power_source_5, true);
	SleepUntil ([|	v_shrike_tally == 5], 20);
	b_chantbreak = true;
	if(object_get_health (OBJECTS.cr_cpb) > 0) then
		object_damage_damage_section (OBJECTS.cr_cpb, "glass", 2000);
		Sleep(2);
		object_damage_damage_section (OBJECTS.cr_cpb, "default", 2000);
	end
	print ("all shrikes destroyed!");
	game_save_no_timeout();
	sleep_s (1);
	--if (ai_living_count (AI.gr_turret_all) > 10)	then
		--sleep_s (2);
		----CreateThread (title_objective_clear);
		--print ("AI still alive, go kill them!");
		--sleep_s (1);
		b_turrettown_enemy_limit = 8;						--	I've added a varialbe to be able to use the same number in narrative scripting. If you want to change it, just change it on this line.		Guillaume 1/27
		SleepUntil ([|	ai_living_count (AI.gr_turret_all) <= b_turrettown_enemy_limit], 1);
		print ("AI are mostly dead, calling in Phantom now!");
		sleep_s (1);
	--else
		--print ("AI are all dead, calling in Phantom now!");
	--end
	CreateThread(tt_ally_airlift);
	sleep_s (1);
	--missing_content_text ("ARBITER SHIP: 'Osiris, we're coming in. Hold Fire!'", 360);
	print ("Waiting for Phantom to move into place.");
	SleepUntil ([|	arbiter_in_place == true], 1);
	sleep_s (1);
	b_guardian_rise = true;
	composer_play_show ("vin_arbiterally_idle");
	GoalComplete (w2_tsunami_station.goal_turrettown);
	--CreateThread (turrettown_musicend);
end
function cpb_jump_hint_listener():void
	sleep_s(1);
	ai_disable_jump_hint(HINTS.jh_cpb_1);
	ai_disable_jump_hint(HINTS.jh_cpb_2);
	ai_disable_jump_hint(HINTS.jh_cpb_1);
	ai_disable_jump_hint(HINTS.jh_cpb_2);
	SleepUntil([|	object_get_health(OBJECTS.cr_cpb) <= 0 ], 5);
	ai_enable_jump_hint(HINTS.jh_cpb_1);
	ai_enable_jump_hint(HINTS.jh_cpb_2);
end
function track_turrettown():void
	object_create ("tracking_to_turrettown_2");
	
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_turrettown_off)
					or IsGoalActive(w2_tsunami_station.goal_turrettown) == false
					], 3);
	object_destroy	(OBJECTS.tracking_to_turrettown_2);
	object_create ("tracking_cache_turrettown");
	object_create ("tracking_cache_turrettown_2");
	CreateThread	(track_turret_3);
	CreateThread	(track_turret_4);
	CreateThread	(track_turret_5);
	SleepUntil (	[|	IsGoalActive(w2_tsunami_station.goal_turrettown) == false
					], 3);
	object_destroy	(OBJECTS.tracking_cache_turrettown);
	object_destroy	(OBJECTS.tracking_cache_turrettown_2);
end
function track_turret_3():void
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_03, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_3, true);
	SleepUntil(		[|	b_shrike_3 == false
					or	IsGoalActive(w2_tsunami_station.goal_turrettown) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_03, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_3, false);
end
function track_turret_4():void
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_04, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_4, true);
	SleepUntil(		[| b_shrike_4 == false
					or IsGoalActive(w2_tsunami_station.goal_turrettown) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_04, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_4, false);
end
function track_turret_5():void
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_05, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_5, true);
	SleepUntil(		[| b_shrike_5 == false
					or IsGoalActive(w2_tsunami_station.goal_turrettown) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_shriketurret_05, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.shrike_power_source_5, false);
end
function w2_turrettown_flock_culling():void															-- thin out cov air forces as turrets are destroyed
	SleepUntil ([|	v_shrike_tally >= 3], 5);
		CreateThread(flock_turrettown_progress_cull_a); 
	SleepUntil ([|	v_shrike_tally >= 4], 5);
		CreateThread(flock_turrettown_progress_cull_b); 
	SleepUntil ([|	v_shrike_tally >= 5], 5);
		CreateThread(flock_turrettown_progress_cull_c);
	SleepUntil ([|	ai_living_count (AI.gr_turret_all) <= b_turrettown_enemy_limit], 3);
		CreateThread(flock_turrettown_progress_cull_d);
end
function tt_ally_airlift():void
	ai_place(AI.sq_turrtown_phantom1);
	sleep_s(1.5);
	ai_place(AI.sq_turrtown_phantom2);
	sleep_s(1.5);
	ai_place(AI.sq_turrtown_phantom3);
end
function w2_tsunami_station.goal_turrettown.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Turret Town - Complete!");
end


--[[
████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗████████╗██╗ ██████╗ ███╗   ██╗    ████████╗ ██████╗ 
╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║╚══██╔══╝██║██╔═══██╗████╗  ██║    ╚══██╔══╝██╔═══██╗
   ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║   ██║   ██║██║   ██║██╔██╗ ██║       ██║   ██║   ██║
   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║   ██║   ██║██║   ██║██║╚██╗██║       ██║   ██║   ██║
   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║   ██║   ██║╚██████╔╝██║ ╚████║       ██║   ╚██████╔╝
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝       ╚═╝    ╚═════╝ 
                                                                                                   
██╗   ██╗███╗   ██╗██████╗ ███████╗██████╗ ██████╗ ███████╗██╗     ██╗     ██╗   ██╗               
██║   ██║████╗  ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║     ██║     ╚██╗ ██╔╝               
██║   ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝██████╔╝█████╗  ██║     ██║      ╚████╔╝                
██║   ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║     ██║       ╚██╔╝                 
╚██████╔╝██║ ╚████║██████╔╝███████╗██║  ██║██████╔╝███████╗███████╗███████╗   ██║                  
 ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝                  
Transition To Underbelly
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_trans_underbelly = 
{
	--description = "TEMP DESC - Transition to Underbelly",
	gotoVolume = VOLUMES.tv_end_trans_underbelly,
	zoneSet = ZONE_SETS.w2_tsunami_turrettown,
	
	next = {"goal_underbelly_1"};
}

function w2_tsunami_station.goal_trans_underbelly.Start():void
	game_save_no_timeout();
	CreateThread(track_post_turrettown);
	CreateThread(update_profiles);
	CreateThread(audio_elevator_buttonpanelloop_start_a);
	local tsu_turrtown_buttonpress:number= nil;
		--	NARRATIVE CALL
		CreateThread(tsunami_elevator_01_get_in_listener);
	--arbiter_make_control = true;
	object_create ("dc_elevator1");
	print ("Elevator 1 switch created.");
	CreateThread(elevator_muskbox);
	sleep_s (1);
	device_set_power (OBJECTS.dc_elevator1, 1);
	--navpoint_track_object_named (OBJECTS.dc_elevator1, "order_goto");
	RegisterInteractEvent(f_elevator_activate, OBJECTS.dc_elevator1);
	SleepUntil ([|	device_get_position (OBJECTS.dc_elevator1) > 0], 1);
	b_guardian_rise = true;
	device_set_power (OBJECTS.dc_elevator1, 0);
	CreateThread(audio_elevator_buttonpress_a);
	print ("Elev1 button pressed");
	sleep_s (1.4);
	CreateThread(audio_elevator_buttonpanelloop_stop_a);
	CreateThread(elevator1_behavior);
	SleepUntil ([|	var_elevator1_state >= 8], 3);
	turrettown_teleport_topside();
	-- zone_set_trigger_volume_enable( "begin_zone_set:w2_tsunami_underbelly", false);
	kill_volume_disable(VOLUMES.playerkill_turrettown);
	device_set_position (OBJECTS.dm_elev_1, 1);
	var_elevator1_state = 10;											-- 10 == in motion
	CreateThread(audio_elevator_down);
	print ("ElevatorUp");
	CreateThread(audio_underbelly_musicstart);
	sleep_s (3);
	
	--object_destroy_folder (MODULES.cr_watertile_toplayer);
--	switch_zone_set (ZONE_SETS.w2_tsunami_elevator);
--	volume_teleport_players_not_inside (VOLUMES.tv_end_trans_underbelly, FLAGS.fl_elevator1_teleport2);	
--	sleep_s (2);	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	/END ELEVATOR WORKAROUND
end
function elevator1_behavior():void
	object_set_function_variable(OBJECTS.dc_elevator1, "button_cov_active", 1, 1);
	sleep_s (3);
	object_destroy (OBJECTS.dc_elevator1);
	var_elevator1_state = 8;											-- 8 == button gone
end
function update_profiles():void
	player_set_profile(STARTING_PROFILES.later, SPARTANS.locke);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.vale);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.tanaka);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.buck);
end
function track_post_turrettown():void
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_turr_shield_shutdown, false );
	ObjectSetSpartanTrackingEnabled( OBJECTS.cr_cpb, false );
	SleepUntil (	[|	object_valid ("dc_elevator1")
					or IsGoalActive(w2_tsunami_station.goal_trans_underbelly) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_elevator1, true);
	SleepUntil (	[| device_get_position (OBJECTS.dc_elevator1) > 0.0
					or IsGoalActive(w2_tsunami_station.goal_trans_underbelly) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_elevator1, false);
end
function elevator_muskbox():void
	-- send musketeers to elevator
	repeat
		SleepUntil( [|	volume_test_players(VOLUMES.tv_elevator1_teleport)
					or	var_elevator1_state >= 5
					],	20);
			MusketeersOrderTurnAllOff();
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_tp_elevator1, 1.6);
					MusketeerCombatSetAllowedPlayerOffset(obj, .1);
			end
		SleepUntil( [| volume_test_players(VOLUMES.tv_elevator1_teleport) == false
					or var_elevator1_state >= 10
					],1);
		sleep_s(2);
		if(volume_test_players(VOLUMES.tv_elevator1_teleport) == false)then
			MusketeerUtil_SetDestination_Clear_All()
			MusketeersOrderTurnAllOn();
		end
		Sleep(2);
	until(var_elevator1_state >= 10);
	MusketeersOrderTurnAllOn();
	sleep_s(1.6);
	print("EXITEXITEXITEXITEXITEXIT");
	MusketeerUtil_SetDestination_Clear_All();
	for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
		MusketeerCombatSetDefault(obj);
	end
end

function turrettown_teleport_topside():void
	volume_teleport_players_not_inside (VOLUMES.tv_elevator1_teleport, FLAGS.fl_tp_elevator1);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if( volume_test_objects(VOLUMES.tv_elevator1_teleport, obj) == false)then
					object_teleport(obj, FLAGS.fl_tp_elevator1);
				end
			end
end
function turrettown_teleport_bottom():void
	volume_teleport_players_not_inside (VOLUMES.tv_elevator_p, FLAGS.fl_tp_elevator2);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if( volume_test_objects(VOLUMES.tv_elevator_p, obj) == false)then
					object_teleport(obj, FLAGS.fl_tp_elevator2);
				end
			end
end
function w2_tsunami_station.goal_trans_underbelly.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Transition to Underbelly - Complete!");
	kill_volume_disable(VOLUMES.playerkill_watervolume);
end


--[[
██╗   ██╗███╗   ██╗██████╗ ███████╗██████╗ ██████╗ ███████╗██╗     ██╗     ██╗   ██╗       ██████╗  █████╗ ██████╗ ████████╗     ██╗
██║   ██║████╗  ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║     ██║     ╚██╗ ██╔╝       ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ███║
██║   ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝██████╔╝█████╗  ██║     ██║      ╚████╔╝        ██████╔╝███████║██████╔╝   ██║       ╚██║
██║   ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║     ██║       ╚██╔╝         ██╔═══╝ ██╔══██║██╔══██╗   ██║        ██║
╚██████╔╝██║ ╚████║██████╔╝███████╗██║  ██║██████╔╝███████╗███████╗███████╗   ██║   ▄█╗    ██║     ██║  ██║██║  ██║   ██║        ██║
 ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝   ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝        ╚═╝
Underbelly, Part 1
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_underbelly_1 = 
{
	gotoVolume = VOLUMES.tv_end_underbelly_1,
	zoneSet = ZONE_SETS.w2_tsunami_underbelly,
	next = {"goal_underbelly_2"};
}

function w2_tsunami_station.goal_underbelly_1.Start():void
	local underbelly_spirit_comp:number=0;
	print("============================ tsunami.goal_underbelly_1.start =============");
	--CreateThread (underbelly1_quiet_musicstart);
	CreateThread (mall_cleanup);
	CreateThread (underbelly_create_crates);
	CreateThread (tsunami_theater_ub1);
	CreateThread (flock_underbelly_client);
	CreateThread (flock_underbelly1_kill_sequence);
	game_save_no_timeout();
	stop_valid_composition (var_comp_guardian_rise);
	stop_valid_composition (var_tsunami_theater_intro);
	stop_valid_composition (var_tsunami_theater_turret);
	stop_valid_composition (var_tsunami_theater_burger);
	stop_valid_composition (var_tsunami_theater_slip);
	stop_valid_composition (g_chantinggrunts);
	CreateThread (ub1_load_squads);
	CreateThread (ub1_checkpoints);
	--CreateThread (flocks_ub_start);
	CreateThread(tsunami_underbelly1_load);	--	NARRATIVE CALL
	--print("tsunami.goal_underbelly_1.start ============= CreateThread(tsunami_underbelly1_load);");
	SleepUntil([| device_get_position(OBJECTS.dm_elev_1) == 1 or b_underbelly1_blink == true] , 3);
	print("tsunami.goal_underbelly_1.start ============= DM_ELEV_1 >= .99");
	switch_zone_set (ZONE_SETS.w2_tsunami_underbelly);
--	CreateThread(ub1_zs);
	--print("tsunami.goal_underbelly_1.start ============= ubz1_zs called");
	underbelly_spirit_comp = composer_play_show ("vin_tsunami_spirit_underbelly");
	sleep_s (1);
	CreateThread(turrettown_teleport_bottom);
	game_save_no_timeout();
	volume_teleport_players_not_inside (VOLUMES.tv_elevator_p, FLAGS.fl_tp_elevator2);
	device_set_position (OBJECTS.dm_elev1_doorb, 1);
	MusketeersOrderTurnAllOn();
	--print("tsunami.goal_underbelly_1.start ============= door presumably opened");
--	CreateThread (title_ambient_throughthewoods);		-- cut
	CreateThread(track_underbelly_1);
	sleep_s (2);
	--CreateThread (title_objective_continue);
	ai_place (AI.sq_ub_phantom2);
	--print("tsunami.goal_underbelly_1.start ============= sq_ub_phantom placed");
	SleepUntil ([|	volume_test_players(VOLUMES.tv_greenplat_spawn)], 1);
	--print("tsunami.goal_underbelly_1.start ============= composer show stopped playing");
	ai_place (AI.sq_ub_phantom);
	object_create ("greenplat_deadelite");
end
function ub1_zs():void
	--print("tsunami.goal_underbelly_1.start ============= zone_set_trigger_enabled");
--	zone_set_trigger_volume_enable( "begin_zone_set:w2_tsunami_underbelly", true);
	--print("tsunami.goal_underbelly_1.start ============= zone_set_trigger_enabled");
end
function stop_valid_composition(comp:number):void
	if(comp ~= nil)then
		composer_stop_show (comp);
		comp = nil;
	end
end
function track_underbelly_1():void
	object_create ("tracking_underbelly_1");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_01)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_1);
	object_create ("tracking_underbelly_2");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_02)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_2);
	object_create ("tracking_underbelly_3");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_03)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_3);
	object_create ("tracking_underbelly_4");
end
function underbelly_create_crates():void
	object_create_folder (MODULES.cr_ub1_weap);
	object_create_folder (MODULES.cr_ub_landing);
	object_create_folder (MODULES.cr_underbelly_shoulderbash);
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_7)
					or	ub1_objcon > 7
					or IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
				], 2);
	object_create_folder (MODULES.cr_ub_mid);
	object_create_folder (MODULES.cr_ub_shade);
	SleepUntil ([|		volume_test_players(VOLUMES.tv_save_blueplat01)
				or		IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
				], 2);
	object_create_folder (MODULES.cr_ub_interior);
	SleepUntil ([|		volume_test_players(VOLUMES.tv_ub2_spawnspirit)
				or		IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
				], 2);
	CreateThread(ub1_crate_manager);
	object_create_folder (MODULES.cr_ub2_most);
	SleepUntil ([|		volume_test_players(VOLUMES.tv_ub2_objcon50)
				or		IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
				], 2);	
	object_create_folder (MODULES.cr_ub2_hunter_left);
end
function ub1_crate_manager():void
	-- called at end of ub1
	-- clears out non-weapons/weaponrack objects
	-- replaces if player returns
	object_destroy_folder (MODULES.cr_ub_landing);
	object_destroy_folder (MODULES.cr_ub_mid);
	object_destroy_folder (MODULES.cr_ub_shade);
	repeat
		SleepUntil([|	volume_test_players(VOLUMES.tv_ub1_all) == true], 20);
			object_create_folder (MODULES.cr_ub_landing);
			object_create_folder (MODULES.cr_ub_mid);
			object_create_folder (MODULES.cr_ub_shade);			

		SleepUntil([|	volume_test_players(VOLUMES.tv_ub1_all) == false], 20);
			object_destroy_folder (MODULES.cr_ub_landing);
			object_destroy_folder (MODULES.cr_ub_mid);
			object_destroy_folder (MODULES.cr_ub_shade);

	until(		IsGoalActive(w2_tsunami_station.goal_underbelly_1) == false
		and		IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
		and		IsGoalActive(w2_tsunami_station.goal_trans_arcade) == false
		);
end

function underbelly_destroy_crates():void
	object_destroy_folder (MODULES.cr_underbelly_shoulderbash);
	object_destroy_folder (MODULES.cr_ub1_weap);
	object_destroy_folder (MODULES.cr_ub_landing);
	object_destroy_folder (MODULES.cr_ub_mid);
	object_destroy_folder (MODULES.cr_ub_shade);
	object_destroy_folder (MODULES.cr_ub_interior);
	object_destroy_folder (MODULES.cr_ub2_most);
	object_destroy_folder (MODULES.cr_ub2_hunter_left);
end
function ub1_load_squads():void
	
	SleepUntil	([|		current_zone_set() == ZONE_SETS.w2_tsunami_underbelly
				], 2);
	Sleep(4);	
	ai_place (AI.sq_ub1_lm1_spirit);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_greenplat_spawn)], 1);
	ai_place (AI.gr_ub_greenplat_all);
--	ai_place (AI.sq_ub1_driveby_spirit01);
--	CreateThread (underbelly1_combat_musicstart);
	Sleep(2);
	composer_play_show ("vin_tsu_underbelly_elite_orders01");
	CreateThread(greenplat_listener);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_landmark1_spawn)], 1);
	ai_place (AI.gr_ub_landmark1_all);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_orangeplat_spawn)], 1);
	CreateThread(audio_underbelly_firstwave);
--	ai_place (AI.sq_ub_blocker_spirit);
	ai_place (AI.gr_ub_orangeplat_all);
--	ai_place (AI.sq_ub1_driveby_spirit02);
	--ai_place (AI.sq_ub_blocker_spirit);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_landmark2_spawn)], 1);
	ai_place (AI.gr_ub_landmark2_all);
	ai_place (AI.gr_ub_rangers);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_spirit_unload)], 1);
	ai_place (AI.gr_ub_blockerplat_all);
end
function greenplat_listener():void
	CreateThread(greenplat_killcount_listener);
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_3)
					or	ub1_objcon > 3
				], 2);
	if(ub1_objcon <= 3)then
		ub1_objcon = 3;
	end
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_7)
					or	ub1_objcon > 7
				], 2);
	if(ub1_objcon <= 7)then
		ub1_objcon = 7;
	end
	
	SleepUntil ([|	volume_test_players(VOLUMES.tv_greenplat_20)
					or ub1_objcon > 20
				], 2);
	if(ub1_objcon <= 20)then
		ub1_objcon = 20;
	end
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_30)
					or	ub1_objcon > 30
				], 2);
	if(ub1_objcon <= 30)then
		ub1_objcon = 30;
	end
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_40)
					or	ub1_objcon > 40
				], 2);
	if(ub1_objcon <= 40)then
		ub1_objcon = 40;
	end
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_50)
					or	ub1_objcon > 50
				], 2);
	if(ub1_objcon <= 50)then
		ub1_objcon = 50;
	end

end
function greenplat_killcount_listener():void
	SleepUntil ([|	(	ai_living_count(AI.gr_ub_greenplat_left)
					+	ai_living_count(AI.gr_ub_greenplat_left)
					) <= 3
				], 1);
		if(ub1_objcon <= 10)then
			ub1_objcon = 10
		end
end

function ub1_checkpoints():void
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_greenplat);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_landmark1);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_orangeplat);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_blueplat01);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_landmark3);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_hunterplat);
	CreateThread (tsunami_checkpoint_save, VOLUMES.tv_save_midpoint);
end
function w2_tsunami_station.goal_underbelly_1.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Underbelly 1 - Complete!");	
end


--[[**
██╗   ██╗███╗   ██╗██████╗ ███████╗██████╗ ██████╗ ███████╗██╗     ██╗     ██╗   ██╗       ██████╗  █████╗ ██████╗ ████████╗    ██████╗ 
██║   ██║████╗  ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║     ██║     ╚██╗ ██╔╝       ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    ╚════██╗
██║   ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝██████╔╝█████╗  ██║     ██║      ╚████╔╝        ██████╔╝███████║██████╔╝   ██║        █████╔╝
██║   ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║     ██║       ╚██╔╝         ██╔═══╝ ██╔══██║██╔══██╗   ██║       ██╔═══╝ 
╚██████╔╝██║ ╚████║██████╔╝███████╗██║  ██║██████╔╝███████╗███████╗███████╗   ██║   ▄█╗    ██║     ██║  ██║██║  ██║   ██║       ███████╗
 ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝   ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚══════╝
Underbelly, Part 2
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_underbelly_2 = 
{
	--description = "TEMP DESC - Underbelly 2",
	--gotoVolume = VOLUMES.tv_end_underbelly_2,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_underbelly,
	next = {"goal_trans_arcade"};
}

function w2_tsunami_station.goal_underbelly_2.Start():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO REQUIRE BEFORE MAKING THE END VOLUME VALID.
	--CreateThread (underbelly1_combat_musicend);
	kill_volume_disable(VOLUMES.playerkill_watervolume);
	CreateThread (cruiser_strafe);
	CreateThread (ub2_load_squads);
	game_save_no_timeout();
	object_create("dm_elev2_doora");
	--	NARRATIVE CALL
	CreateThread(track_underbelly_2);
	CreateThread(flock_underbelly_2);
	CreateThread(tsunami_underbelly2_load);
	CreateThread(ub2_objcon_10);
	CreateThread(ub2_objcon_20);
	CreateThread(ub2_objcon_30);
	CreateThread(ub2_objcon_40);
	CreateThread(ub2_objcon_50);
	CreateThread(hunter_cycler);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_nar_underbelly2)], 1);
	CreateThread(audio_newobjective_beep);
end
function track_underbelly_2():void
	object_create_anew ("tracking_underbelly_4");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_04)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_4);
	object_create ("tracking_underbelly_5");
	object_create ("tr_ub_bridgecache");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_05)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_5);
	object_create ("tracking_underbelly_6");
	object_create ("tr_ub_huntercache");
	object_create ("tr_ub_huntercache01");
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_underbelly_06)
					or IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
					], 3);
	object_destroy (OBJECTS.tracking_underbelly_6);
	SleepUntil (	[|	IsGoalActive(w2_tsunami_station.goal_underbelly_2) == false
					and IsGoalActive(w2_tsunami_station.goal_trans_arcade) == false
					], 3);
	object_destroy (OBJECTS.tr_ub_huntercache);
	object_destroy (OBJECTS.tr_ub_huntercache01);
	object_destroy (OBJECTS.tr_ub_bridgecache);
end
function ub2_load_squads():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ub2_spawnspirit)], 1);
	ai_place (AI.sq_ub2_landmark3_spirit);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ub2_spawn)], 1);
	ai_place (AI.sq_ub2_lm3_spiritdropoff);
	ai_place (AI.sq_ub2_walkway_greeters);
	ai_place (AI.sq_ub2_walkway_gunner);
	ai_place (AI.sq_ub2_walkway_bulwark);
	ai_place (AI.sq_ub2_walkway_reserves);
	ai_place (AI.sq_ub2_walkway_phalanx);
	ai_place (AI.sq_ub2_walkway_grenadier);
	CreateThread (audio_underbelly_middlewave);
	CreateThread (flock_seraph_blast_listener);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_walkway_sniper_spawn)], 1);
	ai_place (AI.sq_ub2_walkway_archers);
	ai_place (AI.sq_ub2_walkway_sniper);
	if	(game_coop_player_count() >= 3)
	or	(game_difficulty_get_real() == DIFFICULTY.legendary)
	then 
		ai_place (AI.sq_ub_landmark3_zealot);
	end
	SleepUntil ([|	volume_test_players (VOLUMES.tv_landmark3_spawn)], 1);
	ai_place (AI.gr_prehunter_all);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_hunter_spawn)], 1);
	sleep_s (1);
	composer_play_show ("vin_tsunami_hunter_form_01");
	composer_play_show ("vin_tsunami_hunter_form_02");
	print ("playing Hunter Form Composition");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_hunter_form)], 1);
	CreateThread(wormcatcher);
	--CreateThread (underbelly2_hunters_musicstart);
	b_hunter_form_now = true;
	sleep_s (.5);
	b_hunter_form_now_2 = true
	sleep_s (.5);
	-- gmu -- 148388 -- changing this to look for the squad that the wormcatcher function looks for
	--also changed the compositions to spawn hunter_form_squad instead of sq_ub_hunters
	SleepUntil ([|	ai_living_count (AI.hunter_form_squad) <= 0], 1);
	sleep_s (1);
	CreateThread (audio_underbelly_outro);
	GoalComplete (w2_tsunami_station.goal_underbelly_2);
end
function wormcatcher():void
	local wurma:boolean = false;
	local wurmo:boolean = false;
	SleepUntil([|ai_living_count(AI.hunter_form_squad) >= 1], 5);
	repeat
		if	(		wurma == false
			and		(	volume_test_object(VOLUMES.tv_wormcatcher, AI.hunter_form_squad.hunter_form_01)
					or	volume_test_object(VOLUMES.tv_wormcatcher_2, AI.hunter_form_squad.hunter_form_01)
					)
			)then
			wurma = true;
			print("wurma");
		end
		if	(		wurmo == false
			and		(	volume_test_object(VOLUMES.tv_wormcatcher, AI.hunter_form_squad.hunter_form_02)
					or	volume_test_object(VOLUMES.tv_wormcatcher_2, AI.hunter_form_squad.hunter_form_02)
					)
			)then
			wurmo = true;
			print("wurm0");
		end
		Sleep(1);
	until(ai_living_count(AI.hunter_form_squad) <= 0);
	if(wurma == true and wurmo == true)then
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		print("ACHIEVEMENT UNLOCKED : WORMS DONT SURF");
		CampaignScriptedAchievementUnlocked(18) ;
	else
		print("ACHIEVEMENT FAILED : WORMS DONT SURF");
		print("ACHIEVEMENT FAILED : WORMS DONT SURF");
		print("ACHIEVEMENT FAILED : WORMS DONT SURF");
	end
end

--this is added to more easily test the hunter achievement
function huntertest()
	kill_volume_disable(VOLUMES.playerkill_watervolume);
	composer_play_show ("vin_tsunami_hunter_form_01");
	composer_play_show ("vin_tsunami_hunter_form_02");
	print ("playing Hunter Form Composition");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_hunter_form)], 1);
	CreateThread(wormcatcher);
	--CreateThread (underbelly2_hunters_musicstart);
	b_hunter_form_now = true;
	sleep_s (.5);
	b_hunter_form_now_2 = true
end

function ub2_objcon_10():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ub2_objcon10)],2);
	if (v_ub2_objcon <= 10)then
		v_ub2_objcon = 10;
	end
end
function ub2_objcon_20():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ub2_objcon20)],2);
	if (v_ub2_objcon <= 20)then
		v_ub2_objcon = 20;
	end
end
function ub2_objcon_30():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ub2_objcon30)],2);
	if (v_ub2_objcon <= 30)then
		v_ub2_objcon = 30;
	end
end
function ub2_objcon_40():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ub2_objcon40)],2);
	if (v_ub2_objcon <= 40)then
		v_ub2_objcon = 40;
	end
end
function ub2_objcon_50():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ub2_objcon50)],2);
	if (v_ub2_objcon <= 50)then
		v_ub2_objcon = 50;
	end
end
function w2_tsunami_station.goal_underbelly_2.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Underbelly 2 - Complete!");	
end
global v_hunter_cycle:number = 0;
function hunter_cycler():void
	SleepUntil([|volume_test_players(VOLUMES.tv_hunter_objcon_10)],5);
	repeat
		v_hunter_cycle = 10;
		
		sleep_s(random_range(6,12));

		if	(	random_range(1,4) >= 2)
		then
			v_hunter_cycle = 20;
			sleep_s(random_range(10,16));
		end

		if	(	random_range(1,4) >= 3)
		then
			v_hunter_cycle = 30;
			sleep_s(random_range(4,12));
		end
	until(ai_living_count(AI.hunter_form_squad) <= 0);
end

--[[
████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗████████╗██╗ ██████╗ ███╗   ██╗    ████████╗ ██████╗ 
╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║╚══██╔══╝██║██╔═══██╗████╗  ██║    ╚══██╔══╝██╔═══██╗
   ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║   ██║   ██║██║   ██║██╔██╗ ██║       ██║   ██║   ██║
   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║   ██║   ██║██║   ██║██║╚██╗██║       ██║   ██║   ██║
   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║   ██║   ██║╚██████╔╝██║ ╚████║       ██║   ╚██████╔╝
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝       ╚═╝    ╚═════╝ 
                                                                                                   
 █████╗ ██████╗  ██████╗ █████╗ ██████╗ ███████╗                                                   
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝                                                   
███████║██████╔╝██║     ███████║██║  ██║█████╗                                                     
██╔══██║██╔══██╗██║     ██╔══██║██║  ██║██╔══╝                                                     
██║  ██║██║  ██║╚██████╗██║  ██║██████╔╝███████╗                                                   
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═════╝ ╚══════╝                                                   
Transition To arcade
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_trans_arcade = 
{
	gotoVolume = VOLUMES.tv_end_trans_arcade,
	zoneSet = ZONE_SETS.w2_tsunami_underbelly,
	next = {"goal_arcade"};
}

function w2_tsunami_station.goal_trans_arcade.Start():void
	kill_volume_disable(VOLUMES.playerkill_watervolume);
	game_save_no_timeout();
	
	--	NARRATIVE LOAD
		CreateThread(tsunami_trans_arcade_load);
		CreateThread(audio_grunt_elevator);
	
	CreateThread(elevator_grunt_sequence);
	CreateThread(elevator2_power_on_sequence);
	CreateThread(elevator2_interface_activated_sequence);
	CreateThread(elevator2_pack_in_sequence);
end
function elevator_grunt_sequence():void
	sleep_s (3.5);
	object_create ("dc_elevator2");
	ai_place (AI.sq_elev2_grunts);
	sleep_s (3);
	device_set_position (OBJECTS.dm_elev2_doora, 1);
end
function elevator2_power_on_sequence():void
	CreateThread(audio_elevator_buttonpanelloop_start_b);
	SleepUntil([| device_get_position(OBJECTS.dm_elev2_doora) >= 1], 5);
	CreateThread(track_underbelly_3);
	sleep_s (1);
	device_set_power (OBJECTS.dc_elevator2, 1);
	RegisterInteractEvent(f_elevator_activate, OBJECTS.dc_elevator2);
end
function elevator2_interface_activated_sequence():void
	SleepUntil ([|	device_get_position (OBJECTS.dc_elevator2) >= 1], 1);
	device_set_power (OBJECTS.dc_elevator2, 0);
	sleep_s(1.4);
	object_set_function_variable(OBJECTS.dc_elevator2, "button_cov_active", 1, 1);
	sleep_s (3);
	object_destroy (OBJECTS.dc_elevator2);
	var_elevator2_state = 8;											-- 8 == button gone
	CreateThread(audio_elevator_buttonpanelloop_stop_b);
end
function elevator2_pack_in_sequence():void
	CreateThread(elevator_muskbox_2);
	SleepUntil ([|	device_get_position (OBJECTS.dc_elevator2) >= 1], 1);
	CreateThread(audio_tsunami_destruction_alley_elevator_start);

	SleepUntil ([|	volume_test_players (VOLUMES.tv_elev2_bottom)], 1);
	sleep_s (2);
	device_set_position (OBJECTS.dm_elev2_doora, 0);
	print ("teleporting players not in Elevator!!!");
	SleepUntil ([|	device_get_position (OBJECTS.dm_elev2_doora) <= 0], 1);
	-- 9-4-2015:	add invisible collision here

	CreateThread(flock_underbelly_2_remove);
	volume_teleport_players_not_inside (VOLUMES.tv_elev2_bottom, FLAGS.fl_elevator2_teleport1);
--	This one should be killed when the players are in the elevator UP TO arcade
	stop_valid_composition (var_cruiser_strafe);
	print ("Players teleported");
		if	(	IsPlayer(SPARTANS.buck) == false
			and	volume_test_object(VOLUMES.tv_elev2_bottom, SPARTANS.buck) == false
			)	then

			object_teleport (SPARTANS.buck, FLAGS.fl_elevator2_teleport1); 
		end
		if	(IsPlayer(SPARTANS.vale) == false
			and	volume_test_object(VOLUMES.tv_elev2_bottom, SPARTANS.vale) == false
			)	then
			object_teleport (SPARTANS.vale, FLAGS.fl_elevator2_teleport1);
		end
		if	(IsPlayer(SPARTANS.tanaka) == false
			and	volume_test_object(VOLUMES.tv_elev2_bottom, SPARTANS.tanaka) == false
			)	then
			object_teleport (SPARTANS.tanaka, FLAGS.fl_elevator2_teleport1);
		end
		if	(IsPlayer(SPARTANS.locke) == false
			and	volume_test_object(VOLUMES.tv_elev2_bottom, SPARTANS.locke) == false
			)then
			object_teleport (SPARTANS.locke, FLAGS.fl_elevator2_teleport1);
		end
	device_set_power (OBJECTS.dm_elev_2, 1);
	sleep_s (1);
	prepare_to_switch_to_zone_set(ZONE_SETS.w2_tsunami_arcade); -- Begin zoneset here instead of switching
	-- switch_zone_set (ZONE_SETS.w2_tsunami_arcade);
	var_elevator2_state = 10;
	device_set_position (OBJECTS.dm_elev_2, 1);
	CreateThread(evelator_2_rescue);								-- 9-4-2015
	CreateThread(audio_elevator_up);
	print ("ElevatorUp");
--	GoalCompleteTask(w2_tsunami_station.goal_trans_arcade);
end
function evelator_2_rescue():void									-- 9-4-2015 Copy/paste from arcade goal. Putting here because if single player, 
																	--			no one reaches the top of the elevator shaft, and the goal logic does not advance to arcade.
	SleepUntil(	[|	device_get_position (OBJECTS.dm_elev_2) >= .99 or
					object_valid("dm_elev_2") == false
				], 5);
	sleep_s (1);
	volume_teleport_players_not_inside(VOLUMES.tv_end_trans_arcade, FLAGS.fl_elevator2_teleport2);
end

function elevator_muskbox_2():void
	-- send musketeers to elevator
	repeat
		SleepUntil( [|	volume_test_players(VOLUMES.tv_elev2_bottom)
					or	var_elevator2_state >= 5
					],	3);
			print("MUSKBOXELEV2-------------------------");
			print("MUSKBOXELEV2-------------------------");
			print("MUSKBOXELEV2-------------------------");
			print("MUSKBOXELEV2-------------------------");
			print("MUSKBOXELEV2-------------------------");
			MusketeersOrderTurnAllOff();
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_elevator2_teleport1, 1.6);
					print(" 1 attempting to go in elev");
					MusketeerCombatSetAllowedPlayerOffset(obj, .1);
			end
		SleepUntil( [| volume_test_players(VOLUMES.tv_elev2_bottom) == false
					or var_elevator2_state >= 10
					],1);
		sleep_s(2);
		if(volume_test_players(VOLUMES.tv_elev2_bottom) == false)then
			MusketeerUtil_SetDestination_Clear_All()
			MusketeersOrderTurnAllOn();
		end
		Sleep(2);
	until(var_elevator2_state >= 10);
	MusketeersOrderTurnAllOn();
	sleep_s(1.6);
	print("EXITEXITEXITEXITEXITEXIT");
	MusketeerUtil_SetDestination_Clear_All();
	for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
		MusketeerCombatSetDefault(obj);
	end
end

function track_underbelly_3():void
	SleepUntil (	[|	object_valid ("dc_elevator2")
					or IsGoalActive(w2_tsunami_station.goal_trans_arcade) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_elevator2, true);
	SleepUntil (	[| device_get_position (OBJECTS.dc_elevator2) > 0.0
					or IsGoalActive(w2_tsunami_station.goal_trans_arcade) == false
					], 5);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_elevator2, false);
end	
function w2_tsunami_station.goal_trans_arcade.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Transition to arcade - Complete!");	
	CreateThread(underbelly_destroy_crates);
end

--[[
 █████╗ ██████╗  ██████╗ █████╗ ██████╗ ███████╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
███████║██████╔╝██║     ███████║██║  ██║█████╗  
██╔══██║██╔══██╗██║     ██╔══██║██║  ██║██╔══╝  
██║  ██║██║  ██║╚██████╗██║  ██║██████╔╝███████╗
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═════╝ ╚══════╝
arcade
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_arcade = 
{
	gotoVolume = VOLUMES.tv_end_arcade,
	zoneSet = ZONE_SETS.w2_tsunami_arcade,
	next = {"goal_destructionalley"};
}

function w2_tsunami_station.goal_arcade.Start():void
	CreateThread(arcade_start);
end
function arcade_start():void
	CreateThread (flocks_ub_stop);
	CreateThread (arcade_aa_cycler);
	CreateThread(demo_fleebie_listener);
	MusketeersOrderTurnAllOn();
	--CreateThread (arcade_musicstart);
	--	NARRATIVE CALL
	CreateThread (tsunami_arcade_load);
	CreateThread (arcade_close_elevator);
	CreateThread (flock_underbelly_cull_client);
--	CreateThread (arcade_rubberband_warning_temp);
	CreateThread (arcade_rubberband_teleport_temp);
	CreateThread(kill_early_comps);
	CreateThread(arcade_snapshut);
	CreateThread(arcade_deathcube);
	--object_create_folder (MODULES.biped_arcade_deadcovenant);
	print ("sleeping until elevator is totes stopped (or fails to exist)");
	SleepUntil(	[|	device_get_position (OBJECTS.dm_elev_2) >= .99 or
		object_valid("dm_elev_2") == false
				], 5);
	sleep_s (1);
	volume_teleport_players_not_inside(VOLUMES.tv_end_trans_arcade, FLAGS.fl_elevator2_teleport2);
	sleep_s (1);
	device_set_position (OBJECTS.dm_elev2_doorb, 1);
	CreateThread (arcade_death_compositions);
	Sleep(2);
	CreateThread (arcade_shield_stripper);
	CreateThread (dead_bodies);
	CreateThread (arcade_create_crates);
	ai_place(AI.sq_arcade_pawns);
	CreateThread (arcade_prometheans_listener);
	object_create ("arcade_deadelitebro_1");
	object_create ("arcade_deadelitebro_2");
	kill_volume_enable(VOLUMES.playerkill_watervolume);
	var_tsunami_theater_arcade = composer_play_show("vin_tsunami_theater_arcade");
	MusketeersOrderTurnAllOn();
	game_save_no_timeout();
	CreateThread (track_arcade);
	CreateThread (title_ambient_partycrashers);
	sleep_s (2);
	--CreateThread (title_objective_rendezvous);
end
function arcade_shield_stripper():void
	object_set_shield_stun_infinite(AI.sq_arcadecomp_cov.stairselite);
	object_set_shield(AI.sq_arcadecomp_cov.stairselite, 0.05);
	unit_doesnt_drop_items(AI.sq_arcadecomp_cov.stairselite);
--	object_set_shield_stun_infinite(AI.sq_arcadecomp_arb.pointingelite);
--	object_set_shield(AI.sq_arcadecomp_arb.pointingelite, 0.05);
--	unit_doesnt_drop_items(AI.sq_arcadecomp_arb.pointingelite);
end
function kill_early_comps():void
	stop_valid_composition(var_tsunami_theater_ub1);
	stop_valid_composition (var_tsunami_theater_burger);
	stop_valid_composition (var_tsunami_theater_turret);
	stop_valid_composition (var_tsunami_theater_slip);
	stop_valid_composition (var_tsunami_theater_ub1);
	stop_valid_composition (var_tsunami_theater_intro);
	stop_valid_composition (var_tsunami_theater_slip);
end
function track_arcade():void
	--	Starting up blip to Destruction Alley
	object_create ("tracking_to_destruction_1");
	object_create ("tr_arcadecache");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_on)
					or	(	IsGoalActive(w2_tsunami_station.goal_arcade) == false
						and	IsGoalActive(w2_tsunami_station.goal_destructionalley) == false)
				], 5);
	object_destroy (OBJECTS.tracking_to_destruction_1);
	object_destroy (OBJECTS.tr_arcadecache);
end
function flocks_ub_stop():void
	flock_stop ("flock_ub_arb01");
	flock_stop ("flock_ub_arb02");
	flock_stop ("flock_ub_cov01");
	flock_stop ("flock_ub_cov02");
	flock_destroy ("flock_ub_arb01");
	flock_destroy ("flock_ub_arb02");
	flock_destroy ("flock_ub_cov01");
	flock_destroy ("flock_ub_cov02");
	print ("Underbelly Flocks are now OFF");
end
function arcade_close_elevator():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_arcade_close_elevator)], 3);
	volume_teleport_players_inside(VOLUMES.tv_arcade_elevator, FLAGS.fl_bl_arcade_1);
	object_create_anew("dm_elev2_doorb");
	device_set_power(OBJECTS.dm_elev2_doorb, 0);
end
function arcade_rubberband_warning_temp():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arcade_rubberband_warning)], 1);
	
	local whoisinthewarningvol = volume_return_players(VOLUMES.tv_arcade_rubberband_warning);
	local player0Behind:boolean=true;
	local player1Behind:boolean=true;
	local player2Behind:boolean=true;
	local player3Behind:boolean=true;
	for _,obj in ipairs(whoisinthewarningvol) do
		if obj == PLAYERS.player0 then
			player0Behind = false;
			print ("Player 0 is not behind.");
		elseif obj == PLAYERS.player1 then
			player1Behind = false;
			print ("Player 1 is not behind.");
		elseif obj == PLAYERS.player2 then
			player2Behind = false;
			print ("Player 2 is not behind.");
		elseif obj == PLAYERS.player3 then
			player3Behind = false;
			print ("Player 3 is not behind.");
		end
	end

	if(player0Behind == true) then
		RunClientScript ("arcade_rubberband_temp", PLAYERS.player0);
	end
	if(player1Behind == true) then
		RunClientScript ("arcade_rubberband_temp", PLAYERS.player1);
	end
	if(player2Behind == true) then
		RunClientScript ("arcade_rubberband_temp", PLAYERS.player2);
	end
	if(player3Behind == true) then
		RunClientScript ("arcade_rubberband_temp", PLAYERS.player3);
	end
end

function arcade_rubberband_teleport_temp():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arcade_rubberband_teleport)], 2);
	ketchup();
end
function ketchup():void
	volume_teleport_players_inside (VOLUMES.tv_arcade_all, FLAGS.fl_arcade_teleport);
	for _, musketeer in pairs( musketeers() ) do
		if volume_test_object (VOLUMES.tv_arcade_all, musketeer) then
			object_teleport(musketeer, FLAGS.fl_arcade_teleport);
		end
	end
end
function arcade_create_crates():void
	object_create_folder (MODULES.cr_arcade_weaponcrates);
end

function w2_tsunami_station.goal_arcade.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal arcade - Complete!");	
end
function arcade_prometheans_listener():void
	SleepUntil	([|	(	(	volume_test_players(VOLUMES.tv_look_companion_1)
						or	volume_test_players(VOLUMES.tv_look_companion_2)
						)
						and volume_test_players_lookat(VOLUMES.tv_look_arcade, 25, 15)
					)
					or
					(	volume_test_players(VOLUMES.tv_arcadecomp_stopidle1)
					)
				], 2);
	b_arcade_go = true
--	print("GONE==================================================================");
end
function arcade_snapshut():void
			print("===================================================================");
			print("====================  SNAPSHUT CALLED!!!  =========================");
			print("====================  SNAPSHUT CALLED!!!  =========================");
			print("====================  SNAPSHUT CALLED!!!  =========================");
			print("===================================================================");
	repeat
		if	(	volume_test_players(VOLUMES.tv_arcade_all) == false
			and	volume_test_players(VOLUMES.tv_pulse_comp_start) == false
			and MusketeersInVolume(VOLUMES.tv_arcade_all) == false
			and	volume_test_players_lookat(VOLUMES.tv_look_arcade_door, 25, 40) == false
			) then
			object_create("dm_da_door");
			CreateThread(arcade_cleanup);
			prepare_to_switch_to_zone_set(ZONE_SETS.w2_tsunami_destruction);
			print("===================================================================");
			print("====================  BAM - DOOR SHUT!!!  =========================");
			print("====================  BAM - DOOR SHUT!!!  =========================");
			print("====================  BAM - DOOR SHUT!!!  =========================");
			print("===================================================================");
			break;
		end
		Sleep(10);
	until(false)
end
function MusketeersInVolume(vol:volume):boolean
	for _, musketeer in pairs( musketeers() ) do
		if volume_test_object (vol, musketeer) then
			return true;
		end
	end
	return false;
end
function arcade_cleanup():void
	object_destroy_folder (MODULES.cr_arcade_weaponcrates);
	
end
function test_look_at_arcade():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_look_arcade_door, 25, 40) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function arcade_deathcube():void
	thread_deathcube = CreateThread(arcade_deathcube_loop);
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_on)
				or	IsGoalActive(w2_tsunami_station.goal_arcade) == false
				], 5);
	if(IsThreadValid(thread_deathcube))then
		KillThread(thread_deathcube);
		print("killthread deathcube");
		print("killthread deathcube");
		print("killthread deathcube");
	else
		print("killthread deathcube not needed");
		print("killthread deathcube not needed");
		print("killthread deathcube not needed");
	end
end
function arcade_deathcube_loop():void
	repeat
		for _, obj in ipairs (volume_return_objects(VOLUMES.tv_arcade_deathcube)) do
			ai_erase(object_get_ai(obj));
		end
	Sleep(10);
	until(volume_test_players(VOLUMES.tv_arcade_almostout));
end

function cs_arcade_flee_1():void
	SleepUntil([|	b_arcade_go == true ], 1);
--	cs_ignore_obstacles(ai_current_actor, true);
--	cs_go_by(POINTS.ps_arcade.p01a,POINTS.ps_arcade.p01b, 1);
--	cs_go_by(POINTS.ps_arcade.p02a,POINTS.ps_arcade.p02b, 1);
--	cs_go_to(POINTS.ps_arcade.p03);
--	cs_go_by(POINTS.ps_arcade.p04, POINTS.ps_arcade.p04b, 1);
--	cs_go_by(POINTS.ps_arcade.p05a, POINTS.ps_arcade.p05b, 1);
	cs_go_to(POINTS.ps_arcade.p06);
	if(volume_test_players(VOLUMES.tv_arcade_almostout)== false)then
		ai_erase(ai_current_actor);
	else
		cs_go_to(POINTS.ps_arcade.p10);
	end
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\pawn\pawn.model_animation_graph'),"combat:any:taunt", true);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
end
function cs_arcade_flee_2():void
	SleepUntil([|	b_arcade_go == true ], 5);
--	cs_ignore_obstacles(ai_current_actor, true);
--	cs_go_to(POINTS.ps_arcade.p07);
--	cs_go_to(POINTS.ps_arcade.p03);
--	cs_go_by(POINTS.ps_arcade.p04, POINTS.ps_arcade.p04b, 1);
--	cs_go_to(POINTS.ps_arcade.p05);
	cs_go_to(POINTS.ps_arcade.p06);
	if(volume_test_players(VOLUMES.tv_arcade_almostout)== false)then
		ai_erase(ai_current_actor);
	else
		cs_go_to(POINTS.ps_arcade.p10);
	end
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\pawn\pawn.model_animation_graph'),"combat:any:taunt", true);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
end
function cs_arcade_flee_3():void
	SleepUntil([|	b_arcade_go == true ], 5);
--	cs_ignore_obstacles(ai_current_actor, true);
--	cs_go_to(POINTS.ps_arcade.p08);
--	cs_go_to(POINTS.ps_arcade.p09);
--	cs_go_to(POINTS.ps_arcade.p03);
--	cs_go_by(POINTS.ps_arcade.p04, POINTS.ps_arcade.p04b, 1);
--	cs_go_to(POINTS.ps_arcade.p05);
	cs_go_to(POINTS.ps_arcade.p06);
	if(volume_test_players(VOLUMES.tv_arcade_almostout)== false)then
		ai_erase(ai_current_actor);
	else
		cs_go_to(POINTS.ps_arcade.p10);
	end
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\pawn\pawn.model_animation_graph'),"combat:any:taunt", true);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
end
function cs_arcade_flee_4():void
	SleepUntil([|	b_arcade_go == true ], 5);
	cs_go_to(POINTS.ps_arcade.p06);
	if(volume_test_players(VOLUMES.tv_arcade_almostout)== false)then
		ai_erase(ai_current_actor);
	else
		cs_go_to(POINTS.ps_arcade.p10);
	end
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
end
function arcade_aa_cycler():void
	repeat
		CreateEffectGroup(EFFECTS.aa_demo_arcade_01);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_03);
		sleep_s(4);
		StopEffectGroup(EFFECTS.aa_demo_arcade_01);
		StopEffectGroup(EFFECTS.aa_demo_arcade_03);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_02);
		sleep_s(1);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_04);
		sleep_s(3);
		StopEffectGroup(EFFECTS.aa_demo_arcade_02);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_01a);
		sleep_s(1);
		StopEffectGroup(EFFECTS.aa_demo_arcade_04);
		sleep_s(2);
		StopEffectGroup(EFFECTS.aa_demo_arcade_01a);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_03a);
		sleep_s(.5);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_02a);
		sleep_s(2);
		StopEffectGroup(EFFECTS.aa_demo_arcade_03a);
		CreateEffectGroup(EFFECTS.aa_demo_arcade_04a);
		sleep_s(1);
		StopEffectGroup(EFFECTS.aa_demo_arcade_02a);
		sleep_s(2);
		StopEffectGroup(EFFECTS.aa_demo_arcade_04a);
		
		KillEffectGroup(EFFECTS.aa_demo_arcade_01);
		KillEffectGroup(EFFECTS.aa_demo_arcade_01a);
		KillEffectGroup(EFFECTS.aa_demo_arcade_02);
		KillEffectGroup(EFFECTS.aa_demo_arcade_02a);
		KillEffectGroup(EFFECTS.aa_demo_arcade_03);
		KillEffectGroup(EFFECTS.aa_demo_arcade_03a);
		KillEffectGroup(EFFECTS.aa_demo_arcade_04);
		KillEffectGroup(EFFECTS.aa_demo_arcade_04a);
		Sleep(2);
	until	(		IsGoalActive(w2_tsunami_station.goal_arcade) == false)
end
--[[
██████╗ ███████╗███████╗████████╗██████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗     █████╗ ██╗     ██╗     ███████╗██╗   ██╗
██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔══██╗██║     ██║     ██╔════╝╚██╗ ██╔╝
██║  ██║█████╗  ███████╗   ██║   ██████╔╝██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║    ███████║██║     ██║     █████╗   ╚████╔╝ 
██║  ██║██╔══╝  ╚════██║   ██║   ██╔══██╗██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██╔══██║██║     ██║     ██╔══╝    ╚██╔╝  
██████╔╝███████╗███████║   ██║   ██║  ██║╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ██║  ██║███████╗███████╗███████╗   ██║   
╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝   
Destruction Alley
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_destructionalley = 
{
	--description = "TEMP DESC - Destruction Alley",
	gotoVolume = VOLUMES.tv_end_destructionalley,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_destruction,
	next = {"goal_bldg_interior"};
}

function w2_tsunami_station.goal_destructionalley.Start():void
--	game_save_no_timeout();												-- for now!
		--	NARRATIVE CALL
		CreateThread(tsunami_destructionalley_load);			
	CreateThread (phandy_landy);						-- phantom begins landing on destruction alley platform
	CreateThread (track_destruction);
	CreateThread (destruction_alley_player_killer);
	CreateThread (alphatight_for_destruction);
	-- play comp functions
	CreateThread (destruction_guardian_pulse);			-- tv_pulse_comp_start, "vin_tsunami_destruction_alley"
	CreateThread (destruction_pre_pulse);				-- tv_destruction_pre_pulse, b_pre_pulse = true
	CreateThread (player_ics_pulse_01);					-- tv_platfall_02, kick off staggerguard threads (unnecessary extra step?)  state.spartan
	CreateThread (spartan_choreographer);				-- tv_destruction_start, vin_ics_pulse_stagger_primary
	thread_slide = CreateThread (slide_ics_trigger);	-- 1:tv_slider == slide
	-- Boolean Triggers for Pulse Vignette
	CreateThread (dest_pulse_triggers);
	kill_volume_enable(VOLUMES.playerkill_watervolume);
end
function track_destruction():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_on)
					or	(	IsGoalActive(w2_tsunami_station.goal_arcade) == false
						and	IsGoalActive(w2_tsunami_station.goal_destructionalley) == false)
				], 5);
	object_create ("tracking_to_destruction_2");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_off)
					or IsGoalActive(w2_tsunami_station.goal_destructionalley) == false
				], 5);
	object_destroy (OBJECTS.tracking_to_destruction_2);
	object_create ("tracking_through_destruction");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_slide_bc)
					or IsGoalActive(w2_tsunami_station.goal_destructionalley) == false
				], 5);
	object_destroy (OBJECTS.tracking_through_destruction);
	object_create ("tracking_to_buildinginterior");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_buildinginterior_off)
					or IsGoalActive(w2_tsunami_station.goal_destructionalley) == false
				], 5);
	object_destroy (OBJECTS.tracking_to_buildinginterior);
end
function alphatight_for_destruction():void
	render_low_res_transparents = false;
	SleepUntil ([|	volume_test_players_all (VOLUMES.tv_interior_all)], 5);
	render_low_res_transparents = true;
end
function w2_tsunami_station.goal_destructionalley.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Destruction Alley - Complete!");	
end

--[[
██████╗ ██╗   ██╗██╗██╗     ██████╗ ██╗███╗   ██╗ ██████╗     ██╗███╗   ██╗████████╗███████╗██████╗ ██╗ ██████╗ ██████╗ 
██╔══██╗██║   ██║██║██║     ██╔══██╗██║████╗  ██║██╔════╝     ██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗██║██╔═══██╗██╔══██╗
██████╔╝██║   ██║██║██║     ██║  ██║██║██╔██╗ ██║██║  ███╗    ██║██╔██╗ ██║   ██║   █████╗  ██████╔╝██║██║   ██║██████╔╝
██╔══██╗██║   ██║██║██║     ██║  ██║██║██║╚██╗██║██║   ██║    ██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗██║██║   ██║██╔══██╗
██████╔╝╚██████╔╝██║███████╗██████╔╝██║██║ ╚████║╚██████╔╝    ██║██║ ╚████║   ██║   ███████╗██║  ██║██║╚██████╔╝██║  ██║
╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝
Building Interior
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_bldg_interior = 
{
	--description = "TEMP DESC - Building Interior",
	gotoVolume = VOLUMES.tv_end_bldg_interior,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_destruction,
	next = {"goal_trans_final"};
}

function w2_tsunami_station.goal_bldg_interior.Start():void
	--CreateThread (title_objective_wreckage);
	CreateThread (audio_tsunami_destruction_walkway_end);
	CreateThread (interior_events);
	CreateThread (grunt_crawler_war);
	CreateThread (track_interior);
	CreateThread (interior_prevent_retreat);
	CreateThread (ff_trans_arbstarter);
	game_safe_to_respawn(true);																	-- undo suppress respawn for destruction alley
	stop_valid_composition (var_tsunami_theater_arcade);
	object_create_folder(MODULES.cr_interior_weapons);
	--object_create_folder (MODULES.building_interior_dead);
		-- NARRATIVE CALL
		CreateThread(tsunami_buildinginterior_load);
	Sleep(2);
	weapon_set_current_amount(OBJECTS.weapon_int_1, .6);
	weapon_set_current_amount(OBJECTS.weapon_int_2, .6);
	MusketeersOrderTurnAllOn();
	game_save_no_timeout();
end
function track_interior():void
	--	Starting up blip to Final Fight
	object_create ("tracking_interior");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_interior_off)
					or IsGoalActive(w2_tsunami_station.goal_bldg_interior) == false
				], 3);
	object_destroy (OBJECTS.tracking_interior);
	object_create ("tracking_to_finalfight");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_finalfight_off)
					or IsGoalActive(w2_tsunami_station.goal_bldg_interior) == false
				], 3);
	object_destroy (OBJECTS.tracking_to_finalfight);
end
function soldierbamf_test():void
	print ("SOLDIER SMACK");
	repeat
		SleepUntil ([|	volume_test_players (VOLUMES.tv_soldierbamf)], 3);
		if(var_soldierbamf == nil)then
			var_soldierbamf = composer_play_show ("vin_soldierbamf");
			Sleep(90);
			var_soldierbamf = nil;
		end
	until(false);
end
function interior_events():void					--ported over from e3
	CreateThread(demo_tow_interior_start);
	SleepUntil([|	volume_test_players(VOLUMES.tv_ripple) 
				], 2);
	RunClientScript("client_tension_ripple");
	CreateThread(demo_bamf);

	SleepUntil(	[|	volume_test_players(VOLUMES.tv_demo_ass_pawn) 	], 2);
	v_interior_theater = composer_play_show("vin_e3_interior_theater");
	RunClientScript("client_tension_ripple_vtol");
	--CreateThread(demo_ripple_ff);
end
function w2_tsunami_station.goal_bldg_interior.End():void
	print ("Goal Building Interior - Complete!");	
end
function interior_prevent_retreat():void
	local muskies:object_list = ai_actors(GetMusketeerSquad());
	SleepUntil(	[|	volume_test_players_all(VOLUMES.tv_interior_most)
				and	volume_test_objects_all(VOLUMES.tv_interior_most, muskies);
				]);
	b_doorway_blocker = true						-- collapses overhang
	--	need to turn off these compositions when the player hits the interior bsp:
	stop_valid_composition (var_arcade_deathcomp);
	stop_valid_composition (var_tsunami_pulse);
end

--[[
███████╗██╗███╗   ██╗ █████╗ ██╗         ███████╗██╗ ██████╗ ██╗  ██╗████████╗   
██╔════╝██║████╗  ██║██╔══██╗██║         ██╔════╝██║██╔════╝ ██║  ██║╚══██╔══╝██╗
█████╗  ██║██╔██╗ ██║███████║██║         █████╗  ██║██║  ███╗███████║   ██║   ╚═╝
██╔══╝  ██║██║╚██╗██║██╔══██║██║         ██╔══╝  ██║██║   ██║██╔══██║   ██║   ██╗
██║     ██║██║ ╚████║██║  ██║███████╗    ██║     ██║╚██████╔╝██║  ██║   ██║   ╚═╝
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝      
                                                                                 
████████╗██████╗  █████╗ ███╗   ██╗███████╗██╗████████╗██╗ ██████╗ ███╗   ██╗    
╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║╚══██╔══╝██║██╔═══██╗████╗  ██║    
   ██║   ██████╔╝███████║██╔██╗ ██║███████╗██║   ██║   ██║██║   ██║██╔██╗ ██║    
   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██║   ██║   ██║██║   ██║██║╚██╗██║    
   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║   ██║   ██║╚██████╔╝██║ ╚████║    
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    
Final Fight: Transition
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_trans_final = 
{
	--description = "TEMP DESC - Final Transition",
	--gotoVolume = VOLUMES.tv_end_trans_final,
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_finale,
	next = {"goal_finalfight"};
}

function w2_tsunami_station.goal_trans_final.Start():void
	composer_stop_show (var_tsunami_pulse);

		--	NARRATIVE CALL
		CreateThread (tsunami_finalfight_load);
	CreateThread (ff_objcon_10);
	CreateThread (ff_objcon_20);
	CreateThread (ff_objcon_30);
	CreateThread (ff_objcon_40);
	CreateThread (ff_snapshut);
	CreateThread (watcher_watch_1);
	CreateThread (watcher_watch_2);
	CreateThread (watcher_watch_3);
	CreateThread (watcher_watch_4);
	CreateThread (arbydog_feeder);
	CreateThread (ff_trans_aispawner);
	CreateThread (ff_arbiter_follows);
	--CreateThread (title_objective_regroup);
	CreateThread (ff_create_crates);
	MusketeersOrderTurnAllOn();
	kill_volume_enable(VOLUMES.playerkill_watervolume);
	game_save_no_timeout();
end

function ff_trans_arbstarter():void
	SleepUntil([| volume_test_players(VOLUMES.tv_startffcomps)], 1);
	CreateThread (arb_v_kni);
	CreateThread (guardian_bail);
	ai_place (AI.sq_ff_ally_dead);
	CreateThread(ffflock);
end
function arbydog_feeder():void
	repeat
		ai_magically_see(AI.sq_ff_arbiter, AI.gr_arbydogs);
		ai_magically_see(AI.gr_arbydogs, AI.sq_ff_arbiter);
		sleep_s(random_range(4,8));
		SleepUntil ([|	ai_living_count(AI.gr_arbydogs) <= 0], 30);
		sleep_s(random_range(1,5));
		SleepUntil ([|	ai_living_count(AI.gr_all_finalfight) <= 13], 30);
			if		(var_ff_objcon >=40)then
				SlipSpaceSpawn (AI.sq_arbydogs_40);
			elseif	(var_ff_objcon >=30)then
				SlipSpaceSpawn (AI.sq_arbydogs_30);
			else
				SlipSpaceSpawn (AI.sq_arbydogs_10);
			end
		SleepUntil ([|	ai_living_count(AI.gr_arbydogs) >= 1], 30, 540);
	until(false);
end
function cs_arbydog():void
	ai_prefer_target_ai(ai_current_actor, AI.sq_ff_arbiter, true);
	object_set_melee_attack_inhibited(ai_current_actor, true);				-- if pawns & arbiter try to melee one another,
																			-- they can get in a stalemate where the pawn just grinds 
																			-- against arby, inside the arc of his sword.
end
function arbydog_timer(dog:object):void		-- after x time, close distance to melee
	sleep_s(10);
	if(ai_living_count(object_get_ai(dog)) >= 1)then
		object_set_ranged_attack_inhibited(dog, true);
		print("arbydog close distance");
	end
end
function ff_trans_aispawner():void
-- ============= Greeters:
	SleepUntil ([|	volume_test_players (VOLUMES.tv_fft_startspawn)], 1);
	sleep_s (.6);	
	CreateThread(ff_spawn_greeter_sequence);
		-- 5 pawns
		--2 soldiers, 2 watchers

	SleepUntil (	[|		ai_living_count (AI.gr_ff_greeter_bishops) >= 1], 1);

-- ============= Dish:
	--CreateThread (finalfight_combat_musicstart);
	SleepUntil (	[|		ai_living_count (AI.gr_ff_greeters_all) <= 7
					or		volume_test_players (VOLUMES.tv_ff_objcon_20)
					], 1);
	SlipSpaceSpawnBlocking (AI.sq_dish_soldier_bulwark);
	sleep_s(3.5);
	SleepUntil (	[|		ai_living_count (AI.gr_fft_all) <= 8
					or		volume_test_players (VOLUMES.tv_ff_objcon_30)
					], 1);
	SlipSpaceSpawnBlocking(AI.sq_dish_pawns_1);
	sleep_s(.4);
--	gr_ff_dish_pawns_2
	ai_place(AI.gr_ff_dish_officer);

	SleepUntil ([|	ai_living_count (AI.gr_fft_all) <= 5], 1);
	GoalComplete (w2_tsunami_station.goal_trans_final);
end
function ff_spawn_greeter_sequence():void
	SlipSpaceSpawnBlocking (AI.sq_greeter_pawns_b);
	sleep_s(.4);
	if game_coop_player_count() >= 2 then
		sleep_s (.4);
		ai_place_with_slip_space (AI.sq_greeter_pawns_a);
	end
	ai_place(AI.sq_greeter_pawns_c);
	sleep_s(.4);
	ai_place(AI.gr_ff_greeter_pairs01);
	sleep_s(.4);
	ai_place(AI.gr_ff_greeter_pairs02);
	sleep_s(.4);
	ai_place(AI.gr_ff_greeter_bishops);
end
function ff_objcon_10():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_objcon_10)], 1);
	if(var_ff_objcon < 10)then
		var_ff_objcon = 10;
	end
end
function ff_objcon_20():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_objcon_20)], 1);
	if(var_ff_objcon < 20)then
		var_ff_objcon = 20;
	end
end
function ff_objcon_30():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_objcon_30)], 1);
	if(var_ff_objcon < 30)then
		var_ff_objcon = 30;
	end
end
function ff_objcon_40():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_objcon_40)], 1);
	if(var_ff_objcon < 40)then
		var_ff_objcon = 40;
	end
end
function ff_slipspace_TEMPEFFECT(thething1:string, theai:ai, thething2:effect_placement):void
	local obj:object = object_create (thething1);
	print ("the thing is", obj);
	object_cannot_die (obj, true);
	sleep_s (2);
	SleepUntil ([|	ai_living_count (theai)>= 1], 1);
	object_cannot_die (obj, false);
	object_hide (obj, true);
	object_destroy (obj);
	CreateEffectGroup (thething2);
end

--function finalfight_overlap():void
	--sleep_s (7);
	--SleepUntil ([|	ai_living_count (AI.gr_ff_greeters_all) <= 2], 1);
	--ai_place (AI.sq_ff_overlap1);
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_fft_2ndflr_spawn01)], 1);
	--sleep_s (7);
	--SleepUntil ([|	ai_living_count (AI.gr_ff_dish_all) <= 2], 1);
	--ai_place (AI.sq_ff_overlap2);
--end
--
--function ff_ai_objcon():void
	--ff_objcon = 0;
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_fft_2ndflr_spawn01)], 1);
	--ff_objcon = 30;
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_enemyspawn_finalarea)], 1);
	--ff_objcon = 60;
--end
--
function ff_arbiter_replenisher():void
	repeat
		SleepUntil([| ai_living_count(AI.sq_ff_arbiter) <= 0], 30);
		object_create_anew("arb_sword");
		Sleep(2);
		ai_place(AI.sq_ff_arbiter);
	until(false)
end
function ff_arbiter_follows():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arbiterfollow)], 1);
	ff_arbiterfollow = true;
end

function ff_create_crates():void
	object_create_folder (MODULES.cr_finalfight_weaponcrates);
	object_create_folder (MODULES.cr_finalfight_crates);
	object_create_folder (MODULES.cr_finalfight_weapons);
end
function w2_tsunami_station.goal_trans_final.End():void
	print ("Goal Transition to Final Fight - Complete!");	
end
function watcher_watch_1():void
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tvl_watcher_1, 15, 15) 
				and volume_test_players(VOLUMES.tv_watcher_1)], 10);
	if(ai_living_count(AI.gr_all_finalfight) <= 15)then
		ai_place(AI.sq_watcher_add_1.spawnpoint03);
		if(		game_coop_player_count() >= 2
			or	ai_living_count(AI.gr_all_finalfight) <= 8
			)then
			ai_place(AI.sq_watcher_add_1.spawnpoint04);
			ai_place(AI.sq_watcher_add_1.spawnpoint05);
		end
	end
end
function watcher_watch_2():void
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tvl_watcher_2, 15, 15) 
				and volume_test_players(VOLUMES.tv_watcher_2)], 10);
	if(ai_living_count(AI.gr_all_finalfight) <= 15)then
		ai_place(AI.sq_watcher_add_2.spawnpoint03);
		if(		game_coop_player_count() >= 2
			or	ai_living_count(AI.gr_all_finalfight) <= 8
			)then
			ai_place(AI.sq_watcher_add_2.spawnpoint04);
			ai_place(AI.sq_watcher_add_2.spawnpoint05);
		end
	end
end
function watcher_watch_3():void
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tvl_watcher_3, 15, 15) 
				and volume_test_players(VOLUMES.tv_watcher_3)], 10);
	if(ai_living_count(AI.gr_all_finalfight) <= 15)then
		ai_place(AI.sq_watcher_add_3.spawnpoint03);
		if(		game_coop_player_count() >= 2
			or	ai_living_count(AI.gr_all_finalfight) <= 8
			)then
			ai_place(AI.sq_watcher_add_3.spawnpoint04);
			ai_place(AI.sq_watcher_add_3.spawnpoint05);
		end
	end
end
function watcher_watch_4():void
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tvl_watcher_4, 15, 15) 
				and volume_test_players(VOLUMES.tv_watcher_4)], 10);
	if(ai_living_count(AI.gr_all_finalfight) <= 15)then
		ai_place(AI.sq_watcher_add_4.spawnpoint03);
		if(		game_coop_player_count() >= 2
			or	ai_living_count(AI.gr_all_finalfight) <= 8
			)then
			ai_place(AI.sq_watcher_add_4.spawnpoint04);
			ai_place(AI.sq_watcher_add_4.spawnpoint05);
		end
	end
end
function ff_snapshut():void
			print("===================================================================");
			print("====================  SNAPSHUT CALLED!!!  =========================");
			print("===================================================================");
	repeat
		if	(	volume_test_players(VOLUMES.tv_interior_all) == false
			and MusketeersInVolume(VOLUMES.tv_interior_all) == false
			and	volume_test_players_lookat(VOLUMES.tv_look_ff_door, 25, 42) == false
			) then
			object_create("dm_ff_door");
--			CreateThread(arcade_cleanup);
--			prepare_to_switch_to_zone_set();
			prepare_to_switch_to_zone_set(ZONE_SETS.w2_tsunami_grand_finale);
			sleep_s(6);
			switch_zone_set(ZONE_SETS.w2_tsunami_grand_finale);
			sleep_s(1);
			-- Begin loom for next campaign mission here so we dont have a hitch
			LoomNextCampaignMission();
			print("===================================================================");
			print("====================  BAM - DOOR SHUT!!!  =========================");
			print("===================================================================");
			break;
		end
		Sleep(10);
	until(false)
end
function ff_door_look_at_test():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_look_ff_door, 25, 42) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function cs_watcher_add_1():void
	cs_fly_by(ai_current_actor, true, POINTS.watchers_ff.p04, 2);
end
function cs_watcher_add_2():void
	cs_fly_by(ai_current_actor, true, POINTS.watchers_ff.p05, 2);
end
function cs_watcher_add_3():void
	cs_fly_by(ai_current_actor, true, POINTS.watchers_ff.p06, 2);
end
function cs_watcher_add_4():void
	cs_fly_by(ai_current_actor, true, POINTS.watchers_ff.p07, 2);
end
--[[
███████╗██╗███╗   ██╗ █████╗ ██╗         ███████╗██╗ ██████╗ ██╗  ██╗████████╗   
██╔════╝██║████╗  ██║██╔══██╗██║         ██╔════╝██║██╔════╝ ██║  ██║╚══██╔══╝██╗
█████╗  ██║██╔██╗ ██║███████║██║         █████╗  ██║██║  ███╗███████║   ██║   ╚═╝
██╔══╝  ██║██║╚██╗██║██╔══██║██║         ██╔══╝  ██║██║   ██║██╔══██║   ██║   ██╗
██║     ██║██║ ╚████║██║  ██║███████╗    ██║     ██║╚██████╔╝██║  ██║   ██║   ╚═╝
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝      
                                                                                 
 ██████╗ █████╗ ██╗   ██╗ █████╗ ██╗     ██╗███████╗██████╗                      
██╔════╝██╔══██╗██║   ██║██╔══██╗██║     ██║██╔════╝██╔══██╗                     
██║     ███████║██║   ██║███████║██║     ██║█████╗  ██████╔╝                     
██║     ██╔══██║╚██╗ ██╔╝██╔══██║██║     ██║██╔══╝  ██╔══██╗                     
╚██████╗██║  ██║ ╚████╔╝ ██║  ██║███████╗██║███████╗██║  ██║                     
 ╚═════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝                     
Final Fight: Cavalier
------------------------------------------------------------------------------------
--]]


w2_tsunami_station.goal_finalfight = 
{
	--description = "TEMP DESC - Final Fight",
	--navPoint = FLAGS.tsulocke_crumb1,
	zoneSet = ZONE_SETS.w2_tsunami_finale,
	-- next = {"EndMission"};
}

function w2_tsunami_station.goal_finalfight.Start():void

		--	NARRATIVE CALL
		CreateThread (tsunami_finalfight_cavalier);

	CreateThread (finalfight_ai_spawn);
	MusketeersOrderTurnAllOn();
	kill_volume_enable(VOLUMES.playerkill_watervolume);
	game_save_no_timeout();
	--CreateThread (title_objective_clear);
	SleepUntil ([|	finalfight_encounter_end == true], 1);
	
--	SleepUntil ([|	NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__final_fight__after_warden_s_dea)], 1);
	sleep_s (3);
	--CreateThread (finalfight_combat_musicend);
	--sleep_s (2);
	--missing_content_text ("CUTSCENE: Arbiter troops arrive in Phantom. Palmer arrives in Pelican...", 300);
	--print ("CUTSCENE: Arbiter troops arrive in Phantom. Palmer arrives in Pelican...");
	--sleep_s (3);
	--missing_content_text ("CUTSCENE: Osiris and Palmer barely make it to the Guardian.", 300);
	--print ("CUTSCENE: Osiris and Palmer barely make it to the Guardian.");

	GoalComplete (w2_tsunami_station.goal_finalfight);
end

function finalfight_ai_spawn():void
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_ff_enemyspawn_finalarea)], 1);	
	--************ STARTING WAVE 1
	
	---
	CreateThread (ff_ww1_spawn_sequence);
	CreateThread (SlipSpaceSpawn, AI.gr_ff_ww1_all);
	sleep_s(1);
	SleepUntil ([|	ai_living_count (AI.gr_ff_ww1_all) >= 1], 1);
	sleep_s(1);
	SleepUntil ([|	ai_living_count (AI.gr_ff_ww1_all) <= 1], 1);
	game_save_no_timeout();
	sleep_s (1);

	---
	CreateThread (ff_ww2_spawn_sequence);
	sleep_s (6);
	b_finalfight_guardian_singing_2 = true;			--	For Narrative
	SleepUntil ([|	ai_living_count (AI.gr_ff_ww2_all) <= 3], 1);	
	game_save_no_timeout();
	--************ STARTING WAVE 3
	sleep_s (3);

	---
	CreateThread (ff_ww3_spawn_sequence);
	--CreateThread (finalfight_warden_musicstart);
	ff_cavalierarrival = true;
	sleep_s (5);
	ai_place_with_slip_space (AI.sq_ww3_knights);
	sleep_s (5);
	ai_place_with_slip_space (AI.sq_ww3_pawns);
	if game_coop_player_count() >= 2 then
		sleep_s (4);
		ai_place_with_slip_space (AI.sq_ww3_soldiers);
	end
	SleepUntil ([|	ai_living_count (AI.sq_ww3_cavalier) <= 0], 1);
	sleep_s (7);
	CreateThread (ff_dissolve);
	CreateThread (audio_warden_musicend);
	print ("AI are all dead, calling in Palmer now!");
	finalfight_encounter_end = true;
end

function ff_ww1_spawn_sequence():void
	SlipSpaceSpawnBlocking(AI.sq_ww1_fireteam_1);
	ff_arbiterstayback = true;
	sleep_s(.4);
	ai_place(AI.sq_ww1_fireteam_2);
end
function ff_ww2_spawn_sequence():void
	SlipSpaceSpawnBlocking(AI.gr_ff_ww2_officers);
	sleep_s(.4);
	ai_place(AI.gr_ff_ww2_pawns);
	sleep_s(.4);
	ai_place(AI.gr_ff_ww2_soldier_pair);
	ff_arbiterstayback = true;
end
function ff_ww3_spawn_sequence():void
	SlipSpaceSpawnBlocking(AI.sq_ww3_cavalier);
	sleep_s(.4);
end
function ff_ai_counter():void
	local count:number = 0
	repeat
		count = ai_living_count(AI.gr_all_finalfight);
		print("count = ", count);
		Sleep(30);
	until(false)
end


function w2_tsunami_station.goal_finalfight.End():void
	--	PLACE SCRIPTS/ETC. THAT YOU WANT TO FIRE OFF BEFORE MOVING TO NEXT GOAL.
	print ("Goal Final Fight - Complete!");
--	sleep_s (1.5);
	fade_out (0,0,0,60);
--	fade_in (0,0,0,30);
	sleep_s (1);
	CreateThread (ff_cleanup);
	CreateThread(foffflock);
	CreateThread(stop_valid_composition, v_interior_theater );
	composer_stop_all();
--	CreateThread(fade_in_plz);					--8/20/2015 https://entomo:8443/browse/OSR-143043
	CinematicPlay ("cin_160_vadamharbor");
	EndMission (w2_tsunami_station);
end
function fade_in_plz():void
	Sleep(1);
	fade_in (0,0,0,30);
end

function ff_cleanup()

--adding this function to cleanup guys before cinematic, as per OSR-149461

	ai_erase (AI.sq_ff_ally_dead);
	ai_erase (AI.sq_ff_ally_phantom);
	ai_erase (AI.sq_ff_ally_reinforce);

end


function ff_dissolve()

	repeat

		Sleep (2);
		damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), ai_get_object(AI.gr_finalfight_all));
		Sleep (2);
		print ("running");
	
	until ai_living_count (AI.gr_finalfight_all) <= 0;

	print ("aaaaand, done.");

end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--[[ ---------------------------------------------------------------------------------------------- demo & e3
                         _______   ________  __       __   ______          ___            ________   ______  
                        /       \ /        |/  \     /  | /      \        /   \          /        | /      \ 
 ____  ____  ____       $$$$$$$  |$$$$$$$$/ $$  \   /$$ |/$$$$$$  |      /$$$  |         $$$$$$$$/ /$$$$$$  |
/    |/    |/    |      $$ |  $$ |$$ |__    $$$  \ /$$$ |$$ |  $$ |      $$ $$ \__       $$ |__    $$ ___$$ |
$$$$/ $$$$/ $$$$/       $$ |  $$ |$$    |   $$$$  /$$$$ |$$ |  $$ |      /$$$     |      $$    |     /   $$< 
/    |/    |/    |      $$ |  $$ |$$$$$/    $$ $$ $$/$$ |$$ |  $$ |      $$ $$ $$/       $$$$$/     _$$$$$  |
$$$$/ $$$$/ $$$$/       $$ |__$$ |$$ |_____ $$ |$$$/ $$ |$$ \__$$ |      $$ \$$  \       $$ |_____ /  \__$$ |
                        $$    $$/ $$       |$$ | $/  $$ |$$    $$/       $$   $$  |      $$       |$$    $$/ 
                        $$$$$$$/  $$$$$$$$/ $$/      $$/  $$$$$$/         $$$$/$$/       $$$$$$$$/  $$$$$$/  
                                                                                                             
                                                                                                             
--]] ---------------------------------------------------------------------------------------------- demo & e3


--[[ ---------------------------------------------------------------------------------------------- demo & e3
---------------------------------------- demo arcade
--]] ---------------------------------------------------------------------------------------------- demo & e3

w2_tsunami_station.goal_demo_arcade = 
{
	gotoVolume = VOLUMES.tv_end_arcade,
	zoneSet = ZONE_SETS.w2_tsunami_arcade,
	next = {"goal_demo_destructionalley"};
}
function w2_tsunami_station.goal_demo_arcade.Start():void
	v_is_demo = true;
	CreateThread(demo_arcade_kill_threads_and_restart);												-- kill sequence if it's already running. Then start sequence.
end
function w2_tsunami_station.goal_demo_arcade.End():void
	object_destroy_folder(MODULES.demo_arcade);
	print ("");	
end
--[[ ---------------------------------------------------------------------------------------------- demo & e3
---------------------------------------- demo destructionalley
--]] ---------------------------------------------------------------------------------------------- demo & e3

w2_tsunami_station.goal_demo_destructionalley = 
{
	gotoVolume = VOLUMES.tv_interior_dampen,
	zoneSet = ZONE_SETS.w2_tsunami_destruction,
	next = {"goal_demo_interior"};
}

-- NOTE:	So far this is just as a copy/paste
--			of the mainline mission's goal

function w2_tsunami_station.goal_demo_destructionalley.Start():void
	v_is_demo = true;
	-- play comp functions

	CreateThread (destruction_guardian_pulse);			-- tv_pulse_comp_start, "vin_tsunami_destruction_alley"
	CreateThread (destruction_pre_pulse);				-- tv_destruction_pre_pulse, b_pre_pulse = true
	CreateThread (player_ics_pulse_01);					-- tv_platfall_02, kick off staggerguard threads (unnecessary extra step?)  state.spartan
	CreateThread (spartan_choreographer);				-- tv_destruction_start, vin_ics_pulse_stagger_primary
	CreateThread (slide_ics_trigger);					-- 1:tv_slider == slide
	-- Boolean Triggers for Pulse Vignette
	CreateThread (dest_pulse_triggers);
	-- Demo Specific:
	CreateThread(demosys_thread_up_destruction_narrative);
	CreateThread(undampen_destruction_listener);
end
--[[ ---------------------------------------------------------------------------------------------- demo & e3
---------------------------------------- demo interiorA
--]] ---------------------------------------------------------------------------------------------- demo & e3
w2_tsunami_station.goal_demo_interior = 
{
	gotoVolume = VOLUMES.tv_end_bldg_interior,
	zoneSet = ZONE_SETS.w2_tsunami_destruction,
	next = {"goal_demo_fight"}
}
function w2_tsunami_station.goal_demo_interior.Start():void
	v_is_demo = true;
	CreateThread(demo_interior_kill_threads_and_restart);
end
function w2_tsunami_station.goal_demo_interior.End():void
	object_destroy_folder(MODULES.demo_interior);
	print ("");	
end
--[[ ---------------------------------------------------------------------------------------------- demo & e3
---------------------------------------- demo fight
--]] ---------------------------------------------------------------------------------------------- demo & e3
w2_tsunami_station.goal_demo_fight = 
{
	zoneSet = ZONE_SETS.w2_tsunami_finale,
	next = {"goal_finalfight"};
}
function w2_tsunami_station.goal_demo_fight.Start():void
	v_is_demo = true;
	composer_stop_show (var_tsunami_pulse);
	CreateThread(demo_fight_kill_threads_and_restart);
end
function w2_tsunami_station.goal_demo_fight.End():void
	print ("Goal Transition to Final Fight - Complete!");	
end

-- ========================================
-- ==== musketeer steering
-- =======================================
function muskbox(vol:volume, flag1:flag, dist1:number, flag2:flag, dist2:number, goal:table):void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	
	repeat
		b_pos_1_set = false;
		b_pos_2_set = false;
		SleepUntil( [| volume_test_players(vol)
					or IsGoalActive(goal) == false
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					-- stays with player
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					MusketeerDestSetPoint(obj, flag1, dist1);
				else
					MusketeerDestSetPoint(obj, flag2, dist2);
				end
			end
		SleepUntil( [| volume_test_players(vol) == false
					or IsGoalActive(goal) == false
					],1);
		MusketeerUtil_SetDestination_Clear_All()
	until (IsGoalActive(goal) == false);
	MusketeerUtil_SetDestination_Clear_All()
end

--[[
 ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝     ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Command Scripts
------------------------------------------------------------------------------------
--]]

function cs_introgrunt_1():void
	cs_enable_moving(true);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_intro.shoot1);
	sleep_s(4);
end
function cs_introgrunt_2():void
	cs_enable_moving(true);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_intro.shoot2);
	sleep_s(4);
end
function cs_introgrunt_3():void
	cs_enable_moving(true);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_intro.shoot3);
	sleep_s(4);
end
function intro_grunt_scramble():void
	SleepUntil(	[|	ai_living_count(AI.sq_turr0_front) <= 3
				and	intro_objcon >= 20
				], 5);
	cs_run_command_script(AI.sq_turr0_front, "cs_intro_grunt_scramble");
end
function cs_intro_grunt_scramble():void
	cs_push_stance(ai_current_actor, "flee");
		local dice:number = nil;
		dice = random_range(1, 6);
		if(dice == 1)then
			cs_go_to(POINTS.ps_intro.p0);
		elseif(dice == 2)then
			cs_go_to(POINTS.ps_intro.p1);
		elseif(dice == 3)then
			cs_go_to(POINTS.ps_intro.p2);
		elseif(dice == 4)then
			cs_go_to(POINTS.ps_intro.p3);
		elseif(dice == 5)then
			cs_go_to(POINTS.ps_intro.p4);
		elseif(dice == 6)then
			cs_go_to(POINTS.ps_intro.p5);
		end
end

function cs_tsu_arbiter()
	--object_set_scale (ai_current_actor, 1.1, 1);
	ai_cannot_die (ai_current_actor, true);
	print ("Arbiter is alive!");
end
function cs_tsu_arbiter_fight()
	--object_set_scale (ai_current_actor, 1.1, 1);
	ai_cannot_die (ai_current_actor, true);
	unit_drop_weapon(AI.sq_ff_arbiter.arbiter, unit_get_primary_weapon(AI.sq_ff_arbiter.arbiter), 1);
	Sleep(1); 
	object_create_if_necessary("arb_sword");
	unit_add_weapon (AI.sq_ff_arbiter.arbiter, OBJECTS.arb_sword, 3);
	ai_prefer_target_ai(AI.sq_ff_arbiter.arbiter, AI.gr_arbydogs, true);
end
function cs_tsu_arbiterally_position1()
	ai_cannot_die (ai_current_actor, true);
--	navpoint_track_object(ai_get_object(ai_current_actor), true);
	--sleep_s (7);
	--cs_go_to_and_face (POINTS.ps_turrettown_arbiterallypoints.p00, POINTS.ps_turrettown_arbiterallypoints.p00);
	--SleepUntil ([|	device_get_position (OBJECTS.dm_elev_1) > 0], 1);
end

function cs_tsu_arbiterally_position2()
	ai_cannot_die (ai_current_actor, true);
--	navpoint_track_object(ai_get_object(ai_current_actor), true);
	print ("Arbiter is alive!");
	--sleep_s (7);
	--cs_go_to_and_face (POINTS.ps_turrettown_arbiterallypoints.p01, POINTS.ps_turrettown_arbiterallypoints.p01);
	--SleepUntil ([|	device_get_position (OBJECTS.dm_elev_1) > 0], 1);
end
function cs_tsu_arbiterally_position3()
	ai_cannot_die (ai_current_actor, true);
	navpoint_track_object(ai_get_object(ai_current_actor), true);
	print ("Arbiter is alive!");
	sleep_s (7);
	--cs_go_to_and_face (POINTS.ps_turrettown_arbiterallypoints.p02, POINTS.ps_turrettown_arbiterallypoints.p02);
	--SleepUntil ([|	device_get_position (OBJECTS.dm_elev_1) > 0], 1);
end
function cs_tsu_arbiter_squad()
	--object_set_scale (ai_current_actor, 1.1, 1);
	sleep_s (.2);
	unit_doesnt_drop_items(ai_current_actor);
	ai_kill (ai_current_actor);
	print ("Arbiter's squadmates are dead!");
end
function cs_zealot_camo()
	print("camo_seek");
     Sleep(2);
     ai_set_active_camo(AI.sq_ub_landmark3_zealot, true);
end

function cs_grunt_scared()
	cs_push_stance(ai_current_actor, "flee");
end
--function firegrunts_immortal():void
	--sleep_s (5);
	--ai_cannot_die (AI.sq_dest_panicgrunts.grunt1, false);
	--ai_cannot_die (AI.sq_dest_panicgrunts.grunt2, false);
	--ai_cannot_die (AI.sq_dest_panicgrunts.grunt3, false);
--end
function cs_tsu_cavalier()
	ObjectSetSpartanTrackingEnabled(ai_get_object (AI.sq_ww3_cavalier), true);
end

function cs_ub_hunters()
	print ("Hunters! Run!");
end
function cs_ub_blockerplat_shade()
	print ("shade turret driver running to turret");
	cs_go_to_vehicle (ai_current_actor, true, OBJECTS.ub_blockerplat_shade);
end

function cs_kamikaze()
	ai_grunt_kamikaze (ai_current_actor);
end

function cs_ub_phantom()
	SleepUntil ([|	volume_test_players (VOLUMES.tv_spirit_unload)], 1);
	f_load_drop_ship (AI.sq_ub_phantom, AI.sq_ub_blockerplat_spiritdrop, true, false, "left");
	sleep_s (.1);
	print ("Spirit is unloading!");
	f_unload_drop_ship (AI.sq_ub_phantom, "left");
--	sleep_s (5);
	print ("Spirit is leaving!");
	cs_fly_to (POINTS.ps_ub_phantom_1.p13);
	--object_move_to_point (ai_vehicle_get_from_spawn_point (AI.sq_ub_phantom.spawnpoint80), 3, POINTS.ps_ub_phantom_1.p13);
	cs_fly_to (POINTS.ps_ub_phantom_1.p14);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_phantom.spawnpoint80), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub_phantom);
end

function cs_ub_phantom_2()
	--AI.sq_ub1_driveby_spirit01, POINTS.ps_ub_spirit_2
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_phantom2.driver), 0.01, 1 ); --Shrink size over time
	sleep_s (1);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_phantom2.driver), 1, 120 ); --Shrink size over time
	sleep_s (1);
	cs_fly_to (POINTS.ps_ub_phantom_2.p00);
	cs_fly_to (POINTS.ps_ub_phantom_2.p31);
	cs_fly_to (POINTS.ps_ub_phantom_2.p32);
	cs_fly_to (POINTS.ps_ub_phantom_2.p33);
	cs_fly_to (POINTS.ps_ub_phantom_2.p34);
	cs_fly_to (POINTS.ps_ub_phantom_2.p35);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_phantom2.driver), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub_phantom2);
end

function cs_ub1_driveby_spirit01()
	--AI.sq_ub1_driveby_spirit01, POINTS.ps_ub_spirit_2
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit01.spawnpoint151), 0.01, 1 ); --Shrink size over time
	sleep_s (1);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit01.spawnpoint151), 1, 120 ); --Shrink size over time
	sleep_s (1);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p01);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p23);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p24);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p25);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p26);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit01.spawnpoint151), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub1_driveby_spirit01);
end

function cs_ub1_driveby_spirit02()
	ai_enter_limbo (AI.sq_ub1_driveby_spirit02);
	SleepUntil ([|	ai_living_count  (AI.sq_ub1_driveby_spirit01) == 0], 1);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit02.spawnpoint152), 0.01, 1 ); --Shrink size over time
	sleep_s (1);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit02.spawnpoint152), 1, 120 ); --Shrink size over time
	sleep_s (1);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p01);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p23);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p24);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p25);
	cs_fly_to (POINTS.ps_ub_driveby_spirit_01.p26);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_driveby_spirit02.spawnpoint152), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub1_driveby_spirit02);
end

function cs_ub1_blocker_spirit()
	cs_ignore_obstacles (ai_current_actor, true);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_blocker_spirit.spawnpoint151), 0.01, 1 ); --Shrink size over time
	sleep_s (1);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_blocker_spirit.spawnpoint151), 1, 120 ); --Shrink size over time
	sleep_s (1);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p01);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p15);
	sleep_s (2);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p15_2);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p16);
	sleep_s (1);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p16_2);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p17);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p18);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p19);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p20);
	cs_fly_by (POINTS.ps_ub_blocker_spirit.p21);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub_blocker_spirit.spawnpoint151), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub_blocker_spirit);
end

function cs_ub2_landmark3_spirit()
--	cs_fly_by (POINTS.ps_ub2_lm3_spirit.p19);
--	cs_fly_by (POINTS.ps_ub2_lm3_spirit.p20);
	cs_fly_by (POINTS.ps_ub2_lm3_spirit.p21);
--	cs_fly_by (POINTS.ps_ub2_lm3_spirit.p22);
	cs_fly_by (POINTS.ps_ub2_lm3_spirit.p27);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub2_landmark3_spirit.spawnpoint153), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub2_landmark3_spirit);
end

function cs_ub2_lm3_spiritdropoff()
	ai_set_blind(ai_current_actor, true);
--	SleepUntil ([|	volume_test_players (VOLUMES.tv_walkway_sniper_spawn)], 1);
	f_load_drop_ship (AI.sq_ub2_lm3_spiritdropoff, AI.sq_ub_landmark3_reinforce, true, false, "left");	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	f_load_drop_ship (AI.sq_ub2_lm3_spiritdropoff, AI.sq_ub_landmark3_rear, true, false, "left");	--	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	sleep_s (1);	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	print ("Spirit is unloading!");	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	f_unload_drop_ship (AI.sq_ub2_lm3_spiritdropoff, "left");	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	sleep_s (5);	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	TEMP UNTIL SPIRIT IS FIXED
	cs_fly_by (POINTS.ps_ub2_lm3_spiritdropoff.p1);
	cs_fly_by (POINTS.ps_ub2_lm3_spiritdropoff.p2);
	cs_fly_by (POINTS.ps_ub2_lm3_spiritdropoff.p3);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub2_lm3_spiritdropoff.driver), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub2_lm3_spiritdropoff);
end

function cs_ub1_lm1_spirit()
	SleepUntil ([|	volume_test_players (VOLUMES.tv_greenplat_spawn)
					or	ub1_objcon >= 100													-- I just use this for testing	
				], 1);
	sleep_s (10);
	cs_fly_to (POINTS.ps_ub1_lm1_spirit.p00);
	cs_fly_to (POINTS.ps_ub1_lm1_spirit.p28);
	cs_fly_to (POINTS.ps_ub1_lm1_spirit.p29);
	cs_fly_to (POINTS.ps_ub1_lm1_spirit.p30);
	object_set_scale ( ai_vehicle_get_from_spawn_point (AI.sq_ub1_lm1_spirit.spawnpoint152), 0.01, 180 ); --Shrink size over time
	sleep_s (4);
	ai_erase (AI.sq_ub1_lm1_spirit);
end

function cs_ff_phantom()
	print ("FF Ally Phantom is a thing that is happening.");
	sleep_s (4);
	damage_object(ai_vehicle_get_from_spawn_point(AI.sq_ff_ally_phantom.driver), "body", 2000); 
	print ("FF Ally Phantom is DEEEEEAAAAAAAAAAAAD.");
	--cs_fly_to (POINTS.ps_ff_allyphantom.p0);
	--cs_fly_to (POINTS.ps_ff_allyphantom.p01);
	--cs_fly_to (POINTS.ps_ff_allyphantom.p02);
	--cs_fly_to (POINTS.ps_ff_allyphantom.p03);
	--f_load_drop_ship (AI.sq_ff_ally_phantom, AI.sq_ff_ally_reinforce, true, false, "right");
	--sleep_s (1);
	--print ("Phantom is unloading!");
	--f_unload_drop_ship (AI.sq_ff_ally_phantom, "right");
end

function cs_buildingint_soldier()
	sleep_s (1);
	ai_erase (ai_current_actor);
end

--[[
███╗   ███╗██╗███████╗ ██████╗       ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
████╗ ████║██║██╔════╝██╔════╝       ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██╔████╔██║██║███████╗██║            ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║╚██╔╝██║██║╚════██║██║            ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
██║ ╚═╝ ██║██║███████║╚██████╗██╗    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Misc. Scripts
------------------------------------------------------------------------------------
--]]

function tsunami_checkpoint_save(triggervolume:volume):void
	SleepUntil ([|	volume_test_players (triggervolume)], 5);
	game_save_no_timeout();
	print ("Game Save (No Timeout) Initiated. Saving When safe.");
end
function disable_kill_volumes_on_main_path():void
	kill_volume_disable(VOLUMES.playerkill_watervolume);
	kill_volume_disable(VOLUMES.kill_destruction_kill_zone);
end
function f_elevator_activate(device:object, activator:player)
	print ("A button has been pressed! Quick, let's go into FIRST PERSON TO PRESS IT!");
	if device == OBJECTS.dc_elevator1 then
		g_ics_player = activator;
		
		print(g_ics_player);
--		teleport_player_to_flag(activator, FLAGS.fl_elevator_button_press_1, false);
		composer_play_show ("button_press_1");
		print ("playing ICS of Elev 1 Button Press");
	end
	if device == OBJECTS.dc_elevator2 then
		g_ics_player = activator;
		print(g_ics_player);
--		teleport_player_to_flag(activator, FLAGS.fl_elevator_operate, false);
		composer_play_show ("button_press_2");
		CreateThread(audio_elevator_buttonpress_b);
		print ("playing ICS of Elev 2 Button Press");
	end
end
global b_ship_crashed:boolean = false
function destruction_alley_player_killer():void
	-- doomcruiser function!
	SleepUntil(	[|	b_ship_crashed == true], 2);												-- flipped within composition
	for _, spartan in ipairs (spartans()) do
		if(volume_test_object(VOLUMES.tv_destruction_kill_zone, spartan))then
			print(spartan, " in kill zone. Kill them.");
			if(IsPlayer(spartan))then
				RunClientScript("player_explosion", spartan);										-- play fx in the players face
				SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2tsunami_destruction\018_vin_cp_tsunamidestruction_doomcruiser_crash.sound'), nil, 1);
				CreateThread(delayed_fade, unit_get_player(spartan));
			end
		end
	end
	kill_volume_enable(VOLUMES.kill_destruction_kill_zone);
end
function delayed_fade(spartan:player)
	Sleep(30);
	fade_out_for_player(spartan);
end
function kill_tanaka():void
	RunClientScript("player_explosion", SPARTANS.locke);
end


function missing_content_text(text:string, ticks:number):void
	
	clear_all_text();

-- ==== handle text formatting
	if (text ~= nil) then
--		set_text_defaults();
		set_text_color(1, 1, 0.270588, 0);
		if(ticks ~= nil)then
			set_text_lifespan(ticks);
		else
			set_text_lifespan(120);
		end
		set_text_wrap(true, true);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.center);
		set_text_scale(1);
		set_text_indents(50, 50);
--		set_text_margins(50, 75, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);


		show_text("[MISSING CONTENT] ", text, " [MISSING CONTENT]");
	end

	if (ticks ~= nil)then
		Sleep(ticks);
	end

end

function audio_cinematic_mute_tsunami()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--	**********	**********	TEMP AUDIO STUFF, DELETE IT LATER. **********	**********
function sound_impulse_start_server(soundTag:tag, theObject:object, theScale:number):void
     RunClientScript("sound_impulse_start_client", soundTag, theObject, theScale);
end

function audio_newobjective_beep():void
     sound_impulse_start_server(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_newobjective.sound'), nil, 1);
end

function AnimateObjectThread( o: object, l: location, t1: number, t2: number ): void
	CreateThread(object_rotate_to_point, o,t1*2,l);
    object_move_to_point(o,t2*2,l);
end
function remoteServer.CinematicZoneSetSwitch():void
    switch_zone_set(ZONE_SETS.cin_155);
end

--## CLIENT
function remoteClient.firegrunts():void
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt1, "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt2, "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt3, "head");
end

function remoteClient.arcade_rubberband_temp(p_player:player)
	if (PLAYERS.local0 == p_player) then
		missing_content_text_client ("!WARNING: Players falling behind may be teleported!", 360);
		print ("WARNING: You're falling behind and may be teleported.");
	end
end

function remoteClient.player_explosion(deadplayer:object):void
	--play explosions
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
	Sleep(15)
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
	Sleep(15)
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
--	damage_object (deadplayer, "head", 2000);		--	--	--	--	--	--	REPLACE WITH REVIVE BYPASS
end

function missing_content_text_client(text:string, ticks:number):void
	clear_all_text();
	if (text ~= nil) then
		set_text_color(1, 1, 0.270588, 0);
		if(ticks ~= nil)then
			set_text_lifespan(ticks);
		else
			set_text_lifespan(120);
		end
		set_text_wrap(true, true);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.center);
		set_text_scale(1);
		set_text_indents(50, 50);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);
		show_text("[TEMP] ", text, " [TEMP]");
	end
	if (ticks ~= nil)then
		Sleep(ticks);
	end
end
function remoteClient.locke_move():void
	player_control_move_to_point(SPARTANS.locke, POINTS.ps_start_position.locke, 1, 1.25, 90);
end
function remoteClient.tanaka_move():void
	player_control_move_to_point(SPARTANS.tanaka, POINTS.ps_start_position.locke, 1, 1.25, 90);
end
function remoteClient.vale_move():void
	player_control_move_to_point(SPARTANS.vale, POINTS.ps_start_position.locke, 1, 1.25, 90);
end
function remoteClient.buck_move():void
	player_control_move_to_point(SPARTANS.buck, POINTS.ps_start_position.locke, 1, 1.25, 90);
end
function remoteClient.sound_impulse_start_client(soundTag:tag, theObject:object, theScale:number)
     sound_impulse_start(soundTag, theObject, theScale);
end

--[[
function dest_pawnreveal_01():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_pawnreveal_01) or volume_test_players (VOLUMES.tv_pawnreveal_02)], 1);
	b_pawnreveal_01 = true;
	print ("pawnreveal_01 triggered");
end
--]]



--** Font name is ANSI Shadow.
function remoteClient.client_pin_155_textures():void
	streamer_pin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain.material'));
	streamer_pin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain_fg2.material'));
	streamer_pin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain_fg.material'));
end

function remoteClient.client_unpin_155_textures():void
	streamer_unpin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain.material'));
	streamer_unpin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain_fg2.material'));
	streamer_unpin_tag(TAG('levels\campaignworld020\w2_tsunami\vista\cin155\materials\cin155_terrain_fg.material'));
end