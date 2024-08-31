--## SERVER

--[[
███╗   ███╗███████╗██████╗ ██╗██████╗ ██╗ █████╗ ███╗   ██╗                                         
████╗ ████║██╔════╝██╔══██╗██║██╔══██╗██║██╔══██╗████╗  ██║                                         
██╔████╔██║█████╗  ██████╔╝██║██║  ██║██║███████║██╔██╗ ██║                                        
██║╚██╔╝██║██╔══╝  ██╔══██╗██║██║  ██║██║██╔══██║██║╚██╗██║                                         
██║ ╚═╝ ██║███████╗██║  ██║██║██████╔╝██║██║  ██║██║ ╚████║                                         
╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝                                         
                                                                                                    
███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   
██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║    ███████║╚██████╗██║  ██║██║██║        ██║   
╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   
Meridian Mission Script
------------------------------------------------------------------------------------
--]]

--==============================
-- MERIDIAN FLOW
--==============================
	--	SECTION - BLINK - CRITICAL TRACKING OBJECT
	-- 1. INTRO_ELEVATOR_SCRIPTS 
	-- 2. OUTPOST_SCRIPT - f_blink_outpost
	-- 3. BOWL_1_DRIVE_SCRIPTS - f_blink_bowl_1 - OBJECTS.tracking_bowl_1_blip
	-- 4. BRIDGE_SCRIPTS -
	-- 5. BOWL_2_DRIVE_SCRIPTS - f_blink_bowl_2 - OBJECTS.tracking_bowl_2_blip
	-- 6. DRYGRANNIS_ARRIVAL_SCRIPTS - f_blink_drygrannis_arrival - OBJECTS.dm_drygrannis_door

--[[
 ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗     ███████╗
██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║     ██╔════╝
██║  ███╗██║     ██║   ██║██████╔╝███████║██║     ███████╗
██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║     ╚════██║
╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗███████║
 ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
Globals
------------------------------------------------------------------------------------
--]]

global b_welcometofight : boolean = false;
global b_welcometorest : boolean = false;
global g_b_left_enc : boolean = true;
global g_b_mid_enc : boolean = true;
global g_b_rear_enc : boolean = true;
global b_elevator_over : boolean = false;
global b_bowl_1_retreat : boolean = false;
global b_bowl_2_over : boolean = false;
global b_open_bridge : boolean = false;
global b_loadbowl2_enemies : boolean = false;
global b_open_elevator_exit : boolean = false;
global b_outpost_gate_hacked : boolean = false;
global b_lower2ndbridgedoor : boolean = false;
global b_start_sloan_console : boolean = false;
global g_n_assault_cleared : number = 0;
-- VIGNETTE GLOBALS
global num_icsbuttonpress : number = -1;
global g_n_miner_welcome : number = 0;
global miner_kick_door : number = 0;
global b_start_outpost_pelican : boolean = false;
global b_start_pelican_crash_bridge : boolean = false;
global b_vtol_kill_mining_ship : boolean = false;
global b_vtol_kill_still_alive : boolean = false;
global b_bridge_vtol_flyby : boolean = false;
global b_startwarthog_hijacking : boolean = false;
global b_mer_scorp_door_open : boolean = false;
global vin_additionallobby : number = 0;
global g_n_end_wave : number = 0;
global mer_tossed_hog_x:number = nil;
global mer_tossed_hog_y:number = nil;
global mer_tossed_hog_z:number = nil;
global tossed_hog_health:number = nil;

global s_thread_f_spawn_leftcave:thread = nil;
global s_thread_f_mer_sq_op_topright_mid_02:thread = nil;
global s_thread_f_mer_sq_op_upperleft:thread = nil;
global s_thread_f_mer_sq_op_right_interior:thread = nil;
global s_thread_f_mer_sq_op_mid_01:thread = nil;
global s_thread_f_mer_sq_op_rear_mid_01:thread = nil;
global s_thread_f_mer_sq_prom_b2_a_02:thread = nil;
global b_mer_outpost_door_closed : boolean = false;
global n_mer_correct_change:number = 0;

global s_thread_f_mer_bowl1_pawns_08_spawn:thread = nil;
global s_thread_f_mer_bowl1_pawns_03_04_spawn:thread = nil;
global s_thread_f_mer_bowl1_pawns_05_spawn:thread = nil;
global s_thread_f_mer_bowl1_pawns_06_07_wall_spawn:thread = nil;
global s_thread_f_mer_chicken_player:thread = nil;
global s_thread_f_mer_musk_regroup:thread = nil;
global n_miner_open_bridge:number = nil;

global n_vin_miner_welcome_party:number = nil;
global marines_guarding_door:number = nil;
global b_musk_switch_to_bowl1_2:boolean = false;
global b_mer_cheevo_01:boolean = false;
global b_mer_cheevo_02:boolean = false;
global b_mer_ready_to_close_outpost:boolean = false;
global b_mer_bowl_2_5_over:boolean = false;
global b_mer_bowl_2_7_over:boolean = false;
global b_mer_final_bowl_over:boolean = false;
global b_mer_musk_clear_for_bowl3:boolean = false;



--[[
███████╗████████╗ █████╗ ██████╗ ████████╗██╗   ██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
███████╗   ██║   ███████║██████╔╝   ██║   ██║   ██║██████╔╝    ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██║   ██║██╔═══╝     ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
███████║   ██║   ██║  ██║██║  ██║   ██║   ╚██████╔╝██║         ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝         ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Table and Startup Scrpts
------------------------------------------------------------------------------------
--]]

global t_Town_Assault_Blips : table =
	{
		FLAGS.flg_assault_loc_left,
		FLAGS.flg_assault_loc_mid,
		FLAGS.flg_assault_loc_rear
	}; -------------------------------------------------------	no idea what this is
	
global Meridian:table=
	{
		name = "w1_meridian",
		--breadCrumbs = {FLAGS.fl_bc_0, FLAGS.fl_bc_end},
		--description = "Meridian: Ride a space elevator to the planet surface and thwart a major attack on the mining colony",
		profiles = {STARTING_PROFILES.meridian_profile, STARTING_PROFILES.meridian_profile, STARTING_PROFILES.meridian_profile, STARTING_PROFILES.meridian_profile},
		points = POINTS.meridian_start_point,
		startGoals = {"goal_intro_elevator"},
		startFadeOut = "no",
		collectibles = {
						{objectName="dc_mer_collect_01", collectibleName="dc_mer_collect_01"},
						{objectName="dc_mer_collect_02", collectibleName="dc_mer_collect_02"},
						{objectName="dc_mer_collect_03", collectibleName="dc_mer_collect_03"},
						{objectName="dc_mer_collect_04", collectibleName="dc_mer_collect_04"},
						{objectName="dc_mer_collect_05", collectibleName="dc_mer_collect_05"},
						{objectName="dc_mer_collect_07", collectibleName="dc_mer_collect_07"},
						{objectName="dc_meridian_skull_iron", collectibleName="collectible_skull_iron"},
						
						}
	}

function StartMeridian()
	StartMission(Meridian);
end

function startup.InitMeridian()
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_meridian);
		fade_out(0, 0, 0, 0);
		StartMeridian();
	end
end

function Meridian.Start()
	print ("start meridian");
	ai_allegiance(TEAM.human, TEAM.player);
	CreateThread(f_mer_cheevo_01_call);
	CreateThread(f_mer_cheevo_02_call);
end

function f_mer_cheevo_01_call():void
	repeat
		for _,cheevo_player1 in pairs (players()) do
			if is_player_using_ads(cheevo_player1) then
				print("Player used ADS. No Achievement");
				b_mer_cheevo_01 = true;
			end
		end
		sleep_s(0.1);
	until b_mer_cheevo_01 == true;
end

function f_mer_cheevo_02_call():void
	repeat
		for _,cheevo_player2 in pairs (players()) do
			if unit_in_vehicle(cheevo_player2) then
				print("Player got in vehicle. No Achievement");
				b_mer_cheevo_02 = true;
			end
		end
		sleep_s(0.1);
	until b_mer_cheevo_02 == true;
end

--function f_mer_cheevo_01_call():void
--	for _,cheevo_player1 in ipairs (players()) do
--		CreateThread (f_mer_cheevo_01, cheevo_player1);
--	end
--end

--function f_mer_cheevo_01(cheevo_player1:player):void
--	SleepUntil ([| is_player_using_ads(cheevo_player1)], 3);
--	print("Player used ADS. No Achievement");
--	b_mer_cheevo_01 = true;
--end

--function f_mer_cheevo_02_call():void
--	for _,cheevo_player2 in ipairs (players()) do
--		CreateThread (f_mer_cheevo_02, cheevo_player2);
--	end
--end

--function f_mer_cheevo_02(cheevo_player2:player):void
--	SleepUntil ([| unit_in_vehicle(cheevo_player2)], 3);
--	print("Player got in vehicle. No Achievement");
--	b_mer_cheevo_02 = true;
--end

function Meridian.End()
	if b_mer_cheevo_01 == false then
		print("ACHIEVEMENT UNLOCKED!");
		CampaignScriptedAchievementUnlocked(6);
	end
	if b_mer_cheevo_02 == false then
		print("ACHIEVEMENT UNLOCKED!");
		CampaignScriptedAchievementUnlocked(5);
	end
	
	sys_LoadW1Hub();
end

--[[
██╗███╗   ██╗████████╗██████╗  ██████╗     ███████╗██╗     ███████╗██╗   ██╗ █████╗ ████████╗ ██████╗ ██████╗ 
██║████╗  ██║╚══██╔══╝██╔══██╗██╔═══██╗    ██╔════╝██║     ██╔════╝██║   ██║██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗
██║██╔██╗ ██║   ██║   ██████╔╝██║   ██║    █████╗  ██║     █████╗  ██║   ██║███████║   ██║   ██║   ██║██████╔╝
██║██║╚██╗██║   ██║   ██╔══██╗██║   ██║    ██╔══╝  ██║     ██╔══╝  ╚██╗ ██╔╝██╔══██║   ██║   ██║   ██║██╔══██╗
██║██║ ╚████║   ██║   ██║  ██║╚██████╔╝    ███████╗███████╗███████╗ ╚████╔╝ ██║  ██║   ██║   ╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝     ╚══════╝╚══════╝╚══════╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
Intro Elevator Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_intro_elevator = 
	{	description = "",
		--gotoVolume = VOLUMES.tv_5b,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.elevator_intro,
		--checkPoints = POINTS.ps_reefcity_start,
		next = {"goal_outpost"};
	}
	
function Meridian.goal_intro_elevator.Start() -- Cinematic ends and Osiris rides the space elevator down to the surface of Merdian
	SleepUntil([|AllClientViewsActiveAndStable()], 3);
	Sleep(1);
	CinematicPlay ("cin_065_elevator"); ----------------------------- TURN THIS ON once the cinematic is actually made. Ask Damon Conn for more info on it.
	Sleep(1);
	switch_zone_set(ZONE_SETS.elevator_intro);
	
	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.elevator_intro], 3);
	Sleep(1);
	TeleportNoFX();
	object_teleport(SPARTANS.locke, FLAGS.cf_mer_ele_locke );
	object_teleport(SPARTANS.vale, FLAGS.cf_mer_ele_vale );
	object_teleport(SPARTANS.tanaka, FLAGS.cf_mer_ele_tanaka );
	object_teleport(SPARTANS.buck, FLAGS.cf_mer_ele_buck );
	Sleep(1);
	MusketeerDestSetPoint(SPARTANS.vale, FLAGS.cf_mer_ele_vale, 0.25);
	MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.cf_mer_ele_tanaka, 0.25);
	MusketeerDestSetPoint(SPARTANS.buck, FLAGS.cf_mer_ele_buck, 0.25);
	
	sleep_s(1.5);
	fade_in(0, 0, 0, 90);
	game_save_no_timeout();
	Sleep(5);
	--MusketeerUtil_SetMusketeerGoal(FLAGS.cf_musk_go_elevator, 0.75);
	pup_play_show("space_elevator_ride");
	Wake(dormant.w1_elevator_scripts); -- elevator & outpost
	CreateThread(w1_meridian_1_elevator_VO); 
	sleep_s(3);
	CreateThread(audio_mission_start_music);
	CreateThread(f_navblip_exitelevator);
	prepare_to_switch_to_zone_set(ZONE_SETS.zs_010);
	CreateThread(f_mer_zone_set_proxy_handler);

	SleepUntil([| b_elevator_over == true ], 1);
	switch_zone_set(ZONE_SETS.zs_010);
	
  SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_010], 3);
  kill_volume_disable(VOLUMES.kill_mer_outpost_door);
  kill_volume_disable(VOLUMES.kill_mer_bridge_door_01);
  kill_volume_disable(VOLUMES.kill_mer_bridge_door_02);
  kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
  
  MusketeerUtil_SetDestination_Clear_All();
	GoalComplete(Meridian.goal_intro_elevator);
end

function f_mer_ele_pup_show_call():void
	pup_play_show ("pelican_crash_elevator_1");
end

function f_mer_vtol_crash_elevator_1_call():void
	pup_play_show ("vtol_crash_elevator_1");
end

function f_mer_pelican_crash_elevator_2_call():void
	pup_play_show ("pelican_crash_elevator_2");
end

function f_mer_vtol_crash_elevator_2_call():void
	pup_play_show ("vtol_crash_elevator_2");
end

--function f_mer_musk_regroup():void
--	SleepUntil([|volume_test_players(VOLUMES.w1_meridian_1_miners_meet) == true], 1);
--	
--	SleepUntil([|volume_test_players(VOLUMES.w1_meridian_1_miners_meet) == false], 1);
--	MusketeerUtil_SetDestination_Clear_All();
--	sleep_s(1);
--	--MusketeerUtil_SetMusketeerGoal(FLAGS.cf_mer_musk_outpost_door_regroup, 0.75);
--	MusketeerDestSetPoint(SPARTANS.vale, FLAGS.cf_mer_musk_outpost_dr_vale, 0.25);
--	MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.cf_mer_musk_outpost_dr_tanaka, 0.25);
--	MusketeerDestSetPoint(SPARTANS.buck, FLAGS.cf_mer_musk_outpost_dr_buck, 0.25);
--end

function f_elevator_flocks()	----------------------------------------------------------	I hate flocks. 
	flock_create("pelican_flock_elevator_far");
	flock_create("vtol_flock_elevator_far");
	flock_create("vtol_flock_elevator");
	flock_create("pelican_flock_elevator");
end

function f_kill_elevator_flocks()		---------------------------------------------------------- Stupid flocks.
	flock_delete("pelican_flock_elevator_far");
	flock_delete("vtol_flock_elevator_far");
	flock_delete("vtol_flock_elevator");
	flock_delete("pelican_flock_elevator");
end

