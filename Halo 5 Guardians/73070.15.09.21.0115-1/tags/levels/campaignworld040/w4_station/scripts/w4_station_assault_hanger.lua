--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- HANGAR
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------


global n_hangar_objcon:number = 0;
global b_hangar_fight_begin:boolean = false;
global b_hangar_fight_end:boolean = false;
global b_debug_hangar_extra_hunters:boolean = false;
global n_hangar_extra_hunter_count:number = 0;
global b_hangar_extra_hunters_active:boolean = false;
global b_hangar_fuel_objective_active:boolean = false;
global b_hangar_fuel_objective_complete:boolean = false;
global b_hangar_destroy_objective_active:boolean = false;
global b_hangar_destroy_objective_complete:boolean = false;
global b_hangar_50_percent:boolean = false;
global b_hangar_critical:boolean = false;

AssaultOnTheStation.goal_hangar = 

{
	--gotoVolume = VOLUMES.tv_hangar_init,
	zoneSet = ZONE_SETS.zs_05,
	--next={"goal_hangar"},

}

function blink_hangar():void
	ai_erase_all();
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_hangar", FLAGS.fl_hangar_01);
	f_blink_clear_blips();
	CreateThread(audio_assault_stopallmusic);
	--physics_set_gravity( 1.0 );
	b_flight_end = true;
	b_tun_assault_range = true;
	gb_flight_found_exit = true;
	TurnOffAllSpartanFlashlights();
end

function blink_hangar_extra_hunters():void

	b_debug_hangar_extra_hunters = true;
	ai_erase_all();
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_hangar", FLAGS.fl_hangar_01);
	f_blink_clear_blips();
	CreateThread(audio_assault_stopallmusic);
	--physics_set_gravity( 1.0 );
	b_flight_end = true;
	b_tun_assault_range = true;
	TurnOffAllSpartanFlashlights();
	
	--object_create_folder( "cr_reactor" );
end

function AssaultOnTheStation.goal_hangar.Start() :void    

		object_create_folder( "dms_hangar" );
		if b_flight_begin then
			print("hangar waiting for flight to end");
			SleepUntil( [| b_flight_end ],1);	
		
		else
			print("flight was not active continuing to hanagar")
		end
		----zone_set_trigger_volume_enable( "zone_set:zs_05", false );
		TurnOffAllSpartanFlashlights();
		CreateThread( f_hangar_breadcrumbs );
		Sleep(1);
		--gb_flight_found_exit = true;
		device_set_power(OBJECTS.dm_arrival_door_04, 1);
		device_set_power(OBJECTS.dm_arrival_door_02, 1);
		print("Hanger init");
		f_intro_cleanup();
		f_shipyard_cleanup();
		f_reactor_cleanup();
		f_hunter_cleanup();
		--Sleep(1);
		Wake( dormant.w4_assault_hangar_init );
		Sleep(1);
		object_create_folder( "crs_hangar" );
		Sleep(3);
			
		garbage_collect_now();
		--physics_set_gravity( 1 );
		assault_game_save_no_timeout();
		f_hangar_create_flocks();
		CreateThread(f_hangar_shake_loop);
		CreateThread(nar_goal_assault_hangar); 
		CreateThread( f_hangar_bring_forward );
		CreateThread(f_hangar_entrance_door );
--		f_blip_flag( FLAGS.fl_hangar_start, "default" );
		Wake( dormant.f_hangar_objcon_controller );
		Wake( dormant.f_hangar_general_watcher );
			
end

function dormant.w4_assault_hangar_init()
	--SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_banshee_exit ) ],1);

	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_init ) ],1);
		
		--CreateThread( f_player_area_text , "Hangar");
		--f_unblip_flag( FLAGS.fl_hangar_start );		
		
		CreateThread( f_hangar_spawning_manager );
		CreateThread(f_hangar_door);
		--object_create_folder( "sn_hangar");
		CreateThread( f_flight_destroy_flocks );
		
		object_create_folder( "wpns_hangar_early" );
end

function f_hangar_breadcrumbs()

	SleepUntil( [| gb_flight_found_exit ],1); 
		sleep_s(1);
		object_create("sn_obj_hangar_window");
	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_window_blip ) ],1);
		sleep_s(2);
		object_destroy( OBJECTS.sn_obj_hangar_window );
		Sleep(3);	
		object_create("sn_obj_hangar_dropdown");
	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_bring_players_forward ) ],1);
		object_destroy( OBJECTS.sn_obj_hangar_dropdown );
		Sleep(3);
		object_create("sn_obj_hangar_big_door");
	SleepUntil( [| device_get_position( OBJECTS.dm_arrival_door_01 ) > 0 ],1);
		object_destroy( OBJECTS.sn_obj_hangar_big_door );
end


function debug_hangar_crates()
	object_create_folder( "crs_hangar" );
end

