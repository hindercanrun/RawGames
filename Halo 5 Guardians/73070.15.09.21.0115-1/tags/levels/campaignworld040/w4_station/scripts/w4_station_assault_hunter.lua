--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- HUNTER
---------------------------------------------------------------
---------------------------------------------------------------

global b_hunter_form_now:boolean = false;
global b_hunter_anvil_died:boolean = false;
global b_hunter_ballista_died:boolean = false;
global b_assault_hunter_complete:boolean = false;
global b_assault_hunter_begin:boolean = false;
global b_assault_hunter_fight_begin:boolean = false;
global b_assault_hunter_fight_end:boolean = false;
global b_hunter_blast_door_opened:boolean = false;
global gb_hunter_exit_open:boolean = false;
global gb_hunter_room_cleared:boolean = false;
global gb_hunter_jump_down_ready:boolean = false;
---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
AssaultOnTheStation.goal_hunter = 

{
	gotoVolume = VOLUMES.tv_reactor_init,
	zoneSet = ZONE_SETS.zs_03,
	next={"goal_reactor"},

}



function blink_hunter():void

	CreateThread(audio_assault_stopallmusic);	
	ai_erase_all();
	--Sleep (10);
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_hunter", FLAGS.fl_hunter_blink);
	f_blink_clear_blips();
	b_reactor_plan_complete = true;
	b_tun_assault_range = true;
	CreateThread( f_setup_headlamp_area, VOLUMES.tv_headlamp_1 , f_tunnel_lamp_areas_complete );


end

function AssaultOnTheStation.goal_hunter.Start()

		print("Hunter init");

		assault_game_save_no_timeout();
		

	b_assault_hunter_begin = true;

	CreateThread(nar_goal_assault_hunter);
	CreateThread(f_tun_hunter_door);

	zone_set_trigger_volume_enable("begin_zone_set:zs_03_b", false );
	object_destroy(OBJECTS.sn_tunnels_mark_path_01);
	object_destroy(OBJECTS.sn_tunnels_mark_path_window);
	object_create_folder("m_hunter_room_crates");

	object_create_folder("wpns_hunter");
	Sleep(1);
	--object_create("dc_hunter_exit_control");
	CreateThread( f_hunter_kill_lights );
	CreateThread( f_hunter_exit_watcher );
	CreateThread( f_hunter_exit_blip );
	CreateThread( f_hunter_anvil );
	CreateThread( f_hunter_ballista );
	CreateThread(f_hunter_blast_shield_door);
	ai_disable_jump_hint( HINTS.jh_hunter_elevator );

	ai_disable_jump_hint( HINTS.jh_hunter_elevator_exit_01 );
	ai_disable_jump_hint( HINTS.jh_hunter_elevator_exit_02 );		
	
	ObjectOverrideNavMeshCutting( OBJECTS.dm_hunter_plug, true );
	GoalCreateThread( AssaultOnTheStation.goal_hunter, f_assault_volume_display_tutorial_wait, unit_get_player( SPARTANS.chief ), VOLUMES.tv_hunter_target_tut, "training_orders_target", TUTORIAL.OrdersEnemy, 6 );

end

function dormant.f_hunter_attach_sign()

	--objects_physically_attach( OBJECTS.dm_tun_hunter_door, "hunter_decal", OBJECTS.sn_hunter_lab_sign, "");
end

function f_tun_hunter_door():void
-- adding this bool for narrative
		local l_timer:number = 0;
		l_timer = timer_stamp( 24 );
	SleepUntil( [| b_reactor_plan_complete or timer_expired(l_timer)  ] , 1 );
		CreateThread( f_hunter_objective );
		object_create( "sn_obj_hunter_door" );

		device_set_power( OBJECTS.dc_tun_hunter_door, 1 );
end

function f_hunter_objective()

  f_assault_set_objective( TITLES.ct_obj_assault_3_main, true );
end

