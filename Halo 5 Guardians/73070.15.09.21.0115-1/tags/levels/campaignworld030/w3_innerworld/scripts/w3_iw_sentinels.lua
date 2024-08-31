--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 Sentinels*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

global b_sen_turrets:boolean = false;
global b_sen_bombard:boolean = false;
global b_sen_tower_01:boolean = false;
global b_sen_tower_02:boolean = false;
global b_sen_doors:boolean = false;

global b_sen_nar_tower_01:boolean = false;
global b_sen_nar_tower_02:boolean = false;
global b_sen_nar_base:boolean = false;
global b_sen_nar_siphon:boolean = false;
global b_sen_nar_underground:boolean = false;
global b_sen_nar_underground_switch:boolean = false;
--global b_sent_kill_amb_fx:boolean = false;

global n_base_beam_state:number = 0;
global n_nar_tower_state:number = 0;
global objcon_underground:number = 0;

global g_monitornarrative:number = 0;
global g_collectiblecount:number = 0;

global n_col_subcore_active:number = 0;

global b_coliseum_continue:boolean = false;

global n_endgame_state:number = 0;


global b_monitor_wander_lil_1:boolean = false;
global b_monitor_wander_lil_2:boolean = false;
global b_monitor_wander_lil_3:boolean = false;
global b_monitor_wander_lil_4:boolean = false;
global b_monitor_wander_lil_5:boolean = false;
global b_monitor_wander_lil_6:boolean = false;
global b_monitor_wander_lil_7:boolean = false;
global b_monitor_wander_lil_8:boolean = false;
-- n_endgame_state @ 0 = starting position
-- n_endgame_state @ 1 = upon opening of coliseum
-- n_endgame_state @ 2 = as players enter coliseum
-- n_endgame_state @ 3 = when sentinel factory is opened
-- n_endgame_state @ 4 = when the cryptum is brought down

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
--  ********************  			       GLOBAL SCRIPTS                *********************** --
--  **************************************************************************************** --
global  cryptum_active:boolean = false;



global missionSentinels:table=
	{
	
		name = "w3_sentinels",
		-- breadCrumbs = {FLAGS.fl_sentinels_breadcrumb_1, FLAGS.fl_sentinels_breadcrumb_2, FLAGS.fl_sentinels_breadcrumb_3, FLAGS.fl_sentinels_breadcrumb_4, FLAGS.fl_sentinels_breadcrumb_5, FLAGS.fl_sentinels_breadcrumb_6},
		--description = "Sentinels: Locke braves a long-abandoned Sentinels Hub to recruit workers to free Chief from the Cryptum",
		startGoals = {"goal_museum"},
		--collectibles = {"w3_sentinels_collectible_1","w3_sentinels_collectible_2","w3_sentinels_collectible_3","w3_sentinels_collectible_4","w3_sentinels_collectible_5", "w3_sentinels_collectible_6", "w3_sentinels_collectible_7", "w3_sentinels_collectible_8", "w3_sentinels_collectible_9", "w3_sentinels_collectible_10" },
		collectibles = {
						{objectName="w3_sentinels_collectible_1", collectibleName="w3_sentinels_collectible_1"},
						{objectName="w3_sentinels_collectible_2", collectibleName="w3_sentinels_collectible_2"},
						{objectName="w3_sentinels_collectible_3", collectibleName="w3_sentinels_collectible_3"},
						{objectName="w3_sentinels_collectible_4", collectibleName="w3_sentinels_collectible_4"},
						{objectName="w3_sentinels_collectible_5", collectibleName="w3_sentinels_collectible_5"},
						{objectName="w3_sentinels_collectible_6", collectibleName="w3_sentinels_collectible_6"},
						{objectName="w3_sentinels_collectible_7", collectibleName="w3_sentinels_collectible_7"},
						{objectName="w3_sentinels_collectible_8", collectibleName="w3_sentinels_collectible_8"},
						{objectName="w3_sentinels_collectible_9", collectibleName="w3_sentinels_collectible_9"},
						{objectName="w3_sentinels_collectible_10", collectibleName="w3_sentinels_collectible_10"},
						{objectName = "skull_toughluck", collectibleName = "collectible_skull_toughluck"},
						},
		--profiles = {STARTING_PROFILES.profile1, STARTING_PROFILES.profile2, STARTING_PROFILES.profile3, STARTING_PROFILES.profile4},

	}


function startup.SentinelsInit()

	

	print("Init");
	zone_set_trigger_volume_enable("zone_set:zn_coliseum", false );
	zone_set_trigger_volume_enable("begin_zone_set:zn_coliseum", false );
	CreateThread( f_sent_setup_crytum_fx);
	
	if not editor_mode() then
		print("Starting Sentinels");
		fade_out( 0,0,0,0);
		player_control_fade_out_all_input(0.1);
		startSentinels();
		
	end


	
	
end


function startSentinels()

	StartMission(missionSentinels);
	
end


