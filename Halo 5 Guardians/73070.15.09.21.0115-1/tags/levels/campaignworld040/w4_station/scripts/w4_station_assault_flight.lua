--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

global t_flight_reactor_vents:table =
{ 
	"cr_flight_core_engine_01",
	"cr_flight_core_engine_02",
	"cr_flight_core_engine_03",
	"cr_flight_core_engine_04",
	"cr_flight_core_engine_05",
	"cr_flight_core_engine_06", 
	"cr_flight_core_engine_07",
	"cr_flight_core_engine_08",

};

global t_flight_reactor_vents_real:table =
{ 
	"sn_flight_core_engine_real_01",
	"sn_flight_core_engine_real_02",
	"sn_flight_core_engine_real_03",
	"sn_flight_core_engine_real_04",
	"sn_flight_core_engine_real_05",
	"sn_flight_core_engine_real_06", 
	"sn_flight_core_engine_real_07",
	"sn_flight_core_engine_real_08",

};

global t_flight_reactor_vents_blips:table =
{ 
	"sn_obj_valve_01",
	"sn_obj_valve_02",
	"sn_obj_valve_03",
	"sn_obj_valve_04",
	"sn_obj_valve_05",
	"sn_obj_valve_06", 
	"sn_obj_valve_07",
	"sn_obj_valve_08",

};

	--"cr_flight_core_engine_02",
		--"cr_flight_core_engine_04",
	--"cr_flight_core_engine_05",
		--"cr_flight_core_engine_08",
	--"cr_flight_core_engine_09",
		--"cr_flight_core_engine_11",

---------------------------------------------------------------
---------------------------------------------------------------
-- Escape Flight
---------------------------------------------------------------
---------------------------------------------------------------

global w4_flight_engine_dead_count = 0;
global w4_flight_vent_count = 0;
global b_flight_begin = false;
global b_flight_end = false;

global gb_flight_phant_01_launch:boolean = false;
global gb_flight_phant_02_launch:boolean = false;
global gb_flight_phant_03_launch:boolean = false;
global gb_flight_phant_04_launch:boolean = false;
global gb_flight_phant_05_launch:boolean = false;
global gb_flight_phant_06_launch:boolean = false;
global gb_flight_spirit_01_launch:boolean = false;
global gb_flight_spirit_02_launch:boolean = false;
global gb_flight_banshees_intro_launch:boolean = false;
global gb_flight_found_exit:boolean = false;
global gb_flight_timer_start_done:boolean = false;
---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------


AssaultOnTheStation.goal_flight = 

{
	gotoVolume = VOLUMES.tv_hangar_banshee_exit,
	zoneSet = ZONE_SETS.zs_04,
	next={"goal_hangar"},

}


function blink_flight():void
	f_blink_clear_blips();
	NarrativeQueue.Kill();
	CreateThread(audio_assault_stopallmusic);
	GoalBlink(AssaultOnTheStation, "goal_flight", FLAGS.fl_blink_flight_01);
	

	TurnOffAllSpartanFlashlights();
	b_tun_assault_range = true;
	object_create_anew("dm_reactor_core");
	Sleep(3);
	b_w4_banshee_intro_done = true;
	device_set_position_immediate( OBJECTS.dm_reactor_core, 0.78 );

end

global g_vin_banshee_skybox_cruisers:number = -1;

function blink_flight_full_entrance():void
	switch_zone_set(ZONE_SETS.zs_04);
	NarrativeQueue.Kill();
	CreateThread(audio_assault_stopallmusic);

	object_create("dm_reactor_core");
	Sleep(10);
	GoalBlink(AssaultOnTheStation, "goal_flight", FLAGS.fl_blink_flight_05);
	--SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs_04 ], 1);
	--	Sleep (10);		
	  --device_set_position_track(OBJECTS.dm_reactor_core, "device:position", 0);
	--	Sleep(1);
		--device_animate_position( OBJECTS.dm_reactor_core ,0.58, 0.001, 0.1, 0 , false );
		--Sleep(120);
		
	--	teleport_player_to_flag (SPARTANS.chief, FLAGS.fl_blink_flight_05, false);
	--	teleport_player_to_flag (SPARTANS.kelly, FLAGS.fl_blink_flight_06, false);
	--	teleport_player_to_flag (SPARTANS.fred, FLAGS.fl_blink_flight_07, false);
	--	teleport_player_to_flag (SPARTANS.linda, FLAGS.fl_blink_flight_08, false);
		--Wake( dormant.w4_assault_flight_init );	
	--	g_vin_banshee_skybox_cruisers = composer_play_show( "vin_banshee_room_skybox" );
	--	Sleep(60);
	--	CreateThread( AssaultOnTheStation.goal_flight.Start )
		assault_game_save_no_timeout();
		b_reactor_ready_to_move = true;
		f_move_reactor();

end

function AssaultOnTheStation.goal_flight.Start()
	--SleepUntil( [| volume_test_players( VOLUMES.tv_flight_init ) ],1);
		print("Banshee Flight init");
		--physics_set_gravity( 0.3 );
		f_hunter_cleanup();
		f_reactor_cleanup();
		---adding this becuase all dudes take damage when falling down with reactor. KS
		object_create( "sn_flight_core_plug_invis" );
		--CreateThread( f_flight_sphincter );
		CreateThread( f_flight_create_flocks );
		--CreateThread( f_chapter_title, TITLES.ch_assault_4); 
		object_create_folder( "vehs_flight");
		object_create_folder("wpns_flight");
		Sleep(2);
		object_create_folder( "crs_flight");
		object_create_folder( "crs_flight_core_engines");
		if g_vin_banshee_skybox_cruisers == -1 then
			g_vin_banshee_skybox_cruisers = composer_play_show( "vin_banshee_room_skybox" );
		end
		Sleep(5);
		CreateThread( f_tun_flight_vents_vulnerable, false );
		
		--CreateThread( f_player_area_text , "Banshee Flight");
		--object_create_folder( "sn_flight" );
		ai_place(AI.sg_flight_on_foot_start);
		ai_place(AI.sg_flight_spirits);
		Sleep(2);
		ai_place( AI.sg_flight_banshees_intro );
		ai_place(AI.sg_flight_phantoms);
		CreateThread( f_flight_action );
		
		--=CreateThread(f_flight_lower_engine_guards);

		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_support_wee );
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_place_lost_01 );
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_place_lost_02);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_place_lost_03);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_place_lost_04);
		
		if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
			GoalCreateThread(  AssaultOnTheStation.goal_flight,f_flight_player_in_a_banshee_tut_setup );
		end
				
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_1);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_2);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_3);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_4);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_5);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_area_6);
		GoalCreateThread( AssaultOnTheStation.goal_flight, f_flight_save_engine_dead_half);
		
		local l_timer:number = 0;
		l_timer = timer_stamp( 10 );
		--SleepUntil( [|  timer_expired(l_timer) ],1);
	SleepUntil( [| b_w4_banshee_intro_done or timer_expired(l_timer)],1);
			
			for _,spartan in ipairs (spartans()) do
				CreateThread(f_flight_temp_invul, spartan);
			end
			ai_place( AI.sq_flight_banshee_05);
			ai_place( AI.sq_flight_banshee_06 );
		--	assault_game_save_no_timeout();
		
			--f_blip_flag( FLAGS.fl_flight_vent_01, "default");
			--f_blip_flag( FLAGS.fl_flight_vent_02, "default");

			GoalCreateThread(AssaultOnTheStation.goal_flight,f_tun_flight_vent_button_01);
			
			GoalCreateThread(AssaultOnTheStation.goal_flight,f_tun_flight_vent_button_02);
			
			CreateThread(f_tun_flight_vents_open);
			
			
			CreateThread(nar_goal_assault_flight);
		sleep_s( 1 );
		CreateThread(f_flight_objective);
		--sleep_s(10);
		
		sleep_s(8);
		CreateThread( f_flight_mark_vents );
		MusketeerUtil_SetDestination_Assault_Clear();
		--f_blip_object( OBJECTS.dc_banshee_vent_1, "default");
		--f_blip_object( OBJECTS.dc_banshee_vent_2, "default");
