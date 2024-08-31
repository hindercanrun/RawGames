--## SERVER

--Owner: 
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCONFIRMED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- CAVALIER BATTLE
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------

global n_cav_objcon:number = 0;
global gb_cav_fight_begin:boolean = false;
global n_cav_spawn_stage:number = 0;
global gb_cav_fight_finished:boolean = false;
global gb_cav_debug_solo:boolean = false;
global gb_cav_nudge_back_hint:boolean = false;
global gb_cav_somebody_has_the_boomer:boolean = false;

--[[
   ______            __        ___                         
  / ____/___  ____ _/ /  _    /   |  ________  ____  ____ _
 / / __/ __ \/ __ `/ /  (_)  / /| | / ___/ _ \/ __ \/ __ `/
/ /_/ / /_/ / /_/ / /  _    / ___ |/ /  /  __/ / / / /_/ / 
\____/\____/\__,_/_/  (_)  /_/  |_/_/   \___/_/ /_/\__,_/  
                                                           
                                                                                                                                                          
--]]            

UnconfirmedReports.goal_arena = 
{
	--ends the goal
	--gotoVolume = VOLUMES.tv_ur_mission_end,
	
	--this is the next goal name
	next={"goal_exit"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs040_bridge_arena,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_bridgearena,
}

function BlinkArena()
	--print ("Blinking to Bridge Arena");
	--map_reset();
	GoalBlink (UnconfirmedReports, "goal_arena", FLAGS.fl_cav_blinkarena);
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

function BlinkCavSolo()
	--print ("Blinking to Bridge Arena");
	--map_reset();
	gb_cav_debug_solo = true;
	n_cav_spawn_stage = 3;
		Sleep(1);
	GoalBlink (UnconfirmedReports, "goal_arena");
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

function UnconfirmedReports.goal_arena.Start() :void            
	f_uncon_forerunner_profile_set();
	game_save_no_timeout();
	CreateThread(nar_unconfirmed_cavalier_room);
	CreateThread(f_ur_breadcrumbs_cav_arena);
	sleep_s(1);
	if object_valid("s_ur_breadcrumb_01") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end

	--START CAVALIER EVENTS
	SleepUntil([|volume_test_players(VOLUMES.tv_cav_init)  and current_zone_set_fully_active() == ZONE_SETS.zs040_bridge_arena ], 1);
	CreateThread(nar_cinematic_01_start);
	device_set_power(OBJECTS.dm_ur_door_02, 1);
	Sleep(1);
	device_set_position(OBJECTS.dm_ur_door_02, 1);
	interpolator_start("bridgearena_lightbridge_01");
	SleepUntil([|device_get_position (OBJECTS.dm_ur_door_02) >= .45], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_ur_door_02, false);
	--sleep_s(0.25);
	MusketeerUtil_SetDestination_Clear_All();
	
	fade_out( 0, 0, 0, 60 );
	object_destroy(OBJECTS.s_ur_breadcrumb_09_5);
	
	sleep_s(1.25);
	object_destroy(OBJECTS.dm_ur_door_03);
	player_enable_input( false );
	setLightingVariant("cinematic");
	CreateThread(audio_unconfirmedreports_thread_up_elevator_outro);
	sleep_s(1);
	
	CinematicPlay ("cin_090_door");
	
	Sleep(5);
	CreateThread(f_ur_warden_cine_set_object);

	game_save_no_timeout();
	sleep_s(1);
	
	CreateThread(w1_uncon_cavalier_fight_init);
		
	f_ur_lava_cleanup();
	f_cav_teleport_players();
	gb_cav_fight_begin = true;
	object_create_anew("cin_guardian");
	object_create_anew("cin_pedestal_a");
	object_create_anew("cin_cover_a");
	object_create_anew("cin_cover_b");
	sleep_s(1);
	f_cav_strip_shields();
	interpolator_start ("bridgearena_lightbridge_01");
	setLightingVariant("gameplay");
	object_create_anew("dm_ur_door_03");
	fade_in( 0, 0, 0, 60 );
	ObjectSetSpartanTrackingEnabled(ai_get_object (AI.sq_cav_cavalier), true);
	ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ur_cav_cannon, true);
	CreateThread(f_ur_kill_inc_cannon_icon);
	player_enable_input( true );
	
	sleep_s(3);
	
	CreateThread(f_ur_cav_tutorial);
		
	--ENABLE DOOR WHEN CAVALIER IS KILLED
	SleepUntil([| ai_spawn_count( AI.sq_cav_cavalier) > 0 and ai_living_count( AI.sq_cav_cavalier ) <= 0 ], 1);
		print("Cavalier dead 1");
		CreateThread(audio_unconfirmedreports_thread_up_wardenfight_outro);
		sleep_s(1);
		--RunClientScript( "cav_cav_death_fx", AI.sq_cav_cavalier);
		rumble_shake_small();
		f_cav_death( AI.sg_cav_all);
		gb_cav_fight_finished = true;
		
		sleep_s(3);
		warden_combat_complete = true;
		GoalComplete(UnconfirmedReports.goal_arena);
		sleep_s(2);
		--f_blip_flag ( FLAGS.flag_guardian_door, "default" );
		--print ("guardian vignette starts playing");
		--composer_play_show ("vin_w1_unconfirmed_reports_guardian_motion");
		SleepUntil([|b_ur_warden_chatter_done == true], 1);
	
		SleepUntil([| volume_test_players(VOLUMES.tv_ur_guardian_door) ], 1);
		object_dissolve_from_marker(OBJECTS.dm_ur_door_03, "hard_kill", "");
		--CreateThread(audio_door_derez);
		sleep_s(3);
		object_destroy(OBJECTS.dm_ur_door_03);
		ObjectOverrideNavMeshCutting(OBJECTS.dm_ur_door_03, false);