function f_hangar_entrance_door()

	--repeat
	--Sleep(1);
	print("open");
	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_entrance_open_door ) ],1);
		--CreateEffectGroup(EFFECTS.fx_hangar_door_broken);
		device_set_position( OBJECTS.dm_arrival_door_04,1.0 );
	--until b_hangar_fight_begin;

end

function f_hangar_door() 
	--print("hey");
	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_open_door ) ],1);
		print("turn on door power");
		sleep_s(2.5);
		object_create_folder( "wpns_hangar" );
		assault_game_save_no_timeout();
		device_set_power(OBJECTS.dm_arrival_door_01, 1);
		device_set_position( OBJECTS.dm_arrival_door_01,0.8 );
		CreateThread(audio_prowler_door_open);
		sleep_s(2);
		b_hangar_fight_begin = true;
		--CreateThread(audio_assault_thread_up_hangar_fight);
		ai_braindead(AI.sg_hangar_initial, false);
		ai_braindead(AI.sq_hangar_jacks_r_intro, false);
		ai_set_blind(AI.sq_hangar_jacks_r_intro, false);
		ai_set_deaf(AI.sq_hangar_jacks_r_intro, false);
		
		--device_set_power(OBJECTS.dm_arrival_door_1, 1);
		
		
		
		--f_hangar_objective();
		--f_hangar_objective_4();
		--device_set_position( OBJECTS.dm_arrival_door_1,1 );
end

function f_hangar_create_flocks()

	flock_create("aiflock_hangar_banshees01");
	flock_create("aiflock_hangar_banshees02");
	
end

function f_hangar_bring_forward()
	SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_bring_players_forward ) ],1);
		print("airlock");
		TutorialStopAll();

		f_volume_teleport_all_not_inside(VOLUMES.tv_hangar_lobby, FLAGS.fl_hangar_forward_teleport);
		Sleep(2);
		--switch_zone_set(ZONE_SETS.zs_05);
		----zone_set_trigger_volume_enable( "zone_set:zs_05", true );

		device_set_position_immediate( OBJECTS.dm_arrival_door_04,0 );
		device_set_position_immediate( OBJECTS.dm_arrival_door_02, 0 );
		device_set_power( OBJECTS.dm_arrival_door_02, 0);
		CreateThread( f_hangar_fuel_generator_1 );

		f_flight_cleanup();
		Sleep(3);

end

function blah()

		device_set_position_immediate( OBJECTS.dm_arrival_door_02, 0 );
		device_set_power( OBJECTS.dm_arrival_door_02, 0);
end