end

function f_flight_mark_vents()
		
		if w4_flight_vent_count == 0 then
			print("blip");
			object_create( "sn_obj_vent_1");
			object_create( "sn_obj_vent_2");
			sleep_s( 5 );
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );	
		else
			print("aborting marking vents because they've been activated already");
		end
end

function f_flight_sphincter()
	--SleepUntil( [| volume_test_players(VOLUMES.tv_flight_close_sphincter ) ],1);
		print("closing the sphincter");
		device_set_position(OBJECTS.dm_flight_sphincter, 0 );
end


function f_flight_save_area_1()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_01 ) ],1);
		assault_game_save_no_timeout();
end

function f_flight_save_area_2()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_02 ) ],1);
		assault_game_save_no_timeout();
end

function f_flight_save_area_3()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_03 ) ],1);
		assault_game_save_no_timeout();
end


function f_flight_save_area_4()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_04 ) ],1);
		assault_game_save_no_timeout();
end

function f_flight_save_area_5()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_05 ) ],1);
		assault_game_save_no_timeout();
end

function f_flight_save_area_6()
	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_save_area_06 ) ],1);
		assault_game_save_no_timeout();
end

function f_flight_save_engine_dead_half()
	SleepUntil([| w4_flight_engine_dead_count >= #t_flight_reactor_vents_real/2 ] , 3);
		assault_game_save_no_timeout();
end

function f_flight_objective()
	--f_assault_complete_objective();
--	f_assault_set_objective( TITLES.ct_obj_assault_9, false );
end


function f_flight_objective_2()
	--f_assault_complete_objective();
	--f_assault_set_objective( TITLES.ct_obj_assault_10, true );
end


function f_flight_objective_3()
	--f_assault_complete_objective();
	f_assault_set_objective( TITLES.ct_obj_assault_4_main, true );
end

---adding this becuase all dudes take damage when falling down with reactor. KS
function f_flight_temp_invul(spartan:object):void
	object_cannot_die(spartan, false);	
	unit_falling_damage_disable(spartan, false);
end


function f_flight_create_flocks()



	flock_create( "aiflock_flight_banshees03");
	flock_create( "aiflock_flight_banshees02");

	
	SleepUntil([| w4_flight_vent_count > 0] , 1 );
		print("increase flocks");

		flock_create( "aiflock_flight_banshees01");
		flock_create( "aiflock_flight_banshees04");
--	object_create( "vin_cruiser_banshee_room01");
--	object_create( "vin_cruiser_banshee_room02");	
--	object_create( "vin_cruiser_banshee_room03");	
	--object_create( "vin_cruiser_banshee_room04");	
	--object_create( "vin_cruiser_banshee_room05");	
	--object_create( "vin_cruiser_banshee_room06");		
end
function f_flight_destroy_flocks()

	flock_destroy( "aiflock_flight_banshees01");
	flock_destroy( "aiflock_flight_banshees02");
	flock_destroy( "aiflock_flight_banshees03");
	flock_destroy( "aiflock_flight_banshees04");
	
end


function f_flight_action()

	SleepUntil( [| volume_test_players(VOLUMES.tv_flight_action ) ],1);
		b_flight_begin = true;
		gb_flight_spirit_01_launch = true;
		gb_flight_spirit_02_launch = true;
		gb_flight_phant_01_launch = true;
		gb_flight_phant_02_launch = true;
		gb_flight_phant_03_launch = true;
		gb_flight_phant_04_launch = true;
		
		--object_create_folder( "dms_flight_plug" );
		
		--gb_flight_phant_05_launch = true;
		gb_flight_banshees_intro_launch = true;
		--sleep_s( 2 );
		
		--gb_flight_banshees_intro_launch = true;
		--gb_flight_phant_06_launch = true;
		sleep_s(3 );
		f_flight_sphincter();
end
	
function f_flight_cleanup()
	ai_erase( AI.sg_flight_all );
	object_destroy_folder("crs_flight");
	object_destroy_folder("vehs_flight");
	object_destroy_folder("crs_flight_core_engines");	
	object_destroy_folder("wpns_flight");
	object_destroy( OBJECTS.sn_flight_core_plug_invis );
	object_destroy( OBJECTS.dm_reactor_core );
	f_flight_destroy_flocks();
	
	if g_vin_banshee_skybox_cruisers ~= -1 then
		composer_stop_show( g_vin_banshee_skybox_cruisers );
	end
	--object_destroy_folder("sn_flight");
end


function f_flight_set_up_vents(vents:string, index:number):void
	--local vent_obj:object = object_create(vents);
	local vent_obj:object = OBJECTS[vents];
	local blip_obj:object = nil;
	Sleep(4);
		--print( vent_obj );
	ai_object_set_team( vent_obj, TEAM.covenant );
	ai_object_enable_targeting_from_vehicle( vent_obj, true );
	ai_object_set_targeting_bias( vent_obj, 0.5 );   -- not needed for musketeers
	blip_obj = object_create( t_flight_reactor_vents_blips[index] );
	--f_blip_object( vent_obj, "order_attack" );
	--play_animation_on_object( vent_obj, "any:open" );
	--scenery_animation_start(vent_obj, TAG('levels\assets\osiris\props\planet_assault\crates\oni_cooling_valve\oni_cooling_valve.model_animation_graph'), "any:open" );
	
	--DeviceLayerPlayAnimation(vent_obj, 2, "any:open", 30);
	SleepUntil( [| object_get_health(vent_obj) <= 0 ],1 );	
		object_destroy( blip_obj );
		w4_flight_engine_dead_count = w4_flight_engine_dead_count + 1;	

		if w4_flight_engine_dead_count == 2 then
			CreateEffectGroup(EFFECTS.reactor_damage01);
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
		elseif w4_flight_engine_dead_count == 4 then
			CreateEffectGroup(EFFECTS.reactor_damage02);
		elseif w4_flight_engine_dead_count == 6 then
			CreateEffectGroup(EFFECTS.reactor_damage03);
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
		elseif w4_flight_engine_dead_count == 7 then
			CreateEffectGroup(EFFECTS.reactor_damage04);
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
		elseif w4_flight_engine_dead_count == 8 then
				CreateEffectGroup(EFFECTS.reactor_damage05);
		end
		sleep_s(3);
		
		
end

function f_flight_vent_comp()
	sleep_s(2);
	composer_play_show( "w4_oni_valve_opening" );
end

function f_flight_open_pipes()
	print("opening pipes");
	device_set_position(OBJECTS.dm_flight_pipe_a , 1 );
	Sleep(15);
	device_set_position(OBJECTS.dm_flight_pipe_b , 1 );
end

function f_tun_flight_vent_button_01():void
	--SleepUntil( [| volume_test_players(VOLUMES.tv_tun_flight_vent_01 ) ],1);
		--f_unblip_flag( FLAGS.fl_flight_vent_01);
		print("button 1 rdy");
		device_set_power(OBJECTS.dc_banshee_vent_1, 1);
	--SleepUntil( [| device_get_position( OBJECTS.dc_banshee_vent_1 ) ~= 0 ] , 1 );
	SleepUntil( [| gb_flight_vent_1_pushed ] , 1 );
		print("-----switch 1 off-----");
		print("-----switch 1 off-----");
		print("-----switch 1 off-----");
		--CreateThread(audio_assault_thread_up_switch_off);
			object_destroy( OBJECTS.sn_obj_vent_1 );
			Sleep(3);
			object_destroy( OBJECTS.sn_obj_vent_2 );
		--CreateThread( f_flight_button_01_callback );
end

function f_flight_button_01_callback()
	
		
		--sleep_s(0.5);
		CreateEffectGroup(EFFECTS.fx_boom_vent_01);
		object_damage_damage_section( OBJECTS.cr_flight_vent_01, "default", 10000 );
end

function f_tun_flight_vent_button_02():void
	--SleepUntil( [| volume_test_players(VOLUMES.tv_tun_flight_vent_02 ) ],1);
		
		device_set_power(OBJECTS.dc_banshee_vent_2, 1);
	--	SleepUntil( [| device_get_position( OBJECTS.dc_banshee_vent_2 ) ~= 0 ] , 1 );
		SleepUntil( [| gb_flight_vent_2_pushed ] , 1 );
	
			print("------- switch 2 off-------");
			print("------- switch 2 off-------");
			print("------- switch 2 off-------");
			object_destroy( OBJECTS.sn_obj_vent_1 );
			Sleep(3);
			object_destroy( OBJECTS.sn_obj_vent_2 );			
			--f_unblip_flag( FLAGS.fl_flight_vent_02);
			--f_unblip_object( OBJECTS.dc_banshee_vent_2);
			--f_unblip_object( OBJECTS.dc_banshee_vent_1);
			--CreateThread( f_flight_button_02_callback );
			--CreateThread(audio_assault_thread_up_switch_off);

end

function f_flight_button_02_callback()

			--device_set_power(OBJECTS.dc_banshee_vent_2, 0);
			--device_set_power(OBJECTS.dc_banshee_vent_1, 0);
			--Wake(dormant.f_flight_open_pipes);
			--Sleep(10);
			CreateEffectGroup(EFFECTS.fx_boom_vent_02);	
			object_damage_damage_section( OBJECTS.cr_flight_vent_02, "default", 10000 );

end

global gb_flight_vent_1_pushed:boolean = false;
global gb_flight_vent_2_pushed:boolean = false;

function f_tun_flight_v_btn_01_on(trigger:object, activator:object):void
	local this_activator:object = activator or SPARTANS.chief ;
	if not gb_flight_vent_1_pushed then
		gb_flight_vent_1_pushed = true;
		--print("switch 1 pushed");
		CreateThread(audio_vent_control_activated);
		w4_flight_vent_count = w4_flight_vent_count + 1;
		composer_play_show("vin_player_ics_banshee_room_02", { ics_player = this_activator});
		CreateThread(audio_vent_control_glassbreak1);
		
	end

end



function f_tun_flight_v_btn_02_on(trigger:object, activator:object):void
	local this_activator:object = activator or SPARTANS.chief ;
	if not gb_flight_vent_2_pushed then
		gb_flight_vent_2_pushed = true;
		--print("switch 2 pushed");
		CreateThread(audio_vent_control_activated);
		w4_flight_vent_count = w4_flight_vent_count + 1;
		composer_play_show("vin_player_ics_banshee_room_01", { ics_player = this_activator});
		CreateThread(audio_vent_control_glassbreak2);
	end
	

end


function debug_f_tun_flight_vents_open()
	object_create_folder( "vehs_flight");
	object_create_folder( "crs_flight_core_engines");
	for i,vents in ipairs (t_flight_reactor_vents_real) do
		CreateThread(f_flight_set_up_vents, vents, i);
		print(vents);
		
	end
	CreateThread( f_flight_vent_comp );
end


function debug_vents_vulnerable( )
	object_create_folder("crs_flight_core_engines");
	for _,vents in ipairs (t_flight_reactor_vents_real) do
			print(vents);
			object_cannot_take_damage( vents );		

		--print(vents);
		
	end
end

function f_tun_flight_vents_vulnerable( isVulnerable:boolean)

	for _,vents in ipairs (t_flight_reactor_vents_real) do
		if isVulnerable then
			--print("gack ", vents);
			object_can_take_damage( ObjectFromName(vents));		
		else
			--print("invul ", vents);
			object_cannot_take_damage(  ObjectFromName(vents) );		
		end
		--print(vents);
	end
end

function f_tun_flight_vents_open():void
	SleepUntil( [| w4_flight_vent_count >= 1 ],1);
		print("vents open");
		device_set_power(OBJECTS.dc_banshee_vent_2, 0);
		device_set_power(OBJECTS.dc_banshee_vent_1, 0);
		CreateThread(audio_assault_thread_up_switch_off);
		CreateThread( f_flight_open_pipes);
		--CreateThread( f_player_area_text , "Ok Blue Team, safety protocol override is a go.");
		assault_game_save_no_timeout();
		--object_destroy( OBJECTS.sn_obj_vent_1 );
		--object_destroy( OBJECTS.sn_obj_vent_2 );
		--CreateThread(nar_ass_second_clamp_used);
		sleep_s(4);
		object_destroy( OBJECTS.sn_obj_vent_1 );
		object_destroy( OBJECTS.sn_obj_vent_2 );

		--CreateThread( f_player_area_text , "Now blast those open vents ");
		CreateThread( f_tun_flight_vents_vulnerable, true );
		for i,vents in ipairs (t_flight_reactor_vents_real) do
			CreateThread(f_flight_set_up_vents, vents,i );
			print(vents);
		end
		CreateThread( f_flight_vent_comp );
		sleep_s(1);
		
		CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );	
		CreateThread(f_flight_all_core_engines_dead);
		--CreateThread( f_flight_objective_2);
		sleep_s(3);
		CreateThread(f_flight_banshee);
end

function f_flight_banshee():void
	--SleepUntil( [| unit_in_vehicle(SPARTANS.chief) or unit_in_vehicle(PLAYERS.player1) or unit_in_vehicle(PLAYERS.player2) or unit_in_vehicle(PLAYERS.player3) ],1);
	--sleep_s(2);
	--CreateThread( f_player_area_text , "Banshees inbound!");
	
	
	--b_flight_end
	CreateThread( f_flight_on_ground_refill );
	if coop_players_4() or game_difficulty_get_real() == DIFFICULTY.legendary then
		ai_place( AI.sq_flight_banshee_01, 2 );
	else
	
	
		if ai_living_count(AI.sg_flight_banshees) <= 1 then
			ai_place( AI.sq_flight_banshee_04 );
		end
		
		ai_place( AI.sq_flight_banshee_02 );
		ai_place( AI.sq_flight_banshee_03 );
	
	end
		sleep_rand_s(20,25);
	repeat
		SleepUntil([| ai_living_count( AI.sg_flight_banshees ) <= 0 ], 1 );
			--print("all banshees dead");

			


			if game_is_cooperative() or game_difficulty_get_real() == DIFFICULTY.legendary then
				sleep_rand_s(50,80);
			else
				sleep_rand_s(80,100);
			end		
			
			if any_players_in_vehicle() and not b_flight_end then
					print("banshee refill");
					ai_place( AI.sq_flight_banshee_01, 2 );				
				
			end
			Sleep(10);
	until b_flight_end;
end

function f_flight_on_ground_refill()
	repeat
		SleepUntil([| ai_living_count( AI.sg_flight_on_foot_all ) <= 16 ], 1 );
			print("refill ground");
			if game_is_cooperative() or game_difficulty_get_real() == DIFFICULTY.legendary then
				sleep_rand_s(8,12);
			else
				sleep_rand_s(15,20);
			end
					
			if ai_living_count( AI.sq_flight_phant_07 ) == 0 then
				ai_place( AI.sq_flight_phant_07);
			end
			
			SleepUntil([| ai_living_count( AI.sq_flight_phant_07 ) == 0 ], 1 );
			Sleep(10);
	until b_flight_end;
end
	
function cs_banshee_fly_in()
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.1, 0 );
	cs_vehicle_boost(true);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 3*60 );
	--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.1, 1, 3) ;
	sleep_s( 2.5 );
	cs_vehicle_boost(false);
