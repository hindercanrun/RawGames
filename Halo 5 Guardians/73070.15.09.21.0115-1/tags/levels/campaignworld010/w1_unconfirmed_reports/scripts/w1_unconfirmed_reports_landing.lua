--## SERVER

--Owner: 
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCOMFIRED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*


---------------------------------------------------------------
---------------------------------------------------------------
-- LANDING
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global b_move_marines = false;
global b_all_waves_done = false;
global b_marines_move_up_1 = false;
global b_marines_move_up_2 = false;
global b_marines_move_up_3 = false;
global b_marines_move_up_mid = false;
global b_marines_move_up_front = false;
global b_mid_level_marines_move_up = false;
global b_ur_backup_pelican_spawn = false;
global b_ur_landing_3rd_wave_spawned = false;
global b_ur_landing_all_back_waves_spawned = false;
global b_ur_marines_unloaded = false;
global b_ur_audio_landing_combat_start = false;
global b_ur_audio_landing_combat_stop = false;
global b_ur_landing_bridge_guards_spawned = false;
global b_ur_playfighting_off = false;
global b_ur_pelican_dropoff_takeoff = false;
global b_ur_p2_dropoff_takeoff = false;
global n_ur_intro_pelican_show:number = nil;
global b_ur_intro_boarded = false;
global b_ur_intro_ejected = false;
global b_ur_marine_to_computer = false;
global b_ur_landing_backup_pelican_dropoff = false;

