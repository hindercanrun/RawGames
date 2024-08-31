--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- Escape Flight
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------

global n_intro_objcon:number = 0;
global n_intro_set:number = 0;
global b_intro_halls_fight_begin:boolean = false;
global b_intro_halls_fight_end:boolean = false;
global b_intro_goal_done:boolean = false;
global b_intro_halls_done:boolean = false;
global gb_intro_route_switch:boolean = false;

AssaultOnTheStation.goal_intro_halls = 

{
	gotoVolume = VOLUMES.tv_intro_spawn,
	zoneSet = ZONE_SETS.zs_01,
	next={"goal_intro_halls_fight"},

}

AssaultOnTheStation.goal_intro_halls_fight = 

{
	gotoVolume = VOLUMES.tv_tc_ship_goal,
	zoneSet = ZONE_SETS.zs_01,
	next={"goal_tech_center"},

}

function blink_start()
	ai_erase_all();
	NarrativeQueue.Kill();
	CreateThread(audio_assault_stopallmusic);
	GoalBlink(AssaultOnTheStation, "goal_intro_halls", FLAGS.fl_assault_start);
	f_blink_clear_blips();
	
end

function blink_intro()
	ai_erase_all();
	NarrativeQueue.Kill();
	CreateThread(audio_assault_stopallmusic);
	GoalBlink(AssaultOnTheStation, "goal_intro_halls_fight", FLAGS.fl_intro_01);
	f_blink_clear_blips(); 
	
end

function blink_intro_inside()
	ai_erase_all();
	NarrativeQueue.Kill();
	CreateThread(audio_assault_stopallmusic);
	GoalBlink(AssaultOnTheStation, "goal_intro_halls_fight", FLAGS.fl_intro_05);
	
	
end

function AssaultOnTheStation.goal_intro_halls.Start() :void    


	SleepUntil( [|  b_assault_intro_cin_done ], 1 );
		
		print("Intro Halls init");
		
		CreateThread(audio_assault_thread_up_mission_start);
		object_create( "sn_intro_blast_door" );
		if not editor_mode() then
			--gmu 8/12/2015 - OSR-146611 -- removing these and putting them just after the cinema ends
			--f_assault_move_to_starting_locations();
			prepare_to_switch_to_zone_set( ZONE_SETS.zs_01 );
			
		else
			--CreateThread( f_assault_move_to_starting_locations );
			sleep_s(1);
		end
		player_control_fade_in_all_input(1);
		--CreateThread( f_intro_set_controller );
		CreateThread( f_intro_musketeer_detour_hint );
		Wake( dormant.tv_nar_entry_point );   -- NARRATIVE
		
		
		Sleep(5);
			-- HACK: Fix for press demo
		--fade_in (0, 0, 0, 0);
		assault_game_save_no_timeout();
		CreateThread( f_intro_cinematic_bars );
		CreateThread( f_intro_breadcrumbs );
		sleep_s( 8 );
		CreateThread( f_assault_update_weapon_profile_post_start );	
		CreateThread( remember_back_when );

		
end

function AssaultOnTheStation.goal_intro_halls.End() :void 
	ai_set_objective( AI.musketeer, "" );
	b_intro_halls_done = true;
end   

function AssaultOnTheStation.goal_intro_halls.Cleanup() 
		--print("--------END INTRO HALLS GOAL ---------------");
		b_intro_goal_done = true;
		b_intro_halls_done = true;
end


function AssaultOnTheStation.goal_intro_halls_fight.Start() :void    

		print("Intro Halls fight init");
		zone_set_trigger_volume_enable( "begin_zone_set:zs_02" , false );
		zone_set_trigger_volume_enable( "zone_set:zs_02" , false );
		b_intro_goal_done = true;
		Wake( dormant.f_intro_spawn_enemies );

		CreateThread( f_intro_bump_forward );
		CreateThread( f_intro_objcon_controller );
		CreateThread( f_intro_grunt_room_door );
		
		if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
			CreateThread( f_assault_volume_dislay_tutorial_setup,  VOLUMES.tv_intro_objcon_10, "training_rearmelee",TUTORIAL.Assassination ,5 );
		end
		
		GoalCreateThread( AssaultOnTheStation.goal_intro_halls_fight, f_assault_volume_tutorial_setup, VOLUMES.tv_intro_crouch_tut, "training_crouch", TUTORIAL.Crouch, true );
		
		Sleep(5);
		assault_game_save_no_timeout();
		
		
		sleep_s( 8 );
		CreateThread( f_assault_update_weapon_profile_post_start );	

end

function AssaultOnTheStation.goal_intro_halls_fight.End() :void 
	ai_set_objective( AI.musketeer, "" );
end   