end
	
	

global g_MAXVENTSDEAD:number = 5;

function f_flight_all_core_engines_dead():void
	local l_timer:number = -1;

	g_MAXVENTSDEAD = #t_flight_reactor_vents_real;
	print("number of vents to destroy =  ", #t_flight_reactor_vents_real );
	SleepUntil( [| w4_flight_engine_dead_count == #t_flight_reactor_vents_real ],1);
		
		sleep_s(3);
		--CreateThread( f_player_area_text , "Good job Blue Team");
		CreateThread(audio_assault_thread_up_vents_dead);
		CreateThread(nar_ass_reactor_blasted);
		l_timer = timer_stamp( 75 );
		assault_game_save_no_timeout();
	SleepUntil( [| timer_expired( l_timer ) or b_flight_marked_exit ],1);		
		CreateThread( f_flight_mark_hangar_entrance );  --failsafe, should be called from narr script
		assault_game_save_no_timeout();
end


global b_flight_marked_exit:boolean = false;

function f_flight_mark_hangar_entrance()
		--sleep_s(3);
		if not b_flight_marked_exit then
			b_flight_marked_exit = true;
			CreateThread(audio_assault_thread_up_mark_entrance);
			CreateThread( f_flight_open_space_shield );
			CreateThread( f_flight_objective_3 );
			device_set_position( OBJECTS.dm_banshee_hangar_door, 0.35 );
			--sleep_s(2);
			CreateThread(audio_forcefield_door_open);
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 10 );
			CreateThread( f_flight_ping_until_found );
			--f_blip_flag( FLAGS.fl_flight_end, "default");
			object_create( "sn_obj_flight_exit" );
			b_flight_end = true;
		
			SleepUntil( [| volume_test_players(VOLUMES.tv_flight_end ) ],1);
			--	f_unblip_flag( FLAGS.fl_flight_end);
				gb_flight_found_exit = true;
				assault_game_save_no_timeout();
				object_destroy( OBJECTS.sn_obj_flight_exit );
		end
end

function f_flight_open_space_shield()

	object_set_function_variable (OBJECTS.cr_flight_shield_space_barrier, "shield_pass", 1, 2 );
	sleep_s(2);
	object_destroy(OBJECTS.cr_flight_shield_space_barrier_collision);
end

function f_flight_ping_until_found()
	sleep_s(45);

		repeat
				if not gb_flight_found_exit then
					CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 15 );
				end
				sleep_s(60);
		until( gb_flight_found_exit );

end

function f_flight_lower_engine_guards():void
	--SleepUntil( [| volume_test_players(VOLUMES.tv_flight_lower_squads ) ],1);
		ai_place(AI.sq_flight_engine_guards_01);
		ai_place(AI.sq_flight_engine_guards_02);
end

global gb_flight_wee_activator:player = nil;
global gb_flight_wee_reset:boolean = false;
global gb_flight_wee_ground_pound:boolean = false;
function f_flight_support_wee()
	
		local l_timer:number = -1;
		gb_flight_timer_start_done = false;
	local b_wee_lock : boolean = false;
		object_set_cinematic_visibility( OBJECTS.flight_sword_of_lols, true );
	repeat
		Sleep(3);
		
		----SleepUntil( [| volume_test_players(VOLUMES.tv_flight_prize_p1) ],3);	
		SleepUntil( [| volume_test_players(VOLUMES.tv_flight_prize_p00) ],3);	
				CreateThread( f_flight_start_timer_done );
				print("rock it");
				sleep_s(2.5);
				print("meep");
		SleepUntil( [| volume_test_players(VOLUMES.tv_flight_prize_p0) or gb_flight_timer_start_done],3);	
			 if not gb_flight_timer_start_done then
				object_create_anew( "cr_flight_ee_sword" );
				SleepUntil( [| object_valid( "cr_flight_ee_sword" ) ],1);	
				print("register death event for ee");
				--RegisterDeathEvent(AssaultEESwordDeath, OBJECTS.cr_flight_ee_sword);
				--Sleep(30);
				gb_flight_wee_ground_pound = true;
				print( gb_flight_wee_ground_pound);
			end
		SleepUntil( [| volume_test_players(VOLUMES.tv_flight_prize_p1) or gb_flight_timer_start_done ],3);	
			print( gb_flight_wee_ground_pound);
			if gb_flight_wee_ground_pound and not gb_flight_timer_start_done then
				if not ( b_wee_lock and gb_flight_prize ) then
						b_wee_lock = true;
						print("go1"); 
						if		(	volume_test_object(VOLUMES.tv_flight_prize_p1, PLAYERS.player0 ) and	( unit_get_vehicle( PLAYERS.player0 ) == nil ) ) then
							--print("player not in vehicle");
							print("go?");
							gb_flight_wee_activator =  PLAYERS.player0;
						elseif(	volume_test_object(VOLUMES.tv_flight_prize_p1, PLAYERS.player1 ) and	( unit_get_vehicle( PLAYERS.player1 ) == nil ) ) then
							gb_flight_wee_activator =  PLAYERS.player1;
						elseif(	volume_test_object(VOLUMES.tv_flight_prize_p1, PLAYERS.player2 ) and	( unit_get_vehicle( PLAYERS.player2 ) == nil ) ) then
							gb_flight_wee_activator =  PLAYERS.player2;				
						elseif(	volume_test_object(VOLUMES.tv_flight_prize_p1, PLAYERS.player3 ) and	( unit_get_vehicle( PLAYERS.player3 ) == nil ) ) then
							gb_flight_wee_activator =  PLAYERS.player3;
										
						else
							print("meh");
							sleep_s(15);
							
						end
						
						if gb_flight_wee_activator ~= nil then
								CreateThread( f_flight_wee );
								object_create("mcc_flight_p1");
								print("mcc_flight_p1CREATE");
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p01);
								Sleep(30);
							--	object_teleport( gb_flight_wee_activator,FLAGS.fl_flight_wee_start );
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p1);
								print("1");
							SleepUntil( [| volume_test_object(VOLUMES.tv_flight_prize_p2, gb_flight_wee_activator) or gb_flight_wee_reset],3);	
								
								object_destroy(OBJECTS.mcc_flight_p1);
								StopEffectGroup(EFFECTS.fx_flight_cannon_p1);
								object_create("mcc_flight_p2");
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p02);
								Sleep(15);
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p2);
								print("2");
							SleepUntil( [| volume_test_object(VOLUMES.tv_flight_prize_p3, gb_flight_wee_activator) or gb_flight_wee_reset],3);	
								object_destroy(OBJECTS.mcc_flight_p2);
								StopEffectGroup(EFFECTS.fx_flight_cannon_p2);
	
								object_create("mcc_flight_p3");
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p03);
								Sleep(15);
								CreateEffectGroup(EFFECTS.fx_flight_cannon_p3);
								print("3");
								sleep_s(2);
								StopEffectGroup(EFFECTS.fx_flight_cannon_p3);
						end
				end
		 end
			sleep_s(15);
			b_wee_lock = false;
			gb_flight_wee_ground_pound = false;
			gb_flight_timer_start_done = false;
			gb_flight_wee_reset = false;
	until b_flight_end or gb_flight_prize;