function missionSentinels.Start()
	
	print ("start Sentinels");
	
	Sys_TeleportPlayers (missionSentinels);
	Sys_ForcePlayerProfile(missionSentinels);

	--	NARRATIVE CALL
	CreateThread(sentinels_narrative_startup);
	--CreateThread (f_sen_start);
	
	object_destroy_folder("crs_col_racks"); -- for object count management
	object_destroy_folder("crs_col_cannons"); -- for object count management
end


function missionSentinels.End()
	--starting and killing the subtitles from the composition so it's always synced and called on the client
	CinematicPlay("cin_190_endgame");
	print ("Sentinels end");
	
	-- Award achievements before credits
	RunClientScript("AwardSentinelsMissionCompletionAchievement");
	
	Sleep (2);
	--print ("CHECKING SKIP BUG!!!!!!!!!!");
	--gmu OSR-153441 -- adding a small 1/4second sleep between cinematics so the skip isn't registered with multiple cinematics
	sleep_s (0.25);
	
	print ("credits start");
	CinematicPlay("cin_h5_credits");
	
	Sleep (2);
	--gmu OSR-153441 -- adding a small 1/4second sleep between cinematics so the skip isn't registered with multiple cinematics
	sleep_s (0.25);
	
	if game_difficulty_get_real() == DIFFICULTY.legendary then
		print ("PLAYING LEGENDARY ENDING");
		CinematicPlay("cin_195_legendary", true);
	end

	if not editor_mode() then
		sys_LoadEnding();
		
	else
		print ("in editor not loading the end");
	end
end


function cryptum_movement()

	cryptum_active = true;


end

function f_sentinels_update_weapon_profile()

	player_set_profile(STARTING_PROFILES.cp_profile01 ,SPARTANS.locke);
	player_set_profile(STARTING_PROFILES.cp_profile02 ,SPARTANS.vale);
	player_set_profile(STARTING_PROFILES.cp_profile03 ,SPARTANS.tanaka);
	player_set_profile(STARTING_PROFILES.cp_profile04 ,SPARTANS.buck);
	
end
--  **************************************************************************************** --
--  ********************  			       MONITOR SCRIPTS               *********************** --
--  **************************************************************************************** --


function cs_monitor_follow()
	local l_timer:number = -1;
	object_set_scale (AI.sq_sassy_spark, 1.2, 0.1);
	--object_cannot_take_damage (AI.sq_sassy_spark);
	object_cannot_die (ai_get_object(AI.sq_sassy_spark), true);
----	object_cannot_die(ai_get_object(AI.sq_sassy_spark.aisquadspawnpoint53), true);
	
	cs_face_player( AI.sq_sassy_spark, true);
	if b_hub_start then
		print("wait");
		--SleepUntil ([| volume_test_players ( VOLUMES.tv_hub_start_sassy )], 1);
		--print("go");
		cs_face_player( AI.sq_sassy_spark, true);
		
		SleepUntil ([| b_hub_black_done] , 1);
		sleep_s( 2 );
		cs_face_player( AI.sq_sassy_spark, false);
		cs_fly_to(AI.sq_sassy_spark, true, POINTS.ps_monitor_prison.p04, 0.75);
	end
		
		--sleep_s( 5 );
		
		
		
		SleepUntil ([| volume_test_players ( VOLUMES.tv_hub_start_sassy )], 1);
			cs_face_player( AI.sq_sassy_spark, true);
			
			l_timer = timer_stamp( 90 );
		SleepUntil ([| b_hub_right_this_way_sassy or timer_expired( l_timer )], 1); -- or b_exitTunnel
			--sleep_s(2);
			b_hub_unlock_gondola_door = true;
	--[[	repeat
	
			if object_get_health (PLAYERS.player0) > 0 then
				SleepUntil ([| objects_distance_to_object ( AI.sq_sassy_spark, PLAYERS.player0) >= 1], 1);
				cs_approach (AI.sq_sassy_spark, true, PLAYERS.player0, 2, 50, 51);
				
			elseif 
			
				object_get_health (PLAYERS.player1) > 0 then
				SleepUntil ([| objects_distance_to_object ( AI.sq_sassy_spark, PLAYERS.player0) >= 1], 1);
				cs_approach (AI.sq_sassy_spark, true, PLAYERS.player1, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player2) > 0 then
				SleepUntil ([| objects_distance_to_object ( AI.sq_sassy_spark, PLAYERS.player0) >= 1], 1);
				cs_approach (AI.sq_sassy_spark, true, PLAYERS.player2, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player3) > 0 then
				SleepUntil ([| objects_distance_to_object ( AI.sq_sassy_spark, PLAYERS.player0) >= 1], 1);
				cs_approach (AI.sq_sassy_spark, true, PLAYERS.player3, 2, 50, 51);

			else
				
				Sleep (5);
			
			end

		until  b_hub_right_this_way_sassy ;--b_exitMuseum
		]]--
		cs_approach (AI.sq_sassy_spark, false);
		cs_wait_for_player_prison( AI.sq_sassy_spark );
	--cs_run_command_script( object_get_ai(AI.sq_sassy_spark ),"cs_wait_for_player_prison"  );
