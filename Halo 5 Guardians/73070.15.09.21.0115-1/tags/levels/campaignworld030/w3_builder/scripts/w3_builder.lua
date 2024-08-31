--## SERVER

--  **************************************************************************************** --
--  **************************   	 W3_BUILDER - BUILDER       ****************************** --
--  **************************************************************************************** --

-----------------------------------------------------------------------------------------------

--  **************************************************************************************** --
--  **************************   		  GLOBAL SCRIPTS          ****************************** --
--  **************************************************************************************** --


global encampment_objcon:number = 0;
global caves_objcon:number = 0;
global docks_objcon:number = 0;
global g_ics_player:object = nil;
global n_gateway_state = 0;
global b_caves_ee_over = false;
global b_canyon_respawn_fix = false;
global n_canyon_objcon = 0;
global b_grunt_button_hit = false;

global b_temple1_elevator_ready = false;
global b_temple1_shutter_ready = false;
global b_temple1_console_ready = false;
global b_temple1_ics_complete = false;
global b_temple1_elevator_down = false;
global b_temple1_sync_ready = false;

global b_temple2_elevator_ready = false;
global b_temple2_shutter_ready = false;
global b_temple2_console_ready = false;
global b_temple2_ics_complete = false;
global b_temple2_elevator_down = false;
global b_temple2_sync_ready = false;

global patrol_show:number = 0;
global guardian_show:number = 0;

global b_temple3_elevator_ready = false;
global b_temple3_shutter_ready = false;
global b_temple3_console_ready = false;
global b_temple3_ics_complete = false;
global b_temple3_elevator_down = false;
global b_temple3_sync_ready = false;

global p_player1 = nil;
global p_player2 = nil;

global b_PhaetonHasPilot = false;

global b_VTOLAscendComplete = false;
global b_VTOLDescendComplete = false;
global b_VTOLEvadeComplete = false;
global b_VTOLShootComplete = false;
global b_VTOLSwitchWeaponsComplete = false;
global stream_docks = false;
global stream_docks_final = false;
global switch_docks = false;
global switch_docks_final = false;
global stream_builder_end = false;

global b_shouldOptimizeBuilder:boolean = false;


-- n_gateway_state = 0;  Before any activations
-- n_gateway_state = 1;  After Temple 1
-- n_gateway_state = 2;  After Temple 2
-- n_gateway_state = 3;  After Temple 3
-- n_gateway_state = 4;  After Final Door


global missionBuilder:table=
	{
		name = "w3_builder",
		startGoals = {"goal_temple1"},
		profiles = {STARTING_PROFILES.pr_builder_chief, STARTING_PROFILES.pr_builder_kelly, STARTING_PROFILES.pr_builder_linda, STARTING_PROFILES.pr_builder_fred},
		points = POINTS.ps_builder_start,
		collectibles = {

		{objectName = "w3_builder_collectible_1", collectibleName = "w3_builder_collectible_1"},
		{objectName = "w3_builder_collectible_2", collectibleName = "w3_builder_collectible_2"},
		{objectName = "w3_builder_collectible_3", collectibleName = "w3_builder_collectible_3"},
		{objectName = "w3_builder_collectible_4", collectibleName = "w3_builder_collectible_4"},
		--{objectName = "w3_builder_collectible_5", collectibleName = "test_collectible"},
		{objectName = "w3_builder_collectible_6", collectibleName = "w3_builder_collectible_6"},
		--{objectName = "w3_builder_collectible_7", collectibleName = "test_collectible"},
		{objectName = "w3_builder_collectible_8", collectibleName = "w3_builder_collectible_7"},
		{objectName = "w3_builder_collectible_9", collectibleName = "w3_builder_collectible_8"},
		--{objectName = "w3_builder_collectible_10", collectibleName = "test_collectible"},
		{objectName = "w3_builder_skull_2", collectibleName = "collectible_skull_cloud"},
		{objectName = "w3_builder_skull_1", collectibleName = "collectible_skull_gruntparty"}
		
		},
		
	}

function f_activator(device:object, activator:object)

  g_ics_player = activator; 

end


function TempleDoorControl (dm:object)

	device_set_power (dm, 1);
	
	device_set_position (dm, 0);
	
	Sleep (5);
	
	print ("setting", dm);
	
	SleepUntil ([| device_get_position (dm) == 0 ]);
	
	print ("getting", dm);	
	
	Sleep (5);
	
	object_destroy (dm);
	
end


function cavalier_scale()

	object_set_scale (ai_current_actor, 1.5);

end


--  **************************************************************************************** --
--  ********************  			       CHAPTER TITLES                *********************** --
--  **************************************************************************************** --

function f_builder_chapter_1()

	RunClientScript ("HudShowClient",false); 
	cinematic_show_letterbox (true);
	sleep_s ( 1.5 );
	cinematic_set_title (TITLES.ct_builder_1);
	sleep_s ( 6.5 );
	cinematic_show_letterbox (false);
	sleep_s ( 1.5 );
	RunClientScript ("HudShowClient",true);  

end


function f_builder_chapter_2()

print ("deprecated");

end


function f_builder_chapter_3()

	RunClientScript ("HudShowClient",false); 
	cinematic_show_letterbox (true);
	sleep_s ( 1.5 );
	cinematic_set_title (TITLES.ct_builder_3);
	sleep_s ( 6.5 );
	cinematic_show_letterbox (false);
	sleep_s ( 1.5 );
	RunClientScript ("HudShowClient",true);  

end


function f_builder_chapter_4()

	print ("deprecated");

end


function f_builder_obj_complete(next_title:title)

	sleep_s (2);
	
	ObjectiveShow (next_title);

end


function f_builder_obj_complete_nil()

	ObjectiveShow (TITLES.obj_builder_complete);

end


function f_builder_obj_1()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: ACTIVATE THE FIRST GATEWAY CONDUIT

end

function f_builder_obj_2()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: FIND THE SECOND GATEWAY CONDUIT

end

function f_builder_obj_3()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: ACTIVATE THE SECOND GATEWAY CONDUIT

end

function f_builder_obj_4()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: FIND THE FINAL GATEWAY CONDUIT
	

end

function f_builder_obj_5()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: ACTIVATE THE FINAL GATEWAY CONDUIT
	

end

function f_builder_obj_6()

	ObjectiveShow (TITLES.obj_builder_1);
	-- OBJECTIVE: REACH THE GATEWAY

end

--  **************************************************************************************** --
--  **************************   		   BLINK SCRIPTS          ****************************** --
--  **************************************************************************************** --


function BlinkPatrol()

	print ("Blinking to Goal 2 - Patrol");
	GoalBlink (missionBuilder, "goal_patrol", FLAGS.fl_goal_patrol);

	NarrativeQueue.Kill();	
	CreateThread(audio_builder_stopallmusic);

	pup_play_show ("vin_w3builder_gateway");
	
	n_gateway_state = 1;

	fade_in();

end


function BlinkEncampment()

	print ("Blinking to Goal 3 - Encampment");
	GoalBlink (missionBuilder, "goal_encampment", FLAGS.fl_goal_encampment);

	NarrativeQueue.Kill();	
	CreateThread(audio_builder_stopallmusic);

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 1;

	fade_in();

end


function BlinkTemple2()

	print ("Blinking to Goal 4 - Temple 2");
	NarrativeQueue.Kill();	
	GoalBlink (missionBuilder, "goal_temple2", FLAGS.fl_goal_temple2);

	
	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_covenant, true, true );

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 1;
	
	fade_in();

end


function BlinkAftermath()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 5 - Aftermath");
	GoalBlink (missionBuilder, "goal_aftermath", FLAGS.fl_goal_aftermath);
	
	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_covenant, true, true );

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 2;
	
	device_set_power (OBJECTS.marsh_exit_door, 0);
	
	fade_in();

end


function BlinkCaves()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 6 - Caves");
	GoalBlink (missionBuilder, "goal_caves", FLAGS.fl_goal_caves);
	
	CreateThread(audio_builder_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_covenant, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_covenant, true, true );

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 2;

	--device_set_power (OBJECTS.dm_aftermath_door, 0);

	object_create ("aftermath_door_left");
	object_create ("aftermath_door_right");

	fade_in();

end


function BlinkDocks()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 7 - Docks");
	GoalBlink (missionBuilder, "goal_docks", FLAGS.fl_goal_docks);

	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 2;
	
	fade_in();

end


function BlinkTemple3()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 8 - Temple3");
	GoalBlink (missionBuilder, "goal_temple3", FLAGS.fl_goal_temple3);

	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );

	object_create_anew("temple_3_elevator");
	
	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 3;
	
	fade_in();

end


function BlinkVTOL()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 9 - VTOL Canyon");
	GoalBlink (missionBuilder, "goal_vtol", FLAGS.fl_goal_vtol);

	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );

	pup_play_show ("vin_w3builder_gateway");

	CreateThread (f_damage_first_vtolbashes);
	CreateThread (control_caverns_zone_sets);

	n_gateway_state = 3;
	
	fade_in();

end


function BlinkFinalWalk()
NarrativeQueue.Kill();	
	print ("Blinking to Goal 10 - Final Walk");
	GoalBlink (missionBuilder, "goal_finalwalk", FLAGS.fl_goal_finalwalk);

	CreateThread(audio_builder_stopallmusic);
	
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );

	pup_play_show ("vin_w3builder_gateway");

	n_gateway_state = 3;
	
	fade_in();

end


--  **************************************************************************************** --
--  ***********************  		STARTUP AND ENDING SCRIPTS       *************************** --
--  **************************************************************************************** --


function startup.initBuilder()

	print ("...Builder is loaded...");
	
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_builder);
		fade_out(0,0,0,0);
		StartBuilder();
	else
		print ("...run StartBuilder to begin playing...");
	end
	
end


function StartBuilder()

	StartMission(missionBuilder);
	
end


function missionBuilder.Start()
	
	print ("start Builder");
--	if current_zone_set() ~= ZONE_SETS.Builder then
--		switch_zone_set (ZONE_SETS.Builder);
--	end
	--Sys_TeleportPlayers (missionBuilder);
	

end

function missionBuilder.End()

	print ("Builder end");
	SetGlobalFlag("Builder_complete");
--	CinematicPlay ("cin_120_infinity2b");
	sys_LoadCin_120();
	
end


--  **************************************************************************************** --
--  **************************   		     ACHIEVEMENTS          ***************************** --
--  **************************************************************************************** --

global b_phantom_escaped:boolean = false;


function NoWitnesses()

	if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then

		SleepUntil ([| object_get_health(unit_get_vehicle( AI.sq_encampment_phantom)) >= 0], 1);

		print ("phantom is a thing");
	
		SleepUntil ([| b_phantom_escaped == true or object_get_health(unit_get_vehicle( AI.sq_encampment_phantom)) <= 0], 1); 
	
		if (object_get_health(unit_get_vehicle( AI.sq_encampment_phantom)) <= 0) then
	
			print ("Leave No Witnesses achievement unlocked");
			CampaignScriptedAchievementUnlocked(12); 
		
		elseif b_phantom_escaped == true then
	
			print ("phantom is gone, achievement lost");
	
		end			
		
	elseif game_difficulty_get_real() == DIFFICULTY.normal or game_difficulty_get_real() == DIFFICULTY.easy then
	
		print ("not on heroic or legendary, no cheevo for you");

	end

end




function IsSpartanInVTOL(p_player:object)
	
	SleepUntil ([| unit_in_vehicle (p_player)], 1);

	if unit_in_vehicle (p_player) then
		b_PhaetonHasPilot = true;
		print ("You got in a VTOL - Take A Hike can no longer be achieved...");
	end
	
end


function TakeAHike()

	print ("Take A Hike logic running...");

	SleepUntil ([| volume_test_players (VOLUMES.tv_vtol_exit) or b_PhaetonHasPilot == true], 1);
		
	if b_PhaetonHasPilot == true then
		
		print ("You got in a VTOL - Take A Hike can no longer be achieved...");
			
	else
			
		print ("You made it without a VTOL - Take a Hike achievement earned!");	
		CampaignScriptedAchievementUnlocked(11);

	end

end