end

function AssaultEESwordDeath( deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64  )

    print("Something died");
   -- print(deadObject);
   -- print("Damage Type =", damageType,damageModifier, " ", damageSource);
	--if damageType == ground_pound then
	--	print("shiiiiit");
	--end

  --  if(damageType == 0 or damageType == 1 or damageType == 2 or damageType == 3 or damageType == 4 or damageType == 5 or damageType == -1 or   damageType == 7 or damageType == 8 or damageType == 6 ) then 
    --  print("ground pund !", damageType)
     gb_flight_wee_ground_pound = true;
   -- end
   -- print("END Something died");
   -- print();
    
    
   -- if(damageSource == assaultRifleStringID) then
    --                print ("assault rifle'd")
  --  end


end

function f_flight_wee()

	local b_wee_lock : boolean = false;
	repeat
		Sleep(3);
		SleepUntil( [| volume_test_players(VOLUMES.tv_flight_skull) ],3);	
			print("skull land");
			if not ( b_wee_lock and gb_flight_prize ) then
					b_wee_lock = true;
							object_destroy(OBJECTS.mcc_flight_p3);
							StopEffectGroup(EFFECTS.fx_flight_cannon_p3);
					if		(	volume_test_object(VOLUMES.tv_flight_skull, gb_flight_wee_activator ) and	( unit_get_vehicle( gb_flight_wee_activator ) == nil ) ) then
						print("player not in vehicle");
					f_flight_prize_logic(gb_flight_wee_activator);	
						
					--elseif(	volume_test_object(VOLUMES.tv_flight_skull, PLAYERS.player1 ) and	( unit_get_vehicle( PLAYERS.player1 ) == nil ) ) then
				--		f_flight_prize_logic(PLAYERS.player1);
				--	elseif(	volume_test_object(VOLUMES.tv_flight_skull, PLAYERS.player2 ) and	( unit_get_vehicle( PLAYERS.player2 ) == nil ) ) then
					--	f_flight_prize_logic(PLAYERS.player2);				
				--	elseif(	volume_test_object(VOLUMES.tv_flight_skull, PLAYERS.player3 ) and	( unit_get_vehicle( PLAYERS.player3 ) == nil ) ) then
						--f_flight_prize_logic(PLAYERS.player3);
									
					--else
					--	sleep_s(15);
	
					end
			end
			sleep_s(15);
			b_wee_lock = false;
			gb_flight_wee_reset = true;
			gb_flight_wee_activator = nil;
	until b_flight_end or gb_flight_prize;