--[[
 ██████╗ ██╗   ██╗████████╗██████╗  ██████╗ ███████╗████████╗
██╔═══██╗██║   ██║╚══██╔══╝██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝
██║   ██║██║   ██║   ██║   ██████╔╝██║   ██║███████╗   ██║   
██║   ██║██║   ██║   ██║   ██╔═══╝ ██║   ██║╚════██║   ██║   
╚██████╔╝╚██████╔╝   ██║   ██║     ╚██████╔╝███████║   ██║   
 ╚═════╝  ╚═════╝    ╚═╝   ╚═╝      ╚═════╝ ╚══════╝   ╚═╝   
Outpost Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_outpost = 
	{	description = "",
		gotoVolume = VOLUMES.tv_oupost_end,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.zs_010,
		checkPoints = POINTS.ps_outpost_start,
		next = {"goal_bowl_1_drive"};
	}

function Meridian.goal_outpost.Start()
	-- Scenery BSP threads
	--f_proxy_zs_010_add();

	--CreateThread(f_proxy_zs_010_remove);

	device_set_position(OBJECTS.dm_elevator_intro_door, 0.63);
	CreateThread(f_mer_elevator_door_navmesh);
	CreateThread(outpost_flocks);
	CreateThread(f_elevator_int_obj);
	--CreateThread(f_glassing); -- removing for OSR-96843
	CreateThread(f_mer_start_sloan_console);
	ai_place(AI.sq_interior_miners);
	vin_additionallobby = composer_play_show ("vin_lobby_miners_additional");
	pup_play_show("miners_guarding_door");
	CreateThread (f_looping_explosions);
	
	SleepUntil( [| list_count(players()) > 0 ], 10);
	CreateThread (f_first_miner_vo);
	pup_play_show ("vtol_kills_peli_outpost");
	
	SleepUntil([|volume_test_players(VOLUMES.tv_outpost_start) == true], 1);
	CreateThread(f_outpost_reveal_vo);
	CreateThread(f_device_setup);
	CreateThread(w1_meridian_one_startup);
	CreateThread(f_outpost_rocket_door_control);
	CreateThread(f_reserve_outpost_turret_seats);
	CreateThread(f_meridian_garbage_collection);
	
	SleepUntil([|b_open_elevator_exit == true], 1);
	CreateThread(f_create_door_alarm);
	CreateThread(audio_outpost_opening_music);
	CreateThread(SlipSpaceSpawn , AI.sq_mer_outpost_door_initial);
	sleep_s(1);
	device_set_position (OBJECTS.dm_spelevator_door, 0.751);				---------------------------	DOOR TO OUTPOST IS OPENING
	Sleep(1);
	MusketeerUtil_SetDestination_Clear_All();
	CreateThread(f_mer_outpost_door_navmesh);
	CreateThread(f_turret_door_vig);
	ObjectSetSpartanTrackingEnabled(OBJECTS.elevexit_door_tracking, false);
	sleep_s (2);
	s_thread_f_spawn_leftcave = CreateThread(f_spawn_leftcave);
	b_start_outpost_pelican = true;
	sleep_s (4);
	CreateThread(f_place_outpost_init_ai);		--			--			--			--	Spawns AI
	CreateThread(f_outpost_explosion);
	--object_damage_damage_section(OBJECTS.cr_outpost_fuel_silo, "default", 500);
	GoalThread(f_damn_fine_cola);
	CreateThread(f_meridian_chapter_title);
	sleep_s (2);
	CreateThread(f_outpost_tracking_objects); -- Sets up tracking for Outpost objects
	CreateThread(f_turnofftracking_outpost);
	
	--SleepUntil([|volume_test_players(VOLUMES.tv_inside_elevator) == false], 1);
	-- chaning this for coop, need to get players out, if player stays behind, this never triggers.
	-- OSR-149833
 	SleepUntil([|volume_test_players(VOLUMES.tv_mer_out_of_outpost_01)], 3);
	-- end
	
	sleep_s(1);
	CreateThread(f_cacheblip_sniperperch);
	CreateThread(f_navblip_outpostdoor);
	CreateThread(f_outpost_saves,VOLUMES.tv_ammo_bottom_right);
	CreateThread(f_outpost_saves,VOLUMES.tv_out_rockets);
	CreateThread(f_outpost_saves,VOLUMES.tv_outpost_sniper_save);
	CreateThread(f_outpost_saves,VOLUMES.tv_outpost_auto_turret);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_red_shirt)], 1);
	b_mer_ready_to_close_outpost = true;
	device_set_position(OBJECTS.dm_spelevator_door, 0);
	
	SleepUntil([|device_get_position (OBJECTS.dm_spelevator_door) <= 0.35], 1);
	kill_volume_enable(VOLUMES.kill_mer_outpost_door);
	
	SleepUntil([|device_get_position (OBJECTS.dm_spelevator_door) == 0], 1);
	device_set_power(OBJECTS.dm_spelevator_door, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_spelevator_door, true);
	b_mer_outpost_door_closed = true
	sleep_s(1);
	--volume_teleport_players_inside (VOLUMES.tv_lobby_teleport, FLAGS.fl_teleport_outpost);
	f_volume_teleport_all_inside(VOLUMES.tv_lobby_teleport ,FLAGS.fl_teleport_outpost);
--	if	volume_test_object (VOLUMES.tv_lobby_teleport, SPARTANS.buck)	then
--			object_teleport (SPARTANS.buck, FLAGS.fl_teleport_outpost);
--	end
--	if	volume_test_object (VOLUMES.tv_lobby_teleport, SPARTANS.vale)	then
--			object_teleport (SPARTANS.vale, FLAGS.fl_teleport_outpost);
--	end
--	if	volume_test_object (VOLUMES.tv_lobby_teleport, SPARTANS.tanaka)	then
--			object_teleport (SPARTANS.tanaka, FLAGS.fl_teleport_outpost);
--	end
--	if	volume_test_object (VOLUMES.tv_lobby_teleport, SPARTANS.locke) then
--			object_teleport (SPARTANS.locke, FLAGS.fl_teleport_outpost);
--	end
	sleep_s(1);
	ai_erase_out_of_context();
	ai_erase(AI.miner_welcome_party);
	ai_erase(AI.miners_guarding_door);
	ai_erase(AI.sq_lobby_marines_idle);
	ai_erase(AI.sq_interior_miners);
	ai_erase(AI.miners_elevator_int);
	ai_erase(AI.sq_welcomeparty);
	KillThread(s_thread_mer_elevator_log);
	CreateThread(meridian_tutorials_start);
	--TutorialShowAllIfNotPerformed("training_ping_sub", TUTORIAL.Tracking, 15);
end

function f_mer_backup_lobby_kickout():void -- setting this up to make sure players are out of the lobby. OSR-144634
	if b_mer_ready_to_close_outpost == false then
		device_set_position(OBJECTS.dm_spelevator_door, 0);
		SleepUntil([|device_get_position (OBJECTS.dm_spelevator_door) <= 0.35], 1);
		kill_volume_enable(VOLUMES.kill_mer_outpost_door);
	
		SleepUntil([|device_get_position (OBJECTS.dm_spelevator_door) == 0], 1);
		device_set_power(OBJECTS.dm_spelevator_door, 0);
		ObjectOverrideNavMeshCutting(OBJECTS.dm_spelevator_door, true);
		b_mer_outpost_door_closed = true
		sleep_s(1);
		f_volume_teleport_all_inside(VOLUMES.tv_lobby_teleport ,FLAGS.fl_teleport_outpost);
	end
end


--function f_proxy_zs_010_add()
--	-- SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_020_add)], 1);
--	object_create("glassupper_b1_scenery_bsp");
--	object_create("glassupper_b2_scenery_bsp");
--	object_create("glassupper_b_vista_scenery_bsp");
--	object_create("bridge_scenery_bsp");
--end

function f_mer_elevator_door_navmesh():void
	SleepUntil([|device_get_position (OBJECTS.dm_elevator_intro_door) >= 0.55], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_elevator_intro_door, false);
	--MusketeerUtil_SetMusketeerGoal(FLAGS.cf_mer_after_elevator, 0.5);
	CreateThread(f_mer_musk_after_ele_buck);
	CreateThread(f_mer_musk_after_ele_vale);
	CreateThread(f_mer_musk_after_ele_tanaka);
end

function f_mer_musk_after_ele_buck():void
	MusketeerDestSetPoint(SPARTANS.buck, FLAGS.cf_mer_after_ele_buck_01, 0.5);
	--SleepUntil([|objects_distance_to_flag(SPARTANS.buck, FLAGS.cf_mer_after_ele_buck_01) <= 0.4], 1);
	--Sleep(50);
	--MusketeerUtil_SetDestination_Clear_All();
	--Sleep(50);
	--MusketeerDestSetPoint(SPARTANS.buck, FLAGS.cf_mer_after_ele_buck_02, 0.5);
end

function f_mer_musk_after_ele_vale():void
	MusketeerDestSetPoint(SPARTANS.vale, FLAGS.cf_mer_after_ele_vale_01, 0.6);
	--SleepUntil([|objects_distance_to_flag(SPARTANS.vale, FLAGS.cf_mer_after_ele_vale_01) <= 0.5], 1);
	--sleep_s(1);
	--MusketeerUtil_SetDestination_Clear_All();
	--sleep_s(1);
	--MusketeerDestSetPoint(SPARTANS.vale, FLAGS.cf_mer_after_ele_vale_02, 0.5);
end

function f_mer_musk_after_ele_tanaka():void
	MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.cf_mer_after_ele_tanaka_01, 0.6);
	--SleepUntil([|objects_distance_to_flag(SPARTANS.tanaka, FLAGS.cf_mer_after_ele_tanaka_01) <= 0.5], 1);
	--sleep_s(1);
	--MusketeerUtil_SetDestination_Clear_All();
	--sleep_s(1);
	--MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.cf_mer_after_ele_tanaka_02, 0.5);
end

function f_mer_outpost_door_navmesh():void
	SleepUntil([|device_get_position (OBJECTS.dm_spelevator_door) >= 0.72], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_spelevator_door, false);
	Sleep(10);
	MusketeerUtil_SetDestination_Clear_All();
	SleepUntil([| ai_living_count( AI.sq_mer_outpost_door_initial ) <= 0 ], 30);
	MusketeerUtil_SetMusketeerGoal(FLAGS.cf_mer_outpost_musk, 5);
	SleepUntil([|volume_test_players (VOLUMES.tv_mer_clear_musk_outpost_1)], 1);
	sleep_s(1);
	MusketeerUtil_SetDestination_Clear_All();
end

function f_mer_start_sloan_console():void
	SleepUntil([|volume_test_players (VOLUMES.tv_mer_console_sloan)], 1);
	b_start_sloan_console = true;
end

function f_mer_elevator_objective_change():void
	composer_stop_show(n_vin_miner_welcome_party);
	ai_set_objective(AI.miner_welcome_party_solo, "obj_lobby_front");
	sleep_s(2);
	MusketeerUtil_SetDestination_Clear_All();
	MusketeerDestSetPoint(SPARTANS.vale, FLAGS.cf_mer_musk_outpost_dr_vale, 1);
	MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.cf_mer_musk_outpost_dr_tanaka, 1);
	MusketeerDestSetPoint(SPARTANS.buck, FLAGS.cf_mer_musk_outpost_dr_buck, 1);
end

function f_mer_miner_raise_weapon():void
	cs_stow(AI.miner_welcome_party.female_miner_dragger, false);
end

function f_place_outpost_init_ai()	---------------------------------------------------------- The waves show up only if the Outpost encounter is still live
--PLACE INITIAL AI
	CreateThread (SlipSpaceSpawn , AI.sq_op_frontyard_left);--place frontyard_left_pawns
	sleep_s (random_range (1, 2));
	CreateThread (SlipSpaceSpawn , AI.sq_op_topright_mid_01);--place topright_mid_1
	s_thread_f_mer_sq_op_topright_mid_02 = CreateThread(f_mer_sq_op_topright_mid_02);
	sleep_s (random_range (1, 2));
	CreateThread(f_mer_sq_op_armory_front);
	s_thread_f_mer_sq_op_upperleft = CreateThread(f_mer_sq_op_upperleft);
	s_thread_f_mer_sq_op_right_interior = CreateThread(f_mer_sq_op_right_interior);
	sleep_s(1);
	ai_place(AI.sg_miners_outpost_all);
	CreateThread(f_mer_sg_miners_outpost_all_marker);
	--NavpointShowAllServer(AI.sg_miners_outpost_all, "ally");
	s_thread_f_mer_sq_op_mid_01 = CreateThread(f_mer_sq_op_mid_01);
	s_thread_f_mer_sq_op_rear_mid_01 = CreateThread(f_mer_sq_op_rear_mid_01);
	sleep_s (5);
	CreateThread (f_respawn_outpost_mid);
	CreateThread (f_respawn_rear_outpost_mid);
	CreateThread (f_outpost_chk_ai_count);
	sleep_s(3.25);
	
	SleepUntil([|	ai_living_count (AI.sg_fore_outpost_mainroad) >= 3], 1);
	sleep_s(3.25);
	
	SleepUntil([|	ai_living_count (AI.sg_fore_outpost_mainroad) <= 3], 1);
--WAVE 2
	if b_encounter_completed == false	then
		garbage_collect_now();
		CreateThread (SlipSpaceSpawn , AI.sq_op_rear_armory);--place rear_armory
		sleep_s (random_range (1, 2));
		CreateThread (SlipSpaceSpawn , AI.sq_op_rear_left);--place rear_outpost_left
		sleep_s (random_range (1, 2));
		CreateThread (SlipSpaceSpawn , AI.sq_op_rear_right_01);--place rear_outpost_right
		sleep_s (5);
		CreateThread (f_respawn_rear_outpost_right);
	end
	sleep_s(3.25);
	CreateThread(f_mer_backup_lobby_kickout);
	
	SleepUntil([|	ai_living_count (AI.sg_fore_outpost_mainroad) <= 3], 1);
--WAVE 3
	if b_encounter_completed == false	then
		garbage_collect_now();
		b_fallback_1 = true;	--	tells all upperlevel ai to retreat to ground rear
		n_tutorialpoint = 10;
		CreateThread (SlipSpaceSpawn , AI.sq_op_knight_entourage);
		sleep_s (random_range(2, 4));
		CreateThread (SlipSpaceSpawn , AI.sq_outpost_knight);
		CreateThread(audio_outpost_knightspawn_music);
		if game_coop_player_count() >= 2  then
			sleep_s(random_range(2, 3));
			SlipSpaceSpawn(AI.sq_outpost_knight_coop);  --bring the pain
		end	
	end
	sleep_s(5);
	
	SleepUntil([|	ai_living_count (AI.sg_fore_outpost_all) <= 0], 1);
	--CreateThread (audio_outpost_knightdead_music);
	sleep_s(3);
	--b_encounter_completed = true;
	CreateThread(f_open_doors);
	garbage_collect_now();
end

function f_mer_sg_miners_outpost_all_marker():void
	SleepUntil ([|ai_living_count(AI.sg_miners_outpost_all) > 0]);
		for _, ally in pairs (ai_actors (AI.sg_miners_outpost_all)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_op_armory_front():void
	SleepUntil([|b_mer_outpost_door_closed == true], 1);
	CreateThread (SlipSpaceSpawn , AI.sq_op_armory_front);--place Armory_front
end

function f_mer_sq_op_topright_mid_02():void
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sq_op_topright_mid_01) <= 0], 1);
	CreateThread(SlipSpaceSpawn , AI.sq_op_topright_mid_02);--place topright_mid_2
