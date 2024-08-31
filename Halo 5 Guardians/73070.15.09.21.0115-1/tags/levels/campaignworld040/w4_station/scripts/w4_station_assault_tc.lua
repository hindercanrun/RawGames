--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- TECH CENTER
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global gb_tech_halogram_activate:boolean = false;
global g_tech_blip_control:boolean = true;
global b_tech_elevator_open:boolean = false;
global g_b_tech_elevator_started:boolean = false;
global g_comp_holo:number = -1;
global g_comp_elevator:number = -1;
AssaultOnTheStation.goal_tech_center = 

{
	gotoVolume = VOLUMES.tv_shipyard_init,
	zoneSet = ZONE_SETS.zs_01,
	next={"goal_shipyard"},
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	--checkPoints = POINTS.ps_intro_blink,
}


function blink_tech():void
--	switch_zone_set(ZONE_SETS.zs_01);
	ai_erase_all();
	object_create( "sn_obj_tech_holo" );
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_tech_center", FLAGS.fl_blink_tc_01);
	
	CreateThread(audio_assault_stopallmusic);
	f_blink_clear_blips(); 
	--object_create_folder( "cr_reactor" );
end

--
function AssaultOnTheStation.goal_tech_center.Start()

		assault_game_save_no_timeout();
		CreateThread( f_move_elevator );
		CreateThread( f_tech_download );
		--zone_set_trigger_volume_enable( "begin_zone_set:zs_02" , false );
		--zone_set_trigger_volume_enable( "zone_set:zs_02" , false );
		CreateThread( f_tech_blip_wait );
		--CreateThread( f_tech_objective);	
		CreateThread( f_tech_command_killed );
		SleepUntil( [| device_get_power( OBJECTS.dc_tech_halogram ) == 0 ],1);	
			--dc_tech_halogram
			g_tech_blip_control = false;
			object_destroy( OBJECTS.sn_obj_tech_holo );
			CreateThread(audio_hologram_loop);
			Sleep(15);
			CreateThread( f_tech_attach_button );
			--object_destroy( OBJECTS.sn_obj_tech_holo );
			Sleep(5);
			--print("elevator blip");
			--object_create( "sn_obj_tech_elevator" );
			--f_unblip_object(OBJECTS.dc_tech_halogram);
			--sleep_s(5);
			--f_tech_objective_2();

end

function f_tech_command_killed()

	SleepUntil( [| ai_living_count(AI.sg_intro_command) <= 0 and  ai_living_count(AI.sg_intro_command) <= 0 ],1);
			print("room clear");
			
			
			Sleep(5);
		
			sleep_s( 3 );
						
			b_intro_halls_fight_end = true;
end


function AssaultOnTheStation.goal_tech_center.End()
		print("ending tech center goal");
		b_musketeer_enter_elevator = true;
		object_destroy( OBJECTS.sn_obj_tech_holo );
		object_destroy( OBJECTS.sn_obj_tech_elevator );	
		object_destroy_folder("crs_tech");
		object_destroy( OBJECTS.cr_tech_door_blocker );
		flock_destroy( "aiflock_intro_banshees01" );
		MusketeerUtil_SetDestination_Assault_Clear();
end

function dormant.w4_assault_techcenter_init()
	SleepUntil( [| volume_test_players(VOLUMES.tv_techcenter_init ) ],1);
		print("Tech Center init");
		--CreateThread( f_player_area_text , "Reach The Station's Diagnostics");
	
	--	CreateThread( f_assault_blip_wrapper, FLAGS.fl_tc_ship_diag , VOLUMES.tv_techcenter_init, VOLUMES.tv_tech_commit );
		--CreateThread( f_assault_blip_wrapper, FLAGS.fl_tc_ship_diag , VOLUMES.tv_tc_ship_goal, VOLUMES.tv_tc_ship_diag );
		CreateThread(nar_goal_assault_tech); 
		CreateThread( f_tc_diag_complete );
		object_create_folder("crs_tech");
		
		object_create_folder("dms_tech");

		object_create( "dc_tech_halogram" );
		assault_game_save_no_timeout();

		

end