end


global b_flight_awake_grunt:boolean = false;

function cs_sleep_long_time()
--	ai_set_deaf( ai_current_actor, true );
	cs_abort_on_damage(  true );
	--cs_abort_on_alert(  true );
	Sleep(10);
	--SleepUntil( [| ai_combat_status( AI.sq_flight_grunt_lost01)  >=3 or ai_living_count(AI.sq_flight_grunt_lost) < 3], 1	);
	 --ai_set_deaf( ai_current_actor, false );
end


function f_flight_place_lost_01()
		SleepUntil( [| volume_test_players(VOLUMES.tv_flight_spawn_lost_01) ],2);	
			ai_place(AI.sq_flight_grunt_lost);
end


function f_flight_place_lost_02()
		SleepUntil( [| volume_test_players( VOLUMES.tv_flight_spawn_lost_02 )  ],2);	
			--print("catch up");
		if not game_is_cooperative() then
			CreateEffectGroup(EFFECTS.fx_boom_lost_02);
	
			sleep_rand_s( 2, 3 );
			if IsPlayer(SPARTANS.chief) and unit_has_weapon_readied(SPARTANS.chief, TAG('objects\weapons\support_high\rocket_launcher\rocket_launcher.weapon')) then
				--print("i has big gun");
				SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
				ai_place(AI.sq_flight_banshee_lost_02);
			end
			StopEffectGroup(EFFECTS.fx_boom_lost_02);
		end
end

function f_flight_place_lost_03()
		SleepUntil( [| volume_test_players( VOLUMES.tv_flight_spawn_lost_03 )  ],2);	
			print("catch up");
			if not game_is_cooperative() then
				CreateEffectGroup(EFFECTS.fx_boom_lost_03);
	
				sleep_rand_s( 2, 3 );
			if IsPlayer(SPARTANS.chief) and unit_has_weapon_readied(SPARTANS.chief, TAG('objects\weapons\pistol\magnum\magnum.weapon')) then
				print("i has a blam blam");
				SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
				ai_place(AI.sq_flight_elite_lost03);
				Sleep(120);
				ai_place(AI.sq_flight_elite_lost03);
		
			end
				StopEffectGroup(EFFECTS.fx_boom_lost_03);
			end
			
end