function f_hangar_spawning_manager()

		SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_start_spawn ) ],1);
			ai_lod_full_detail_actors(25);
			--spawn initial command squad and grunts
			CreateThread( f_doomsday_ender_spawner_intro ,  AI.sg_hangar_initial ) ;
			--ai_place( AI.sq_hangar_jacks_r_intro );
			Sleep(3);
			ai_braindead(AI.sg_hangar_initial, true);
			Sleep(3);
			ai_braindead(AI.sq_hangar_jacks_r_intro, false);
			ai_set_blind(AI.sq_hangar_jacks_r_intro, true);
			ai_set_deaf(AI.sq_hangar_jacks_r_intro, true);
			print( ai_living_count( AI.sg_hangar_all ) );
		SleepUntil( [| volume_test_players(VOLUMES.tv_hangar_spawn_zealot ) ],1);
			--sleep_rand_s( 1,2.5 );
			
			local l_timer:number = timer_stamp( 25, 30 ); -- unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\storm_energy_sword\storm_energy_sword.weapon') )


			if coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then
				ai_place ( AI.sg_hangar_initial_coop ) ;
			end


		SleepUntil( [| volume_test_players_lookat(VOLUMES.tv_hangar_zealot_lookat, 30, 15 )  or timer_expired(l_timer) or n_hangar_objcon >= 30 ],1);
			--print("zeeeelots!!!!");
			--spawn zealots when player looks at their area
			print("total players = ", game_coop_player_count());
			if game_coop_player_count() >= 2 or game_difficulty_get_real() == DIFFICULTY.legendary then
				ai_place( AI.sq_hangar_zealots );

			else
			
				local index:number = random_range( 1 , 100 );
				print("path index ", index );

				ai_place( AI.sq_hangar_zealots.dark );
			end


						
			print( ai_living_count( AI.sg_hangar_all ) );
			local current_count:number = ai_living_count( AI.sg_hangar_all );
		SleepUntil( [| ai_living_count( AI.sg_hangar_all ) <= current_count - 3 or 
									( ai_living_count( AI.sq_hangar_zealots ) <= 0  and ai_living_count( AI.sg_hangar_all ) <= 3 )
									],1 ); --or

			sleep_s(4);
			b_hangar_fuel_objective_active = true;
			
			CreateThread( f_hangar_objective_ping_reminder );
	SleepUntil([|  b_hangar_fuel_objective_complete ] , 5 );			


			sleep_rand_s( 0.5, 1 );
			print("rangers");
			CreateThread( f_doomsday_saver_spawner, AI.sq_hangar_jacks_r_01 );
			--CreateThread(nar_ass_fuel_announcements);
			
			if coop_players_3() or game_difficulty_get_real() == DIFFICULTY.legendary then 
				CreateThread( f_doomsday_saver_spawner, AI.sq_hangar_jacks_r_08, 0 );
				sleep_s(1.5);
				CreateThread( f_doomsday_saver_spawner, AI.sq_hangar_jacks_r_09, 0 );
			end			
			
			print( ai_living_count( AI.sg_hangar_all ) );

			--reinforcements							
			Sleep(5);
			print( ai_living_count( AI.sg_hangar_all ) );
			--current_count = ai_living_count( AI.sg_hangar_all );
			CreateThread( f_hangar_underground_save );
		SleepUntil( [| ( ai_living_count( AI.sq_hangar_zealots ) <= 0  and ai_living_count( AI.sg_hangar_all ) <= 6 )
									],1 ); --or
			
			game_save_no_timeout();
			
			sleep_s( 1 );
			
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_05 );
			sleep_s( 1 );
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_jacks_r_05 );
			sleep_s( 2 );
			--CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_jacks_r_06 );
			
			sleep_s( 2);
			game_save();
			Sleep(5);
			RunClientScript("f_assault_cl_hunter_camera_shake");
			--sleep_rand_s( 8, 10.5 );
			--RunClientScript("f_assault_cl_hunter_camera_shake");
			CreateThread(nar_ass_fuel_announcements);
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_hunters );

			print("HUNTERS!");
			--Sleep(2);
			CreateThread(nar_ass_hangar_hunters);
			sleep_rand_s( 5, 7.5 );
			--f_player_area_text("HUNTERS!");
			SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_prowlerappear.sound'), nil, 1);
			
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_02_a );
			Sleep(15);
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_02_b );

			Sleep(60);
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_jacks_r_03 );	
			Sleep(60);
			CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_jacks_r_04 );
			
			
			if coop_players_3() then
				sleep_s(2);
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_02_c );
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_02_d );
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_jacks_r_06 );
			end
			--sleep_rand_s( 10, 13 );
			current_count = ai_living_count( AI.sg_hangar_all );
			
			
			--sleep_rand_s( 15, 20 );
		SleepUntil( [| ai_living_count( AI.sg_hangar_all ) <= 7 and ai_living_count( AI.sq_hangar_hunters ) <= 1 ], 1 );		
			CreateThread(nar_ass_hunters_dead2);
			CreateThread(nar_ass_fuel_announcements);
			b_hangar_50_percent = true;
			
			
			if  game_difficulty_get_real() ~= DIFFICULTY.legendary then
				game_save();
			end
			sleep_rand_s( 3, 5 );
			--b_hangar_destroy_objective_active = true;
			
			if ( b_assault_hunter_begin and b_assault_hunter_complete ) or b_debug_hangar_extra_hunters then

				if  (not b_hunter_anvil_died )   or b_debug_hangar_extra_hunters then
					print("placing extra hunter Anvil");
					CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_tunnel_hunters.anvil );
					n_hangar_extra_hunter_count = n_hangar_extra_hunter_count + 1;
					b_hangar_extra_hunters_active = true;
				end
				
				if ( not b_hunter_ballista_died ) or b_debug_hangar_extra_hunters then
					print("placing extra hunter Ballista ");
					CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_tunnel_hunters.ballista );
					n_hangar_extra_hunter_count = n_hangar_extra_hunter_count + 1;
					b_hangar_extra_hunters_active = true;
				end

				if b_hangar_extra_hunters_active then
											
						SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_prowlerappear.sound'), nil, 1);
						sleep_s(1);
						RunClientScript("f_assault_cl_hunter_camera_shake");
				end
				
				sleep_s(3);

				--sleep_rand_s( 10, 13 );
			end
			
			CreateThread( f_hangar_achievo );
		--SleepUntil([|  b_hangar_destroy_objective_complete ] , 5 );	
		
			if  game_difficulty_get_real() ~= DIFFICULTY.legendary then
				game_save();
			end
			
			CreateThread( f_doomsday_saver_spawner, AI.sq_hangar_general_command );
			
			sleep_rand_s( 0.5, 1 );
			
			if coop_players_3()  then
				sleep_rand_s( 2, 3 );
				CreateThread( f_doomsday_saver_spawner , AI.sq_hangar_command_coop ) ;
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_04 );
			end			
			CreateThread( f_doomsday_saver_spawner, AI.sq_hangar_jacks_r_07, 0 );
			print( ai_living_count( AI.sg_hangar_all ) );
			current_count = ai_living_count( AI.sg_hangar_all );
			--sleep_rand_s( 15, 20 );
			
		SleepUntil( [| ai_living_count( AI.sg_hangar_all ) <= current_count - 2 or ai_living_count( AI.sg_hangar_all ) <= 9 ], 1 );
				print("----- xtra grunts -----");
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_03_a );
				CreateThread( f_doomsday_ender_spawner, AI.sq_hangar_grunts_03_b );
				Sleep(2);
			--	CreateThread(nar_ass_hangar_reinforcements);
				CreateThread(nar_ass_fuel_announcements);
				b_hangar_critical = true;
				print( ai_living_count( AI.sg_hangar_all ) );
				
				zone_set_trigger_volume_enable( "begin_zone_set:zs_05", false );
				zone_set_trigger_volume_enable( "zone_set:zs_05", false );
				sleep_s( 2);
				game_save_no_timeout();
		SleepUntil( [| ai_living_count( AI.sg_hangar_critical ) <= 0 and ai_living_count( AI.sg_hangar_grunts ) <= 1  and ai_living_count( AI.sg_hangar_rangers ) <= 1 and not volume_test_objects( VOLUMES.tv_hangar_top_level, AI.sg_hangar_rangers ) ] , 1 );
			print("mission ending");
			prepare_to_switch_to_zone_set(ZONE_SETS.cin050_exterior);
			sleep_s( 2);
			--CreateThread( f_assault_complete_objective );
			f_hangar_escape_to_area();  --BLOCKING ON PURPOSE
			 
			
			for _,spartan in ipairs (spartans()) do  
				CreateThread(f_hangartemp_invul, spartan);
			end
		
			
			sleep_s( 1 );
			b_hangar_fight_end = true;
			
			CreateThread(audio_assault_thread_up_mission_end);
			
			
			

			StopEffectGroup(EFFECTS.hangar_exit_sparks01);	
			--CreateThread( f_player_area_text , "Mission Complete: Halo and his friends are victorious");
			g_b_assault_mission_complete = true;