function ee_tracking()

	object_create ("caves_ee_1");

	SleepUntil ([| object_get_health(OBJECTS.caves_ee_1) > 0], 1);
			
	sleep_s (0.1);
			
	SleepUntil ([| object_get_health(OBJECTS.caves_ee_1) <= 0], 1);
		
	print ("ding!");
	CreateEffectGroup( EFFECTS.ee_fire_1 );
			
	object_create ("caves_ee_2");

	SleepUntil ([| object_get_health(OBJECTS.caves_ee_2) > 0], 1);
			
	sleep_s (0.1);
			
	SleepUntil ([| object_get_health(OBJECTS.caves_ee_2) <= 0], 1);		

	print ("ding!");
	CreateEffectGroup( EFFECTS.ee_fire_2 );

	object_create ("caves_ee_3");

	SleepUntil ([| object_get_health(OBJECTS.caves_ee_3) > 0], 1);
			
	sleep_s (0.1);
			
	SleepUntil ([| object_get_health(OBJECTS.caves_ee_3) <= 0], 1);

	print ("ding!");
	CreateEffectGroup( EFFECTS.ee_fire_3 );

	object_create ("caves_ee_4");

	SleepUntil ([| object_get_health(OBJECTS.caves_ee_4) > 0], 1);
			
	sleep_s (0.1);
			
	SleepUntil ([| object_get_health(OBJECTS.caves_ee_4) <= 0], 1);

	print ("ding!");
	CreateEffectGroup( EFFECTS.ee_fire_4 );

	object_create ("caves_ee_5");

	SleepUntil ([| object_get_health(OBJECTS.caves_ee_5) > 0], 1);
			
	sleep_s (0.1);
			
	SleepUntil ([| object_get_health(OBJECTS.caves_ee_5) <= 0], 1);

	print ("congration, you did it");
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);

	CreateEffectGroup( EFFECTS.ee_fire_5 );

	if IsPlayer (SPARTANS.chief) then
		unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_ee, true, true );
	end
	
	if IsPlayer (SPARTANS.linda) then
		unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_ee, true, true );
	end
	
	if IsPlayer (SPARTANS.kelly) then
		unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_ee, true, true );
	end
	
	if IsPlayer (SPARTANS.fred) then
		unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_ee, true, true );				
	end

	ee_refill();

end


function ee_refill()

	repeat

		object_create ("ee_refill_1");
		object_create ("ee_refill_2");
		object_create ("ee_refill_3");
		object_create ("ee_refill_4");	

		objects_attach( SPARTANS.chief, "", OBJECTS.ee_refill_1, "" );
		objects_attach( SPARTANS.linda, "", OBJECTS.ee_refill_2, "" );
		objects_attach( SPARTANS.kelly, "", OBJECTS.ee_refill_3, "" );
		objects_attach( SPARTANS.fred, "", OBJECTS.ee_refill_4, "" );

		sleep_s (0.1);
	
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.chief), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.linda), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.kelly), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.fred), 1 );			

		sleep_s (0.1);
	
		objects_detach (SPARTANS.chief, OBJECTS.ee_refill_1);
		objects_detach (SPARTANS.linda, OBJECTS.ee_refill_2);
		objects_detach (SPARTANS.kelly, OBJECTS.ee_refill_3);
		objects_detach (SPARTANS.fred, OBJECTS.ee_refill_4);		
						
		print ("ammo up!");
	
		sleep_s (1);
	
	until b_caves_ee_over;
		
end


--  **************************************************************************************** --
--  **************************   		     MISC SCRIPTS          ***************************** --
--  **************************************************************************************** --

function lost_grunts_exit()

	print ("run away!");

	cs_push_stance( ai_current_actor, "flee" );

--	ai_flee_target ( ai_current_actor, player_get_unit (PLAYERS.player0));

	cs_go_to ( ai_current_actor, true, POINTS.ps_lost_grunts.p01, 1 );
	

end


function TempCrates()

	object_create ("temp1");
	object_create ("temp2");
	object_create ("temp3");
	object_create ("temp4");	
	object_create ("temp5");
	object_create ("temp6");
	object_create ("temp7");

end


function f_activator_get (device:object, activator:object)

	g_ics_player = activator;
	
end
   
 
function clear_objective_blips()

	object_destroy_folder ("sc_blips");

end
    
                
function set_objective_blip(blip_object:string)

	print ("setting new blip, clearing old!");
	object_destroy_folder ("sc_blips");
	sleep_s(1);
	object_create(blip_object);
	
end


function TempleTeleport(p_player:object, tv_check:volume, fl_tele:flag)

	if volume_test_object(tv_check, p_player) then
	
		print ("object in volume");
		
	else
	
		object_teleport( p_player, fl_tele );

	end

end


--  **************************************************************************************** --
--  ********************  			      GOAL 1 - TEMPLE1               *********************** --
--  **************************************************************************************** --


missionBuilder.goal_temple1 = 

{
	gotoVolume = VOLUMES.tv_goal_patrol,
	next={"goal_patrol"},
	zoneSet = ZONE_SETS.zn_intro,

}


function missionBuilder.goal_temple1.Start() :void                          

	CinematicPlay ("cin_112_builder");
	zone_set_trigger_volume_enable("begin_zone_set:zn_to_canyon", false);
	zone_set_trigger_volume_enable("zone_set:zn_to_canyon", false);

--	Creating Outcrop Flocks
	CreateThread (OutcropFlocks);
	guardian_show = pup_play_show ("vin_builder_outcrop_guardian");

	print("goal_temple1_start");
	
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen_off.sound'), nil, 1);
	
	fade_in();

	ai_disable_jump_hint (HINTS.jh_temple1_exit1);
	ai_disable_jump_hint (HINTS.jh_temple1_exit2);

	game_save_no_timeout();
	print ("temple1 checkpoint activated");	

	CreateThread (locate_cortana_obj);

	sleep_s (1);

	object_create ("temple1_rampshield_1");
	object_create ("temple1_rampshield_2");

	CreateThread (set_objective_blip, "blip_1");

	CreateThread (f_builder_chapter_1);

	CreateThread (hero_bird_1);
	CreateThread (hero_bird_2);	

	CreateThread (nar_builder_start);
	-- narrative thread!

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple1_start)], 1);

	sleep_s (2);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_temple1_initiate)], 1);
	device_set_power(OBJECTS.dm_temple1_ceiling, 1);
	sleep_s(1);
	pup_play_show ("vin_builder_temple1_console");
	print ("temple1 console is raising up");
	
	SleepUntil ([| b_temple1_console_ready], 1);
	
	sleep_s (0.1);
	device_set_power (OBJECTS.temple_control_1, 1);
	device_set_position (OBJECTS.temple_control_1, 0);
	print ("temple1 console is ready to be used");
		
	SleepUntil ([| device_get_position (OBJECTS.temple_control_1) == 1], 1);

	CreateThread (temple1_musk_control);

	print ("temple1 button has been pressed, ICS playing");
	pup_play_show ("vin_builder_temple1_ics");
	
	CreateThread (set_objective_blip, "blip_2");

	SleepUntil ([| g_ics_player ~= nil ]);

	object_destroy (OBJECTS.temple_control_1);
	CreateThread (nar_bldr_console_interact);
	-- narrative thread!

	SleepUntil ([| b_temple1_ics_complete ], 1);

	g_ics_player = nil;
	
	SleepUntil ([| b_temple1_shutter_ready], 1);
		
	pup_play_show ("vin_builder_temple1_window");
	pup_play_show ("vin_w3builder_gateway");

	RunClientScript("ShakeHard");
	
	CreateThread (audio_builder_thread_up_mission_start);

	n_gateway_state = 1;

	SleepUntil ([| b_temple1_elevator_down], 1);

	ai_enable_jump_hint (HINTS.jh_temple1_exit1);
	ai_enable_jump_hint (HINTS.jh_temple1_exit2);

	game_save_no_timeout();
	
	print ("waiting for blip3 volume");
	
	sleep_s (2);

	SleepUntil ([| volume_test_players (VOLUMES.tv_blip3_active)], 1);

	print ("blip3 volume hit");

	CreateThread (set_objective_blip, "blip_3");

	print ("waiting for blip4 volume");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip4_active)], 1);

	CreateThread (set_objective_blip, "blip_4");

	print ("blip4 volume hit");

end


function locate_cortana_obj()

	SleepUntil ([| b_search_ahead == true], 1);

	CreateThread (f_builder_obj_1);

	print ("waiting for line to be said, then updating objective");

	SleepUntil ([| b_find_cortana_objective ], 1);

	Sleep (0.5);

	CreateThread (f_builder_obj_complete, TITLES.obj_builder_2);

end


function hero_bird_1()

	SleepUntil ([| volume_test_players (VOLUMES.tv_w3_builder_bird_01)], 1);

	pup_play_show ("vin_w3builder_bird_01");

end


function hero_bird_2()

	SleepUntil ([| volume_test_players (VOLUMES.tv_w3_builder_bird_02)], 1);

	pup_play_show ("vin_w3builder_bird_02");

end


function hero_bird_3()

	SleepUntil ([| volume_test_players (VOLUMES.tv_w3_builder_bird_03)], 1);

	pup_play_show ("vin_w3builder_bird_03");

end


function hero_bird_4()

	SleepUntil ([| volume_test_players (VOLUMES.tv_w3_builder_bird_04)], 1);

	pup_play_show ("vin_w3builder_bird_04");

end


function temple1_musk_control()

	if not IsPlayer (SPARTANS.linda) then
		MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_temple1_musk_points.p0, 0.7);
	end
		
	if not IsPlayer (SPARTANS.kelly) then
		MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_temple1_musk_points.p1, 0.7);
	end
		
	if not IsPlayer (SPARTANS.fred) then
		MusketeerDestSetPoint(SPARTANS.fred, POINTS.ps_temple1_musk_points.p2, 0.7);		
	end	

end


function temple1_domeattach()

	object_create ("temple1_dome_1");
	objects_physically_attach( OBJECTS.dm_temple1_console, "bubble_snap", OBJECTS.temple1_dome_1, "" );

	MusketeersOrderTurnAllOff();
		
end


function temple1_teleport()

	TempleTeleport(SPARTANS.chief, VOLUMES.tv_temple1_teleport, FLAGS.temple1_chief_tele);
	TempleTeleport(SPARTANS.fred, VOLUMES.tv_temple1_teleport, FLAGS.temple1_fred_tele);
	TempleTeleport(SPARTANS.kelly, VOLUMES.tv_temple1_teleport, FLAGS.temple1_kelly_tele);
	TempleTeleport(SPARTANS.linda, VOLUMES.tv_temple1_teleport, FLAGS.temple1_linda_tele);	
	
	MusketeerDestClear(SPARTANS.chief);
	MusketeerDestClear(SPARTANS.fred);
	MusketeerDestClear(SPARTANS.kelly);
	MusketeerDestClear(SPARTANS.linda);			
	
end


function temple1_domedetach()

	objects_detach( OBJECTS.dm_temple1_console, OBJECTS.temple1_dome_1);

	object_destroy (OBJECTS.temple1_dome_1);

	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_energy\003_amb_positional_energy_shielddrop_builder.sound'), nil, 1);

	MusketeersOrderTurnAllOn();	
	
end


function OutcropFlocks()

	flock_create ("outcrop_flock_bird_01");
	flock_create ("outcrop_flock_bird_02");
	flock_create ("outcrop_flock_bird_03");
	flock_create ("outcrop_flock_bird_04");
	flock_create ("outcrop_flock_bird_05");
--	flock_create ("outcrop_flock_bird_06");
	flock_create ("outcrop_flock_bird_07");
--	flock_create ("outcrop_flock_bird_08");
--	flock_create ("outcrop_flock_bird_09");
	flock_create ("outcrop_flock_horseshoe_crab_01");
--	flock_create ("outcrop_flock_horseshoe_crab_02");
--	flock_create ("outcrop_flock_horseshoe_crab_03");
	flock_create ("vista_flock_bird_01");
	flock_create ("vista_flock_bird_02");																					

end




--  **************************************************************************************** --
--  ********************  			      GOAL 2 - PATROL                *********************** --
--  **************************************************************************************** --

missionBuilder.goal_patrol = 

{
	gotoVolume = VOLUMES.tv_goal_encampment,
	next={"goal_encampment"},
	zoneSet = ZONE_SETS.zn_outcrop,

}


