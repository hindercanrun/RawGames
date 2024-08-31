--## SERVER

--Owner: 
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCOMFIRED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- LAVATUBE
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global gb_ur_laval_construct_01:boolean = false;
global gb_ur_laval_construct_02:boolean = false;
global gb_ur_laval_construct_03:boolean = false;

--[[
   ______            __        __                         __    _ ______ 
  / ____/___  ____ _/ /  _    / /   ____ __   ______ _   / /   (_) __/ /_
 / / __/ __ \/ __ `/ /  (_)  / /   / __ `/ | / / __ `/  / /   / / /_/ __/
/ /_/ / /_/ / /_/ / /  _    / /___/ /_/ /| |/ / /_/ /  / /___/ / __/ /_  
\____/\____/\__,_/_/  (_)  /_____/\__,_/ |___/\__,_/  /_____/_/_/  \__/  
                                                                         
                                                                                                      
--]]            

UnconfirmedReports.goal_lava_lift = 
{
	--ends the goal
	gotoVolume = VOLUMES.tv_ur_lava_lift_end,
	
	--this is the next goal name
	next={"goal_arena"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs030_lava_elevator,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_lavalift,
}

function UnconfirmedReports.goal_lava_lift.Start() :void            
	print ("starting lava lift goal");
	--GoalCreateThread( UnconfirmedReports.goal_lava_lift, f_fore_trans );
	GoalCreateThread( UnconfirmedReports.goal_lava_lift, f_ur_lava_lift );
	
	CreateThread(nar_unconfirmed_lava_lift);	
	CreateThread(f_ur_breadcrumbs_lava_lift);
	game_save();
	sleep_s(1);
	if object_valid("s_ur_breadcrumb_01") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
	if object_valid("s_ur_breadcrumb_07") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
	if object_valid("s_ur_breadcrumb_08") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
end

----FORERUNNER DOOR TRANSITION
--function f_fore_trans()
--	--SPAWN FORERUNNER DOOR ENCOUNTER
--		print("starting forerunner door transition" );
--		--ai_place( AI.sg_ur_fore_trans );
--	
--	--OPEN DOOR WHEN ALL ENEMIES ARE DEAD
--	--SleepUntil([| ai_living_count( AI.sg_ur_fore_trans ) <= 0 ], 1);
--	--SleepUntil([| volume_test_players(VOLUMES.tv_ur_lava_door_open) ], 1);
--	--print("opening door...");
--	--sleep_s(1);
--	--device_set_power(OBJECTS.dm_ur_door_01, 1);
--end

--LAVA ELEVATOR
function f_ur_lava_lift()
	print("__________ startng lava lift goal");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_lavalamp_init) ], 5);
	print("__________ startng lava lift goal 1");
		ai_place( AI.sg_lava_intro);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_laval_c_move_up_01) ], 5);
	print("__________ startng lava lift goal 2");
		CreateThread(f_ur_watcher_intro_01_move);
		CreateThread(f_ur_watcher_intro_02_move);
		CreateThread(f_ur_watcher_intro_03_move);
		
		ai_place( AI.sq_lava_watcher_02);
		
	--SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.zs030_lava_elevator], 30);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_lava_tease_watcher_04) ], 30);
	print("__________ startng lava lift goal 3");
	MusketeerUtil_SetMusketeerGoal(FLAGS.cf_laval_elevator_go_01, 1);
	
	--SleepUntil([| volume_test_players(VOLUMES.tv_ur_lava_bridge_on) ], 30);
	--	object_create_anew("cr_ur_lava_bridge_01");
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_elevator_lava) ], 30);
	print("__________ startng lava lift goal 4");
	sleep_s(2);
	--object_destroy(OBJECTS.cr_ur_lava_bridge_01);
	--Sleep(120);
		
	---adding this becuase all dudes take damage when falling down with lava elevator. KS	
--	for _,spartan in ipairs (spartans()) do  
--		CreateThread(f_ur_lava_temp_invul, spartan);
--	end
	
	device_set_power(OBJECTS.dm_ur_lava_closer, 1);
	device_set_position(OBJECTS.dm_ur_lava_closer, 0);
	f_volume_teleport_all_not_inside(VOLUMES.tv_ur_elevator_lava_full, FLAGS.fl_uc_lavatube);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_ur_lava_closer, true);
	game_save();
	f_mine_cleanup();
	device_set_position(OBJECTS.dm_ur_elevator_lava, 1 );
	--CreateThread(f_ur_lava_prepare_zs_4);
	
	cs_run_command_script(AI.sq_lava_watcher_02.construct_01, "f_cs_ur_constructor_1_mid");
	cs_run_command_script(AI.sq_lava_watcher_02.construct_02, "f_cs_ur_constructor_2_mid");
	cs_run_command_script(AI.sq_lava_watcher_02.construct_03, "f_cs_ur_constructor_3_mid");
	
	sleep_s(0.5);
	CreateThread( f_chapter_title, TITLES.ch_ur_ct_02);
	
	SleepUntil([| volume_test_object(VOLUMES.tv_ur_elevator_watcher_02, OBJECTS.dm_ur_elevator_lava) ], 30);
	sleep_s(0.25);
	f_volume_teleport_all_not_inside(VOLUMES.tv_ur_elevator_lava_full, FLAGS.fl_uc_lavatube_02);
		gb_ur_laval_construct_02 = true;
		
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_elevator_watcher_03) ], 30);
		gb_ur_laval_construct_03 = true;
	
	SleepUntil([| device_get_position(OBJECTS.dm_ur_elevator_lava) == 1 ], 60);
	cs_run_command_script(AI.sq_lava_watcher_02.construct_01, "f_cs_ur_constructor_1_end");
	cs_run_command_script(AI.sq_lava_watcher_02.construct_02, "f_cs_ur_constructor_2_end");
	cs_run_command_script(AI.sq_lava_watcher_02.construct_03, "f_cs_ur_constructor_3_end");
	
	MusketeerUtil_SetMusketeerGoal(FLAGS.cf_laval_elevator_go_02, 0.5);
	--MusketeerUtil_SetDestination_Clear_All();
end

--function f_ur_lava_prepare_zs_4():void
--	SleepUntil([| volume_test_players(VOLUMES.tv_ur_prep_4) ], 5);
----	--prepare_to_switch_to_zone_set(ZONE_SETS.zs040_bridge_arena);
--	--print("__________ prepping");
----	
----	SleepUntil([| volume_test_players(VOLUMES.tv_ur_load_4) ], 5);
----	switch_zone_set(ZONE_SETS.zs040_bridge_arena);
----	print("__________ switching");
----
----	SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.zs040_bridge_arena], 30);
--	sleep_s(8);
--	kill_volume_disable(VOLUMES.kill_ur_lava_preload);
--	print("__________ killing");
--end

function f_ur_watcher_intro_01_move():void
	cs_fly_to(AI.sq_lava_watcher_intro_01, true, POINTS.ps_ur_watcher_tease_move.p01, (random_range(2,4)));
	sleep_s(2);
	gb_ur_laval_construct_01 = true;
end

function f_ur_watcher_intro_02_move():void
	cs_fly_to(AI.sq_lava_watcher_intro_02, true, POINTS.ps_ur_watcher_tease_move.p02, (random_range(2,4)));
end

function f_ur_watcher_intro_03_move():void
	cs_fly_to(AI.sq_lava_watcher_intro_03, true, POINTS.ps_ur_watcher_tease_move.p03, (random_range(2,4)));
end

function f_ur_lava_cleanup()
	ai_erase( AI.sg_lava_all );
	object_destroy_folder ( "crs_lava" );
end

-----adding this becuase all dudes take damage when falling down with lava elevator. KS
--function f_ur_lava_temp_invul(spartan:object):void
--	unit_falling_damage_disable(spartan, true);
--	object_cannot_take_damage(spartan);
--end

function f_cs_ur_constructor_1_start():void
	cs_vehicle_speed(0.25);
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_start.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p04, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p06, (random_range(2,4)));
		sleep_s(2);
	until false;
end

function f_cs_ur_constructor_2_start():void
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_start.p06, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p04, (random_range(2,4)));
		sleep_s(2);
	until false;
end

function f_cs_ur_constructor_3_start():void
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_start.p04, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p06, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_start.p03, (random_range(2,4)));
		sleep_s(2);
		until false;
end

function f_cs_ur_constructor_1_mid():void
	cs_vehicle_speed(0.25);
	cs_fly_to(POINTS.ps_ur_constructor_mid.p01_1, (random_range(2,4)));
	--repeat
		cs_fly_to(POINTS.ps_ur_constructor_mid.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p08, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p11, (random_range(2,4)));
		sleep_s(2);
	--until false;
	cs_fly_to(POINTS.ps_ur_constructor_mid.p_end_01, (random_range(2,4)));
end

function f_cs_ur_constructor_2_mid():void
	cs_vehicle_speed(0.25);
	cs_fly_to(POINTS.ps_ur_constructor_mid.p01_2, (random_range(2,4)));
	--repeat
		cs_fly_to(POINTS.ps_ur_constructor_mid.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p06, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p09, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p12, (random_range(2,4)));
		sleep_s(2);
	--until false;
	cs_fly_to(POINTS.ps_ur_constructor_mid.p_end_02, (random_range(2,4)));
end

function f_cs_ur_constructor_3_mid():void
	cs_vehicle_speed(0.25);
	cs_fly_to(POINTS.ps_ur_constructor_mid.p01_3, (random_range(2,4)));
	--repeat
		cs_fly_to(POINTS.ps_ur_constructor_mid.p04, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p07, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p10, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_mid.p13, (random_range(2,4)));
		sleep_s(2);
	--until false;
	cs_fly_to(POINTS.ps_ur_constructor_mid.p_end_03, (random_range(2,4)));
end

function f_cs_ur_constructor_1_end():void
	cs_vehicle_speed(0.25);
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_end.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p04, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p06, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p07, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p08, (random_range(2,4)));
		sleep_s(2);
	until false;
end

function f_cs_ur_constructor_2_end():void
	cs_vehicle_speed(0.25);
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_end.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p08, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p07, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p04, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p06, (random_range(2,4)));
		sleep_s(2);
	until false;
end

function f_cs_ur_constructor_3_end():void
	cs_vehicle_speed(0.25);
	repeat
		cs_fly_to(POINTS.ps_ur_constructor_end.p08, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p03, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p07, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p05, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p01, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p06, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p02, (random_range(2,4)));
		sleep_s(2);
		cs_fly_to(POINTS.ps_ur_constructor_end.p04, (random_range(2,4)));
		sleep_s(2);
	until false;
end

function f_ur_breadcrumbs_lava_lift():void
	object_create("s_ur_breadcrumb_09");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_09) ], 30);
	object_destroy(OBJECTS.s_ur_breadcrumb_09);
	object_create("s_ur_breadcrumb_09_2");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_elevator_lava) ], 30);
	object_destroy(OBJECTS.s_ur_breadcrumb_09_2);
	object_create("s_ur_breadcrumb_09_5");
end