function f_flight_place_lost_04()
		SleepUntil( [| volume_test_players( VOLUMES.tv_flight_spawn_lost_04 )  ],2);	
			print("who dat");
			if not game_is_cooperative() then
				
				CreateEffectGroup(EFFECTS.fx_boom_lost_04);
	
				sleep_rand_s( 4, 7 );
				if IsPlayer(SPARTANS.chief) and unit_has_weapon_readied(SPARTANS.chief, TAG('objects\weapons\pistol\plasma_pistol\plasma_pistol.weapon')) then
					print("i has pew pew");
					SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
					ai_place(AI.sq_flight_phant_lost_04);
					
			  end
			  StopEffectGroup(EFFECTS.fx_boom_lost_04);
			end
			
end

function cs_phantom_fly_in_lost()

	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.1, 0 );
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_lost_04 ) );
	--cs_vehicle_boost(true);
	cs_vehicle_speed(0.3);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 3*60 );
	--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.1, 1, 3) ;
	cs_fly_by(POINTS.ps_flight_hj.p17);
	cs_fly_by(POINTS.ps_flight_hj.p18);
	Sleep(180);
	cs_fly_by(POINTS.ps_flight_hj.p19);
	cs_vehicle_boost(false);
	cs_fly_by(POINTS.ps_flight_hj.p20);

	cs_fly_by(POINTS.ps_flight_hj.p21);
	--cs_shoot( true );
	cs_vehicle_speed(0.5);
	cs_fly_by(POINTS.ps_flight_hj.p22);
	Sleep(180);
	cs_fly_by(POINTS.ps_flight_hj.p23);
	cs_vehicle_speed(1.0); 
	cs_fly_by(POINTS.ps_flight_hj.p24);
	--cs_shoot( false );
	cs_fly_to (ai_current_actor, true, POINTS.ps_flight_hj.p25, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 3*60 ); --Shrink size over time
	--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 3) ;
	cs_fly_by (ai_current_actor, true, POINTS.ps_flight_hj.p25, 0);
		sleep_s (3);
		ai_erase (AI.sq_flight_phant_lost_04);	
	

end

function cs_banshee_fly_in_lost()
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.1, 0 );
	
	cs_vehicle_boost(true);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 3*60 );
	--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.1, 1, 3) ;
	cs_abort_on_vehicle_exit( AI.sq_flight_banshee_lost_02, true );
	cs_fly_by(POINTS.ps_flight_hj.p10);
	cs_fly_by(POINTS.ps_flight_hj.p11);
	
	cs_fly_by(POINTS.ps_flight_hj.p12);
	cs_vehicle_boost(false);
	cs_fly_by(POINTS.ps_flight_hj.p13);

	cs_fly_by(POINTS.ps_flight_hj.p14);
	--cs_shoot( true );
	cs_vehicle_speed(0.5);
	cs_fly_by(POINTS.ps_flight_hj.p15);
	--cs_shoot( false );
	cs_fly_by(POINTS.ps_flight_hj.p16);


	cs_fly_by(POINTS.ps_flight_hj.p23);
	cs_vehicle_speed(1.0);
	cs_vehicle_boost(true);
	cs_fly_by(POINTS.ps_flight_hj.p24);
	--object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 3*60 );
	cs_fly_by(POINTS.ps_flight_hj.p25);
	sleep_s(3)
	ai_erase (AI.sq_flight_banshee_lost_02);
end

function f_flight_crouch_test()

	player_action_test_reset();
	Sleep(3);
	

	SleepUntil([|  unit_action_test_equipment()] ,1 );--player_action_test_vehicle_trick_primary() or 
		print("alsdkfj");
end

function f_flight_prize_logic(p_player:player )
		--local b_dash:boolean = false;
		
		CreateThread( f_flight_timer_done );
		print("prize logic");
		SleepUntil( [| volume_test_object(VOLUMES.tv_flight_prize, p_player) or gb_flight_timer],3);	
			print("huh");
			if not gb_flight_timer then
				CreateEffectGroup(EFFECTS.fx_boom_special);
				Sleep(15);
				print("PRIZE!");
				SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
				object_create( "veh_banshee_catch");
				Sleep(30);
				if p_player and OBJECTS.veh_banshee_catch then
					unit_enter_vehicle( p_player, OBJECTS.veh_banshee_catch,"banshee_d" );

					gb_flight_prize = true;
				end
			else
				print("times up ");
			end
			--gb_flight_prize_finder = nil;
end
global gb_flight_timer:boolean = false;
global gb_flight_prize:boolean = false;
--global gb_flight_prize_finder:player = nil;
function f_flight_timer_done()
		local l_timer:number = 0;
		l_timer = timer_stamp( 5 );
		SleepUntil( [|  timer_expired(l_timer) ],1);
		 	gb_flight_timer = true;
			--return gb_flight_timer;
end

function f_flight_start_timer_done()
		local l_timer:number = 0;
		l_timer = timer_stamp( 6 );
		SleepUntil( [|  timer_expired(l_timer) ],1);
		 	gb_flight_timer_start_done = true;
		 	print("start timer done");
			--return gb_flight_timer;
end







function f_flight_player_in_a_banshee_tut_setup():void
	local b_in_a_vehicle:boolean = false;
		
		for _, spartan in ipairs ( players() ) do
				GoalCreateThread(  AssaultOnTheStation.goal_flight, f_flight_player_in_a_banshee_tut , unit_get_player( spartan ) );
		end
		
end


function f_flight_player_in_a_banshee_tut(pl:player):void


			
	SleepUntil([| unit_in_vehicle ( pl ) or b_flight_end ] , 1);
		if not b_flight_end then
				sleep_s(3);
			--gmu OSR-148903 -- switching these tutorials to be only play if not seen (register with the profile)
				f_assault_popup_display_tutorial_wait( pl, "training_bansheeboost", TUTORIAL.BansheeBoost, 5 )
						
		end
		sleep_s(8);
		
		SleepUntil([| unit_in_vehicle ( pl ) or b_flight_end ] , 1);
			if not b_flight_end then
				--gmu OSR-148903 -- switching these tutorials to be only play if not seen (register with the profile)
				f_assault_popup_display_tutorial_wait( pl, "training_bansheetrick", TUTORIAL.BansheeTrick, 5 )
						
		end	
	
end

---------------------------------------------------------------
---------------------------------------------------------------
--COMMMAND SCRIPTS
---------------------------------------------------------------
---------------------------------------------------------------


function cs_flight_banshee_hijack_me()
	
	repeat
		Sleep(1);
		
		cs_fly_by( POINTS.ps_flight_hj.p0 );
		cs_fly_by( POINTS.ps_flight_hj.p01 );
		cs_fly_by( POINTS.ps_flight_hj.p02 );
		cs_fly_by( POINTS.ps_flight_hj.p03 );
		cs_fly_by( POINTS.ps_flight_hj.p04 );
		cs_fly_by( POINTS.ps_flight_hj.p05 );
		cs_fly_by( POINTS.ps_flight_hj.p06 );
		cs_fly_by( POINTS.ps_flight_hj.p07 );		
		cs_fly_by( POINTS.ps_flight_hj.p08 );
		cs_fly_by( POINTS.ps_flight_hj.p09 );
	until false ;

end