function missionBuilder.goal_patrol.Start() :void                          

	print("goal_patrol_start");
	print("attempting to save...");	
	CreateThread(nar_goal_builder_patrol);
	game_save_no_timeout();
	
	CreateThread (GruntEasterEgg);	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_patrol_start)], 1);

	CreateThread (PatrolHintControl);	
	
	print ("spawning first enemies");

	ai_place (AI.sq_lost_grunts);
	
	CreateThread (audio_builder_thread_up_patrol_start);
	
	patrol_show =	pup_play_show ("vin_w3builder_covenant_scavenge");

	CreateThread(audio_gateway_deactivate_a);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip5_active)], 1);

	CreateThread (set_objective_blip, "blip_5");

end


function PatrolHintControl()

	print ("musketeer's taking point");

	ai_allegiance(TEAM.covenant, TEAM.neutral);
	
	ai_disable_jump_hint (HINTS.patrol_jump_hint_1);
	ai_disable_jump_hint (HINTS.patrol_jump_hint_2);
	ai_disable_jump_hint (HINTS.patrol_jump_hint_3);	
	
	if not IsPlayer (SPARTANS.linda) then
		object_set_allegiance( SPARTANS.linda, TEAM.neutral);
		MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_ambush_points.p1, 0.5);
	end
		
	if not IsPlayer (SPARTANS.kelly) then
		object_set_allegiance( SPARTANS.kelly, TEAM.neutral);
		MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_ambush_points.p2, 0.5);
	end
		
	if not IsPlayer (SPARTANS.fred) then
		object_set_allegiance( SPARTANS.fred, TEAM.neutral);
		MusketeerDestSetPoint(SPARTANS.fred, POINTS.ps_ambush_points.p3, 0.5);		
	end				
	
	SleepUntil ([| not pup_is_playing (patrol_show)], 1);
	
	ai_enable_jump_hint (HINTS.patrol_jump_hint_1);
	ai_enable_jump_hint (HINTS.patrol_jump_hint_2);
	ai_enable_jump_hint (HINTS.patrol_jump_hint_3);

	ai_allegiance_remove(TEAM.covenant, TEAM.neutral);
	
	if not IsPlayer (SPARTANS.linda) then
		object_set_allegiance( SPARTANS.linda, TEAM.player);
		MusketeerDestClear(SPARTANS.linda);
	end
		
	if not IsPlayer (SPARTANS.kelly) then
		object_set_allegiance( SPARTANS.kelly, TEAM.player);	
		MusketeerDestClear(SPARTANS.kelly);
	end
		
	if not IsPlayer (SPARTANS.fred) then
		object_set_allegiance( SPARTANS.fred, TEAM.player);
		MusketeerDestClear(SPARTANS.fred);		
	end		

end

	

function GruntEasterEgg()

--	ai_place (AI.sq_grunt_easteregg);

	local show:number =	pup_play_show ("w3_builder_grunt_easteregg");
		
	object_create ("dc_builder_grunt_kick");
	object_hide (OBJECTS.dc_builder_grunt_kick, true);
	
	print ("button is hidden, waiting to be hit");
	
	SleepUntil ([| device_get_position (OBJECTS.dc_builder_grunt_kick) == 1], 1);
	
	print ("button is hit");	

	SleepUntil ([| g_ics_player ~= nil ]);	

	pup_play_show ("w3_builder_grunt_easteregg_ics");

	sleep_s (0.5);

	b_grunt_button_hit = true;
	
	sleep_s (1);
	
	object_destroy (OBJECTS.dc_builder_grunt_kick);
	
	print ("skull found!");

	sleep_s (1);
	
	object_create ("w3_builder_skull_1");
	
	g_ics_player = nil;
	
end


function EasterEggPhysics() 

	object_wake_physics (AI.sq_grunt_easteregg);
	ai_kill (AI.sq_grunt_easteregg);

end

--  **************************************************************************************** --
--  ********************  			      GOAL 3 - ENCAMPMENT            *********************** --
--  **************************************************************************************** --

missionBuilder.goal_encampment = 

{
	gotoVolume = VOLUMES.tv_goal_temple2,
	next={"goal_temple2"},
	zoneSet = ZONE_SETS.zn_outcrop,

}


function missionBuilder.goal_encampment.Start() :void                          

	print("goal_encampment_start");
	print("attempting to save...");	
	CreateThread (nar_goal_builder_encampment);
	CreateThread (MarshFlocks);	
	
	
	game_save_no_timeout();
	
	ai_place (AI.sq_encampment_cov_1);
	ai_place (AI.sq_encampment_cov_2);
	ai_place (AI.sq_encampment_cov_3);	
	ai_place (AI.sq_encampment_sniper);
	ai_place (AI.sq_encampment_phantom);
	
	sleep_s (0.1);
	
	--CreateThread(AudioCheckEnemyCount, AI.sq_encampment, 1, audio_builder_thread_up_patrol_outro);
	
--	ai_kill_silent (AI.sq_encampment_dead_guys);	
	
	unit_set_maximum_vitality (unit_get_vehicle( AI.sq_encampment_phantom ), 1000, 0);
	unit_set_current_vitality(unit_get_vehicle( AI.sq_encampment_phantom ), 1, 0 );
	
	CreateThread (EncampmentPhantom);
	CreateThread (NoWitnesses);
	CreateThread (EncampmentObjcon);	

	SleepUntil ([| volume_test_players (VOLUMES.tv_blip6_active)], 1);	

	CreateThread (set_objective_blip, "blip_6");

	SleepUntil ([| volume_test_players (VOLUMES.tv_marsh_cave_spawn)], 1);	
	
	ai_place (AI.sq_marsh_cave_cov_1);
	ai_place (AI.sq_marsh_cave_cov_2);	
	
	CreateThread (set_objective_blip, "blip_7");


end


function MarshFlocks()

	flock_create ("marsh_flock_bird_01");
	flock_create ("marsh_flock_bird_02");
--	flock_create ("marsh_flock_bird_03");
	flock_create ("marsh_flock_bird_04");
	flock_create ("marsh_flock_bird_05");
	flock_create ("marsh_flock_bird_06");
	flock_create ("marsh_flock_bird_07");
	flock_create ("marsh_flock_bird_08");			

	flock_delete ("vista_flock_bird_02");
	flock_delete ("outcrop_flock_horseshoe_crab_01");		

end


function EncampmentObjcon()

	encampment_objcon = 0;

	SleepUntil ([| volume_test_players (VOLUMES.tv_encampment_objcon_5)], 1);
	
	encampment_objcon = 5;
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_encampment_objcon_10)], 1);

	encampment_objcon = 10;

end


function EncampmentPhantom()

	SleepUntil ([| volume_test_players (VOLUMES.tv_phantom_staging) or object_get_health(unit_get_vehicle( AI.sq_encampment_phantom)) <= 0.95], 1);
	
	print ("phantom about to fly away!");
	
	sleep_s (6);
	
	cs_run_command_script(AI.sq_encampment_phantom.driver, "cs_encampment_phantom_flyaway" );

end


function cs_encampment_phantom_flyaway()

	print ("phantom is flying away");

	cs_fly_to (POINTS.ps_encampment_phantom_points.p1, 1);
	
	cs_fly_to_and_face (POINTS.ps_encampment_phantom_points.p2, POINTS.ps_encampment_phantom_points.p3, 1);
	
	cs_fly_to (POINTS.ps_encampment_phantom_points.p3, 1);
	
	cs_fly_to (POINTS.ps_encampment_phantom_points.p4, 1);
	
	cs_fly_to (POINTS.ps_encampment_phantom_points.p5, 1);
	
	cs_fly_to (POINTS.ps_encampment_phantom_points.p6, 5);

	b_phantom_escaped = true;	

	sleep_s (0.25);
	
	ai_erase (AI.sq_encampment_phantom);

end


--  **************************************************************************************** --
--  ********************  			      GOAL 4 - TEMPLE2               *********************** --
--  **************************************************************************************** --

missionBuilder.goal_temple2 = 

{
	gotoVolume = VOLUMES.tv_goal_aftermath,
	next={"goal_aftermath"},
	zoneSet = ZONE_SETS.zn_marsh,

}


function missionBuilder.goal_temple2.Start() :void                          
	
	print ("setting players loadout...");
	CreateThread(nar_goal_builder_temple2);
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player3 );

	print("goal_temple2_start");
	print("attempting to save...");	
	game_save_no_timeout();

	CreateThread (hero_bird_3);	

	object_destroy (OBJECTS.marsh_lightbridge);
	RunClientScript ("MarshLightBridgeOff");

	object_create ("temple2_rampshield_1");
	object_create ("temple2_rampshield_2");

	CreateThread (f_builder_obj_complete, TITLES.obj_builder_3);
	CreateThread (set_objective_blip, "blip_8");
	
	CreateThread (Temple2_encounter_regroup);
	
	ai_place (AI.sg_temple2_all);
	ai_place (AI.sq_temple2_phantom);
	
	CreateThread (Temple_2_DoorControl);	

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple2_entrance)], 1);

	CreateThread (set_objective_blip, "blip_9");

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple2_initiate)], 1);
	device_set_power(OBJECTS.dm_temple2_ceiling, 1);
	sleep_s(1);
	pup_play_show ("vin_builder_temple2_console");
	
	SleepUntil ([| b_temple2_console_ready], 1);

	sleep_s (0.1);

	device_set_power (OBJECTS.temple_control_2, 1);
	device_set_position (OBJECTS.temple_control_2, 0);
	
	sleep_s (1);
	
	SleepUntil ([| device_get_position (OBJECTS.temple_control_2) == 1], 1);

	CreateThread (clear_objective_blips);

	CreateThread (temple2_musk_control);

	pup_play_show ("vin_builder_temple2_ics");
	
	CreateThread (nar_bldr_second_console_use);
	-- narrative thread!

	object_destroy (OBJECTS.temple_control_2);	
		
	SleepUntil([| b_temple2_ics_complete], 1);

	g_ics_player = nil;
	
	n_gateway_state = 2;

	garbage_collect_now();
	print ("collecting garbage");
	
	SleepUntil ([| b_temple2_shutter_ready], 1);

	pup_play_show ("vin_builder_temple2_window");

	RunClientScript("ShakeHard");
	
	--CreateThread(audio_builder_thread_up_find_final_conduit_start);

	CreateThread (set_objective_blip, "blip_10");
						
	SleepUntil ([| b_temple2_elevator_ready], 1);
	
	CreateThread (MarshDoorControl);
	
end


function temple2_musk_control()

	if not IsPlayer (SPARTANS.linda) then
		MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_temple2_musk_points.p0, 0.7);
	end
		
	if not IsPlayer (SPARTANS.kelly) then
		MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_temple2_musk_points.p1, 0.7);
	end
		
	if not IsPlayer (SPARTANS.fred) then
		MusketeerDestSetPoint(SPARTANS.fred, POINTS.ps_temple2_musk_points.p2, 0.7);		
	end	

end


function Aftermath_tunnel_regroup()

	print ("regrouping players into aftermath underground tunnel");
	
	EncounterRegroup(SPARTANS.chief, VOLUMES.tv_tunnel_teleport_check, VOLUMES.tv_tunnel_teleport_check, FLAGS.tunnel_chief_regroup);
	EncounterRegroup(SPARTANS.fred, VOLUMES.tv_tunnel_teleport_check, VOLUMES.tv_tunnel_teleport_check, FLAGS.tunnel_fred_regroup);
	EncounterRegroup(SPARTANS.kelly, VOLUMES.tv_tunnel_teleport_check, VOLUMES.tv_tunnel_teleport_check, FLAGS.tunnel_kelly_regroup);
	EncounterRegroup(SPARTANS.linda, VOLUMES.tv_tunnel_teleport_check, VOLUMES.tv_tunnel_teleport_check, FLAGS.tunnel_linda_regroup);	

end