end

function f_hangar_objective_ping_reminder()

	
	repeat
		sleep_s(15);
		if not b_hangar_fuel_objective_complete then
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 5 );	
		end
	until b_hangar_fuel_objective_complete;


end

function f_hangar_escape_ping_reminder()

	
	repeat
		sleep_s(20);
		if not b_hangar_fight_end then
			CreateThread( f_assault_popup_dislay_tutorial_setup,  "training_objective", 8 );	
		end
	until b_hangar_fight_end;


end

function f_hangar_spawn_zealots()
	if game_coop_player_count() >= 2 or game_difficulty_get_real() == DIFFICULTY.legendary then
		ai_place_in_limbo(AI.sq_hangar_zealots);
	else
		ai_place_in_limbo(AI.sq_hangar_zealots.dark);
	end
end
 
function f_hangar_underground_save()
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_underground_save ) ], 1);
		game_save_no_timeout();
end

function f_hangar_escape_to_area()
	
	CreateThread(audio_assault_thread_up_hangar_end);
	Sleep(2);
	--CreateThread( f_ass_objective_pulse , OBJECTS.sn_obj_hangar_escape, 8 );
	CreateThread(nar_ass_combat_complete);
	sleep_s(4);
	object_create("sn_obj_hangar_escape");
	CreateEffectGroup(EFFECTS.hangar_exit_sparks01);	
	sleep_s(6);
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_escape ) ], 1);
		CreateThread( f_hangar_escape_ping_reminder );
		ai_kill( AI.sg_hangar_all );
		object_destroy( OBJECTS.sn_obj_hangar_escape );
		
end

function f_hangartemp_invul(spartan:object):void
	unit_falling_damage_disable(spartan, true);
	object_cannot_take_damage(spartan);
	object_cannot_die(spartan, true);
end
	
	
function f_hangar_fuel_generator_1()

	object_cannot_take_damage( OBJECTS.cr_hangar_generator01 );
	
	SleepUntil([|  b_hangar_fuel_objective_active or volume_test_players( VOLUMES.tv_hangar_generator ) ] , 5 );
		CreateThread(nar_ass_launch_startit);
		device_set_power(  OBJECTS.hum_keypad_generator, 1 );
		--f_blip_object( OBJECTS.hum_keypad_generator, "default");
		object_create( "sn_obj_hangar_generator" );
		--CreateThread( f_hangar_objective_2 );
		Sleep(3);
		--CreateThread( f_ass_objective_pulse, OBJECTS.sn_obj_hangar_generator );
	SleepUntil([|  device_get_position  (OBJECTS.hum_keypad_generator) >= 0.2 ] , 1 );	
		b_hangar_fuel_objective_complete = true;
		object_destroy( OBJECTS.sn_obj_hangar_generator );
		game_save();

end

function f_activator_get_generator(trigger:object, activator:object ) 
	print("generator activated");
	CreateThread(audio_generator_activated);
	CreateThread(audio_assault_thread_up_hangar_switch);
	 --RunClientScript("f_cl_halogram_ics", trigger, activator);
	local this_activator:object = activator or PLAYERS.player0 ;
	
	composer_play_show("vin_player_ics_hangar", { ics_player = this_activator});
	
end


function f_hangar_fuel_generator_2()


	
	SleepUntil([|  b_hangar_destroy_objective_active ] , 5 );

		b_hangar_destroy_objective_complete = true;
		f_unblip_object( OBJECTS.hum_keypad_generator);
		
		sleep_s(3);


