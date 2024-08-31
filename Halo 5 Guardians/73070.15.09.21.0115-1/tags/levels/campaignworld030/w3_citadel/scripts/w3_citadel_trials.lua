--## SERVER

--  **************************************************************************************** --
--  ********************  			    W3_CITADEL - TRIALS              *********************** --
--  **************************************************************************************** --

-----------------------------------------------------------------------------------------------

--  **************************************************************************************** --
--  ********************  			         VARIABLES                   *********************** --
--  **************************************************************************************** --

global obj_con_cath:number = 0;
global obj_con_tower_cavalier:number = 0;

global trials_blip:number = 0;

global b_cath_cav_start:boolean = false;
global b_bridge_unlocked:boolean = false;

global g_ics_player0:object = nil;
global g_ics_player1:object = nil;
global g_ics_player2:object = nil;
global g_ics_player3:object = nil;

global b_super_player:boolean = false;
global b_cav_fight:boolean = false;

global cin_show = nil;
global cryo_show = nil;
global warden_show = nil;

global obj_con_tower:number = 0;
global n_hallway2_objcon:number = 0;
global n_trials_elevator_2:number = 0;

global b_trials_cortana_vanish:boolean = false;

global b_trials_shield_stun:boolean = false;
global b_trials_cav_fight:boolean = false;

global b_hallway_2_last_soldiers:boolean = false;

global b_ramp_failsafe_volume:boolean = false;
global b_ramp_show_play:boolean = false;

global b_elevator1_play:boolean = false;
global b_elevator2_play:boolean = false;

global b_HasEverWiped:boolean = false;
global b_HasEverDied:boolean = false;

global b_SomeWardenDied:boolean = false;
global n_WardenDeathTimer:number = 0;

--  **************************************************************************************** --
--  ********************  			       CHAPTER TITLES                *********************** --
--  **************************************************************************************** --

function f_trials_chapter_1()

	RunClientScript ("HudShowClient",false); 
	cinematic_show_letterbox (true);
	sleep_s ( 1.5 );
	cinematic_set_title (TITLES.ct_citadel_1);
	sleep_s ( 6.5 );
	cinematic_show_letterbox (false);
	sleep_s ( 1.5 );
	RunClientScript ("HudShowClient",true); 

end


function f_trials_chapter_2()

	print ("deprectated chapter title");

end


function f_trials_chapter_3()

	print ("deprectated chapter title");

end


function f_trials_chapter_4()

	print ("deprectated chapter title");

end


function f_trials_chapter_5()

	print ("deprectated chapter title");

end


--  **************************************************************************************** --
--  ********************  			         OBJECTIVES                  *********************** --
--  **************************************************************************************** --


function f_trials_obj_1()

	sleep_s (5);

	ObjectiveShow (TITLES.ct_obj_citadel_1);

end

function f_trials_obj_1_reminder()

	ObjectiveShow  (TITLES.ct_obj_citadel_1);

end


--  **************************************************************************************** --
--  ********************  			        ACHIEVEMENTS                 *********************** --
--  **************************************************************************************** --


function PrisonBreak()

	print ("starting up prison break achievement checker!");

	RegisterDeathEvent(PrisonBreakDeathA, ai_get_object(AI.sq_bridge_cav_1));
	RegisterDeathEvent(PrisonBreakDeathB, ai_get_object(AI.sq_bridge_cav_2));
	RegisterDeathEvent(PrisonBreakDeathC, ai_get_object(AI.sq_bridge_cav_3));
	
end


function PrisonBreakDeathA (deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64)
print ("PrisonBreakDeathA");
	if(b_SomeWardenDied == true) then
		print ("Prison Break Achivement unlocked");
		CampaignScriptedAchievementUnlocked(22);
	end

		n_WardenDeathTimer = 5;
		b_SomeWardenDied = true;
		print ("b_SomeWardenDied is set to...");
		print (b_SomeWardenDied);
	
end


function PrisonBreakDeathB (deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64)
print ("PrisonBreakDeathB");
	if(b_SomeWardenDied == true) then
		print ("Prison Break Achivement unlocked");
		CampaignScriptedAchievementUnlocked(22);
	end

		n_WardenDeathTimer = 5;
		b_SomeWardenDied = true;
		print ("b_SomeWardenDied is set to...");
		print (b_SomeWardenDied);
	
end


function PrisonBreakDeathC (deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64)
print ("PrisonBreakDeathC");
	if(b_SomeWardenDied == true) then
		print ("Prison Break Achivement unlocked");
		CampaignScriptedAchievementUnlocked(22);
	end

		n_WardenDeathTimer = 5;
		b_SomeWardenDied = true;
		print ("b_SomeWardenDied is set to...");
		print (b_SomeWardenDied);
	
end


function WardenDeathCheck()

	repeat

	SleepUntil([| b_SomeWardenDied == true ], 1);
		
		repeat
			print (n_WardenDeathTimer);
			n_WardenDeathTimer = n_WardenDeathTimer - 1;
			sleep_s(1);
		until n_WardenDeathTimer <= 0;
		
	b_SomeWardenDied = false;
	print ("b_SomeWardenDied is set to...");
	print (b_SomeWardenDied);

	until 1 == 0;

end


function ReclaimerWipeTracker()

	print ("reclaimer wipe tracker is going");

	repeat
		sleep_s (0.2);
		
		if(campaign_metagame_get_total_wipe_count() ~= 0) then
			b_HasEverWiped = true;
		end	
			
	until b_HasEverWiped == true;
	
end


function ReclaimerCheck()

		if game_difficulty_get_real() == DIFFICULTY.legendary then
	
			print ("did you get the achievement?");

			if (not b_HasEverWiped) then
				CampaignScriptedAchievementUnlocked(21);
				print ("Reclaimer Acheivement Unlocked!");
			else
				print ("no achievement for you");
			end
			
		end

end