end

function f_mer_sq_op_upperleft():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_mer_upper_outpost)], 1);
	CreateThread (SlipSpaceSpawn , AI.sq_op_upperleft);--place upperleft
	sleep_s(4);
	CreateThread (f_respawn_upperleft_fore);
end

function f_mer_sq_op_right_interior():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_mer_sq_op_right_interior)], 1);
	CreateThread (SlipSpaceSpawn , AI.sq_op_right_interior);--place right_interior
end
	
function f_mer_sq_op_mid_01():void
	SleepUntil([|	volume_test_players (VOLUMES.tv_mer_mid_outpost)], 1);
	
	SleepUntil([|	ai_living_count (AI.sq_op_armory_front) <= 0], 1);
	CreateThread (SlipSpaceSpawn , AI.sq_op_mid_01);--place Outpost_mid_1
end

function f_mer_sq_op_rear_mid_01():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_mer_mid_outpost02)], 1);
	sleep_s(3.25);
	
	SleepUntil([|	ai_living_count (AI.sq_op_mid_01) <= 0], 1);
	CreateThread (SlipSpaceSpawn , AI.sq_op_rear_mid_01);--place Rear_Outpost_mid_1
end

--- removing for OSR-96843
--function f_glassing():void  
--	local b_helpfulcounter: number = 0;
--	if (game_difficulty_get_real() == DIFFICULTY.legendary)	then
--		repeat
--			SleepUntil([|volume_test_players (VOLUMES.tv_helpfulcounter)], 1);
--			
--			SleepUntil([|volume_test_players_lookat (VOLUMES.tv_helpfulcounter_lookat, 20, 20)], 1);
--			b_helpfulcounter = b_helpfulcounter + 1;
--			sleep_s (1);
--		until (b_helpfulcounter == 343);
--		sleep_s (1);
--		if	b_helpfulcounter == 343	then
--			composer_play_show ("vin_cleaningtime");
--		end
--	else
--		print ("Difficulty requirements not met. Not spawning Helpful Counter");
--	end
--end

function f_spawn_leftcave():void	---------------------------------------------------------- This will only happen if the Outpost encounter is still live
	SleepUntil([|volume_test_players (VOLUMES.tv_spawn_leftcave_01) or volume_test_players (VOLUMES.tv_spawn_leftcave_02)], 3);
	if	b_encounter_completed == false	then
		if	b_fallback_1 == false	then
			CreateThread (SlipSpaceSpawn ,AI.sq_op_leftcave);
		end
	end
end

function f_respawn_upperleft_fore()	---------------------------------------------------------- This will only happen if the Outpost encounter is still live
	SleepUntil([|ai_living_count(AI.sq_op_upperleft) <= 1], 1);
	if b_encounter_completed == false then
		if	b_fallback_1 == false	then
			SlipSpaceSpawn(AI.sq_op_upperleft);
		end
	end
end

function f_respawn_outpost_mid():void	---------------------------------------------------------- This will only happen if the Outpost encounter is still live
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sg_fore_op_mid) <= 0], 1);
	if b_encounter_completed == false then
		if	b_fallback_1 == false	then
		SlipSpaceSpawn(AI.sq_op_mid_02);
		end
	end
	sleep_s (4);
	
	SleepUntil([|ai_living_count(AI.sg_fore_op_mid) <= 0], 1);
	if b_encounter_completed == false then
		if	b_fallback_1 == false	then
		SlipSpaceSpawn(AI.sq_op_mid_03);
		end
	end
end

function f_respawn_rear_outpost_mid():void	---------------------------------------------------------- This will only happen if the Outpost encounter is still live
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sg_fore_op_rear_mid) <= 0], 1);
	if b_encounter_completed == false then
		if	b_fallback_1 == false	then
		SlipSpaceSpawn(AI.sq_op_rear_mid_02);
		end
	end
end

function f_respawn_rear_outpost_right():void	---------------------------------------------------------- This will only happen if the Outpost encounter is still live
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sg_fore_op_rear_right) <= 0], 1);
	sleep_s (3);
	if b_encounter_completed == false then
		if	b_fallback_1 == false	then
		SlipSpaceSpawn(AI.sq_op_rear_mid_02);
		end
	end
end

function f_outpost_tracking_objects()	---------------------------------------------------------- David did this. I think it turns on/off tracking in the outpost area
	local t_tracking:table={
	-- Security Gates at Outpost Exit
		OBJECTS.dm_exit_door_1,
		OBJECTS.dm_exit_door_2,
    -- Tactical Options     
		OBJECTS.dc_gun_button,
		OBJECTS.armory_rocket,
		OBJECTS.cr_outpost_generator,
	};
	for _,objects in ipairs (t_tracking) do
		ObjectSetSpartanTrackingEnabled( objects, true);
	end
	print ("Outpost objects now tracked");
end

function outpost_flocks():void
	flock_destroy ("mining_ship_flock_elevator");	--	--	--	--	--	--	--	--	Spawned in Elevator
	flock_create ("meridian_low_vtols_1");	--	--	--	--	--	--	--	--	--	--	Always on, never delete
	flock_create ("meridian_low_vtols_2");	--	--	--	--	--	--	--	--	--	--	Always on, never delete
	flock_create ("mining_ship_flock_outpost");	--	--	--	--	--	--	--	--	--	Delete in Drygrannis
	flock_create ("pelican_flock_outpost");	--	--	--	--	--	--	--	--	--	--	Delete in Drygrannis
	flock_create ("vtol_flock_outpost");--	--	--	--	--	--	--	--	--	--	--	Created in Outpost
end

function f_turnofftracking_outpost():void
	SleepUntil([|device_get_position(OBJECTS.dm_exit_door_2) > 0.0], 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_gun_button, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.cr_outpost_generator, false);
	--NavpointStopAllServer(AI.sg_miners_outpost_all);
end

function f_elevator_int_obj() -- displays the first mission objective once you exit the personel elevator
	SleepUntil([|volume_test_players(VOLUMES.tv_obj_elevator_interior) == true], 1);
	g_n_assault_cleared = 1;
	b_outpost_objective = true;
end

function f_meridian_chapter_title()
	f_chapter_title (TITLES.ct_meridian_1);
end

function f_meridian_garbage_collection() -- temp script to deal with perf issues. LIKELY REMOVE BEFORE SHIP
	repeat
		garbage_collect_now()
		sleep_s(20);
	until g_n_end_wave == 3
end

function f_turret_door_vig() -- script to play the vignette of the miners kicking the shoulder bash door for the auto turrets
	pup_play_show ("miners_kicking_door");
	
	SleepUntil([|volume_test_players(VOLUMES.tv_obj_right_top_1) == true], 1);
	miner_kick_door = 1;
end

function f_create_door_alarm() -- plays audio when the big door opens as you exit the elevator interior
	RunClientScript ("f_door_alarm");
end

function f_reserve_outpost_turret_seats() -- script to keep non null AI out of auto turrets
	ai_vehicle_reserve( OBJECTS.v_turret_1, true);
	ai_vehicle_reserve( OBJECTS.v_turret_2, true);
	ai_vehicle_reserve( OBJECTS.v_turret_3, true);
	ai_vehicle_reserve( OBJECTS.v_turret_4, true);
	ai_vehicle_reserve( OBJECTS.v_turret_5, true);
end

function f_first_miner_vo():void
	
	n_vin_miner_welcome_party = pup_play_show("miner_welcome_party");
	marines_guarding_door = pup_play_show("marines_guarding_door");
	
	SleepUntil([| volume_test_players (VOLUMES.tv_minersayshi)], 1);
	NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_MINER_MEET);
	g_n_miner_welcome = 1;
end

function f_damn_fine_cola() ---------------------------------------------------------- Eggs from Easter
	repeat
		SleepUntil ([| device_get_position(OBJECTS.dc_refreshments) >= 1], 3);
		SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_vendingmachine\004_dm_vendingmachine_buttonpress.sound'), OBJECTS.dc_refreshments, nil, 1);
		n_mer_correct_change = n_mer_correct_change + 1;
		device_set_position(OBJECTS.dc_refreshments, 0);
		device_set_power(OBJECTS.dc_refreshments, 0);
		if n_mer_correct_change == 3 then
			object_create_anew ("pistol_cola");
			object_set_velocity (OBJECTS.pistol_cola, 1, 5);
			print("pistol_spawned");
		end
		if n_mer_correct_change == 7 then
			object_create_anew ("shotgun_cola");
			object_set_velocity (OBJECTS.shotgun_cola, 1, 7);
			print("shotgun_spawned");
		end
		if n_mer_correct_change == 10 then
			object_create_anew ("lmg_cola");
			print("lmg_spawned");
		end
		sleep_s (1);
		device_set_power(OBJECTS.dc_refreshments, 1);
	until n_mer_correct_change == 10
	device_set_power(OBJECTS.dc_refreshments, 0);
end

function f_activator_get_vend_mer_01(trigger:object, activator:object)
	local this_activator:object = activator or PLAYERS.player0 ;
	if n_mer_correct_change == 3 then
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		--remoteClient.SoundImpulseStartClientPlayer(this_activator, TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	end
	if n_mer_correct_change == 7 then
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		--remoteClient.SoundImpulseStartClientPlayer(this_activator, TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	end
	if n_mer_correct_change == 10 then
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		--remoteClient.SoundImpulseStartClientPlayer(this_activator, TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	end
end

function f_outpost_reveal_vo()
	SleepUntil([|volume_test_players(VOLUMES.tv_open_big) == true], 1);
	RunClientScript("f_outpost_gen_spark");
	sleep_s (1);
	game_save_no_timeout();
	Wake(dormant.w1_facility_reveal);
end

function f_outpost_saves (location:volume)
	SleepUntil([|volume_test_players(location) == true], 3);
	game_save_no_timeout();
end

function f_outpost_chk_ai_count()	--------------------------------------------------------------------	This boolean is needed for narrative purposes
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count( AI.sg_fore_outpost_all ) <= 0], 2);
	b_all_outpost_enemies_dead = true;
end

function f_outpost_rocket_door_control() -- script for opening exit door if player ground pounds through roof of armory room - DE
	SleepUntil([|volume_test_players(VOLUMES.tv_enable_doordc_tracking)], 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_armory_door, true);
	object_destroy(OBJECTS.armory_cache);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_out_rockets) or b_encounter_completed == true], 3);
	
	SleepUntil([|device_get_position(OBJECTS.dc_armory_door) == 1], 1);
	sleep_s(1);
	device_set_position(OBJECTS.dm_out_rocket_door, 1);
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_armory_door, false);
	
	SleepUntil([|device_get_position(OBJECTS.dm_out_rocket_door) == 1], 1);
	device_set_power(OBJECTS.dc_armory_door, 0);
	device_set_power(OBJECTS.dm_out_rocket_door, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_out_rocket_door, false);
end

function f_outpost_test_vignette()
	ai_place (AI.sq_outpost_vignette);
end

function Meridian.goal_outpost.End()
	--CreateThread (audio_outpost_end_music);
	composer_stop_show (vin_additionallobby);
end


--[[
██████╗  ██████╗ ██╗    ██╗██╗          ██╗
██╔══██╗██╔═══██╗██║    ██║██║         ███║
██████╔╝██║   ██║██║ █╗ ██║██║         ╚██║
██╔══██╗██║   ██║██║███╗██║██║          ██║
██████╔╝╚██████╔╝╚███╔███╔╝███████╗     ██║
╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝     ╚═╝
 Bowl 1 Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_bowl_1_drive = 
	{	description = "",
		gotoVolume = VOLUMES.tv_bridge_start,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.zs_020,
		checkPoints = POINTS.ps_goal_bowl_1_drive,
		next = {"goal_bridge"};	
	}

--function f_proxy_zs_010_remove()
--	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_010_remove)], 1);
--	object_destroy(OBJECTS.bridge_scenery_bsp);
--	object_destroy(OBJECTS.glassupper_b1_scenery_bsp);
--	object_destroy(OBJECTS.glassupper_b_vista_scenery_bsp);
--end
	
function Meridian.goal_bowl_1_drive.Start()
	-- Launches the scripts for the 'drive' section of Meridian.
	CreateThread(f_navblip_bowl1_1);
	CreateThread(f_navblip_bridgedoor);
	Wake(dormant.w1_warthog_scripts); -- warthog ride through the bridge
	RunClientScript("f_crashed_ship_fx");
	CreateThread(f_prebridge_spawn);
	--CreateThread(f_musketeer_bowl_1_drive);
	CreateThread(f_mer_bowl1_musk_timer);
	CreateThread(f_mer_objective_3);
	CreateThread(f_despawn_outpost);
	CreateThread(f_spawn_bowl_1);
	CreateThread(f_bridge_crash_vig);
	game_save_no_timeout();
end

function f_prebridge_spawn():void
	SleepUntil([|volume_test_players (VOLUMES.tv_spawn_prebridge)], 2);
	sleep_s(2);
	ai_place(AI.sq_pro_drive);
	ai_place(AI.sg_drive);
	CreateThread(f_mer_sq_marines_drive_2_marker);
	CreateThread(f_mer_sq_marines_bridge_entrance_01_marker);
	CreateThread(f_mer_sq_marines_bridge_entrance_03_marker);
	CreateThread(f_mer_sq_marines_bridge_entrance_05_marker);
	
	sleep_s (1);
	CreateThread(f_check_drive_prometheans);
	game_save_no_timeout();
end