end



function f_hangar_achievo()

	if b_hangar_extra_hunters_active then
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_prowlerappear.sound'), nil, 1);
		print("HUNTER ACHIEVEMENT UNLOCKED");
		CampaignScriptedAchievementUnlocked( 3 ) ;
	--	print("HUNTER ACHIEVEMENT UNLOCKED");
	--	print("HUNTER ACHIEVEMENT UNLOCKED");
	--	print("HUNTER ACHIEVEMENT UNLOCKED");
	--	print("HUNTER ACHIEVEMENT UNLOCKED");
	end
end


global gb_hangar_general_dead:boolean = false;


function dormant.f_hangar_general_watcher()

		-- 2 possible spawn points for general
	SleepUntil([| (ai_spawn_count( AI.sq_hangar_general_command.general_pookie) > 0 and ai_living_count( AI.sq_hangar_general_command.general_pookie) < 0 )	 ], 1);
		print("the king is dead!");
		gb_hangar_general_dead = true;
	
end

function dormant.f_hangar_objcon_controller()

	print("hangar objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_objcon_10 ) or n_hangar_objcon >= 10 ], 1);
		if n_hangar_objcon <= 10 then
			n_hangar_objcon = 10;
			print("n_hangar_objcon = 10 ");
		end


		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_objcon_20 ) or n_hangar_objcon >= 20 ], 1);
		if n_hangar_objcon <= 20 then
			n_hangar_objcon = 20;
			print("n_hangar_objcon = 20 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_objcon_30 ) or n_hangar_objcon >= 30 ], 1);
		if n_hangar_objcon <= 30 then
			n_hangar_objcon = 30;
			print("n_hangar_objcon = 30 ");
		end		


	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_objcon_40 ) or n_hangar_objcon >= 40 ], 1);
		if n_hangar_objcon <= 40 then
			n_hangar_objcon = 40;
			print("n_hangar_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_objcon_50 ) or n_hangar_objcon >= 50 ], 1);
		if n_hangar_objcon <= 50 then
			n_hangar_objcon = 50;
			print("n_hangar_objcon = 50 ");
		end
				
end



function cs_active_camo_use()

		print( "cs_active_camo_use: ENABLED" );
		CreateThread( f_ai_active_camo_manager, ai_current_actor );

end

function f_hangar_off_camo( camo_dude:ai )
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_the_bridge, ai_get_object(camo_dude) )  ], 1);
	
end


function cs_set_active_camo( dude:ai )

		sleep_rand_s( 2.25, 2.5);


		print( "cs_active_camo_use: ENABLED" );
		
		ai_set_active_camo( dude, true );
		

	CreateThread( f_hangar_active_camo_manager, dude );
end

global gb_route_switch: boolean = false;

function cs_active_camo_use_delay()



	
	--cs_jump(30,2);
	if gb_route_switch then
		
		print("left");
		CreateThread( cs_set_active_camo , ai_current_actor );
		cs_abort_on_damage( true );
		cs_go_to( POINTS.ps_hangar_move_points.p0, 3 );
		
		cs_go_to( POINTS.ps_hangar_move_points.p02, 3 );
		
		--cs_go_to( POINTS.ps_hangar_move_points.p06, 3 );
		--cs_go_to( POINTS.ps_hangar_move_points.p07, 3 );
	else
	print("right");
		gb_route_switch = true;
		CreateThread( cs_set_active_camo , ai_current_actor );
		cs_abort_on_damage( true );
		cs_go_to_and_face(  POINTS.ps_hangar_move_points.p01, POINTS.ps_hangar_move_points.pface_entrance );
		Sleep(45);
		cs_go_to( POINTS.ps_hangar_move_points.p03, 3 );
		cs_go_to( POINTS.ps_hangar_move_points.p04, 3 );
		
		cs_go_to(  POINTS.ps_hangar_move_points.p08, 3 );
		--cs_go_to( POINTS.ps_hangar_move_points.p09, 3 );
		--cs_go_to( POINTS.ps_hangar_move_points.p10, 3 );
		--cs_go_to( POINTS.ps_hangar_move_points.p11, 3 );
		--cs_go_to( POINTS.ps_hangar_move_points.p05, 3 );
	end
	

	--cs_move_towards_point( POINTS.ps_hangar_move_points[random_range(1, 2)], 2 );
	--cs_move_towards_point( POINTS.ps_hangar_move_points[random_range(3, 4)], 2 );
	--cs_move_towards_point( POINTS.ps_hangar_move_points[random_range(5, 6)], 2 );
	
end


function cs_get_off_prowler_left()
		Sleep(60);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p01, 3 );
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p02, 3 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p03, 5 );
	
		
end

function cs_get_off_prowler_left_camo()
		Sleep(60);
		ai_set_active_camo( ai_current_actor , true );
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p01, 3 );
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p02, 3 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p03, 5 );
	
		
end