function ee_tracking(player:object)

	print ("lesdodis");

	player = nil;
	local n_progress:number = 0;

	SleepUntil ([| volume_test_players (VOLUMES.tv_ee_1)], 1);	

	print ("ee_1_hit");

		if
			volume_test_objects (VOLUMES.tv_ee_1, PLAYERS.player0)
		then
			player = PLAYERS.player0;	
		elseif 
			volume_test_objects (VOLUMES.tv_ee_1, PLAYERS.player1)
		then
			player = PLAYERS.player1;		
		elseif 
			volume_test_objects (VOLUMES.tv_ee_1, PLAYERS.player2)
		then
			player = PLAYERS.player2;		
		elseif 
			volume_test_objects (VOLUMES.tv_ee_1, PLAYERS.player3)
		then
			player = PLAYERS.player3;
		end	
	
	n_progress = n_progress + 1;
		
	SleepUntil ([| volume_test_object (VOLUMES.tv_ee_2, player) or volume_test_object (VOLUMES.tv_ee_ground, player)], 1);	
	
		if 
			volume_test_object (VOLUMES.tv_ee_2, player)
		then
			print ("ee_2_hit")
			n_progress = n_progress + 1;
		elseif
			volume_test_object (VOLUMES.tv_ee_ground, player)
		then
			print ("ee_ground_hit");
			n_progress = 0;
		end	
		
	SleepUntil ([| volume_test_object (VOLUMES.tv_ee_3, player) or volume_test_object (VOLUMES.tv_ee_ground, player)], 1);
	
		if 
			volume_test_object (VOLUMES.tv_ee_3, player)
		then
			print ("ee_3_hit")
			n_progress = n_progress + 1;
		elseif
			volume_test_object (VOLUMES.tv_ee_ground, player)
		then
			print ("ee_ground_hit");
			n_progress = 0;
		end		
	
	SleepUntil ([| volume_test_object (VOLUMES.tv_ee_4, player) or volume_test_object (VOLUMES.tv_ee_ground, player)], 1);
	
		if 
			volume_test_object (VOLUMES.tv_ee_4, player)
		then
			print ("ee_4_hit")
			n_progress = n_progress + 1;
		elseif
			volume_test_object (VOLUMES.tv_ee_ground, player)
		then
			print ("ee_ground_hit");
			n_progress = 0;
		end	
		
	SleepUntil ([| volume_test_object (VOLUMES.tv_ee_5, player) or volume_test_object (VOLUMES.tv_ee_ground, player)], 1);
	
		if 
			volume_test_object (VOLUMES.tv_ee_5, player)
		then
			print ("ee_5_hit")
			n_progress = n_progress + 1;
		elseif
			volume_test_object (VOLUMES.tv_ee_ground, player)
		then
			print ("ee_ground_hit");
			n_progress = 0;
		end	
	
	SleepUntil ([| volume_test_object (VOLUMES.tv_ee_6, player) or volume_test_object (VOLUMES.tv_ee_ground, player)], 1);
	
		if 
			volume_test_object (VOLUMES.tv_ee_6, player) and n_progress >= 5
		then
			
			object_create ("ee_target_1");
			
			print ("target ho!");
			
			SleepUntil ([| object_get_health(OBJECTS.ee_target_1) > 0], 1);
			
			sleep_s (0.1);
			
			SleepUntil ([| object_get_health(OBJECTS.ee_target_1) <= 0], 1);
			
			print ("congration, you did it");			

			SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
			
			CreateEffectGroup( EFFECTS.fx_crate_1 );
			CreateEffectGroup( EFFECTS.fx_crate_2 );
			CreateEffectGroup( EFFECTS.fx_crate_3 );
			CreateEffectGroup( EFFECTS.fx_crate_4 );
			CreateEffectGroup( EFFECTS.fx_crate_5 );
			CreateEffectGroup( EFFECTS.fx_crate_6 );
			CreateEffectGroup( EFFECTS.fx_crate_7 );
			CreateEffectGroup( EFFECTS.fx_crate_8 );	

			object_create ("ee_rack_1");
			object_create ("ee_rack_2");
			object_create ("ee_rack_3");
			object_create ("ee_rack_4");
			object_create ("ee_rack_5");
			object_create ("ee_rack_6");
			object_create ("ee_rack_7");
			object_create ("ee_rack_8");			
			
		elseif
			volume_test_object (VOLUMES.tv_ee_ground, player)
		then
			print ("ee_ground_hit");
			n_progress = 0;
		end	
	
end


function clear_objective_blips()

	object_destroy_folder ("sc_blips");

end
    
                
function set_objective_blip(blip_object:string)

	object_destroy_folder ("sc_blips");
	sleep_s(1);
	object_create(blip_object);
	
end


--  **************************************************************************************** --
--  ********************  			       MISSION SCRIPTS               *********************** --
--  **************************************************************************************** --


global missionTrials:table=
	{
		--Mission Name
		name = "w3_trials",	
		profiles = {STARTING_PROFILES.sp_chief, STARTING_PROFILES.sp_fred, STARTING_PROFILES.sp_linda, STARTING_PROFILES.sp_kelly},
		startGoals = {"goal_intro"},
		collectibles = 
		
		{
		
		{ objectName="w3_trials_collectible_1", collectibleName="w3_trials_collectible_1"},
		{ objectName="w3_trials_collectible_2", collectibleName="w3_trials_collectible_2"},
		{ objectName="w3_trials_collectible_3", collectibleName="w3_trials_collectible_3"},
		{ objectName="w3_trials_collectible_4", collectibleName="w3_trials_collectible_4"},
		{ objectName="w3_trials_collectible_5", collectibleName="w3_trials_collectible_5"},
		{ objectName="dc_skull_famine", collectibleName="collectible_skull_famine"},
		
		},
	
	}
	
	
function startup.TrialsInit()
		
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_trials);
		fade_out(0,0,0,0);
		StartTrials();
			
	end	

end	
	

function missionTrials.Start()
	print ("start Trials");
	if current_zone_set() ~= ZONE_SETS.zn_start then
	
		switch_zone_set (ZONE_SETS.zn_start);
		
	end
	
--	Sys_TeleportPlayers (missionTrials);
	Sleep(1);
	--CreateMissionThread(TrialsStart);

	-- NARRATIVE CALL
	CreateThread(trials_narrative_startup);
end


function missionTrials.End()
	print ("Trials end");
	LoomNextCampaignMission();
	print ("Loom to next mission: BEGIN");
	MusketeersOrderTurnAllOn();
	--156430, gmu moving subtitle call to client and having the movie call it
	CinematicPlay ("cin_180_trials");
	
	ReclaimerCheck();
	
	if editor_mode() == false then
		sys_LoadSentinels();
	else
		print ("in editor, not loading the next level - Sentinels)");
	end
end


function no_babysitting()
	ai_cannot_die( AI.sq_musketeer, true );
end


function StartTrials()
	StartMission(missionTrials);
end


--  **************************************************************************************** --
--  ********************  			            BLINKS                   *********************** --
--  **************************************************************************************** --


function BlinkHallway1()

	GoalBlink(missionTrials, "goal_hallway1", FLAGS.fl_goal_hallway1);
	
	CreateThread(audio_trials_stopallmusic);
	 
	sleep_s (1);
	 
	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	 
	fade_in();	

--	device_set_power (OBJECTS.dm_door_01, 1);

end


function BlinkFlashback1()

	GoalBlink(missionTrials, "goal_flashback1", FLAGS.fl_goal_flashback1);
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	
	pup_play_show ("vin_trials_elevator1");
	 
	sleep_s (1);
	 
	fade_in();

end


function BlinkTower()
	
	GoalBlink(missionTrials, "goal_tower", FLAGS.fl_goal_tower);
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	 
	sleep_s (1);
	 
	fade_in();
	 
end


function BlinkArena()

	GoalBlink(missionTrials, "goal_arena", FLAGS.fl_goal_arena);
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	
	pup_play_show ("vin_trials_elevator2");	
	 
	sleep_s (1);
	 
	fade_in();
	 
end


function BlinkFlashback2()

	GoalBlink(missionTrials, "goal_flashback2", FLAGS.fl_goal_flashback2);
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 

	pup_play_show ("vin_trials_elevator2");
	 
	sleep_s (1);
	 
	fade_in();

end


function BlinkHallway2()
	 
	GoalBlink(missionTrials, "goal_hallway2", FLAGS.fl_goal_hallway2);
	
	device_set_position_immediate( OBJECTS.dm_flashback2_elevator, 1 );
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	 
	sleep_s (1);
	 
	fade_in();

end


function BlinkCavalier()

	GoalBlink(missionTrials, "goal_cavalier", FLAGS.fl_goal_cavalier);
	
	CreateThread(audio_trials_stopallmusic);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 
	 
	sleep_s (1);
	 
	fade_in();

end


function BlinkThrone() 
	
	GoalBlink(missionTrials, "goal_throne", FLAGS.fl_goal_throne);
	
	CreateThread(audio_trials_stopallmusic);
	 
	sleep_s (1);

	unit_add_equipment( SPARTANS.chief, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.fred, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.linda, STARTING_PROFILES.pr_promethean, true, true );
	unit_add_equipment( SPARTANS.kelly, STARTING_PROFILES.pr_promethean, true, true );	 

	pup_play_show("comp_trials_end_cortana_1");
	 
	object_create ("cr_throne_lightbridge");	 
	 
	fade_in();

end


--  **************************************************************************************** --
--  ********************  			      GOAL 1 - INTRO                 *********************** --
--  **************************************************************************************** --


 missionTrials.goal_intro = 
	{
	gotoVolume = VOLUMES.tv_goal_hallway1,
	next={"goal_hallway1"},
	zoneSet = ZONE_SETS.zn_start,
	}