end


function f_sent_emp_shields()
	CreateThread( rumble_shake_large );
	for _,spartan in ipairs (spartans()) do  
		object_set_shield ( spartan, 0 );
		object_set_shield_stun( spartan, 5 );
	end
end

function f_sent_emp_early_shake()
	CreateThread( rumble_shake_large );
end

function cs_debug_lilbowl_monitor_follow()
	print("debug spark01");
	ai_erase( AI.sq_sassy_spark  );
	object_set_scale (AI.sq_sassy_spark01, 1.2, 0.1);
	object_cannot_take_damage (AI.sq_sassy_spark01);
----	object_cannot_die(ai_get_object(AI.sq_sassy_spark01.tester), true);
	
	print("ai_current_actor" , ai_current_actor );
	cs_face_player( AI.sq_sassy_spark01, true);
	--cs_run_command_script( ai_current_actor,"cs_monitor_lead_lilbowl"  );
	cs_monitor_lead_lilbowl(ai_current_actor);
end

function f_monitor_volume_checks()

	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_01)],1);
		b_monitor_wander_lil_1 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_02)],1);
		b_monitor_wander_lil_2 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_03)],1);
		b_monitor_wander_lil_3 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_04)],1);
		b_monitor_wander_lil_4 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_05)],1);
		b_monitor_wander_lil_5 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_06)],1);
		b_monitor_wander_lil_6 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_07)],1);
		b_monitor_wander_lil_7 = true;
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_08)],1);
	b_monitor_wander_lil_8 = true;


end

function cs_wait_for_player_prison( sassy:ai )

	print("sassy prison wait");
	--SleepUntil([|b_hub_right_this_way_sassy],1);
	if not b_exitTunnel then
		cs_fly_to(sassy, true, POINTS.ps_monitor_prison.p0, 0.5);
	end
	
	if not b_exitTunnel then
		cs_fly_to(sassy, true, POINTS.ps_monitor_prison.p01,0.5);
	end
	
	SleepUntil([|b_exitTunnel],1);
		
	cs_monitor_gondola(sassy);
	--cs_run_command_script( sassy,"cs_monitor_gondola"  );

end


function cs_monitor_gondola(sassy:ai)
	print("sassy gondola");
	local n_sassy_distance:number = -1;
	cs_fly_to(sassy, true, POINTS.gondola.p0, 0.75);
	Sleep(2);
	SleepUntil([|volume_test_players(VOLUMES.tv_gondola_start)],1);
		--cs_approach_player (AI.sq_sassy_spark, true, 2, 50, 999);
		
	f_monitor_attach_to_gondola();
			
	SleepUntil([|device_get_position(OBJECTS.dm_gondola) == 1],1);
		objects_detach(OBJECTS.dm_gondola,ai_get_object(sassy));
		
		if objects_distance_to_point( ai_get_object( AI.sq_sassy_spark) , POINTS.gondola.p0 ) > 10 or objects_distance_to_point( ai_get_object( AI.sq_sassy_spark) , POINTS.gondola.p0 ) == -1 then
			print("bump sassy");
			object_teleport(ai_get_object( AI.sq_sassy_spark) , POINTS.ps_monitor_breadcrumb.pfailsafe );
			Sleep(1);
		end	
		cs_approach (sassy, false);
		cs_monitor_lead_lilbowl(sassy);
		--cs_run_command_script( sassy,"cs_monitor_lead_lilbowl"  );
end


function f_monitor_attach_to_gondola()

		if objects_distance_to_point( ai_get_object( AI.sq_sassy_spark) , POINTS.gondola.p0 ) > 3 or objects_distance_to_point( ai_get_object( AI.sq_sassy_spark) , POINTS.gondola.p0 ) == -1 then
			print("bump sassy");
			object_teleport(ai_get_object( AI.sq_sassy_spark) , POINTS.gondola.p0 );
			Sleep(3);
		end
		
			objects_physically_attach( OBJECTS.dm_gondola, "fx_gondola_rib_sm", ai_get_object(AI.sq_sassy_spark), "");

end