end

function f_ur_warden_cine_set_object():void
	scenery_animation_start_at_frame(OBJECTS.cin_guardian, TAG('compositions\cinematics\cin_090_door\objects\door_010_bridge\cin_guardian.model_animation_graph'), "bridge_210", 0);
	pause_animation_on_object(OBJECTS.cin_guardian);
	scenery_animation_start_at_frame(OBJECTS.cin_cover_a, TAG('compositions\cinematics\cin_090_door\objects\door_010_bridge\cin_cover_a.model_animation_graph'), "bridge_220", 53);
	pause_animation_on_object(OBJECTS.cin_cover_a);
	scenery_animation_start_at_frame(OBJECTS.cin_cover_b, TAG('compositions\cinematics\cin_090_door\objects\door_010_bridge\cin_cover_b.model_animation_graph'), "bridge_220", 53);
	pause_animation_on_object(OBJECTS.cin_cover_b);
	scenery_animation_start_at_frame(OBJECTS.cin_pedestal_a, TAG('compositions\cinematics\cin_090_door\objects\door_010_bridge\cin_cover_b.model_animation_graph'), "bridge_210", 107);
	pause_animation_on_object(OBJECTS.cin_pedestal_a);
end

function f_ur_kill_inc_cannon_icon()
	repeat
		for _ , player in pairs (players()) do
			if unit_has_weapon(player, TAG('\objects\weapons\support_high\incineration_cannon\incineration_cannon.weapon')) then
				ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ur_cav_cannon, false);
				gb_cav_somebody_has_the_boomer = true;
			end
		end
		sleep_s(0.1);
	until gb_cav_somebody_has_the_boomer == true;
end

function f_ur_cav_tutorial():void
	TutorialShowAll("training_orders_target", 5);
	sleep_s(15);
	TutorialStopAll();
end

-----adding this becuase all dudes take damage when falling down with lava elevator. KS
--function f_ur_lava_temp_invul_off(spartan:object):void
--	unit_falling_damage_disable(spartan, false);
--	object_can_take_damage(spartan);
--end

