--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 Sentinels*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



--  ****************************************************************************************** --
--  ********************  			      GOAL 1 - MUSEUM &              ************************* --
--  ********************  			      GOAL 2 - GARAGE                ************************* --
--  ********************     LOCATED IN W3_IW_SENTINELS_HUB.LUA      ************************* --
--  ****************************************************************************************** --


--  ****************************************************************************************** --
--  ********************  			      GOAL 3 - TRENCH &                *********************** --
--  ********************  			      GOAL 4 - GATE                    *********************** --
--  ********************  LOCATED IN W3_IW_SENTINELS_ROAD_LILBOWL.LUA  *********************** --
--  ****************************************************************************************** --


--  ****************************************************************************************** --
--  ********************  			      GOAL 5 - TOWERS &              ************************* --
--  ********************  			      GOAL 6 - COLISEUM              ************************* --
--  ********************   LOCATED IN W3_IW_SENTINELS_BIGBOWL.LUA    ************************* --
--  ****************************************************************************************** --


--  ****************************************************************************************** --
--  ********************  			      GOAL 7 - UNDERGROUND &             ********************* --
--  ********************  			      GOAL 8 - FROZEN &                  ********************* --
--  ********************  			      GOAL 9 - ENDGAME                   ********************* --
--  ********************   LOCATED IN W3_IW_SENTINELS_UNDERGROUND.LUA    ********************* --
--  ****************************************************************************************** --


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  **************************************************************************************** --
--  ********************  			      GOAL 5 - TOWERS                *********************** --
--  **************************************************************************************** --



















	
		



--  **************************************************************************************** --
--  ********************  			      GOAL 6 - COLISEUM              *********************** --
--  **************************************************************************************** --

missionSentinels.goal_coliseum = 
	{
	gotoVolume = VOLUMES.tv_goal_underground,
	next={"goal_underground"},
	zoneSet = ZONE_SETS.zn_factory,
	}



global wave_layers:number = 3;
global objcon_col:number = 0;
global col_wave:number = 0;
global monitorShow:number = -1;
global b_col_fight_over:boolean = false;
global b_col_release_b:boolean = false;
global b_col_release_a:boolean = false;
global b_col_close_door:boolean = false;
global b_col_both_constructors_released:boolean = false;
global b_col_poweroverwhelping_unlease:boolean = false;
global b_col_kill_overwhelping:boolean = false;
global b_end_restart_fx:boolean = false;
global b_sent_omelet_king_unlock:boolean = false;
global b_col_knight_moment_elevator_block:boolean = false;
global b_col_whelping_close_spawned:boolean = false;
global b_col_elevator_ready_and_waiting:boolean = false;


function missionSentinels.goal_coliseum.Start() :void		

	f_bowl_kill_all_tethers();
	zone_set_trigger_volume_enable( "begin_zone_set:zn_coliseum", false );
	zone_set_trigger_volume_enable( "zone_set:zn_coliseum", false );
	
	Sleep(3);
	CreateThread( f_col_bump_and_switch );
	Wake( dormant.f_endgame_fx_control );
	f_col_dynamic_hints( false );
	b_col_close_door = true;
	b_museShowStop = true;
	print ("goal_coliseum starting...");
	garbage_collect_now();
	Sleep(15);
	game_save_no_timeout();
	print ("attempting to save...");
	--CreateThread( f_col_defend_blip )
	
		--	NARRATIVE CALL
	CreateThread(sentinels_coliseum_wake);

	f_bigbowl_cleanup();
	object_create_folder("mod_coliseum");



		Sleep(2);
		object_create_folder("crs_col_racks"); -- for object count management
		Sleep(2);
		object_create_folder("crs_col_cannons"); -- for object count management	

		object_create_folder("mod_col_weapon_cache"); -- for object count management	
	--	object_create("sn_col_cache_01");
		--object_create("sn_col_cache_02");

		--

		local l_timer:number = timer_stamp( 40 );
	SleepUntil([|b_coliseum_hostiles_incoming or timer_expired( l_timer ) ], 1);
	--	monitorShow = composer_play_show ("vin_w3_monitor_tower_interact");
		f_col_start_tower_show();	
		object_destroy( OBJECTS.bowl_objective_go_in_coliseum );
		--object_destroy(OBJECTS.sn_col_wait);
		ai_allegiance( TEAM.forerunner, TEAM.neutral );
		ai_allegiance( TEAM.neutral, TEAM.forerunner );
		
		Sleep(5);
		ObjectiveShow (TITLES.obj_sen_5);
		n_endgame_state = 2;		
		objcon_col = 0;
		print("start wave 1");
		CreateThread( col_wave_1 );
		CreateThread( audio_sentinels_thread_up_coliseum_start );
	
		sleep_s(6);
		
	SleepUntil([| wave_layers <= 2], 1);
		print("wave_layers 2");
		sleep_s (6);
		--f_col_weapon_cache_drop_2();
		l_timer = timer_stamp( 20 );
		SleepUntil([| timer_expired( l_timer ) or  b_col_started_scan_obj ], 1);
			CreateThread( f_col_contructor_objective );  --called from narrative script this is the failsafe
		SleepUntil([| b_col_both_constructors_released  ], 1);
		
		sleep_s (10);
		objcon_col = 0;
		print("start wave 2");
		CreateThread(col_wave_2);
	
	SleepUntil([| wave_layers <= 1], 1);
		print("wave_layers 1");
			

			sleep_s (15);
		objcon_col = 0;
		print("start wave 3");
		CreateThread(col_wave_3);
		
		sleep_s (1);
	SleepUntil([| wave_layers <= 0], 1);
		print("wave_layers 0");
		
		b_col_fight_over = true;
		game_save_no_timeout();	
		sleep_s(3);
		--CreateThread(audio_sentinels_thread_up_coliseum_end);
		CreateThread( f_col_end_elevator );
		
		RunClientScript ("sen_base_shake");	

	