function cs_monitor_lead_lilbowl(sassy:ai)
	print("Sassy ", sassy);
	cs_approach (sassy, false);
	cs_fly_to(sassy, true, POINTS.ps_monitor_breadcrumb.pexit);
	cs_fly_to(sassy, true, POINTS.ps_monitor_breadcrumb.pexit2);
	cs_fly_to(sassy, true, POINTS.ps_monitor_breadcrumb.p0);
	cs_face_player( sassy, true);
	SleepUntil([|volume_test_players(VOLUMES.tv_monitor_road) ],1);
		print("MONITOR: leading to lil bowl");
		cs_fly_to(sassy, true, POINTS.ps_monitor_breadcrumb.p03);

		
	--SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_01) or volume_test_players(VOLUMES.tv_monitor_lil_02) or volume_test_players(VOLUMES.tv_monitor_lil_03) ],3);
	SleepUntil([| b_monitor_wander_lil_1],3);
	
		cs_face_player( sassy, false);
		Sleep(2);
		if not b_itty_start then
			print("MONITOR: ps_monitor_lilbowl_wander_01");
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_01, sassy);
		end
	--SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_02) or volume_test_players(VOLUMES.tv_monitor_lil_03)],3);
	SleepUntil([| b_monitor_wander_lil_2],3);
		Sleep(2);
		if not b_itty_start then
			print("MONITOR:ps_monitor_lilbowl_wander_02");
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_02, sassy);
		end
	--SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_03) or volume_test_players(VOLUMES.tv_monitor_lil_04) ],3);
	SleepUntil([| b_monitor_wander_lil_3 or ai_living_count(AI.sg_lb_all) <= 0  ],3);

		Sleep(2);
		
		if not ( b_itty_start or volume_test_players(VOLUMES.tv_monitor_lil_04 or ai_living_count(AI.sg_lb_all) <= 0 ) )then
			print("MONITOR:ps_monitor_lilbowl_wander_03");
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_03, sassy);
		end
		
	--SleepUntil([|volume_test_players(VOLUMES.tv_monitor_lil_04) or ai_living_count(AI.sg_lb_all) <= 0 or volume_test_players(VOLUMES.tv_monitor_lil_05)],3);
	SleepUntil([| b_monitor_wander_lil_4 or ai_living_count(AI.sg_lb_all) <= 0  ],3);
	--	n_monitor_wander_state = 0;
		--n_monitor_clear_all = 1;
		--sleep_s(0.5);
		--n_monitor_clear_all = 0;
		Sleep(5);
		if not b_itty_start then
			print("MONITOR:ps_monitor_lilbowl_wander_04");
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_04, sassy);
		end
	 SleepUntil([|device_get_position( OBJECTS.dm_lb_mid_gate)>= 0.80 ],1);
		 n_monitor_wander_state = 0;
		 n_monitor_clear_all = 1;
		 print("MONITOR: itty door opened");
	 	--CreateThread( f_monitor_follow_into_itty, sassy );
	 	--cs_go_to( POINTS.ps_monitor_breadcrumb.p_mid_door_bump
	 	cs_fly_to(sassy, true, POINTS.ps_monitor_breadcrumb.p_mid_door_bump, 0.75);
	  --f_monitor_lead_ittybowl(sassy);
	 	cs_run_command_script( sassy,"f_monitor_lead_ittybowl"  );
end
	

function f_monitor_follow_into_itty(sassy:ai)
	object_cannot_take_damage (sassy);
----	object_cannot_die(ai_get_object(AI.sq_sassy_spark.aisquadspawnpoint53), true);
	cs_face_player( sassy, true);
	print("MONITOR:sassy follow resume");
	Sleep(5);
	n_monitor_wander_state = 0;
	n_monitor_clear_all = 1;
	
		repeat
		
			if 
			
				object_get_health (PLAYERS.player0) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player0, 2, 50, 51);
				
			elseif 
			
				object_get_health (PLAYERS.player1) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player1, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player2) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player2, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player3) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player3, 2, 50, 51);

			else
				
				Sleep (4);
			
			end

	--	until volume_test_players(VOLUMES.tv_monitor_lil_05) or volume_test_players(VOLUMES.tv_monitor_lil_06) or volume_test_players(VOLUMES.tv_monitor_lil_07) ;
		until b_monitor_wander_lil_5  or b_itty_done ;
		cs_approach (sassy, false);
		Sleep(15);
		
		--f_monitor_lead_ittybowl(sassy);
		cs_run_command_script( sassy,"f_monitor_follow02"  );
end

function f_monitor_lead_ittybowl()
		local l_timer:number = -1;
		cs_approach (ai_current_actor, false);
		print("MONITOR: sassy itty wander");
		print("MONITOR: ps_monitor_lilbowl_wander_05");
		 --n_monitor_clear_all = 1;
		--Sleep(5);
		l_timer = timer_stamp( 6 );
		 n_monitor_clear_all = 0;
		SleepUntil([| b_monitor_wander_lil_5  or timer_expired( l_timer )],1);
			print("MONITOR: ps_monitor_lilbowl_wander_05");
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_05, ai_current_actor);
			Sleep(5);
		SleepUntil([| b_monitor_wander_lil_6 or ai_living_count( AI.sg_lb_for_gate ) <= 0 or b_itty_done],1);

		Sleep(2);
		print("MONITOR:ps_monitor_lilbowl_wander_06");
		if not b_itty_done then
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_06, ai_current_actor);
		end
		SleepUntil([| b_monitor_wander_lil_7 or ai_living_count( AI.sg_lb_for_gate ) <= 0 or b_itty_done ],1);

		Sleep(2);
		print("MONITOR:ps_monitor_lilbowl_wander_07");
		if not b_itty_done then
			CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_07, ai_current_actor);
		end
	SleepUntil([|  b_monitor_wander_lil_8 or ai_living_count( AI.sg_lb_for_gate ) <= 0 or b_itty_done ],1);
			
			sleep_s(0.5);
			n_monitor_wander_state = 0;
			n_monitor_clear_all = 1;
			cs_face_player( ai_current_actor, false);
			print("MONITOR: TO THE DOOR PLEEEEEASE!!!!");
			cs_fly_to(ai_current_actor, true, POINTS.ps_monitor_breadcrumb.p_hero_door, 0.75);
	 SleepUntil([|device_get_position( OBJECTS.dm_lb_gate02 )>= 0.3   ],1);
	 
		 n_monitor_wander_state = 0;
	 --	cs_run_command_script( sassy,"f_monitor_follow02"  );
	 	Sleep(5);
	 	f_monitor_follow02( ai_current_actor );