function Temple2_encounter_regroup()

	SleepUntil ([| volume_test_players (VOLUMES.temple2_teleport_check)], 1);
	
	sleep_s (5);
	
	print ("regrouping players into temple2 encounter");
	
	EncounterRegroup(SPARTANS.chief, VOLUMES.temple2_teleport_check, VOLUMES.temple2_teleport_check_2, FLAGS.temple2_chief_regroup);
	EncounterRegroup(SPARTANS.fred, VOLUMES.temple2_teleport_check, VOLUMES.temple2_teleport_check_2, FLAGS.temple2_fred_regroup);
	EncounterRegroup(SPARTANS.kelly, VOLUMES.temple2_teleport_check, VOLUMES.temple2_teleport_check_2, FLAGS.temple2_kelly_regroup);
	EncounterRegroup(SPARTANS.linda, VOLUMES.temple2_teleport_check, VOLUMES.temple2_teleport_check_2, FLAGS.temple2_linda_regroup);	
	
	sleep_s (1);
	
	print ("erasing all patrol, encampment and marsh cave enemies here");
	
	ai_erase (AI.sg_encampment_front);
	ai_erase (AI.sg_encampment_mid);
	ai_erase (AI.sg_encampment_reserves);
	ai_erase (AI.sg_encampment_side);
	ai_erase (AI.sg_encampment_snipers);
	
	ai_erase (AI.sg_cov_patrol);
	ai_erase (AI.sg_jackal_rangers);
	ai_erase (AI.sg_lost_grunts);
	
	ai_erase (AI.sq_marsh_cave_cov_1);
	ai_erase (AI.sq_marsh_cave_cov_2);
	
	
	
end


function EncounterRegroup(p_player:object, tv_check:volume, tv_check2:volume, fl_tele:flag)

	if volume_test_object(tv_check, p_player) or volume_test_object(tv_check2, p_player) then
	
		print ("object in volume");
		
	else
	
		object_teleport( p_player, fl_tele );

	end

end


function temple2_domeattach()

	object_create ("temple2_dome_1");
	objects_physically_attach( OBJECTS.dm_temple2_console, "bubble_snap", OBJECTS.temple2_dome_1, "" );
	
--	f_volume_teleport_all_not_inside (VOLUMES.tv_temple2_teleport, FLAGS.flag_temple2_teleport);	

	MusketeersOrderTurnAllOff();
	
end

function temple2_domedetach()

	objects_detach( OBJECTS.dm_temple2_console, OBJECTS.temple2_dome_1);
	object_destroy (OBJECTS.temple2_dome_1);
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_energy\003_amb_positional_energy_shielddrop_builder.sound'), nil, 1);
	
	MusketeersOrderTurnAllOn();	
	
end


function temple2_teleport()

	TempleTeleport(SPARTANS.chief, VOLUMES.tv_temple2_teleport, FLAGS.temple2_chief_tele);
	TempleTeleport(SPARTANS.fred, VOLUMES.tv_temple2_teleport, FLAGS.temple2_fred_tele);
	TempleTeleport(SPARTANS.kelly, VOLUMES.tv_temple2_teleport, FLAGS.temple2_kelly_tele);
	TempleTeleport(SPARTANS.linda, VOLUMES.tv_temple2_teleport, FLAGS.temple2_linda_tele);	

	MusketeerDestClear(SPARTANS.chief);
	MusketeerDestClear(SPARTANS.fred);
	MusketeerDestClear(SPARTANS.kelly);
	MusketeerDestClear(SPARTANS.linda);			
	
end


function MarshDoorControl()

	object_destroy (OBJECTS.temple_2_elevator_cap);	
	print ("deleting the elevator cap");

	CreateThread (set_objective_blip, "blip_11");

	object_destroy (OBJECTS.marsh_lightbridge);
	RunClientScript ("MarshLightBridgeOff");

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple2_elevator_base)], 1);

	CreateThread (f_builder_obj_complete, TITLES.obj_builder_4);

	SleepUntil ([| volume_test_players (VOLUMES.tv_marsh_door_open)], 1);
	
	game_save_no_timeout();
	
	device_set_power (OBJECTS.marsh_exit_door, 1);
	
	object_create ("temple_2_elevator_cap");

end


function Temple_2_DoorControl()

	SleepUntil ([| b_temple_shield_drop ], 1);
	
	print ("Marsh Temple Door ready to open...");
	sleep_s (0.5);
	
	CreateThread(audio_builder_thread_up_patrol_outro);

	object_destroy (OBJECTS.temple2_rampshield_1);
	object_destroy (OBJECTS.temple2_rampshield_2);	

end



	--====================================
	--HAXUR
	--====================================
	global b_t2_phantom_leave:boolean = false;
	
	function t2_phantom_timer()
	sleep_s(45);
	b_t2_phantom_leave = true;
	
	end
	--====================================
	--HAXUROVER
	--====================================

function cs_temple2_phantom_control()

	print ("phantom is flying up");

	cs_vehicle_speed( ai_current_actor, 0.2 );

	cs_fly_to_and_face (POINTS.ps_temple2_phantom_points.p0, POINTS.ps_temple2_phantom_points.p1, 1);

	CreateThread(t2_phantom_timer);
	
	repeat
		
		cs_fly_to_and_face (POINTS.ps_temple2_phantom_points.p2, POINTS.ps_temple2_phantom_points.p1, 1);
	
		cs_fly_to_and_face (POINTS.ps_temple2_phantom_points.p3, POINTS.ps_temple2_phantom_points.p1, 1);
	
		sleep_s (1);
		
	until volume_test_players (VOLUMES.tv_temple2_phantom_retreat) or b_t2_phantom_leave;
	
	print ("temple2 phantom leaving");

	sleep_s (0.5);

	cs_vehicle_speed( ai_current_actor, 1 );

	cs_fly_to_and_face (POINTS.ps_temple2_phantom_points.p4, POINTS.ps_temple2_phantom_points.p5, 1);
	
	cs_fly_to (POINTS.ps_temple2_phantom_points.p6);
	
	object_set_scale(ai_current_actor, 0.1, 120 );	

	sleep_s(30);
	
	ai_erase (AI.sq_temple2_phantom);

end



--  **************************************************************************************** --
--  ********************  			      GOAL 5 - AFTERMATH             *********************** --
--  **************************************************************************************** --

missionBuilder.goal_aftermath = 

{
	gotoVolume = VOLUMES.tv_goal_caves,
	next={"goal_caves"},
	zoneSet = ZONE_SETS.zn_marsh,

}
global b_t2_bridge:boolean = false;

function missionBuilder.goal_aftermath.Start() :void                          

	print ("setting players loadout...");
	CreateThread(nar_goal_builder_aftermath);
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player3 );

	print("goal_aftermath_start");

	object_destroy (OBJECTS.marsh_lightbridge);
	RunClientScript ("MarshLightBridgeOff");
	
	ai_disable_jump_hint (HINTS.jh_marsh_bridge);
	
	game_save_no_timeout();
	print("attempting to save...");	

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple2_guardian_arrive)], 1);

	local show:number = pup_play_show ("vin_builder_temple2_guardian");
	
	--SleepUntil ([| volume_test_players (VOLUMES.tv_marsh_bridge_create) ], 1, 14);
 	SleepUntil ([| b_t2_bridge and volume_test_players (VOLUMES.tv_marsh_bridge_create)], 1);
	object_create ("marsh_lightbridge");
	RunClientScript ("MarshLightBridgeOn");
	CreateThread(audio_builder_lightbridge_activate_a);
	
	ai_enable_jump_hint (HINTS.jh_marsh_bridge);

	SleepUntil ([| volume_test_players (VOLUMES.tv_cavalier_cutscene)], 1);

	CreateThread (set_objective_blip, "blip_12");
	
	--CreateThread(audio_builder_thread_up_find_final_conduit_stop);
	fade_out( 0, 0, 0, 60 );
	
	sleep_s (1);
	
	CreateThread(PrepareToSwitchToDocks);	
	CreateThread(SwitchToDocks);
	CreateThread(PrepareToSwitchToDocksFinal);
	CreateThread(SwitchToDocksFinal);
	CinematicPlay ("cin_115_warden", true);
	sleep_s (1.5);
	switch_zone_set(ZONE_SETS.zn_docks);
	
	object_destroy (OBJECTS.marsh_lightbridge);
	RunClientScript ("MarshLightBridgeOff");

	TeleportNoFX(10);

	volume_teleport_players_not_inside (VOLUMES.tv_cutscene_cav_teleport, FLAGS.fl_goal_caves);
	
	object_teleport (SPARTANS.chief, FLAGS.fl_caves_tele_chief);
	object_teleport (SPARTANS.kelly, FLAGS.fl_caves_tele_kelly);
	object_teleport (SPARTANS.linda, FLAGS.fl_caves_tele_linda);
	object_teleport (SPARTANS.fred, FLAGS.fl_caves_tele_fred);
	
	object_create ("aftermath_door_left");
	object_create ("aftermath_door_right");
	
	fade_in(0,0,0,60);
	
	game_save_no_timeout();
	print("attempting to save...");	

end


function MarshLightbridgeOff()

	RunClientScript ("MarshLightBridgeOff");

end


-----Streaming Docks-----
function remoteServer.FlipDocksStreamingBoolean()

	print("about to flip bool");
	stream_docks = true;
	print("bool flipped");

end

function PrepareToSwitchToDocks()

	print("about to sleep");
	SleepUntil([| stream_docks == true], 1);
	print("done sleeping.  about to prepare");
	prepare_to_switch_to_zone_set(ZONE_SETS.zn_to_docks);
	print("prepared");

end

function remoteServer.FlipDocksSwitchBoolean()

	switch_docks = true;

end

function SwitchToDocks()

	SleepUntil([| switch_docks == true], 1);
	switch_zone_set(ZONE_SETS.zn_to_docks);
	-- Sleep(5);
	-- switch_zone_set(ZONE_SETS.zn_docks);

end

function remoteServer.FlipDocksFinalStreamBoolean()

	stream_docks_final = true;

end

function PrepareToSwitchToDocksFinal()

	SleepUntil([| stream_docks_final == true], 1);
	prepare_to_switch_to_zone_set(ZONE_SETS.zn_docks);
end

function remoteServer.FlipDocksFinalSwitchBoolean()

	switch_docks_final = true;

end

function SwitchToDocksFinal()

	SleepUntil([| switch_docks_final == true], 1);
	switch_zone_set(ZONE_SETS.zn_docks);
end

function doorshut()

--	object_create ("dm_aftermath_door");
	
	object_create ("aftermath_door_left");
	object_create ("aftermath_door_right");
	
--	device_set_power (OBJECTS.dm_aftermath_door, 1);
--	Sleep (1);	
--	device_set_position_immediate (OBJECTS.dm_aftermath_door, 1);
--	device_set_power (OBJECTS.dm_aftermath_door, 0);

end




--  **************************************************************************************** --
--  ********************  			      GOAL 6 - CAVES                 *********************** --
--  **************************************************************************************** --

missionBuilder.goal_caves = 

{
	gotoVolume = VOLUMES.tv_goal_docks,
	next={"goal_docks"},
	zoneSet = ZONE_SETS.zn_docks,

}


function missionBuilder.goal_caves.Start() :void                          

	print ("setting players loadout...");
	CreateThread (nar_goal_builder_caves);
	CreateThread (CavesFlocks);	

	TeleportNoFX(10);

	object_create ("aftermath_door_left");
	object_create ("aftermath_door_right");
	sleep_s (0.1);

	pup_stop_show (guardian_show);

	CreateThread (CavesCrateCreation);
	
	CreateThread (set_objective_blip, "blip_12");
	
	if game_difficulty_get_real() == DIFFICULTY.legendary then
		CreateThread (ee_tracking);
	end

	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_covenant, PLAYERS.player3 );

	CreateThread(audio_builder_thread_up_caves_start);
	
	print("goal_caves_start");
	print("attempting to save...");	
	
	game_save_no_timeout();

	CreateThread (f_builder_chapter_3);
		
	CreateThread (CavesObjcon);
	print ("caves objcon is created");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_caves_start)], 1); 

	SlipSpaceSpawn (AI.sg_caves_first_soldiers);
	sleep_s (0.3);
	SlipSpaceSpawn (AI.sq_cave_watchers_1);
	sleep_s (0.3);
	SlipSpaceSpawn (AI.sq_cave_soldier_sniper);

	CreateThread (caves_blip_control);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_caves_objcon_5)], 1); 	
			
	SlipSpaceSpawn (AI.sg_caves_second_officers);
	sleep_s (0.3);
	SlipSpaceSpawn (AI.sg_caves_second_soldiers);
	sleep_s (0.3);
	SlipSpaceSpawn (AI.sq_cave_final_soldiers);
	sleep_s (0.3);
	SlipSpaceSpawn (AI.sq_cave_watchers_2);			

	SleepUntil ([| volume_test_players (VOLUMES.tv_caves_obj_reminder)], 1);

	CreateThread (f_builder_obj_complete, TITLES.obj_builder_5);