function f_mer_sq_marines_drive_2_marker():void
	SleepUntil ([|ai_living_count(AI.sq_marines_drive_2) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_marines_drive_2)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_marines_bridge_entrance_01_marker():void
	SleepUntil ([|ai_living_count(AI.sq_marines_bridge_entrance_01) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_marines_bridge_entrance_01)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_marines_bridge_entrance_03_marker():void
	SleepUntil ([|ai_living_count(AI.sq_marines_bridge_entrance_03) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_marines_bridge_entrance_03)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_marines_bridge_entrance_05_marker():void
	SleepUntil ([|ai_living_count(AI.sq_marines_bridge_entrance_05) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_marines_bridge_entrance_05)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_objective_3()
	ObjectiveShow (TITLES.ct_obj_meridian_3);
end

function f_despawn_outpost() -- script for deleting all AI, turrets and crates in outpost to save on perf overhead
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_1_close_outpost) == true], 60);
	sleep_s(8);
	device_set_position(OBJECTS.dm_exit_door_2, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_exit_door_2, true);

	SleepUntil([|	device_get_position(OBJECTS.dm_exit_door_2) <= 0.1], 60);
	device_set_power(OBJECTS.dm_exit_door_2, 0);
	CreateThread (f_teleport_outpost_slowfolks);
end

function f_teleport_outpost_slowfolks() -- teleports players out of the outpost before unloading it. Removes players from turrets before teleporting
	vehicle_unload(OBJECTS.v_outpost_chaingun_01, "");
	vehicle_unload(OBJECTS.v_outpost_chaingun_02, "" );
	unit_set_enterable_by_player(OBJECTS.v_outpost_chaingun_01, false);
	unit_set_enterable_by_player(OBJECTS.v_outpost_chaingun_02, false);
	volume_teleport_players_not_inside_with_vehicles(VOLUMES.tv_bowl_1_close_outpost, FLAGS.fl_teleport_outpost_slowfolks);
	sleep_s (0.25);
	f_volume_teleport_all_not_inside(VOLUMES.tv_bowl_1_close_outpost ,FLAGS.fl_teleport_outpost_slowfolks);
	sleep_s(3);
	CreateThread(f_mer_kill_all_left_in_outpost);
end

function f_mer_kill_all_left_in_outpost():void
	object_destroy_folder("cr_bsp_zs_010");
	--object_destroy_folder("cr_bsp_zs_010_02");
	object_destroy_folder("v_bsp_zs_010");
	
	f_mer_clear_allies(VOLUMES.nar_outpost_volume, AI.sg_miners_outpost_all);
	ai_erase(AI.sq_outpost_turrets);
	--ai_erase(AI.sg_miners_outpost_all);
	ai_erase(AI.sg_fore_op_topright_mid01);
	ai_erase(AI.sg_fore_outpost_upperareas);
	ai_erase(AI.sg_fore_outpost_mainroad);
	garbage_collect_now();
end

function f_spawn_bowl_1()
	SleepUntil([|volume_test_players(VOLUMES.tv_bridge_start) == true], 1);
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b1_pawns); -- spawn bowl 1 enemies
	s_thread_f_mer_bowl1_pawns_08_spawn = CreateThread(f_mer_bowl1_pawns_08_spawn);
	s_thread_f_mer_bowl1_pawns_03_04_spawn = CreateThread(f_mer_bowl1_pawns_03_04_spawn);
	s_thread_f_mer_bowl1_pawns_05_spawn = CreateThread(f_mer_bowl1_pawns_05_spawn);
	s_thread_f_mer_bowl1_pawns_06_07_wall_spawn = CreateThread(f_mer_bowl1_pawns_06_07_wall_spawn);
	sleep_s(0.2);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns01);
	sleep_s(0.2);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns02);
	game_save_no_timeout();
end

function f_mer_bowl1_pawns_08_spawn():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_bowl1_p08) == true], 1);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns08);
	garbage_collect_now();
end

function f_mer_bowl1_pawns_03_04_spawn():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_bowl1_p03_04) == true], 1);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns03);
	sleep_s(.5);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns04);
	garbage_collect_now();
end

function f_mer_bowl1_pawns_05_spawn():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_bowl1_p05) == true], 1);
	CreateThread (SlipSpaceSpawn ,AI.sq_prom_b1_pawns05);
	garbage_collect_now();
end

function f_mer_bowl1_pawns_06_07_wall_spawn():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_bowl1_p06_07) == true], 1);
	CreateThread(SlipSpaceSpawn ,AI.sq_prom_b1_pawns06);
	sleep_s(.5);
	CreateThread(SlipSpaceSpawn ,AI.sq_prom_b1_pawns07);
	sleep_s(.5);
	CreateThread(SlipSpaceSpawn ,AI.sq_prom_b1_soldier_wall);
	garbage_collect_now();
end

function f_bridge_crash_vig() -- plays vignette of pelican crashing into the bridge
	SleepUntil([|volume_test_players(VOLUMES.tv_bridge_crash_vign) == true], 1);
	pup_play_show("pelican_crash_bridge");	
end

function f_test_bridge()
	-- Test function to view the bridge events. (These events are included in 'f_drive_start' but this function includes no SleepUntils.)
	ai_place(AI.sg_drive);
	Sleep(10);
	CreateThread(f_check_drive_prometheans);
end

function f_musketeer_bowl_1_drive() -- script controling musketeer driving in bowl 1. only activates if player is in vehicle.
	repeat
		if b_musk_switch_to_bowl1_2 == false then
			MusketeerUtil_SetDestinationWhenDrivingPlayer (FLAGS.cf_mer_bowl_1_musk_drive_dest01, POINTS.ps_bowl_1_musk_drive01);
		else 
			MusketeerUtil_SetDestinationWhenDrivingPlayer (FLAGS.cf_mer_bowl_1_musk_drive_dest02, POINTS.ps_bowl_1_musk_drive02);
		end
		sleep_s (3);
	until (b_open_bridge == true)
end

function f_mer_bowl1_musk_timer():void
	sleep_s(20);
	b_musk_switch_to_bowl1_2 = true;
end

function f_open_bridge_door():void
	-- Opens the door at the bridge.
	CreateThread(f_bridge_door_alarm);
	composer_play_show("warthog_hijack");
	device_set_position(OBJECTS.dm_bridge_door, 0.64);
	
	SleepUntil([|device_get_position (OBJECTS.dm_bridge_door) >= .60], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_bridge_door, false);
	composer_stop_show(n_miner_open_bridge);
	CreateThread(f_musketeer_bowl_2_drive);
	--device_set_power(OBJECTS.dc_bridge_open_l, 0);
	--device_set_power(OBJECTS.dc_bridge_open_r, 0);
	--NavpointStopAllServer(AI.sq_marines_drive_2);
	--NavpointStopAllServer(AI.sq_marines_bridge_entrance_01);
	--NavpointStopAllServer(AI.sq_marines_bridge_entrance_03);
	--NavpointStopAllServer(AI.sq_marines_bridge_entrance_05);
end

function f_bridge_door_alarm()
	RunClientScript ("f_open_bridge_alarm");
end

function f_check_drive_prometheans()
	-- Miner opens the door when the prometheans are killed.
	CreateThread(f_mer_bridge_run_away);
	
	SleepUntil([|ai_living_count(AI.sq_pro_drive) <= 3], 1);
	--NavpointShowAllServer(AI.sq_pro_drive, "enemy");
	
	SleepUntil([|ai_living_count(AI.sq_pro_drive) <= 0], 1);
	Sleep(30);
	--b_bowl_1_retreat = true;
	game_save_no_timeout();
	sleep_s (1);
	n_miner_open_bridge = pup_play_show("miner_open_bridge");
	sleep_s (1);
	
	SleepUntil([|NarrativeQueue.HasConversationFinished(W1HubMeridian_Meridian_Station_BRIDGE_END) == true], 1);
	
	SleepUntil([|b_open_bridge == true], 1);
	MusketeerUtil_SetDestination_Clear_All();
	CreateThread(f_open_bridge_door);
	SleepUntil([|volume_test_players (VOLUMES.tv_mer_call_warthog_hijack)], 1);
	
	b_startwarthog_hijacking = true;
end

function f_mer_bridge_run_away():void
	SleepUntil([|ai_living_count(AI.sg_bowl1_test) <= 10], 1);
	b_bowl_1_retreat = true;
	KillThread(s_thread_f_mer_bowl1_pawns_08_spawn);
	KillThread(s_thread_f_mer_bowl1_pawns_03_04_spawn);
	KillThread(s_thread_f_mer_bowl1_pawns_05_spawn);
	KillThread(s_thread_f_mer_bowl1_pawns_06_07_wall_spawn);
	
	SleepUntil([|objects_distance_to_object(spartans(), AI.sg_bowl1_test) >= 30], 1);
	ai_kill(AI.sg_bowl1_test);
end

function f_musk_obj()
	ai_set_objective( AI.musketeers, "obj_musk_driving");
end

function Meridian.goal_bowl_1_drive.End()
	print ("Bowl 1 Goal is Complete!");
end

--[[
██████╗ ██████╗ ██╗██████╗  ██████╗ ███████╗
██╔══██╗██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝
██████╔╝██████╔╝██║██║  ██║██║  ███╗█████╗  
██╔══██╗██╔══██╗██║██║  ██║██║   ██║██╔══╝  
██████╔╝██║  ██║██║██████╔╝╚██████╔╝███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝
 Bridge Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_bridge = 
	{	description = "",
		gotoVolume = VOLUMES.tv_bridge_open,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.zs_020,
		checkPoints = POINTS.ps_goal_bridge,
		next = {"goal_bowl_2_drive"};
	}

function Meridian.goal_bridge.Start()
	print("____________ Meridian.goal_bridge.Start");
	CreateThread(dormant.w1_bridge_scripts);
	CreateThread (f_navblip_bridgeexit);

	CreateThread(f_proxy_zs_030_add);
	CreateThread(f_proxy_zs_030_remove);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_bridge_entrance) == true], 1);
	print("____________ Meridian.goal_bridge.Start VOLUMES.tv_bridge_entrance");
	CreateThread(vtol_attacks_bridge);
	CreateThread(f_mer_close_bowl1);
	CreateThread(f_mer_close_bridge);
	print("____________ Meridian.goal_bridge.Start DONE");
end

function f_proxy_zs_030_add()
	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_030_add) == true], 1);
	object_create("outpost_scenery_bsp");
end

function f_proxy_zs_030_remove()
	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_030_remove) == true], 1);
	object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
end

function vtol_attacks_bridge():void
	SleepUntil([|volume_test_players(VOLUMES.tv_vtol_spawn) == true], 1);
	pup_play_show ("vtols_attack_bridge");
end

function f_mer_close_bowl1():void	----------------------------	this script teleports stragglers when the bridge door closes
	print("______________ function close bowl1");
	SleepUntil([|volume_test_players (VOLUMES.tv_loadbowl2_bypass)], 1);
	print("______________ function close bowl1 in trigger");
	--CreateThread(f_mer_close_bridge);
	sleep_s(3);
	device_set_position(OBJECTS.dm_bridge_door, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_bridge_door, true);
	
	SleepUntil([|device_get_position (OBJECTS.dm_bridge_door) == 0], 1);
	kill_volume_enable(VOLUMES.kill_mer_bridge_door_01);
	device_set_power(OBJECTS.dm_bridge_door, 0);
	sleep_s(1.5);
	volume_teleport_players_inside_with_vehicles(VOLUMES.tv_teleport_bowl1, FLAGS.fl_bridge_teleport);
	sleep_s(0.5);
	f_volume_teleport_all_inside(VOLUMES.tv_teleport_bowl1 ,FLAGS.fl_bridge_teleport);
	b_lower2ndbridgedoor = true;
	CreateThread(f_mer_destroy_all_bowl1);
end

function f_mer_destroy_all_bowl1():void
	sleep_s(1);
	object_destroy_folder("cr_bsp_zs_020_bowl1");
	f_mer_clear_allies(VOLUMES.tv_bowl_1_close_outpost, AI.sg_miners_outpost_all);
	f_mer_clear_allies(VOLUMES.tv_bowl_1_close_outpost, AI.sq_marines_drive_2);
	f_mer_clear_allies(VOLUMES.tv_bowl_1_close_outpost, AI.sq_marines_bridge_entrance_01);
	f_mer_clear_allies(VOLUMES.tv_bowl_1_close_outpost, AI.sq_marines_bridge_entrance_03);
	f_mer_clear_allies(VOLUMES.tv_bowl_1_close_outpost, AI.sq_marines_bridge_entrance_05);
	garbage_collect_now();
end

function f_mer_close_bridge():void
	print("____________ starting close bridge thread");
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_close_bridge_down)], 1);
	print("____________ starting close bridge");
	device_set_position(OBJECTS.dm_bridge_door2, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_bridge_door2, true);
	
	SleepUntil([|device_get_position (OBJECTS.dm_bridge_door2) == 0], 1);
	kill_volume_enable(VOLUMES.kill_mer_bridge_door_02);
	device_set_power(OBJECTS.dm_bridge_door2, 0);
	volume_teleport_players_inside_with_vehicles (VOLUMES.tv_mer_bridge_out_now, FLAGS.fl_teleport_bridge);
	sleep_s(0.25);
	f_volume_teleport_all_inside(VOLUMES.tv_mer_bridge_out_now ,FLAGS.fl_teleport_bridge);
	b_loadbowl2_enemies = true;
	object_destroy_folder("cr_bsp_zs_020_no_destroy");
	object_destroy_folder("dm_bsp_zs_010_extractors");
	garbage_collect_now();
end

--[[
██████╗  ██████╗ ██╗    ██╗██╗         ██████╗ 
██╔══██╗██╔═══██╗██║    ██║██║         ╚════██╗
██████╔╝██║   ██║██║ █╗ ██║██║          █████╔╝
██╔══██╗██║   ██║██║███╗██║██║         ██╔═══╝ 
██████╔╝╚██████╔╝╚███╔███╔╝███████╗    ███████╗
╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚══════╝
 Bowl 2 Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_bowl_2_drive = 
	{	description = "",
		gotoVolume = VOLUMES.tv_drygrannis_arrival,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.zs_030,
		checkPoints = POINTS.ps_goal_bowl_2_drive,
		next = {"goal_drygrannis_arrival"};
	}
	
function Meridian.goal_bowl_2_drive.Start()
	CreateThread (f_bowl2_aiload);
	
	SleepUntil([|current_zone_set() == ZONE_SETS.zs_030], 1);

	--CreateThread(f_proxy_zs_040_remove);
	--CreateThread(f_proxy_zs_040_add);
	--CreateThread(f_proxy_zs_040_add_backtrack);

	CreateThread(f_navblip_bowl2);
	--CreateThread(f_musketeer_bowl_2_drive); -- moving to when the bridge door opens -KS 8/4/15
	CreateThread(f_cacheblip_bowl2_all);
	CreateThread(f_navblip_exitbowl2_1);
	CreateThread(f_navblip_exitbowl2_2);
	Wake(dormant.w1_bowl2_scripts);
	CreateThread(f_end_bridge_save);
	CreateThread(f_entered_scorpion_vo);
	CreateThread(f_mer_scorpion_door_control);
	GoalCreateThread(Meridian.goal_bowl_2_drive, f_give_player_scorpion);
	CreateThread(f_spawn_knight_hog_vignette);
end

--function f_proxy_zs_040_add()
--	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_040_add) == true], 1);
--	object_create("glassupper_a_scenery_bsp");
--end
--
--function f_proxy_zs_040_add_backtrack()
--	-- SleepUntil([|current_zone_set() == ZONE_SETS.zs_050], 1);
--	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_040_add_backtrack) == true], 1);
--	object_create("bridge_scenery_bsp");
--end
--
--function f_proxy_zs_040_remove()
--	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_zs_040_remove) == true], 1);
--	object_destroy(OBJECTS.bridge_scenery_bsp);
--end