end

function f_monitor_follow02(sassy:ai)
	object_cannot_take_damage (sassy);
----	object_cannot_die(ai_get_object(AI.sq_sassy_spark.aisquadspawnpoint53), true);
	cs_face_player( sassy, true);

		repeat
	
			if 
			
				object_get_health (PLAYERS.player0) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player0, 2, 50, 51);
				
			elseif 
			
				object_get_health (PLAYERS.player1) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player1, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player2) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player2, 2, 50, 51);

			elseif 
			
				object_get_health (PLAYERS.player3) > 0 then
				SleepUntil ([| objects_distance_to_object ( sassy, PLAYERS.player0) >= 2], 1);
				cs_approach (sassy, true, PLAYERS.player3, 2, 50, 51);

			else
				
				Sleep (5);
			
			end

		until b_core_front_go ;
		cs_approach (sassy, false);
		Sleep(5);
	-- f_monitor_bigbowl(sassy);

end

function f_monitor_bigbowl()
	
		--cs_fly_to(sassy, true, POINTS.ps_monitor_bigbowl.p0);
		n_monitor_clear_all = 1;
		n_monitor_wander_state = 0;
		sleep_s(2);
		n_monitor_clear_all = 0;
		n_monitor_wander_state = 0;
		CreateThread( f_monitor_wander_random, POINTS.ps_monitor_bigbowl_wander_01, ai_current_actor);
	SleepUntil([|object_get_health(OBJECTS.dc_core_first) <= 0 or volume_test_players(VOLUMES.tv_check_center)], 1);
		n_monitor_clear_all = 1;
		n_monitor_wander_state = 0;
		cs_fly_to(ai_current_actor, true, POINTS.ps_monitor_bigbowl.p01);
		sleep_s(4);
		n_monitor_clear_all = 0;
		CreateThread( f_monitor_wander_random, POINTS.ps_monitor_bigbowl_wander_02, ai_current_actor);
	SleepUntil ([| core_count <= 0 ], 1);
		n_monitor_clear_all = 1;
		n_monitor_wander_state = 0;
		
		sleep_s(3);	
		n_monitor_clear_all = 0;
		cs_run_command_script( ai_current_actor,"f_monitor_bigbowl_prime_wait"  );
	
end

function f_monitor_bigbowl_prime_wait()

		--cs_fly_to(sassy, true, POINTS.ps_monitor_bigbowl.p02);
		CreateThread( f_monitor_wander_random, POINTS.ps_monitor_bigbowl_wander_03, ai_current_actor);
	SleepUntil ([| g_core_prime_action_done ], 1);
			print("MONITOR: g_core_prime_action_done ");
			n_monitor_wander_state = 0;
			Sleep(5);
			--cs_fly_to(ai_current_actor, true, POINTS.ps_monitor_bigbowl.p02);
			cs_run_command_script( ai_current_actor,"cs_montior_prime_location"  );
			--cs_montior_prime_location();
end

function cs_montior_prime_location()
	cs_fly_to(ai_current_actor, true, POINTS.ps_monitor_col.open_col);
end


function f_bowl_sassy_prime_sequence()
		local n_sassy_distance:number = -1;
		
		if not f_sent_get_sassy() then
			ai_place(AI.sq_sassy_spark);
			print("replicating sassy");
		end		
		Sleep(5);
		
		sleep_s(6);
	--	navpoint_track_object( AI.sq_sassy_spark, true );
		n_sassy_distance = objects_distance_to_point( ai_get_object(  f_sent_get_sassy()) , POINTS.ps_monitor_col.open_col ) ;
		print("Sassy distance to end point", n_sassy_distance );
		if n_sassy_distance > 30 or n_sassy_distance < 0 then
			object_teleport(  ai_get_object( f_sent_get_sassy() ), POINTS.ps_monitor_col.open_col);
			print("sassy is missing...teleporting");
		else
			cs_fly_to( f_sent_get_sassy(), true, POINTS.ps_monitor_col.open_col); --this is blocking so be careful
		end
		cs_run_command_script( f_sent_get_sassy(), "cs_monitor_open_col" );
end

