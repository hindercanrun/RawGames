--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- REACTOR ROOM
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global s_reactor_objcon: number = 0;
global b_reactor_pull_players_to_core:boolean = false;
global b_assault_reactor_fight_begin:boolean = false;
global b_assault_reactor_fight_end:boolean = false;
global b_reactor_ready_to_move:boolean = false;
global b_reactor_musk_exit_reactor:boolean = false;
global b_reactor_marked:boolean = false;
global b_assault_reactor_start:boolean = false;
--global b_flight_close_box_cap:boolean = false;
	
AssaultOnTheStation.goal_reactor = 

{
	gotoVolume = VOLUMES.tv_flight_init,
	zoneSet = ZONE_SETS.zs_03_b,
	next={"goal_flight"},

}

function blink_reactor():void
	ai_erase_all();
	CreateThread(audio_assault_stopallmusic);
	b_tun_assault_range = true;
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_reactor", FLAGS.fl_blink_reactor_01);
	f_blink_clear_blips();
	TurnOffAllSpartanFlashlights();


end

function AssaultOnTheStation.goal_reactor.Start()
	--SleepUntil( [|  volume_test_players( VOLUMES.tv_reactor_init ) ], 1 );
		local l_timer:number = -1;
			print("Start goal reactor");
			b_assault_reactor_start = true;
			f_intro_cleanup();
			f_shipyard_cleanup();
			f_tunnel_cleanup();

			b_assault_hunter_fight_end = true;
			garbage_collect_now();
			assault_game_save_no_timeout();
			Wake( dormant.f_reactor_objcon_controller );
			print( "Reactor init" );
			f_blink_clear_blips();
			Sleep(2);
			CreateThread( f_reactor_bash_wall_wait );

			object_create( "sn_obj_reactor_console" );
			CreateThread( nar_goal_assault_reactor ); 
			CreateThread(audio_reactor_idle);
			CreateThread( f_reactor_clear_hard_orders );
			object_create_folder( "crs_reactor" );
			object_create_folder( "dms_reactor" );
			object_create_folder( "wpns_reactor" );
			object_create_folder( "sn_reactor" );
			--zone_set_trigger_volume_enable( "zone_set:zs_04", false );
			zone_set_trigger_volume_enable( "begin_zone_set:zs_04", false );
			CreateThread( f_reactor_charge_tut );
			object_destroy( OBJECTS.sn_obj_hunter_hole );
			object_destroy( OBJECTS.sn_obj_hunter_exit_button );
			CreateThread( f_reactor_ninja_spread_musketeer);
			CreateThread( f_reactor_catwalk_spread_musketeer );
			
			if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
				CreateThread( f_reactor_ground_pount_tut );
			end
			ai_disable_jump_hint( HINTS.jh_reactor_flight_exit_01 );
			ai_disable_jump_hint( HINTS.jh_reactor_flight_exit_02 );
			--
	SleepUntil( [|  volume_test_players( VOLUMES.tv_reactor_spawn) ], 1 );					
			ai_place(AI.sg_reactor_room);
			Sleep(2);
			--composer_play_show("vin_global_prebattle_elites");
			--composer_play_show("vin_global_prebattle_grunts");
			if game_is_cooperative() or game_difficulty_get_real() == DIFFICULTY.legendary then
				ai_place( AI.sg_reactor_extras );
			end
			CreateThread( f_reactor_secret_room_door_power );
	SleepUntil( [|  volume_test_players( VOLUMES.tv_reactor_fight_begin ) ], 1 );			
			b_assault_reactor_fight_begin = true;
			CreateThread(audio_assault_thread_up_reactor_combat);
			--print(ai_living_count( AI.sg_reactor_all ));
			object_destroy( OBJECTS.sn_obj_hunter_hole );
	SleepUntil( [| ai_living_count( AI.sg_reactor_all ) <= 2 and ai_living_count( AI.sg_reactor_elites ) <= 0 and not volume_test_objects( VOLUMES.tv_reactor_objcon_50, AI.sg_reactor_all ) ], 1);
		b_assault_reactor_fight_end = true;
		--Sleep(60);
		CreateThread( f_reactor_blip_wait );