function f_tun_open_hunter_door( trigger:object, activator:object ) 
	CreateThread(audio_hunter_door_button_press);
	CreateThread(audio_assault_thread_up_hunter_room);
	local this_activator:object = activator or PLAYERS.player0 ;
	device_set_power( OBJECTS.dc_tun_hunter_door, 0 );
	CreateThread(nar_ass_elevator_panel_used);

	composer_play_show("vin_player_ics_valve_turn", { ics_player = this_activator});


	
	object_destroy( OBJECTS.sn_obj_hunter_door );
	CreateThread( f_hunter_mark_elevator );

	--print("you should only see this once f_hunter_blast_shield_door ");
	
	b_hunter_blast_door_opened = true;
end



function f_hunter_mark_elevator()
	sleep_s(1);
	object_create( "sn_obj_hunter_elevator" );
end

global l_comp_hunter_form:number = nil;

function f_hunter_window_worms()
	--SleepUntil( [| volume_test_players( VOLUMES.tv_hunter_window_worms) ] , 3 );
		composer_play_show( "w4_station_tunnel_elevator_worms"); 
		

end

function f_hunter_musketeer_elevator()
		SleepUntil ( [| device_get_position( OBJECTS.dm_tun_hunter_door ) >  0.8 ] , 1 );
			ai_enable_jump_hint( HINTS.jh_hunter_elevator );
			ai_set_objective( AI.musketeer, "obj_hunter_blue" );
			f_assault_set_musketeer_goal( FLAGS.fl_hunter_musk_elevator_goal ,0.5);
end

function f_hunter_blast_shield_door():void
	local l_timer:number = -1;
	SleepUntil( [| b_hunter_blast_door_opened ] , 3 );
	sleep_s(4);
	object_destroy( OBJECTS.sn_obj_hunter_door );
	CreateThread( f_hunter_window_worms );
	--print("open");
	--sleep_s(2.0);
	CreateThread( f_hunter_musketeer_elevator );
	device_set_position( OBJECTS.dm_tun_hunter_door, 1 );
	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter_blast_shield) ] , 3 );
		l_comp_hunter_form = composer_play_show("vin_hunter_forms");
		l_timer = timer_stamp( 7 );
		Sleep(3);
	SleepUntil( [|  f_assault_wait_for_coop_buddy( VOLUMES.tv_hunter_blast_shield ) or timer_expired(l_timer)] , 3 );
		sleep_s(0.5);

		object_destroy( OBJECTS.sn_obj_hunter_elevator );
		assault_game_save_no_timeout();
		--CreateThread( f_player_area_text , "Narrative Beat: Cool looking HUNTER room");
	
		CreateThread(nar_ass_hunter_elevator);
		sleep_s(2.5);
		
		f_volume_teleport_all_not_inside(VOLUMES.tv_hunter_blast_shield_teleport ,FLAGS.fl_tun_blast_teleport);
		b_lamp_areas_complete = true;
			print("poof");
		TurnOffAllSpartanFlashlights();

		CreateThread( f_hunter_close_door )

		Sleep(5);
		f_volume_teleport_all_not_inside(VOLUMES.tv_hunter_blast_shield_teleport ,FLAGS.fl_tun_blast_teleport);
		
		
		CreateThread( f_move_hunter_elevator);
		f_tunnel_cleanup();
		CreateThread(f_rec_hunter_form);
		

		sleep_s(3);
		--
		b_hunter_form_now = true;
		sleep_s(11.5);
		TurnOffAllSpartanFlashlights();
		--f_hunter_bang();
		CreateThread( f_check_hunter_area );
end

function f_hunter_bang()
	print("bang");
	rumble_shake_medium(0.75);
end

function f_hunter_kill_lights()
		SleepUntil ([|volume_test_players (VOLUMES.tv_hunter_finish_lights)], 1);
			b_lamp_areas_complete = true;
			SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_flashlight\004_dm_flashlight_turnoff.sound'), nil, 1);
			TurnOffAllSpartanFlashlights();
end


function f_hunter_close_door()
		--device_set_power( OBJECTS.dm_tun_hunter_door, 0 );
		device_set_position( OBJECTS.dm_tun_hunter_door, 0 );
	SleepUntil( [| device_get_position( OBJECTS.dm_tun_hunter_door ) == 0], 1 ) ;		
		f_volume_teleport_all_not_inside(VOLUMES.tv_hunter_blast_shield_teleport ,FLAGS.fl_tun_blast_teleport02);
		device_set_power( OBJECTS.dm_tun_hunter_door, 0 );