function cs_monitor_open_col()

	print("locked sassy");
	object_set_scale (ai_current_actor, 1.2, 0.1);
	object_cannot_take_damage (ai_current_actor);
	cs_face( ai_current_actor,  true, POINTS.ps_monitor_col.open_col_face )

	SleepUntil([| n_endgame_state >= 1  ], 1 );
		print("free sassy");
		sleep_s(2);
		cs_run_command_script( ai_current_actor, "cs_go_to_coliseum" );
end

function cs_go_to_coliseum()
	cs_fly_by(ai_current_actor, true, POINTS.ps_coliseum.p07);
	cs_fly_by(ai_current_actor, true, POINTS.ps_coliseum.p06);
	cs_fly_by(ai_current_actor, true, POINTS.ps_coliseum.p05);
	cs_fly_by(ai_current_actor, true, POINTS.ps_coliseum.p01);
	cs_fly_by(ai_current_actor, true, POINTS.ps_coliseum.p02);
	f_col_start_tower_show();
end

function xxx_wander()
	--b_monitor_wander_active = true;
	ai_place(AI.sq_sassy_spark01);
	sleep_s(0.5);
	CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_01, AI.sq_sassy_spark01);
	Sleep(1);
	CreateThread( f_monitor_wander_random, POINTS.ps_monitor_lilbowl_wander_02, AI.sq_sassy_spark01);
--	b_monitor_wander_active = false;
end

global b_monitor_wander_active:boolean = false;

global n_monitor_wander_state:number = 0;
global n_monitor_clear_all:number = 0;
--global n_monitor_wander_state_request_new:number = 0;
global n_monitor_wander_action:number = 0;
global n_monitor_current_wander_lock:boolean = false;
-- 0 not active
-- 1 request new
-- 99 active