end


function CavesCrateCreation()

	print ("failsafe, creating Caves crates");

	object_create_anew ("caves_weapcrate_01");
	object_create_anew ("caves_weapcrate_02");
	object_create_anew ("caves_weapcrate_03");
	object_create_anew ("caves_weapcrate_04");
	
	object_create_anew ("caves_breakable_01");
	object_create_anew ("caves_breakable_02");
	object_create_anew ("caves_breakable_03");		

	object_create_anew ("w3_builder_collectible_6");
	object_create_anew ("w3_builder_collectible_9");

end


function caves_blip_control()

	CreateThread (set_objective_blip, "blip_13");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip14_active)], 1); 	

	CreateThread (set_objective_blip, "blip_14");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip15_active)], 1); 	

	CreateThread (set_objective_blip, "blip_15");	

end


function CavesFlocks()

	flock_create ("cave_flock_bird_01");
			
end


function CavesObjcon()

	caves_objcon = 0;

	SleepUntil ([| volume_test_players (VOLUMES.tv_caves_objcon_5)], 1);
	
	caves_objcon = 5;

	game_save_no_timeout();
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_caves_objcon_10)], 1);

	caves_objcon = 10;

end


function doortest()

	object_create ("aftermath_door_left");
	object_create ("aftermath_door_right");

end

--  **************************************************************************************** --
--  ********************  			      GOAL 7 - DOCKS                 *********************** --
--  **************************************************************************************** --

missionBuilder.goal_docks = 

{
	gotoVolume = VOLUMES.tv_goal_temple3,
	next={"goal_temple3"},
	zoneSet = ZONE_SETS.zn_docks,

}


function missionBuilder.goal_docks.Start() :void                          

	print ("setting players loadout...");

	CreateThread (set_objective_blip, "blip_16");	

	CreateThread (DocksFrontBridgeDestroy);
	CreateThread (DocksSideBridgeDestroy);

	CreateThread (DocksFlocks);	
	CreateThread (nar_goal_builder_docks);
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player3 );

	print("goal_docks_start");
	print("attempting to save...");	
	game_save_no_timeout();

	object_create ("temple3_rampshield_1");
	object_create ("temple3_rampshield_2");

	sleep_s (1.4);

	CreateThread(audio_builder_thread_up_caves_warden);
	
	SlipSpaceSpawn (AI.sq_docks_warden);
  
  SleepUntil ([| ai_living_count (AI.sq_docks_warden) > 0], 1);
  	
  sleep_s (0.8);	
  
	ai_place_with_slip_space (AI.sg_docks_crawlers);
  sleep_s (0.3);
	SlipSpaceSpawn (AI.sq_docks_soldiers_1);
 	sleep_s (0.3);
 	SlipSpaceSpawn (AI.sq_docks_soldiers_2);
 	sleep_s (0.3);
 	SlipSpaceSpawn (AI.sq_docks_soldiers_3);
 	sleep_s (0.3);
 	SlipSpaceSpawn (AI.sg_docks_crawlers);
 	sleep_s (0.3);
 	SlipSpaceSpawn (AI.sg_docks_knights);

	CreateThread (DocksObjcon);
	
	CreateThread (DocksMusketeerControl);
	CreateThread (nar_bldr_cav_fight_start);
	-- narrative thread!
	
	SleepUntil ([| ai_living_count (AI.sg_docks_knights) > 0], 1);

	sleep_s (1);

	SleepUntil ([| ai_living_count (AI.sg_docks_knights) <= 1], 1);

	print("attempting to save...");	
	game_save_no_timeout();

	sleep_s (1);
	 
	SleepUntil ([| ai_living_count (AI.sg_docks_all) <= 1 and ai_living_count(AI.sq_docks_warden) <= 0 ], 1);	
	
	CreateThread(audio_builder_thread_up_caves_outro);
	
	sleep_s (1);
	print ("docks encounter complete");
	game_save_no_timeout();	

	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_front_bridge_spawn)], 1);

	pup_play_show ("vin_builder_docks_guardian");

	CreateThread (set_objective_blip, "blip_17");	

	CreateThread (nar_bldr_cav_fight_complete);
	-- narrative thread!	

	SleepUntil ([| b_lightbridge_activate ], 1);

	CreateThread (DocksFrontBridgeCreate);

end


function DocksMusketeerControl()

	SleepUntil ([| docks_objcon == 0 ], 1);
	
		if not IsPlayer (SPARTANS.linda) then
			MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_docks_points.linda1, 1);
		end
				
	SleepUntil ([| docks_objcon == 5 ], 1);
		
		if not IsPlayer (SPARTANS.kelly) then
			MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_docks_points.kelly1, 3);
		end
		
		if not IsPlayer (SPARTANS.fred) then
			MusketeerDestSetPoint(SPARTANS.fred, POINTS.ps_docks_points.fred1, 3);
		end							

	SleepUntil ([| docks_objcon == 10 ], 1);
		
		if not IsPlayer (SPARTANS.linda) then
			MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_docks_points.linda2, 1);
		end			
			
		if not IsPlayer (SPARTANS.kelly) then
			MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_docks_points.kelly2, 1);
		end
		
		if not IsPlayer (SPARTANS.fred) then
			MusketeerDestClear(SPARTANS.fred);
		end		

	SleepUntil ([| docks_objcon == 15 ], 1);
	
		if not IsPlayer (SPARTANS.linda) then
			MusketeerDestClear(SPARTANS.linda);
		end
			
		if not IsPlayer (SPARTANS.kelly) then
			MusketeerDestClear(SPARTANS.kelly);
		end

		if not IsPlayer (SPARTANS.fred) then
			MusketeerDestClear(SPARTANS.fred);
		end		
		
end


function DocksFrontBridgeDestroy()

	object_destroy (OBJECTS.docks_front_bridge);
	print ("destroying front bridge");
	RunClientScript ("DocksFrontLightBridgeOff");
	
	ai_disable_jump_hint (HINTS.temple3_front_hint);	
	
	kill_volume_enable (VOLUMES.kill_docks_front_bridge);
	
	print ("creating front bridge kill volume");

end

function DocksSideBridgeDestroy()

	object_destroy (OBJECTS.docks_side_bridge);
	print ("destroying side bridge");	
	RunClientScript ("DocksSideLightBridgeOff");

	ai_disable_jump_hint (HINTS.temple3_side_hint);

	kill_volume_enable (VOLUMES.kill_docks_side_bridge);

	print ("creating side bridge kill volume");

end

function DocksFrontBridgeCreate()

	object_create ("docks_front_bridge");
	print ("creating front bridge");		
	RunClientScript ("DocksFrontLightBridgeOn");
	CreateThread(audio_builder_lightbridge_activate_b);

	ai_enable_jump_hint (HINTS.temple3_front_hint);
	
	zone_set_trigger_volume_enable("begin_zone_set:zn_to_canyon", true);

	kill_volume_disable (VOLUMES.kill_docks_front_bridge);

	print ("destroying front bridge kill volume");

end

function DocksSideBridgeCreate()

	object_create ("docks_side_bridge");
	print ("creating side bridge");		
	RunClientScript ("DocksSideLightBridgeOn");
	CreateThread(audio_builder_lightbridge_activate_c);

	ai_enable_jump_hint (HINTS.temple3_side_hint);

	kill_volume_disable (VOLUMES.kill_docks_side_bridge);

	print ("destroying side bridge kill volume");

end


function DocksFlocks()

	flock_create ("3rd_temple_flock_bird_01");
	flock_create ("3rd_temple_flock_bird_02");
	flock_create ("3rd_temple_flock_bird_03");		
		
end


function DocksBridges()

	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_lightbridge_switch)], 1);

	CreateThread (DocksFrontBridgeDestroy);
	
	sleep_s (1.5);

	CreateThread (DocksSideBridgeCreate);

end


function cs_one_second_blind()

	ai_braindead (ai_current_actor, true);
	
	sleep_s (1);
	
	ai_braindead (ai_current_actor, false);
	
	print ("no longer braindead");	

end


function DocksObjcon()

	docks_objcon = 0;

	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_objcon_5)], 1);
	
	docks_objcon = 5;
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_objcon_10) or ai_living_count (AI.sg_docks_knights) <= 0], 1);

	docks_objcon = 10;

	print ("docks objcon is 10, spawning rear guys if warden is alive");

	if ai_living_count (AI.sq_docks_warden) > 0 then

		--hacking in a spawn fix for OSR-141194

		ai_place_with_slip_space (AI.sq_docks_crawlers_1_wave2);
		sleep_s (0.3);
		SlipSpaceSpawn (AI.sq_docks_soldiers_1_wave2);
		sleep_s (0.3);
		SlipSpaceSpawn (AI.sq_docks_watchers_1_wave2);
			
	end

	SleepUntil ([| ai_living_count (AI.sg_docks_wave2) > 0 or ai_living_count (AI.sq_docks_warden) <= 0 ], 1);

	docks_objcon = 15;

	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_objcon_20) or ai_living_count (AI.sg_docks_wave2) <= 2 ], 1);
	
	game_save_no_timeout();
	
	docks_objcon = 20;

end



--  **************************************************************************************** --
--  ********************  			      GOAL 8 - TEMPLE3               *********************** --
--  **************************************************************************************** --

missionBuilder.goal_temple3 = 

{
	gotoVolume = VOLUMES.tv_goal_vtol,
	next={"goal_vtol"},
	zoneSet = ZONE_SETS.zn_to_canyon,

}


function missionBuilder.goal_temple3.Start() :void                          

	print ("setting players loadout...");
	CreateThread(nar_goal_builder_temple3);
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player3 );

	print("goal_temple3_start");
	print("attempting to save...");	

	object_destroy (OBJECTS.temple3_rampshield_1);
	object_destroy (OBJECTS.temple3_rampshield_2);
	
	game_save_no_timeout();

	SleepUntil ([| volume_test_players (VOLUMES.tv_blip18_active)], 1);

	CreateThread (set_objective_blip, "blip_18");	

	ai_disable_jump_hint(HINTS.jh_temple3_exit1);
	ai_disable_jump_hint(HINTS.jh_temple3_exit2);	

	SleepUntil ([| volume_test_players (VOLUMES.tv_temple3_initiate)], 1);	
	device_set_power(OBJECTS.dm_temple3_ceiling, 1);
	sleep_s(1);
	pup_play_show ("vin_builder_temple3_console");

	SleepUntil ([| b_temple3_console_ready], 1);

	sleep_s (0.1);

	device_set_power (OBJECTS.temple_control_3, 1);
	device_set_position (OBJECTS.temple_control_3, 0);
	
	SleepUntil ([| device_get_position (OBJECTS.temple_control_3) == 1], 1);

	zone_set_trigger_volume_enable("zone_set:zn_to_canyon", true);

	CreateThread (temple3_musk_control);
	
	CreateThread (clear_objective_blips);		
	
	--navpoint_track_flag (FLAGS.temple_control_3_flag, false);		
	object_destroy (OBJECTS.temple_control_3);	
		
	pup_play_show ("vin_builder_temple3_ics");
	
	SleepUntil([| b_temple3_ics_complete], 1);

	g_ics_player = nil;
	
--	CreateThread (Temple3_Teleport);	
	
	n_gateway_state = 3;	

	CreateThread (nar_bldr_final_console_use);
	-- narrative thread!
	
	SleepUntil ([| b_temple3_shutter_ready], 1);
	
	--CreateThread(audio_builder_thread_up_elevator_start);
	
	pup_play_show ("vin_builder_temple3_window");

	RunClientScript("ShakeHard");

	sleep_s (2);

	CreateThread (set_objective_blip, "blip_19");	

	CreateThread (f_damage_first_vtolbashes);
	
	-----Canyon Streaming-----
	CreateThread (stream_canyon_zone_set);
	CreateThread (enable_foot_path_canyon_trigger);
	CreateThread (control_caverns_zone_sets);

	CreateThread (temple3_obj);

	sleep_s (3);
	
	CreateThread(DocksBridges);
	CreateThread (VTOL_entrance_control);

	SleepUntil ([| volume_test_players (VOLUMES.tv_docks_exit)], 1);	

	CreateThread (set_objective_blip, "blip_20");	