end

function f_move_hunter_elevator()

	
	----device_set_position_track(OBJECTS.dm_reac_hunt_rm_lift_01, "device:position", 1);
	----device_animate_position( OBJECTS.dm_reac_hunt_rm_lift_01 ,0.70, 12, 0.1, 0 , true );
	
	DeviceSetLayerAnimation (OBJECTS.dm_reac_hunt_rm_lift_01, 1, "device:position");
	
	DeviceSetLayerRate(OBJECTS.dm_reac_hunt_rm_lift_01, 1, 30);
	
	DeviceSetLayerPlaybackStop(OBJECTS.dm_reac_hunt_rm_lift_01, 1);
  DeviceSetLayerDest(OBJECTS.dm_reac_hunt_rm_lift_01, 1, 0.7);    
  DeviceSetLayerPos(OBJECTS.dm_reac_hunt_rm_lift_01, 1, 0);
	sleep_s(15); 
	DeviceSetLayerDest(OBJECTS.dm_reac_hunt_rm_lift_01, 1, 1);  
	print("testesta");
----	device_animate_position( OBJECTS.dm_reac_hunt_rm_lift_01 ,1, 4, 0.1, 0 , true );
	sleep_s(1);
	ai_enable_jump_hint( HINTS.jh_hunter_elevator_exit_01 );
	ai_enable_jump_hint( HINTS.jh_hunter_elevator_exit_02 );		
	assault_game_save_no_timeout();
end


function f_hunter_exit_blip()


	SleepUntil( [| ai_spawn_count( AI.AISquad_hunter_forms ) > 0 and ai_spawn_count( AI.sq_reac_hunter_2 ) > 0 and ai_living_count(AI.AISquad_hunter_forms) <= 0 and ai_living_count(AI.sq_reac_hunter_2) <= 0 ] , 1 );
		gb_hunter_room_cleared = true;
		
		if not ( b_assault_hunter_complete or b_assault_reactor_start ) then 
			game_save_no_timeout();
		
			if device_get_position(OBJECTS.dm_hunter_plug ) == 0  then
			  object_create( "sn_obj_hunter_exit_button" );
			end
		
		
			sleep_s(2);
			f_assault_set_musketeer_goal( FLAGS.fl_hunter_musk_exit_goal ,0.5);
			ai_set_objective( AI.musketeer, "obj_hunter_blue" );
			CreateThread( f_hunter_ping_until_exit_found );
			if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
				CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 5 );
			end
		end
end



function f_hunter_exit_watcher()
	SleepUntil( [| object_valid( "dc_hunter_exit_control") ] , 1 );

	SleepUntil( [| device_get_position(OBJECTS.dc_hunter_exit_control) >= 0.1  ] , 1 );
		print("opening exit");
		zone_set_trigger_volume_enable("begin_zone_set:zs_03_b", true );
		gb_hunter_exit_open = true;
		CreateThread(nar_ass_air_duct_used);
		device_set_power(OBJECTS.dc_hunter_exit_control, 0 );

		
		object_destroy( OBJECTS.sn_obj_hunter_exit_button );
		
		sleep_s(1.25);
		CreateThread( f_hunter_move_plug );
		object_create( "sn_obj_hunter_hole" );
		--device_set_power( OBJECTS.dc_hunter_exit_control,0 );
		sleep_s(4);
		

		CreateThread( f_ass_track_blip_per_player, VOLUMES.tv_hunter_exit, FLAGS.fl_hunter_exit );
		--ai_set_objective( AI.musketeer, "" );
		--MusketeerUtil_SetDestination_Assault_Clear();
	SleepUntil( [| device_get_position( OBJECTS.dm_hunter_plug ) >= 0.99  ] , 1 );
		gb_hunter_jump_down_ready	= true;
		f_assault_set_musketeer_goal( FLAGS.fl_hunter_reactor_drop_goal ,0.75);
		object_destroy( OBJECTS.sn_obj_hunter_exit_button );
		
		sleep_s(3) ;
		if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
		end
		--navpoint_track_object_for_player( PLAYERS.player0, OBJECTS.sn_obj_hunter_exit_button, true ) ;
		--f_unblip_flag( FLAGS.fl_hunter_exit );
			--object_destroy( OBJECTS.sn_obj_hunter_hole );