function f_bowl2_aiload():void
	SleepUntil([|current_zone_set() == ZONE_SETS.zs_030], 1);
	
	CreateThread(f_mer_tossed_hog_invul);
	ai_place(AI.sq_bowl_2_scorpion_security);
	CreateThread(f_mer_sq_bowl_2_scorpion_security_marker);
	ai_place(AI.sq_bowl_2_miner_left);
	CreateThread(f_mer_sq_bowl_2_miner_left_marker);
	ai_place(AI.sq_bowl_2_miner_right);
	CreateThread(f_mer_sq_bowl_2_miner_right_marker);

	CreateThread(f_bowl2_welcomeparty);
	CreateThread(f_bowl2_rightscaffold);
	CreateThread(bowl2_spawnturrets);
	garbage_collect_now();
	sleep_s (random_range (1.5, 2.5));
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_b_02);
	sleep_s (random_range (1.5, 4));
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_a_01);
	sleep_s (random_range (1.5, 4));
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_a_03);
	sleep_s (random_range (1.5, 4));
	garbage_collect_now();
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_c_01);
	--CreateThread (f_spawn_bowl_2_exit);
	s_thread_f_mer_sq_prom_b2_a_02 =  CreateThread(f_mer_sq_prom_b2_a_02);
	sleep_s (random_range (1.5, 4));
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_c_02);
	sleep_s (random_range (1.5, 4));
	CreateThread (SlipSpaceSpawn, AI.sq_prom_b2_exit_lower);
	garbage_collect_now();
	CreateThread(f_musketeer_bowl_2_5_drive);
end

function f_mer_sq_bowl_2_scorpion_security_marker():void
	SleepUntil ([|ai_living_count(AI.sq_bowl_2_scorpion_security) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_bowl_2_scorpion_security)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_bowl_2_miner_left_marker():void
	SleepUntil ([|ai_living_count(AI.sq_bowl_2_miner_left) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_bowl_2_miner_left)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_bowl_2_miner_right_marker():void
	SleepUntil ([|ai_living_count(AI.sq_bowl_2_miner_right) > 0]);
		for _, ally in pairs (ai_actors (AI.sq_bowl_2_miner_right)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_mer_sq_prom_b2_a_02():void
	SleepUntil([|volume_test_players (VOLUMES.tv_mer_sq_prom_b2_a_02)], 1);
	CreateThread(SlipSpaceSpawn, AI.sq_prom_b2_a_02);
	garbage_collect_now();
end

function f_bowl2_welcomeparty():void
	SleepUntil ([|volume_test_players (VOLUMES.tv_neo_bowl2_welcome)], 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_mer_supply_bowl1_run1, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_mer_supply_bowl1_run2, false);
	CreateThread (SlipSpaceSpawn, AI.sq_neo_bowl2_welcome);
	garbage_collect_now();
end

function f_bowl2_rightscaffold():void
	SleepUntil([|volume_test_players (VOLUMES.tv_neo_bowl2_r_scaffold)], 1);
	CreateThread(SlipSpaceSpawn, AI.sq_neo_bowl2_r_scaffold);
	garbage_collect_now();
end

function bowl2_spawnturrets():void
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl2_spawnturrets_01) == true], 1);
	CreateThread (SlipSpaceSpawn, AI.sq_bowl_2_turrets_01);
	sleep_s(2);
	CreateThread (SlipSpaceSpawn, AI.sq_bowl_2_turrets_02);
	sleep_s(2);
	CreateThread (SlipSpaceSpawn, AI.sq_bowl_2_turrets_03);
	garbage_collect_now();
end

function f_end_bridge_save()
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_2_chkpnt) == true], 1);
	b_bridge_vtol_flyby = true; -- boolean for handling the transition from idle into the vtols flying towards the mouth of the bridge
	device_set_position(OBJECTS.dm_bridge_door, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_bridge_door, true);
	game_save_no_timeout();

	SleepUntil([|device_get_position (OBJECTS.dm_bridge_door) == 0], 1);
	device_set_power(OBJECTS.dm_bridge_door, 0);
end

function f_spawn_bowl_2_exit() -- sleeps until the player has killed a certain number of AI before spawning squads on exit of bowl 2
	--sleep_s(3);
	--SleepUntil([|ai_living_count(AI.sg_bowl_2_all) <= 32], 1);
	CreateThread(SlipSpaceSpawn ,AI.sq_prom_b2_exit_mid);
	sleep_s(3);
	CreateThread(SlipSpaceSpawn ,AI.sq_prom_b2_exit_upper);
	garbage_collect_now();
end

function f_musketeer_bowl_2_drive() -- script controling musketeer driving in bowl 1. only activates if player is in vehicle.
	repeat
		MusketeerUtil_SetDestinationWhenDrivingPlayer(FLAGS.cf_mer_musk_bowl2, POINTS.ps_bowl_2_musk_drive);
		sleep_s(3);
	until (b_bowl_2_over == true)
end

function f_musketeer_bowl_2_5_drive():void
	SleepUntil([|ai_living_count(AI.sg_bowl_2_main_force) <= 3], 1);
	
	b_bowl_2_over = true;
	sleep_s(1);
	MusketeerUtil_SetDestination_Clear_All();
	sleep_s(1);
	CreateThread(f_musketeer_bowl_2_5_drive_loop);
	CreateThread(f_musketeer_bowl_2_7_drive);
	print("____________ switching to 2.5");
end

function f_musketeer_bowl_2_5_drive_loop() -- script controling musketeer driving in bowl 1. only activates if player is in vehicle.
	repeat
		MusketeerUtil_SetDestinationWhenDrivingPlayer(FLAGS.cf_mer_musk_bowl2_5, POINTS.ps_bowl_2_5_musk_drive);
		sleep_s(3);
	until (b_mer_bowl_2_5_over == true)
end

function f_musketeer_bowl_2_7_drive():void
	SleepUntil([|volume_test_players(VOLUMES.tv_disable_exitbowl2_1a_navblip) == true], 3);
	b_mer_bowl_2_5_over = true;
	MusketeerUtil_SetDestination_Clear_All();
	sleep_s(1);
	CreateThread(f_musketeer_bowl_2_7_drive_loop);
	CreateThread(f_mer_musketeer_bowl_3_drive_activate);
	print("____________ switching to 2.7");
end

function f_musketeer_bowl_2_7_drive_loop() -- script controling musketeer driving in bowl 1. only activates if player is in vehicle.
	repeat
		MusketeerUtil_SetDestinationWhenDrivingPlayer(FLAGS.cf_mer_musk_bowl2_7, POINTS.ps_bowl_2_7_musk_drive);
		sleep_s(3);
	until (b_mer_bowl_2_7_over == true)
end

function f_mer_musketeer_bowl_3_drive_activate():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_musk_bowl3_drive_ready) == true], 3);
	b_mer_bowl_2_7_over = true;
	sleep_s(1);
	MusketeerUtil_SetDestination_Clear_All();
	print("________ bowl 2 mostly dead, switching to bowl 3");
	sleep_s(1);
	CreateThread(f_musketeer_bowl_3_drive_loop);
end

function f_musketeer_bowl_3_drive_loop() -- script controling musketeer driving in bowl 1. only activates if player is in vehicle.
	repeat
		if b_mer_musk_clear_for_bowl3 == false then
			MusketeerUtil_SetDestination_Clear_All();
			b_mer_musk_clear_for_bowl3 = true;
			print("________ clearing for bowl 3");
		end
		MusketeerUtil_SetDestinationWhenDrivingPlayer(FLAGS.cf_mer_musk_bowl3, POINTS.ps_bowl_3_musk_drive);
		print("________ setting for bowl 3");
		sleep_s(3);
	until (b_mer_final_bowl_over == true)
end 

function f_mer_scorpion_door_control():void
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_2_garage)], 1);
	if b_mer_scorp_door_open == false then
		ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scorpion_door, true);
		
		SleepUntil([|device_get_position(OBJECTS.dc_scorpion_door) == 1], 1);
		sleep_s(2);
		device_set_position(OBJECTS.dm_scorpion_door, 1);
		b_mer_scorp_door_open = true;
		device_set_power(OBJECTS.dc_scorpion_door, 0);
		ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scorpion_door, false);
		
		SleepUntil([|device_get_position(OBJECTS.dm_scorpion_door) >= 1], 1);
		device_set_power(OBJECTS.dm_scorpion_door, 0);
	end
end

function f_give_player_scorpion()
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sg_bowl_2_main_force) >= 1], 30);
	
	SleepUntil([|ai_living_fraction(AI.sg_bowl_2_main_force) <= 0.25], 30);
	b_mer_scorp_door_open = true;
	device_set_position(OBJECTS.dm_scorpion_door, 1);
	
	SleepUntil([|device_get_position(OBJECTS.dm_scorpion_door) >= 1], 1);
	device_set_power(OBJECTS.dm_scorpion_door, 0);
	device_set_power(OBJECTS.dc_scorpion_door, 0);
	garbage_collect_now();
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_scorpion_door, false);	
end

function f_entered_scorpion_vo()
	SleepUntil([|vehicle_test_seat(OBJECTS.v_skatepark_scorpion, "")], 3);
	CreateThread(audio_playerinscorpion);
	device_set_position(OBJECTS.dm_scorpion_door, 1);
	device_set_power(OBJECTS.dc_scorpion_door, 0);
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scorpion_door, false);
	b_mer_scorp_door_open = true;
end

function cs_vtol_tank_target_pilot()
	cs_fly_by(ai_current_actor, true, POINTS.ps_tank_targets.p01);
	cs_fly_by(ai_current_actor, true, POINTS.ps_tank_targets.p05);
	CreateThread (f_tanktarget_continue);
end

function f_tanktarget_continue():void
	sleep_s (10);
	cs_fly_by(AI.sq_vtol_targets, true, POINTS.ps_tank_targets.p02);
	--cs_vehicle_boost(AI.sq_vtol_targets, false );
	cs_fly_to_and_face (AI.sq_vtol_targets, true, POINTS.ps_tank_targets.p03, POINTS.ps_tank_targets.p04);
	cs_fly_by(AI.sq_vtol_targets, true, POINTS.ps_tank_targets.p04);
	object_set_scale (ai_vehicle_get(AI.sq_vtol_targets), .1, 60);
	sleep_s(1);
	ai_kill (AI.sq_vtol_targets);
end

function cs_vtol_tank_target_gunner()
	cs_fly_to(ai_current_actor, true, POINTS.ps_tank_targets.p02);
	cs_aim_object(ai_current_actor, true, OBJECTS.v_skatepark_scorpion);
end

function f_mer_tossed_hog_invul():void
	SleepUntil([|object_valid("sc_tossed_warthog")], 2);
	object_cannot_take_damage(OBJECTS.sc_tossed_warthog);
end

function f_spawn_knight_hog_vignette() -- spawns vignette of knight v warthog as player exits bowl 2
	SleepUntil([|volume_test_players(VOLUMES.tv_knight_wart_vig) == true], 2);
	--if object_get_health(OBJECTS.sc_tossed_warthog) >= 1 then
		object_destroy(OBJECTS.sc_tossed_warthog);
		Sleep(1);
		object_create_anew("tossed_warthog");
		pup_play_show ("knight_vs_warthog");
	--else
		--tossed_hog_health = object_get_health(OBJECTS.sc_tossed_warthog);
		--object_destroy(OBJECTS.sc_tossed_warthog);
	--Sleep(1);
	--object_create_anew("tossed_warthog");
		--object_set_health(OBJECTS.tossed_warthog, tossed_hog_health);
	--end
	CreateThread (f_spawn_bowl_2_exit);
end

function Meridian.goal_bowl_2_drive.End()
	b_bowl_2_over = true;
	--MusketeerUtil_SetDestination_Clear_All();
	--NavpointStopAllServer(AI.sq_bowl_2_miner_left);
	--NavpointStopAllServer(AI.sq_bowl_2_miner_right);
	--NavpointStopAllServer(AI.sq_bowl_2_scorpion_security);
	
	f_mer_clear_allies_markers(VOLUMES.big_combat_area, AI.sq_bowl_2_miner_left);
	f_mer_clear_allies_markers(VOLUMES.big_combat_area, AI.sq_bowl_2_miner_right);
	f_mer_clear_allies_markers(VOLUMES.big_combat_area, AI.sq_bowl_2_scorpion_security);
end


--[[
██████╗ ██████╗ ██╗   ██╗ ██████╗ ██████╗  █████╗ ███╗   ██╗███╗   ██╗██╗███████╗     █████╗ ██████╗ ██████╗ ██╗██╗   ██╗ █████╗ ██╗     
██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝ ██╔══██╗██╔══██╗████╗  ██║████╗  ██║██║██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██║██║   ██║██╔══██╗██║     
██║  ██║██████╔╝ ╚████╔╝ ██║  ███╗██████╔╝███████║██╔██╗ ██║██╔██╗ ██║██║███████╗    ███████║██████╔╝██████╔╝██║██║   ██║███████║██║     
██║  ██║██╔══██╗  ╚██╔╝  ██║   ██║██╔══██╗██╔══██║██║╚██╗██║██║╚██╗██║██║╚════██║    ██╔══██║██╔══██╗██╔══██╗██║╚██╗ ██╔╝██╔══██║██║     
██████╔╝██║  ██║   ██║   ╚██████╔╝██║  ██║██║  ██║██║ ╚████║██║ ╚████║██║███████║    ██║  ██║██║  ██║██║  ██║██║ ╚████╔╝ ██║  ██║███████╗
╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝
Drygrannis Arrival Scripts
------------------------------------------------------------------------------------
--]]

Meridian.goal_drygrannis_arrival = 
	{	description = "",
		--gotoVolume = VOLUMES.tv_mission_end,
		--navPoint = FLAGS.crumb5b,
		zoneSet = ZONE_SETS.zs_040,
		checkPoints = POINTS.ps_goal_drygrannis_arrival,
		--next = {"goal_drygrannis_arrival"};
	}
	
function Meridian.goal_drygrannis_arrival.Start()
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
	CreateThread(f_navblip_drygrannis);
	CreateThread(f_navblip_drygrannis_door);
	Wake(dormant.w1_garage_scripts); -- warthog ride garage to town
	CreateThread(f_mer_sg_end_gate_enemies);
	CreateThread(f_spawn_gate_turrets);
	CreateThread(f_save_vtol_vig);
	CreateThread(drygrannis_flocks);	
	if game_difficulty_get_real() == DIFFICULTY.legendary then
		CreateThread(f_meridian_skull);
	else
		print ("game too easy");	
	end
	s_thread_f_mer_chicken_player = CreateThread(f_mer_chicken_player);
end

function f_mer_chicken_player():void
	SleepUntil([|volume_test_players(VOLUMES.nar_gate_more_to_kill) == true], 30);
	CreateThread(f_mer_final_battle_kill_volumes);
	
	SleepUntil([|volume_test_players(VOLUMES.nar_gate_more_to_kill) == false], 30);
	ai_kill(AI.sq_drygrannis_gate_turret);
	object_damage_damage_section(OBJECTS.v_gate_turret_01, "body", 9999);
	object_damage_damage_section(OBJECTS.v_gate_turret_02, "body", 9999);
	CreateEffectGroup(EFFECTS.fx_mer_turret_01);
	CreateEffectGroup(EFFECTS.fx_mer_turret_02);
end