--		f_blip_flag( FLAGS.fl_reactor_control, "default" );
		device_set_power( OBJECTS.dc_assault_reactor, 1 );
		

	SleepUntil( [|  device_get_position( OBJECTS.dc_assault_reactor ) >= 0.99 ], 1 );
		g_reactor_button_blip = false;
		device_set_power( OBJECTS.dc_assault_reactor, 0 );
		CreateThread(nar_ass_reactor_hit);

		object_destroy( OBJECTS.sn_obj_reactor_console );	
		Sleep( 15 );			
		garbage_collect_now();

		sleep_s( 2 );		
		assault_game_save_no_timeout();
		sleep_s( 2 );
		CreateThread( f_reactor_shake_loop );
		sleep_s( 5 );

		CreateThread( f_reactor_overload );
		--PauseGame();
		l_timer = timer_stamp( 30 );
	SleepUntil( [|  timer_expired(l_timer)  or  b_reactor_marked ], 3 );
		CreateThread( f_reactor_mark_reactor );   --failsafe if conv fails.
	
	SleepUntil( [|  volume_test_players( VOLUMES.tv_reactor_goto ) and b_reactor_marked ], 3 );		
		l_timer = timer_stamp( 8 );
	SleepUntil( [|  f_assault_wait_for_coop_buddy( VOLUMES.tv_reactor_goto ) or timer_expired( l_timer )], 3 );	
		b_reactor_ready_to_move = true;
		f_reactor_ass_clamps();  
		
		
		
end


function f_reactor_mark_reactor()
	if not b_reactor_marked then
		b_reactor_marked = true;
		object_create( "sn_obj_reactor_core" );
		CreateThread( f_move_reactor);
		f_reactor_musk_board_reactor();
	end
end

function debug_move_reactor()
	b_reactor_ready_to_move = true;
	f_reactor_mark_reactor();
end

function f_activator_get_reactor( trigger:object, activator:object ) 
	print("hologram activated");
	CreateThread(audio_assault_thread_up_activate_reactor);
	 --RunClientScript("f_cl_halogram_ics", trigger, activator);
	local this_activator:object = activator or PLAYERS.player0 ;
	--if not editor_mode() then
		g_comp_holo = composer_play_show("vin_player_ics_core_overload", { ics_player = this_activator});
	--end
	--SleepUntil( [| not pup_is_playing(g_comp_holo)  ],1);
	--Sleep(60);
		print("overload");
	CreateThread(audio_reactor_button_press);
		

end


function f_reactor_overload()
	
	RunClientScript( "cf_reactor_shake");
	sleep_s( .75 );
	--CreateEffectGroup(EFFECTS.fx_reactor_glow_01);
	RunClientScript( "cf_reactor_shake");
	sleep_s( .50 );
	--CreateEffectGroup(EFFECTS.fx_reactor_glow_02);	
	RunClientScript( "cf_reactor_shake");
	sleep_s( .25 );
	--CreateEffectGroup(EFFECTS.fx_reactor_glow_03);	
	RunClientScript( "cf_reactor_shake");
	sleep_s( 0.5 );
	--CreateEffectGroup(EFFECTS.fx_reactor_glow_04);
	sleep_s( 0.5 );	
	RunClientScript( "cf_reactor_shake");
end

function f_reactor_shake_loop()

	repeat
		RunClientScript( "cf_reactor_shake");
		sleep_rand_s( 3, 5 );
	until b_flight_begin ; 

end

global g_reactor_button_blip: boolean = true;

function f_reactor_blip_wait()


end

function f_reactor_bash_wall_wait()
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_charge_wall )  ], 1);
		ObjectOverrideNavMeshCutting( OBJECTS.sn_reactor_bash_wall, false );

end