function f_intro_halls_mark_tech_center()

	sleep_s( 8 );
	if not b_intro_goal_done then
		--CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 5 );
		--CreateThread( f_assault_ping_tutorial_all_setup,  "training_objective", "training_chief_ping_01" );
			for i, p_player in ipairs( players() ) do
			 	f_assault_ping_tutorial(p_player, "training_objective", "training_chief_ping_01");	
			end
	end
end


--function f_assault_ping_tutorial_all_setup( tutorial_string_id:string, blocking_id:string )

--	for i, p_player in ipairs( players() ) do
--		 f_assault_ping_tutorial(p_player, tutorial_string_id, "training_chief_ping_01");	
--	end

--end


function f_assault_ping_tutorial( p_player:object, tutorial_string_id:string, blocking_id:string)

	 	TutorialShowStartDelayed(unit_get_player(p_player), tutorial_string_id, blocking_id, 10 ,0);	
	 	sleep_s(10);
	--	SleepUntil([| b_intro_goal_done  ], 1);
		TutorialStopAndMark(unit_get_player(p_player ), blocking_id);

end

function f_intro_breadcrumbs()
	print("bread crumbs");
	object_create( "sn_obj_intro_balcony" );
	
	SleepUntil( [| volume_test_players(  VOLUMES.tv_intro_balcony_entrance )  ], 1);
		object_destroy( OBJECTS.sn_obj_intro_balcony );
		Sleep(5);
		object_create( "sn_obj_intro_room" );
	SleepUntil( [| volume_test_players(  VOLUMES.tv_intro_objcon_10 )  ], 1);
		object_destroy( OBJECTS.sn_obj_intro_room );
		Sleep(5);
		object_create( "sn_obj_tech_holo" );	
end

function f_intro_cinematic_bars()

		f_chapter_title(TITLES.ch_assault_1); 
end

global test_object1:object = nil;
global test_object2:object = nil;
global test_object3:object = nil;

function dormant.f_intro_spawn_enemies()

		assault_game_save_no_timeout();
		Sleep(3);
		--ai_place( AI.sg_intro_all );
		ai_place( AI.sq_intro_command );
		Sleep(1);
		ai_place( AI.sq_intro_elite_01 );
		ai_place( AI.sq_intro_elite_02 );		
		Sleep(1);
		ai_place( AI.sq_intro_grunt_crates );

		ai_place( AI.sq_intro_grunt_reserve );
		Sleep(1);
		ai_place( AI.sq_intro_jackal_01 );					
		Sleep(3);

		composer_play_show("vin_global_prebattle_grunts");
end

function f_intro_musketeer_detour_hint()
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	if not game_is_cooperative() then
		repeat
	
				SleepUntil( [| volume_test_players(  VOLUMES.tv_intro_detour )  ], 1);
					for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					
						if not b_pos_1_set then
							b_pos_1_set = true;
							MusketeerDestSetPoint(obj, FLAGS.fl_intro_detour_01, 1);
						elseif not b_pos_2_set then
							b_pos_2_set = true;
							MusketeerDestSetPoint(obj, FLAGS.fl_intro_detour_02, 1);
						else
								MusketeerDestSetPoint(obj, FLAGS.fl_intro_detour_03, 1);
						end
					end
				SleepUntil( [| not volume_test_players(  VOLUMES.tv_intro_detour )  ], 1);
					MusketeerUtil_SetDestination_Assault_Clear();
		until b_intro_halls_done;
	end

end



function f_intro_grunt_room_door()
	SleepUntil( [| volume_test_players(  VOLUMES.tv_intro_grunt_room_door ) or ai_combat_status(AI.sg_intro_all) > 3 ], 1);
				device_set_power( OBJECTS.dm_intro_grunt_room_door, 1 );
end

function f_intro_combat_status()

	SleepUntil( [| ai_combat_status(AI.sg_intro_all) > 3 ] ,1 );
		print("combat alert");
		ai_set_objective( AI.musketeer, "" );
		MusketeerUtil_SetDestination_Assault_Clear();
end



