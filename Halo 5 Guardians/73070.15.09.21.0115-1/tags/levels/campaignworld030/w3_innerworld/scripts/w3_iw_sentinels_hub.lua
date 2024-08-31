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
--  ********************  			      GOAL 1 - MUSEUM                *********************** --
--  **************************************************************************************** --

global b_museShowStop:boolean = false;
global b_exitMuseum:boolean = false;
global b_exitTunnel:boolean = false;
global b_onGondola:boolean = false;
global vin_w3_guardians:number = -1;
global b_hub_start:boolean = false;
global b_hub_black_done:boolean = false;
global b_hub_done:boolean = false;
global b_hub_right_this_way_sassy:boolean = false;
global b_guardian_vin_done:boolean = false;
global b_hub_unlock_gondola_door:boolean = false;
global b_gondola_starting_to_leave:boolean = false;

missionSentinels.goal_museum = 

	{
		gotoVolume = VOLUMES.tv_goal_gondola,
		next={"goal_gondola"},
		zoneSet = ZONE_SETS.zn_wall,
	}


function missionSentinels.goal_museum.Start() :void		
	--fade_out( 0,0,0,0);
	--this might go into its own scenario
	--CinematicPlay ("cin_180_trials");
	
	
	b_hub_start = true;

	print ("attempting to save game...");
	
	CreateThread(audio_sentinels_thread_up_mission_start);
	
	
	
		game_save_immediate();
		Sleep(3);
	--object_create("gondola_obj");
	
	


		CreateThread(f_ready_exit);
	CreateThread(f_ready_exit_tunnel);
	CreateThread(f_ready_ongondola);
	
	CreateThread(museum_pup_show);
	sleep_s(1.5);
	ai_place (AI.sq_sassy_spark);
	sleep_s(1);

	--	NARRATIVE CALL
	CreateThread(sentinels_museum_wake);

	fade_in(0, 0, 0, seconds_to_frames( 4 ));	
 	player_control_fade_in_all_input (0.5);	
	sleep_s(2.5);
	b_hub_black_done = true;
		CreateThread (MonitorRandomDialog);
	CreateThread(f_close_entrance_door);
	CreateThread (f_chapter_title, TITLES.ct_sen_1);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_sassy_spark.aisquadspawnpoint53), true);


		

	SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.zn_road  and b_hub_unlock_gondola_door ] , 1 );
		object_create("hub_exit");
		CreateThread( f_hub_switch_blip );
		ObjectiveShow(TITLES.obj_sen_2);
		sleep_s(0.5);
	SleepUntil ([|volume_test_players(VOLUMES.tv_museum_exit)], 1);
		vin_w3_guardians = composer_play_show("vin_w3_guardians_state1");
		print("unlock prison door");

		device_set_power (OBJECTS.dm_museum_exit_door, 1);
		device_set_position (OBJECTS.dm_museum_exit_door, 1);
end



function f_ready_exit()
SleepUntil([|volume_test_players(VOLUMES.tv_monitor_prison)], 1);
	b_exitMuseum = true;
--ObjectiveShow (TITLES.obj_sen_2);

end

function f_hub_switch_blip()

	SleepUntil([|volume_test_players(VOLUMES.tv_museum_exit_blip)], 1);
		object_destroy(OBJECTS.hub_exit);
		Sleep(2);
		object_create("gondola_obj");
			
end

function f_ready_exit_tunnel()
	SleepUntil([|volume_test_players(VOLUMES.tv_museum_exit) and b_hub_unlock_gondola_door ], 1);
		b_exitTunnel = true;
--ObjectiveShow (TITLES.obj_sen_2);

end


function f_ready_ongondola()
	SleepUntil([|volume_test_players(VOLUMES.tv_gondola_start)],1);
		b_onGondola = true;


end
	

function missionSentinels.goal_museum.End() :void		
	b_hub_done = true;
end