--	CreateThread (f_builder_chapter_4);

end


function temple3_musk_control()

	if not IsPlayer (SPARTANS.linda) then
		MusketeerDestSetPoint(SPARTANS.linda, POINTS.ps_temple3_musk_points.p0, 0.7);
	end
		
	if not IsPlayer (SPARTANS.kelly) then
		MusketeerDestSetPoint(SPARTANS.kelly, POINTS.ps_temple3_musk_points.p1, 0.7);
	end
		
	if not IsPlayer (SPARTANS.fred) then
		MusketeerDestSetPoint(SPARTANS.fred, POINTS.ps_temple3_musk_points.p2, 0.7);		
	end	

end


function temple3_obj()

	SleepUntil ([| b_locate_cortana], 1);
	
	sleep_s (1);

	CreateThread (f_builder_obj_complete, TITLES.obj_builder_6);

end


function VTOL_entrance_control()

	device_set_power (OBJECTS.vtol_entrance_door, 1);
	device_set_position (OBJECTS.vtol_entrance_door, 1);
	
	SleepUntil ([| device_get_position (OBJECTS.vtol_entrance_door) >= 0.9], 1);	

	device_set_power (OBJECTS.vtol_entrance_door, 0);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_vtol_teleport)], 1);
	
	sleep_s (1);
	
	device_set_power (OBJECTS.vtol_entrance_door, 1);
	device_set_position (OBJECTS.vtol_entrance_door, 0);
	
	SleepUntil ([| device_get_position (OBJECTS.vtol_entrance_door) <= 0.2], 1);
	
--	f_volume_teleport_all_not_inside (VOLUMES.tv_vtol_teleport, FLAGS.fl_goal_vtol);
	CreateThread (vtol_teleport);

	-----Turn off zone set triggers in Temple-----
	Sleep(1);
	zone_set_trigger_volume_enable("begin_zone_set:zn_to_canyon", false);
	zone_set_trigger_volume_enable("zone_set:zn_to_canyon", false);
	prepare_to_switch_to_zone_set(ZONE_SETS.zn_canyon);
			 
end


function f_damage_first_vtolbashes()

	object_cannot_take_damage (OBJECTS.vtol_bash_1);
	object_cannot_take_damage (OBJECTS.vtol_bash_1b);
	object_cannot_take_damage (OBJECTS.vtol_bash_1c);

	print ("setting first vtol-bash health");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_vtol_tutorial) or volume_test_players (VOLUMES.tv_first_wall_breakable) ], 1);
	
	object_can_take_damage (OBJECTS.vtol_bash_1);
	object_can_take_damage (OBJECTS.vtol_bash_1b);
	object_can_take_damage (OBJECTS.vtol_bash_1c);		
	
	sleep_s (0.1);
	
	object_set_health (OBJECTS.vtol_bash_1, 0.4);
	object_set_health (OBJECTS.vtol_bash_1b, 0.4);
	object_set_health (OBJECTS.vtol_bash_1c, 0.4);

end
-----Canyon Streaming Logic-----
function stream_canyon_zone_set()

	SleepUntil([| object_valid("vtol_bash_1") == true and object_valid("vtol_bash_1b") == true and object_valid("vtol_bash_1c") == true], 1); 
	Sleep(2);
	--Once one of the walls break, load the zn_canyon zone set.
	SleepUntil([| object_get_health (OBJECTS.vtol_bash_1) <= 0.1 or object_get_health (OBJECTS.vtol_bash_1b) <= 0.1 or object_get_health (OBJECTS.vtol_bash_1c) <= 0.1 ], 1);
	
	if current_zone_set() == ZONE_SETS.zn_canyon then
		switch_zone_set(ZONE_SETS.zn_canyon);
	end

end

function enable_foot_path_canyon_trigger()

	SleepUntil([| volume_test_players (VOLUMES.tv_on_foot_zone_set_zn_canyon)]);

	switch_zone_set(ZONE_SETS.zn_canyon);

end

function check_players_position(begin_trigger:volume, load_trigger:volume, bsp1_volume:volume, bsp2_volume:volume, teleport_to_flag:flag)
	print("in 'check_players_position'");
	for _, player in pairs(players()) do
		print("checking where ", player, "is...");
		--if not volume_test_object(safe_begin_trigger, player) and not volume_test_object(safe_load_trigger, player) then
		if bsp2_volume ~= nil then
			if volume_test_object (begin_trigger, player) or volume_test_object (load_trigger, player) or volume_test_object(bsp1_volume, player) or volume_test_object(bsp2_volume, player) then
				print(player, " NEEDS TO BE TELEPORTED!!!");
				teleport_player_to_flag(player, teleport_to_flag, false);
				print(player, " SHOULD HAVE BEEN TELEPORTED!!!");
			end
		else
			if volume_test_object (begin_trigger, player) or volume_test_object (load_trigger, player) or volume_test_object(bsp1_volume, player) then
				print(player, " NEEDS TO BE TELEPORTED!!!");
				teleport_player_to_flag(player, teleport_to_flag, false);
				print(player, " SHOULD HAVE BEEN TELEPORTED!!!");
			end
		
		end
	end
	Sleep(2);
	print("done with 'check_players_position'");

end


function control_caverns_zone_sets()

	print("in 'control_caverns_zone_sets'");
		
	repeat
		if current_zone_set() == ZONE_SETS.zn_canyon then
			if volume_test_players (VOLUMES.tv_begin_zone_set_zn_to_grasslands) then
				print("a player is in 'BEGIN_zone_set_zn_grasslands'");
				check_players_position(VOLUMES.tv_begin_zone_set_zn_canyon, VOLUMES.tv_zone_set_zn_canyon, VOLUMES.tv_cavernair1, VOLUMES.tv_caverns, FLAGS.flag_canyon_to_grasslands);
				prepare_to_switch_to_zone_set(ZONE_SETS.zn_to_grasslands);
				
				repeat			
					if volume_test_players (VOLUMES.tv_zone_set_zn_to_grasslands) then
						print("a player is in 'ZONE_SET_zn_grasslands'");
						check_players_position(VOLUMES.tv_begin_zone_set_zn_canyon, VOLUMES.tv_zone_set_zn_canyon, VOLUMES.tv_cavernair1, VOLUMES.tv_caverns, FLAGS.flag_canyon_to_grasslands);
						switch_zone_set(ZONE_SETS.zn_to_grasslands);
					end
					Sleep(1);
				until current_zone_set_fully_active() == ZONE_SETS.zn_to_grasslands or volume_test_players(VOLUMES.tv_begin_zone_set_zn_canyon) or volume_test_players(VOLUMES.tv_zone_set_zn_canyon);
			end
			Sleep(1);
		elseif current_zone_set() == ZONE_SETS.zn_to_grasslands then
			if volume_test_players (VOLUMES.tv_begin_zone_set_zn_canyon) then
				print("a player is in 'BEGIN_zone_set_zn_canyon'");
				check_players_position(VOLUMES.tv_begin_zone_set_zn_to_grasslands, VOLUMES.tv_zone_set_zn_to_grasslands, VOLUMES.tv_caverns3, nil, FLAGS.flag_grasslands_to_canyon);
				prepare_to_switch_to_zone_set(ZONE_SETS.zn_canyon);
				
				repeat
					if volume_test_players (VOLUMES.tv_zone_set_zn_canyon) then
						print("a player is in 'ZONE_SET_zn_canyon'");
						check_players_position(VOLUMES.tv_begin_zone_set_zn_to_grasslands, VOLUMES.tv_zone_set_zn_to_grasslands, VOLUMES.tv_caverns3, nil, FLAGS.flag_grasslands_to_canyon);
						switch_zone_set(ZONE_SETS.zn_canyon);
					end
					Sleep(1);
				until current_zone_set_fully_active() == ZONE_SETS.zn_canyon or volume_test_players(VOLUMES.tv_begin_zone_set_zn_to_grasslands) or volume_test_players(VOLUMES.tv_zone_set_zn_to_grasslands);
			end
			Sleep(1);
		end		
		Sleep(1);
	until current_zone_set_fully_active() == ZONE_SETS.zn_builder_end;
	print("done repeating...  should be zn_grasslands");
end

function vtol_teleport()

	TempleTeleport(SPARTANS.chief, VOLUMES.tv_vtol_teleport, FLAGS.fl_vtol_teleport_chief);
	TempleTeleport(SPARTANS.fred, VOLUMES.tv_vtol_teleport, FLAGS.fl_vtol_teleport_fred);
	TempleTeleport(SPARTANS.kelly, VOLUMES.tv_vtol_teleport, FLAGS.fl_vtol_teleport_kelly);
	TempleTeleport(SPARTANS.linda, VOLUMES.tv_vtol_teleport, FLAGS.fl_vtol_teleport_linda);	
	
end


function temple3_domeattach()

	object_create ("temple3_dome_1");
	objects_physically_attach( OBJECTS.dm_temple3_console, "bubble_snap", OBJECTS.temple3_dome_1, "" );

	MusketeersOrderTurnAllOff();

--	f_volume_teleport_all_not_inside (VOLUMES.tv_temple3_teleport, FLAGS.flag_temple3_teleport);


	
end

function temple3_domedetach()

	objects_detach( OBJECTS.dm_temple3_console, OBJECTS.temple3_dome_1);
	object_destroy (OBJECTS.temple3_dome_1);
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_energy\003_amb_positional_energy_shielddrop_builder.sound'), nil, 1);

	ai_enable_jump_hint(HINTS.jh_temple3_exit1);
	ai_enable_jump_hint(HINTS.jh_temple3_exit2);	

	MusketeersOrderTurnAllOn();
	
end


function temple3_teleport()

	TempleTeleport(SPARTANS.chief, VOLUMES.tv_temple3_teleport, FLAGS.temple3_chief_tele);
	TempleTeleport(SPARTANS.fred, VOLUMES.tv_temple3_teleport, FLAGS.temple3_fred_tele);
	TempleTeleport(SPARTANS.kelly, VOLUMES.tv_temple3_teleport, FLAGS.temple3_kelly_tele);
	TempleTeleport(SPARTANS.linda, VOLUMES.tv_temple3_teleport, FLAGS.temple3_linda_tele);	
	
	MusketeerDestClear(SPARTANS.chief);
	MusketeerDestClear(SPARTANS.fred);
	MusketeerDestClear(SPARTANS.kelly);
	MusketeerDestClear(SPARTANS.linda);				
	
end


--  **************************************************************************************** --
--  ********************  			      GOAL 9 - VTOL CANYON           *********************** --
--  **************************************************************************************** --

function UpdateBuilderOptimizations():void
	repeat
		air_fp_min_spacing = 1.2;
		Sleep(1);
	until (b_shouldOptimizeBuilder == false)
	air_fp_min_spacing = 0.5;
end


missionBuilder.goal_vtol = 

{
	gotoVolume = VOLUMES.tv_goal_finalwalk,
	next={"goal_finalwalk"},
	zoneSet = ZONE_SETS.zn_canyon,

}

function missionBuilder.goal_vtol.Start() :void                          

	print ("setting players loadout...");
	CreateThread(nar_goal_builder_flight);
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player3 );

	b_shouldOptimizeBuilder = true; -- Set to faster spacing for framerate
	CreateThread(UpdateBuilderOptimizations);

	CreateThread (vtol_canyon_blips);
	CreateThread (audio_enter_vtol_canyon);

	if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then

		CreateThread (TakeAHike);
		CreateThread (IsSpartanInVTOL, SPARTANS.chief);
		CreateThread (IsSpartanInVTOL, SPARTANS.fred);
		CreateThread (IsSpartanInVTOL, SPARTANS.kelly);
		CreateThread (IsSpartanInVTOL, SPARTANS.linda);	
		
	end	

	print("goal_vtol_start");
	print("attempting to save...");	

	CreateThread (audio_builder_thread_up_vtol_start);	
	
	game_save_no_timeout();
	
	sleep_s (1);
	
	CreateThread (canyon_spawn_control);	
	CreateThread (canyon_objcon_control);
	
	print("attempting to save...");	