end


function f_col_start_tower_show()

	if not composer_show_is_playing(monitorShow) then
		monitorShow = composer_play_show ("vin_w3_monitor_tower_interact");
	end

end

function f_col_teleport_sassy()
	local n_sassy_distance:number = -1;
	
		--print("Sassy distance to end point", n_sassy_distance );
		if f_sent_get_sassy() and not volume_test_objects( VOLUMES.tv_col_int, ai_get_object( f_sent_get_sassy() ) ) then
			object_teleport(  ai_get_object( f_sent_get_sassy() ), POINTS.ps_coliseum.p02);
			print("sassy is missing...teleporting");
		end
end

function f_col_bump_and_switch()
	
	sleep_s( 4);
	f_volume_teleport_all_not_inside (VOLUMES.tv_col_int, FLAGS.fl_col_bump_forward);
	SleepUntil([| b_col_roof_closed ] ,1 );
		object_create( "cr_coliseum_back_door_blocker");
		f_volume_teleport_all_not_inside (VOLUMES.tv_col_int, FLAGS.fl_col_bump_forward);
		device_set_position (OBJECTS.dm_col_roof, 0);
		CreateThread( f_col_set_factory_zoneset) ;
		ai_disable_jump_hint(HINTS.jp_col_bowl_connection );
		CreateThread( f_col_teleport_sassy );
	--CreateThread( f_col_recreate_gap_blocker );
	
	Sleep(5);
	game_save_no_timeout();
end

function missionSentinels.goal_coliseum.End() :void		
	object_destroy_folder("mod_col_weapon_cache");
end

global b_col_roof_closed:boolean = false;
function f_col_recreate_gap_blocker()
	--SleepUntil([| device_get_position( OBJECTS.dm_col_roof ) == 0 ] , 1 );
		print("recreate gap filler");
		object_create_anew( "sn_coliseum_gap_blocker" );
		b_col_roof_closed = true;
end

function test_col_end_elevator_sequence()
	monitorShow = composer_play_show ("vin_w3_monitor_tower_interact");
	wave_layers = 0;
	b_col_fight_over = true;
	CreateThread( f_col_end_elevator );
end




function f_col_defend_blip()
	object_create("sn_col_wait");
end

global b_col_lower_elevator_position:boolean = false;

function f_col_end_elevator()	
			local l_timer:number = -1;
			object_create("coliseum_objective_escape");
			game_save_cancel();
			CreateThread( f_col_kill_below_elevator_all );
			--game_save_no_timeout();
			sleep_s(15);
			CreateThread( f_col_remove_from_vehicles_and_delete);
			sleep_s(2);

			
		
			
			f_col_dynamic_hints( true );
			--print("position set");
			CreateThread(f_col_poweroverwhelping);
			CreateThread( MusketeerUtil_SetMusketeerGoal, FLAGS.fl_coliseum_elevator , 0.3 );
			ObjectOverrideNavMeshCutting( OBJECTS.dm_col_elevator, false );
			Sleep(1);
			b_col_elevator_ready_and_waiting = true;
			ai_set_objective( AI.musketeers, "obj_musk_elevator" );
			game_save_cancel();
		SleepUntil([| volume_test_players(VOLUMES.tv_col_lift) ], 1);
			b_col_elevator_ready_and_waiting = true;	
			CreateThread(audio_sentinels_thread_up_coliseum_fadeout);
			game_save_cancel();
			print("lower lift");
			CreateThread( f_col_remove_from_vehicles_and_delete);
			--sleep_s(1);
			l_timer = timer_stamp( 4 );
		SleepUntil([|volume_test_players_all(VOLUMES.tv_col_lift) or timer_expired(l_timer)], 1);
			b_col_elevator_ready_and_waiting = true;	
			game_save_cancel();
			print("proceed goodbye");			
			CreateThread( f_col_poweroverwhelping_close );
			
			
			sleep_s( 3.0 );
			b_col_poweroverwhelping_unlease = true;
			for _,spartan in ipairs (spartans()) do  
				object_cannot_take_damage(spartan);
			end			
			CreateThread( f_col_goodbye_rumble);			
			CreateThread (col_elevator_domeattach);
			f_col_dynamic_hints( false );
			--sleep_s(1);
			CreateThread( f_coliseum_clear_elevator );
			CreateThread( f_col_remove_from_vehicles_and_delete);
			f_volume_teleport_all_not_inside(VOLUMES.tv_col_lift ,FLAGS.fl_coliseum_elevator);
		
			--	NARRATIVE CALL
			if g_currentMission then   
				CreateMissionThread(sentinels_factory_wake);
			end
			sleep_s( 2.5 );
			MusketeerUtil_SetDestination_Clear_All();
			f_volume_teleport_all_not_inside(VOLUMES.tv_col_lift ,FLAGS.fl_coliseum_elevator);
			--rumble_shake_medium(0.75);
			b_col_lower_elevator_position = true;
			CreateThread(endMuskSetPosition, t_endMusk0);
			--b_col_lower_elevator_position = true;

			--CreateThread(audio_sentinels_thread_up_coliseum_fadeout);
			
			object_destroy( OBJECTS.coliseum_objective_escape );
			
			-- ending previous show
			composer_stop_show(vin_endgame); 
			sleep_s( 10 );


			ai_erase(AI.sg_col_contructor);
			ai_kill(AI.sg_col);
			b_end_restart_fx = true;
			sleep_s( 10);
			

			b_col_kill_overwhelping = true;
			Sleep (5);
			ai_kill(AI.sg_col_all);
			ai_set_objective( AI.musketeers, "" );
			for _,spartan in ipairs (spartans()) do  
				object_can_take_damage(spartan);
			end