function f_reactor_clear_hard_orders()
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_charge_tut )  ], 1);
		MusketeerUtil_SetDestination_Assault_Clear();
		ai_set_objective( AI.musketeer, "" );
end

function f_reactor_charge_tut()
	
	--GoalCreateThread( AssaultOnTheStation.goal_reactor, f_assault_volume_dislay_tutorial_setup , VOLUMES.tv_reactor_charge_tut, "training_charge", 5 );
	--if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
		CreateThread( f_assault_volume_tutorial_blocking_setup, VOLUMES.tv_reactor_charge_tut, "training_charge", "training_chief_charge_01", false );
	--end
end

function f_reactor_ground_pount_tut()
	
		for _,pl in ipairs ( players() ) do
			CreateThread( f_reactor_ground_pount_tut_player, unit_get_player(pl) , VOLUMES.tv_reactor_ground_pound_tutorial, "training_groundpound", TUTORIAL.GroundPound, 6 );
			sleep_s (0.1);
		end
end

function f_reactor_ground_pount_tut_player (pl:player, tv:volume, train_mechanic:string, mechanic_id:tutorial, n_time:number )
		SleepUntil([| volume_test_objects(tv, pl)], 1);
			print("tut");
			 TutorialShowIfNotPerformed(unit_get_player(pl), train_mechanic, mechanic_id, n_time);		
			 --TutorialShow( pl, train_mechanic, n_time );
			SleepUntil([| s_reactor_objcon >= 13 or ai_combat_status(AI.sg_reactor_room) >= 5] ,1 );
			 TutorialStop(pl);
end

function dormant.f_reactor_objcon_controller()

	print("reactor objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_10 ) or s_reactor_objcon >= 10 ], 1);
		if s_reactor_objcon <= 10 then
			s_reactor_objcon = 10;
			print("s_reactor_objcon = 10 ");
		end

	
	----CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_groundpound", 6 );
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_13 ) or s_reactor_objcon >= 13 ], 1);
		if s_reactor_objcon <= 13 then
			s_reactor_objcon = 13;
			print("s_reactor_objcon = 13 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_15 ) or s_reactor_objcon >= 15 ], 1);
		if s_reactor_objcon <= 15 then
			s_reactor_objcon = 15;
			print("s_reactor_objcon = 15 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_17 ) or s_reactor_objcon >= 17 ], 1);
		if s_reactor_objcon <= 17 then
			s_reactor_objcon = 17;
			print("s_reactor_objcon = 17 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_20 ) or s_reactor_objcon >= 20 ], 1);
		if s_reactor_objcon <= 20 then
			s_reactor_objcon = 20;
			print("s_reactor_objcon = 20 ");
		end
		
		assault_game_save_no_timeout();
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_25 ) or s_reactor_objcon >= 25 ], 1);
		if s_reactor_objcon <= 25 then
			s_reactor_objcon = 25;
			print("s_reactor_objcon = 25 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_30 ) or s_reactor_objcon >= 30 ], 1);
		if s_reactor_objcon <= 30 then
			s_reactor_objcon = 30;
			print("s_reactor_objcon = 30 ");
		end		
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_33 ) or s_reactor_objcon >= 33 ], 1);
		if s_reactor_objcon <= 33 then
			s_reactor_objcon = 33;
			print("s_reactor_objcon = 33 ");
		end	
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_35 ) or s_reactor_objcon >= 35 ], 1);
		if s_reactor_objcon <= 35 then
			s_reactor_objcon = 35;
			print("s_reactor_objcon = 35 ");
		end	


	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_40 ) or s_reactor_objcon >= 40 ], 1);
		if s_reactor_objcon <= 40 then
			s_reactor_objcon = 40;
			print("s_reactor_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_objcon_50 ) or s_reactor_objcon >= 50 ], 1);
		if s_reactor_objcon <= 50 then
			s_reactor_objcon = 50;
			print("s_reactor_objcon = 50 ");
		end
		

		
		
end

global b_reactor_ninja_active:boolean = false;

function f_reactor_ninja_spread_musketeer()
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;

		repeat
				b_pos_1_set = false;
				b_pos_2_set = false;
				SleepUntil( [| volume_test_players(  VOLUMES.tv_reactor_ninja )  or s_reactor_objcon >= 50 ], 1);
					if s_reactor_objcon < 50 then
						b_reactor_ninja_active = true;
						for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
						
							if not b_pos_1_set then
								b_pos_1_set = true;
								MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_01, 3.5);
									print("pos 1");
							elseif not b_pos_2_set then
								b_pos_2_set = true;
								print("pos 2");
								MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_02, 5);
							else
									print("pos 3");
									MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_03, 5);
							end
						end
					end
				SleepUntil( [| not volume_test_players(  VOLUMES.tv_reactor_ninja ) or s_reactor_objcon >= 50 ], 1);

					b_reactor_ninja_active = false;
					MusketeerUtil_SetDestination_Assault_Clear();
					print("cleared goals");

		until s_reactor_objcon >= 50 ;
		
		MusketeerUtil_SetDestination_Assault_Clear();