function cs_get_off_prowler_leftb()
		Sleep(60);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p21, 3 );
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p22, 3 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p03, 5 );
	
		
end

function cs_get_off_prowler_right()
		Sleep(60);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p04, 3 );
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p05, 3 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p06, 5 );

		
end

function cs_get_off_prowler_right_camo()

		Sleep(60);
		ai_set_active_camo( ai_current_actor , true );
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p04, 3 );
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p05, 3 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p06, 5 );

		
end



function cs_get_off_high_shelf()
		Sleep(60);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p18, 3 );
		

		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p20, 5 );

		
end
global n_wait_shelf:number = 0;

function cs_get_off_high_shelf_b()
		if n_wait_shelf == 0 then
			n_wait_shelf = 3;
		else
			sleep_rand_s(n_wait_shelf, n_wait_shelf + 2);
		end
		CreateThread( cs_release_drop_in, ai_current_actor );
		--cs_go_to_and_face( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p19, POINTS.ps_hangar_spawn_prower.p20 );
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p19, 2 );
		--Sleep(9999999);
		

		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p20, 5 );	
end

function cs_get_off_drop_left()
		Sleep(60);
		
		cs_go_to( ai_current_actor, true, POINTS.ps_hangar_spawn_prower.p_drop_1, 3 );
		CreateThread( cs_release_drop_in, ai_current_actor );		
end
--
function cs_release_drop_in( dude:ai )

	SleepUntil([| not volume_test_objects( VOLUMES.tv_hangar_doomsday_ender , ai_get_object( dude ) ) ] ,2 );
		print("out ", dude, " ",ai_get_object( dude ) );
		cs_run_command_script( dude, "cs_hangar_path_clear" );

end

function cs_hangar_path_clear( )
	print("clear");
end

function cs_start_active_camo()
	Sleep(5);
	print("start bg camo");
	CreateThread( f_hangar_active_camo_manager_bodyguard, ai_current_actor );
end

function f_hangar_active_camo_manager( ai_actor:ai ):void
 local l_timer:number = 0;
 local obj_actor:object  = ai_get_object( ai_actor );
	print( "cs_active_camo_use: ENABLED" );

	repeat
	
		-- activate camo
		if ( unit_get_health(ai_actor) > 0.0 ) then
			ai_set_active_camo( ai_actor, true );
			print( "f_active_camo_manager: ACTIVE" ); 
		end
		
		-- disable camo
		--print( objects_distance_to_object(players(),obj_actor) );
		SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or   objects_distance_to_object(players(),obj_actor) < 9.00  or ((object_get_recent_body_damage(obj_actor) + object_get_recent_shield_damage(obj_actor)) > 0.2) ], 3 );
			if ( unit_get_health(ai_actor) > 0.0 ) then
				ai_set_active_camo( ai_actor, false );
				print( "f_active_camo_manager: DISABLED" ); 
			end
		
		-- manage resetting
		if ( unit_get_health(ai_actor) > 0.0 ) then
			l_timer = timer_stamp( 4, 7.0 ); -- unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\storm_energy_sword\storm_energy_sword.weapon') )
			SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or (timer_expired(l_timer) and ( objects_distance_to_object( players(),obj_actor) >= 9.00 ) ) ], 1 );
			
			
			if unit_has_weapon(ai_actor, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon' ) ) and not unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon') ) then
				--print("ai switching back to sword");
				ai_swap_weapons( ai_current_actor);
			end
		
		end

		Sleep(1);
	until ( unit_get_health(ai_actor) <= 0.0 );


end


function f_hangar_active_camo_manager_bodyguard( ai_actor:ai ):void
 local l_timer:number = 0;
 local obj_actor:object  = ai_get_object( ai_actor );
	--print( "cs_active_camo_use: ENABLED" );

	repeat
	
		-- activate camo
		if ( unit_get_health(ai_actor) > 0.0 ) then
			ai_set_active_camo( ai_actor, true );
			--print( "f_active_camo_manager: ACTIVE" ); 
		end
		
		-- disable camo
		--print( objects_distance_to_object(players(),obj_actor) );
		SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or   objects_distance_to_object(players(),obj_actor) <= 10  or ((object_get_recent_body_damage(obj_actor) + object_get_recent_shield_damage(obj_actor)) > 0.2) ], 3 );
		if ( unit_get_health(ai_actor) > 0.0 ) then
			ai_set_active_camo( ai_actor, false );
			--print( "f_active_camo_manager: DISABLED" ); 
		end
		
		-- manage resetting
		if ( unit_get_health(ai_actor) > 0.0 ) then
			l_timer = timer_stamp( 2.5, 5.0 ); -- unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\storm_energy_sword\storm_energy_sword.weapon') )
			SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or (timer_expired(l_timer) and ( objects_distance_to_object( players(),obj_actor) >= 15.1 ) ) ], 1 );
			
			
			if unit_has_weapon(ai_actor, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon' ) ) and not unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon') ) then
				--print("ai switching back to sword");
				ai_swap_weapons( ai_current_actor);
			end
		
		end

		Sleep(1);
	until ( unit_get_health(ai_actor) <= 0.0 );