end


function f_col_kill_below_elevator_all()
		sleep_s(3);
		for _,spartan in ipairs (spartans()) do
			CreateThread(f_col_kill_below_elevator, spartan);
		end

end

function f_col_kill_below_elevator( o_spartan:object)

	repeat
		SleepUntil([|volume_test_objects(VOLUMES.tv_col_elevator_kill_safety,o_spartan ) or b_col_elevator_ready_and_waiting ], 1);
			if not b_col_elevator_ready_and_waiting then
				--print("killing player in bad location ",o_spartan );
				unit_kill( o_spartan);
			end
			Sleep(10);
	until b_col_elevator_ready_and_waiting;

end

function f_col_destroy_mantis()

	
			f_col_block_vehicle_entering(OBJECTS.v_mantis_deff);
			f_col_block_vehicle_entering(OBJECTS.v_mantis_dred);
						
			sleep_s(4);
			if object_valid("v_mantis_deff") then
				object_damage_damage_section( OBJECTS.v_mantis_deff, "body", 20000 );
			end
			
			if object_valid("v_mantis_dred") then
				object_damage_damage_section( OBJECTS.v_mantis_dred, "body", 20000 );					
			end	
			

end


function blah_veh()
	f_col_block_vehicle_entering( OBJECTS.v_mantis_deff );

end

function f_col_block_vehicle_entering( veh:object)

		unit_set_enterable_by_player( veh, false );	
		if veh ~= OBJECTS.v_mantis_dred or veh ~= OBJECTS.v_mantis_deff then
			--ai_vehicle_reserve( veh, true );
		end

end

function f_col_grab_all_vehicles()

	garbage_collect_now();
	Sleep(2);
 local col_objs:object_list = volume_return_objects( VOLUMES.tv_col_all) ;
 local vehicle_list:object_list =	metalabel_filter_objectlist( "vehicle", col_objs );

	for i, v in ipairs (col_objs) do
		--print(v );

	end
	
	for i, v in ipairs (vehicle_list) do
		print(v );
		f_col_block_vehicle_entering( v );
		Sleep(1);
		--object_destroy( v );
	end


	object_destroy_list(vehicle_list );
end

function f_col_remove_from_vehicles_and_delete()
		local vehicle = nil;
				
		for _,v in ipairs(spartans()) do
			if(v ~= nil) then
				print(v);
				
				if IsPlayer(v) then
					
						vehicle = unit_get_vehicle( player_get_unit(v) );
					if vehicle then
						f_col_block_vehicle_entering(vehicle);
					end
					print("player Exiting vehicles", vehicle);
					unit_exit_vehicle(player_get_unit(v), 0);
				else
					MusketeerClearMountOrder( v );
					vehicle = unit_get_vehicle( v );
					if vehicle then
						f_col_block_vehicle_entering(vehicle);
					end
					print("musketeer Exiting vehicles " , vehicle);
					---unit_exit_vehicle(v), 0);
					
				end
			end
		end
	

		CreateThread ( f_col_destroy_mantis );
		
		-- Gotta wait to get out of those vehicles!
		for _,v in ipairs(spartans()) do
			if(v ~= nil) then
				if IsPlayer(v) then
					--print("players Waiting til vehicles exited");
					vehicle = unit_get_vehicle( v );
			--		print("waiting player exit");
					SleepUntil([| unit_in_vehicle(player_get_unit(v)) == false ], 1);
						--	print("player exit done");
				else
						vehicle = unit_get_vehicle( v );
				--		print("musketeers Waiting til vehicles exited ", v);
						
				--		print("musketeers exit done");
							
				end

								
					
				end 
			end  
		
		sleep_s(1);
		f_col_grab_all_vehicles();


end

function f_col_goodbye_rumble()

	CreateThread( rumble_shake_small);
	sleep_s( 3 );
	CreateThread( rumble_shake_small);
	sleep_s( 2.5 );
	CreateThread( rumble_shake_medium);

	sleep_s( 2.5 );
	CreateThread( rumble_shake_medium);
	sleep_s( 2 );	
	CreateThread( rumble_shake_medium);

end

function col_elevator_domeattach()

	object_create ("col_elevator_dome");
	objects_physically_attach( OBJECTS.dm_col_elevator, "dome_attach", OBJECTS.col_elevator_dome, "" );
	b_underground_dome_attach = true;
		
end


function col_elevator_domedetach()
		print("stuff");
	if object_index_valid(OBJECTS.dm_col_elevator) and object_index_valid(OBJECTS.col_elevator_dome) then
		objects_detach( OBJECTS.dm_col_elevator, OBJECTS.col_elevator_dome);
		object_destroy (OBJECTS.col_elevator_dome);
	end
end