--	CreateThread (canyon_save_loop);
	
	sleep_s (3);
	
	CreateThread (vtol_tutorial, SPARTANS.chief);
	CreateThread (vtol_tutorial, SPARTANS.fred);
	CreateThread (vtol_tutorial, SPARTANS.linda);
	CreateThread (vtol_tutorial, SPARTANS.kelly);	
	
	CreateThread (f_musketeer_wall_shoot, SPARTANS.chief);
	CreateThread (f_musketeer_wall_shoot, SPARTANS.fred);
	CreateThread (f_musketeer_wall_shoot, SPARTANS.linda);
	CreateThread (f_musketeer_wall_shoot, SPARTANS.kelly);	

	CreateThread (CanyonRespawnFix);

	SleepUntil ([| volume_test_players (VOLUMES.tv_vtol_exit)], 1);

	CreateThread (VTOL_exit_control);
	
	CreateThread (audio_gateway_final_reveal);
	

	
end


function vtol_canyon_blips()

	print ("vtol canyon blips are starting");

	CreateThread (set_objective_blip, "blip_20");	

	SleepUntil ([| volume_test_players (VOLUMES.tv_blip21_active)], 1);	

	CreateThread (set_objective_blip, "blip_21");

	SleepUntil ([| volume_test_players (VOLUMES.tv_blip22_active)], 1);	

	CreateThread (set_objective_blip, "blip_22");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip23_active)], 1);	

	CreateThread (set_objective_blip, "blip_23");	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip24_active)], 1);	

	CreateThread (set_objective_blip, "blip_24");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip25_active)], 1);	

	CreateThread (set_objective_blip, "blip_25");			
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip26_active)], 1);	

	CreateThread (set_objective_blip, "blip_26");		
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_blip27_active)], 1);	

	CreateThread (set_objective_blip, "blip_27");		

end


function canyon_spawn_control()

	CreateThread(canyonRoom2);
	CreateThread(canyonRoom3);
	CreateThread(canyonRoom4);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_20)], 1);
	
	ai_place(AI.sq_canyon_infantry_1a);
	ai_place(AI.sq_canyon_infantry_1c);
	
	CreateThread (f_musketeer_wall_shoot_2, SPARTANS.chief);
	CreateThread (f_musketeer_wall_shoot_2, SPARTANS.fred);
	CreateThread (f_musketeer_wall_shoot_2, SPARTANS.linda);
	CreateThread (f_musketeer_wall_shoot_2, SPARTANS.kelly);		

	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_30)], 1);

	SlipSpaceSpawn (AI.sq_canyon_infantry_3a);	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_40)], 1);
	
	SlipSpaceSpawn (AI.sq_canyon_infantry_4a);
	SlipSpaceSpawn (AI.sq_canyon_infantry_4b);		
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_55)], 1);
	
	SlipSpaceSpawn (AI.sq_canyon_turrets_4a);
	SlipSpaceSpawn (AI.sq_canyon_turrets_4b);
	
	CreateThread (f_musketeer_wall_shoot_3, SPARTANS.chief);
	CreateThread (f_musketeer_wall_shoot_3, SPARTANS.fred);
	CreateThread (f_musketeer_wall_shoot_3, SPARTANS.linda);
	CreateThread (f_musketeer_wall_shoot_3, SPARTANS.kelly);		
		
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_60)], 1);
	
	SlipSpaceSpawn (AI.sq_canyon_infantry_5a);
	SlipSpaceSpawn (AI.sq_canyon_infantry_5b);	
	
end


function f_musketeer_wall_shoot(p_player:object)

	SleepUntil ([| unit_in_vehicle (p_player)], 1);

	print ("musketeer or not!?");

	if (not IsPlayer (p_player)) then
	
		print ("character is musketeer");
	
		if
			unit_in_vehicle (p_player) 
		then

			print ("musketeer is in vtol, continuing help script");

			print ("20...");
			sleep_s (5);
			print ("15...");	
			sleep_s (5);
			print ("10...");
			sleep_s (5);
			print ("5...");
			sleep_s (5);
			
			print ("helping the player out...");						
			
			object_set_health (OBJECTS.vtol_bash_1, 0.1);
			
			print ("setting the breakable walls team!");
			ai_object_set_team (OBJECTS.vtol_bash_1, TEAM.forerunner);
	
			sleep_s (0.1);
			
			print ("enabling targeting from vehicle!");
			ai_object_enable_targeting_from_vehicle (OBJECTS.vtol_bash_1, true);
				
			MusketeersOrderProsecuteTarget (PLAYERS.player0, OBJECTS.vtol_bash_1, false);
			
			SleepUntil ([| 
			
			object_get_health (OBJECTS.vtol_bash_1) <= 0
			or
			volume_test_object(VOLUMES.tv_canyon_hole_1a, p_player)
			
			], 1);	

			object_can_take_damage (OBJECTS.vtol_bash_1);

			sleep_s (0.1);
			
			damage_object(OBJECTS.vtol_bash_1, "default", 1000);

			MusketeerDestSetPoint(p_player, POINTS.ps_vtol_goto.p1, 3);
			
			sleep_s (5);
			
			MusketeerDestClear(p_player);
			
		else
			print ("...isn't in a vtol, nevermind");
		end	
	
	else	
		print ("...is a player, nevermind.");	
	end	
	
end


function f_musketeer_wall_shoot_2(p_player:object)

	print ("musketeer or not!?");

	if (not IsPlayer (p_player)) then
	
		print ("character is musketeer");
	
		if
			unit_in_vehicle (p_player) 
		then

			print ("musketeer is in vtol, continuing help script");

			print ("40...");
			sleep_s (5);
			print ("35...");	
			sleep_s (5);
			print ("30...");
			sleep_s (5);
			print ("25...");	
			sleep_s (5);
			print ("20...");
			sleep_s (5);
			print ("15...");	
			sleep_s (5);
			print ("10...");
			sleep_s (5);
			print ("5...");
			sleep_s (5);
			
			print ("helping the player out...");						

			print ("setting the breakable walls team!");
			ai_object_set_team (OBJECTS.vtol_bash_2, TEAM.forerunner);
	
			sleep_s (0.1);
			
			print ("enabling targeting from vehicle!");
			ai_object_enable_targeting_from_vehicle (OBJECTS.vtol_bash_2, true);
				
			MusketeersOrderProsecuteTarget (PLAYERS.player0, OBJECTS.vtol_bash_2, false);
			
			SleepUntil ([| 
			
			object_get_health (OBJECTS.vtol_bash_2) <= 0
			or
			volume_test_object(VOLUMES.tv_hole2_check, p_player)
			
			], 1);	

			damage_object(OBJECTS.vtol_bash_2, "default", 1000);	

			MusketeerDestSetPoint(p_player, POINTS.ps_vtol_goto.p2, 3);
			
			sleep_s (5);
			
			MusketeerDestClear(p_player);
		
		else
			print ("...isn't in a vtol, nevermind");
		end	
	
	else	
		print ("...is a player, nevermind.");	
	end	
	
end


function f_musketeer_wall_shoot_3(p_player:object)

	print ("musketeer or not!?");

	if (not IsPlayer (p_player)) then
	
		print ("character is musketeer");
	
		if
			unit_in_vehicle (p_player) 
		then

			print ("musketeer is in vtol, continuing help script");

			print ("40...");
			sleep_s (5);
			print ("35...");	
			sleep_s (5);
			print ("30...");
			sleep_s (5);
			print ("25...");	
			sleep_s (5);
			print ("20...");
			sleep_s (5);
			print ("15...");	
			sleep_s (5);
			print ("10...");
			sleep_s (5);
			print ("5...");
			sleep_s (5);
			
			print ("helping the player out...");						
					
			print ("setting the breakable walls team!");
			ai_object_set_team (OBJECTS.vtol_bash_3, TEAM.forerunner);
	
			sleep_s (0.1);
			
			print ("enabling targeting from vehicle!");
			ai_object_enable_targeting_from_vehicle (OBJECTS.vtol_bash_3, true);
				
			MusketeersOrderProsecuteTarget (PLAYERS.player0, OBJECTS.vtol_bash_3, false);
			
			SleepUntil ([| 
			
			object_get_health (OBJECTS.vtol_bash_3) <= 0
			or
			volume_test_object(VOLUMES.tv_canyon_hole_4a, p_player)
			
			], 1);	

			damage_object(OBJECTS.vtol_bash_3, "default", 1000);	

			MusketeerDestSetPoint(p_player, POINTS.ps_vtol_goto.p3, 3);
			
			sleep_s (5);
			
			MusketeerDestClear(p_player);
		
		else
			print ("...isn't in a vtol, nevermind");
		end	
	
	else	
		print ("...is a player, nevermind.");	
	end	
	
end


function hide_watcher()

	object_hide (AI.vtol_temp_watcher, true);

end


function cs_musketeer_shoot_wall()
	
	print("blah");
	cs_look_object (object_get_ai(ai_current_actor), true, OBJECTS.vtol_bash_1);
	cs_move_towards_point	(object_get_ai(ai_current_actor), true, POINTS.ps_vtol_musketeer_points.p0, 1 );
	
		repeat

		--cs_shoot (object_get_ai(ai_current_actor), true, OBJECTS.vtol_bash_1);
		cs_shoot_at (object_get_ai(ai_current_actor), true, FLAGS.fl_vtol_target_1 );

		sleep_s (1);
	
		until (object_get_health (OBJECTS.vtol_bash_1) <= 0);

end


function VTOL_exit_control()

	CreateThread(audio_builder_thread_up_vtol_end);

	sleep_s (3);

	print ("teleporting players together");

	f_volume_teleport_all_not_inside (VOLUMES.tv_vtol_exit_teleport, FLAGS.fl_vtol_exit_teleport);

	device_set_power (OBJECTS.vtol_exit_door, 1);
	device_set_position (OBJECTS.vtol_exit_door, 1);
	
	SleepUntil ([| device_get_position (OBJECTS.vtol_exit_door) >= 0.9], 1);	

	device_set_power (OBJECTS.vtol_exit_door, 0);

		 
end


function vtol_tutorial(p_player:object)
	print ("waiting for players to enter VTOLs");
	
	sleep_s (0.2);
	
	SleepUntil ([|  vehicle_driver (OBJECTS.vtol_1) == p_player or vehicle_driver (OBJECTS.vtol_2) == p_player], 1);
	
	sleep_s (1);
	
	print ("player is driver");	
	
	sleep_s (2);
	
	print ("playing first vtol tutorial");
	TutorialShow (unit_get_player (p_player), "training_phaeton_ascend", 5);

	sleep_s (5);
	
	TutorialStop (unit_get_player (p_player));	

	sleep_s (1);
	
	print ("playing second vtol tutorial");
	TutorialShow (unit_get_player (p_player), "training_phaeton_descend", 5);
	
	sleep_s (5);
	
	TutorialStop (unit_get_player (p_player));	
		
	sleep_s (1);

	print ("playing third vtol tutorial");
	TutorialShow (unit_get_player (p_player), "training_phaeton_boost", 5);				

	sleep_s (5);
	
	TutorialStop (unit_get_player (p_player));	
		
	sleep_s (1);

	print ("playing fourth vtol tutorial");
	TutorialShow(unit_get_player (p_player), "training_phaeton_shoot", 5);			

	sleep_s (5);	
	
	TutorialStop (unit_get_player (p_player));
		
	sleep_s (1);		

	TutorialShow (unit_get_player (p_player), "training_phaeton_weaponchange", 5);					

	sleep_s (5);	
	
	TutorialStop(unit_get_player (p_player));	

end


function canyon_save_loop() 

	repeat
	
		game_save_no_timeout();
		
		sleep_s (45);		
	
	until volume_test_players (VOLUMES.tv_vtol_exit);
	
end