end

function cs_hangar_hunter_jumpster()
	print("a hunter");
	--cs_go_to( POINTS.ps_hangar_move_points.hunterbash, 1);
	--cs_face( true, POINTS.ps_hangar_move_points.plifta01 );
	

	CreateThread( cs_release_drop_in, ai_current_actor );
	CreateThread( cs_hangar_hunter_jumpster_safety , ai_current_actor );
		cs_smash_direction(45);
	Sleep(10);
	cs_smash_direction(45);
	--cs_go_to_and_face( POINTS.ps_hangar_move_points.hunterbash, POINTS.ps_hangar_move_points.plifta01);
	--cs_go_to( POINTS.ps_hangar_move_points.hunterbash, 2.5);
	--Sleep(60);
	cs_go_to( POINTS.ps_hangar_move_points.hunterbash01, 3);
	cs_smash_direction(45);
	Sleep(10);
	cs_smash_direction(45);
	--cs_jump( 20,4);
	--Sleep(60);
	--CreateThread( cs_release_drop_in, ai_current_actor );
	
	cs_go_to( POINTS.ps_hangar_move_points.hunterbash01, 3);

	--cs_go_to( POINTS.ps_hangar_move_points.hunterbash02, 1);

	cs_abort_on_damage( true );
	--SleepForever();
end

function cs_hangar_hunter_jumpster_safety( hunter:ai )
	sleep_s(13);
	if volume_test_objects ( VOLUMES.tv_hangar_doomsday_ender , ai_get_object( hunter) ) then
		--print("still a hunter");
		--cs_go_to_and_face( POINTS.ps_hangar_move_points.hunterbash, POINTS.ps_hangar_move_points.plifta01);
		--cs_jump( 30,3);
		object_teleport( ai_get_object( hunter) , FLAGS.fl_hangar_failsafe_hunter );
		--cs_smash_direction( hunter, true, 45);
		--cs_go_to( hunter, POINTS.ps_hangar_move_points.hunterbash01, 1);
		
	end
end

function cs_hangar_hunter_shafty()


	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_shaft_b_lift , ai_actors( ai_current_actor))  ], 1);
		--print("in vol");
		--cs_move_towards_point( POINTS.ps_hangar_move_points.pliftb, 1);
		cs_go_to( POINTS.ps_hangar_move_points.pliftb01, 2);
		cs_jump( 30,3.5);
		print("go shafty");
		--sleep_s(1.75);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( POINTS.ps_hangar_move_points.pliftb02, 7);
		--cs_smash_direction(45);
		print("go shafty");
		--sleep_s(0.25);
		cs_abort_on_damage( true );
	---	cs_smash_direction(45);
		--cs_jump( 30,4.3);
		
		--cs_go_to( POINTS.ps_hangar_move_points.pliftb02, 1);

end


function cs_hangar_hunter_anvil()
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_shaft_b_lift , ai_actors( ai_current_actor))  ], 1);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( POINTS.ps_hangar_move_points.pliftb03, 2);
		--cs_jump( 30,4.3);
		--Sleep(100);
		--cs_jump( 30,4.3);
		cs_abort_on_damage( true );
		

end


function cs_hangar_hunter_ballista()
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_shaft_a_lift , ai_actors( ai_current_actor))  ], 1);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( POINTS.ps_hangar_move_points.plifta03, 2);
		
		--cs_jump( 30,4.3);
		--Sleep(100);
		--cs_jump( 30,4.3);
		cs_abort_on_damage( true );
		
		
end

function cs_hangar_shaft_right()
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_shaft_b_lift , ai_actors( ai_current_actor))  ], 1);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( POINTS.ps_hangar_move_points.pliftb03, 2);
		--cs_jump( 30,4.3);
		--Sleep(100);
		--cs_jump( 30,4.3);
		cs_abort_on_damage( true );
		

end


function cs_hangar_shaft_left()
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_hangar_shaft_a_lift , ai_actors( ai_current_actor))  ], 1);
		CreateThread( cs_release_drop_in, ai_current_actor );
		cs_go_to( POINTS.ps_hangar_move_points.plifta03, 2);
		
		--cs_jump( 30,4.3);
		--Sleep(100);
		--cs_jump( 30,4.3);
		cs_abort_on_damage( true );
		
		
end

function cs_hangar_jackal_clementine()
	SleepUntil ([| volume_test_players ( VOLUMES.tv_hangar_jackal_showoff )  ], 1);
		cs_go_to( POINTS.ps_hangar_move_points_01.p15, 0.5);
		sleep_s(3);
		cs_go_to( POINTS.ps_hangar_move_points_01.p14, 0.5);
	SleepUntil ([| b_hangar_fight_begin  ], 1);
		
end