function f_tech_attach_button()

	--objects_physically_attach( OBJECTS.dm_intro_elevator, "m_pad", OBJECTS.dc_tech_elevator_render, "");
end

function f_tech_download()

		device_set_power( OBJECTS.dc_tech_halogram, 1 );
		
end

function f_tech_objective()
	--f_assault_complete_objective();
	f_assault_set_objective( TITLES.ct_obj_assault_2, true );
end

function f_tech_objective_2()
	--f_assault_complete_objective();
	print("blip elevator");
	if not g_b_tech_elevator_started then
		object_create( "sn_obj_tech_elevator" );
	end
	f_assault_set_objective( TITLES.ct_obj_assault_2_main, true );
end

function f_tech_blip_wait()

	local l_timer:number = 0;
	l_timer = timer_stamp(30 );
	SleepUntil( [|  timer_expired(l_timer) ],1); 
		if g_tech_blip_control then 
			print("reminder to ping");
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 5 );	
		end
end







function f_activator_get_hologram( trigger:object, activator:object ) 
	print("hologram activated");
	 --RunClientScript("f_cl_halogram_ics", trigger, activator);
	local this_activator:object = activator or PLAYERS.player0 ;
	--if not editor_mode() then
		g_comp_holo = composer_play_show("vin_player_ics_hologram", { ics_player = this_activator});
	--end
	--SleepUntil( [| not pup_is_playing(g_comp_holo)  ],1);
	--Sleep(60);
		print("gb_tech_halogram_activate");
		gb_tech_halogram_activate = true;
		device_set_power( OBJECTS.dc_tech_halogram, 0 );
		CreateThread(audio_assault_thread_up_activate_hologram);
		CreateThread(audio_activate_hologram);
		interpolator_start(  "w4_tech_center" );
end


function f_halogram_activated()
	print("hellow world");

end

function test_hologram(  ) 
	
	composer_play_show("vin_player_ics_hologram");

	
end

function f_tc_bump_forward()
		f_volume_teleport_all_not_inside(VOLUMES.tv_tc_ship_exit_begin ,FLAGS.fl_tc_ship_diag);
		--device_set_position( OBJECTS.dm_tc_entrance_door , 0 );
		--Sleep(2);
		object_create( "cr_tech_door_blocker" );
		device_set_power( OBJECTS.dm_tc_entrance_door , 0);
		SleepUntil([| device_get_position(OBJECTS.dm_tc_entrance_door) == 0 ] ,1 );
			--print("dont sneak away from me");
			f_volume_teleport_all_not_inside(VOLUMES.tv_tc_ship_exit_begin ,FLAGS.fl_tc_ship_diag);

end

function f_tc_diag_complete()
	SleepUntil( [| gb_tech_halogram_activate  ],1);

		
		--CreateThread( f_player_area_text , "Beep, boop, beep, ship diagnostics gained");

		sleep_s(3.5);
		f_tc_bump_forward();
		--zone_set_trigger_volume_enable( "begin_zone_set:zs_02" , true );

		
		--CreateThread( f_assault_blip_wrapper, FLAGS.fl_elevator_trans , VOLUMES.tv_tc_ship_exit_begin, VOLUMES.tv_main_elevator );
		--f_blip_object( OBJECTS.dc_tech_elevator, "default" );
		--CreateThread( f_player_area_text , "Use the Elevator to get to the Shipyard");
		--f_unblip_object(OBJECTS.dc_tech_halogram);
		sleep_s(5);
		device_set_power( OBJECTS.dm_tc_exit_door, 1 );
		device_set_position( OBJECTS.dm_tc_exit_door, 1 );
		--Sleep(5);
		
		
		
		
		
		sleep_s(4);
		--SleepUntil ([|	PreparingToSwitchZoneSet () == false ], 1);
		--	print("update zone set to shipyard");
				--zone_set_trigger_volume_enable( "zone_set:zs_02" , true );
				
				CreateThread( f_tech_musk_enter_elevator );
				CreateThread( f_tech_musketeer_elevator_hint );
		--SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs_02 ], 1);
		--	print("zone set 2 fully loaded , attempting to save");
			assault_game_save_no_timeout();		
end

