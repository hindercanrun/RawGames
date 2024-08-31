--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 Sentinels*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



--  ****************************************************************************************** --
--  ********************  			      GOAL 1 - MUSEUM &              ************************* --
--  ********************  			      GOAL 2 - GONDOLA                ************************* --
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
--  ********************  			      GOAL 4 - GATE                  *********************** --
--  **************************************************************************************** --

global n_lilbowl_objcon:number = 0;
global vin_endgame:number = -1;
global b_itty_start:boolean = false;
global b_itty_done:boolean = false;
global b_lilbowl_begin_fight:boolean = false;
global b_lilbowl_all_spawned:boolean = false;

missionSentinels.goal_gate = 

	{
	
	gotoVolume = VOLUMES.tv_goal_cores,
	next={"goal_cores"},
	zoneSet = ZONE_SETS.zn_lilbowl,

	}


function missionSentinels.goal_gate.Start() :void		

	--CreateThread(audio_sentinels_thread_up_gondola_exit);
	print ("goal_gate starting...");
	object_create("road_objective");
	ai_disable_jump_hint(HINTS.jh_lil_mid_door );
	b_museShowStop = true;
	MusketeerUtil_SetDestination_Clear_All();
	CreateThread(f_snow_effect_call);
	CreateThread(f_lil_save);
	CreateThread(audio_cortana_smallbowl_activate);
	print ("attempting to save...");
	--object_create_folder("mod_gond_racks");
		--	NARRATIVE CALL
		CreateThread(sentinels_gate_wake);
	CreateThread ( f_monitor_volume_checks );
	--object_create_folder("mod_lilbowl");
	--object_create ("dm_lb_gate03");
	--object_create ("dm_lb_gate04");
	CreateThread( f_lil_wait_for_zoneset_load );
	CreateThread(f_lilbowl_objcon);
	CreateThread (f_gate_blip);
	CreateThread( f_lilbowl_begin_fight );
		CreateThread( f_endgame_vignette_wait );
	--composer_stop_show(vin_w3_guardians);
	----CreateThread( f_hub_guardian_set_done ); -- temp till i get ahold of that vignette
	--vin_endgame = pup_play_show ("vin_w3_endgame");
	--spawn

	ObjectiveShow (TITLES.obj_sen_2);
	CreateThread(SpawnLilBowl);
	CreateThread(audio_cortana_smallbowl_deactivate);
	SleepUntil ([|volume_test_players (VOLUMES.tv_mid_gate_open)], 1);
		print ("opening mid-gate");
		game_save_no_timeout();
	

	
		--device_set_power (OBJECTS.dm_lb_mid_gate, 1);
		device_set_position (OBJECTS.dm_lb_mid_gate, 1);
		object_destroy(OBJECTS.road_objective);
		Sleep(5);
		object_create("lilbowl_objective");			
		CreateThread( f_itty_bowl_airlock );
	SleepUntil ([|device_get_position (OBJECTS.dm_lb_mid_gate) >= 0.1], 1);
		ai_place( AI.sq_lb_gateFor05 );
		
	SleepUntil ([|device_get_position (OBJECTS.dm_lb_mid_gate) >= 0.5], 1);
		b_itty_start = true;
		
		ai_enable_jump_hint(HINTS.jh_lil_mid_door );
		ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_mid_gate, false );

		SleepUntil ([|volume_test_players (VOLUMES.tv_mid_gate_spawn)], 1);
			f_sentinels_update_weapon_profile();
	
	
	
		SlipSpaceSpawn (AI.sq_lb_gateFor01);
		SlipSpaceSpawn (AI.sq_lb_gateFor02);
		sleep_s(0.5);
		SlipSpaceSpawn (AI.sq_lb_gateFor03);
		SlipSpaceSpawn (AI.sq_lb_gateFor04);


	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zn_bowl and volume_test_players ( VOLUMES.tv_gate_door_open ) ], 1);

		CreateThread( rumble_shake_medium );
		device_set_position (OBJECTS.dm_lb_gate02, 1);
		ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_gate02, false );	
		Wake( dormant.f_open_big_door );
		--sleep_s(1);
		

	
end


function f_lil_wait_for_zoneset_load()
	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zn_lilbowl ], 1);
		object_create_folder("mod_lilbowl");
		object_create ("dm_lb_gate03");
		object_create ("dm_lb_gate04");

end

function f_hub_guardian_set_done()
	 b_guardian_vin_done = true;
	print("xxxx xxxxx xxxx sb_guardian_vin_done true");
end

function f_endgame_vignette_wait()
	SleepUntil([|  b_guardian_vin_done or current_zone_set_fully_active() == ZONE_SETS.zn_lilbowl ], 1); --b_guardian_vin_done
		print("xxxx xxxxx xxxx stop guardian vignette");
		composer_stop_show(vin_w3_guardians);
		--Sleep(5);
		vin_endgame = composer_play_show ("vin_w3_endgame");
end