function missionTrials.goal_intro.Start() :void

	print("goal_intro_start");
	
	print("Playing cin 175")
	CinematicPlay("cin_175_hall");
	
	cryo_show = pup_play_show("vin_trials_h4");
	
	CreateThread (ReclaimerWipeTracker);

	CreateThread (set_objective_blip, "blip1");

	if game_difficulty_get_real() == DIFFICULTY.legendary then
		CreateThread (ee_tracking);
	end	
	
	sleep_s (1);

	-- NARRATIVE CALL
	CreateThread(trials_halo_4_flashback);
	CreateThread(trials_cathedral_hallway_encounter_warden_new);

	sleep_s (1);
		
	print("waitin on show end");
		
	SleepUntil([| not pup_is_playing(cryo_show) ], 1);

	CreateThread (cryo_show_teleport);
	
	game_save_no_timeout();
	print("attempting to save...");	
		
	Sleep(1);

	CreateThread (f_trials_chapter_1);

	CreateThread (f_trials_obj_1);
	
	CreateThread (f_elevator_hide);
	
	-- NARRATIVE CALL
	CreateThread(trials_cathedral_post_halo_4_flashback);
	CreateThread(audio_trials_thread_up_mission_start);
	


end


function cryo_show_teleport()

	object_teleport (SPARTANS.linda, FLAGS.cryo_tube_tele_linda);
	object_teleport (SPARTANS.fred, FLAGS.cryo_tube_tele_fred);
	object_teleport (SPARTANS.kelly, FLAGS.cryo_tube_tele_kelly);		

end


function comp_cryo_text_1()

	print ("debug");

end

function comp_cryo_text_2()

	print ("debug");

end

function comp_cryo_text_3()

	print ("debug");

end

function comp_cryo_text_4()

	print ("debug");

end


function f_elevator_hide()

object_hide (OBJECTS.vin_lift1_dm, true);
object_hide (OBJECTS.vin_lift2_dm, true);

end


--function cryotube_cleanup()
--	
--	print ("cleaning up");
--	object_destroy (OBJECTS.trials_cryo_tube);
--	object_destroy (OBJECTS.trials_cryo_tube2);
--	object_destroy (OBJECTS.trials_cryo_tube3);
--	object_destroy (OBJECTS.trials_cryo_tube4);
--	object_destroy (OBJECTS.plinth_1);
--	object_destroy (OBJECTS.cortana_1);
--
--end


--  **************************************************************************************** --
--  ********************  			      GOAL 2 - HALLWAY1              *********************** --
--  **************************************************************************************** --

 missionTrials.goal_hallway1 = 
	{
	gotoVolume = VOLUMES.tv_goal_flashback1,
	next={"goal_flashback1"},
	zoneSet = ZONE_SETS.zn_lowground,
	}
	
function missionTrials.goal_hallway1.Start() :void	
	
	print("goal_hallway1_start");

	game_save_no_timeout();
	print("attempting to save...");	

	CreateThread (set_objective_blip, "blip2");

	-- NARRATIVE CALL
	CreateThread(trials_hallway_load);
	
	CreateThread(audio_trials_thread_up_hallway1_door);

	SleepUntil ([| volume_test_players (VOLUMES.tv_trials_cathedral_start)], 1);	

	game_save_no_timeout();
	print("attempting to save...");	

	b_cath_cav_start = true;			--	from Guillaume: maybe you're not using this one anymore since we moved the Warden vignette. But I do use it to know where the spawning started. tell me if you need to delete it.

	SlipSpaceSpawn (AI.sq_cath_front_crawlers);
	sleep_s (0.1);
	SlipSpaceSpawn (AI.sq_cath_front_crawlers_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_front_crawlers_3);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_front_crawlers_4);
	sleep_s (0.1);
	SlipSpaceSpawn (AI.sq_cath_front_crawlers_5);

	sleep_s (1);	
	
	-- MUSIC CALL
	--CreateThread(audio_trials_thread_up_hallway1_start);	
	
	SleepUntil([| volume_test_players(VOLUMES.tv_cath_obj_con_1)], 1);
	
	obj_con_cath = 1;
	
	SlipSpaceSpawn (AI.sq_cath_bridge_soldiers);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_bridge_soldiers_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_bridge_soldiers_3);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_bridge_left_crawlers);	
	sleep_s (0.1);							
	SlipSpaceSpawn (AI.sq_cath_bridge_right_crawlers);
	sleep_s (0.1);			
	SlipSpaceSpawn (AI.sq_cath_bridge_watchers);

	SleepUntil([| volume_test_players(VOLUMES.tv_cath_obj_con_2)], 1);

	game_save_no_timeout();
	
	obj_con_cath = 2;
	
	SlipSpaceSpawn (AI.sq_cath_back_left_crawlers);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_back_right_crawlers);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_back_knight_left);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_cath_back_knight_right);						

	SleepUntil([| volume_test_players(VOLUMES.tv_cath_obj_con_3)], 1);

	obj_con_cath = 3;

	sleep_s (1);
	
	SleepUntil ([| ai_living_count (AI.sg_cath_all) <= 0], 1);

	pup_play_show ("vin_trials_elevator1");

	sleep_s (1);

	object_hide (OBJECTS.vin_lift1_dm, true);

	sleep_s (1);

	print("set door on");
	
	--	NARRATIVE CALL
	b_hallway_1_open_door = true;

	CreateThread (set_objective_blip, "blip3");	
	print ("blipping blip3");

	CreateThread (LowgroundExitDoorControl);
	
	-- OBJECTIVE REMINDER
	CreateThread (f_trials_obj_1_reminder);

	-- MUSIC END CALL	
	--CreateThread(audio_trials_thread_up_hallway1_end);
	
end



function LowgroundExitDoorControl()

	device_set_power(OBJECTS.dm_lowground_exit_door, 1);
	device_set_position (OBJECTS.dm_lowground_exit_door, 0.4);
	
	print ("opening the door");
	
	SleepUntil ([| device_get_position (OBJECTS.dm_lowground_exit_door) >= 0.4 ], 1);
	
	print ("destroying the door");
	
	object_destroy (OBJECTS.dm_lowground_exit_door);

-- added a failsafe to fix OSR-126932 for real-real, not for play-play
	

end


--  **************************************************************************************** --
--  ********************  			      GOAL 3 - FLASHBACK1            *********************** --
--  **************************************************************************************** --

 missionTrials.goal_flashback1 = 
	{
	gotoVolume = VOLUMES.tv_goal_tower,
	next={"goal_tower"},
	zoneSet = ZONE_SETS.zn_lowground,
	}


function missionTrials.goal_flashback1.Start() :void

	print("goal_flashback1_start");

	print ("turning off force walk jump hint");
	ai_disable_jump_hint(HINTS.jh_elevator1);	

	object_create ("vin_lift1_dm");
	object_hide (OBJECTS.vin_lift1_dm, true);
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	game_save_no_timeout();	
	print("attempting to save...");	

	--	NARRATIVE CALL
	CreateThread(trials_elevator_load);

--	RunClientScript("elevatorDissolve", OBJECTS.vin_lift1_dm);
	object_dissolve_from_marker( OBJECTS.vin_lift1_dm, "phase_in", "audio_center" );
	
	CreateThread (Flashback1_safety);
	
	CreateThread(audio_trials_elevatorspawn_a);

	SleepUntil([| volume_test_players(VOLUMES.tv_elevator_1_start)], 1);

	CreateThread (clear_objective_blips);	

	game_save_no_timeout();

	sleep_s (5);

	b_elevator1_play = true;

	--NARRATIVE CALL
	b_players_on_elevator_01 = true;
	
	CreateThread(audio_trials_thread_up_elevator1_start);
	
end