end


function f_reactor_catwalk_spread_musketeer()
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;

		repeat
				b_pos_1_set = false;
				b_pos_2_set = false;
				SleepUntil( [| volume_test_players(  VOLUMES.tv_reactor_catwalks )  or s_reactor_objcon >= 50 ], 1);
					if not b_reactor_ninja_active then
						for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
						
							if not b_pos_1_set then
								b_pos_1_set = true;
								--MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_04, 5);
									print("my buddy");
							elseif not b_pos_2_set then
								b_pos_2_set = true;
								print("pos 2");
								MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_05, 6);
							else
									print("pos 3");
									MusketeerDestSetPoint(obj, FLAGS.fl_reactor_goal_mid_06, 6);
							end
						end
					end
				SleepUntil( [| not volume_test_players(  VOLUMES.tv_reactor_catwalks ) or s_reactor_objcon >= 50 ], 1);

					if not b_reactor_ninja_active then
						MusketeerUtil_SetDestination_Assault_Clear();
					end
					print("cleared goals");

		until s_reactor_objcon >= 50 ;
		
		MusketeerUtil_SetDestination_Assault_Clear();
end

function debug_reactor()
	print("debug reactor");
	Wake( dormant.f_reactor_objcon_controller );
	--ai_place(AI.sg_reactor_room);
end

function debug_reactor_con()
	print("debug reactor");
	Wake( dormant.f_reactor_objcon_controller );
	object_teleport(PLAYERS.player0,FLAGS.fl_blink_reactor_01 );
	object_teleport(PLAYERS.player1,FLAGS.fl_blink_reactor_02 );
	object_teleport(PLAYERS.player2,FLAGS.fl_blink_reactor_03 );
	object_teleport(PLAYERS.player3,FLAGS.fl_blink_reactor_04 );
	--ai_place(AI.sg_reactor_room);
end




function cs_dummy_staging_elite()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true);
	cs_enable_moving ( false );
	--cs_custom_animation( TAG('objects\characters\storm_elite_ai\storm_elite_ai.model_animation_graph'), "combat:rifle:warn", true );
	SleepUntil( [| ai_combat_status(AI.sg_reactor_elites) >= 5 ],1 );
	
end

function cs_dummy_staging_jackal()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true);
	cs_enable_moving ( false );
	--cs_custom_animation( TAG('objects\characters\storm_elite_ai\storm_elite_ai.model_animation_graph'), "crouch:dual:js:idle", true );
	SleepUntil( [| ai_combat_status(AI.sg_reactor_elites) >= 5 ],1 );
	--print("hi");
end



function f_reactor_ass_clamps()


 device_set_position ( OBJECTS.dm_reactor_ass_clamp01, 1 );
 Sleep(30);
 device_set_position ( OBJECTS.dm_reactor_ass_clamp02, 1 );
 Sleep(30);
 device_set_position ( OBJECTS.dm_reactor_ass_clamp03, 1 ); 
 sleep_s(2);
