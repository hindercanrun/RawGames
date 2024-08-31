--## SERVER

--Owner: 
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCOMFIRED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- MINE
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global gb_mines_begin:boolean = false;
global gb_mines_complete:boolean = false;
global n_mine_objcon:number = 0;
global gb_officer_big_guns_ready:boolean = false;
global gb_officer_big_guns_over:boolean = false;
global n_vin_soldier_equip_lmg:number = 0;

--[[
   ______            __        __  __                         __  ____                
  / ____/___  ____ _/ /  _    / / / /___  ____  ___  _____   /  |/  (_)___  ___  _____
 / / __/ __ \/ __ `/ /  (_)  / / / / __ \/ __ \/ _ \/ ___/  / /|_/ / / __ \/ _ \/ ___/
/ /_/ / /_/ / /_/ / /  _    / /_/ / /_/ / /_/ /  __/ /     / /  / / / / / /  __(__  ) 
\____/\____/\__,_/_/  (_)   \____/ .___/ .___/\___/_/     /_/  /_/_/_/ /_/\___/____/  
                                /_/   /_/                                             
                                                                                                      
--]]            

UnconfirmedReports.goal_upper_mines = 
{
	--ends the goal
	gotoVolume = VOLUMES.tv_ur_upper_mine_complete,

	--this is the next goal name
	next={"goal_lava_lift"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs020_cave,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_uppermines,
}

function f_activate():void
	print ("turrets");
end

function UnconfirmedReports.goal_upper_mines.Start() :void            
	print ("starting first goal");
	RegisterDeathEvent(UR_MongooseDeath, nil);
	CreateThread(f_ur_breadcrumbs_upper_mine);
	CreateThread(f_ur_upper_mines_airlock);
	CreateThread(audio_unconfirmedreports_thread_up_upper_mines);
	
	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs020_cave], 1);
		Sleep(5);
		game_save_no_timeout();
		Sleep(5);
		GoalCreateThread( UnconfirmedReports.goal_upper_mines, f_ur_upper_mines_spawn_manager );
		--GoalCreateThread( UnconfirmedReports.goal_upper_mines, f_ur_upper_mines_airlock );
		
		GoalCreateThread( UnconfirmedReports.goal_upper_mines, f_mine_turret_01 );
		GoalCreateThread( UnconfirmedReports.goal_upper_mines, f_mine_turret_02 );

		GoalCreateThread( UnconfirmedReports.goal_upper_mines, f_upper_mine_checkpoints );
		
			--maybe make these waterfall (we might not want all to go at the same time
--		--GoalCreateThread (UnconfirmedReports.goal_upper_mines, VinPawnsFlee);
--		GoalCreateThread (UnconfirmedReports.goal_upper_mines, VinCavePawns);
--		GoalCreateThread (UnconfirmedReports.goal_upper_mines, VinCaveKnight);
		
		CreateThread(nar_unconfirmed_upper_mines);
		
		sleep_s(1);
	if object_valid("s_ur_breadcrumb_01") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
	
	if object_valid("s_ur_breadcrumb_06") then
		object_destroy(OBJECTS.s_ur_breadcrumb_06);
	end
	
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_01, true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_02, true);

	gb_mines_begin = true;
	Wake(dormant.f_uncon_mine_objcon_controller);
	
	SleepUntil( [| volume_test_players( VOLUMES.tv_ur_upper_mine_complete ) ], 1 );
	
	ai_place(AI.sq_lava_watcher_intro_03);
	
	gb_mines_complete = true;
	upper_mine_battle_complete = true;
	game_save_no_timeout();
end

function UnconfirmedReports.goal_upper_mines.End() :void  
	print("UpperMines Complete");
end
--*************VIGNETTES**************

--global b_VinPawnsFlee:boolean = false;
--global b_VinCavePawns:boolean = false;
--global b_VinCaveKnight:boolean = false;

--function VinPawnsFlee()
--	pup_play_show ("vin_w1_un_reports_pawns_fleeaway");
--	SleepUntil([| volume_test_players(VOLUMES.vin_w1_un_reports_pawns_flee_triggervolume) ], 1);
--	b_VinPawnsFlee = true;
--end

--function VinCavePawns()
--	pup_play_show ("vin_w1_un_reports_cave_pawns");
--	SleepUntil([| volume_test_players(VOLUMES.vin_w1_un_reports_cave_pawns_triggervolume) ], 1);
--	b_VinCavePawns = true;
--end
--
--function VinCaveKnight()
--	pup_play_show ("vin_w1_un_reports_cave_knight");
--	SleepUntil([| volume_test_players(VOLUMES.vin_w1_un_reports_cave_knight_tv) ], 1);
--	b_VinCaveKnight = true;
--end

function f_ur_upper_mines_airlock()
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_airlock_begin) ], 1);
	device_set_position(OBJECTS.quarry_door_airlock_enter, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.quarry_door_airlock_enter, true);
	CreateThread(audio_airlock_enter_door_close);
	SleepUntil ([|device_get_position (OBJECTS.quarry_door_airlock_enter) == 0], 1);
	sleep_s(1);
	f_volume_teleport_all_not_inside( VOLUMES.tv_ur_airlock_teleport, FLAGS.flag_ur_airlock );
	ai_erase(AI.sq_ur_mid_level_marines);
	ai_erase(AI.miner_pinned_by_snipers);
	device_set_power(OBJECTS.quarry_door_airlock_enter, 0 );
	SleepUntil([| volume_test_players(VOLUMES.tv_mine_open_airlock_2) ], 1);	
	CreateThread(f_ur_officer_big_guns_check);
	device_set_power(OBJECTS.quarry_door_airlock_exit, 1);
	device_set_position(OBJECTS.quarry_door_airlock_exit, 0.65);
	CreateThread(audio_airlock_exit_door);
	SleepUntil([|device_get_position (OBJECTS.quarry_door_airlock_exit) >= .60], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.quarry_door_airlock_exit, false);
	sleep_s(2);
	game_save_no_timeout();
	CreateThread(f_ur_uppermine_sniper_perch);
	CreateThread(f_ur_close_airlock);
end

function f_ur_close_airlock():void
	SleepUntil([|volume_test_players(VOLUMES.tv_mine_airlock_shutdown) ], 1);
	zone_set_trigger_volume_enable("zone_set:zs020_cave", false);
end

function f_ur_officer_big_guns_check():void
	n_vin_soldier_equip_lmg = composer_play_show("vin_w1_un_reports_soldier_equip_lmg");
	sleep_s(1.5);
	CreateThread(f_ur_mines_turret_check);
	sleep_s(1.5);
	gb_officer_big_guns_ready = true;
	SleepUntil([| gb_officer_big_guns_over == true  ], 1);
	ai_set_objective(AI.cave_soldier, "obj_soldier_lmg");
end

function f_ur_mines_turret_check():void  --easter egg
	if game_difficulty_get_real() == DIFFICULTY.legendary then
		sleep_s(6);
		if ai_living_count(AI.cave_soldier) <= 0 then
			SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
			object_create("veh_ur_mines_turret");
		end
	end
end

function f_ur_uppermine_sniper_perch():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ur_mine_sniper_perch) ], 1);
	--CreateThread( SlipSpaceSpawn, AI.sq_mine_fr_sniper_perch );
	game_save_no_timeout();
	CreateThread(f_ur_um_sniper_perch_sending);
end

function f_ur_um_sniper_perch_sending():void
	SleepUntil([|volume_test_players(VOLUMES.tv_ur_um_sniper_perch) ], 1);
	CreateThread(f_ur_musketeer_sniper_perch);
end

function f_ur_musketeer_sniper_perch():void
	local b_tube_buddy_set:boolean = false;
	local b_tube_mid_set:boolean = false;
          
	for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do                                      
		if  not b_tube_buddy_set then
			b_tube_buddy_set = true;
			--MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_mid, 3);
		elseif not b_tube_mid_set then
			b_tube_mid_set = true;
			MusketeerDestSetPoint(obj, FLAGS.cf_ur_um_sniper_perch_goto_01, 3);
		else
			MusketeerDestSetPoint(obj, FLAGS.cf_ur_um_sniper_perch_goto_02, 1);
		end                                          
	end    
	CreateThread(f_ur_um_sniper_perch_sending_ending);    
end

function f_ur_um_sniper_perch_sending_ending():void
	SleepUntil([| not volume_test_players(VOLUMES.tv_ur_um_sniper_perch) ], 1);
	MusketeerUtil_SetDestination_Clear_All();
	CreateThread(f_ur_um_sniper_perch_sending);
end


function f_ur_upper_mines_spawn_manager()
	CreateThread(f_ur_upper_mines_spawn_anthill);
	CreateThread(f_ur_upper_mines_rear_guard_spawn);
	ai_place( AI.sg_mine_soldier_front );
	SleepUntil([| volume_test_players(VOLUMES.tv_mine_approach) ], 1);
	SleepUntil ([| ai_spawn_count( AI.sg_mine_soldier_front) > 0 and ( ai_living_count ( AI.sg_mine_soldier_front ) <= 3 or n_mine_objcon >= 30 ) ], 1);	
	CreateThread( SlipSpaceSpawn, AI.sg_mine_front_slipspacers );
end

function f_ur_upper_mines_rear_guard_spawn()
	SleepUntil([| volume_test_players(VOLUMES.tv_mt_mine_spawn_03) ], 1);
	print("spawn rear_guard");

	CreateThread(SlipSpaceSpawn, AI.sg_mine_enemy_rear_guard);
	CreateThread(nar_upper_wave_3);
	SleepUntil([| n_mine_objcon >= 100 or  ( ai_spawn_count(AI.sg_mine_enemy_rear_guard) > 0 and ai_living_count(AI.sg_mine_enemy_rear_guard) <= 1) ], 1);
	CreateThread(SlipSpaceSpawn, AI.sq_mine_rg_knight_01);
	CreateThread(AudioCheckEnemyCount, AI.sq_mine_rg_knight_01, 1, audio_unconfirmedreports_thread_up_waves_outro);
end

function f_ur_upper_mines_spawn_anthill()
	SleepUntil([| volume_test_players(VOLUMES.tv_mt_mine_spawn_02) ], 1);
	MusketeerUtil_SetDestinationWhenDrivingPlayer (OBJECTS.cr_ur_um_drive_crate, POINTS.ps_ur_um_mongoose);
		game_save();
		garbage_collect_now();
		CreateThread(f_ur_mine_mid_pawn_01);
		CreateThread(f_ur_mine_mid_pawn_02);
		--CreateThread(f_ur_mine_mid_pawn_03);
		CreateThread(f_ur_mine_mid_pawn_04);
		CreateThread(f_ur_mine_mid_pawn_05);
		CreateThread(f_ur_mine_mid_pawn_06);
		--CreateThread(f_ur_mine_mid_pawn_07);
		CreateThread(f_ur_mine_mid_pawn_08);
		CreateThread(f_ur_mine_mid_soldier_01);
		CreateThread(f_ur_mine_mid_soldier_02);
		CreateThread(nar_upper_wave_2);
		
	SleepUntil ([| ai_spawn_count( AI.sg_mine_anthill) > 0 and  ai_living_count ( AI.sg_mine_anthill ) <= 9  ], 1);	
		print("anthill fillin ");
		garbage_collect_now();
		
		if coop_players_3() then
			CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_07 );
--			SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_07 ) > 0 ], 30);
--			for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_07) ) do
--				RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--			end	
		end
		
		CreateThread(f_ur_mine_mid_pawn_08);
		CreateThread(f_ur_mine_mid_pawn_09);
		CreateThread(f_ur_mine_mid_pawn_10);
		CreateThread(f_ur_mine_mid_soldier_03);
		CreateThread(f_ur_mine_mid_soldier_04);

	SleepUntil ([| ai_spawn_count( AI.sq_mine_mid_pawn_08) > 0 and  ai_living_count ( AI.sg_mine_anthill ) <= 11  ], 1);	
		garbage_collect_now();
		CreateThread(audio_unconfirmedreports_thread_up_waves_start);
		CreateThread(f_ur_mine_mid_pawn_01);
		CreateThread(f_ur_mine_mid_pawn_02);
		CreateThread(f_ur_mine_mid_pawn_03);
		CreateThread(f_ur_mine_mid_pawn_07);
		
	if coop_players_3() then
		CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_04 );
--		SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_04 ) > 0 ], 30);
--		for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_04) ) do
--			RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--		end	
	end
end

function f_upper_mine_checkpoints()
	SleepUntil([| volume_test_players(VOLUMES.tv_mt_mine_mid_01) ], 1);
		print( "CHECKPOINT!" );
		game_save_no_timeout();
		
	SleepUntil([| volume_test_players(VOLUMES.tv_mt_mine_knight_fallback) ], 1);
		print( "CHECKPOINT!" );
		game_save_no_timeout();
end

function dormant.f_uncon_mine_objcon_controller()
	print("mine objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_10 ) or n_mine_objcon >= 10 ], 1);
	if n_mine_objcon <= 10 then
		n_mine_objcon = 10;
		print("n_mine_objcon = 10 ");
	end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_20 ) or n_mine_objcon >= 20 ], 1);
		if n_mine_objcon <= 20 then
			n_mine_objcon = 20;
			print("n_mine_objcon = 20 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_30 ) or n_mine_objcon >= 30 ], 1);
		if n_mine_objcon <= 30 then
			n_mine_objcon = 30;
			print("n_mine_objcon = 30 ");
		end		

	game_save();
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_40 ) or n_mine_objcon >= 40 ], 1);
		if n_mine_objcon <= 40 then
			n_mine_objcon = 40;
			print("n_mine_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_50 ) or n_mine_objcon >= 50 ], 1);
	game_save_no_timeout();
	
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_03, true);
	
	if n_mine_objcon <= 50 then
		n_mine_objcon = 50;
		print("n_mine_objcon = 50 ");
	end
	game_save();
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_60 ) or n_mine_objcon >= 60 ], 1);
	game_save_no_timeout();
	if n_mine_objcon <= 60 then
		n_mine_objcon = 60;
		print("n_mine_objcon = 60 ");
	end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_70 ) or n_mine_objcon >= 70 ], 1);
	if n_mine_objcon <= 70 then
		n_mine_objcon = 70;
		print("n_mine_objcon = 70 ");
	end
	game_save();
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_80 ) or n_mine_objcon >= 80 ], 1);
	if n_mine_objcon <= 80 then
		n_mine_objcon = 80;
		print("n_mine_objcon = 80 ");
	end		
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_90 ) or n_mine_objcon >= 90 ], 1);
	game_save_no_timeout();
	if n_mine_objcon <= 90 then
		n_mine_objcon = 90;
		print("n_mine_objcon = 90 ");
	end
	game_save();
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_100 ) or n_mine_objcon >= 100 ], 1);
	if n_mine_objcon <= 100 then
		n_mine_objcon = 100;
		print("n_mine_objcon = 100 ");
	end
	garbage_collect_now();
	SleepUntil ([| volume_test_players ( VOLUMES.tv_mine_objcon_110 ) or n_mine_objcon >= 110 ], 1);
	if n_mine_objcon <= 110 then
		n_mine_objcon = 110;
		print("n_mine_objcon = 110 ");
	end	
	CreateThread(audio_unconfirmedreports_thread_up_reveal_start);
	device_set_power(OBJECTS.quarry_door_airlock_exit, 0);
	garbage_collect_now();
end

--ACTIVATE MINE TURRETS
function f_mine_turret_01()
	--repeat
		SleepUntil([| device_get_position(OBJECTS.dc_mine_turret_switch_01) == 1 ], 1);
		device_set_power( OBJECTS.dc_mine_turret_switch_01, 0 );
		ObjectSetSpartanTrackingEnabled(OBJECTS.dc_mine_turret_switch_01, false); 
		ai_place( AI.sq_mine_turret_01);	
		CreateThread(audio_activate_turret_a);
		--sleep_s( 45 );
		--ai_erase( AI.sq_mine_turret_01);
		--sleep_s( 60 );
		--device_set_position( OBJECTS.dc_mine_turret_switch_01, 0 );
		--device_set_power( OBJECTS.dc_mine_turret_switch_01, 1 );
		--ObjectSetSpartanTrackingEnabled(OBJECTS.dc_mine_turret_switch_01, true);
	--until gb_mines_complete;
	
	StopEffectGroup(EFFECTS.fx_panel_lens_flare_01);
	StopEffectGroup(EFFECTS.fx_panel_lens_flare_02);
end

function f_mine_turret_02()
	--repeat
		SleepUntil([| device_get_position(OBJECTS.dc_mine_turret_switch_02) == 1 ], 1);
			device_set_power( OBJECTS.dc_mine_turret_switch_02, 0 );
			ObjectSetSpartanTrackingEnabled(OBJECTS.dc_mine_turret_switch_02, false);
			--composer_play_show("comp_ur_button_press");		
			ai_place( AI.sq_mine_turret_02 );
			ai_place( AI.sq_mine_turret_03 );
			ai_place( AI.sq_mine_turret_04 );
			CreateThread(audio_activate_turret_b);
			
			--sleep_s( 60 );
			
			--ai_erase( AI.sq_mine_turret_02 );
			--ai_erase( AI.sq_mine_turret_03 );
			--ai_erase( AI.sq_mine_turret_04 );
			
			--sleep_s( 60 );
			
			--device_set_position( OBJECTS.dc_mine_turret_switch_02, 0 );
			--device_set_power( OBJECTS.dc_mine_turret_switch_02, 1 );
			--ObjectSetSpartanTrackingEnabled(OBJECTS.dc_mine_turret_switch_02, true);
	--until gb_mines_complete;
	
	StopEffectGroup(EFFECTS.fx_panel_lens_flare_03);
	StopEffectGroup(EFFECTS.fx_panel_lens_flare_04);
end

function cs_min_turret_01()
	ai_vehicle_enter_immediate( ai_current_actor, OBJECTS.veh_mine_turret_01); 
	unit_open(OBJECTS.veh_mine_turret_01);
end

function cs_min_turret_02()
	ai_vehicle_enter_immediate( ai_current_actor, OBJECTS.veh_mine_turret_02); 
	unit_open(OBJECTS.veh_mine_turret_02);
end

function cs_min_turret_03()
	ai_vehicle_enter_immediate( ai_current_actor, OBJECTS.veh_mine_turret_03); 
	unit_open(OBJECTS.veh_mine_turret_03);
end

function cs_min_turret_04()
	ai_vehicle_enter_immediate( ai_current_actor, OBJECTS.veh_mine_turret_04); 
	unit_open(OBJECTS.veh_mine_turret_04);
end

function f_mine_cleanup()
	ai_erase( AI.sg_mine_enemy_all);
end

function debug_mine_crates()
	--object_create_folder("crs_mine");
end

function f_ur_mine_mid_pawn_01():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_01 );
	--sleep_s(3);
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_01 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_01);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_01) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_02():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_02 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_02 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_02);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_02) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_03():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_03 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_03 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_03);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_03) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_04():void
	sleep_s(random_range(0,2));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_04 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_04 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_04);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_04) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_05():void
	sleep_s(random_range(0,2));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_05 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_05 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_05);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_05) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_06():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_06 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_06 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_06);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_06) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_07():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_07 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_07 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_07);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_07) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end
end

function f_ur_mine_mid_pawn_08():void
	sleep_s(random_range(1,4));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_08 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_08 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_08);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_08) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
end

function f_ur_mine_mid_pawn_09():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_09 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_09 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_09);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_09) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
end

function f_ur_mine_mid_pawn_10():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_pawn_10 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_pawn_10 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_pawn_10);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_pawn_10) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
end

function f_ur_mine_mid_soldier_01():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_soldier_01 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_soldier_01 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_soldier_01);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_soldier_01) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
end

function f_ur_mine_mid_soldier_02():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_soldier_02 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_soldier_02 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_soldier_02);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_soldier_02) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
	if game_coop_player_count() >= 3 then
		CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_soldier_gen );
--		SleepUntil([| ai_living_count( AI.sq_mine_mid_soldier_gen ) > 0 ], 30);
--		--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_soldier_02);
--		for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_soldier_gen) ) do
--			RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--		end	
	end
end

function f_ur_mine_mid_soldier_03():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_soldier_03 );
--	SleepUntil([| ai_living_count( AI.sq_mine_mid_soldier_03 ) > 0 ], 30);
--	--RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_soldier_03);
--	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_soldier_03) ) do
--		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
--	end	
end

function f_ur_mine_mid_soldier_04():void
	sleep_s(random_range(0,3));
	CreateThread( SlipSpaceSpawn, AI.sq_mine_mid_soldier_04 );
	SleepUntil([| ai_living_count( AI.sq_mine_mid_soldier_04 ) > 0 ], 30);
	RegisterAIDeathEvent(UR_MongooseDeath, AI.sq_mine_mid_soldier_04);
	for i,ur_dead_unit in ipairs( ai_actors(AI.sq_mine_mid_soldier_04) ) do
		RegisterDeathEvent(UR_MongooseDeath, ur_dead_unit);
	end	
end

function f_ur_breadcrumbs_upper_mine():void
	object_create("s_ur_breadcrumb_07");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_07) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_07);
	sleep_s(1);
	object_create("s_ur_breadcrumb_08");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_08) ], 10);
	game_save_no_timeout();
	object_destroy(OBJECTS.s_ur_breadcrumb_08);
	sleep_s(1);
	object_create("s_ur_breadcrumb_09");
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_01, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_02, false);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_cave_03, false);
end

--### DC Turret Controls ###############################
global gb_ur_comp_turret:number = -1;

function f_activator_get_turret_01( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
		gb_ur_comp_turret = composer_play_show("comp_ur_button_press_01", { ics_player = this_activator});
end

function f_activator_get_turret_02( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;
		gb_ur_comp_turret = composer_play_show("comp_ur_button_press_02", { ics_player = this_activator});
end
--### DC Turret Controls End ###############################