function Flashback1_warp_control()

	print ("teleporting players not on elevator to elevator");
	print ("teleporting musketeers not on elevator to elevator");

	FlashbackTeleport(SPARTANS.chief, VOLUMES.tv_elevator_1_start, FLAGS.elevator1_chief_teleport);
	FlashbackTeleport(SPARTANS.fred, VOLUMES.tv_elevator_1_start, FLAGS.elevator1_fred_teleport);
	FlashbackTeleport(SPARTANS.kelly, VOLUMES.tv_elevator_1_start, FLAGS.elevator1_kelly_teleport);
	FlashbackTeleport(SPARTANS.linda, VOLUMES.tv_elevator_1_start, FLAGS.elevator1_linda_teleport);		

end


function Flashback1_warp_failsafe()

	print ("FAILSAFE - teleporting players not on elevator to elevator");
	print ("FAILSAFE - teleporting musketeers not on elevator to elevator");

	FlashbackTeleport(SPARTANS.chief, VOLUMES.tv_elevator1_failsafe_teleport, FLAGS.fl_ele1_failsafe_chief);
	FlashbackTeleport(SPARTANS.fred, VOLUMES.tv_elevator1_failsafe_teleport, FLAGS.fl_ele1_failsafe_fred);
	FlashbackTeleport(SPARTANS.kelly, VOLUMES.tv_elevator1_failsafe_teleport, FLAGS.fl_ele1_failsafe_kelly);
	FlashbackTeleport(SPARTANS.linda, VOLUMES.tv_elevator1_failsafe_teleport, FLAGS.fl_ele1_failsafe_linda);		

end


function ElevatorGateOff(gate:object)

	object_set_physics (gate, false);
	
	sleep_s (0.5);
	
	object_dissolve_from_marker (gate, "phase_out", "fademarker");

end


function ElevatorGateOn(gate:object)

	object_set_physics (gate, false);
	
	sleep_s (0.5);
	
	object_dissolve_from_marker (gate, "phase_in", "fademarker");

end


function Flashback1_safety()

	print ("turning off orders and putting musketeers in objective");

	MusketeersOrderTurnAllOff();

	ai_set_objective (AI.sq_musketeer, "obj_trials_ele1");

end


function Flashback1_safety_end()

	print ("turning on orders and removing musketeers from objective");

	MusketeersOrderTurnAllOn();

	ai_set_objective (AI.sq_musketeer, "");

	ai_enable_jump_hint(HINTS.jh_elevator1);

end


--  **************************************************************************************** --
--  ********************  			      GOAL 4 - TOWER                 *********************** --
--  **************************************************************************************** --

 missionTrials.goal_tower = 
	{
	gotoVolume = VOLUMES.tv_goal_arena,
	next={"goal_arena"},
	zoneSet = ZONE_SETS.zn_midground,
	}


function missionTrials.goal_tower.Start() :void 

	print("goal_tower_start");

	-- OBJECTIVE CALL
	CreateThread (f_trials_obj_1_reminder);

	game_safe_to_respawn (true, SPARTANS.chief);
	game_safe_to_respawn (true, SPARTANS.fred);
	game_safe_to_respawn (true, SPARTANS.kelly);
	game_safe_to_respawn (true, SPARTANS.linda);

	CreateThread (set_objective_blip, "blip4");	

	-- NARRATIVE CALL
	CreateThread(trials_tower_load);

	pup_play_show ("vin_trials_elevator2");

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	--game_save_no_timeout();	    --temp until saving on device machines doesn't break save/load
	--print("attempting to save...");	
	CreateThread( temp_delay_saving_tower1 );
	
	sleep_s (4);
	
	-- MUSIC START CALL
	CreateThread(audio_trials_thread_up_tower_start);
	
	SlipSpaceSpawn (AI.sq_tower_f1_front);
	SlipSpaceSpawn (AI.sq_tower_f1_mid);
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f1_ramp_left);
	SlipSpaceSpawn (AI.sq_tower_f1_ramp_right);
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f1_rear_left);
	SlipSpaceSpawn (AI.sq_tower_f1_rear_right);	
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f1_officer1);
	SlipSpaceSpawn (AI.sq_tower_f1_officer2);	
	
	SleepUntil([|volume_test_players(VOLUMES.tv_tower_obj_con_1)], 1);

	obj_con_tower = 1;

	SleepUntil([|volume_test_players(VOLUMES.tv_tower_obj_con_2)], 1);

	CreateThread (set_objective_blip, "blip5");	
	
	obj_con_tower = 2;
	SlipSpaceSpawn (AI.sq_tower_f2_front);
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f2_mid_left);
	SlipSpaceSpawn (AI.sq_tower_f2_mid_right);
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f2_rear_left);	
	SlipSpaceSpawn (AI.sq_tower_f2_rear_right);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_tower_obj_con_3)], 1);
	
	obj_con_tower = 3;

	SleepUntil([|volume_test_players(VOLUMES.tv_blip6_activate)], 1);

	CreateThread (set_objective_blip, "blip6");	
	
	game_save_no_timeout();
	
	SleepUntil([|volume_test_players(VOLUMES.tv_tower_turret_spawn)], 1);
	
	ai_disable_jump_hint (HINTS.jh_tower_floor3);
	
	SlipSpaceSpawn (AI.sq_tower_f3_turret_1);
	SlipSpaceSpawn (AI.sq_tower_f3_turret_2);
	sleep_s (0.2);
	SlipSpaceSpawn (AI.sq_tower_f3_officer_1);
	SlipSpaceSpawn (AI.sq_tower_f3_officer_2);	
	
	SleepUntil([| ai_living_count (AI.sg_tower_floor_3) > 0], 1);	
	
	sleep_s (0.2);
	
	SleepUntil([| ai_living_count (AI.sg_tower_floor_3) <= 0], 1);	
	
	device_set_power (OBJECTS.dm_arena_airlock_door_1, 1);

	SleepUntil ([| device_get_position (OBJECTS.dm_arena_airlock_door_1) > 0.8 ], 1);

	ai_enable_jump_hint (HINTS.jh_tower_floor3);
	

end

function temp_delay_saving_tower1()
	sleep_s(8);
	game_save_no_timeout();	    --temp until saving on device machines doesn't break save/load
	print("attempting to save...");
end

--  **************************************************************************************** --
--  ********************  			      GOAL 5 - ARENA                 *********************** --
--  **************************************************************************************** --


 missionTrials.goal_arena = 
	{
	next={"goal_flashback2"},
	zoneSet = ZONE_SETS.zn_midground,
	}


function missionTrials.goal_arena.Start() :void 

	print("goal_arena_start");

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	game_save_no_timeout();	
	print("attempting to save...");	

	sleep_s (1);

	object_hide(OBJECTS.vin_lift2_dm, true);
	object_set_physics(OBJECTS.vin_lift2_dm, false);
	
	ai_disable_jump_hint (HINTS.jh_arena_onto_elevator);	
	
	device_set_power (OBJECTS.dm_arena_airlock_door_2, 1);
	
	-- NARRATIVE CALL
	CreateThread(trials_arena_load);

	SleepUntil([|volume_test_players(VOLUMES.tv_blip7_activate)], 1);

	CreateThread (set_objective_blip, "blip7");	

	SleepUntil([| volume_test_players(VOLUMES.tv_tower_spawn_cav)], 1);

	-- WARDEN APPEARS, TAUNTS AND SPAWNS ENEMIES
	pup_play_show ("comp_trials_cav_taunt");

	sleep_s (2);

	SlipSpaceSpawn (AI.sq_arena_bottom_left);
	SlipSpaceSpawn (AI.sq_arena_bottom_right);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_arena_mortar_officer_left);
	SlipSpaceSpawn (AI.sq_arena_mortar_officer_right);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_arena_center_soldiers);
	SlipSpaceSpawn (AI.sq_arena_watchers);
	sleep_s (0.1);
	SlipSpaceSpawn (AI.sq_arena_sniper_1);
	SlipSpaceSpawn (AI.sq_arena_sniper_2);
	sleep_s (0.1);		
	SlipSpaceSpawn (AI.sq_arena_mortar_officer_center);
	SlipSpaceSpawn (AI.sq_arena_top_rear_left);
	SlipSpaceSpawn (AI.sq_arena_top_rear_right);
	
	-- MUSIC START CALL
	CreateThread(audio_trials_thread_up_tower_middlewave);

	sleep_s (1);

	SleepUntil ([| ai_living_count (AI.sg_arena_all) >= 3], 1);
	
	sleep_s(1);
	
	SleepUntil ([| ai_living_count (AI.sg_arena_all) <= 0], 1);
	
	game_save_no_timeout();
	print ("arena encounter cleaned up, attempting to save");

	sleep_s (2);

	-- OBJECTIVE REMINDER
	CreateThread (f_trials_obj_1_reminder);

	CreateThread(audio_trials_thread_up_tower_middlewave_outro);
		
	sleep_s (1);

	GoalCompleteCurrent();
	