function f_cav_setup_nook_watchers()
	for _, playa in ipairs ( players() ) do
		print(playa);
		CreateThread( f_cav_nook_watcher_a, playa );
		CreateThread( f_cav_nook_watcher_b, playa );
	end
end

function f_cav_nook_watcher_a( sparts:player )
	local l_timer:number = 0;
	local b_flush:boolean = false;
	repeat
		SleepUntil([| volume_test_object(VOLUMES.tv_cav_nook_a , sparts) ], 1);
				l_timer = timer_stamp( 15 );
				print("player in nook a ", sparts);	
		SleepUntil([| not volume_test_object(VOLUMES.tv_cav_nook_a , sparts ) or timer_expired( l_timer ) ], 1);
				if timer_expired( l_timer ) then
					b_flush = true;
					ai_place_with_slip_space( AI.sq_cav_soldiers_06_nook_a );
					print("flush player nook a");
					sleep_s(10);
					SleepUntil([| ai_living_count(AI.sq_cav_soldiers_06_nook_a) <= 0 ] ,1 );
				else
					--print("player exits nook a ", sparts);	
				end
				sleep_s(0.167);
	until gb_cav_fight_finished;
end

function f_cav_nook_watcher_b(sparts:player)
	local l_timer:number = 0;
	local b_flush:boolean = false;
	
	repeat
		SleepUntil([| volume_test_object(VOLUMES.tv_cav_nook_b , sparts) ], 1);
				l_timer = timer_stamp( 15 );
				print("player in nook b ", sparts);	
		SleepUntil([| not volume_test_object(VOLUMES.tv_cav_nook_b , sparts ) or timer_expired( l_timer ) ], 1);
				if timer_expired( l_timer ) then
					b_flush = true;
					ai_place_with_slip_space( AI.sq_cav_soldiers_07_nook_b);
					print("flush player nook b");
					sleep_s(10);
					SleepUntil([| ai_living_count(AI.sq_cav_soldiers_07_nook_b) <= 0 ] ,1 );
				else
					--print("player exits nook b ", sparts);	
				end
				sleep_s(0.167);
	until gb_cav_fight_finished;

end

function f_cav_nook_flush_a()
	
end

function f_cav_nook_flush_b()
	
end

function f_cav_strip_shields()
	for _,spartan in ipairs (spartans()) do
		object_set_shield_stun( spartan, 5 );
		object_set_shield(spartan, 0);
	end
end

function f_cav_teleport_players()
		print("teleporting players");
		--teleport_player_to_flag (PLAYERS.player0, FLAGS.fl_cav_start_01, false);
	--teleport_player_to_flag (PLAYERS.player1, FLAGS.fl_cav_start_02, false);
		--teleport_player_to_flag (PLAYERS.player2, FLAGS.fl_cav_start_03, false);
		--teleport_player_to_flag (PLAYERS.player3, FLAGS.fl_cav_start_04, false);
		--object_teleport( spartan , fl);
		
	--ai_place(AI.sq_cav_crawlers_00);  -- warden will fake summon during vignette
	--SlipSpaceSpawn( AI.sq_cav_crawlers_00);
	for i,spartan in ipairs( spartans() ) do
		local flagah:string = "fl_cav_start_0" .. i ;
		print(i ,"  ", flagah );
		object_teleport( spartan , FLAGS[flagah]);
	end
end

function w1_uncon_cavalier_fight_init()
	print("BEGIN: Cav encounter");  
	---ai_place( AI.sq_cav );
	---ai_place( AI.sq_prime );
	game_save_no_timeout();
	--SleepUntil( [| volume_test_players(VOLUMES.tv_cav_init )  ],1);

	SleepUntil( [| volume_test_players(VOLUMES.tv_cav_fight_begin ) and gb_cav_fight_begin ],1);
		print("Begin Cav Fight");
		CreateThread(audio_unconfirmedreports_thread_up_wardenfight_start);
		Wake( dormant.f_uncon_cav_objcon_controller );
		CreateThread( f_cav_setup_nook_watchers );
		if  gb_cav_debug_solo then
			print("debug cav solo");
			ai_place( AI.sq_cav_cavalier );
		else
			composer_play_show("vin_w1_un_reports_warden_intro");
			sleep_s(2);
			
			SlipSpaceSpawn( AI.sq_cav_crawlers_00);
			CreateThread( w1_uncon_cav_spawn_manager );
		end
		--CreateThread( w1_uncon_cav_incin_watcher );