global b_col_wave_1_begin:boolean = false;

function col_wave_1()
	local l_timer:number = -1;
	game_save();
	col_wave = 1;
	
	f_col_wave_1_part_1();

	
	sleep_s(5);
	b_col_wave_1_begin = true;
	SleepUntil([| ai_living_count(AI.sg_col) <= 7], 1);
		f_coliseum_save();
		sleep_s(2);
		f_col_wave_1_part_2();
	--SlipSpaceSpawn(AI.sq_col_w1_sol04);
	sleep_s(6);
	SleepUntil([| ai_living_count(AI.sg_col) <= 3 and ai_living_count(AI.sg_col_officers) <= 1], 1);		--	TO CHRIS: Can we change that to <= 2 ?  	--Guillaume
		l_timer = timer_stamp( 30 );
	SleepUntil([| ( ai_living_count(AI.sg_col) <= 1  and ai_living_count(AI.sg_col_officers) <= 0 ) or timer_expired( l_timer )], 1);	
		f_coliseum_save();
	
	--	NARRATIVE CALL
	b_coliseum_wave_1_part_3 = true;

	sleep_s(8);

	f_col_wave_1_part_3();
	--SlipSpaceSpawn(AI.sq_col_w1_sol05);
	sleep_s(5);

	SleepUntil([| ai_living_count(AI.sg_col) <= 8], 1);
		f_coliseum_save();
	
		f_col_wave_1_part_4();
		sleep_s(5);

	SleepUntil([| ai_living_count(AI.sg_col) <= 2  ], 1);		
		l_timer = timer_stamp( 20 );
	SleepUntil([| ai_living_count(AI.sg_col) <= 1  or timer_expired( l_timer )], 1);		--	TO CHRIS: Can we change that to <= 1 ?  with 2 soldier commander left, it's still quite intense		--Guillaume	
		game_save();
	
	b_coliseum_end_of_wave_1 = true;	--	TO CHRIS: I've added a call for the VO here			--Guillaume

	sleep_s(7);							--	TO CHRIS: I've added a pause to hear better the VO			--Guillaume

	objcon_col = 10;
	wave_layers = wave_layers - 1;
	
end

function f_col_wave_1_part_1()
	print("part 1");
	SlipSpaceSpawn (AI.sq_col_w1_sol01);
	SlipSpaceSpawn(AI.sq_col_w1_sol02);
	SlipSpaceSpawn(AI.sq_col_w1_officer01);
	if coop_players_2() then
		SlipSpaceSpawn(AI.sq_col_w1_officer02);	
	end
	
end

function f_col_wave_1_part_2()
	print("part 2");
	SlipSpaceSpawn(AI.sq_col_w1_sol03);
	
	
	if coop_players_2() then
		SlipSpaceSpawn (AI.sq_col_w1_sol04);
		SlipSpaceSpawn(AI.sq_col_w1_sol05);	
	end

end

function f_col_wave_1_part_3()
	print("part 3");
	SlipSpaceSpawn(AI.sq_col_w1_officer03);	
	if coop_players_3() then
		SlipSpaceSpawn(AI.sq_col_w1_officer04);	
	end	
end

function f_col_wave_1_part_4()
		print("part 4");
	if coop_players_3() then
		SlipSpaceSpawn(AI.sq_col_w1_sol06);
		SlipSpaceSpawn(AI.sq_col_w1_officer05);	
	end
	SlipSpaceSpawn(AI.sq_col_w1_officer06);	
end

function col_wave_2()

		local l_timer:number = -1;
	col_wave = 2;
	game_save();
	
	f_col_wave_2_part_1();
	sleep_s(7);
	
	SleepUntil([| ai_living_count(AI.sg_col) <= 4], 1);
		f_coliseum_save();

		sleep_s(1);
		l_timer = timer_stamp( 60 );
		CreateThread(Sentinels__coliseum__Defend_end_wave_2);				--	Call the Slipspace of the Guardian when the player is not engage in close combat	--Guillaume
		SleepUntil([| b_coliseum_last_guardian_slipspacing or timer_expired(l_timer) ], 1);			--	TO CHRIS: When critical VO has played	--Guillaume

		--sleep_s(5);

		f_col_wave_2_part_2();
		sleep_s(7);
	SleepUntil([| ai_living_count( AI.sg_col ) <= 2  ], 1);
		
		sleep_s(5);
		f_coliseum_save();
		f_col_wave_2_part_3();
		--	NARRATIVE CALL
		CreateThread(coliseum_enemy_incoming);
		sleep_s(1);
		sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_col) <= 2 and  ai_living_count( AI.sq_col_w2_battlewagon_01) == 0  and  ai_living_count( AI.sq_col_w2_battlewagon_02 ) == 0 ], 1);
	
		b_coliseum_end_of_wave_2 = true;	--	TO CHRIS: I've added a call for Cortana VO here			--Guillaume
		CreateThread(audio_sentinels_thread_up_coliseum_end);
		l_timer = timer_stamp( 60 );
	SleepUntil([| b_coliseum_spawn_enemies_after_cortana  or timer_expired(l_timer)], 1);	--	TO CHRIS: I've added a call for the end of Cortana VO here			--Guillaume
		
		objcon_col = 10;
		game_save();
		wave_layers = wave_layers - 1;	
end