function f_close_prison_door()
	SleepUntil([|volume_test_objects_all(VOLUMES.tv_close_prisondoor, spartans())], 1);
		device_set_position(OBJECTS.dm_museum_exit_door, 0);
		print("locking prison door");
		if AI.sq_sassy_spark and not volume_test_objects(VOLUMES.tv_close_prisondoor,ai_get_object(AI.sq_sassy_spark)) then
			object_teleport( ai_get_object(AI.sq_sassy_spark), FLAGS.fl_hub_gondola_sassy_teleport );
		end
		Sleep(1);
		object_create( "cr_prison_door_blocker" );
end

function f_close_entrance_door()
	SleepUntil([|volume_test_objects_all(VOLUMES.tv_entrance_door, spartans())], 1);
		device_set_power (OBJECTS.dm_museum_entrance_door, 1);
		Sleep(1);
		device_set_position(OBJECTS.dm_museum_entrance_door, 0);
		
	SleepUntil([|device_get_position(OBJECTS.dm_museum_entrance_door) == 0], 1);
		device_set_power (OBJECTS.dm_museum_entrance_door, 0);
end

function museum_pup_show()

	local showKnight:number 		= pup_play_show ("vin_prisoncell_knight_disturbed");
	local showCrawler:number 		= pup_play_show ("vin_w3_prisoncells_crawlers_sleeping");
	local showTugwar:number 		= pup_play_show ("vin_w3_prisoncells_global_crawlers_tug_war_grunt");
	local showGruntElite:number = pup_play_show ("vin_w3_prisoncells_grunts_with_elite");
	local showHero:number 			= pup_play_show ("vin_w3_prisoncells_hero_pawn");
	local showHunter:number 		= pup_play_show ("vin_w3_prisoncells_hunter");
	local showSoldier:number 		= pup_play_show ("vin_w3_prisoncells_soldier");

	sleep_s(1);
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncells_huinter_squad));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_knight_sp));
	object_cannot_take_damage(ai_get_object(AI.vin_w3_prisoncells_soldier_squa));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_knight_disturbed));
	object_cannot_take_damage(ai_get_object(AI.pawnsquad));
--
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_grunts_with_elit.elite_sit));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt02_sleep));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03));
	object_cannot_take_damage(ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt04_sit));
	
	
	print("set_up_tracking");

	SleepUntil ([| b_museShowStop ], 1);
		pup_stop_show(showKnight);
		pup_stop_show(showCrawler);
		pup_stop_show(showTugwar);
		pup_stop_show(showGruntElite);
		pup_stop_show(showHero);
		pup_stop_show(showHunter);
		pup_stop_show(showSoldier);
		Sleep(1);
		ai_erase(AI.vin_prisoncells_huinter_squad);
		ai_erase(AI.vin_prisoncell_knight_sp);
		ai_erase(AI.vin_w3_prisoncells_soldier_squa);
		ai_erase(AI.vin_prisoncell_knight_disturbed);
		ai_erase(AI.pawnsquad);
	--
		ai_erase(AI.vin_prisoncell_grunts_with_elit.elite_sit);
		ai_erase(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01);
		ai_erase(AI.vin_prisoncell_grunts_with_elit.grunt02_sleep);
		ai_erase(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03);
		ai_erase(AI.vin_prisoncell_grunts_with_elit.grunt04_sit);
end


function f_sen_start()
	
	SleepUntil ([| player_is_in_game (PLAYERS.player0) == true], 1);

	
	--CreateThread (f_spawn_flock);
	
end

--  **************************************************************************************** --
--  ********************  			      GOAL 2 - GONDOLA               *********************** --
--  **************************************************************************************** --

missionSentinels.goal_gondola = 

	{
	gotoVolume = VOLUMES.tv_goal_gate,
	next={"goal_gate"},
	zoneSet = ZONE_SETS.zn_road,
	}


