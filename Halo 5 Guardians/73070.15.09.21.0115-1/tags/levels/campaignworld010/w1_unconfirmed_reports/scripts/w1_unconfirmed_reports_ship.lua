--## SERVER

--Owner: 
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCOMFIRED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- SHIP
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------

global gb_ship_start_fight:boolean = false;
global gb_ship_officers_spawned:boolean = false;
global gb_quarry_door_open:boolean = false;
global gb_ship_knight_full_area:boolean = false;

--[[
   ______            __        _____ __    _          ____        __  __  
  / ____/___  ____ _/ /  _    / ___// /_  (_)___     / __ \____ _/ /_/ /_ 
 / / __/ __ \/ __ `/ /  (_)   \__ \/ __ \/ / __ \   / /_/ / __ `/ __/ __ \
/ /_/ / /_/ / /_/ / /  _     ___/ / / / / / /_/ /  / ____/ /_/ / /_/ / / /
\____/\____/\__,_/_/  (_)   /____/_/ /_/_/ .___/  /_/    \__,_/\__/_/ /_/ 
                                        /_/                               
                                                                                                      
--]]                                             
--UnconfirmedReports.goal_ship_path = 
--{
--	--ends the goal
--	gotoVolume = VOLUMES.tv_ur_ship_tracking_start,
--	
--	--this is the next goal name
--	next={"goal_chief_ship"},
--	
--	-- the zoneset the goal starts in
--	zoneSet = ZONE_SETS.zs010_chiefship,
--	
--	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
--	checkPoints = POINTS.ps_ur_checkpoint_shippath,
--}

--function UnconfirmedReports.goal_ship_path.Start() :void            
--	print ("starting first goal");
--	--GoalCreateThread( UnconfirmedReports.goal_ship_path, f_ur_ship_path );
--	--put everything here
--	CreateThread(f_ur_breadcrumbs_ship_path);
--	CreateThread(nar_unconfirmed_ship_path); 
--end

--PATH TO SHIP
--function f_ur_ship_path()
--	--SleepUntil([| volume_test_players(VOLUMES.tv_knight_save) ], 1);
--		--print("CHECKPOINT!");
--		--game_save_no_timeout();
--					
--	--CREATE OFFICERS & TRACKING OBJECTS
--	--SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_knight_fallback) ], 1);
--		--ai_place( AI.sq_ur_ship_officer_01 );
--		--ai_place( AI.sq_ur_ship_officer_02 );
--end