function f_col_wave_2_part_1()
	--12 pawns
	-- 2 watchers
			print("part 1");

	  
	SlipSpaceSpawn (AI.sq_col_w2_pawn01b);  
	SlipSpaceSpawn(AI.sq_col_w2_pawn02b);
	SlipSpaceSpawn(AI.sq_col_w2_pawn03b);				
	Sleep(30);											
	SlipSpaceSpawn (AI.sq_col_w2_pawn01);  
	SlipSpaceSpawn(AI.sq_col_w2_pawn02);
	--SlipSpaceSpawn(AI.sq_col_w2_pawn03);
	SlipSpaceSpawn(AI.sq_col_w2_watcher01);				
	SlipSpaceSpawn(AI.sq_col_w2_watcher01b);			
end

function f_col_wave_2_part_2()
	-- 6 pawns
	-- 2 watchers
	-- 1 snipers
	print("part 2");
	SlipSpaceSpawn(AI.sq_col_w2_pawn04);
	SlipSpaceSpawn (AI.sq_col_w2_watcher02);
	SlipSpaceSpawn(AI.sq_col_w2_pawn06);
	--SlipSpaceSpawn(AI.sq_col_w2_sniper01);	
	if coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then	
		SlipSpaceSpawn(AI.sq_col_w2_sniper02);	
		SlipSpaceSpawn(AI.sq_col_w2_pawn03);
	end
end

function f_col_wave_2_part_3()
	-- 3 pawns

	--2 watchers
	print("part 3");
	SlipSpaceSpawn(AI.sq_col_w2_pawn05);
	--SlipSpaceSpawn(AI.sq_col_w2_sniper03);

	if coop_players_3() then		
		--SlipSpaceSpawn(AI.sq_col_w2_sniper04);
		--SlipSpaceSpawn(AI.sq_col_w2_sniper05);
			SlipSpaceSpawn(AI.sq_col_w2_pawn08);
			SlipSpaceSpawn(AI.sq_col_w2_watcher03);	
	end
	--
	
	SlipSpaceSpawn(AI.sq_col_w2_battlewagon_01);
	SlipSpaceSpawn(AI.sq_col_w2_battlewagon_02);
	if coop_players_4() or game_difficulty_get_real() == DIFFICULTY.legendary then
		print("part 3 legendary or coop");
		SlipSpaceSpawn(AI.sq_col_w2_pawn07);	
		--SlipSpaceSpawn(AI.sq_col_w2_pawn08);		
		--SlipSpaceSpawn(AI.sq_col_w2_sniper06);		
	end	
	
	sleep_s(3);
	ai_place_with_birth(AI.sq_col_w3_watcher_01a);
	ai_place_with_birth(AI.sq_col_w3_watcher_01b);
	--6 pawns
	-- 1 sniper

end




function col_wave_3()
	col_wave = 3;
	game_save();

	f_col_wave_3_part_1();

	local l_timer:number = 0;
	l_timer = timer_stamp( 60 );		
	sleep_s(5);
	print(ai_living_count(AI.sg_col) );
	SleepUntil([| ai_living_count(AI.sg_col) <= 2 or timer_expired(l_timer) ], 1);
		f_coliseum_save();


		f_col_wave_3_part_2();
		sleep_s(5);
	SleepUntil([| ai_living_count(AI.sg_col) <= 1], 1);
		sleep_s(6);
		objcon_col = 10;
		ai_kill(AI.sg_col);
		wave_layers = wave_layers - 1;
	
end


function f_col_wave_3_part_1()
	-- 2 officers
	-- 3 watchers
	-- 2 battlewagons
	print("part 1");
	
	b_coliseum_spawn = true;			--	To know when not to trigger a VO during a enemy spawning			--	Guillaume

	
	SlipSpaceSpawn(AI.sq_col_w3_battlewagon_03);
	
	sleep_s(5);

	ai_place_with_birth(AI.sq_col_w3_watcher_01c);
	b_coliseum_spawn = false;			--	To know when not to trigger a VO during a enemy spawning			--	Guillaume
																					
end

function f_col_wave_3_part_2()
	-- i expect you to die
	print("part 2");

	b_coliseum_spawn = true;			--	To know when not to trigger a VO during a enemy spawning			--	Guillaume


	SlipSpaceSpawn(AI.sq_col_w3_commander_01);
	SlipSpaceSpawn (AI.sq_col_w3_commander_02);
	
	sleep_s( 1 );
	SlipSpaceSpawn(AI.sq_col_w3_commander_04);	
	sleep_s( 1 );
	--	NARRATIVE CALL
		CreateThread(coliseum_enemy_incoming);
	sleep_s( 1 );	
	if coop_players_3()  or game_difficulty_get_real() == DIFFICULTY.legendary then
		SlipSpaceSpawn(AI.sq_col_w3_commander_03);	
	end
	sleep_s( 3);
	if coop_players_4() and game_difficulty_get_real() == DIFFICULTY.legendary then
		
		SlipSpaceSpawn(AI.sq_col_w3_battlewagon_04);	

	end	

	sleep_s(5);
	ai_place_with_birth(AI.sq_col_w3_watcher_02a);
	ai_place_with_birth(AI.sq_col_w3_watcher_02b);
	ai_place_with_birth(AI.sq_col_w3_watcher_03a);
	if coop_players_3()  or game_difficulty_get_real() == DIFFICULTY.legendary then
		ai_place_with_birth(AI.sq_col_w3_watcher_03b);
	end
	b_coliseum_spawn = false;			--	To know when not to trigger a VO during a enemy spawning			--	Guillaume
end