function f_snow_effect_call()

	SleepUntil([|volume_test_players(VOLUMES.tv_snow_trigger)],1);
		fx_vista_snow_kill();
		print ("killing vista FX");
end

function f_itty_bowl_airlock()
			--device_set_power (OBJECTS.dm_lb_mid_gate, 1);
		--device_set_position (OBJECTS.dm_lb_mid_gate, 0);	
		SleepUntil ([|volume_test_players (VOLUMES.tv_lilbowl_airlock_forward)], 1);
			f_volume_teleport_all_not_inside (VOLUMES.tv_itty_bowl_area, FLAGS.fl_ittybowl_airlock_teleport);	
				--device_set_power (OBJECTS.dm_lb_mid_gate, 1);
				device_set_position_immediate (OBJECTS.dm_lb_mid_gate, 0);	
				--object_create("dm_lb_mid_gate_blocker");
				Sleep(1);
				--device_set_position (OBJECTS.dm_lb_mid_gate_blocker, 0);
				ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_mid_gate, true );				
				if not volume_test_objects( VOLUMES.tv_itty_bowl_area, ai_get_object( f_sent_get_sassy() ) )then
					object_teleport( ai_get_object( f_sent_get_sassy()), POINTS.ps_monitor_breadcrumb.p_mid_door_bump);
					--print("force bumping sassy");
					n_monitor_clear_all = 1;
					n_monitor_wander_state = 0;
				end
				--device_set_power (OBJECTS.dm_lb_mid_gate, 0);
			SleepUntil( [| device_get_position(OBJECTS.dm_lb_mid_gate ) == 0 ] ,1 );	
				f_volume_teleport_all_not_inside (VOLUMES.tv_itty_bowl_area, FLAGS.fl_ittybowl_airlock_teleport);	
				if not volume_test_objects( VOLUMES.tv_itty_bowl_area, ai_get_object( f_sent_get_sassy() ) )then
					object_teleport( ai_get_object( f_sent_get_sassy()), POINTS.ps_monitor_breadcrumb.p_mid_door_bump);
					print("force bumping sassy");
					n_monitor_clear_all = 1;
					n_monitor_wander_state = 0;
				end
				
				sleep_s(1);
				n_monitor_clear_all = 0;
			--dm_lb_mid_gate
end



function SpawnLilBowl()
	local l_timer:number = -1;
	SleepUntil ([|volume_test_players (VOLUMES.tv_lilbowl_spawn)], 1);
	
		ai_place( AI.sg_lb_cov_left );
		Sleep(10);
		ai_place(AI.sg_lb_all_init);
		
		l_timer = timer_stamp( 45 );
		--ai_playfight( AI.sg_lb_all_init , true );
	SleepUntil ([|volume_test_players (VOLUMES.tv_lilbowl_spawn_slips) or timer_expired(l_timer) or b_monitor_wander_lil_1], 1);	
		SlipSpaceSpawn(AI.sq_lb_For05);
		sleep_s(1);
		SlipSpaceSpawn(AI.sq_lb_sniperFor01);
	SleepUntil ([|b_monitor_wander_lil_2 ], 1);
		SlipSpaceSpawn(AI.sq_lb_For03_sniper);
	SleepUntil ([|b_monitor_wander_lil_3 ], 1);
		SlipSpaceSpawn(AI.sq_lb_For01);
		
		sleep_s(3.5);
		b_lilbowl_all_spawned = true;
		
		
end

function f_lilbowl_begin_fight()
	SleepUntil ([|volume_test_players (VOLUMES.tv_lilbowl_begin_fight)], 1);
		b_lilbowl_begin_fight = true;
end

function f_gate_blip ()

	SleepUntil ([|volume_test_players (VOLUMES.tv_gate_door_open)], 1);
	
	object_destroy(OBJECTS.lilbowl_objective);
	Sleep(5);
	object_create( "bowl_objective_enter");
end


function f_lilbowl_objcon()

	SleepUntil ([|volume_test_players(VOLUMES.tv_lb_objcon_20)], 1);
	
		n_lilbowl_objcon = 20;
	SleepUntil ([|volume_test_players(VOLUMES.tv_lb_objcon_20)], 1);
		n_lilbowl_objcon = 40;
end

function f_lil_save()

--	repeat
		print("trying to save");
		game_save_no_timeout();
		--sleep_s(20);
		
	--until device_get_position (OBJECTS.dc_lb_gate_button) > 0

end



function cs_move_lil_grunt_01()

	cs_abort_on_damage( true );
	cs_go_to( POINTS.ps_lil_grunts.p0,2);

end

function cs_move_lil_grunt_02()

	cs_abort_on_damage( true );
	cs_go_to( POINTS.ps_lil_grunts.p01,2);

end

function cs_move_lil_grunt_03()

	cs_abort_on_damage( true );
	cs_go_to(POINTS.ps_lil_grunts.p02,2);

end

function cs_move_lil_grunt_04()

	cs_abort_on_damage( true );
	cs_go_to( POINTS.ps_lil_grunts.p03,2);

end