function f_activator_tech_elevator(trigger:object, activator:object)

	print("elevator activated");
	CreateThread(audio_elevator_button_press);
	 --RunClientScript("f_cl_halogram_ics", trigger, activator);
	local this_activator:object = activator or PLAYERS.player0 ;
	--if not editor_mode() then
		g_comp_elevator = composer_play_show("vin_player_ics_tech_elevator", { ics_player = this_activator});
	--end
	--SleepUntil( [| not pup_is_playing(g_comp_holo)  ],1);
	--Sleep(60);
		--print("pup down");
	CreateThread( f_elevator_button_switch_mat );
		--device_set_power( OBJECTS.dc_tech_halogram, 0 );

end

function f_elevator_button_switch_mat()

		SleepUntil( [| not pup_is_playing(g_comp_elevator)  ],1);
			--print("done button press");
			--swtiches button to red
			object_set_function_variable (OBJECTS.dm_intro_elevator, "button_active", 1, 1 );
end

global b_musketeer_enter_elevator:boolean = false;

function f_tech_musk_enter_elevator()
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	ai_disable_jump_hint(HINTS.jump_intro_elevator_exit );
	ai_disable_jump_hint(HINTS.jump_intro_elevator_exit01 );
	SleepUntil( [| volume_test_players(  VOLUMES.tv_elevator_musk_enter )  ], 3);
		b_musketeer_enter_elevator = true;
		Sleep(3);
		
		print("elevator obj");
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_elevator_trans01, 0.75);
			end
			sleep_s(2);
		ai_set_objective( AI.musketeer, "obj_tech_blue" );
	SleepUntil( [| b_tech_elevator_open  ], 3);
			ai_enable_jump_hint( HINTS.jump_intro_elevator_exit );
			ai_enable_jump_hint( HINTS.jump_intro_elevator_exit01 );
			ai_set_objective( AI.musketeer, "" );
			MusketeerUtil_SetDestination_Assault_Clear();
end


function f_tech_musketeer_elevator_hint()
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;

		repeat
				b_pos_1_set = false;
				b_pos_2_set = false;
				SleepUntil( [| volume_test_players(  VOLUMES.tv_elevator_musk_pre_enter )  or b_musketeer_enter_elevator ], 1);
					if not b_musketeer_enter_elevator then
						for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
						
							if not b_pos_1_set then
								b_pos_1_set = true;
								MusketeerDestSetPoint(obj, FLAGS.fl_tc_musk_01, 0.5);
									print("pos 1");
							elseif not b_pos_2_set then
								b_pos_2_set = true;
								print("pos 2");
								MusketeerDestSetPoint(obj, FLAGS.fl_tc_musk_02, 1);
							else
									print("pos 3");
									MusketeerDestSetPoint(obj, FLAGS.fl_tc_musk_03, 0.5);
							end
						end
					end
				SleepUntil( [| not volume_test_players_all(  VOLUMES.tv_elevator_musk_pre_enter ) or b_musketeer_enter_elevator ], 1);
					if not b_musketeer_enter_elevator then
						
						MusketeerUtil_SetDestination_Assault_Clear();
						print("cleared goals");
					end
		until b_musketeer_enter_elevator ;
	

end