end


function cs_one_second_blind()

	ai_braindead (ai_current_actor, true);
	
	sleep_s (1);
	
	ai_braindead (ai_current_actor, false);
	
	print ("no longer braindead");	

end


function arena_airlock()

	device_set_power (OBJECTS.dm_arena_airlock_door_2, 0);
	
	SleepUntil ([| device_get_position  (OBJECTS.dm_arena_airlock_door_2) <= 0]);

end



--  **************************************************************************************** --
--  ********************  			      GOAL 6 - FLASHBACK2            *********************** --
--  **************************************************************************************** --




 missionTrials.goal_flashback2 = 
	{
	gotoVolume = VOLUMES.tv_goal_hallway2,
	next={"goal_hallway2"},
	zoneSet = ZONE_SETS.zn_midground,
	}


function missionTrials.goal_flashback2.Start() :void 

	object_hide(OBJECTS.vin_lift2_dm, true);
	print("goal_flashback2_start");

	device_set_position_immediate (OBJECTS.vin_lift2_dm, 0);

	game_save_no_timeout();
	print ("arena encounter cleaned up, attempting to save");

	print ("turning off force walk jump hint");
	ai_disable_jump_hint(HINTS.jh_elevator2);	

	object_set_physics(OBJECTS.vin_lift2_dm, true);

	print ("waiting for player proximity to elevator");
	SleepUntil([| volume_test_players(VOLUMES.tv_arena_elevator_spawn)], 1);
	
	print ("player close to elevator, spawning in");	

--	RunClientScript("elevatorDissolve", OBJECTS.vin_lift2_dm);
	object_dissolve_from_marker( OBJECTS.vin_lift2_dm, "phase_in", "audio_center" );	
	
	ai_enable_jump_hint (HINTS.jh_arena_onto_elevator);
	
	CreateThread (Flashback2_safety);
	
	CreateThread(audio_trials_elevatorspawn_b);
	
	CreateThread (clear_objective_blips);	
	
	sleep_s (1);
	
	-- NARRATIVE CALL																	--	VO ON THE ELEVATOR BEFORE THE FLASHBACK												
	CreateThread(trials_elevator_2_pre_halo_2_flashback);

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	SleepUntil([| volume_test_players(VOLUMES.tv_elevator_2_start)], 1);	

	--	NARRATIVE CALL
	b_players_on_elevator_02 = true;
	
	CreateThread(audio_trials_thread_up_elevator2_start);

	game_save_no_timeout();	
	print("attempting to save...");	

	sleep_s (5);	

	b_elevator2_play = true;
	

end


function FlashbackTeleport(p_player:object, tv_check:volume, fl_tele:flag)

	if volume_test_object(tv_check, p_player) then
	
		print ("object in volume");
		
	else
	
		object_teleport( p_player, fl_tele );

	end

end


function Flashback2_warp_control()

	print ("teleporting players not on elevator to elevator");
	print ("teleporting musketeers not on elevator to elevator");

	FlashbackTeleport(SPARTANS.chief, VOLUMES.tv_elevator_2_start, FLAGS.elevator2_chief_teleport);
	FlashbackTeleport(SPARTANS.fred, VOLUMES.tv_elevator_2_start, FLAGS.elevator2_fred_teleport);
	FlashbackTeleport(SPARTANS.kelly, VOLUMES.tv_elevator_2_start, FLAGS.elevator2_kelly_teleport);	
	FlashbackTeleport(SPARTANS.linda, VOLUMES.tv_elevator_2_start, FLAGS.elevator2_linda_teleport);		

end


function Flashback2_warp_failsafe()

	print ("FAILSAFE - teleporting players not on elevator to elevator");
	print ("FAILSAFE - teleporting musketeers not on elevator to elevator");

	FlashbackTeleport(SPARTANS.chief, VOLUMES.tv_elevator2_failsafe_teleport, FLAGS.fl_ele2_failsafe_chief);
	FlashbackTeleport(SPARTANS.fred, VOLUMES.tv_elevator2_failsafe_teleport, FLAGS.fl_ele2_failsafe_fred);
	FlashbackTeleport(SPARTANS.kelly, VOLUMES.tv_elevator2_failsafe_teleport, FLAGS.fl_ele2_failsafe_kelly);
	FlashbackTeleport(SPARTANS.linda, VOLUMES.tv_elevator2_failsafe_teleport, FLAGS.fl_ele2_failsafe_linda);		

end


function Flashback2_safety()

	print ("turning off orders and putting musketeers in objective");

	MusketeersOrderTurnAllOff();

	ai_set_objective (AI.sq_musketeer, "obj_trials_ele2");

end


function Flashback2_safety_end()

	print ("turning on orders and removing musketeers from objective");

	MusketeersOrderTurnAllOn();

	ai_set_objective (AI.sq_musketeer, "");

	ai_enable_jump_hint(HINTS.jh_elevator2);

end


--  **************************************************************************************** --
--  ********************  			      GOAL 7 - HALLWAY2              *********************** --
--  **************************************************************************************** --


 missionTrials.goal_hallway2 = 
	{
	gotoVolume = VOLUMES.tv_goal_cavalier,
	next={"goal_cavalier"},
	zoneSet = ZONE_SETS.zn_highground,
	}