end

function w1_uncon_cav_spawn_manager()
	print("spawnzonr");
	local l_timer:number = 0;

	-------------
	-- STAGE 1
	-------------
	--CreateThread( SlipSpaceSpawn, AI.sq_cav_crawlers_00 );
	--CreateThread(f_cav_ground_effect, AI.sq_cav_crawlers_00, "dc_spawner_spawn_gate_00"  );
	--ai_place_with_slip_space(AI.sq_cav_crawlers_00);
	--sleep_s(2);
	n_cav_spawn_stage = 1;
	SleepUntil( [| ai_spawn_count(AI.sq_cav_crawlers_00) > 0 and ai_living_count( AI.sq_cav_crawlers_00 ) <= 1],1);
		--CreateThread(f_cav_ground_effect, AI.sg_cav_snipers_wave_01, "dc_spawner_spawn_gate_01"  );
		
		if coop_players_4() and game_difficulty_get_real() == DIFFICULTY.legendary then
			ai_place_with_slip_space(AI.sg_cav_snipers_wave_01);
		elseif coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then
			if  volume_test_players(VOLUMES.tv_cav_high_ground ) then
				print("spawn high ground");				
				ai_place_with_slip_space(AI.sq_cav_soldiers_04_high);
			else
				print("low ground");
				ai_place_with_slip_space(AI.sq_cav_soldiers_04);
			end
			
		end
		
		
		--CreateThread(f_cav_ground_effect, AI.sq_cav_snipers_02, "dc_spawner_spawn_gate_02"  );
		--ai_place_with_slip_space(AI.sq_cav_snipers_02);
		sleep_s( 10 );
		l_timer = timer_stamp( 10 );
	print("stage 0  spawned");
	SleepUntil ([| 	ai_spawn_count (AI.sg_cav_snipers_wave_01) > 0 or
									ai_spawn_count (AI.sg_cav_spawn_01) > 0 or timer_expired(l_timer)], 1);
		--sleep_s( 5 );
		l_timer = timer_stamp( 60 );
	SleepUntil( [| ( ai_living_count( AI.sg_cav_snipers ) <= 0  and ai_living_count( AI.sg_cav_soldiers ) <= 0 and ai_living_count( AI.sq_cav_crawlers_00 ) <= 1 ) or timer_expired(l_timer) ],1);
		
		sleep_s(20);
		
	if coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then
		print("spawnin soldiers");
		--ai_place_with_slip_space(AI.sg_cav_soldiers_wave_01);
		ai_place_with_slip_space(AI.sq_cav_soldiers_01);
		ai_place_with_slip_space(AI.sq_cav_soldiers_02);
	
		SleepUntil ([| 	ai_spawn_count( AI.sq_cav_soldiers_01 )> 0 and 
										ai_spawn_count( AI.sq_cav_soldiers_02 )> 0 ], 1);
	end -- end xtra for coop or legendary
		
		print("stage 1  spawned");
		n_cav_spawn_stage = 2;
	SleepUntil ([| 	ai_living_count (AI.sg_cav_soldiers) <= 2 ] , 1 );
		--CreateThread(f_cav_ground_effect, AI.sq_cav_crawlers_01, "dc_spawner_spawn_gate_06"  );	
		ai_place_with_slip_space(AI.sq_cav_crawlers_01);
		l_timer = timer_stamp( 10 );
	SleepUntil ([| 	ai_spawn_count (AI.sq_cav_crawlers_01) > 0 or timer_expired(l_timer) ], 1 );	
		print("stage 2  spawned");
		--n_cav_spawn_stage = 2; 
	gb_cav_nudge_back_hint = true;
	l_timer = timer_stamp( 45 );
	SleepUntil ([| 	ai_living_count (AI.sg_cav_minions) >= 1  or timer_expired(l_timer) ], 1 );	
		sleep_s( 15 );

		if coop_players_4() and game_difficulty_get_real() == DIFFICULTY.legendary then
			ai_place_with_slip_space(AI.sg_cav_snipers_wave_02);
		elseif  coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then
			if  volume_test_players(VOLUMES.tv_cav_high_ground ) then
				print("spawn high ground");				
				ai_place_with_slip_space(AI.sq_cav_soldiers_05_high);
			else
				print("low ground");
				ai_place_with_slip_space(AI.sq_cav_soldiers_05);
			end	
		else
			if  volume_test_players(VOLUMES.tv_cav_high_ground ) then
				print("spawn high ground");				
				ai_place_with_slip_space(AI.sq_cav_crawlers_04_high);
			else
				print("low ground");
				ai_place_with_slip_space(AI.sq_cav_crawlers_04);
			end	
		
		end	
		
		l_timer = timer_stamp( 15 );
	SleepUntil ([| 	ai_spawn_count (AI.sg_cav_snipers_wave_02) > 0 or 
									ai_spawn_count (AI.sg_cav_spawn_02) > 0 or timer_expired(l_timer) ], 1);		
				print("___stage 3  spawned");
				n_cav_spawn_stage = 3; 
	CreateThread( f_uncon_cav_spawner_filler );