end

global b_reactor_end_pause_full_go:boolean = false;
global b_reactor_final_pause_go:boolean = false;
global b_reactor_final_pause_start:boolean = false;
function f_move_reactor():boolean
	print("move reactor");
	
	SleepUntil( [| b_reactor_ready_to_move ], 1);
		ai_disable_jump_hint( HINTS.jump_reactor_dyn_01 );
		ai_disable_jump_hint( HINTS.jump_reactor_dyn_02 );
		game_save_cancel();
		Sleep(2);
		zone_set_trigger_volume_enable( "begin_zone_set:zs_04", true );
		sleep_s(2.5);		
		CreateThread(audio_assault_thread_up_move_reactor);
		CreateThread(nar_ass_reactor_start);
	---adding this becuase all dudes take damage when falling down with reactor. KS
		for _,spartan in ipairs (spartans()) do  
			CreateThread(f_reac_temp_invul, spartan);
		end
	
		composer_play_show( "reactor_reactor");


	----	device_set_position_track(OBJECTS.dm_reactor_core, "device:position", 0);
	----	device_animate_position( OBJECTS.dm_reactor_core ,0.1, 6, 0.1, 0 , true );
		--print( seconds_to_frames(6) );
		--DeviceLayerPlayAnimationDestination( OBJECTS.dm_reactor_core, 1, "device:position",  0.1 / 6 * 15 , 0.1  );   -- dest / rate * total frames
		
		

		
	
		sleep_s(8);
		
		f_volume_teleport_all_not_inside(VOLUMES.tv_reactor_goto_teleport ,FLAGS.fl_reactor_core01);
		--f_unblip_flag( FLAGS.fl_reactor_core );
		ai_disable_jump_hint( HINTS.jump_reactor_dyn_03 );
		ai_disable_jump_hint( HINTS.jump_reactor_dyn_04 );
		
		object_destroy( OBJECTS.sn_obj_reactor_core );
		--CreateThread( f_reactor_flight_door );
		sleep_s(5);
		b_reactor_end_pause_full_go = true;
	----	device_animate_position( OBJECTS.dm_reactor_core ,0.71, 22 , 0.1, 0 , true ); 
		--DeviceLayerPlayAnimationDestinationContinue( OBJECTS.dm_reactor_core, 1, "device:position",  0.71 / 22 * 15 , 0.71);
		--sleep_s(23);
		--device_set_position( OBJECTS.dm_reactor_box_cap ,1 );
	----	device_animate_position( OBJECTS.dm_reactor_core ,0.775, 5 , 0.1, 0 , true );
		--DeviceLayerPlayAnimationDestinationContinue( OBJECTS.dm_reactor_core, 1, "device:position", 0.775 / 5 * 15, 0.775);

    --sleep_s(5)
		SleepUntil ( [| b_reactor_final_pause_start ] ,1 );
			print("second pause start");
			ai_enable_jump_hint( HINTS.jh_reactor_flight_exit_01 );
			ai_enable_jump_hint( HINTS.jh_reactor_flight_exit_02 );
			b_reactor_musk_exit_reactor = true;	
			sleep_s(3);	
		SleepUntil ( [| not volume_test_players( VOLUMES.tv_flight_ass_cap ) ] ,1 );
			print("exited");
			sleep_s(5);
			b_reactor_final_pause_go = true;
			
	----	device_animate_position( OBJECTS.dm_reactor_core ,0.782, 5, 0.1, 0 , true );
			--DeviceLayerPlayAnimationDestinationContinue( OBJECTS.dm_reactor_core, 1, "device:position",  0.793 / 5 * 58, 0.793 );
			----sleep_s(2);

			--b_flight_close_box_cap = true;
			object_destroy( OBJECTS.sn_obj_reactor_core );
	return true;
end