function cs_flight_phant_01()

	--ai_place(AI.sq_flight_null);
	--CreateThread( f_close_phantom_door,  ai_get_object ( ai_current_actor ) );
	CreateThread( f_close_phantom_door,  ai_vehicle_get_from_squad( AI.sq_flight_phant_01 ) );
	--vehicle_load_magic ( ai_vehicle_get_from_squad( AI.sq_flight_phant_01 ), "close_turret_doors", AI.sq_flight_null.door_seat);
	if not object_valid("crate_billy05") then
		object_create("crate_billy05");
	end
	
	if not object_valid("crate_billy06") then
		object_create("crate_billy06");
	end
	
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_01.phantom01) ,"small_cargo01", OBJECTS.crate_billy05,"" );
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_01.phantom01) ,"small_cargo02", OBJECTS.crate_billy06,"" );

	SleepUntil(  [| volume_test_players( VOLUMES.tv_flight_phantom_launch_01 ) or gb_flight_phant_01_launch ], 1);

		cs_vehicle_speed (0.3 );
		ai_place( AI.sq_flight_jack_rang_g2_02 );
		--ai_place( AI.sq_flight_jack_rang_g2_01 );
		----f_load_drop_ship ( AI.sq_flight_phant_01, AI.sq_flight_jack_rang_g2_01, true, false, "right" );
		f_load_phantom_right(AI.sq_flight_phant_01, AI.sq_flight_jack_rang_g2_01.jackal_01,AI.sq_flight_jack_rang_g2_01.jackal_02, AI.sq_flight_jack_rang_g2_01.jackal_03, nil, true);
		sleep_s(1);		
		f_unload_drop_ship(AI.sq_flight_phant_01);		
		sleep_s(7);	
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_07, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_08, 0);
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_04, 0);
		cs_vehicle_speed (0.8 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_05, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 6) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_06, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_01);
end

function cs_flight_phant_02()

	CreateThread( f_close_phantom_door,   ai_vehicle_get_from_squad( AI.sq_flight_phant_02 ) );
	
	if not object_valid("crate_billy07") then
		object_create("crate_billy07");
	end
	
	if not object_valid("crate_billy08") then
		object_create("crate_billy08");
	end
	
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_02.phantom02) ,"small_cargo01", OBJECTS.crate_billy08,"" );
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_02.phantom02) ,"small_cargo02", OBJECTS.crate_billy07,"" );
	--SleepUntil(  [| gb_flight_phant_02_launch ], 1);
		--sleep_s( 1);
		cs_vehicle_speed (1 );
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_02.s_03, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_02.s_04, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_02);
end


function cs_flight_phant_03()
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_03 ) );

	if not object_valid("crate_billy01") then
		object_create("crate_billy01");
	end
	
	if not object_valid("crate_billy04") then
		object_create("crate_billy04");
	end
	
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_03.phantom03) ,"small_cargo01", OBJECTS.crate_billy01,"" );
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_03.phantom03) ,"small_cargo02", OBJECTS.crate_billy04,"" );

	SleepUntil(  [| gb_flight_phant_03_launch ], 1);
		cs_vehicle_speed (0.3 );	
		sleep_s(3);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_03.s_1a, 0);
		cs_vehicle_speed (1 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_03.s_05, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_03.s_06, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_03);
end

function cs_flight_phant_04()
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_04 ) );
	--objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_04.phantom04) ,"fx_destroyed_phantom", OBJECTS.crate_billy01,"" );
	if not object_valid("crate_billy02") then
		object_create("crate_billy02");
	end
	
	if not object_valid("crate_billy03") then
		object_create("crate_billy03");
	end
	
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_04.phantom04) ,"small_cargo01", OBJECTS.crate_billy02,"" );
	objects_attach(ai_vehicle_get_from_spawn_point (AI.sq_flight_phant_04.phantom04) ,"small_cargo02", OBJECTS.crate_billy03,"" );
	SleepUntil(  [| gb_flight_phant_04_launch ], 1);
		cs_vehicle_speed (0.3 );
		--sleep_s(3);
		f_load_drop_ship ( AI.sq_flight_phant_04, AI.sg_flight_grunt_01, true, false, "right" );	
		f_unload_drop_ship(AI.sq_flight_phant_04);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_04.s_01, 0);
		cs_vehicle_speed (0.8 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_04.s_02, 0);
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_04.s_03, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_04.s_04, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_04);
end


function cs_flight_phant_05()
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_05 ) );
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); 
	SleepUntil(  [| volume_test_players( VOLUMES.tv_flight_phantom_launch_05 ) or gb_flight_phant_05_launch ], 1);
		object_teleport( ai_vehicle_get ( ai_current_actor ), FLAGS.fl_flight_phant_05	);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 5*60 );
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.01, 1, 5) ;
		cs_vehicle_speed (1.0 );
		--f_load_drop_ship ( AI.sq_flight_phant_05, AI.sg_flight_jack_rang_01, true, false, "any" );
		----f_load_drop_ship ( AI.sq_flight_phant_05, AI.sq_flight_jack_rang_g1_01, true, false, "left" );
	----	f_load_drop_ship ( AI.sq_flight_phant_05, AI.sq_flight_jack_rang_g1_02, true, false, "right" );
		f_load_phantom_left(AI.sq_flight_phant_05, AI.sq_flight_jack_rang_g1_01.jackal_01,AI.sq_flight_jack_rang_g1_01.jackal_02, AI.sq_flight_jack_rang_g1_01.jackal_03, nil, true);
		f_load_phantom_right(AI.sq_flight_phant_05, AI.sq_flight_jack_rang_g1_02.jackal_01,AI.sq_flight_jack_rang_g1_02.jackal_02, AI.sq_flight_jack_rang_g1_02.jackal_03, nil, true); 
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_08, 0);
		cs_vehicle_speed (0.8 );
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_09, 0);
		cs_vehicle_speed (0.2);
		cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_09, POINTS.ps_flight_phantom_05.s_10, 2.5); 
		--f_unload_drop_ship(AI.sq_flight_phant_05);
		f_unload_phantom(ai_vehicle_get_from_spawn_point(AI.sq_flight_phant_05.phantom05), "any");
		--f_unload_phantom(AI.sq_flight_phant_05, "right");
		sleep_s(6);
		cs_vehicle_speed (0.3 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_01, 0);
		cs_vehicle_speed (0.7 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_02, 0);		
		cs_vehicle_speed (1.0 );
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_03, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_05.s_04, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_05);
end


function cs_flight_phant_06()
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_06 ) );
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); 
	

SleepUntil(  [| volume_test_players( VOLUMES.tv_flight_phantom_launch_06 ) or gb_flight_phant_06_launch ], 1);

		object_teleport( ai_vehicle_get ( ai_current_actor ), FLAGS.fl_flight_phant_06	);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 5*60 );
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.01, 1, 5) ;
		cs_vehicle_speed (1.0 );
		f_load_drop_ship ( AI.sq_flight_phant_06, AI.sg_flight_grunt_02, true, false, "any" );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_01, 0);	
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_02, 0);		
		cs_vehicle_speed (0.4);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_03, 0);
		cs_vehicle_speed (0.2);
		cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_03, POINTS.ps_flight_phantom_06.s_04, 2.5); 
		f_unload_drop_ship(AI.sq_flight_phant_06);
		sleep_s(6.75);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_05, 0);
		cs_vehicle_speed (1.0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_06, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_7a, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_07, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;

		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_phantom_06.s_08, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_06);