function missionTrials.goal_hallway2.Start() :void 

	print("goal_hallway2_start");
	
	CreateThread(audio_trials_thread_up_arena_start);

	CreateThread (f_trials_obj_1_reminder);

	CreateThread (set_objective_blip, "blip8");	

	game_safe_to_respawn (true, SPARTANS.chief);
	game_safe_to_respawn (true, SPARTANS.fred);
	game_safe_to_respawn (true, SPARTANS.kelly);
	game_safe_to_respawn (true, SPARTANS.linda);

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	f_volume_teleport_all_not_inside (VOLUMES.tv_hallway2_teleport, FLAGS.fl_goal_hallway2);

	game_save_no_timeout();
	sleep_s (2);
	
	print ("spawning front encounter");
	SlipSpaceSpawn (AI.sq_hallway2_intro_soldiers_1);
	sleep_s (0.1);
	SlipSpaceSpawn (AI.sq_hallway2_intro_soldiers_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_intro_soldiers_3);

	-- NARRATIVE CALL
	CreateThread(trials_hallwayredux_load);

	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_10)], 1);
	
	print ("spawning mid encounter");
	SlipSpaceSpawn (AI.sq_hallway2_left_front_soldier);
	SlipSpaceSpawn (AI.sq_hallway2_right_front_soldier);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_mid_front_officer);
	SlipSpaceSpawn (AI.sq_hallway2_mid_front_officer_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_mid_front_soldiers);	
	SlipSpaceSpawn (AI.sq_hallway2_mid_turrets);												

	-- SAVE CHECKS
	CreateThread (Hallway2Save);

	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_20)], 1);
	
	print ("spawning mid-rear encounter");
	SlipSpaceSpawn (AI.sq_hallway2_mid_crawlers);
	SlipSpaceSpawn (AI.sq_hallway2_mid_crawlers_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_officers);
	SlipSpaceSpawn (AI.sq_hallway2_rear_officers_2);		
		
	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_30)], 1);
	
	print ("spawning rear encounter");
	SlipSpaceSpawn (AI.sq_hallway2_rear_knights);
	SlipSpaceSpawn (AI.sq_hallway2_rear_knights_2);
	sleep_s (0.1);
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers_2);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers_3);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers_4);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers_5);
	sleep_s (0.1);	
	SlipSpaceSpawn (AI.sq_hallway2_rear_snipers_6);					

	sleep_s (3);

	SleepUntil ([| ai_living_count (AI.sg_hallway2_rear_snipers) > 0], 1);

	sleep_s (1);

	SleepUntil ([| ai_living_count (AI.sg_hallway2_rear_snipers) <= 2], 1);
	--	NARRATIVE
	b_hallway_2_last_soldiers = true;

	print ("spawning officer reinforcements");
	SlipSpaceSpawn (AI.sq_hallway2_backup_officers);

	--sleep until everything's dead, then turn music off and unlock door

	SleepUntil ([| ai_living_count (AI.sg_hallway2_rear_all) <= 0], 1);

	b_hallway_2_door_open = true;
	
	-- MUSIC END CALL	 
	CreateThread(audio_trials_thread_up_arena_outro);
	
	device_set_power (OBJECTS.dm_cavalier_airlock_door_1, 1);
	device_set_position (OBJECTS.dm_cavalier_airlock_door_1, 1);

	CreateThread (set_objective_blip, "blip9");	
	
end


function doortest()

	device_set_power (OBJECTS.dm_cavalier_airlock_door_1, 1);
	device_set_position (OBJECTS.dm_cavalier_airlock_door_1, 1);


end


function Hallway2Save()

	SleepUntil([| ai_living_count (AI.sq_hallway2_mid_turrets) > 0 ], 1);

	sleep_s (1);
	print ("waiting for knight to die");

	SleepUntil([| ai_living_count (AI.sq_hallway2_mid_turrets) <= 0 ], 1);
	
	game_save_no_timeout();
	print ("attempting to save game");
		
end	


function Hallway2_objcon()

	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_10)], 1);
	
	n_hallway2_objcon = 10;
	
	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_20)], 1);
	
	n_hallway2_objcon = 20;
	
	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_30)], 1);
	
	n_hallway2_objcon = 30;
	
	SleepUntil([| volume_test_players(VOLUMES.tv_hallway2_objcon_40)], 1);
	
	n_hallway2_objcon = 40;			

end


--  **************************************************************************************** --
--  ********************  			      GOAL 8 - CAVALIER              *********************** --
--  **************************************************************************************** --

 missionTrials.goal_cavalier = 
	{
	gotoVolume = VOLUMES.tv_goal_throne,
	next={"goal_throne"},
	zoneSet = ZONE_SETS.zn_highground,
	}


function missionTrials.goal_cavalier.Start() :void

	print("goal_cavalier_start");

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );
	
	CreateThread (WardenAirlockControl);
	
	game_save_no_timeout();	
	print("attempting to save...");
	object_create("dm_trials_bridge");

	ai_disable_jump_hint (HINTS.ramp_force_walk);

	kill_volume_disable (VOLUMES.kill_warden_turret1);
	kill_volume_disable (VOLUMES.kill_warden_turret2);
	kill_volume_disable (VOLUMES.kill_warden_turret3);
	kill_volume_disable (VOLUMES.kill_warden_turret4);			

	--	NARRATIVE CALL
	CreateThread(trials_bridge_load);

	SleepUntil([| volume_test_players(VOLUMES.tv_bridge_spawn_cav)], 1);

	CreateThread (clear_objective_blips);
	
	CreateThread (cavalier_fight_teleport);
		
	local show = pup_play_show ("vin_w3_trials_cav_resist_cortana");	
	
	SleepUntil ([| b_ramp_show_play == true], 1);
	
	pup_play_show ("vin_cav_resist_cortana_ramp");

	b_cav_fight = true;	
	
	CreateThread(audio_trials_thread_up_wardenfight_start);
	
	SleepUntil ([| not pup_is_playing (show)], 1);	
	
	print ("waiting for wardens to be alive");
	
	SleepUntil([|ai_living_count(AI.sg_bridge_cav) >= 2], 1);
	
	if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then

		CreateThread (PrisonBreak);	
		CreateThread (WardenDeathCheck);	
	
	end
	
	CreateThread (WardenCrateLogic);
	print ("Basic weapon crates refilling on a 60 second cooldown");

	print ("3 wardens alive, waiting for 2 to of them to die");
	
	sleep_s (0.1);

	SleepUntil([|ai_living_count(AI.sg_bridge_cav) <= 2], 1);
	
	print ("2 wardens alive, waiting for 1 to of them to die");	
	
	sleep_s (1);
	
	game_save_no_timeout();
	
	SleepUntil([|ai_living_count(AI.sg_bridge_cav) <= 1], 1);
	
	sleep_s (1);
	
	game_save_no_timeout();
	
	if ai_living_count (AI.sg_bridge_cav) == 1 then
	
		print ("only 1 warden left, turrets spawning!");
		
		--spawn turrets squads
		SlipSpaceSpawn (AI.sq_warden_turret1);
		SlipSpaceSpawn (AI.sq_warden_turret2);
		SlipSpaceSpawn (AI.sq_warden_turret3);
		SlipSpaceSpawn (AI.sq_warden_turret4);
	
	end
	
	sleep_s (1);
	
	print ("waiting for Wardens to be dead...");
	
	SleepUntil([|ai_living_count(AI.sg_bridge_cav) <= 0], 1);

	print ("warden's dead, killing turrets");
	
	ai_kill (AI.sq_warden_turret1);
	ai_kill (AI.sq_warden_turret2);
	ai_kill (AI.sq_warden_turret3);
	ai_kill (AI.sq_warden_turret4);
	
	kill_volume_enable (VOLUMES.kill_warden_turret1);
	kill_volume_enable (VOLUMES.kill_warden_turret2);
	kill_volume_enable (VOLUMES.kill_warden_turret3);
	kill_volume_enable (VOLUMES.kill_warden_turret4);								

	sleep_s (1);
	
	kill_volume_disable (VOLUMES.kill_warden_turret1);
	kill_volume_disable (VOLUMES.kill_warden_turret2);
	kill_volume_disable (VOLUMES.kill_warden_turret3);
	kill_volume_disable (VOLUMES.kill_warden_turret4);

	sleep_s (10);

	b_cav_fight = false;
	print ("b_cav_fight equals false");
		
	CreateThread (f_trials_obj_1_reminder);
	
	print ("b_bridge_unlocked = true");
	
	b_bridge_unlocked = true;

	CreateThread (set_objective_blip, "blip10");	
	
	sleep_s(3);
	
	CreateThread(audio_trials_thread_up_wardenfight_outro);
	
	game_save_no_timeout();

	print("throne active");

	sleep_s (1);

	ai_enable_jump_hint (HINTS.ramp_force_walk);

	SleepUntil ([| volume_test_players (VOLUMES.tv_hero_door_open)], 1);	

	CreateThread (HeroDoorOpen);

	object_create("cr_throne_lightbridge");

--	CreateThread (f_trials_chapter_4);	

end