end

function f_uncon_cav_spawner_filler()
	local l_timer:number = 0;
	local n_cav_repeat_spawn_count = 0;
	repeat
		Sleep(1);
		if   ( game_is_cooperative() or game_difficulty_get_real() == DIFFICULTY.legendary ) then
			l_timer = timer_stamp( 20, 30 );
		else
			l_timer = timer_stamp( 30, 45 );
		end
		
		SleepUntil ([| 	ai_living_count ( AI.sg_cav_minions ) <= 0 and timer_expired(l_timer) ], 1 );	
			print("spawning fillers");
			--if ( ai_living_count( AI.sq_cav_cavalier ) > 0 ) then

		--	end
			
			if not  ( game_is_cooperative() or game_difficulty_get_real() == DIFFICULTY.legendary  )then
				sleep_rand_s( 40, 60 );
			end
			
			if   ( coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary ) then
				if ( ai_living_count( AI.sq_cav_cavalier ) > 0 ) then
						print("game is tough");
						ai_place_with_slip_space(AI.sq_cav_soldiers_03);
				end		
			end
			
			if n_cav_repeat_spawn_count < 3 then
				ai_place_with_slip_space( AI.sq_cav_crawlers_02 );
			end
			
			n_cav_repeat_spawn_count = n_cav_repeat_spawn_count + 1;
		--	n_cav_spawn_stage = n_cav_spawn_stage + 1; 
					--print("filler fighters stage," , n_cav_spawn_stage );
	--until ( ai_living_count( AI.sq_cav_cavalier ) <= 0 or n_spawn_count == 2 );
	until (  n_cav_repeat_spawn_count > 8 or gb_cav_fight_finished);
end

function f_uncon_forerunner_profile()
	player_set_profile(STARTING_PROFILES.sp_ur_cav, nil);
	unit_add_equipment(PLAYERS.player0, STARTING_PROFILES.sp_ur_cav, true, false);
	unit_add_equipment(PLAYERS.player1, STARTING_PROFILES.sp_ur_cav, true, false);
	unit_add_equipment(PLAYERS.player2, STARTING_PROFILES.sp_ur_cav, true, false);
	unit_add_equipment(PLAYERS.player3, STARTING_PROFILES.sp_ur_cav, true, false);		
end