end


function f_hunter_ping_until_exit_found()
	sleep_s(25);

		repeat
				if not gb_hunter_exit_open then
					if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
						CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
					end
				end
				sleep_s(25);
		until( gb_hunter_exit_open );

end

function f_hunter_move_plug()


	device_set_position( OBJECTS.dm_hunter_plug , 1) ;

	
	--ObjectOverrideNavMeshCutting( OBJECTS.dm_hunter_plug, false );
end



function f_activator_get_hunter_exit( trigger:object, activator:object ) 
	print("exit plug de-activated");
	CreateThread(audio_hunter_exit_plug);

	local this_activator:object = activator or SPARTANS.chief ;

		g_comp_holo = composer_play_show("vin_player_ics_hunter_exit", { ics_player = this_activator});		
		print("open exit vent");
		
end

--function f_hunter_exit_fx()
	--Sleep(45);
--	CreateEffectGroup( EFFECTS.fx_hunter_exit_punch );
	
--end

function f_activator_get_hunter()
	print("hunter button push callback");
end

function f_rec_hunter_form():void

	--	b_hunter_form_now = true;
		sleep_s(11.0);
		RunClientScript("f_hunter_cl_hunter_drop_boom");
		sleep_s(0.25);	
		ai_place( AI.sq_reac_hunter_2 );
		sleep_s( 1.5 );
		ai_set_task(AI.AISquad_hunter_forms, "obj_hunter", "front" );
		sleep_s( 5 );
		ai_set_objective( AI.musketeer, "" );
		ai_disable_jump_hint( HINTS.jh_hunter_elevator );
		MusketeerUtil_SetDestination_Assault_Clear();
		b_assault_hunter_fight_begin = true;		
end



function debug_hunter_spawn()
	ai_place( AI.sq_reac_hunter_1 );
	ai_place( AI.sq_reac_hunter_2 );
	Sleep(10);
	ai_set_task(AI.sq_reac_hunter_1, "obj_hunter", "front" )
end

function f_hunter_anvil()
	SleepUntil( [| ai_spawn_count( AI.AISquad_hunter_forms )  > 0 ], 1 );
		print("Anvil spawned");
	SleepUntil( [| ai_living_count( AI.AISquad_hunter_forms )  <= 0 ], 1 );	
		print("AI.AISquad_hunter_forms Anvil is dead");
		if not b_assault_hunter_complete then
			b_hunter_anvil_died = true;
		else
			print("HUNTER SURVIVED HUNTER ENCOUNTER");
		end

end

function f_hunter_ballista()
	SleepUntil( [| ai_spawn_count( AI.sq_reac_hunter_2 )  > 0 ], 1 );
		print("Ballista spawned");
	SleepUntil( [| ai_living_count( AI.sq_reac_hunter_2 )  <= 0 ], 1 );	
		print("AI.sq_reac_hunter_2 Ballista is dead");
		if not b_assault_hunter_complete then
			b_hunter_ballista_died = true;
		else
			print("HUNTER SURVIVED HUNTER ENCOUNTER");
		end
end

function f_check_hunter_area()

	SleepUntil( [| not volume_test_objects( VOLUMES.tv_hunter_room_all, spartans() ) ] , 3 );
		print("Hunter area complete");
		b_assault_hunter_complete = true;

end

function f_hunter_cleanup()
	print("hunter cleanup ");
	b_assault_hunter_complete = true;
	Sleep(5);
	ai_erase( AI.sq_reac_hunter_2 );
	ai_erase( AI.AISquad_hunter_forms );
	object_destroy_folder("m_hunter_room_crates");
	object_destroy(OBJECTS.dc_hunter_exit_control);
	object_destroy_folder("wpns_hunter");
	object_destroy( OBJECTS.sn_obj_hunter_exit_button );
	object_destroy( OBJECTS.sn_obj_hunter_door );
	object_destroy( OBJECTS.sn_obj_hunter_elevator );
	--flock_destroy("aiflock_worms_temp");
	
end

function cs_hunter_1()

end

function cs_hunter_2()

end