function WardenAirlockControl()

	device_set_power (OBJECTS.dm_cavalier_airlock_door_2, 1);
	device_set_position (OBJECTS.dm_cavalier_airlock_door_2, 1);	
	
	SleepUntil ([| device_get_position (OBJECTS.dm_cavalier_airlock_door_2) >= 1 ], 1);	

	device_set_power (OBJECTS.dm_cavalier_airlock_door_2, 0);

	SleepUntil([| volume_test_players(VOLUMES.tv_bridge_spawn_cav)], 1);

	device_set_power (OBJECTS.dm_cavalier_airlock_door_2, 1);
	device_set_position (OBJECTS.dm_cavalier_airlock_door_2, 0);
	
	SleepUntil ([| device_get_position (OBJECTS.dm_cavalier_airlock_door_2) <= 0 ], 1);	

	device_set_power (OBJECTS.dm_cavalier_airlock_door_2, 0);

end


function HeroDoorOpen()

	device_set_power(OBJECTS.dm_throne_airlock_door_1, 1);
	device_set_position (OBJECTS.dm_throne_airlock_door_1, 1);
	
	SleepUntil ([| device_get_position (OBJECTS.dm_throne_airlock_door_1) >= 1 ], 1);
	
	device_set_power (OBJECTS.dm_throne_airlock_door_1, 0);

end


function FailsafeKillSpartans()

	for _,spartan in ipairs( spartans() ) do

		if volume_test_object (VOLUMES.tv_ramp_failsafe, spartan) then
		
			object_teleport (spartan, FLAGS.fl_failsafe_teleport);
			unit_kill (spartan);
			--damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartan);
			
		end

	end
 
end


function FailsafeKillSpartansBack()

	for _,spartan in ipairs( spartans() ) do

		if volume_test_object (VOLUMES.tv_ramp_failsafe_back, spartan) then
		
			object_teleport (spartan, FLAGS.fl_failsafe_teleport_back);
			unit_kill (spartan);
			--damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartan);
			
		end

	end
 
end


function WardenTurretLogic()

	print ("warden turret logic running");

	repeat
	
		sleep_s (90);
		print ("checking turrets");
		
		if ai_living_count (AI.sq_warden_turret1) <= 0 then
		
			print ("respawning turret 1");
			SlipSpaceSpawn (AI.sq_warden_turret1);

			b_bridge_turret_respawn = true;			--	For VO trigger, when a turret is respawned
			
		end	
			
		if ai_living_count (AI.sq_warden_turret2) <= 0 then

			print ("respawning turret 2");		
			SlipSpaceSpawn (AI.sq_warden_turret2);

			b_bridge_turret_respawn = true;			--	For VO trigger, when a turret is respawned
			
		end	
			
		if ai_living_count (AI.sq_warden_turret3) <= 0 then

			print ("respawning turret 3");		
			SlipSpaceSpawn (AI.sq_warden_turret3);

			b_bridge_turret_respawn = true;			--	For VO trigger, when a turret is respawned
			
		end	
			
		if ai_living_count (AI.sq_warden_turret4) <= 0 then

			print ("respawning turret 4");		
			SlipSpaceSpawn (AI.sq_warden_turret4);				

			b_bridge_turret_respawn = true;			--	For VO trigger, when a turret is respawned
		
		end
		
	until ai_living_count(AI.sg_bridge_cav) <= 0

end


function WardenCrateLogic()

	repeat

		print ("waiting 1 minute to replace crates");

		sleep_s (60);
		print ("replacing basic weapon crates");

		object_create_anew ("cr_warden_crate_1");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_1);	
		
		object_create_anew ("cr_warden_crate_2");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_2);	
		
		object_create_anew ("cr_warden_crate_3");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_3);	
					
		object_create_anew ("cr_warden_crate_4");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_4);	
			
		object_create_anew ("cr_warden_crate_5");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_5);	
			
		object_create_anew ("cr_warden_crate_6");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_6);	
			
		object_create_anew ("cr_warden_crate_7");	
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_7);	
		
		object_create_anew ("cr_warden_crate_8");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_8);		
			
		object_create_anew ("cr_warden_crate_9");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_9);	
			
		object_create_anew ("cr_warden_crate_10");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_10);	
			
		object_create_anew ("cr_warden_crate_11");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_11);	
			
		object_create_anew ("cr_warden_crate_12");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_12);	
			
		object_create_anew ("cr_warden_crate_13");
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_13);	
			
		object_create_anew ("cr_warden_crate_14");	
		CreateEffectGroup	 (EFFECTS.fx_warden_crate_14);	
			

	until ai_living_count(AI.sg_bridge_cav) <= 0

end


function cavalier_fight_teleport()

	print ("checking cavalier teleport");

	sleep_s (3);

	SleepUntil ([| device_get_position (OBJECTS.dm_cavalier_airlock_door_2) <= 0.3], 1);

	print ("door is closed, waiting to teleport players in");

	f_volume_teleport_all_not_inside (VOLUMES.tv_cavalier_teleport_check, FLAGS.fl_trials_cavalier_teleport);	
	
	
end


--  **************************************************************************************** --
--  ********************  			      GOAL 9 - THRONE                *********************** --
--  **************************************************************************************** --

 missionTrials.goal_throne = 
	{
	zoneSet = ZONE_SETS.zn_highground,
	}

function missionTrials.goal_throne.Start() :void 

	print("goal_throne_start");

	MusketeersOrderTurnAllOff();
	
	CreateThread (set_objective_blip, "blip11");
	
	--CreateThread(audio_trials_thread_up_throne_start);

	-- NARRATIVE CALL
	CreateThread(trials_throne_load);

	device_set_power (OBJECTS.dm_throne_airlock_door_2, 1);	

	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.chief );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.linda );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.kelly );
	player_set_profile( STARTING_PROFILES.pr_promethean, SPARTANS.fred );

	game_save_no_timeout();	
	print("attempting to save...");
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ending_start)], 1);
	
	CreateThread (audio_trials_thread_up_wardenfight_fade);
	
	sleep_s (1);

	EndMission(missionTrials);

end


function toggle_player_deathless (enable:boolean)
	
	if enable then
		object_cannot_die_except_kill_volumes (spartans(), true);
		object_set_shield ( spartans(), 1);
		object_set_shield_stun( spartans(), 1);
	else
		object_cannot_die_except_kill_volumes (spartans(), false);
	end
	
	for _,spartan in ipairs (spartans()) do
		object_cannot_die_except_kill_volumes (spartan, enable);
		object_set_shield ( spartans(), 1);
		object_set_shield_stun( spartans(), 1);
	end

end


function AR_refill()

	repeat

		object_create ("eq_ammo_refill_1");
		object_create ("eq_ammo_refill_2");
		object_create ("eq_ammo_refill_3");
		object_create ("eq_ammo_refill_4");	

		print ("creating crates");
		sleep_s (1);

		objects_attach( SPARTANS.chief, "", OBJECTS.eq_ammo_refill_1, "" );
		objects_attach( SPARTANS.linda, "", OBJECTS.eq_ammo_refill_2, "" );
		objects_attach( SPARTANS.kelly, "", OBJECTS.eq_ammo_refill_3, "" );
		objects_attach( SPARTANS.fred, "", OBJECTS.eq_ammo_refill_4, "" );

		sleep_s (0.1);
	
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.chief), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.linda), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.kelly), 1 );
		weapon_set_current_amount( unit_get_primary_weapon(SPARTANS.fred), 1 );			

		sleep_s (0.1);
	
		objects_detach (SPARTANS.chief, OBJECTS.eq_ammo_refill_1);
		objects_detach (SPARTANS.linda, OBJECTS.eq_ammo_refill_2);
		objects_detach (SPARTANS.kelly, OBJECTS.eq_ammo_refill_3);
		objects_detach (SPARTANS.fred, OBJECTS.eq_ammo_refill_4);		
						
		print ("ammo up!");
	
		sleep_s (1);
	