end






---------------------reinforce



function cs_flight_phant_07()
	CreateThread( f_close_phantom_door,    ai_vehicle_get_from_squad( AI.sq_flight_phant_07 ) );
----	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); 
	


		object_teleport( ai_vehicle_get ( ai_current_actor ), FLAGS.fl_flight_phant_05	);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1, 5*60 );
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  0.01, 1, 5) ;
		cs_vehicle_speed (1.0 );
		--print("fly monkey fly2");
		--f_load_drop_ship( ship_squad:ai, squad:ai, b_spawn_squad:boolean, b_spawn_ship:boolean, side:string ):void
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_enter, 0);	
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_01, 0);	
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_02, 0);		
		cs_vehicle_speed (0.4);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_reinforce.s_03, 0);
		
		
		if ai_living_count( AI.sg_flight_on_foot_all ) <= 13 then
			f_load_drop_ship ( AI.sq_flight_phant_07, AI.sg_flight_reinforce, true, false, "any" );
			cs_vehicle_speed (0.2);
			cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_flight_reinforce.s_dock, POINTS.ps_flight_reinforce.s_face, 2.5); 
			f_unload_drop_ship(AI.sq_flight_phant_07);
			sleep_s(6.75);
		end
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_04, 0);
		cs_vehicle_speed (1.0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_05, 0);
		--cs_fly_by (ai_current_actor, true, POINTS.ps_flight_reinforce.s_07, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 4*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 4) ;
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_reinforce.s_exit, 0);
		sleep_s (4);
		ai_erase (AI.sq_flight_phant_07);
end













--
function cs_flight_spirit_01()
	
	SleepUntil(  [| gb_flight_spirit_01_launch ], 1);
		cs_vehicle_speed ( 0.55 );
		--print("fly monkey fly");
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_01, 0);
		ai_set_blind(ai_current_actor,true);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_02, 0);	
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_03, 0);
		
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_04, 0);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_05, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 6) ;
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_01.s_06, 0);
		sleep_s (6);
		ai_erase (AI.sq_flight_spirit_01);		
end



function cs_flight_spirit_02()
	SleepUntil(  [| gb_flight_spirit_02_launch ], 1);
		cs_vehicle_speed ( 0.5 );
		--print("fly monkey fly2");
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_01, 0);
		ai_set_blind(ai_current_actor,true);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_02, 0);		
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_03, 0);
		
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_04, 0);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_05, 0);
		object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
		--CreateThread( f_assault_scaleover_time, ai_vehicle_get ( ai_current_actor ),  1, 0.01, 6) ;
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_spirit_02.s_06, 0);
		sleep_s (6);
		ai_erase (AI.sq_flight_spirit_02);
end


function cs_flight_banshee_01()
	SleepUntil(  [| gb_flight_banshees_intro_launch ], 1);
		cs_vehicle_speed ( 1.0 );
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_27, 0);
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_29, 0);
		cs_shoot_at(true, OBJECTS.cr_flight_tank_04 );
				if object_valid ("cr_flight_tank_04") then
		
			object_damage_damage_section(OBJECTS.cr_flight_tank_04, "default", 1000);
		end
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_30, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_15, 0);
		cs_vehicle_boost( false );
		cs_shoot_at(true, OBJECTS.cr_flight_tank_02 );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_19, 0);
			if object_valid ("cr_flight_tank_02") then
		
			object_damage_damage_section(OBJECTS.cr_flight_tank_02, "default", 1000);
		end
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_31, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_23, 0);	
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_25, 0);

		ai_erase (AI.sq_flight_banshee_intro_01);
end

function cs_flight_banshee_02()
	SleepUntil(  [| gb_flight_banshees_intro_launch ], 1);
		cs_vehicle_speed ( 1.0 );
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_09, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_28, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_01, 0);	
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_21, 0);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_26, 0);

		ai_erase (AI.sq_flight_banshee_intro_02);
end

function cs_flight_banshee_03()
	SleepUntil(  [| gb_flight_banshees_intro_launch ], 1);
		cs_vehicle_speed ( 1.0 );
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_22, 0);
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_16, 0);
		cs_vehicle_boost( false );
		--ai_magically_see_object(ai_current_actor,OBJECTS.cr_flight_tank_01  );
		cs_shoot_at(true,OBJECTS.cr_flight_tank_01 );
		
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_33, 0);	
		if object_valid ("cr_flight_tank_01") then
		
			object_damage_damage_section(OBJECTS.cr_flight_tank_01, "default", 1000);
			Sleep(45);
			object_damage_damage_section(OBJECTS.cr_flight_tank_03, "default", 1000);
		end
		
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_28, 0);	
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_02, 0);	
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_10, 0);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_14, 0);
		ai_erase (AI.sq_flight_banshee_intro_03);
end

function cs_flight_banshee_04()
	SleepUntil(  [| gb_flight_banshees_intro_launch ], 1);
		cs_vehicle_speed ( 1.0 );
		cs_vehicle_boost( true );
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_17, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_01, 0);
		cs_fly_by (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_27, 0);	
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_12, 0);
		cs_fly_to (ai_current_actor, true, POINTS.ps_flight_banshee_intro.s_13, 0);

		ai_erase (AI.sq_flight_banshee_intro_04);
end




function f_close_phantom_door( phantom:object )
	ai_place( AI.sq_flight_null );
	Sleep(1);
	--ai_vehicle_enter_immediate(AI.sq_flight_null, phantom, "close_turret_doors");
	vehicle_load_magic ( phantom, "close_turret_doors", AI.sq_flight_null.door_seat);
	print("close door" , phantom );
end


function f_assault_scaleover_time( obj:object, scale_from:number, scale_to:number, seconds:number):boolean

	local frames:number = seconds_to_frames( seconds );
	
	local increment:number = -1; 
	local decrement:number = -1; 
	local current_scale:number = scale_from;
	local b_scale_up:boolean = scale_to > scale_from;
	
	--print("is a scale up: ", b_scale_up );
	
	--print("FRAMES :", frames );
	if frames <= 0 then 
		return false;
	end
	
	if b_scale_up then
			increment = ( scale_to - scale_from ) / frames;
			--print("Increment: " ,increment );
	else
		decrement = ( scale_from - scale_to ) / frames; 
		--print("Decrement: " ,decrement );
	end

	for i = 1 , frames do
		if b_scale_up then
			current_scale = current_scale + increment;
			if current_scale >= scale_to then
				current_scale = scale_to;
			end
		else
			
			current_scale = current_scale - decrement;
			--print( "should dec to", current_scale);
			if current_scale < scale_to then
				--print("hmmm");
				current_scale = scale_to;
			end

		end
		
		--print("Current scale: ", current_scale);
		object_set_scale ( obj,current_scale, 0 );
		Sleep(1);
		

	end
		object_set_scale ( obj,scale_to, 0 );
	return true;


end