function f_mer_sg_end_gate_enemies():void
	CreateThread (SlipSpaceSpawn ,AI.sq_end_gate_mixed_01);
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_tank_run_lead) == true], 1);
	CreateThread (SlipSpaceSpawn ,AI.sq_end_gate_mixed_02);
	sleep_s(3.25);
	
	--SleepUntil([|ai_living_count(AI.sg_end_gate_enemies) <= 1], 3);
	CreateThread (SlipSpaceSpawn ,AI.sq_end_gate_mixed_03);
	garbage_collect_now();
	sleep_s(3.25);
	
	SleepUntil([|ai_living_count(AI.sg_end_gate_enemies) <= 2], 3);
	CreateThread (SlipSpaceSpawn ,AI.sq_end_gate_officers);
	garbage_collect_now();
	sleep_s(3.25);
	CreateThread(f_open_drygrannis_gate);
end

function f_spawn_gate_turrets() -- spawn automated turrets on top of drygrannis gate
	SleepUntil([|volume_test_players(VOLUMES.tv_drive_explosions) == true], 3);
	ai_place(AI.sq_drygrannis_gate_turret);
end

function f_save_vtol_vig() -- plays vignette of vtol attacking the mining ship
	SleepUntil([|volume_test_players(VOLUMES.tv_save_mining_ship) == true], 1);
	pup_play_show ("save_the_mining_ship");
	--CreateThread (f_vtol_health_check);
end

function drygrannis_flocks():void
	flock_destroy ("mining_ship_flock_outpost");	--	--	--	--	--	--	--	--	--	--	Created in Outpost
	flock_destroy ("pelican_flock_outpost");	--	--	--	--	--	--	--	--	--	--	--	Created in Outpost
	flock_destroy ("vtol_flock_outpost");	--	--	--	--	--	--	--	--	--	--	--	--	Created in Outpost
	flock_create ("mining_ship_flock_miningtown");	--	--	--	--	--	--	--	--	--	--	Always on, never delete
	flock_create ("pelican_flock_miningtown");	--	--	--	--	--	--	--	--	--	--	--	Always on, never delete
	flock_create ("vtol_flock_miningtown");	--	--	--	--	--	--	--	--	--	--	--	--	Always on, never delete
end

function f_mer_final_battle_kill_volumes():void
	SleepUntil([| volume_test_players(VOLUMES.w1_meridian_1_gate_combat) ], 1);
	f_mer_teleport_players();
	kill_volume_enable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_enable(VOLUMES.kill_tv_mer_final);
  f_mer_clear_allies(VOLUMES.big_combat_area, AI.sq_bowl_2_miner_left);
	f_mer_clear_allies(VOLUMES.big_combat_area, AI.sq_bowl_2_miner_right);
	f_mer_clear_allies(VOLUMES.big_combat_area, AI.sq_bowl_2_scorpion_security);
end

--OSR-154739
--teleporting players outside of softkill and kill volumes
function f_mer_teleport_players()
	--kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  --kill_volume_disable(VOLUMES.kill_tv_mer_final);
	for i,spartan in pairs (spartans()) do
		if volume_test_object (VOLUMES.kill_tv_mer_final, spartan) or volume_test_object (VOLUMES.kill_soft_tv_mer_final, spartan) then
			if IsPlayer(spartan) then 
				teleport_player_to_flag(unit_get_player(spartan), FLAGS["fl_teleport_mer_final0"..i], true);
			else
				object_teleport (spartan, FLAGS["fl_teleport_mer_final0"..i]);
			end
		end
	end
end

--function f_vtol_health_check() -- script for branching this vignette if player destroys vtol in time
--	SleepUntil([|object_get_health(OBJECTS.killer_vtol) > 0], 3);
--	
--	SleepUntil([|object_get_health(OBJECTS.killer_vtol) <= 0], 1);
--	b_vtol_kill_mining_ship = false;
--end
	
function f_final_gate_health_vo() -- gate that checks main gate health narratives wants to play some lines if this happens
	SleepUntil([|object_get_health (OBJECTS.dm_drygrannis_door) < 1], 1);
end
	
function Meridian.goal_drygrannis_arrival.End()
	game_save_no_timeout();
	LoomNextCampaignMission();

	SleepUntil([|NarrativeQueue.HasConversationFinished(W1HubMeridian_Meridian_Station__Combat_COMPLETE) == true], 1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mer_end_gate_open) ], 5);	
	CreateThread(f_exit_vehicle_gate_entrance); -- kicks player out of vehicle as the gate opens
	CreateThread(f_final_door_alarm);
	--device_set_position(OBJECTS.dm_drygrannis_door, 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dm_drygrannis_door, false );
	sleep_s(3);
	fade_out(0,0,0, 120);
	sleep_s(2);
	EndMission (Meridian);
end

function f_open_drygrannis_gate() -- script that controls end of the mission
	sleep_s(4);
	
	SleepUntil([|ai_living_count(AI.sg_end_gate_enemies) <= 0], 5); -- player kills all AI at gate entrance
	game_save_no_timeout();
	sleep_s(5);
	f_final_waves(); -- script that handles the entire defend sequence
	--CreateThread(f_drygrannis_arrival_complete);
	Wake(dormant.w1_meridian_gate_complete);
	sleep_s(4);
	GoalComplete(Meridian.goal_drygrannis_arrival);
end

function f_final_door_alarm()
	RunClientScript("f_open_meridian_station_gate");
end

function f_drygrannis_arrival_complete():void
	sleep_s(2);
	ObjectiveShow (TITLES.ct_obj_meridian_4);
	CreateThread(audio_gate_defend_start_music);
end

function f_final_waves()
	--//	//	Loading Wave 1	//	//	--
	if not volume_test_players(VOLUMES.t_mer_marine_backup) then
		ai_place(AI.sg_mer_marine_backup);
	end
	sleep_s(2);
	CreateThread(f_mer_sg_mer_marine_backup_marker);
	--NavpointShowAllServer(AI.sg_mer_marine_backup, "ally");
	--CreateThread(audio_gate_defend_start_music);
	print("spawning wave 1");
	garbage_collect_now();
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_mid1);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_top1);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_right1);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_left1);
	g_n_end_wave = 1;
	print ("wave 1 spawned");
	sleep_s (4);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_mid) <= 2], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_top) <= 1], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_right) <= 2], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_left) <= 2], 5);
	game_save_no_timeout();
	
	--//	//	Wave 2 starting, AI counts have dipped	//	//	--
	print ("spawning wave 2");
	sleep_s (random_range (2.5, 5));
	garbage_collect_now();
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_bot1);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_left2);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_right2);
	sleep_s (random_range (2.5, 4));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_mid2);
	garbage_collect_now();
	g_n_end_wave = 2;
	sleep_s (4);
	
	SleepUntil([|ai_living_count(AI.sq_neo_dryg_mid2) <= 1], 5);
	CreateThread (SlipSpaceSpawn, AI.sq_end_final_wave_knight_01);
	sleep_s (4);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_right) <= 2], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_left) <= 2], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sq_end_final_wave_knight_01) <= 1], 5);
	game_save_no_timeout();
	
	--//	//	Wave 3 starting, AI counts have dipped	//	//	--
	sleep_s (random_range (3.5, 6));
	print ("spawning wave 3");
	--CreateThread(audio_gate_defend_secondwave_music);
	sleep_s (random_range (3.5, 6));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_mid3);
	if game_coop_player_count() >= 3  then
		sleep_s (random_range (2.5, 5));
		CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_right6);
		sleep_s (random_range (2.5, 5));
		CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_mid6);
		garbage_collect_now();
	end
	sleep_s (random_range (2.5, 5));
	garbage_collect_now();
	CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_right3);
	sleep_s (random_range (2.5, 6));
	CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_left3);
	sleep_s (4);
	CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_bot2);
	sleep_s (random_range (2.5, 4));
	CreateThread (SlipSpaceSpawn, AI.sq_neo_dryg_top2);
	garbage_collect_now();
	sleep_s (4);
	g_n_end_wave = 3;
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_mid) <= 1], 5);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_bot) <= 2], 5);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_top) <= 1], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_right) <= 2], 5);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_left) <= 1], 5);
	garbage_collect_now();
	
	SleepUntil([|ai_living_count(AI.sg_end_gate_waves) <= 3], 5);
	game_save_no_timeout();

	--//	//	Wave 4 starting, AI counts have dipped	//	//	--
	--CreateThread(audio_gate_defend_thirdwave_music);
	CreateThread(f_end_tank_vtols);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_mid4);
	if game_coop_player_count() >= 2  then 
		sleep_s (random_range (2.5, 5));
		CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_right7);
	end
	sleep_s (random_range (2.5, 5));
	garbage_collect_now();
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_right4);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_left4);
	if game_coop_player_count() >= 2  then 
		sleep_s (4);
		CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_left5); 
	end	
	sleep_s (4);
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_bot3);
	sleep_s (random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_top3);
	garbage_collect_now();
	sleep_s (random_range (2.5, 5));
	g_n_end_wave = 4;
	sleep_s (4);
	
	SleepUntil([|ai_living_count(AI.sg_neo_drygrannis_all) <= 3], 5);
	
	SleepUntil([|ai_living_count(AI.sg_end_gate_waves) <= 1], 5);
	game_save_no_timeout();
	--//	//	Wave 5 starting, AI counts have dipped	//	//	--
	sleep_s (random_range (2.5, 5));
	if game_coop_player_count() >= 2  then 
		CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_top4);
		sleep_s (random_range (2.5, 5));
	end
	garbage_collect_now();
	CreateThread(SlipSpaceSpawn, AI.sq_neo_dryg_right4);
	sleep_s(random_range (2.5, 5));
	CreateThread (SlipSpaceSpawn, AI.sq_end_final_wave_knight_02);
	sleep_s(random_range (2.5, 5));
	CreateThread(SlipSpaceSpawn, AI.sq_end_final_wave_knight_03);
	garbage_collect_now();
	sleep_s(3.3);
	g_n_end_wave = 5;
	
	SleepUntil([|ai_living_count(AI.sg_pro_all) <= 3], 1);
	--NavpointShowAllServer(AI.sg_pro_all, "enemy");
		
--	local squadCount = ai_squad_group_get_squad_count(AI.sg_pro_all);
--		for i = 1, (squadCount - 1) do
--		for i, living_blood_gate in ipairs(ai_actors(AI.sg_pro_all)) do
--			--ObjectSetSpartanTrackingEnabled(living_blood_gate, true);
--			NavpointShowAllServer(living_blood_gate, "enemy");
--		end
--	end
	
	SleepUntil([|ai_living_count(AI.sg_pro_all) <= 0], 5);
	NavpointStopAllServer(AI.sg_mer_marine_backup);
	CreateThread(audio_gate_defend_end_music);
	KillThread(s_thread_f_mer_chicken_player);
	sleep_s (6);
	b_mer_final_bowl_over = true;
end

function f_mer_sg_mer_marine_backup_marker():void
	SleepUntil ([|ai_living_count(AI.sg_mer_marine_backup) > 0]);
		for _, ally in pairs (ai_actors (AI.sg_mer_marine_backup)) do
			navpoint_track_object_named( ally, "ally" );
		end
end

function f_end_tank_vtols() -- spawns two vtols if the player is in the tank during defend sequence
	composer_play_show ("vtols_attack_miningtown");
end

function f_exit_vehicle_gate_entrance() -- script for kicking players out of vehicles at the end of the mission.
	--SleepUntil([|volume_test_players(VOLUMES.tv_mission_end_final) == true], 1);
	print ("kicking players out of vehicles.");
	for _,vehicles in ipairs (volume_return_objects_by_type (VOLUMES.tv_mission_end_vehicles, 2)) do
		print ("Who is in", vehicles);
		vehicle_unload( vehicles, "");
		vehicle_set_unit_interaction( vehicles, "", false, true );
		Sleep (2);
	end
	print ("Players should be ejected from vehicles.");
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

function cs_mer_bowl1_officer_shoot():void
	cs_go_to(POINTS.ps_mer_bowl1_officer.p_officer_goto, 3);
	sleep_s(1);
	cs_shoot(AI.sq_pro_drive.officer, true, OBJECTS.cr_mer_bowl1_officer_target_3);
	object_damage_damage_section(OBJECTS.cr_mer_bowl1_officer_target_3, "default", 500);
	sleep_s(2);
	cs_shoot(AI.sq_pro_drive.officer, true, OBJECTS.cr_mer_bowl1_officer_target_4);
	object_damage_damage_section(OBJECTS.cr_mer_bowl1_officer_target_4, "default", 500);
end

function cs_mer_end_marine_backup_1():void
	cs_go_to(POINTS.ps_mer_marine_backup_turret.p_gaussturret01_01, 1);
	ai_vehicle_enter(ai_current_actor, OBJECTS.gaussturret01);
end

function cs_mer_end_marine_backup_3():void
	cs_go_to(POINTS.ps_mer_marine_backup_turret.p_rocketturret03_03, 1);
	ai_vehicle_enter(ai_current_actor, OBJECTS.rocketturret03);
end

function cs_mer_end_marine_backup_4():void
	cs_go_to(POINTS.ps_mer_marine_backup_turret.p_rocketturret02_04, 1);
	ai_vehicle_enter(ai_current_actor, OBJECTS.rocketturret02);
end

function cs_immortality()
	ai_cannot_die (ai_current_actor, true);
	print ("immortal ai has spawned");
end

--function cs_bowl_2_rocket_turret()
--	cs_force_combat_status(ai_current_actor, 3);
--	unit_enter_vehicle_immediate(ai_current_actor, OBJECTS.v_bowl_2_rocket, 'warthog_g');
--end

function cs_welcomemarine()
	CreateThread (welcomemarine_fightsetup);
	CreateThread (welcomemarine_stopfighting);
end

function cs_killminer()
	sleep_s (1);
	ai_kill (ai_current_actor);
end

function cs_first_miner()
	cs_crouch(ai_current_actor, true, 1);	
	
	SleepUntil([| objects_distance_to_object(spartans(), AI.sq_interior_miners.first_miner) <= 4], 1);
	ai_place(AI.miners_elevator_int);
	cs_crouch(ai_current_actor, false, 1);
	--cs_look_player(ai_current_actor, true);
	--cs_go_to_and_face(ai_current_actor, true, POINTS.ps_elevator_interior.p02, POINTS.ps_elevator_interior.p01);	
end

function welcomemarine_fightsetup():void
	SleepUntil([|volume_test_players (VOLUMES.tv_welcometofight)], 1);
	b_welcometofight = true;
	repeat
		sleep_s (10);
		if (unit_get_health(AI.sq_welcomeparty.welcome_miner) > 0)	then
		object_set_health(AI.sq_welcomeparty.welcome_miner, 1);
		else
		print ("Welcome party not refreshed");
		end
	until (b_welcometorest == true or ai_living_count(AI.sq_welcomeparty) <= 0);
end

function welcomemarine_stopfighting():void
	SleepUntil([|volume_test_players (VOLUMES.tv_main_outpost_gate)], 1);
	b_welcometorest = true;
end

function cs_attack_miners()
	SleepUntil([|device_get_position(OBJECTS.dm_spelevator_door) >= 0.74], 3);
end

function cs_auto_turret_miner()
	print ("Autoturret Miners spawned");
end