--	until b_super_player == false;
	
	until false;
	
	
end


function missionTrials.goal_throne.End() :void 
	
	EndMission(missionTrials);
end


function comp_end_fight_wound_cav()

	local count:number = list_count( AI.sg_final_cav_fight );
	
		for i = 1, count do
		
    local ai:object = list_get(AI.sg_final_cav_fight, i - 1);
    
     if object_get_health(ai) > 0 then
     
      	object_set_health( ai, 0.3 );
				object_set_shield( ai, 0 );
				
      end   
      
    end
    
end


function cs_final_cav_setup_1()

	print("cav1");
	ai_place_in_limbo(ai_current_actor);
	cs_phase_in(ai_current_actor);
	--object_set_scale(ai_current_actor, 1.8, 0);
	cavalier_switch_to_assassin_mode(ai_current_actor);

end


function cs_final_cav_setup_2()

	print("scav2");
	ai_place_in_limbo(ai_current_actor);
	cs_phase_in(ai_current_actor);
	--object_set_scale(ai_current_actor, 1.8, 0);
	cavalier_switch_to_assassin_mode(ai_current_actor);
	
end

function comp_end_fight_shield_stun()

print("waiting to stun");
	SleepUntil([| b_trials_shield_stun ],1)
	
	repeat
	
		object_set_shield( SPARTANS.locke, 0);
		object_set_shield( SPARTANS.buck, 0);
		object_set_shield( SPARTANS.tanaka, 0);
		object_set_shield( SPARTANS.vale, 0);
		object_set_shield_stun_infinite(SPARTANS.locke);
		object_set_shield_stun_infinite(SPARTANS.buck);
		object_set_shield_stun_infinite(SPARTANS.tanaka);
		object_set_shield_stun_infinite(SPARTANS.vale);
		Sleep(60);
	
	until(not b_trials_shield_stun );
		
		RunClientScript ("f_ending_effects");

		object_set_shield_stun(SPARTANS.locke, 0);
		object_set_shield_stun(SPARTANS.buck, 0);
		object_set_shield_stun(SPARTANS.tanaka, 0);
		object_set_shield_stun(SPARTANS.vale, 0);
		print("shield_stun over");
--		object_create("cortana_weapon_01");
		--CreateThread(audio_trials_thread_up_throne_combat);	
end


function comp_end_fight_profile()

	unit_add_equipment( SPARTANS.locke, STARTING_PROFILES.sp_cav_fight_end, true, true );
	
	if object_get_health(SPARTANS.buck) > 0 then
		unit_add_equipment( SPARTANS.buck, STARTING_PROFILES.sp_cav_fight_end, true, true );
	end
	
	if object_get_health(SPARTANS.tanaka) > 0 then
		unit_add_equipment( SPARTANS.tanaka, STARTING_PROFILES.sp_cav_fight_end, true, true );
	end
	
	if object_get_health(SPARTANS.vale) > 0 then
		unit_add_equipment( SPARTANS.vale, STARTING_PROFILES.sp_cav_fight_end, true, true );
	end
	
	b_super_player = true;
	print ("SUUUPER CHIEF TIIIIME");
	
end


function cortana_comp_exit()
	player_control_unlock_gaze(PLAYERS.player0);
	object_set_physics(PLAYERS.player0, true);
	player_disable_movement(false, PLAYERS.player0);
end


function scale_up_current_actor()

	object_set_scale (ai_current_actor, 1.5);

end


function spawn_cavalier(cavalier:ai)
	ai_place_in_limbo (cavalier);
	Sleep(1);
	cs_phase_in(cavalier);
	Sleep(1);
	--object_set_scale(ai_get_object(cavalier), 1.8, 0);
end


function cs_suicide()

	ai_kill( ai_current_actor );
	
end

function comp_end_fight_text_01()
--	ShowTempText ("Warden: You think it so easy to manipulate her, human.", 5, "red");							--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
print("null function"); 
end


function comp_end_fight_text_02()
--	ShowTempText ("Warden: She may not see it, but I do.", 5, "red");											--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
	b_trials_shield_stun = true;
end


function comp_end_fight_text_03()
--	ShowTempText ("Warden: Despite her protests, I will stand fast in your way.", 5, "red");					--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
print("null function");
end


function comp_end_fight_text_04()
print("null function");
--	ShowTempText ("Warden: You would not relent, and now you shall perish.", 5, "red");							--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
end


function comp_end_fight_text_05()
	ShowTempText ("All sound fades out...", 3, "blue");
end


function comp_end_fight_text_06()
print("null function");
--	ShowTempText ("Cortana: I am your Shield...", 3, "blue");													--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
end


function comp_end_fight_text_07()
print("null function");
--	ShowTempText ("Cortana: I am your Sword...", 3, "blue");													--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16
end


function comp_end_fight_text_08()
	
	RunClientScript("f_ending_effects_2");
	
--	ShowTempText ("Warden: AGGH!", 4, "red");																	--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16

	b_trials_shield_stun = false;	
	b_trials_cav_fight = true;
	
end


function comp_end_fight_text_09()
print("null function");
--	ShowTempText ("Warden: So you've chosen a side, Ancilla.", 4, "red");										--	COMMENTED - REPLACED BY VO CALL - guillaume 9/16

end


function cs_scale_cav()

	object_set_scale (ai_current_actor, 1.5);

end

function audio_cinematic_mute_trials()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--================================================
--HAX START
--================================================

function eleSweetHaxOn(elevator:object)
	game_safe_to_respawn( false);
	sleep_s(1);
	sweetHaxAttach(elevator, "m_player1", SPARTANS.locke);
	sweetHaxAttach(elevator, "m_player2", SPARTANS.vale);
	sweetHaxAttach(elevator, "m_player3", SPARTANS.tanaka);
	sweetHaxAttach(elevator, "m_player4", SPARTANS.buck);
	sleep_s(1);
end

function eleSweetHaxOff(elevator:object)
	SleepUntil ([| device_get_position (elevator) >= 1], 1);	
	sleep_s(1);
	sweetHaxDetach(elevator, SPARTANS.locke);
	sweetHaxDetach(elevator, SPARTANS.vale);
	sweetHaxDetach(elevator, SPARTANS.tanaka);
	sweetHaxDetach(elevator, SPARTANS.buck);
	sleep_s(1);
	game_safe_to_respawn(true);
end

function sweetHaxAttach(elevator:object, marker:string, spartan:object)
	if unit_get_health(spartan) > 0 then
		object_cannot_take_damage( spartan );
		object_set_physics( spartan, false );
		objects_attach( elevator, marker, spartan, "" );
	end
end

function sweetHaxDetach(elevator:object, spartan:object)
	if unit_get_health(spartan) > 0 then
		object_can_take_damage(spartan);
		objects_detach( elevator, spartan);
		object_set_physics( spartan, true );
		object_wake_physics( spartan );
	end
end

--================================================
--HAX END
--================================================

--## CLIENT

function remoteClient.f_ending_effects()

	effect_new(TAG('environments\solo\m40_invasion\fx\energy\cortana_emp.effect'), FLAGS.fl_trials_crumb_throne_start);
	
end


function remoteClient.f_ending_effects_2()

	effect_new(TAG('environments\solo\m40_invasion\fx\energy\cortana_emp.effect'), PLAYERS.player0);
	effect_new(TAG('environments\solo\m40_invasion\fx\energy\cortana_emp.effect'), PLAYERS.player1);
	effect_new(TAG('environments\solo\m40_invasion\fx\energy\cortana_emp.effect'), PLAYERS.player2);
	effect_new(TAG('environments\solo\m40_invasion\fx\energy\cortana_emp.effect'), PLAYERS.player3);
	
end

function remoteClient.elevatorDissolve( elevator:object)
	object_dissolve_from_marker( elevator, "phase_in", "audio_center" );	
end