function f_move_elevator():boolean

	SleepUntil( [| object_valid(  "dm_intro_elevator" ) ], 1);
	object_wake_physics(OBJECTS.dm_intro_elevator);
	 DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 2, "any:door2", 30); --shipyard_exit door
	SleepUntil( [| device_get_position( OBJECTS.dc_tech_elevator ) > 0.1  ], 3); 
		game_save_cancel();  --temp
		g_b_tech_elevator_started = true;
		MusketeersOrderTurnAllOff();
		sleep_s(1.5);
		--object_set_function_variable (OBJECTS.dm_intro_elevator, "button_active", 1, 1 );
	--SleepUntil( [| volume_test_players(  VOLUMES.tv_main_elevator ) and f_assault_wait_for_coop_buddy( VOLUMES.tv_main_elevator ) ], 3);
	--f_assault_wait_for_coop_buddy( VOLUMES.tv_main_elevator );
		--device_set_position( OBJECTS.intro_elevator ,1.0);
		
		--f_unblip_object( OBJECTS.dc_tech_elevator );
		object_destroy( OBJECTS.sn_obj_tech_elevator );
		--object_teleport( spartans()[2] , FLAGS.fl_elevator_trans);
		--sleep_s(1);
		sleep_s(2.5);
		ai_disable_jump_hint(HINTS.jump_intro_elevator_entrance );
		ai_disable_jump_hint(HINTS.jump_intro_elevator_entrance01 );
		f_volume_teleport_all_not_inside(VOLUMES.tv_main_elevator ,FLAGS.fl_elevator_trans);
		f_tech_elevator_close_doors();


		--Sleep(30);
		--switch_zone_set(ZONE_SETS.zs_02);
		sleep_s(2);
		MusketeerUtil_SetDestination_Assault_Clear();
		f_volume_teleport_all_not_inside(VOLUMES.tv_main_elevator ,FLAGS.fl_elevator_trans);
		ai_set_objective( AI.musketeer, "obj_tech_blue" );
		-----device_set_position_track(OBJECTS.dm_intro_elevator, "device:position", 0);
		----DeviceSetLayerAnimation (OBJECTS.dm_intro_elevator, 3, "device:position");
	
		----DeviceSetLayerRate(OBJECTS.dm_intro_elevator, 3, 30);
	
		---DeviceSetLayerPlaybackStop(OBJECTS.dm_intro_elevator, 3);

		-----device_animate_position( OBJECTS.dm_intro_elevator ,1.0, 25, 0.1, 0 , true );
		DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 3, "device:position");
		
		CreateThread(audio_elevator_start);
		--DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 0, "device:position", 60 * 20);
		--sleep_s(3);
		--object_teleport( spartans()[2] , FLAGS.fl_elevator_trans04);
			--	sleep_s(1);
		--f_volume_teleport_all_inside(VOLUMES.tv_main_elevator ,FLAGS.fl_elevator_trans04);
		--SleepUntil( [| volume_test_players(  VOLUMES.tv_elevator_chapter_title ) ], 1);	
			--CreateThread( f_chapter_title,TITLES.ch_assault_2); 
		--SleepUntil( [| device_get_position(  OBJECTS.dm_intro_elevator) == 1  ], 1);
		sleep_s(25.0);
		CreateThread(audio_elevator_stop);
			--print("layer done");
			sleep_s(2.5);
			f_tech_elevator_open_exit();
			
	return true;
end

function f_tech_elevator_close_doors():void


		--device_set_position( OBJECTS.intro_elevator ,1.0);
		
	--	device_set_position_track(OBJECTS.dm_intro_elevator, "device:position", 0);
	--	device_animate_position( OBJECTS.dm_intro_elevator ,1.0, 20, 0.1, 0 , true );
	--DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 1, "device:position", 30);
	print("close elevator door");
	CreateThread(audio_elevator_door_close);
	DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 1, "any:door1", 30);  --tech center entrance door
	
	--Sleep(63);

end

function f_tech_elevator_open_exit():void

	print("open elevator exit");
	CreateThread(audio_elevator_door_open);
	CreateThread(audio_assault_thread_up_elevator_end);
		--device_set_position( OBJECTS.intro_elevator ,1.0);
		

	--	device_set_position_track(OBJECTS.dm_intro_elevator, "device:position", 0);
	--	device_animate_position( OBJECTS.dm_intro_elevator ,1.0, 20, 0.1, 0 , true );
	--DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 1, "device:position", 30);
	--DeviceLayerPlayAnimation(OBJECTS.dm_intro_elevator, 2, "any:door2", 30); --shipyard_exit door

		DeviceSetLayerAnimation(OBJECTS.dm_intro_elevator, 2, "any:door2");
	--	DeviceSetLayerPlaybackStop(OBJECTS.dm_intro_elevator, 0);
		DeviceSetLayerDest(OBJECTS.dm_intro_elevator, 2, 0);
		DeviceSetLayerRate(OBJECTS.dm_intro_elevator, 2, 30);
		--DeviceSetLayerPos(OBJECTS.dm_intro_elevator, 2, 0);
		sleep_s( 3 );
		MusketeersOrderTurnAllOn();
		b_tech_elevator_open = true;
end

--## CLIENT

function f_cl_halogram_ics()

end