--[[
   ______            __        ________    _      ____   _____ __    _     
  / ____/___  ____ _/ /  _    / ____/ /_  (_)__  / __/  / ___// /_  (_)___ 
 / / __/ __ \/ __ `/ /  (_)  / /   / __ \/ / _ \/ /_    \__ \/ __ \/ / __ \
/ /_/ / /_/ / /_/ / /  _    / /___/ / / / /  __/ __/   ___/ / / / / / /_/ /
\____/\____/\__,_/_/  (_)   \____/_/ /_/_/\___/_/     /____/_/ /_/_/ .___/ 
                                                                  /_/      
                                                                                                      
--]]            

UnconfirmedReports.goal_chief_ship = 
{
	--ends the goal
	--gotoVolume = VOLUMES.tv_ur_quarry_door_open,
	--useObject = "dc_door_ship_tracking_01",  -manually ending
		
	--this is the next goal name
	next={"goal_quarry"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs010_chiefship,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_chiefship,
}

function UnconfirmedReports.goal_chief_ship.Start() :void            
	CreateThread(nar_unconfirmed_ship_area);
	CreateThread(nar_unconfirmed_ship_path); 
	GoalCreateThread( UnconfirmedReports.goal_chief_ship, f_blip_tracking_button );
	--sleep_s(0.167);
	CreateThread(f_ur_breadcrumbs_ship_path);
	sleep_s(0.167);
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_tracking_start) ], 1);
	GoalCreateThread( UnconfirmedReports.goal_chief_ship, f_ship_spawn_manager );
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_tracking_area) ], 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_landing_end_01, false);
end

function f_ship_spawn_manager():void
	--THESE GUYS ARE SLEEPING
	ai_place(AI.sq_ship_knight_birth);
	ai_place(AI.sq_ship_pawns_01);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_knight_birth) ], 30);
	cs_force_combat_status(AI.sq_ship_pawns_01, 2);
	cs_force_combat_status(AI.sq_ship_knight_birth, 2);
	
		gb_ship_start_fight = true;
		local l_timer:number  = timer_stamp(1);

	SleepUntil( [| volume_test_players(VOLUMES.tv_ur_ship_combat_knight_sleep) or timer_expired(l_timer) ], 30);			
		CreateThread( SlipSpaceSpawn, AI.sq_ship_knights_01 );
		gb_ship_knight_full_area = true;
		sleep_s(7);
		CreateThread( SlipSpaceSpawn, AI.sq_ship_pawns_02 );
	SleepUntil([| ai_spawn_count(AI.sq_ship_pawns_02) > 0 and ( ai_living_count(AI.sg_ship_enemy_all) <= 3 or ai_living_count(AI.sg_ship_knights) <= 0 )], 30);
		game_save_no_timeout();
		sleep_s(5);
		CreateThread( SlipSpaceSpawn, AI.sg_ship_soldiers );
		CreateThread(audio_unconfirmedreports_thread_up_landing_waves);
	SleepUntil([| ai_spawn_count(AI.sg_ship_soldiers) > 0 and ai_living_count(AI.sg_ship_knights) <= 1 and ai_living_count(AI.sg_ship_enemy_all) <= 2 ], 30);
		game_save_no_timeout();
				
		sleep_s(1);
		CreateThread( SlipSpaceSpawn, AI.sq_ship_officer_01 );
		sleep_s(0.25);
		CreateThread( SlipSpaceSpawn, AI.sq_ship_officer_02 );

		if ai_living_count(AI.sg_ship_knights) > 0 then
			sleep_s(5);
		end
			
		--CreateThread( SlipSpaceSpawn, AI.sg_ship_officers_2 );
		
		if coop_players_3() then
			CreateThread( SlipSpaceSpawn, AI.sg_ship_officers_coop );
		end
		
		sleep_s(2);
		CreateThread( SlipSpaceSpawn, AI.sq_ship_bishop_alive );
		sleep_s(5);
		gb_ship_officers_spawned = true;
end

function f_spawn_fing_watcher()
	repeat
			print("trying to birth a watcher ... ");
		if ai_spawn_count( AI.sq_ship_bishop_birth) <= 0 then
			ai_place_with_birth(AI.sq_ship_bishop_birth);
		end
		sleep_s(10);
	until ai_spawn_count( AI.sq_ship_bishop_birth ) > 0 ;
end

function f_spawn_fing_watcher2()
	repeat
			print("trying to birth a watcher2 ... ");
		if ai_spawn_count( AI.sq_ship_bishop_birth_2) <= 0 then
			ai_place_with_birth(AI.sq_ship_bishop_birth_2);
		end
		sleep_s(10);
	until ai_spawn_count( AI.sq_ship_bishop_birth_2 ) > 0 ;
end

--BLIP DOOR BUTTON
function f_blip_tracking_button()
	SleepUntil( [| ai_spawn_count(AI.sg_ship_enemy_all) > 0 and ai_living_count(AI.sg_ship_enemy_all) <= 0 and gb_ship_officers_spawned] ,1 );
	sleep_s(3);
	prowler_battle_complete = true;	--using this for audio as well. KS
	game_save_no_timeout();
	CreateThread(audio_unconfirmedreports_thread_up_landing_waves_outro);
	SleepUntil([| prowler_ready_to_scan == true  ], 1);
		Sleep(1);
		ObjectSetSpartanTrackingEnabled(OBJECTS.dc_door_ship_tracking_01, true);
		RegisterSpartanTrackingPingObjectEvent(nar_prowler_pinged, OBJECTS.dc_door_ship_tracking_01)
		device_set_power(OBJECTS.dc_door_ship_tracking_01, 1);
		CreateThread(f_ship_exit_door_wait);
	SleepUntil([| device_get_position(OBJECTS.dc_door_ship_tracking_01) > 0.75 ], 1);
	Sleep(10);
		ObjectSetSpartanTrackingEnabled(OBJECTS.dc_door_ship_tracking_01, false);
		device_set_power(OBJECTS.dc_door_ship_tracking_01, 0);
		sleep_s(3.7);
		object_set_variant(OBJECTS.cr_ur_ship_prowler_screen, "deactivated");
	SleepUntil([| prowler_door_blip == true ], 1);
		sleep_s(0.167);
		CreateThread(f_ur_ship_prowler_screen_change);
	SleepUntil([| prowler_door_open == true ], 1);
	object_create("s_ur_tracking_obj_02_door");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_exit) ], 1);		
		object_destroy(OBJECTS.s_ur_tracking_obj_02_door);
		device_set_power(OBJECTS.quarry_door_temp, 1);
		Sleep(2);
		device_set_position(OBJECTS.quarry_door_temp, 0.9);
		sleep_s(0.9);
		GoalComplete(UnconfirmedReports.goal_chief_ship);
end

function f_ur_ship_prowler_screen_change():void
	sleep_s(2);
	object_set_variant(OBJECTS.cr_ur_ship_prowler_screen, "deactivated");
end

function cs_charge()
	cs_force_combat_status(9)
end

function f_ship_exit_door_wait()
	SleepUntil([| device_get_position(OBJECTS.quarry_door_temp) >= 0.45 ], 20);
	sleep_s(1);
	gb_quarry_door_open = true;
	SleepUntil([| device_get_position(OBJECTS.quarry_door_temp) >= 0.9 ], 20);
	device_set_power(OBJECTS.quarry_door_temp, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.quarry_door_temp, false);
end

function f_ship_cleanup()
	--object_destroy_folder("crs_ship");
	--object_destroy_folder("wpns_ship");
end

function test_birth()
	ai_place(AI.sq_ship_knight_birth);
end

function cs_knight_birth()
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_knight_birth) or ai_combat_status(ai_current_actor) >= 2], 1);
	CreateThread(f_ship_knight_birth, ai_current_actor);
	gb_ship_start_fight = true;  --using this for audio as well. KS
end

function f_ship_knight_birth( knight:ai)
	SleepUntil([|ai_combat_status( knight ) >= 2], 1);
	ai_place_with_birth(AI.sq_ship_bishop_birth);
end

function cs_knight_birth_2()
	ai_place_with_birth(AI.sq_ship_bishop_birth_2);
end

function f_ur_breadcrumbs_ship_path():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ur_breadcrumb_05) or volume_test_players(VOLUMES.tv_ur_breadcrumb_05_2)], 5);
	game_save_no_timeout();
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_ship_01, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_ship_02, true);
	if object_valid("s_ur_breadcrumb_05") then
		object_destroy(OBJECTS.s_ur_breadcrumb_05);
	end
	if object_valid("s_ur_breadcrumb_01") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
end

--### DC Prowler Controls ###############################
global gb_ur_comp_prowler:number = -1;

function f_activator_get_prowler(trigger:object, activator:object)
	local pl:player = unit_get_player(activator);
	local show:number = composer_play_show ("collectible", {scanner = pl});
	
	--local this_activator:object = activator or PLAYERS.player0 ;
	--gb_ur_comp_prowler = composer_play_show("comp_ur_prowler_press", {ics_player = this_activator});
	CreateThread(f_ur_prowler_hologram);
end

function f_ur_prowler_hologram():void
	sleep_s(1);
	CreateThread(audio_activate_hologram);
end

--### DC Prowler Controls End ###############################