function f_uncon_forerunner_profile_set()
	player_set_profile(STARTING_PROFILES.sp_ur_cav, nil);		
end

function f_cav_death( sg:ai)
	sleep_s(1);
	ai_braindead( sg, true );
	--local obj_list:object_list = ai_actors( AI.sg_cav_all );
	for i, forerunner in ipairs( ai_actors( sg ) ) do
		print(forerunner);
		RunClientScript( "cav_minion_death_fx", forerunner);
		rumble_shake_small();
		ai_kill( object_get_ai(forerunner) );
		sleep_rand_s ( 0.25, 0.5);
	end
end

function blink_cav()
	switch_zone_set(ZONE_SETS.zs040_bridge_arena);
	CreateThread(audio_unconfirmedreports_stopallmusic);
	f_uncon_forerunner_profile();
	game_save_no_timeout();
	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs040_bridge_arena ], 1);
	Sleep(1);
	object_create_folder("wpns_cav_arena");
	object_create_folder("crs_cav_arena");
	teleport_player_to_flag (PLAYERS.player0, FLAGS.fl_cav_start_01, false);
	teleport_player_to_flag (PLAYERS.player1, FLAGS.fl_cav_start_02, false);
	teleport_player_to_flag (PLAYERS.player2, FLAGS.fl_cav_start_03, false);
	teleport_player_to_flag (PLAYERS.player3, FLAGS.fl_cav_start_04, false);
	gb_cav_fight_begin = true;
	CreateThread( w1_uncon_cavalier_fight_init );
end

function dormant.f_uncon_cav_objcon_controller()
	print("cav objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_10 ) or n_cav_objcon >= 10 ], 1);
		if n_cav_objcon <= 10 then
			n_cav_objcon = 10;
			print("n_cav_objcon = 10 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_20 ) or n_cav_objcon >= 20 ], 1);
		if n_cav_objcon <= 20 then
			n_cav_objcon = 20;
			print("n_cav_objcon = 20 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_30 ) or n_cav_objcon >= 30 ], 1);
		if n_cav_objcon <= 30 then
			n_cav_objcon = 30;
			print("n_cav_objcon = 30 ");
		end		
	n_cav_spawn_stage = 2;
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_40 ) or n_cav_objcon >= 40 ], 1);
		if n_cav_objcon <= 40 then
			n_cav_objcon = 40;
			print("n_cav_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_50 ) or n_cav_objcon >= 50 ], 1);
		if n_cav_objcon <= 50 then
			n_cav_objcon = 50;
			print("n_cav_objcon = 50 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_60 ) or n_cav_objcon >= 60 ], 1);
		if n_cav_objcon <= 60 then
			n_cav_objcon = 60;
			print("n_cav_objcon = 60 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_70 ) or n_cav_objcon >= 70 ], 1);
		if n_cav_objcon <= 70 then
			n_cav_objcon = 70;
			print("n_cav_objcon = 70 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_80 ) or n_cav_objcon >= 80 ], 1);
		if n_cav_objcon <= 80 then
			n_cav_objcon = 80;
			print("n_cav_objcon = 80 ");
		end		

	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_90 ) or n_cav_objcon >= 90 ], 1);
		if n_cav_objcon <= 90 then
			n_cav_objcon = 90;
			print("n_cav_objcon = 90 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_cav_objcon_100 ) or n_cav_objcon >= 100 ], 1);
		if n_cav_objcon <= 100 then
			n_cav_objcon = 100;
			print("n_cav_objcon = 100 ");
		end
end

function f_cav_ground_effect( ai_spawners:ai, s_effect:string )
	local o_effect:object = nil;
	--ai_place_with_slip_space(ai_spawners);
	o_effect = object_create( s_effect );
	object_cannot_die(o_effect, true);
	local l_timer:number = timer_stamp( 10 );
	SleepUntil ( [| ai_spawn_count ( ai_spawners ) > 0 or timer_expired(l_timer ) ], 1  );
		--sleep_s( 2 );
	object_cannot_die(o_effect, false);
	object_destroy( o_effect );
end

UnconfirmedReports.goal_exit = 
{
	--ends the goal
	gotoVolume = VOLUMES.tv_ur_mission_end,
	
	--this is the next goal name
	--next={"goal_guardian"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs040_bridge_arena,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_bridgeexit,
}

function UnconfirmedReports.goal_exit.End() :void      
	game_save_no_timeout();
	b_unconfirmed_complete = true;
	CreateThread(audio_unconfirmedreports_thread_up_mission_end);
	sleep_s(1);
	CreateThread(audio_cinematic_mute_unconfirmedreports);
	fade_out(0, 0, 0, 60);
	sleep_s(1.25);
	-- switch_zone_set(ZONE_SETS.cin100_evacuation);
	-- SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.cin100_evacuation], 3);
	object_destroy(OBJECTS.cin_guardian);
	
		-- gmu OSR-154356 -- putting players in limbo so they don't fall to their death during the cinematic
	AttachPlayers();
	
	CinematicPlay("cin_100_evacuation");
		
	fade_out( 0, 0, 0, 0 );
	
	--removing this to improve perceived load times - gmu OSR-154356
	--sleep_s(2);
	EndCurrentMission();
end

--attaching players to this object so they don't exit broadphase in arcade mode gmu OSR-154356
function AttachPlayers()
	object_create ("sc_player_attach");
	object_hide (OBJECTS.sc_player_attach, true);
	for _,player in pairs(players()) do
		print ("attaching ", player);
		objects_attach (OBJECTS.sc_player_attach, "", player, "");
	end
end

function f_create_gun()
	print("Creating incinerator");
	--object_create_clone("wp_cav_incin"); --apparently thiscrashes xbone
end

function f_ur_breadcrumbs_cav_arena():void
	SleepUntil([| b_ur_warden_chatter_done == true ], 1);
	sleep_s(1);
	object_create("s_ur_breadcrumb_10");
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_10) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_10);
end