global b_col_started_scan_obj:boolean = false;

function f_col_contructor_objective()

		if not b_col_started_scan_obj then
			b_col_started_scan_obj = true;
			CreateThread(audio_sentinels_thread_up_coliseum_calm);
			
			if  game_difficulty_get_real() ~= DIFFICULTY.legendary then
				CreateThread( TutorialShowAll , "training_ping", 8 );
			end
			 
			device_set_power( OBJECTS.dc_col_objective_a , 1 );
			device_set_power( OBJECTS.dc_col_objective_b , 1 );
			
			CreateThread(audio_coliseum_console_a_start);
			CreateThread(audio_coliseum_console_b_start);
			
			object_create("sn_col_task_a");
			object_create("sn_col_task_b");

			SleepUntil([| b_col_release_a and b_col_release_b ] , 1 );
				b_col_both_constructors_released = true;
			CreateThread(audio_sentinels_thread_up_coliseum_switches);
		end
end

global g_comp_holo_a:number = -1;
global g_comp_holo_b:number = -1;
function f_activator_get_hologram( dc:object, activator:object ) 
	print("hologram activated");
	local pl:player = unit_get_player (activator) or unit_get_player (SPARTANS.chief);
		--	NARRATIVE CALL
		CreateThread(Sentinels__coliseum__auxilliary, pl);

		if dc == OBJECTS.dc_col_objective_a then
			print("obj a");
			g_comp_holo_a = composer_play_show ("collectible", {scanner = pl});
			device_set_power( dc, 0 );
			b_col_release_a = true;	
			object_destroy(OBJECTS.sn_col_task_a);
			CreateThread(fx_col_device_a);
		else
			print("obj b");
			g_comp_holo_b = composer_play_show ("collectible", {scanner = pl});
			device_set_power( dc, 0 );
			b_col_release_b = true;	
			object_destroy(OBJECTS.sn_col_task_b);
			CreateThread(fx_col_device_b);
		end

end

function fx_col_device_a()		
	sleep_s(3.5);
	SleepUntil([| pup_is_playing( g_comp_holo_a ) ], 1);
		CreateEffectGroup(EFFECTS.fx_obj_a);
		CreateEffectGroup(EFFECTS.fx_obj_domrune_a);	
		CreateThread(audio_coliseum_console_a_stop);
end

function fx_col_device_b()	
	sleep_s(3.5);	
	SleepUntil([| pup_is_playing( g_comp_holo_b )], 1);
		CreateEffectGroup(EFFECTS.fx_obj_b);
		CreateEffectGroup(EFFECTS.fx_obj_domrune_b);
		CreateThread(audio_coliseum_console_b_stop);
end

function f_col_fx_obj_a()
	CreateEffectGroup(EFFECTS.fx_obj_a);
	CreateEffectGroup(EFFECTS.fx_obj_b	);
end

function f_col_fx_obj_b()
	CreateEffectGroup(EFFECTS.fx_obj_b);

end


function f_col_set_factory_zoneset()


			
			if current_zone_set_fully_active() ~= ZONE_SETS.zn_factory then
				Sleep( 1 );
					--CreateThread( f_test_streamer );
				prepare_to_switch_to_zone_set( ZONE_SETS.zn_factory );
				sleep_s(7);
				SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
					Sleep(3);
				switch_zone_set( ZONE_SETS.zn_factory );
			end

end
 
function  f_test_streamer()
	repeat
		print("PREPARING TO STREAM! ", PreparingToSwitchZoneSet() );
		Sleep(1);
	until  current_zone_set_fully_active() == ZONE_SETS.zn_factory;
end

function cs_col_const_a()
	--print("susie");
	objects_physically_attach( OBJECTS.dc_col_objective_a, "", ai_get_object(ai_current_actor), "" );

	SleepUntil( [| b_col_release_a ] ,1 );

		Sleep(60);

end

function cs_col_const_b()
	objects_physically_attach( OBJECTS.dc_col_objective_b, "", ai_get_object(ai_current_actor), "" );

	SleepUntil( [| b_col_release_b ] ,1 );

		Sleep(60);

end




function f_col_dynamic_hints( on:boolean )

		if on then
			ai_enable_jump_hint(HINTS.jp_col_dynamic_01 );
--			ai_enable_jump_hint(HINTS.jp_col_dynamic_02 );
			ai_enable_jump_hint(HINTS.jp_col_dynamic_03 );
			--ai_enable_jump_hint(HINTS.jp_col_dynamic_04 );
			
			ai_enable_jump_hint(HINTS.jp_musket_mobile_01 );
			ai_enable_jump_hint(HINTS.jp_musket_mobile_02 );
			ai_enable_jump_hint(HINTS.jp_musket_mobile_03 );
			ai_enable_jump_hint(HINTS.jp_musket_mobile_04 );
			--ai_enable_jump_hint(HINTS.jp_musket_mobile_05 );
			ai_enable_jump_hint(HINTS.jp_musket_mobile_06 );
			ai_enable_jump_hint(HINTS.jp_musket_mobile_07 );
		else
			ai_disable_jump_hint(HINTS.jp_col_dynamic_01 );
--			ai_disable_jump_hint(HINTS.jp_col_dynamic_02 );  
			ai_disable_jump_hint(HINTS.jp_col_dynamic_03 );
			--ai_disable_jump_hint(HINTS.jp_col_dynamic_04 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_01 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_02 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_03 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_04 );
			--ai_disable_jump_hint(HINTS.jp_musket_mobile_05 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_06 );
			ai_disable_jump_hint(HINTS.jp_musket_mobile_07 );
		end