function cs_pel_outpost()
	SleepUntil([|volume_test_players(VOLUMES.tv_outpost_vignette_ships) == true], 3);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_01, POINTS.ps_outpost_ship_vignette.p_pel_02);
	cs_fly_to(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_03);	
	RunClientScript("f_outpost_vig_fx");
	cs_die(ai_current_actor, true, 2);
	sleep_s (.5);
	ai_erase( ai_current_actor );
end

function cs_vtol_outpost()
	SleepUntil([|volume_test_players(VOLUMES.tv_outpost_vignette_ships) == true], 3);
	sleep_s ();
	cs_aim(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_03);
	cs_fly_to(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_vtol_01);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_03);
	print ("did the vtol fire?");
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_to(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_vtol_02);	
	ai_erase( ai_current_squad );
end

function cs_vtol_outpost_2()
	SleepUntil([|volume_test_players(VOLUMES.tv_outpost_vignette_ships) == true], 3);
	cs_aim(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_03);
	sleep_s (3);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_outpost_ship_vignette.p_pel_03);
	sleep_s (5);
end

--function cs_left_path_red_shirt()
--	--SleepUntil([|volume_test_players(VOLUMES.tv_red_shirt) == true], 1);
--end

function cs_fly_to_end_battle()
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, .1);
	object_set_scale (ai_vehicle_get(ai_current_actor), 1, 90);
	cs_fly_to(ai_current_actor, true, POINTS.ps_end_fight_vtol.p06, 5);
end

function cs_leave_end_battle()
	cs_fly_to(ai_current_actor, true, POINTS.ps_end_fight_vtol.p07, 5);
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, 120);
	ai_erase (ai_current_actor);
end

function cs_gate_turret_1()
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_gate_turret_01);
	unit_open (OBJECTS.v_gate_turret_01);
end

function cs_gate_turret_2()
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_gate_turret_02);
	unit_open (OBJECTS.v_gate_turret_02);
end

function cs_open_bridge_left()
	sleep_s(1);
end

function cs_open_bridge_right()
	sleep_s(1);
end

function cs_bridge_hog_driver():void
	CreateThread(warthog_soldier_vehexit);
	cs_go_to_vehicle(ai_current_actor, true, OBJECTS.v_bridge_hog, 'warthog_d');
end

function cs_bridge_hog_gunner():void
	cs_go_to_vehicle(ai_current_actor, true, OBJECTS.v_bridge_hog, 'warthog_g');
end

function cs_bridge_hog_sold_1()
	ai_vehicle_enter_immediate(AI.sq_bridge_soldiers.driver, OBJECTS.v_bridge_hog, 'warthog_d');
	cs_go_to(AI.sq_bridge_soldiers.driver, true, POINTS.ps_bridge_hog.p01, 1);
	cs_go_to(AI.sq_bridge_soldiers.driver, true, POINTS.ps_bridge_hog.p02, 1);
	cs_go_to(AI.sq_bridge_soldiers.driver, true, POINTS.ps_bridge_hog.p04, 1);
end

function cs_bridge_hog_sold_2()
	ai_vehicle_enter_immediate(AI.sq_bridge_soldiers.gunner, OBJECTS.v_bridge_hog, 'warthog_g');
end

function cs_vtol_defend_01()
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, .1);
	object_set_scale (ai_vehicle_get(ai_current_actor), 1, 90);
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_01.p_01);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_01.p_02);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_defend_01.p_03, POINTS.ps_vtol_defend_01.p_target);
	cs_aim(ai_current_actor, true, POINTS.ps_vtol_defend_01.p_target );
	cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol_defend_01.p_target);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_01.p_target);
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, 60);
	ai_erase (ai_current_actor);
end

function cs_vtol_defend_01_gunner()
	repeat
		sleep_s (random_range (1, 5));
		cs_shoot(ai_current_actor, true, OBJECTS.cr_vtol_target_01);
		sleep_s (.5);
	until object_get_health(OBJECTS.cr_vtol_target_01) <= 0
end

function cs_vtol_defend_02()
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, .1);
	object_set_scale (ai_vehicle_get(ai_current_actor), 1, 90);
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_02.p_01);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_02.p_02);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_defend_02.p_03, POINTS.ps_vtol_defend_02.p_target);
	cs_aim(ai_current_actor, true, POINTS.ps_vtol_defend_02.p_target );
	cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol_defend_02.p_target);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_02.p_target);
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, 60);
	ai_erase (ai_current_actor);
end

function cs_vtol_defend_02_gunner()	
	repeat
	sleep_s (random_range (1, 5));
	cs_shoot(ai_current_actor, true, OBJECTS.cr_vtol_target_02);
	sleep_s (.5);
	until object_get_health(OBJECTS.cr_vtol_target_02) <= 0
end

function cs_vtol_defend_03()
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, .1);
	object_set_scale (ai_vehicle_get(ai_current_actor), 1, 90);
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_03.p_01);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_03.p_02);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_defend_03.p_03, POINTS.ps_vtol_defend_03.p_target);
	cs_aim(ai_current_actor, true, POINTS.ps_vtol_defend_03.p_target );
	cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol_defend_03.p_target);
	cs_fly_by(ai_current_actor, true, POINTS.ps_vtol_defend_03.p_target);
	object_set_scale (ai_vehicle_get(ai_current_actor), .1, 60);
	ai_erase (ai_current_actor);
end

function cs_vtol_defend_03_gunner()
	repeat
	sleep_s (random_range (1, 5));
	cs_shoot(ai_current_actor, true, OBJECTS.cr_vtol_target_03);
	sleep_s (.5);
	until object_get_health(OBJECTS.cr_vtol_target_03) <= 0
end

function cs_soldierswarthog_start()
	CreateThread (warthog_soldier_vehexit);
end

function warthog_soldier_vehexit():void
	--sleep_s (5);
	
	SleepUntil([|ai_living_count (AI.sq_bridge_soldiers.gunner) <=0], 2);
	--unit_exit_vehicle(AI.sq_bridge_soldiers.driver, 0);
end

function cs_vtol_1()
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_01.p01, POINTS.ps_vtol_01.p2);
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_01.p03, POINTS.ps_vtol_01.p02);
end

function cs_vtol_2()
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_01.p2, POINTS.ps_vtol_01.p01);
	cs_vehicle_boost(ai_current_actor, true );
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_vtol_01.p02, POINTS.ps_vtol_01.p03);
end


--[[
███╗   ██╗ █████╗ ██╗   ██╗    ██████╗ ██╗     ██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
████╗  ██║██╔══██╗██║   ██║    ██╔══██╗██║     ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██╔██╗ ██║███████║██║   ██║    ██████╔╝██║     ██║██████╔╝    ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║╚██╗██║██╔══██║╚██╗ ██╔╝    ██╔══██╗██║     ██║██╔═══╝     ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
██║ ╚████║██║  ██║ ╚████╔╝     ██████╔╝███████╗██║██║         ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝      ╚═════╝ ╚══════╝╚═╝╚═╝         ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Nav Blip Scripts
------------------------------------------------------------------------------------
--]]

function f_navblip_exitelevator():void
	SleepUntil([|device_get_position(OBJECTS.dm_elevator_intro_door) >= 0.2], 1);
	object_create("tracking_elevatorlobby_blip");
	
	SleepUntil([|volume_test_players(VOLUMES.tv_disable_lobby_navblip)], 1);
	object_destroy(OBJECTS.tracking_elevatorlobby_blip);
	object_create("elevexit_door_tracking");
	
	SleepUntil([|b_open_elevator_exit == true], 1);
	object_destroy(OBJECTS.elevexit_door_tracking);
end

function f_cacheblip_sniperperch():void
	SleepUntil([|volume_test_players(VOLUMES.tv_enable_sniperperch_blip)], 1);
	object_create("tracking_sniperperch_cache_blip");
	
	SleepUntil([|device_get_position(OBJECTS.dm_exit_door_1) >= .2], 1);
	game_save_no_timeout();
	object_destroy(OBJECTS.tracking_sniperperch_cache_blip);
end

function f_navblip_outpostdoor():void
	SleepUntil([|volume_test_players (VOLUMES.tv_enable_sniperperch_blip)], 1);
	ObjectSetSpartanTrackingEnabled (OBJECTS.dm_exit_door_1, true);
	
	SleepUntil([|device_get_position (OBJECTS.dm_exit_door_1) >= .1], 1);
	ObjectSetSpartanTrackingEnabled (OBJECTS.dm_exit_door_1, false);
end

function f_navblip_exitoutpost():void
	object_create ("tracking_exit_outpost_blip");
	
	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_exitoutpost_navblip)], 1);
	object_destroy (OBJECTS.tracking_exit_outpost_blip);
end

function f_navblip_bowl1_1():void
	SleepUntil([|volume_test_players (VOLUMES.tv_disable_exitoutpost_navblip)], 1);
	object_create("tracking_bowl_1_blip");

	SleepUntil([|volume_test_players (VOLUMES.tv_delete_bowl_1_blip)], 1);
	object_destroy(OBJECTS.tracking_bowl_1_blip);
end

function f_navblip_bridgedoor():void
	SleepUntil([|volume_test_players (VOLUMES.tv_delete_bowl_1_blip)], 1);
	object_create("tracking_bridge_entrance_blip");

	SleepUntil([|device_get_position (OBJECTS.dm_bridge_door) > 0.0], 1);
	object_destroy(OBJECTS.tracking_bridge_entrance_blip);
end

function f_navblip_bridgeexit():void
	SleepUntil ([|	device_get_position (OBJECTS.dm_bridge_door) > 0.0], 1);
	object_create ("tracking_bridge_exit_blip");

	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_bridgeexit_navblip)], 1);
	object_destroy (OBJECTS.tracking_bridge_exit_blip);
end

function f_navblip_bowl2():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_bridgeexit_navblip)], 1);
	object_create ("tracking_bowl_2_blip");
	
	SleepUntil ([|	volume_test_players (VOLUMES.tv_delete_bowl_2_blip)], 1);
	KillThread(s_thread_f_mer_sq_prom_b2_a_02);
	object_destroy (OBJECTS.tracking_bowl_2_blip);
end

function f_cacheblip_bowl2_all():void
	SleepUntil([|volume_test_players(VOLUMES.tv_disable_bridgeexit_navblip)], 1);
	object_create("tracking_bowl2_cache1_blip");
	object_create("tracking_bowl2_cache2_blip");
	object_create("tracking_bowl2_cache3_blip");
	
	SleepUntil([|volume_test_players (VOLUMES.tv_disable_exitbowl2_1a_navblip) or volume_test_players (VOLUMES.tv_disable_exitbowl2_1b_navblip)], 1);
	object_destroy(OBJECTS.tracking_bowl2_cache1_blip);
	object_destroy(OBJECTS.tracking_bowl2_cache2_blip);
	object_destroy(OBJECTS.tracking_bowl2_cache3_blip);
end

function f_navblip_exitbowl2_1():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_delete_bowl_2_blip)], 1);
	object_create ("tracking_exit_bowl_2_blip");
	
	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_exitbowl2_1a_navblip) or volume_test_players (VOLUMES.tv_disable_exitbowl2_1b_navblip)], 1);
	object_destroy (OBJECTS.tracking_exit_bowl_2_blip);
end

function f_navblip_exitbowl2_2():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_exitbowl2_1a_navblip) or volume_test_players (VOLUMES.tv_disable_exitbowl2_1b_navblip)], 1);
	object_create ("tracking_exit_bowl_2_blip_2");

	SleepUntil ([|	volume_test_players (VOLUMES.tv_disable_exitbowl2_2_navblip)], 1);
	object_destroy (OBJECTS.tracking_exit_bowl_2_blip_2);
end

function f_navblip_drygrannis():void
	SleepUntil([|volume_test_players(VOLUMES.tv_disable_exitbowl2_2_navblip)], 1);
	object_create("tracking_drygrannis_blip");

	SleepUntil([|volume_test_players(VOLUMES.tv_disable_drygrannis_navblip)], 1);
	object_destroy(OBJECTS.tracking_drygrannis_blip);
end

function f_navblip_drygrannis_door():void
	SleepUntil([|volume_test_players(VOLUMES.tv_enable_drygrannis_door_navblip)], 1);
	object_create("s_tracking_armory_end_01");
	object_create("s_tracking_armory_end_02");
	ObjectSetSpartanTrackingEnabled (OBJECTS.dm_drygrannis_door, true);
	
	--SleepUntil([|device_get_position(OBJECTS.dm_drygrannis_door) > 0.0], 1);
	--ObjectSetSpartanTrackingEnabled(OBJECTS.dm_drygrannis_door, false);
end