function remoteServer.cinematicZonesetSwitch():void
	switch_zone_set(ZONE_SETS.cin100_evacuation);
end

--## CLIENT

function remoteClient.cav_cav_death_fx( forerunner:object )
	effect_new(TAG('objects\vehicles\forerunner\forerunner_vtol\fx\weapon\vtol_super_detonation.effect'), forerunner);
end

function remoteClient.cav_minion_death_fx( forerunner:object )
	--effect_new(TAG('environments\solo\m10_crash\fx\sparks\spark_burst_falling_medium.effect'), forerunner);
	--effect_new(TAG('objects\gear\human\military\resupply_capsule\derez\phase_out_smoke.effect'), forerunner);  --works
	--effect_new(TAG('objects\characters\knight\fx\phase\phase_in_down.effect'), forerunner);  --works
	effect_new(TAG('objects\vehicles\forerunner\forerunner_vtol\fx\weapon\vtol_super_detonation.effect'), forerunner);
	--CreateThread( camera_shake_all_coop_players, 1, 0.25, 0.25, 1) ;
	--effect_new(TAG('objects\vehicles\covenant\storm_lich\fx\lich_damage\lich_external_smoke.effect'), forerunner);
	--effect_new(TAG('fx\library\characters\cortana\rampancy\rampancy_warp_static.effect.effect'), forerunner);
	--effect_new(TAG('fx\library\sandbox\explosions\covenant_explosion_large\covenant_explosion_large.effect'), forerunner);
	--effect_new_on_object_marker (TAG('objects\gear\human\military\resupply_capsule\derez\phase_out_smoke.effect'), forerunner, "");
	--effect_new_on_object_marker(TAG('environments\solo\m90_sacrifice\fx\explosion\human_explosion_large.effect'),forerunner,"");
	--effect_new_on_object_marker(TAG('fx\library\characters\cortana\rampancy\rampancy_glitch.effect'), forerunner, "");
end