function canyon_objcon_control()

	print ("players are in a VTOL, musketeer script control assumed");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_10)], 1);
	
	n_canyon_objcon = 10;

	game_save_no_timeout();

	print ("canyon_objcon is 10, moving up");
	
		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_follow_start, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_follow_start, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_follow_start, SPARTANS.fred);			
		end	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_20)], 1);
	
	n_canyon_objcon = 20;

	game_save_no_timeout();
	
	print ("canyon_objcon is 20, moving up");

		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_first_follow_point, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_first_follow_point, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_first_follow_point, SPARTANS.fred);			
		end

	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_30)], 1);
	
	n_canyon_objcon = 30;

	game_save_no_timeout();
	
	print ("canyon_objcon is 30, moving up");
	
		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_second_follow_point, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_second_follow_point, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_second_follow_point, SPARTANS.fred);			
		end	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_40)], 1);
	
	n_canyon_objcon = 40;

	game_save_no_timeout();
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_45)], 1);	
	
	print ("canyon_objcon is 45, moving up");
	
		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_third_follow_point, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_third_follow_point, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_third_follow_point, SPARTANS.fred);			
		end		
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_50)], 1);
	
	n_canyon_objcon = 50;

	game_save_no_timeout();

	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_55)], 1);
	
	print ("canyon_objcon is 55, moving up");
	
		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_fourth_follow_point, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_fourth_follow_point, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_fourth_follow_point, SPARTANS.fred);			
		end			
		
	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_60)], 1);
	
	n_canyon_objcon = 60;

	game_save_no_timeout();
	
	print ("canyon_objcon is 60, moving up");

		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_fifth_follow_point, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_fifth_follow_point, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_fifth_follow_point, SPARTANS.fred);			
		end			

	SleepUntil ([| volume_test_players (VOLUMES.tv_canyon_objcon_70)], 1);
	
	n_canyon_objcon = 70;

	game_save_no_timeout();
	
	print ("canyon_objcon is 70, releasing them!");

		if not IsPlayer (SPARTANS.linda) and not unit_in_vehicle (SPARTANS.linda) then
			CreateThread (musketeer_release_from_follow, SPARTANS.linda);
		end
		
		if not IsPlayer (SPARTANS.kelly) and not unit_in_vehicle (SPARTANS.kelly) then
			CreateThread (musketeer_release_from_follow, SPARTANS.kelly);
		end
		
		if not IsPlayer (SPARTANS.fred) and not unit_in_vehicle (SPARTANS.fred) then
			CreateThread (musketeer_release_from_follow, SPARTANS.fred);			
		end			


end


function musketeer_follow_start(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
		MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p0, 3);
		MusketeerDestSetCombatRange(p_player, 3);
	end	

end


function musketeer_first_follow_point(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
	
		if 
			volume_test_players (VOLUMES.tv_start_follow_check) 
		then
			
			print ("player is close to teleport point, forcing run");
			
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p1, 3);
			MusketeerDestSetCombatRange(p_player, 3);
		
			SleepUntil ([| volume_test_players (VOLUMES.tv_first_follow_check)], 1);		
				
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p1a, 3);
			
		else

			print ("player is not close to teleport point, allowing teleport");
		
			MusketeerDestClear(p_player);
			object_teleport (p_player, FLAGS.fl_first_follow_point_tele);
			sleep_s (0.1);
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p1, 3);
			MusketeerDestSetCombatRange(p_player, 3);
		
			SleepUntil ([| volume_test_players (VOLUMES.tv_first_follow_check)], 1);		
				
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p1a, 3);
		
		end
		
	end	

end


function musketeer_second_follow_point(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
	
		if 
			volume_test_players (VOLUMES.tv_second_follow_check) 
		then
	
			print ("player is close to teleport point, forcing run");
	
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p2, 3);
			MusketeerDestSetCombatRange(p_player, 3);
	
		else

			print ("player is not close to teleport point, allowing teleport");
			MusketeerDestClear(p_player);				
			object_teleport (p_player, FLAGS.fl_second_follow_point_tele);
			sleep_s (0.1);
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p2, 3);
			MusketeerDestSetCombatRange(p_player, 3);
			
		end
		
	end	

end


function musketeer_third_follow_point(p_player:object)

	if
		unit_in_vehicle (p_player)
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
	
		object_teleport (p_player, FLAGS.fl_third_follow_point_tele);
		MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p3, 3);
		MusketeerDestSetCombatRange(p_player, 3);

		SleepUntil ([| ai_living_count (AI.sq_canyon_infantry_4a) > 0 ], 1);
		
		sleep_s (0.1);
		
		SleepUntil ([| ai_living_count (AI.sq_canyon_infantry_4a) <= 0 ], 1);
		
		MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p3a, 3);
		MusketeerDestSetCombatRange(p_player, 3);
		
	end	

end


function musketeer_fourth_follow_point(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
	
		if 
			volume_test_players (VOLUMES.tv_third_follow_check) 
		then
	
			print ("player is close to teleport point, forcing run");

			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p4, 1);
			MusketeerDestSetCombatRange(p_player, 3);
	
		else
		
			print ("player is not close to teleport point, allowing teleport");		
				
			if volume_test_object (VOLUMES.tv_third_follow_check, p_player) then
			
				object_teleport (p_player, FLAGS.fl_fourth_follow_point_tele);
			
			end
			
			MusketeerDestClear(p_player);
			sleep_s (0.1);
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p4, 1);
			MusketeerDestSetCombatRange(p_player, 3);	
	
		end
		
	end	

end


function musketeer_fifth_follow_point(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
		MusketeerDestClear(p_player);
	else
	
		if 
			volume_test_players (VOLUMES.tv_fourth_follow_check) 
		then	

			print ("player is close to teleport point, forcing run");	

			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p5, 5);
			MusketeerDestSetCombatRange(p_player, 5);
	
		else
	
			print ("player is not close to teleport point, allowing teleport");		
			MusketeerDestClear(p_player);
			object_teleport (p_player, FLAGS.fl_fifth_follow_point_tele);
			sleep_s (0.1);
			MusketeerDestSetPoint(p_player, POINTS.ps_follow_points.p5, 5);
			MusketeerDestSetCombatRange(p_player, 5);
	
		end
		
	end	

end


function musketeer_release_from_follow(p_player:object)

	if
		unit_in_vehicle (p_player) 
	then
		print ("musketeer in vtol, cancelling");
	else
		MusketeerDestClear(p_player);
	end	

end


function canyonRoom2()
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_20_low) or volume_test_players(VOLUMES.tv_canyon_20_mid)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_1d);
	if volume_test_players(VOLUMES.tv_canyon_20_mid) then
		SlipSpaceSpawn(AI.sq_canyon_turrets_1b);
	elseif volume_test_players(VOLUMES.tv_canyon_20_low) then
		SlipSpaceSpawn(AI.sq_canyon_turrets_1c);
	end
	
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_20_top)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_1a);
end

function canyonRoom3()
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_30_low) or volume_test_players(VOLUMES.tv_canyon_30_high) or volume_test_players(VOLUMES.tv_canyon_30_foot)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_2b);
	if volume_test_players(VOLUMES.tv_canyon_30_high) then
		SlipSpaceSpawn(AI.sq_canyon_turrets_2d);
	elseif volume_test_players(VOLUMES.tv_canyon_30_low) then
		SlipSpaceSpawn(AI.sq_canyon_turrets_2a);	
	end
	if volume_test_players(VOLUMES.tv_canyon_30_foot) then
		SlipSpaceSpawn(AI.sq_canyon_turrets_2c);
	end
end

function canyonRoom4()
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_40_foot) or volume_test_players(VOLUMES.tv_canyon_40_air)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_3b);
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_objcon_50)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_3c);	
	SleepUntil ([| volume_test_players(VOLUMES.tv_canyon_40_bottom)], 1);
	SlipSpaceSpawn(AI.sq_canyon_turrets_3d);	
	
end

function CanyonRespawnFix()

	repeat
		
		local isPlayerInUnsafeVolume:boolean = 

			volume_test_players(VOLUMES.tv_canyon_hole_1a) or 
			volume_test_players(VOLUMES.tv_canyon_hole_1b) or
			volume_test_players(VOLUMES.tv_canyon_hole_1c) or
		
			volume_test_players(VOLUMES.tv_canyon_hole_2a) or 
			volume_test_players(VOLUMES.tv_canyon_hole_2b) or
		
			volume_test_players(VOLUMES.tv_canyon_hole_3a) or
			volume_test_players(VOLUMES.tv_canyon_hole_3b) or
		
			volume_test_players(VOLUMES.tv_canyon_hole_4a) or 
			volume_test_players(VOLUMES.tv_canyon_hole_4b);
	
		-- If a player is in an unsafe volume, it's not safe to respawn.
		game_safe_to_respawn(not isPlayerInUnsafeVolume);

		-- If a player is in an unsafe volume, wait a few seconds before allowing them to respawn.
		if (isPlayerInUnsafeVolume) then
			sleep_s (2);
			
		-- Otherwise, check every frame to see if we enter a volume where others can't respawn.			
		else
			Sleep(1);

		end	

	until b_canyon_respawn_fix
	
	game_safe_to_respawn (true);		
end


--  **************************************************************************************** --
--  ********************  			      GOAL 10 - FINAL WALK           *********************** --
--  **************************************************************************************** --


missionBuilder.goal_finalwalk = 

{
	
	zoneSet = ZONE_SETS.zn_grasslands,

}


function missionBuilder.goal_finalwalk.Start() :void                          

	print ("setting players loadout...");

	b_caves_ee_over = true;
	b_canyon_respawn_fix = true;


	CreateThread (hero_bird_4);	

	CreateThread (set_objective_blip, "blip_27");

	b_shouldOptimizeBuilder = false; -- Reset to default

	CreateThread (GrasslandsFlocks);	
	CreateThread(nar_goal_builder_approach);
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player0 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player1 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player2 );
	player_set_profile( STARTING_PROFILES.pr_promethean, PLAYERS.player3 );

	print("goal_vtol_start");
	print("attempting to save...");	
	
	game_save_no_timeout();
	--LoomNextCampaignMission();
	--print("Looming next mission: BEGIN");
	n_gateway_state = 4;
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_builder_end)], 1);
	
	CreateThread(SwitchToBuilderEnd);
	
	local end_show = pup_play_show ("vin_w3_builder_final_shot");

	SleepUntil ([| not pup_is_playing (end_show)], 1);	

	print ("Builder end");
	SetGlobalFlag("Builder_complete");	
	EndMission (missionBuilder);

end

-----End Builder Streaming Logic-----
function remoteServer.FlipBuilderEndStreamingBoolean()

	--print("about to flip bool");
	stream_builder_end = true;
	--print("bool flipped");

end

function SwitchToBuilderEnd()

	--print("about to sleep");
	SleepUntil([| stream_builder_end == true], 1);
	prepare_to_switch_to_zone_set(ZONE_SETS.zn_builder_end);
	sleep_s (1.5);
	--print("done sleeping.  about to switch");
	switch_zone_set(ZONE_SETS.zn_builder_end);
	--print("switched");
	Sleep(1);
	LoomNextCampaignMission();

end


function GrasslandsFlocks()

	flock_create ("grassland_flock_bird_01");
	flock_create ("grassland_flock_bird_02");
	flock_create ("grassland_flock_bird_03");		
		
end



-----------------------------------------------------------------------------------------------------


--  **************************************************************************************** --
--  **************************************************************************************** --
--  ********************                                             *********************** --
--  ********************  			        CLIENT SIDE                  *********************** --
--  ********************                  SCRIPTS                    *********************** --
--  ********************                                             *********************** --
--  **************************************************************************************** --
--  **************************************************************************************** --


--## CLIENT

--lightbridge on functions
function remoteClient.DocksFrontLightBridgeOn()
	interpolator_start ("temple_lightbridge_01");
end

function remoteClient.DocksSideLightBridgeOn()
	interpolator_start ("temple_lightbridge_02");
end

function remoteClient.MarshLightBridgeOn()
	object_set_cinematic_function_variable (nil, true, "scenario_interpolator4", 0, seconds_to_frames(1));
end

----lightbridge off functions
function remoteClient.DocksFrontLightBridgeOff()
	interpolator_stop ("temple_lightbridge_01");
end

function remoteClient.DocksSideLightBridgeOff()
	interpolator_stop ("temple_lightbridge_02");
end

function remoteClient.MarshLightBridgeOff()
	object_set_cinematic_function_variable (nil, true, "scenario_interpolator4", 1, 0);
end

function MarshLightBridgeOff_cin()
	object_set_cinematic_function_variable (nil, true, "scenario_interpolator4", 1, 0);
end


function remoteClient.ShakeSoft()
	camera_shake_all_coop_players (0.2, 0.2, 3);
end

function remoteClient.ShakeHard()
	camera_shake_all_coop_players (0.4, 0.4, 5);
end

function remoteClient.ShakeLong()
	camera_shake_all_coop_players (0.3, 0.3, 4);
end