function f_intro_objcon_controller()
	CreateThread( f_intro_combat_status );
	print("intro objcon setup");
	n_intro_objcon = 1;
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_10 )  ], 1);--or n_intro_objcon >= 10
		if n_intro_objcon <= 10 then
			n_intro_objcon = 10;
			print("n_intro_objcon = 10 ?");
		end
		b_intro_halls_fight_begin = true;
		if ai_combat_status(AI.sg_intro_all) <= 3 then
			print("set blue");
			ai_set_objective( AI.musketeer, "obj_intro_blue" );
			f_assault_set_musketeer_goal( FLAGS.fl_intro_grunt_room);
		end
		Sleep(5);
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_20 ) or n_intro_objcon >= 20 ], 1);
		if n_intro_objcon <= 20 then
			n_intro_objcon = 20;
			print("n_intro_objcon = 20 ");
		end
		ai_set_objective( AI.musketeer, "" );
		MusketeerUtil_SetDestination_Assault_Clear();
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_30 ) or n_intro_objcon >= 30 ], 1);
		if n_intro_objcon <= 30 then
			n_intro_objcon = 30;
			print("n_intro_objcon = 30 ");
		end			
		--print("Creating tech blip");

	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_40 ) or n_intro_objcon >= 40 ], 1);
		if n_intro_objcon <= 40 then
			n_intro_objcon = 40;
			print("n_intro_objcon = 40 ");
		end


	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_45 ) or n_intro_objcon >= 45 ], 1);
		if n_intro_objcon <= 45 then
			n_intro_objcon = 45;
			print("n_intro_objcon = 45 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_objcon_50 ) or n_intro_objcon >= 50 ], 1);
		if n_intro_objcon <= 50 then
			n_intro_objcon = 50;
			print("n_intro_objcon = 50 ");
		end			
end




function f_intro_bump_forward()
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_load_next ) ], 1);	
		print("bump forward");
		f_volume_teleport_all_not_inside(VOLUMES.tv_intro_all , FLAGS.fl_intro_bump_forward);
		device_set_position_immediate( OBJECTS.dm_intro_main_entrance , 1);
		Sleep(1);
		device_set_power( OBJECTS.dm_intro_main_entrance , 0);
		SleepUntil([| device_get_position(OBJECTS.dm_intro_main_entrance) == 0 ] ,1 );

			f_volume_teleport_all_not_inside(VOLUMES.tv_intro_all ,FLAGS.fl_intro_bump_forward);

end


function remember_back_when()

	SleepUntil ([| not b_shipyard_begin and object_get_health(OBJECTS.cr_remember_back_when_activate) <= 0  ], 1);
		print("create point");
		CreateEffectGroup(EFFECTS.fx_remember_back_when_activate);
		object_create( "cr_remember_back_when" );
		Sleep(5);
	SleepUntil ([| not b_shipyard_begin and object_get_health( OBJECTS.cr_remember_back_when ) <= 0 ], 1);
		if not b_shipyard_begin then
			print("DINNNG");
			SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
			CreateEffectGroup(EFFECTS.fx_remember_back_when);
			sleep_s(2);
			flock_create("aiflock_intro_banshees01");		
		end
end



function cs_jackal_patrol()

	cs_abort_on_alert( true );
	cs_abort_on_damage( true );
	
	SleepUntil( [| device_get_position(OBJECTS.dm_intro_stealth_door) > 0 or device_get_position(OBJECTS.dm_intro_grunt_room_door) > 0 or n_intro_objcon >= 30 ] ,1 );
	

		if gb_intro_route_switch then
				repeat
					--print("as;ldfkja");
					cs_go_to( ai_current_actor, true, POINTS.ps_intro_halls.p0, 2);
					sleep_rand_s(1.5, 2.5);
					cs_go_to( ai_current_actor, true, POINTS.ps_intro_halls.p02, 2);
					sleep_rand_s(1.5, 2.5);
				until false;
		else
			gb_intro_route_switch = true;
				repeat
					cs_go_to( ai_current_actor, true, POINTS.ps_intro_halls.p01, 2);
					sleep_rand_s(1.5, 2.5);
					cs_go_to( ai_current_actor, true, POINTS.ps_intro_halls.p03, 2);
					sleep_rand_s(1.5, 2.5);	
				until false;
		end
				

end


function cs_grunt_flee_intro()
		
		for i, grunt in ipairs( ai_actors(ai_current_actor) ) do 

			if grunt == ai_get_object( AI.sq_intro_grunt_scavenge.aisquadspawnpoint01 )  then
				cs_abort_on_damage( true );
				print("go little fella");
				
				cs_go_to( ai_current_actor, true,  POINTS.ps_intro_halls.p06 , 1);
				cs_go_to( ai_current_actor, true,  POINTS.ps_intro_halls.p07 , 1);
				CreateThread( f_grunt_flee_intro_clear_watcher,  AI.sq_intro_grunt_scavenge.aisquadspawnpoint01 );
				cs_go_to( ai_current_actor, true,  POINTS.ps_intro_halls.p04 , 1);
				cs_go_to( ai_current_actor, true,  POINTS.ps_intro_halls.p05 , 2);				
			end
		end
end

function f_grunt_flee_intro_clear_watcher(grunt:ai)
	SleepUntil ([| volume_test_players ( VOLUMES.tv_intro_side_tunnel_booth_near ) or n_intro_objcon >= 30 ], 1);
		cs_run_command_script(grunt, "cs_grunt_intro_clear" );
end

function cs_grunt_intro_clear()
	print("clear grunt");
end

function f_intro_cleanup()
	print("intro halls cleanup");
	ai_erase( AI.sg_intro_all );
	object_destroy_folder("crs_intro");
	object_destroy_folder("dm_intro");	
	object_destroy_folder("wpns_intro");
	--object_destroy_folder("sn_intro");
	
end