--[[
███╗   ███╗██╗███████╗ ██████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
████╗ ████║██║██╔════╝██╔════╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██╔████╔██║██║███████╗██║         ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║╚██╔╝██║██║╚════██║██║         ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
██║ ╚═╝ ██║██║███████║╚██████╗    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Misc. Scripts
------------------------------------------------------------------------------------
--]]
function f_ics_buttonpress( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
	print ("ICS BUTTON PRESS ACTIVATED");
	num_icsbuttonpress = composer_play_show("vin_ics_buttonpress", { ics_player = this_activator});
end

function f_ics_buttonpress_armory( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
	num_icsbuttonpress = composer_play_show("vin_ics_buttonpress_armory", { ics_player = this_activator});
end

function f_ics_buttonpress_scorpion( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
	num_icsbuttonpress = composer_play_show("vin_ics_buttonpress_scorpion", { ics_player = this_activator});
end

function f_ics_buttonpress_ele_audio_log( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
	num_icsbuttonpress = composer_play_show("vin_ics_buttonpress_ele_audio_log", { ics_player = this_activator});
end

-- changing this to wait for the object to be valid, then looking for it to be destroyed.  -KS 8/4/15
function f_meridian_skull() -- if you're reading this function after launch then you're a dirty, dirty cheater. Don't spoil the fun. DE
	SleepUntil([|object_valid("killer_vtol")], 1);
	print("____________VTOL spawned, ready to be killed");
	CreateThread(f_mer_vtol_s_health);
	SleepUntil([|object_get_health(OBJECTS.killer_vtol) <= 0.90], 1);
	print("____________VTOL health low");
	object_cannot_take_damage(OBJECTS.killer_vtol);
	RunClientScript ("f_killer_vtol_die");
	Sleep(1);
	object_destroy(OBJECTS.killer_vtol);
	b_vtol_kill_mining_ship = true;
	if b_vtol_kill_still_alive == false then
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		print ("You killed the vtol. YAY!****************************************************************************");
		object_create("dc_meridian_skull_iron");
		local mer_skull_pos = random_range(1,3);
		print("1. road to final battle, by barrels. 2. scorp garage 3. B2, under arch. Skull location = ", mer_skull_pos);
		if mer_skull_pos == 1 then
			object_teleport(OBJECTS.dc_meridian_skull_iron, FLAGS.cf_skull_01); -- function creates 1 of the 3 random skulls
		elseif mer_skull_pos == 2 then
			object_teleport(OBJECTS.dc_meridian_skull_iron, FLAGS.cf_skull_02);
		elseif mer_skull_pos == 3 then
			object_teleport(OBJECTS.dc_meridian_skull_iron, FLAGS.cf_skull_03);
		end
	end
end

function f_mer_vtol_s_health():void
	sleep_s(22);
	print("____________VTOL done with vig");
	b_vtol_kill_still_alive = true;
end


-- PROXY HANDER FOR BSP LOADING AND UNLOADING
-- adding new checks to make sure backtracking is supported -KS 8/3/2015
function f_mer_zone_set_proxy_handler():void
	local mer_current_zone = current_zone_set_fully_active();
		if current_zone_set() == ZONE_SETS.zs_010 then
			SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_010] or mer_current_zone ~= current_zone_set_fully_active(), 3 );
			object_create_anew("bridge_scenery_bsp");
			object_create_anew("glassupper_b1_scenery_bsp");
			object_create_anew("glassupper_b2_scenery_bsp");
			if object_valid("outpost_scenery_bsp") then
				object_destroy(OBJECTS.bridge_scenery_bsp);
			end
			if object_valid("glassupper_a_scenery_bsp") then
				object_destroy(OBJECTS.bridge_scenery_bsp);
			end

		elseif current_zone_set() == ZONE_SETS.zs_020 then
			object_create_anew("glassupper_b2_scenery_bsp");
			SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_020] or mer_current_zone ~= current_zone_set_fully_active(), 3 );		
			if object_valid("bridge_scenery_bsp") then
				object_destroy(OBJECTS.bridge_scenery_bsp);
			end
			if object_valid("glassupper_b1_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b1_scenery_bsp);
			end
			if object_valid("glassupper_a_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b1_scenery_bsp);
			end	
			if object_valid("outpost_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b1_scenery_bsp);
			end	
				
		elseif current_zone_set() == ZONE_SETS.zs_030 then
			object_create_anew("outpost_scenery_bsp");

			SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_030] or mer_current_zone ~= current_zone_set_fully_active(), 3 );	
			if object_valid("glassupper_b2_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end	
			if object_valid("glassupper_b1_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end
			if object_valid("bridge_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end
			if object_valid("glassupper_a_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end

		elseif current_zone_set() == ZONE_SETS.zs_040 then
			object_create_anew("glassupper_a_scenery_bsp");
			object_create_anew("outpost_scenery_bsp");

			SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_040] or mer_current_zone ~= current_zone_set_fully_active(), 3 );

			if object_valid("bridge_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end
			if object_valid("glassupper_b1_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end
			if object_valid("glassupper_b2_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end

		elseif current_zone_set() == ZONE_SETS.zs_050 then
			
			SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs_050] or mer_current_zone ~= current_zone_set_fully_active(), 3 );
			if object_valid("outpost_scenery_bsp") then
				object_destroy(OBJECTS.outpost_scenery_bsp);
			end
			if object_valid("glassupper_a_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_a_scenery_bsp);
			end
			if object_valid("bridge_scenery_bsp") then
				object_destroy(OBJECTS.bridge_scenery_bsp);
			end
			if object_valid("glassupper_b1_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b1_scenery_bsp);
			end
			if object_valid("glassupper_b2_scenery_bsp") then
				object_destroy(OBJECTS.glassupper_b2_scenery_bsp);
			end															
		end

	SleepUntil([|mer_current_zone ~= current_zone_set_fully_active()], 1);
	CreateThread(f_mer_zone_set_proxy_handler);
end

function f_mer_clear_allies (vol:volume, squad:ai)
	local t_squad = GetTableFromSquad(squad);
	for _,miner in pairs (t_squad) do
		if volume_test_object (vol, miner) then
			ai_erase (object_get_ai(miner));
		end
	end
end

function f_mer_clear_allies_markers (vol:volume, squad:ai)
	local t_squad = GetTableFromSquad(squad);
	for _,miner in pairs (t_squad) do
		if volume_test_object (vol, miner) then
			NavpointStopAllServer (object_get_ai(miner));
		end
	end
end

function audio_cinematic_mute_meridian()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--[[
███████╗██╗  ██╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝╚██╗██╔╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
█████╗   ╚███╔╝     ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██╔══╝   ██╔██╗     ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
██║     ██╔╝ ██╗    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚═╝     ╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
FX Scripts
------------------------------------------------------------------------------------
--]]

function f_looping_explosions()
	repeat
		RunClientScript("f_amb_explosions");
		sleep_s (random_range (2.5, 6));
	until(b_encounter_completed == true);
end

function f_outpost_explosion()
	RunClientScript ("f_bamf_explosion");
end

--[[
██████╗ ██╗     ██╗███╗   ██╗██╗  ██╗███████╗
██╔══██╗██║     ██║████╗  ██║██║ ██╔╝██╔════╝
██████╔╝██║     ██║██╔██╗ ██║█████╔╝ ███████╗
██╔══██╗██║     ██║██║╚██╗██║██╔═██╗ ╚════██║
██████╔╝███████╗██║██║ ╚████║██║  ██╗███████║
╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
Blinks
------------------------------------------------------------------------------------
--]]

function f_blink_outpost():void
	GoalBlink(Meridian, "goal_outpost");
	CreateThread(audio_meridian_stopallmusic);
	device_set_position (OBJECTS.dm_spelevator_door, 0.74);
	kill_volume_disable(VOLUMES.kill_mer_outpost_door);
	object_destroy(OBJECTS.tracking_elevatorlobby_blip);
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
  CreateThread(f_mer_zone_set_proxy_handler);
end

function f_blink_bowl_1():void
	device_set_power(OBJECTS.dm_exit_door_2, 1);
	device_set_position(OBJECTS.dm_exit_door_2, 1);
	GoalBlink(Meridian, "goal_bowl_1_drive");
	CreateThread(audio_meridian_stopallmusic);
	CreateThread (meridian_tutorials_start);
	--TutorialShowAllIfNotPerformed("training_ping_sub", TUTORIAL.Tracking, 15);
	n_tutorialpoint = 20;
	object_destroy(OBJECTS.tracking_elevatorlobby_blip);
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
  CreateThread(f_mer_zone_set_proxy_handler);
end

function f_blink_bridge():void
	GoalBlink(Meridian, "goal_bridge");
	ai_place(AI.sq_pro_drive);
	ai_place(AI.sg_drive);
	CreateThread (f_spawn_bowl_1);
	CreateThread (f_check_drive_prometheans);
	CreateThread(audio_meridian_stopallmusic);
	n_tutorialpoint = 20;
	object_destroy(OBJECTS.tracking_elevatorlobby_blip);
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
  CreateThread(f_mer_zone_set_proxy_handler);
end

function f_blink_bowl_2():void
	GoalBlink(Meridian, "goal_bowl_2_drive");
	CreateThread(audio_meridian_stopallmusic);
	n_tutorialpoint = 20;
	object_destroy(OBJECTS.tracking_elevatorlobby_blip);
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);
  CreateThread(f_mer_zone_set_proxy_handler);
end

function f_blink_drygrannis_arrival():void
	GoalBlink(Meridian, "goal_drygrannis_arrival");
	CreateThread(audio_meridian_stopallmusic);
	n_tutorialpoint = 20;
	kill_volume_disable(VOLUMES.kill_soft_tv_mer_final);
  kill_volume_disable(VOLUMES.kill_tv_mer_final);	
  CreateThread(f_mer_zone_set_proxy_handler);
end


--[[
██╗   ██╗███╗   ██╗██╗   ██╗███████╗███████╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██║   ██║████╗  ██║██║   ██║██╔════╝██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██╔██╗ ██║██║   ██║███████╗█████╗  ██║  ██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║   ██║██║╚██╗██║██║   ██║╚════██║██╔══╝  ██║  ██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
╚██████╔╝██║ ╚████║╚██████╔╝███████║███████╗██████╔╝    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
 ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝╚═════╝     ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Unused Scripts
------------------------------------------------------------------------------------
--]]
--[[


function f_kick_out_player()
	for _,vehicles in ipairs (volume_return_objects_by_type (VOLUMES.tv_mission_end_vehicles, 2)) do
		print ("Who is in", vehicles);
		vehicle_unload( vehicles, "");
		--unit_exit_vehicle(volume_return_players(VOLUMES.tv_mission_end_vehicles), 3);
		vehicle_set_unit_interaction( vehicles, "", false, true );
		Sleep (2);
	end
	print ("Players Should be ejected");	
end

function f_musketeer_delay_teleport() -- TEMP workaround to fix issue with musketeers teleporting around while driving the player. Remove after this is fixed. DLE
	MusketeersTeleportSetDelay (10000);
end

--function f_check_drive_couplings()
--	-- Opens the door if the couplings are destroyed.
--	SleepUntil([|object_get_health(OBJECTS.cr_drive_coupling_1) <= 0], 1);
--	
--	SleepUntil([|object_get_health(OBJECTS.cr_drive_coupling_2) <= 0], 1);
--	CreateThread(f_open_bridge_door);
--end

function cs_scorpion_delivery() SCRIPT YOU SHOULD USE IF MINERS ARE ABLE TO DRIVE THE SCORPION AGAIN
	cs_crouch(ai_current_actor, true, 1);
	cs_look_object(ai_current_actor, true, OBJECTS.v_skatepark_scorpion);
	
	SleepUntil([|ai_living_fraction(AI.sg_bowl_2_all) > 0], 1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_2_garage) or ai_living_fraction(AI.sg_bowl_2_all) <= .25], 1);
	if volume_test_players(VOLUMES.tv_bowl_2_garage) then
		cs_crouch(ai_current_actor, false, 1);
		cs_look_player(ai_current_actor, true);	
	elseif ai_living_fraction(AI.sg_bowl_2_all) <= .25 then
		unit_enter_vehicle_immediate(ai_current_actor, OBJECTS.v_skatepark_scorpion, 'scorpion_d');
		SleepUntil([|device_get_position(OBJECTS.dm_scorpion_door) >= 0.75], 1);
		cs_go_to(AI.sq_bowl_2_miner_garage.spawnpoint, true, POINTS.ps_bowl_2_scorpion.p01, 1);
		ai_vehicle_exit(ai_current_actor, "");
	end
end

function cs_test_scorpion_drive()
	unit_enter_vehicle_immediate(ai_current_actor, OBJECTS.v_skatepark_scorpion, 'scorpion_d');
	cs_go_to(AI.sq_bowl_2_miner_garage.spawnpoint, true, POINTS.ps_bowl_2_scorpion.p01, 1);
	ai_vehicle_exit(ai_current_actor, "");
end


--]]
--[[
 ██████╗██╗     ██╗███████╗███╗   ██╗████████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║       ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║       ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
╚██████╗███████╗██║███████╗██║ ╚████║   ██║       ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
 ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Client Scripts
------------------------------------------------------------------------------------
--]]

--## CLIENT

--function remoteClient.SoundImpulseStartClientPlayer(player:player, soundTag:tag, theObject:object, theScale:number)
--end

function remoteClient.f_killer_vtol_die()
	effect_new_on_object_marker(TAG('objects\vehicles\forerunner\forerunner_vtol\fx\destruction\explosion_vtol_death.effect'), OBJECTS.killer_vtol, "fx_hull_damage");
	Sleep(1);
	effect_new_on_object_marker(TAG('objects\vehicles\forerunner\forerunner_vtol\fx\destruction\explosion_vtol_death.effect'), OBJECTS.killer_vtol, "fx_hull_damage");
end

function remoteClient.f_door_alarm()
	sound_impulse_start_marker(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_alarmalert.sound'), OBJECTS.dm_spelevator_door, "audio_center", 1);
end

function remoteClient.f_open_bridge_alarm()
	sound_impulse_start( TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_alarmalert.sound'), OBJECTS.dm_bridge_door, 1);
end

function remoteClient.f_open_meridian_station_gate()
	sound_impulse_start( TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_alarmalert.sound'), OBJECTS.dm_drygrannis_door, 1);
end

function remoteClient.f_injured_miners()
	object_create ("dead_miner");
	object_create ("dead_miner_01");
end

function remoteClient.f_bamf_explosion()
	effect_new( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero_t1.effect'), FLAGS.bamf_1 );
	sleep_s (.5);
	effect_kill_from_flag ( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero_t1.effect'), FLAGS.bamf_1 );
end

function remoteClient.f_outpost_vig_fx()
	effect_new( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero.effect'), FLAGS.flg_exp_1 );
	sleep_s (1);
	effect_kill_from_flag( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero.effect'), FLAGS.flg_exp_1 );
end

function remoteClient.f_crashed_ship_fx()
	effect_new( TAG('fx\library\fire\fire_unsc\fire_unsc_md_t4.effect'), FLAGS.fl_fire_01 );
	sleep_s (1);
	effect_new( TAG('fx\library\fire\fire_unsc\fire_unsc_smoke_md_t1.effect'), FLAGS.fl_fire_02 );
end

function remoteClient.f_outpost_gen_spark()
	effect_new( TAG('fx\library\sparks\sparks_hero.effect'), FLAGS.flg_spark_1 );
	effect_new( TAG('fx\library\sparks\sparks_hero.effect'), FLAGS.flg_spark_2 );
end

function f_bridge_fx_test()
	effect_new( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero.effect'), FLAGS.fl_bridge_destruction );
	effect_new( TAG('fx\library\fire\fire_unsc\fire_unsc_smoke_lg_t2.effect'), FLAGS.fl_bridge_destruction );
end

function remoteClient.f_amb_explosions()
  local t_amb_explosions:table={
     FLAGS.fl_amb_expl_01,
     FLAGS.fl_amb_expl_02,
     FLAGS.fl_amb_expl_03,
     FLAGS.fl_amb_expl_04, 
           };       
	local effect_flag:flag=t_amb_explosions[random_range(1,#t_amb_explosions)];
	effect_new( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero.effect'), effect_flag);
	sleep_s (1);
	effect_kill_from_flag( TAG('fx\library\explosion\unsc\explosion_air_unsc_crate_hero.effect'), effect_flag);
end

function f_amb_vtol_flock()
	local t_amb_flak_1:table={
     POINTS.ps_vtol_flock_flak.p0,
     POINTS.ps_vtol_flock_flak.p1,
     POINTS.ps_vtol_flock_flak.p2,
           };
	effect_new_at_ai_point (TAG('objects/vehicles/human/turrets/storm_unsc_artillery/weapon/fx/dummy_firing_blue.effect'), t_amb_flak_1[random_range(1,#t_amb_flak_1)]);
	Sleep (random_range (150, 360));
	CreateThread (f_amb_vtol_flock);
end

function f_amb_pel_flock()
	local t_amb_flak_2:table={
     POINTS.ps_pel_flock_flak.p0,
     POINTS.ps_pel_flock_flak.p1,
     POINTS.ps_pel_flock_flak.p2,
           };
	effect_new_at_ai_point (TAG('objects\vehicles\human\turrets\storm_unsc_artillery\weapon\fx\dummy_firing.effect'), t_amb_flak_2[random_range(1,#t_amb_flak_2)]);
	Sleep (random_range (150, 360));
	CreateThread (f_amb_pel_flock);
end