end



function cs_weapon_spawner()
	
	print("cs weapon spawner");
	CreateThread( kill_dummy_ai, ai_current_actor ) ;

end

--- this a a bs goal that is only for debugging and not tied into the real game goals
missionSentinels.goal_factory = 
	{
	gotoVolume = VOLUMES.tv_goal_underground,
	next={"goal_underground"},
	zoneSet = ZONE_SETS.zn_factory,
	}

function f_col_fake_blink_factory()


		GoalBlink(missionSentinels, "goal_factory", FLAGS.fl_coliseum_defend);
		composer_play_show ("vin_w3_monitor_tower_interact");
		b_col_fight_over = true;
		Wake( dormant.f_endgame_fx_control );
		CreateThread( f_col_end_elevator );
		--	NARRATIVE
		b_factory_goal = true;
		
end


 
function f_coliseum_clear_elevator(  )


		
		local obj_list = {};
		local squad_list = ai_actors( AI.sg_col_all );
		
	 	obj_list = ai_get_all_in_trigger_volume ( VOLUMES.tv_col_lift_box );
	 	
	 	for i, doomed in ipairs( squad_list ) do
		 	for _, v in ipairs( obj_list ) do
		 		if v == doomed then
		 			ai_kill( object_get_ai( doomed ) );		 			
		 		end
		 	end
		end
	 
end
 
function debug_col_crates()
	object_create_folder("mod_coliseum");
	object_create_folder("crs_coliseum");
--	object_create_folder("crs_col_cannons");

end
--b_sent_omelet_king_unlock
function f_col_poweroverwhelping()

	local n_ow_wave_count:number = 0;
	local l_timer:number = timer_stamp( 75 );

	SleepUntil([|  timer_expired( l_timer ) ] , 1 );

	ai_allegiance( TEAM.forerunner, TEAM.neutral );
	ai_allegiance( TEAM.neutral, TEAM.forerunner );
	sleep_s( 2 );
	SlipSpaceSpawnGroup(AI.sg_col_power_ow_command);
	b_col_poweroverwhelping_unlease = true;
	b_col_knight_moment_elevator_block = true;
	sleep_s( 8 );

	b_col_poweroverwhelping_unlease = true;

	CreateThread( f_col_poweroverwhelping_close );

	n_ow_wave_count = n_ow_wave_count + 1;
		
	repeat
		SleepUntil([| ai_living_count( AI.sg_col_power_overwhelping ) <= 3 ], 1 );
			if not b_col_kill_overwhelping then
				print("another wave for the masses!");
				SlipSpaceSpawnGroup(AI.sg_col_power_ow_command);
				SlipSpaceSpawnGroup(AI.sg_col_power_ow_bw);
				n_ow_wave_count = n_ow_wave_count + 1;
			end
			garbage_collect_now();
			sleep_s( 10 );
	until b_col_kill_overwhelping or ( b_sent_omelet_king_unlock and (n_ow_wave_count >= 2)  );
		if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then
			if b_sent_omelet_king_unlock and not b_col_kill_overwhelping  then
				SleepUntil([| ai_living_count( AI.sg_col_power_overwhelping ) <= 0 ], 1 );
					print("all hail the omelet king!");
					print("and his merry men");
					CreateThread( f_overwhelping_knight_omelet_king );
					CreateThread( f_overwhelping_knight_omelet_crew );
			end
		end
end



function f_col_poweroverwhelping_close()
	sleep_s(2.0);
	if not b_col_whelping_close_spawned then
		b_col_whelping_close_spawned = true;
		Sleep(1);
		SlipSpaceSpawnGroup(AI.sg_col_power_ow_bw);
	

	end
end

function SlipSpaceSpawnColiseum( placeTarget:ai ):void
	ai_play_slip_space_effect_at_squad_location(placeTarget);
	Sleep(60 * 3 );
	ai_place(placeTarget);
	local squadList:object_list = ai_actors(placeTarget);	
	local listIndex:number = list_count(squadList);
	if listIndex > 0 then
		repeat
			listIndex = listIndex - 1;
			object_dissolve_from_marker(list_get(squadList, listIndex), "resurrect", "phase_in");
			--object_dissolve_from_marker(ai_vehicle_get(placeTarget), "resurrect", "phase_in");
		until listIndex <= 0;
	end
	
	Sleep(5);
	ai_internal_query_clump_for_target(placeTarget);
	
end


function cs_knight_wait()
	

	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then

		sleep_s( 0.5 );

		repeat

		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
		 	sleep_rand_s( 0.25,1);
		 until b_col_knight_moment_elevator_block;
	end

end

global b_col_knight_jump:boolean = false;
function cs_knight_wait_override()


	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then


		sleep_rand_s( 0.5,1.2);
		cs_jump( 50, 7);

		sleep_rand_s( 0.1,0.3);
		repeat
		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0 );			 
			sleep_s( 0.5 );
				cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0 );  
				sleep_s( 0.75 );

		until b_col_knight_moment_elevator_block;
	end
end
  
function cs_knight_goto()

	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then

		sleep_s( 0.5 );
		local rand_n:number = random_range( 2, 5 );
		if POINTS.ps_col_end[rand_n] then
			print( POINTS.ps_col_end[rand_n] );
			cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
			cs_go_to( ai_current_actor, true,  POINTS.ps_col_end[rand_n], 1.5 );
		end

		repeat


		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
		 	sleep_rand_s( 0.5,1);
		 until b_col_knight_moment_elevator_block;
	end