function f_monitor_wander_random( ps:point_set, sassy:ai )
	local point_num:number = #ps;
	local rand_point:number = 1;
	local this_wander_state_action:number = 0;
	print("num points ",#ps);
		n_monitor_wander_action = n_monitor_wander_action + 1;
		this_wander_state_action = n_monitor_wander_action;
	print("MONITOR: starting new wander ",this_wander_state_action);
	
	if n_monitor_wander_state == 0 and n_monitor_clear_all == 0 then
		n_monitor_wander_state = 99;
		

		print("MONITOR: no wander active lets go ", this_wander_state_action);
	elseif n_monitor_wander_state == 99 then
	

		--if n_monitor_wander_state_request_new == 1 then
	--		Sleep(2);
	--		print("a new wander state has already been queued , waiting for it to clear");
	--		SleepUntil ([| n_monitor_wander_state_request_new == 0 or n_monitor_wander_state == 0 or n_monitor_clear_all == 1] ,1 );	
	--			sleep_s(0.5);
	--	end
		
	--	n_monitor_wander_state_request_new = 1;
		--print("MONITOR: requesting new wander area because one is active");
		Sleep(2);
		SleepUntil ([|  n_monitor_wander_state == 0 or n_monitor_clear_all == 1 or this_wander_state_action < n_monitor_wander_action or not n_monitor_current_wander_lock] ,1 ); --n_monitor_clear_all
			Sleep(5);
			if  n_monitor_clear_all == 0 and ( this_wander_state_action == n_monitor_wander_action ) then
				n_monitor_wander_state = 99;
			--	n_monitor_wander_state_request_new = 0;
				print("MONITOR: new wander active ", this_wander_state_action);
	
			else
				if n_monitor_clear_all then
					n_monitor_current_wander_lock = false;
					print("MONITOR: CLEAR ALL MONITOR WANDER ", this_wander_state_action);
				end
				if this_wander_state_action < n_monitor_wander_action then
					print("MONITOR: this_wander_state_action < n_monitor_wander_action  no go ", this_wander_state_action);
				end				
			end
			
	end
	
		print("MONITOR: starting wander " , this_wander_state_action);
		local l_timer:number = -1;
		if this_wander_state_action == n_monitor_wander_action then
			repeat
				Sleep(1);
		
					rand_point = random_range(1,point_num)
					
					
					if n_monitor_clear_all == 0 and n_monitor_wander_state == 99 and not n_monitor_current_wander_lock then
						print("MONITOR: random point for action ", rand_point , " " , this_wander_state_action);
						
						-- lock
						n_monitor_current_wander_lock = true;
						cs_fly_to(sassy, true, ps[rand_point], 0.3);
						n_monitor_current_wander_lock = false;
						--unlock
					end
					--sleep_s(2);
					l_timer = timer_stamp( 2.5 );
					SleepUntil([| timer_expired( l_timer ) or n_monitor_wander_state == 0  or n_monitor_clear_all == 1 or this_wander_state_action < n_monitor_wander_action ] ,1 );-- or n_monitor_wander_state_request_new == 1
				
			until n_monitor_wander_state == 0  or n_monitor_clear_all == 1 or this_wander_state_action < n_monitor_wander_action; --or n_monitor_wander_state_request_new == 1
		end
	
		Sleep(2);
		print("MONITOR: old wander killed ", this_wander_state_action);
		--n_monitor_wander_state_request_new = 0;
		n_monitor_wander_state = 0;
end

function MonitorRandomDialog()

	Sleep (30 * 5);
	
	print ("playing intro dialog");
	
	--	ShowTempText ("MONITOR: Welcome to the your safehaven, Spartans.", 5);													--	Replaced by VO

	--	Sleep (30 * 5);																											--	Replaced by VO
	
	--	ShowTempText ("Monitor: From here you can access the Sentinel Factory that will be able to open the Cryptum.", 5);		--	Replaced by VO

	--	Sleep (30 * 5);																											--	Replaced by VO

	repeat

		print ("waiting to have some random dialog");

		sleep_s (random_range (6, 22));

		local t_dialog_choice:table=
		
		{

     	"MONITOR: I would recommend stocking up on weapons and ammo here.",
    	"MONITOR: Please, let me know if I can do anything for you.",
    	"MONITOR: <Hums Excitedly>",
     	"MONITOR: I've collected a variety of weaponry for you to choose from.",
     	"MONITOR: I think I'm more nervous than the humans were when the Covenant showed up on Reach!",
     	"MONITOR: As soon as we leave this area, Cortana will know you're here.",
     	"MONITOR: <Whistles>",
     	"MONITOR: I prefer UNSC guns much more than alien weapons, by a ratio of 4.62 to 1.",
     	"MONITOR: Once you leave this area, you cannot return here.",
     	"MONITOR: It has taken me a while to accumulate this armory.",
     	"MONITOR: I would never do anything to jeopardize our friendship!",
     	"MONITOR: Hmm... This may be a near impossible mission to complete.",
     	"MONITOR: Cortana's power grows at an exponential rate.  I would recommend hurrying.",
     	"MONITOR: I am currently generating a 92.99999999 repeating percent chance of failure, Spartans.",
     	"MONITOR: Promethean Knights are so interesting.  Such big heads, and such little arms.",
     	"MONITOR: You're spending a lot of time looking around.  I thought Spartans were supposed to kill things.",
     	"MONITOR: They say Spartans never die.  I hope for your sake that is a factual statement.",
     	"MONITOR: The Cryptum was sealed around John 117!  We must free him!",
     	"MONITOR: Are those Thruster Packs new additions to your Spartan armor?",
     	"MONITOR: How many times do you think you've flipped a Warthog while driving?",
     	"MONITOR: If you had to guess, how many bullets do you think you've fired in your life?",
     	"MONITOR: You'll need to act fast if you want to assist Spartan 117 and his team of Spartan 2s.",
  
  	};

			print ("playing flavor dialog");
			--	ShowTempText (t_dialog_choice [random_range(1, #t_dialog_choice)], 5);										--	Replaced by VO

			Sleep (6);

	until ([| volume_test_players (VOLUMES.tv_museum_exit)]);

end

function f_sent_setup_crytum_fx()

	SleepUntil([| object_valid("hero_cryptum01") ] ,3 );
		print("starting crytum fx");
		fx_cryptum_shield_activate();

end

function monitor_damage_test()
	repeat
		print( object_get_recent_body_damage(ai_get_object(AI.sq_sassy_spark) ) );
		print( object_get_recent_shield_damage( ai_get_object(AI.sq_sassy_spark)) );
		Sleep(30);
	until false;
end

function f_sent_get_sassy():ai

	local sassy = AI.sq_sassy_spark;
	
	if ai_living_count( AI.sq_sassy_spark01 ) == 1  then
		sassy = AI.sq_sassy_spark01;
	end
	
	return sassy;

end

--  **************************************************************************************** --
--  ********************  			           BLINKS                    *********************** --
--  **************************************************************************************** --


function BlinkStartSentinels()
	

	
	--f_volume_teleport_all_not_inside(VOLUMES.tv_sent_start ,FLAGS.fl_sent_start);
	GoalBlink(missionSentinels, "goal_museum", FLAGS.fl_sent_start);
--	StartMission(missionSentinels);
	
	CreateThread(audio_sentinels_stopallmusic);

end


function BlinkGondola()

	GoalBlink(missionSentinels, "goal_gondola", FLAGS.fl_goal_gondola);
	
	CreateThread(audio_sentinels_stopallmusic);
	 
	sleep_s (1);
	 
	fade_in();
	
end


function BlinkGate()

	  

	
	GoalBlink(missionSentinels, "goal_gate", FLAGS.fl_goal_gate);
	
	CreateThread(audio_sentinels_stopallmusic);
	ai_erase( AI.sq_sassy_spark );
	sleep_s (1); 
	ai_place(AI.sq_sassy_spark01);
	fade_in();
	b_guardian_vin_done = true;

end
	

function BlinkCores()

	GoalBlink(missionSentinels, "goal_cores", FLAGS.fl_goal_cores);
	f_sentinels_update_weapon_profile();
	CreateThread(audio_sentinels_stopallmusic);
	if not object_valid("dm_col_roof" ) then
		print("where da roof at?");
		object_create("dm_col_roof");
	end
	object_create( "bowl_objective_enter");
	print("END GAME " ,vin_endgame );
	if not composer_show_is_playing( vin_endgame ) then
		Sleep(1);
		print("end game vign not playing...starting");
		vin_endgame =	composer_play_show ("vin_w3_endgame");
	end
	Sleep(5);	 
	sleep_s (1);
	
	player_control_fade_in_all_input (1);		 
	 
	fade_in();

end


function BlinkColiseum()

	GoalBlink(missionSentinels, "goal_coliseum", FLAGS.fl_goal_coliseum);
	f_sentinels_update_weapon_profile();
	CreateThread(audio_sentinels_stopallmusic);
	 
	--sleep_s (1);
	
	--SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zn_coliseum ], 1);
	
	--sleep_s (2);
	b_coliseum_continue = true;
	b_core_prime_destroyed = true;
	if not object_valid("dm_col_roof" ) then
		print("where da roof at?");
		object_create("dm_col_roof");
	end
	if not composer_show_is_playing( vin_endgame ) then
		Sleep(1);
		vin_endgame =	composer_play_show ("vin_w3_endgame");
	end
	Sleep(5);
	object_create_folder("mod_coliseum");
	--object_create("dm_col_roof");

	Sleep(15);
	
	device_set_position_immediate (OBJECTS.dm_col_roof, 0);	
	player_control_fade_in_all_input (1);
	 
	fade_in();
	
end


--debug shortcut blink for a fake goal to you know...shortcut
function BlinkFactory()

		f_col_fake_blink_factory();
		

end


function BlinkUnderground()

	GoalBlink(missionSentinels, "goal_underground", FLAGS.fl_goal_underground);
	f_sentinels_update_weapon_profile();
	CreateThread(audio_sentinels_stopallmusic);
	b_core_prime_destroyed = true;
	b_coliseum_continue = true;
	composer_stop_show(vin_w3_guardians);
	--if not object_valid("dm_col_roof" ) then
	--	vin_endgame =	composer_play_show ("vin_w3_endgame");
	--end
	
	b_sentinels_end_pulse_shielded_01 = true;
	b_sentinels_end_pulse_shielded_02 = true;
	b_sentinels_end_pulse_shielded_03 = true;
	b_blink_undergound_vo = true;
	Sleep(5);
	device_set_position_immediate(OBJECTS.dm_col_elevator, 0.75);
	CreateMissionThread(sentinels_factory_wake);
	sleep_s (1);
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			MusketeerDestClear(spartan);
		end
	end
	CreateThread(endMuskSetPosition, t_endMusk01);
	object_create ("cr_domeshield");

	player_control_fade_in_all_input (1);	
	 
	fade_in();
	
end
 

function BlinkEndgame()

	GoalBlink(missionSentinels, "goal_underground", FLAGS.fl_goal_underground);
	f_sentinels_update_weapon_profile();
	CreateThread(audio_sentinels_stopallmusic);
	b_core_prime_destroyed = true;
	b_coliseum_continue = true;
	composer_stop_show(vin_w3_guardians);
	--if not object_valid("dm_col_roof" ) then
	--	vin_endgame =	composer_play_show ("vin_w3_endgame");
	--end
	Sleep(5);
	device_set_position_immediate(OBJECTS.dm_col_elevator, 0.75);
	CreateMissionThread(sentinels_factory_wake);
	sleep_s (1);

	object_create ("cr_domeshield");

	player_control_fade_in_all_input (1);	
	 
	fade_in();
end


--  **************************************************************************************** --
--  ********************  			        ACHIEVEMENTS                 *********************** --
--  **************************************************************************************** --




----------------------------------------------------------------------------
-- GARBAGE CONTROL ---------------------------------------------------------
----------------------------------------------------------------------------

-- Pretty aggressive garbage collection loop to save perf




----------------------------------------------------------------------------
-- MISSION COMPLETE --------------------------------------------------------
----------------------------------------------------------------------------

function f_sen_complete()

	EndMission(missionSentinels);

end


----------------------------------------------------------------------------
-- CLIENT ONLY UNDER HERE -----------------------------------------------
----------------------------------------------------------------------------
--## CLIENT


----------------------------------------------------------------------------
-- AMBIENT FX CLIENT SCRIPTS -----------------------------------------------
----------------------------------------------------------------------------

-- Snow is turned on here
function remoteClient.f_snow_fx()
	
	SleepUntil ([|volume_test_players (VOLUMES.tv_snow_fx)], 1);
	effect_attached_to_camera_new(TAG('fx\library\weather\snow_falling_light.effect'));

end

function remoteClient.sen_lift_shake()
	camera_shake_all_coop_players (.5,.5, 6);
	
end

function remoteClient.sen_base_shake()
	camera_shake_all_coop_players (.3, .3, 9);
end


--==========================================================================

function remoteClient.AwardSentinelsMissionCompletionAchievement()
	CamapignForceMissionUnlockAchievementForCurrentMission();
end