function missionSentinels.goal_gondola.Start() :void	

	print ("goal_gondola starting...");

		--	NARRATIVE 
		CreateThread(sentinels_gondola_wake);
	
	game_save_no_timeout();
	print ("attempting to save...");
	
	ai_disable_jump_hint(HINTS.jp_hub_gondola_exit );
	
	CreateThread(f_close_prison_door);
	print ("monitor can set up the gondola here and provide last minute narrative before the descent");
	MusketeerUtil_SetMusketeerGoal( FLAGS.fl_hub_gondola_musketeer_goal, 1.5);
	ai_set_objective( AI.musketeers, "obj_gon_musketeers" );
	SleepUntil ([|volume_test_players_all(VOLUMES.tv_gondola_start)], 1);
	--CreateThread(audio_sentinels_thread_up_gondola_emp);
	
	
	--CreateThread (f_chapter_title, TITLES.ct_sen_2);
	game_save();
	sleep_s(7);
	game_save_cancel();
--============================
--HAXON


--eleSweetHaxOn(OBJECTS.dm_gondola)
--CreateThread(eleSweetHaxOff, OBJECTS.dm_gondola);
--HAXOFF
--============================	
	
	device_set_power(OBJECTS.dm_gondola, 1);
	device_set_position(OBJECTS.dm_gondola, 1);	
	CreateThread(f_snow_gondola);
	CreateThread(audio_sentinels_thread_up_gondola_start);
	CreateThread( f_gondola_bump_forward );
	--sleep_s(8);
	b_gondola_starting_to_leave = true;
	SleepUntil([|device_get_position( OBJECTS.dm_gondola ) >=0.173 ],1);
		object_destroy( OBJECTS.gondola_obj );
		object_destroy( OBJECTS.cr_prison_door_blocker );
		f_volume_teleport_all_not_inside(VOLUMES.tv_gondola_start ,POINTS.gondola.pteleport);
		f_monitor_attach_to_gondola();
		ai_disable_jump_hint(HINTS.jp_hub_gondola_enter );
		sleep_s(2);
		MusketeerUtil_SetDestination_Clear_All();
	SleepUntil([|device_get_position( OBJECTS.dm_gondola ) >=0.98 ],1);
		f_volume_teleport_all_not_inside(VOLUMES.tv_gondola_teleport01 ,POINTS.gondola.pteleport);
	SleepUntil([|device_get_position( OBJECTS.dm_gondola ) >=0.99 ],1);
		MusketeerUtil_SetDestination_Clear_All();
		ai_set_objective( AI.musketeers, "" );
		ai_enable_jump_hint(HINTS.jp_hub_gondola_exit );
end


function f_gondola_bump_forward()
--	SleepUntil([|device_get_position( OBJECTS.dm_gondola ) >= 0.255 ],1);
		--sleep_s( 1 );
		print("bump");
		--kill_volume_enable( VOLUMES.kill_tv_after_gondola_gone );
	--	f_volume_teleport_all_not_inside(VOLUMES.tv_gondola_teleport ,POINTS.gondola.pteleport);
		
end

function f_snow_gondola ()
	SleepUntil([|volume_test_players(VOLUMES.tv_gondola_snow_fx)],1);

		RunClientScript("f_start_snow");

	SleepUntil([|not volume_test_players(VOLUMES.tv_gondola_snow_fx)],1);

		RunClientScript("f_stop_snow");

end



--================================================
--HAX START
--================================================



function sweetHaxAttach(gondola:object, marker:string, spartan:object)
	if unit_get_health(spartan) > 0 then
		object_cannot_take_damage( spartan );
		object_set_physics( spartan, false );
		objects_attach( gondola, marker, spartan, "" );
	else
		return;

	end
end

function sweetHaxDetach(gondola:object, spartan:object)
	if unit_get_health(SPARTANS.locke) > 0 then
		object_can_take_damage(spartan);
		objects_detach( gondola, spartan);
		object_set_physics( spartan, true );
		object_wake_physics( spartan );
	else
		return;

	end
end
--================================================
--HAXEND
--================================================

--## CLIENT

function remoteClient.f_start_snow()

	effect_attached_to_camera_new (TAG('\levels\campaignworld030\w3_innerworld\fx\snow\sent_camera_snow_falling.effect'));

end

function remoteClient.f_stop_snow()

	effect_attached_to_camera_stop (TAG('\levels\campaignworld030\w3_innerworld\fx\snow\sent_camera_snow_falling.effect'));

end