end  
  
function cs_knight_goto_1()

	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then

		sleep_s( 0.5 );



			cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
			cs_go_to( ai_current_actor, true,  POINTS.ps_col_end.p01, 1.5 );


		sleep_rand_s( 0.25,0.75);
		repeat

			
		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
		 	sleep_rand_s( 0.75,1.5);
		 until b_col_knight_moment_elevator_block;
	end

end   
 
function cs_knight_goto_2()

	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then

		sleep_s( 0.5 );



			cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
			cs_go_to( ai_current_actor, true,  POINTS.ps_col_end.p02, 1.5 );
			sleep_rand_s( 0.25,0.75);

		repeat

		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
		 	sleep_rand_s( 0.8,1.6);
		 until b_col_knight_moment_elevator_block;
	end

end  

function cs_knight_goto_3()

	if b_col_whelping_close_spawned and not b_col_knight_moment_elevator_block then

		sleep_s( 0.5 );



			cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
			cs_go_to( ai_current_actor, true,  POINTS.ps_col_end.p03, 1.5 );
			sleep_rand_s( 0.25,0.75);

		repeat


		 	cs_shoot_at( ai_current_actor, true, POINTS.ps_col_end.p0  );
		 	sleep_rand_s( 0.5,1.5);
		 until b_col_knight_moment_elevator_block;
	end

end
  
function cs_knight_wait_eggs()

	object_set_scale(ai_current_actor, 2.5, 1*60 );
end

function cs_knight_wait_eggs_4()

	object_set_scale(ai_current_actor, 2.0, 1*60 );
end

function cs_knight_wait_eggs_mity()
 
	object_set_scale(ai_current_actor, 0.33, 0.1 );
end

function f_overwhelping_knight_omelet_king()

	--repeat
		print("king spawn");
		SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		SlipSpaceSpawn(AI.sq_col_w3_commander_ow_05_lol);



end

function f_overwhelping_knight_omelet_crew()

	SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	SlipSpaceSpawn(AI.sq_col_w3_battlewagon_ow_06_lol);
	
	sleep_s(10);
	SleepUntil([| ai_living_count(AI.sq_col_w3_battlewagon_ow_06_lol) <= 1 ] , 1);
		print("minis!!!");
		
		SlipSpaceSpawn(AI.sq_col_w3_battlewagon_ow_07_lol);
	SleepUntil([| ai_living_count(AI.sq_col_w3_battlewagon_ow_06_lol) <= 0 ] , 1);
		SlipSpaceSpawn(AI.sq_col_w3_battlewagon_ow_07_lol);
		print("more minis!!!!");
		sleep_s(10);
	SleepUntil([| ai_living_count(AI.sq_col_w3_battlewagon_ow_07_lol) <= 6 ] , 1);	
		SlipSpaceSpawn(AI.sq_col_w3_battlewagon_ow_06_lol);
		print("big guys!");
end



function debug_weapon_thing()
	--object_create( "fr_weapon_rack06");	
	--sleep_s(5);
	--object_set_variant( OBJECTS.fr_weapon_rack06 , "empty");
	
	--sleep_s(5);
	--object_destroy( OBJECTS.fr_weapon_rack06);	
	--object_create( "fr_weapon_rack06b");	
	--object_create_anew( "fr_weapon_rack06" );
end

function kill_dummy_ai( dummy:ai )
	Sleep(10);
	print("killing dummy");
	
	ai_kill_silent( dummy );
end

function f_coliseum_save()
	if coop_players_4() or game_difficulty_get_real() == DIFFICULTY.legendary then
		--print("no save for you");
	else
		game_save();
	end
	

end

function dormant.f_endgame_fx_control()

	SleepUntil( [| current_zone_set_fully_active() == ZONE_SETS.zn_factory ] , 1 );
		--print("stopping some factory effects");
		StopEffectGroup(EFFECTS.fx_factory_conduit_energy_lg_01 );
		StopEffectGroup(EFFECTS.fx_factory_conduit_energy_lg_02 );
		StopEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_02 );
		StopEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_01 );
		StopEffectGroup(EFFECTS.fx_factory_floor_circle_energy );
		StopEffectGroup(EFFECTS.fx_factory_core_energy );
		StopEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_01 );
		StopEffectGroup(EFFECTS.fx_factory_end_conduit_core );
		StopEffectGroup(EFFECTS.fx_factory_end_conduit_core_beam );
		
				
	
	SleepUntil( [| IsGoalActive(missionSentinels.goal_underground) or  b_end_restart_fx ] , 1 );
		--print("restarting some factory effects");
		CreateEffectGroup(EFFECTS.fx_factory_conduit_energy_lg_01 );
		CreateEffectGroup(EFFECTS.fx_factory_conduit_energy_lg_02 );
		CreateEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_02 );
		CreateEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_01 );
		CreateEffectGroup(EFFECTS.fx_factory_floor_circle_energy );
		CreateEffectGroup(EFFECTS.fx_factory_core_energy );
		CreateEffectGroup(EFFECTS.fx_factory_conduit_energy_sm_01 );
		CreateEffectGroup(EFFECTS.fx_factory_end_conduit_core );
		CreateEffectGroup(EFFECTS.fx_factory_end_conduit_core_beam );
	
end