-- this is a safety precaution to kill any ai that happen to get stuck on top of the prowler
function f_doomsday_ender_spawner( this_squad:ai )
	ai_place( this_squad );
	SleepUntil ([| ai_living_count( this_squad ) > 0  ], 1);	
		sleep_s( 45 );
		local obj_list = {};
		local squad_list = ai_actors( this_squad );
		
	 	obj_list = ai_get_all_in_trigger_volume ( VOLUMES.tv_hangar_doomsday_ender );
	 	
	 	for i, doomed in ipairs( squad_list ) do
	 		--print( "Doomed?!", doomed );
		 	for _, v in ipairs( obj_list ) do
		 		if v == doomed then
		 			print( "Doomsday!", doomed );
		 			ai_kill( object_get_ai( doomed ) );
		 		end
		 	end
		end
	 
end


function f_doomsday_ender_spawner_intro( this_squad:ai )
	ai_place( this_squad );
	SleepUntil ([| ai_living_count( this_squad ) > 0  and b_hangar_fight_begin ], 2);	
		sleep_s( 25 );	
		local obj_list = {};
		local squad_list = ai_actors( this_squad );
		
	 	obj_list = ai_get_all_in_trigger_volume ( VOLUMES.tv_hangar_doomsday_ender );
	 	
	 	for i, doomed in ipairs( squad_list ) do
		 	for _, v in ipairs( obj_list ) do
		 		if v == doomed then
		 			print( "Doomsday!", doomed );
		 			ai_kill( object_get_ai( doomed ) );
		 			
		 		end
		 	end
		end
	 
end

function f_doomsday_saver_spawner( this_squad:ai, timer:number )
	local time:number = timer or 25;
	ai_place( this_squad );
	SleepUntil ([| ai_living_count( this_squad ) > 0  ], 1);	
		sleep_s( time );
		local obj_list = {};
		local squad_list = ai_actors( this_squad );
		
	 	obj_list = ai_get_all_in_trigger_volume ( VOLUMES.tv_hangar_doomsday_ender );
	 	
	 	for i, doomed in ipairs( squad_list ) do
	 		--print( "Doomed?!", doomed );
		 	for _, v in ipairs( obj_list ) do
		 		if v == doomed then
		 			print( "Doomsday!teleport", doomed );
		 			--ai_kill( object_get_ai( doomed ) );
		 			cs_run_command_script( object_get_ai( doomed ), "cs_hangar_path_clear" );
		 			object_teleport(  doomed  , f_find_safe_spawn_location() ); 
		 		end
		 	end
		end
	 
end

	global t_hangar_spawn_info:table = 
	{
		tv_hangar_failsafe_00 = { VOLUMES.tv_hangar_failsafe_00 , FLAGS.fl_hangar_failsafe_00, bUseRecently = false },
		tv_hangar_failsafe_01 = { VOLUMES.tv_hangar_failsafe_01 , FLAGS.fl_hangar_failsafe_01, bUseRecently = false },
		tv_hangar_failsafe_02 = { VOLUMES.tv_hangar_failsafe_02 , FLAGS.fl_hangar_failsafe_02, bUseRecently = false },
		tv_hangar_failsafe_03 = { VOLUMES.tv_hangar_failsafe_03 , FLAGS.fl_hangar_failsafe_03, bUseRecently = false },
		tv_hangar_failsafe_04 = { VOLUMES.tv_hangar_failsafe_04 , FLAGS.fl_hangar_failsafe_04, bUseRecently = false },
		tv_hangar_failsafe_05 = { VOLUMES.tv_hangar_failsafe_05 , FLAGS.fl_hangar_failsafe_05, bUseRecently = false },
		  
	};
function f_find_safe_spawn_location():flag

	local fl_location:flag = FLAGS.fl_hangar_failsafe_fubar;


	for _vol_table, v in pairs( t_hangar_spawn_info ) do
		--print( _vol_table, v, v[1] );
		if not v.bUseRecently and not volume_test_players(v[1] ) then
			v.bUseRecently = true;
			CreateThread( f_find_safe_spawn_location_clear );
			fl_location = v[2];
			--print( fl_location, v[2] );
			break;
		end
	end
	print( fl_location );
	return fl_location;
end

function f_find_safe_spawn_location_clear()
	sleep_s(0.75);
	for _vol_table, v in pairs( t_hangar_spawn_info ) do
			v.bUseRecently = false;
	end
end

function f_hangar_shake_loop()

	repeat
		
		if  b_hangar_critical then
			rumble_shake_medium();
			sleep_rand_s( 7, 10 );
		elseif b_hangar_50_percent then
			rumble_shake_small();
			sleep_rand_s( 7, 10 );
		else
			rumble_shake_small();
			sleep_rand_s( 11, 13 );
		end
		
	until g_b_assault_mission_complete ; 

end

function f_test_doomsday()

	f_doomsday_saver_spawner( AI.sq_hangar_general_command );
	--ai_place( AI.sq_hangar_command_coop );
	sleep_s( 1);
	--f_doomsday_ender_spawner( AI.sq_hangar_command_coop )
	
end


function hangar_living_count()

	print( ai_living_count( AI.sg_hangar_all ) );
end