function f_reactor_open_box_cap()
	print("open cap");

	--SleepUntil ( [| device_get_position( OBJECTS.dm_reactor_core ) >= 0.71 ] ,1 );
		--DeviceLayerPlayAnimation( OBJECTS.dm_reactor_box_cap, 1, "device:position",  seconds_to_frames(1.5));  --seconds_to_frames(1.5)
		--device_set_position_track(OBJECTS.dm_reactor_box_cap, "device:position", 0);
		--device_animate_position( OBJECTS.dm_reactor_box_cap ,1, 1.5 , 0.1, 0 , true ); 
		device_set_position_immediate( OBJECTS.dm_reactor_box_cap ,1 );
----	SleepUntil ( [| b_flight_close_box_cap ] ,1 );
		--DeviceLayerPlayAnimationBackward( OBJECTS.dm_reactor_box_cap, 1, "device:position", 120);
	---	device_set_position( OBJECTS.dm_reactor_box_cap, 0);
----		device_animate_position( OBJECTS.dm_reactor_box_cap ,0, 8 , 0.1, 0 , true ); 
		--DeviceLayerPlayAnimationDestination( OBJECTS.dm_reactor_box_cap, 1, "device:position", seconds_to_frames(6), 0.1);
end


function f_reactor_close_box_cap()
	print("close cap");
		device_set_position( OBJECTS.dm_reactor_box_cap ,0 );
		--device_animate_position( OBJECTS.dm_reactor_box_cap ,0, 8 , 0.1, 0 , true ); 
		SleepUntil ( [| device_get_position( OBJECTS.dm_reactor_box_cap) == 0  ] ,1 );
			sleep_s(1);
			object_destroy( OBJECTS.dm_reactor_core);
end
---adding this becuase all dudes take damage when falling down with reactor. KS
function f_reac_temp_invul(spartan:object):void
	unit_falling_damage_disable(spartan, true);
	object_cannot_die(spartan , true);
end

function f_move_reactor_set():void

	--SleepUntil( [| volume_test_players(  VOLUMES.tv_main_elevator ) ], 1);
		--device_set_position( OBJECTS.intro_elevator ,1.0);
		
	--	device_set_position_track(OBJECTS.dm_reactor_core, "device:position", 0);
		--device_animate_position( OBJECTS.dm_reactor_core ,0.775, 0.1, 0.1, 0 , true );

		DeviceLayerPlayAnimationDestination( OBJECTS.dm_reactor_core, 1, "device:position", seconds_to_frames(0.1), 0.775);
end

function f_reactor_musk_board_reactor()
		b_reactor_marked = true;
		f_assault_set_musketeer_goal( FLAGS.fl_reactor_core02, 0.5);
		ai_set_objective( AI.musketeer , "obj_musket_reactor");
	SleepUntil ( [| b_reactor_musk_exit_reactor ] ,1 );		
		--f_assault_set_musketeer_goal( FLAGS.fl_flight_reactor_drop_stop, 2);
		local b_pos_1_set:boolean = false;
		
		for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;
					MusketeerDestSetPoint(obj, FLAGS.fl_flight_reactor_drop_stop1, 2);
				else
					MusketeerDestSetPoint(obj, FLAGS.fl_flight_reactor_drop_stop2, 2);
				end
		end
		ai_set_objective( AI.musketeer , "");
end


function f_reactor_cleanup()
	ai_erase( AI.sg_reactor_room );
	object_destroy_folder("crs_reactor");
	object_destroy_folder("dms_reactor");	
	object_destroy_folder("wpns_reactor");
	object_destroy_folder("sn_reactor");
end


function debug_reactor_crates()
	object_create_folder( "crs_reactor" );

end

function f_reactor_secret_room_door_power()

	
		SleepUntil ([| volume_test_players ( VOLUMES.tv_reactor_back_room_power )  ], 1);
			device_set_power( OBJECTS.dm_secret_room,1);
end

--## CLIENT

function remoteClient.cf_reactor_shake()

	CreateThread( camera_shake_all_coop_players, 1, 0.4, 0.4, 1) ;
end