--[[
   ______            __        __  ____       _                ____                
  / ____/___  ____ _/ /  _    /  |/  (_)___  (_)___  ____ _   / __ )____ _________ 
 / / __/ __ \/ __ `/ /  (_)  / /|_/ / / __ \/ / __ \/ __ `/  / __  / __ `/ ___/ _ \
/ /_/ / /_/ / /_/ / /  _    / /  / / / / / / / / / / /_/ /  / /_/ / /_/ (__  )  __/
\____/\____/\__,_/_/  (_)  /_/  /_/_/_/ /_/_/_/ /_/\__, /  /_____/\__,_/____/\___/ 
                                                  /____/                           
                                                                                                      
--]]                                             

UnconfirmedReports.goal_mining_base = 
{
	gotoVolume = VOLUMES.tv_ur_ship_path_checkpoint,
	zoneSet = ZONE_SETS.zs005_landing,
	next={"goal_chief_ship"},
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_miningbase,
}

function f_ur_pelican_board():void -- called from composition
	if b_ur_intro_boarded == false then
		camera_control(false);
		vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_r05", SPARTANS.buck);
		vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_l05", SPARTANS.tanaka);
		vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_r04", SPARTANS.vale);
		vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_l04", SPARTANS.locke);
		b_ur_intro_boarded = true;
	end
end

function f_ur_pelican_eject():void	-- called from composition
	if b_ur_intro_ejected == false then
		CreateThread(f_ur_pelican_eject_timer);
		b_ur_intro_ejected = true;
	end
end

function f_ur_pelican_eject_timer():void
	player_control_fade_in_all_input(1);
	sleep_s(0.5);
	ai_braindead(AI.sq_ur_musketeers, false);
	Sleep(5);
	
	vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_r05");
	sleep_s(0.25);
	vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_l05");
	sleep_s(0.25);
	vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_r04");
	sleep_s(0.25);
	vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_player2), "pelican_p_l04");
	sleep_s(0.15);
	ai_braindead(AI.sq_ur_musketeers, false);
	
	sleep_s(13);
	b_ur_pelican_dropoff_takeoff = true;
end

function f_ur_intro_cinematic_call_2():void
	CreateThread(f_ur_intro_cinematic_call_script);
end

function f_ur_intro_cinematic_call_script():void
	--print("f_ur_intro_cinematic_call_script");
	Sleep(1);
	--composer_stop_show(n_ur_intro_pelican_show);
	sleep_s(0.25);
	
	composer_play_show("vin_w1_un_reports_pelican_intro_part2");
	
	--gmu 9/11/2015-- OSR-157355 adding time for vignette to be started before fading in
	--wish I could fix proper 
	sleep_s (0.25);
	fade_in( 0, 0, 0, 30 );
	sleep_s(5.75);

	print("Switched zoneset");
	switch_zone_set(ZONE_SETS.zs010_chiefship);
	SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.zs010_chiefship], 3);
	Sleep(1);
	print("_____________ game save immediate");
	game_save_immediate();
end

function UnconfirmedReports.goal_mining_base.Start() :void
	prepare_to_switch_to_zone_set(ZONE_SETS.zs010_chiefship);
	print("Preparing to switch zoneset");

	CreateThread(audio_unconfirmedreports_thread_up_uppermines_blank);
	CreateThread(audio_unconfirmedreports_start_distant_battle);
	SleepUntil ([| PlayersAreAlive() ],1);
	--fade_in(0, 0, 0, 100);

	--turning off supply cache icons near the prowler
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_ship_01, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_ship_02, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_quarry_01, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_quarry_02, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_01, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_02, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_03, false);
	
	camera_control(true);
	ai_braindead(AI.sq_ur_musketeers, true);
	n_ur_intro_pelican_show = composer_play_show("vin_w1_un_reports_pelican_intro");

	
	Sleep(1);
	CreateThread( f_chapter_title, TITLES.ch_ur_ct_01);
	CreateThread(f_ur_move_miners_up_01);
	CreateThread(f_chief_ship_view);
	CreateThread(f_ur_breadcrumbs_landing);
	CreateThread(f_ur_land_save_intro);
	GoalCreateThread (UnconfirmedReports.goal_mining_base, VinMinerAttack);
	sleep_s(5);
	game_save_no_timeout();

	CreateThread( nar_unconfirmed_mining_base );
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_view_ai_moveup_01) ], 1);
	game_save_no_timeout();
	f_ur_landing_respawn_weapon_profile_set();
	ai_place( AI.sq_ur_ship_view_marines_00 );
	NavpointShowAllServer(AI.sq_ur_ship_view_marines_00, "ally");
	--ai_place( AI.sq_ur_ship_view_marines_04 );
	sleep_s(3);
	--ai_place( AI.sq_ur_ship_view_marines_02 );
	ai_place( AI.sq_ur_ship_view_marines_03 );
	NavpointShowAllServer(AI.sq_ur_ship_view_marines_03, "ally");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_landing_playfighting_off) ], 30);
	b_ur_playfighting_off = true;
end

function f_ur_move_miners_up_01():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_move_up_marines_01) ], 1);
	b_marines_move_up_1 = true;
end

function f_ur_land_save_intro():void
	sleep_s(13);
	game_save_no_timeout();
end

function VinMinerAttack()
  SleepUntil ([| volume_test_players (VOLUMES.vin_w1_un_reports_miner_attack_tv) or volume_test_players (VOLUMES.vin_w1_un_reports_miner_attack_tv2) or volume_test_players (VOLUMES.vin_w1_un_reports_miner_attack_tv3)], 1);
  pup_play_show ("vin_w1_un_reports_miner_attack_02");
  NavpointShowAllServer(AI.vin_w1_un_reports_miner_atk2_1, "ally");
  sleep_s(1.16);
  pup_play_show ("vin_w1_un_reports_miner_attack_01");
  NavpointShowAllServer(AI.vin_w1_un_reports_miner_atk1_1, "ally");
  game_save_no_timeout();
end

--unused--
--MARINE AT BASE WAVES PLAYER OVER
--function cs_ur_marine_waves_01()
--	print("play custom anim");
--	--cs_custom_animation( TAG('sq_ur_drive_06'), "panic:idle" );
--	repeat
--		cs_action_at_player(AI.sq_ur_base_marine_01.sp1, true, 20);
--		sleep_s(1);
--	until (0 == 1);
--end

function f_ur_landing_respawn_weapon_profile_set():void
	player_set_profile(STARTING_PROFILES.sp_ur_start_respawn, nil);
end

function f_ur_cs_intro_pelican():void
	sleep_s(2);
	CreateThread(f_ur_intro_miners_on_foot);
	--Sleep(1);
	--ai_vehicle_enter_immediate(AI.sq_ur_base_marine_move_01, ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_r04");
	--ai_vehicle_enter_immediate(AI.sq_ur_base_marine_move_02, ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_l05");
	--ai_vehicle_enter_immediate(AI.sq_ur_base_marine_move_03, ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_r05");
	--sleep_s(1.5);
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_r04");
	--sleep_s(0.75);
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_l05");
	--sleep_s(0.5);
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_miner2), "pelican_p_r05");
	sleep_s(4);
	b_ur_p2_dropoff_takeoff = true;
end

function f_ur_intro_miners_on_foot():void
	ai_place(AI.sq_ur_base_marine_move_01);
	NavpointShowAllServer(AI.sq_ur_base_marine_move_01, "ally");
	ai_place(AI.sq_ur_base_marine_move_02);
	NavpointShowAllServer(AI.sq_ur_base_marine_move_02, "ally");
	ai_place(AI.sq_ur_base_marine_move_03);
	NavpointShowAllServer(AI.sq_ur_base_marine_move_03, "ally");
end

function f_ur_load_backup_pelican_call():void
	CreateThread(f_ur_load_backup_pelican);
end

function f_ur_load_backup_pelican():void
	CreateThread(f_ur_spawn_mid_level_marines);
	--Sleep(1);
	--vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r02", AI.sq_ur_mid_level_marines.spawnpoint10);
	--vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r03", AI.sq_ur_mid_level_marines.spawnpoint11);
	---vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r04", AI.sq_ur_mid_level_marines.spawnpoint12);
	--vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_l03", AI.sq_ur_mid_level_marines.spawnpoint13);
	--vehicle_load_magic(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_l04", AI.sq_ur_mid_level_marines_lead.spawnpoint14);
end

function f_ur_unload_backup_pelican_call():void
	if b_ur_landing_backup_pelican_dropoff == false then
		CreateThread(f_ur_unload_backup_pelican);
		b_ur_landing_backup_pelican_dropoff = true;
	end
end

function f_ur_spawn_mid_level_marines():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_pathway_fore_01) ], 1);
	ai_place(AI.sq_ur_mid_level_marines);
	--ai_place(AI.sq_ur_mid_level_marines_lead);
end

function f_ur_unload_backup_pelican():void
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r04");
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_l04");
	sleep_s(2);
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r03");
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_l03");
	sleep_s(2);
	--vehicle_unload(ai_vehicle_get(AI.sq_vin_pelican_backup), "pelican_p_r02");
	b_ur_marines_unloaded = true;
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_mid_level_marines_move) ], 1);
	--cs_look_player(AI.sq_ur_mid_level_marines_lead, true);
	--Sleep(1);
	--cs_face_player(AI.sq_ur_mid_level_marines_lead, true);
	--composer_play_show ("comp_ur_miner_lead");
	NavpointShowAllServer(AI.sq_ur_mid_level_marines, "ally");
	--NavpointShowAllServer(AI.sq_ur_mid_level_marines_lead, "ally");
	b_miner_online_line = true;
	sleep_s(1);
	b_ur_marine_to_computer = true;
end

--function f_ur_miner_lead_convo():void
--	SleepUntil([| b_ur_marines_unloaded == true], 1);
--end

--START CHIEF'S SHIP VIEW ENCOUNTER
function f_chief_ship_view()
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_view_begin_01) ], 1);
		object_create( "veh_ur_turret_03" );
		b_marines_move_up_2 = true;
		b_ur_audio_landing_combat_start = true;

	--SPAWN DEFAULT WAVE
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_view_ai_moveup_02) ], 1);
		--CreateThread( SlipSpaceSpawn, AI.sq_ur_base_fore_01 );
		ai_place(AI.sq_ur_base_fore_01 );
		b_marines_move_up_2 = true;
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_view_begin_02) ], 1);
		game_save_no_timeout();
		ai_place(AI.sg_ur_ship_view_00 );
		CreateThread(f_ur_landing_marines_move_up_mid);
		CreateThread(f_ur_landing_bridge_guards);
		CreateThread(f_ur_pelican_back_up);
		CreateThread(f_ur_mid_level_marine_start);
		CreateThread(f_ur_landing_officer_door_backup);
		
	--SPAWN FIRST WAVE
	SleepUntil([| ai_spawn_count(AI.sg_ur_ship_view_00) > 0 and ai_living_count( AI.sg_ur_ship_view_00 ) <= 4 ], 1);
		--print("SPAWNING 1ST WAVE");
		CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_01_a );
		sleep_s(random_range(0.5,2));
		CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_01_b );
		
	--SPAWN SECOND WAVE	
	SleepUntil([| ai_spawn_count(AI.sg_ur_ship_view_01) > 0 and ai_living_count( AI.sg_ur_ship_view_01 ) <= 3 ], 1);
		--print("SPAWNING 2ND WAVE");
		CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_02_a );
		sleep_s(random_range(0.5,2));
		CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_02_b );
		sleep_s(random_range(0.5,2));
		CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_officers_2 );
		
	if game_coop_player_count() >= 3 then
		CreateThread( SlipSpaceSpawn, AI.sq_ur_ship_view_fore_02f );
		sleep_s(random_range(0.5,2));
		CreateThread( SlipSpaceSpawn, AI.sq_ur_ship_view_fore_02d2 );
	end
		
	SleepUntil([| ai_spawn_count(AI.sg_ur_ship_view_02) > 0 and ai_living_count( AI.sg_ur_ship_view_02 ) <= 3 ], 1);
		if b_ur_landing_3rd_wave_spawned == false then
			CreateThread( SlipSpaceSpawn, AI.sg_ur_ship_view_03 );
			b_ur_landing_3rd_wave_spawned = true;
		end
	
	SleepUntil([|b_ur_landing_all_back_waves_spawned ], 1);
	sleep_s(3.6);
	CreateThread(f_ur_landing_all_combat_over);
	b_all_waves_done = true;
	game_save_no_timeout();
end	

function f_ur_pelican_back_up():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_pelican_backup) ], 15);
	composer_play_show ("vin_w1_un_reports_pelican_backup");
	b_marines_move_up_front = true;
end

function f_ur_landing_marines_move_up_mid():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_landing_marine_move_up_mid) ], 30);
	b_marines_move_up_mid = true;
end

function f_ur_landing_bridge_guards():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_flank) ], 15);
	if b_ur_landing_bridge_guards_spawned == false then
		ai_place(AI.sq_ur_ship_fore_bridge_guard_01);
		ai_place(AI.sq_ur_ship_fore_bridge_guard_02);
		b_ur_landing_bridge_guards_spawned = true;
	end
end

function f_ur_landing_officer_door_backup():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_landing_back_door_guards) ], 5);
	if b_ur_landing_bridge_guards_spawned == false then
		CreateThread(SlipSpaceSpawn, AI.sq_ur_ship_fore_bridge_guard_01);
		CreateThread(SlipSpaceSpawn, AI.sq_ur_ship_fore_bridge_guard_02);
		b_ur_landing_bridge_guards_spawned = true;
	end
	
	ai_place(AI.sg_ur_ship_view_officers_point);
	sleep_s(random_range(0.5,2));
	ai_place(AI.sg_ur_ship_view_officers_scatte);
	sleep_s(3.6);
	b_ur_landing_3rd_wave_spawned = true;
	b_ur_landing_all_back_waves_spawned = true;
end

---------------------------------------------------------------
---------------------------------------------------------------
-- Mid Level Marines
---------------------------------------------------------------
---------------------------------------------------------------
function f_ur_mid_level_marine_start():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_mid_level_marines) ], 30);
	ai_place(AI.sq_ur_fore_fodder_pawns);
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_mid_level_marines_move) ], 30);
	SleepUntil([| b_ur_marines_unloaded == true], 1);
	b_mid_level_marines_move_up = true;
	game_save_no_timeout();
end
---------------------------------------------------------------
---------------------------------------------------------------
-- Bools for combat complete audio and combat complete narrative
---------------------------------------------------------------
---------------------------------------------------------------
function f_ur_landing_all_combat_over():void
	SleepUntil([| ai_spawn_count(AI.sg_ur_ship_enemy_all) > 0 ], 1);
	SleepUntil([| ai_living_count(AI.sg_ur_ship_enemy_all) == 0 ], 30);
	sleep_s(3);
	outpost_battle_complete = true;
	b_ur_audio_landing_combat_stop = true;
	CreateThread(audio_unconfirmedreports_thread_up_landing_start);
	game_save_no_timeout();
end

function f_ur_breadcrumbs_landing():void
	sleep_s(1);
	object_create("s_ur_breadcrumb_01");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_01) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_01);
	sleep_s(1);
	object_create("s_ur_breadcrumb_02");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_02) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_02);
	object_create("s_ur_breadcrumb_03");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_03) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_03);
	NavpointStopAllServer(AI.sq_ur_base_marine_move_01);
	NavpointStopAllServer(AI.sq_ur_base_marine_move_02);
	NavpointStopAllServer(AI.sq_ur_base_marine_move_03);
	NavpointStopAllServer(AI.sq_ur_ship_view_marines_00);
	NavpointStopAllServer(AI.sq_ur_ship_view_marines_03);
	NavpointStopAllServer(AI.vin_w1_un_reports_miner_atk1_1);
	NavpointStopAllServer(AI.vin_w1_un_reports_miner_atk2_1);
	sleep_s(1);
	object_create("s_ur_breadcrumb_04");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_04) or volume_test_players(VOLUMES.tv_ur_breadcrumb_04_2)], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_04);
	sleep_s(1);
	object_create("s_ur_breadcrumb_05");
end