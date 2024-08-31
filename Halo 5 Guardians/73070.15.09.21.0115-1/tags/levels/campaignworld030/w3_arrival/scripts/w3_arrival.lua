--## SERVER
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 ARRIVAL*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

--usefull stuff dont delete.
--convert an object name to an object
--		local obj:object = OBJECTS[str_object_name];
---------------------------------------------------


global party_on_chief:boolean = false;
global b_dialogue_random:boolean = true;
global titan_vin_control:number = 0;
global monitor_vin_control:number = 0;
global debug_super_player:number = 0;
global debug_default_lights:number = 0;
global gaurdian_objcon:number = 0;
global grass_objcon:number = 0; 
global b_gaurdShake:boolean = false;
global b_guardActivate:boolean = false; 
global mesa_objcon:number = 0;
global crossing_objcon:number = 0
global cav_objcon:number = 0; 
global b_gateway_init:boolean = false;
global n_show_landing_elevator:number = 0;
global b_landingElevatorTimer:boolean = false;
global b_landingElevatorStage1:boolean = false;
global b_landingElevatorStage2:boolean = false;
global b_landingElevatorStage3:boolean = false;
global n_mon_gate:number = 0;
global n_mon_gate_01_landing:number = 1;
global n_mon_gate_02_tank:number = 2;
global n_mon_gate_03_cave:number = 3;
global n_mon_gate_04_bridge:number = 4;
global n_mon_gate_05_easter:number = 5;
global n_mon_gate_06_gateway:number = 6;
global b_player_past_tank:boolean = false;
global b_sassy:boolean = false;
global b_mon_at_free:boolean =	true;
global b_mon_at_landing:boolean =	false;
global b_mon_at_tank:boolean =	false;
global b_mon_at_cave:boolean =	false;
global b_mon_at_bridge:boolean =	false;
global b_mon_at_gateway:boolean =	false;
global b_mon_at_easter:boolean =	false;
global b_cheevo_show_over:boolean = false;
global is_blink:boolean = false;
global vIndexGhost:number = 26;
global vIndexWraith:number = 29;
global vIndexScorpion:number = 19;
global vIndexWarthog:number = 18;
global b_gateway_zone_locked:boolean = false; 
global  sp_follow:object = nil;	
global showLandingGuardIdle:number = 0;
global showGuardIdle:number = 0;
global showGuardSlide:number = 0;
global showGuardRun:number = 0;
global showGuardJump:number = 0;
global b_disableNavData:boolean = false;

function startup.InitArrival()
	print ("This is before editor mode");
	--Sleep (1);
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_arrival);
		fade_out(0,0,0,0);
		player_enable_input(false);
		StartArrival();
	else
		print ("In Editor Mode call StartArrival to begin mission");
	end
end

function tag_test()
	print ("tag is updating");
end

global missionArrival:table=
	{
		name = "w3_arrival",
		--profiles = {STARTING_PROFILES.sp_arvl_locke, STARTING_PROFILES.sp_arvl_vale, STARTING_PROFILES.sp_arvl_tanaka, STARTING_PROFILES.sp_arvl_buck},
		points = POINTS.ps_cp_01_gaurdian,
		startGoals = {"goal_arrival_gaurdian"},
		collectibles = {
										{objectName = "w3_arrival_collectible_01", collectibleName = "w3_arrival_collectible_01"},
										{objectName = "w3_arrival_collectible_02", collectibleName = "w3_arrival_collectible_02"},
										{objectName = "w3_arrival_collectible_03", collectibleName = "w3_arrival_collectible_03"},
										{objectName = "w3_arrival_collectible_04", collectibleName = "w3_arrival_collectible_04"},
										{objectName = "w3_arrival_collectible_05", collectibleName = "w3_arrival_collectible_05"},
										{objectName = "w3_arrival_collectible_06", collectibleName = "w3_arrival_collectible_06"},
										{objectName = "w3_arrival_collectible_07", collectibleName = "w3_arrival_collectible_07"},
										{objectName = "w3_arrival_collectible_08", collectibleName = "w3_arrival_collectible_08"},
										{objectName = "w3_arrival_collectible_09", collectibleName = "w3_arrival_collectible_09"},
										{objectName = "w3_arrival_collectible_10", collectibleName = "w3_arrival_collectible_10"},
										{objectName = "w3_arrival_skull", collectibleName = "collectible_skull_tilt"},
									 },
	}


function missionArrival.Start()
	print ("start Arrival");
	--change later
	if current_zone_set() ~= ZONE_SETS.zn_titan_fall then
		switch_zone_set (ZONE_SETS.zn_titan_fall);
	end
	--Sys_TeleportPlayers(missionArrival);
	Sys_ForcePlayerProfile(missionArrival);

	--	NARRATIVE CALL
	CreateThread(arrival_narrative_startup);
end

function missionArrival.End()
	print ("Arrival end");
	print ("play arrival cinematic");
	fade_out(0,0,0,60);
	Sleep(61);
	prepare_to_switch_to_zone_set(ZONE_SETS.cin170_arrival);
	Sleep(2);
	switch_zone_set(ZONE_SETS.cin170_arrival);
	Sleep(2);
	LoomNextCampaignMission();
	CinematicPlay ("cin_170_arrival", true);
	sys_LoadTrials();
end
	
function StartArrival()	
	StartMission(missionArrival);
end

function f_w3_arrival_mission_complete()	
	if not editor_mode() then
		StartScenario ("levels\\campaignworld030\\w3_hub\\w3_hub");
	else
		print ("in editor not loading the next level");
	end
end

--========================================================
--Blinks
--========================================================
function BlinkGaurd():void
	is_blink = true;
	ai_erase_all();
	CreateThread(audio_arrival_stopallmusic);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
	MusketeersOrderTurnAllOn();
	CreateThread(setRespawnProfile);
	GoalBlink( missionArrival, "goal_arrival_gaurdian");
end

function BlinkLanding():void
	is_blink = true;
	b_gaurdShake = false;
	b_guardian_start_shaking = true;
	scripting_revive_enabled = true;
	ai_erase_all();
	CreateThread(audio_arrival_stopallmusic);
	MusketeersOrderTurnAllOn();
	CreateThread(setRespawnProfile);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
	GoalBlink( missionArrival, "goal_arrival_landing", FLAGS.fl_blink_02_landing);
end
	
function BlinkRoad():void
	is_blink = true;
	b_gaurdShake = false;
	b_guardian_start_shaking = true;
	scripting_revive_enabled = true;
	ai_erase_all();
	CreateThread(audio_arrival_stopallmusic);
	CreateThread(setRespawnProfile);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
	MusketeersOrderTurnAllOn();
	GoalBlink(missionArrival, "goal_arrival_road", FLAGS.fl_blink_03_road);
end

function BlinkTunnel():void
	is_blink = true;
	b_gaurdShake = false;
	b_guardian_start_shaking = true;
	scripting_revive_enabled = true;
	ai_erase_all();
	CreateThread(audio_arrival_stopallmusic);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
	MusketeersOrderTurnAllOn();
	CreateThread(setRespawnProfile);
	GoalBlink(missionArrival, "goal_arrival_cave", FLAGS.fl_blink_04_cave);	
end

function BlinkGrasslands():void
	is_blink = true;
	b_gaurdShake = false;
	b_guardian_start_shaking = true;
	scripting_revive_enabled = true;
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(audio_arrival_stopallmusic);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
	MusketeersOrderTurnAllOn();
	GoalBlink(missionArrival, "goal_arrival_grasslands", FLAGS.fl_blink_05_grassland);	
end

function BlinkGateway():void
	is_blink = true;
	b_gaurdShake = false;
	b_guardian_start_shaking = true;
	scripting_revive_enabled = true;
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(audio_arrival_stopallmusic);
	MusketeersOrderTurnAllOn();
	GoalBlink(missionArrival, "goal_arrival_cavalier", FLAGS.fl_blink_06_gateway);
end

function setRespawnProfile()
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.locke );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.buck );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.vale );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.tanaka );
end

--ai_vehicle_reserve_seat( object, string, boolean )
--===============================================
--TITAN RUN
--===============================================


missionArrival.goal_arrival_gaurdian = 
	{
	gotoVolume = VOLUMES.tv_goal_02_landing,
	zoneSet = ZONE_SETS.zn_titan_fall,
	next={"goal_arrival_landing"},
	}

function missionArrival.goal_arrival_gaurdian.Start() :void		
	print("goal_arrival_gaurdian");

	RunClientScript("guardPinBird");
	CinematicPlay ("cin_165_genesis");
	player_enable_input(false);	
	CreateThread(flockGuardian);
	CreateThread(KillVolumeDerez);
	--CreateThread(vin_vtol, "vin_w3_arrival_guardian_run_vtolevent", VOLUMES.tv_vin_vtol01, AI.sq_gaurdian_vtol01.spawnpoint01, AI.sq_gaurdian_vtol01.spawnpoint02);
	--CreateThread(vin_vtol, "vin_w3_arrival_guardian_run_vtolevent_02", VOLUMES.tv_vin_vtol02);
	CreateThread(set_objective_blip, 1);
					--	NARRATIVE CALL
	CreateThread(arrival_guardian_start);
	--sleep_s(1);
	showGuardIdle =	pup_play_show("vin_w3_arrival_guardian_run_guardian");
	showGuardSlide = pup_play_show("vin_w3_arrival_guardian_run_intro");
	CreateThread(gr_refill);
	SleepUntil([|not pup_is_playing(showGuardSlide)], 1);
	MusketeersOrderTurnAllOff();
	--ai_set_objective( AI.musketeers, "obj_musk_guard" );
	player_enable_input(true);
	game_save_no_timeout();
	showGuardRun =	pup_play_show("vin_w3_arrival_guardian_run");	
	
	--	NARRATIVE CALL
	CreateThread(arrival_guardian_run_start);
	CreateThread(audio_arrival_thread_up_guardianrun_start);
	CreateThread(f_chapter_title, TITLES.ct_arrival_1);
	CreateThread(ObjectiveShow, TITLES.obj_arrival_1);	
	CreateThread(gaurdian_encounter_control);
	CreateThread(guardNoRevive);
	CreateThread(fallingDebris)
	CreateThread(vinVtolFlyby01);
	CreateThread(vinVtolFlyby02);
	CreateThread(gaurdian_shake_loop);
	CreateThread(setRespawnProfile);
		--I couldn't hav a perfect timing with just a sleep(), so I've changed it with a boolean.			Guillaume
		--
	CreateThread(disableSilhouetteAndNavDataLoop);
	SleepUntil([| b_guardian_start_shaking ], 1);
	RunClientScript("guardUnPinBird");
	CreateThread(progressionPulse);

	sleep_s(1);
	b_gaurdShake = true;

	CreateThread(trainJump);
	--	NARRATIVE CALL
	CreateThread(arrival_guardian_transformation);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_fall)], 1);
	game_save_no_timeout();
	CreateThread(guardianOutroDamage);
	b_gaurdShake = false;
	pup_stop_show(showGuardRun);
	CreateThread(guardRunPulse,3);
	sleep_s(1);
	b_disableNavData = false;
	if checkPlayerAliveAny() then
		showGuardJump = pup_play_show("vin_w3_arrival_guardian_run_outro");
		CreateThread(ZoneSwapLanding);
	end
	--	NARRATIVE CALL
	b_arrival_guardian_surprise = true;
	MusketeersOrderTurnAllOn();
	ai_erase(AI.sg_gaurdian);
	garbage_collect_now();
	flock_delete( "flock_gaurdian_run_bird01" );
	flock_delete( "flock_gaurdian_run_bird02" );
	RunClientScript("flockFlipOFF");
	CreateThread(audio_arrival_thread_up_guardianrun_end);
end

function disableSilhouetteAndNavDataLoop()
	b_disableNavData = true;
	repeat
		Sleep(5);
		stepSilhouettes = false;
		stitchNavData = false;
	until not b_disableNavData
	stepSilhouettes = true;
	stitchNavData = true;
end

function guardianOutroDamage()
	object_cannot_take_damage( spartans() );
	
	SleepUntil([|pup_is_playing(showGuardJump)], 1);
	print("for_respawn");
	object_cannot_take_damage( spartans() );
	
	SleepUntil([|not pup_is_playing(showGuardJump)], 1);
	
	object_can_take_damage( spartans() );
end


function ZoneSwapLanding()
	sleep_s(1);
	SleepUntil([|not pup_is_playing(showGuardJump)], 1);
	switch_zone_set(ZONE_SETS.zn_landing); 
end

function zone_PrepAndSwap(zone:zone_set)
	prepare_to_switch_to_zone_set( zone );
	sleep_s(10);
	SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
	Sleep(1);
	switch_zone_set( zone );
end

function gaurdian_encounter_control()
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_10)], 1);
	gaurdian_objcon = 10;	

	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_20)], 1);
	gaurdian_objcon = 20;
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_01, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_02, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_03, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_04, 0.2);
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_30)], 1);
	gaurdian_objcon = 30;

	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_40)], 1);
	gaurdian_objcon = 40;
	
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_05, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_06, 0.2);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_50)], 1);
	gaurdian_objcon = 50;

	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_07, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_08, 0.1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_60)], 1);
	gaurdian_objcon = 60;
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_01);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_02);

	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_09, 0.1);
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_10, 0.2);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_objcon_70)], 1);
	gaurdian_objcon = 70;
	CreateThread(SpawnAndDamage, AI.sq_gaurdian_for_11, 0.1);
	
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_03);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_05);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_04);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_06);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_07);
	CreateThread(guardPhaseOut, AI.sq_gaurdian_for_08);
end

function guardPhaseOut(squad:ai)
	sleep_s(2);
	local squadList = ai_actors(squad);	
	for _, actor in pairs(squadList) do 
			sleep_s(random_range( 0.75, 1.75 ));
			CreateThread(PhaseOutActor, actor);
	end
end

function PhaseOutActor(actor:object)
	RunClientScript("PhaseOutEffect", actor);
	sleep_s(4);
	ai_erase(object_get_ai(actor));
end

--we need to remove rotate/move to point
function AnimateObjectThread( o: object, l: location, t1: number, t2: number ): void
	CreateThread(object_rotate_to_point, o,t1,l);
	object_move_to_point(o,t2,l);
end

function guardNoRevive()
	scripting_revive_enabled = false;
	SleepUntil([|b_gaurdShake], 1);
	sleep_s(1);
	SleepUntil([|not b_gaurdShake], 1);
	scripting_revive_enabled = true;
end

function gr_refill()
	local t_ammo:table=
		{
			OBJECT_NAMES.gr_ammo01,
    	OBJECT_NAMES.gr_ammo02,
    	OBJECT_NAMES.gr_ammo03,
     	OBJECT_NAMES.gr_ammo04,
  	};
	local n:number = 1;  
	SleepUntil([|b_gaurdShake], 1);
	if b_gaurdShake then
		repeat
		 	n = 1;
			for _,player in ipairs(players()) do
				object_create (t_ammo[n]);
				objects_attach( player, "", t_ammo[n], "" );	
				sleep_s(0.1);
				weapon_set_current_amount( unit_get_primary_weapon(unit_get_player(player)), 1 );
				sleep_s(0.1);
				objects_detach(player, t_ammo[n])
				n = n + 1
			end
		  sleep_s (15);
	  until not b_gaurdShake;
  end
end

function progressionPulse()
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_pulse_activate01)], 1, seconds_to_frames(120));
	guardRunPulse(0);
	SleepUntil([|volume_test_players(VOLUMES.tv_gaurdian_pulse_activate02)], 1, seconds_to_frames(120));
	guardRunPulse(1);
	sleep_s(120);
	if b_gaurdShake then
		guardRunPulse(2);
	end
end

--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast_arrival.sound'), nil, 1);

function pulseKill(pulse_count:number)
	CreateThread(audio_guardianrun_pulseimpact);
	for _, spartan in ipairs(spartans()) do
		print(spartan);
		print("spartando");
		if volume_test_object(VOLUMES.tv_gaurdian_pulse01, spartan) then
			print("boom");
			RunClientScript("guardPulseDeath", spartan);
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartan);
		elseif pulse_count >= 1 and volume_test_object(VOLUMES.tv_gaurdian_pulse02, spartan) then
			print("boom2");
			RunClientScript("guardPulseDeath", spartan);
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartan);
		elseif pulse_count == 2 and b_gaurdShake then
			print("boom3");
			RunClientScript("guardPulseDeath", spartan);
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartan);
		else
			RunClientScript("guardPulseImpact", spartan);
			object_set_shield(spartan,  (object_get_shield(spartan) * 0.40));
			object_set_health(spartan,  (object_get_health(spartan) * 0.75));
		end
	end
end

function guardRunPulse(pulse_count:number)
	print("AUDIO - PULSE WARNING");
	CreateThread(audio_guardianrun_deathcharge);
	sleep_s(2);
	CreateEffectGroup(EFFECTS.guard_shockwave03);
	CreateEffectGroup(EFFECTS.guard_shockwave02);
	CreateEffectGroup(EFFECTS.guard_shockwave01);
	CreateThread(rumble_shake_large, 2);
	CreateEffectGroup(EFFECTS.guard_shockwave_impact01);
	if b_gaurdShake then
		CreateThread(pulseKill, pulse_count);
	end
	sleep_s(1);
	KillEffectGroup(EFFECTS.guard_shockwave01);	
	KillEffectGroup(EFFECTS.guard_shockwave02);	
	KillEffectGroup(EFFECTS.guard_shockwave03);	
	KillEffectGroup(EFFECTS.guard_shockwave_impact01);
end

function pulseHealthSet()
	for _, spartan in ipairs(spartans()) do
		object_set_shield(spartan,  (object_get_shield(spartan) * 0.40));
		object_set_health(spartan,  (object_get_health(spartan) * 0.75));
	end
end

function checkGuardkillVolumes()
	return volume_test_players(VOLUMES.playerkill_guardian_01) or 
				 volume_test_players(VOLUMES.playerkill_guardian_02) or
				 volume_test_players(VOLUMES.playerkill_guardian_03) or
				 volume_test_players(VOLUMES.playerkill_guardian_04) or
				 volume_test_players(VOLUMES.playerkill_guardian_05) or
				 volume_test_players(VOLUMES.playerkill_guardian_06) or
				 volume_test_players(VOLUMES.playerkill_guardian_07) or
				 volume_test_players(VOLUMES.playerkill_guardian_08) or
				 volume_test_players(VOLUMES.playerkill_guardian_09)
end

function KillVolumeDerez()
	repeat
		print("check");
		SleepUntil([| checkGuardkillVolumes() or not b_gaurdShake], 1);
		if b_gaurdShake then
			print("kill");
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_01));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_02));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_03));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_04));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_05));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_06));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_07));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_08));
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_guardian_09));
		end
		sleep_s(1);
	until not b_gaurdShake
end

function killSpartans()
	damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartans());
end

function trainJump()
	print("train_sprint");
	for _,player in ipairs(players()) do
		CreateThread(showJumpTraining, player);
	end
end

function showJumpTraining(p_player:object)
	TutorialShowStartDelayed(unit_get_player(p_player), "training_jump", "training_guard_jump_01");
	sleep_s(5);
	TutorialStopAll(); 
end

function fallingDebris()
	sleep_s(1.5);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_01);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_02);
	sleep_s(0.5);
	CreateThread(CreateAndThrow, OBJECT_NAMES.v_guardfall_01);
	sleep_s(1);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_02);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_03);
	sleep_s(1);
	CreateThread(CreateAndThrow, OBJECT_NAMES.v_guardfall_02);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_04);
	CreateThread(CreateAndThrow, OBJECT_NAMES.cr_guardfall_05);
end

function CreateAndThrow(obj:object_name)
	object_create_anew(obj);
	object_set_velocity( ObjectFromName(obj), 35, 0, -7 );
	sleep_s(8);
	object_destroy(ObjectFromName(obj));
end

function SpawnAndDamage(guy:ai, damage:number)
	SlipSpaceSpawn(guy);
	SleepUntil([|ai_living_count(guy) > 0], 1);
	sleep_s(0.1);
	local squadList:object_list = ai_actors(guy);	
	local listIndex:number = list_count(squadList);
	if listIndex > 0 then
		repeat
			listIndex = listIndex - 1;
			object_set_health( list_get(squadList, listIndex), damage );
			--object_set_scale( list_get(squadList, listIndex), 1.1, 0);
		until listIndex <= 0;
	end
	print("damage");
	
	

end

function flockGuardian()
	flock_create("flock_gaurdian_run_bird01");
	flock_create("flock_gaurdian_run_bird02");
	sleep_s(3);
	RunClientScript("flockFlipAll");
end
	
function cs_gaurd_shoot()
	local set_current:object = spartans()[1];
	local set_new:object = spartans()[1];
	repeat
		set_new = spartans()[random_range(1,#spartans())];
		if set_current ~= set_new then
			set_current = set_new;
			--ai_magically_see_object( ai_current_actor, set_new );
			cs_shoot( true, set_new);
		end
		sleep_s(1);
	until(ai_living_count(ai_current_actor) <= 0);
end

function cs_gaurd_vtol1()
	local set_current:object = spartans()[1];
	local set_new:object = spartans()[1];
	repeat
		set_new = spartans()[random_range(1,#spartans())];
		if set_current ~= set_new then
			set_current = set_new;
			--ai_magically_see_object( ai_current_actor, set_new );
			cs_shoot( true, set_new);
		end
		sleep_s(random_range(1,2));
	until(not b_vtolShootValid01);
end

global b_vtolShootValid01:boolean = true;
global b_vtolShootValid02:boolean = true;

function cs_gaurd_vtol2()
	local set_current:object = spartans()[1];
	local set_new:object = spartans()[1];
	repeat
	
		set_new = spartans()[random_range(1,#spartans())];
		if set_current ~= set_new then
			set_current = set_new;
			--ai_magically_see_object( ai_current_actor, set_new );
			cs_shoot( true, set_new);
		end
		sleep_s(random_range(1,2));
	until(not b_vtolShootValid02);
end

function vinVtolFlyby01()
	sleep_s(random_range( 3, 5 ));
	repeat
		print("playshow3");
		ai_place(AI.sq_gaurdian_vtol01);
		sleep_s(0.1);
		b_vtolShootValid01 = true;
		local state = { 
			vtol01 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol01.spawnpoint01),
			vtol02 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol01.spawnpoint02),
			vtol01pilot = AI.sq_gaurdian_vtol01.spawnpoint01,
			vtol02pilot = AI.sq_gaurdian_vtol01.spawnpoint02,
									};
	
		print("playshow");
		local show:number = pup_play_show("vin_w3_arrival_guardian_run_vtolevent", state);
		sleep_s(5);
		SleepUntil([| not pup_is_playing(show) ], 1);
		print("playshow2");
		sleep_s(1);
	until not b_gaurdShake
end

function vinVtolFlyby02()
	sleep_s(random_range( 1, 3 ));
	repeat
	ai_place(AI.sq_gaurdian_vtol02);
	sleep_s(0.1);
	b_vtolShootValid02 = true;
	local state = { 
		vtol05 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol02.spawnpoint01),
		vtol06 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol02.spawnpoint02),
		vtol05pilot = AI.sq_gaurdian_vtol02.spawnpoint01,
		vtol06pilot = AI.sq_gaurdian_vtol02.spawnpoint02,
								};								

		print("playshow");
		local show:number = pup_play_show("vin_w3_arrival_guardian_run_vtolevent_02", state);
		SleepUntil([| not pup_is_playing(show) ], 1);
		sleep_s(1);
	until not b_gaurdShake
end

function gaurdian_shake_loop()
	repeat	
		CreateThread(rumble_shake_small, 3);
		sleep_s( random_range( 7, 10) );
	until b_guardian_start_shaking

	repeat	
		CreateThread(rumble_shake_large, 3);
		sleep_s( random_range( 6, 9) );
	until not b_gaurdShake 
end

--===============================================
--Monitor_Intro
--===============================================
function InitGateway()
	if not b_gateway_init then
		b_gateway_init = true;
		pup_play_show("comp_arrival_gateway");
	end
end

missionArrival.goal_arrival_landing = 
	{
	gotoVolume = VOLUMES.tv_goal_03_road,
	zoneSet = ZONE_SETS.zn_road,
	next={"goal_arrival_road"},
	}

function missionArrival.goal_arrival_landing.Start() :void		
	if is_blink then
		is_blink = false;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		b_disableNavData = false;
	end
	print("goal_arrival_monitor");
	b_disableNavData = false;
	CreateThread(set_objective_blip, 2);
--	CreateThread(sassy_spark_init);
	--	NARRATIVE CALL
	CreateThread(arrival_landing_load);
	CreateThread(InitGateway);
	CreateThread(flock_landingCreate);
	showLandingGuardIdle = pup_play_show("comp_guardian_landing");
	
	CreateThread(audio_arrival_thread_up_landing_start);
	CreateThread(sassy_spark_init);
	hud_show_navpoints_major_biped(false);
	sleep_s(3);
	pup_play_show("vin_w3_landing_bird");
	CreateThread(landingObjectiveShow)
	device_set_power(OBJECTS.dm_landing_door_01, 1);
	SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_01_landing)], 1)
	CreateThread(clearObjectiveBlips);
	n_mon_gate = n_mon_gate_01_landing;
	hud_show_navpoints_major_biped(true);
	n_show_landing_elevator = pup_play_show("comp_monitor_elevator");
	SleepUntil([| volume_test_players(VOLUMES.tv_landing_elevator_approach)], 1)
	b_landingElevatorStage1 = true;
	sleep_s(2);
	CreateThread(landingElevatorTimer);
	ai_enable_jump_hint( HINTS.jump_elevator_on );
	ai_disable_jump_hint( HINTS.jump_elevator_off );
	CreateThread(landingElevatorMuskPos);
	SleepUntil([| elevatorTestSpartans() or b_landingElevatorTimer], 1);
	b_landingElevatorStage2 = true;
	--	NARRATIVE CALL
	b_landing_elevator_starts = true;
	CreateThread(audio_arrival_thread_up_landing_end);

	sleep_s(3);

	ai_enable_jump_hint( HINTS.jump_elevator_off );
	ai_disable_jump_hint( HINTS.jump_elevator_on );
	sleep_s(6);
	CreateThread(set_objective_blip, 3);
	--b_mon_at_landing = true;		
	CreateThread(flock_landingStop);
end

function landingObjectiveShow()
	SleepUntil([|NarrativeQueue.HasConversationFinished(W3HubArrival_Arrival__LANDING__Start_3) ], 1);
	CreateThread(ObjectiveShow, TITLES.obj_arrival_2);	
end

function elevatorTestSpartans():boolean
	return volume_test_object(VOLUMES.tv_musketeer_elevator, SPARTANS.locke) and
				 volume_test_object(VOLUMES.tv_musketeer_elevator, SPARTANS.vale)  and
				 volume_test_object(VOLUMES.tv_musketeer_elevator, SPARTANS.buck)  and
				 volume_test_object(VOLUMES.tv_musketeer_elevator, SPARTANS.tanaka)
end

function landingElevatorMuskPos()
	if not IsPlayer(SPARTANS.vale) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_ele_vale, 1);
	end
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_ele_buck, 1);
	end
	if not IsPlayer(SPARTANS.tanaka) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_ele_tanaka, 1);
	end
end

function landingElevatorTimer()
	SleepUntil([| volume_test_players(VOLUMES.tv_landing_elevator)], 1);
	sleep_s(7);
	print("go");
	b_landingElevatorTimer = true;
end

function monitor_controlInteract(device:object, p_player:object)
	print("switchflip");
	local show:number = composer_play_show("collectible", {scanner = p_player});
end

function flock_landingCreate()
	flock_create( "flock_landing_bird" );
	flock_create( "flock_landing_vtol" );
	flock_create( "birdflock_landing_01" );
	flock_create( "birdflock_landing_03" );
	flock_create( "birdflock_landing_04" );
	flock_create( "birdflock_landing_05" );
end

function flock_landingStop()
	flock_stop( "flock_landing_bird" );
	flock_stop( "flock_landing_vtol" );
	flock_stop( "birdflock_landing_01" );
	flock_stop( "birdflock_landing_03" );
	flock_stop( "birdflock_landing_04" );
	flock_stop( "birdflock_landing_05" );
end

function flock_landingDelete()
	flock_delete( "flock_landing_bird" );
	flock_delete( "flock_landing_vtol" );
	flock_delete( "birdflock_landing_01" );
	flock_delete( "birdflock_landing_03" );
	flock_delete( "birdflock_landing_04" );
	flock_delete( "birdflock_landing_05" );
end

--object_dissolve_from_marker( OBJECTS.cr_landing_wardens_staff, "hard_kill", "weapon_stow_anchor" );
--===============================================
--Tank_Run
--===============================================

missionArrival.goal_arrival_road = 
	{
	gotoVolume = VOLUMES.tv_goal_04_cave,
	zoneSet = ZONE_SETS.zn_road,
	next={"goal_arrival_cave"},
	}

function missionArrival.goal_arrival_road.Start() :void		
	if is_blink then
		is_blink = false;
		b_disableNavData = false;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		--object_destroy_folder("mod_gaurdian_run");
	end
	ai_disable_jump_hint( HINTS.jh_cave_door01 );
	ai_disable_jump_hint( HINTS.jh_cave_door02 );
	ai_disable_jump_hint( HINTS.jh_cave_door03 );
	
	CreateThread(InitGateway);
	b_mon_at_landing = true;
	CreateThread(regroup_elevator);
	CreateThread(garbage_loop);
	--	NARRATIVE CALL
	CreateThread(arrival_road_load);
	CreateThread(tankObjectiveShow);
	CreateThread(createTank);
	SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_02_tank)] , 1);

	sleep_s(0.25);
	CreateThread(sassy_spark_init);
		
	--	NARRATIVE		-		Wait for the monitor to finish her VO and get on the radio before opening the door.
	SleepUntil([| b_monitor_is_on_radio], 1);
	
	CreateThread(aiDrivePlayer);
	CreateThread(tank_reserve);
	CreateThread(cheevoRollingThunder);
	CreateThread(cheevoTankStillBeatsEverything);
	sleep_s(1);

	
	CreateThread(NarrativeRoadSync);	
	sleep_s(2);
	b_mon_at_tank = true;
	--sassy_pull(POINTS.ps_mon_gate_02_tank.p01);	
	SleepUntil([| volume_test_players(VOLUMES.tv_road_encounter_spawn)], 1);
	game_save_no_timeout();
	b_player_past_tank = true;
	CreateThread(set_objective_blip, 4);
	
	ai_place(AI.sq_road_cov_02);
	ai_place(AI.sq_road_cov_phantom_02);
	ai_place(AI.sq_road_cov_phantom_01);
	CreateThread(road_knight);
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_10) ], 1);
	mesa_objcon = 10;
	game_save_no_timeout();
	garbage_collect_now();
	sleep_s(1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_20) ], 1);	
	mesa_objcon = 20;
	game_save_no_timeout();
	garbage_collect_now();
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p02, nil, 3);
	--	NARRATIVE CALL
	CreateThread(arrival_road_guardian_arrival);
	
	CreateThread(arrivalRodeGuardian);
	sleep_s(2);
	ai_place(AI.sg_road_cov_w1);	
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sg_road_cov_w1), true); 

	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_30) or ai_living_count(AI.sg_road) < 7 ], 1);
	mesa_objcon = 30;
	game_save_no_timeout();
	garbage_collect_now();
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p03, nil, 7);
	SlipSpaceSpawn(AI.sq_mesa_for_1_3);
	ai_place(AI.sq_mesa_cov_2_2);
	
	SlipSpaceSpawn(AI.sq_mesa_for_1_1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_40) or ai_living_count(AI.sg_road) < 6 ], 1);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p03, POINTS.MusketeerDrive.p04, 10);
	mesa_objcon = 40;
	game_save_no_timeout();
	garbage_collect_now();	
	
	ai_place(AI.sq_mesa_for_2_2);
	--ai_place(AI.sq_mesa_cov_2_3);
	SlipSpaceSpawn(AI.sq_mesa_for_2_1);
	SlipSpaceSpawn(AI.sq_mesa_for_2_6);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_50) ], 1);	
	mesa_objcon = 50;
	game_save_no_timeout();
	garbage_collect_now();
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p05, POINTS.MusketeerDrive.p05, 15);
	SlipSpaceSpawn(AI.sq_mesa_for_2_7);
	SlipSpaceSpawn(AI.sq_mesa_for_2_4);
	sleep_s(3);
	SlipSpaceSpawn(AI.sq_mesa_for_2_5);
	SlipSpaceSpawn(AI.sq_mesa_for_2_3);
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_60) or ai_living_count(AI.sg_road) < 7 ], 1);
	mesa_objcon = 60;
	
	game_save_no_timeout();
	garbage_collect_now();
	
	SlipSpaceSpawn(AI.sq_mesa_for_3_1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mon_gate_03_cave)  ], 1);
	game_save_no_timeout();
	b_dialogue_random = false;
	n_mon_gate = n_mon_gate_03_cave;
	object_create_folder("mod_cave_vehicle");
	sleep_s(7);
	b_mon_at_cave	= true;
	sleep_s(7);
	device_set_power(OBJECTS.dm_cave_door_01 ,1);
	device_set_position(OBJECTS.dm_cave_door_01,1);
	CreateThread(caveDoorOpenHintOn);
	CreateThread(set_objective_blip, 5);
end
function caveDoorOpenHintOn()
	SleepUntil([|device_get_position(OBJECTS.dm_cave_door_01) >= 0.75 ], 1);
	print("open");
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p06, POINTS.MusketeerDrive.p06, 7);
	ai_enable_jump_hint( HINTS.jh_cave_door01 );
	ai_enable_jump_hint( HINTS.jh_cave_door02 );
	ai_enable_jump_hint( HINTS.jh_cave_door03 );
end

function createTank()
	RunClientScript("guardPinTank");
	object_create_anew("v_road_tank_01");
	object_hide(OBJECTS.v_road_tank_01, true);
	SleepUntil([| b_monitor_is_on_radio ], 1);
	sleep_s(2);
	device_set_power(OBJECTS.dm_road_door_01, 1);
	device_set_position(OBJECTS.dm_road_door_01, 1);
	SleepUntil([|device_get_position(OBJECTS.dm_road_door_01) > 0.3 ], 1);
	n_mon_gate = n_mon_gate_02_tank;
	sleep_s(1);	
	ai_play_slip_space_effect_at_lua_location(OBJECTS.v_road_tank_01);
	sleep_s(3.5);
	object_hide(OBJECTS.v_road_tank_01, false);
	RunClientScript("phaseTank");
	object_wake_physics(OBJECTS.v_road_tank_01);
	sleep_s(1);	
	RunClientScript("guardUnPinTank");
end

function arrivalRodeGuardian()
	pup_play_show("vin_w3_arrival_rode_guardian");
	RunClientScript ("arvlShakeSlipSpace");
	sleep_s(2);
	ai_place(AI.sq_road_cov_phantom_03);
	sleep_s(3);
	pup_play_show("cov_ships_crashing_guard1");
end

function monEleCrushKill()
	damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.tv_mon_ele_kill_01));
end

function tankObjectiveShow()
	SleepUntil([|NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__in_front_of_the_door_3) ], 1);
	CreateThread(ObjectiveShow, TITLES.obj_arrival_3);
end
	
function road_knight()
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_bridge_spawn) ], 1);
	SlipSpaceSpawn(AI.sq_road_for_02);
end

global pointLocPlayer:point = POINTS.MusketeerDrive.p01;
global pointLocSolo:point = POINTS.MusketeerDrive.p01;
global pointLocRange:number = 7;

function aiDrivePlayer()
	print("DRIVING");
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p01, nil, 7);
	repeat		
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			if (MusketeerIsDrivingPlayer(obj)) and pointLocPlayer ~= nil then
				MusketeerDestSetPoint(obj, pointLocPlayer, pointLocRange);
				
			elseif unit_in_vehicle(obj) and not player_in_vehicle( unit_get_vehicle(obj) and pointLocSolo ~= nil ) then
				MusketeerDestSetPoint(obj, pointLocSolo, pointLocRange);
				if pointLocSolo == POINTS.MusketeerDrive.p06 then
					MusketeerDestSetCombatRange(obj, 5);
				end
			else
				print("CLEAR");
				MusketeerDestClear(obj);
	 		end
		end
		print("aiDrivePlayer -- wait");
		sleep_s(random_range( 7, 14 ));
	until pointLocPlayer == nil  and pointLocPlayer == nil; 
	CreateThread(setMuskMountOrderClear);
	CreateThread(setMuskDestClear);
end

function aiDriveUpdateDestination(drivePointPlayer:point, drivePoint:point, distance:number)
	pointLocPlayer = drivePointPlayer;
	pointLocSolo = drivePoint;
	pointLocRange = distance;
end



function tank_reserve()
	ai_vehicle_reserve_seat( OBJECTS.v_road_tank_01, "scorpion_d", true );
	SleepUntil([|volume_test_players(VOLUMES.tv_mesa_objcon_10) or playerInVehicleType(vIndexScorpion)], 1);
	ai_vehicle_reserve_seat( OBJECTS.v_road_tank_01, "scorpion_d", false );	
end
  
function playerInVehicleType(v_index:number):boolean
	for _,player in ipairs(players()) do
		if	unit_in_vehicle_type(unit_get_player(player), v_index) then
		return true
		end
	end
end


function NarrativeRoadSync()
		--	NARRATIVE CALL		
		b_narrative_chapter_road = true;
	f_chapter_title(TITLES.ct_arrival_3);
end


function arrivalSkull()
	object_create("w3_arrival_skull");
end

function regroup_elevator()
	sleep_s(3);
	regroup_and_warning(  VOLUMES.tv_teleport_road, FLAGS.fl_road_regroup , true);
	sleep_s(5);
	object_destroy_folder("mod_landing");
	CreateThread(fx_landingKillAll);
end

function regroup_and_warning( trig:volume, location:flag, with_vehicle:boolean)
	if with_vehicle then
		volume_teleport_players_not_inside_with_vehicles( trig, location );
	else
		volume_teleport_players_not_inside( trig, location );
	end
end

function cs_road_phantom_01()
	ai_place(AI.sq_road_cov_01);
	Sleep(1);
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_01.spawnpoint01 ), "body", 1000 );
	vehicle_load_magic(unit_get_vehicle( AI.sq_road_cov_phantom_01.spawnpoint01 ), "phantom_sc01", unit_get_vehicle(AI.sq_road_cov_01.spawnpoint01) );
	cs_fly_to(POINTS.ps_road_phantom_01.p01);
	cs_fly_to(POINTS.ps_road_phantom_01.p02);
	sleep_s(1);
	vehicle_unload( unit_get_vehicle(AI.sq_road_cov_phantom_01), "phantom_sc01" );
	sleep_s(0.5);
	vehicle_unload( unit_get_vehicle(AI.sq_road_cov_phantom_01), "phantom_sc02" );
	sleep_s(7);
	cs_fly_to(POINTS.ps_road_phantom_01.p02);
	cs_fly_to(POINTS.ps_road_phantom_01.p03);
	cs_fly_to(POINTS.ps_road_phantom_01.p04);
	cs_fly_to(POINTS.ps_road_phantom_01.p05);
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_01.spawnpoint01 ), "body", 10000 );
	sleep_s(2);
	ai_erase(AI.sq_road_cov_phantom_01);
end

function cs_road_phantom_02()
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_02.spawnpoint01 ), "body", 500 );
	cs_fly_to(POINTS.ps_road_phantom_02.p01);
	cs_fly_to(POINTS.ps_road_phantom_02.p02);
	cs_fly_to(POINTS.ps_road_phantom_02.p03);
	cs_fly_to(POINTS.ps_road_phantom_02.p04);
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_02.spawnpoint01 ), "body", 10000 );
	sleep_s(2);
	ai_erase(AI.sq_road_cov_phantom_02);
end

function cs_road_phantom_03()
	ai_place(AI.sq_mesa_cov_2_3);
	Sleep(1);
	vehicle_load_magic(unit_get_vehicle( AI.sq_road_cov_phantom_03.spawnpoint01 ), "phantom_sc01", unit_get_vehicle(AI.sq_mesa_cov_2_3.spawnpoint01) );
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_03.spawnpoint01 ), "body", 500 );
	cs_fly_to(POINTS.ps_road_phantom_03.p01);
	sleep_s(1);
	vehicle_unload( unit_get_vehicle(AI.sq_road_cov_phantom_03.spawnpoint01), "phantom_sc01" );
	sleep_s(6);
	cs_fly_to(POINTS.ps_road_phantom_03.p02);
	cs_fly_to(POINTS.ps_road_phantom_03.p03);
	object_set_scale(unit_get_vehicle( AI.sq_road_cov_phantom_03), 0.1, 2);	
	object_set_scale(unit_get_vehicle( AI.sq_road_cov_phantom_03), 0.1, 2);
	object_damage_damage_section( unit_get_vehicle( AI.sq_road_cov_phantom_03.spawnpoint01 ), "body", 10000 );
	sleep_s(2);
	ai_erase(AI.sq_road_cov_phantom_03);
end


--===============================================
--Tank_cave
--===============================================
	
missionArrival.goal_arrival_cave = 
	{
	gotoVolume = VOLUMES.tv_goal_05_crossing,
	zoneSet = ZONE_SETS.zn_road,
	next={"goal_arrival_crossing"},
	}


function missionArrival.goal_arrival_cave.Start() :void		
	print("goal_arrival_cave");
	CreateThread(audio_arrival_thread_up_take_cave);
	if is_blink then
		is_blink = false;
		b_disableNavData = false;
		n_mon_gate = n_mon_gate_03_cave;
		b_mon_at_cave	= true;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		vehicle_load_magic(OBJECTS.v_cave_tank_01, "", spartans());
		CreateThread(zone_PrepAndSwap, ZONE_SETS.zn_crossing);
			CreateThread(aiDrivePlayer);
	end
 	object_create_folder("mod_crossing");
	object_create_folder("mod_crossing_vehicle");
	object_create_folder("mod_crossing_weapons");
	CreateThread(InitGateway);
	
	--	NARRATIVE CALL
	CreateThread(arrival_cave_load);
	CreateThread(cave_encounter);
	CreateThread(sassy_spark_init);
	CreateThread(cave_regroup);	
	CreateThread(cave_driveLocationUpdate);
end

function cave_driveLocationUpdate()
	sleep_s(3);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p07, nil, 3);
end

function cave_encounter()
	SleepUntil([|volume_test_players(VOLUMES.tv_cave_encounter_spawn) ], 1);
	game_save_no_timeout();
	ai_place(AI.sg_crossing_cross_cov);
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_crossing_cross_cov04), true); 
	ai_prefer_target_team( AI.sg_crossing_cross_cov, TEAM.player );
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_crossing_cross_cov05), true); 
	b_dialogue_random = true;
end


function cave_regroup()
	sleep_s(2)
	device_set_power(OBJECTS.dm_cave_door_01, 0);
	print("waiting to pull");
	game_save_no_timeout();
	SleepUntil([| device_get_position(OBJECTS.dm_cave_door_01) <= 0] , 1);
	print("pull Players Crossing");
	CreateThread(regroup_and_warning,  VOLUMES.tv_teleport_cave, FLAGS.fl_cave_regroup , true);	
	Sleep(5);
	prepare_to_switch_to_zone_set(ZONE_SETS.zn_crossing);
	sleep_s(3);
	SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
	ai_erase(AI.sg_road);
	object_destroy_folder("mod_road_vehicle");
	object_destroy_folder("mod_mesa");
	CreateThread(flock_landingDelete);
	composer_stop_show( showLandingGuardIdle );
	switch_zone_set( ZONE_SETS.zn_crossing );
	
end

--===============================================
--Tank_Crossing
--===============================================

missionArrival.goal_arrival_crossing = 
	{
	gotoVolume = VOLUMES.tv_goal_07_grasslands,
	zoneSet = ZONE_SETS.zn_crossing,
	next={"goal_arrival_grasslands"},
	}

function missionArrival.goal_arrival_crossing.Start() :void		
	print("goal_arrival_crossing");
	if is_blink then
		is_blink = false;
		b_disableNavData = false;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		CreateThread(garbage_loop);
	end
	CreateThread(InitGateway);
	kill_volume_disable( VOLUMES.playerkill_cross_grass_lightbridge);
		--	NARRATIVE CALL
	CreateThread(arrival_crossing_load);
	
	CreateThread(sassy_spark_init);
	CreateThread(crossingGuardianShow);
	ai_disable_jump_hint( HINTS.jh_lightbridge_foot );
	ai_disable_jump_hint( HINTS.jh_lightbridge_v );
	object_destroy(OBJECTS.dm_lightbridge);
	RunClientScript ("arvlLightbridge_off");

	ai_place(AI.sq_crossing_cross_cov06);
	SlipSpaceAndPreferTeam(AI.sq_crossing_cross_for05, TEAM.player);
	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_10)], 1);
	SlipSpaceSpawn(AI.sq_crossing_cross_for01);
	SlipSpaceSpawn(AI.sq_crossing_cross_for03);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p08, POINTS.MusketeerDrive.p09, 12);
	crossing_objcon = 10;
	game_save_no_timeout();
	garbage_collect_now();

	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_20) or ai_living_count(AI.sg_crossing_all) < 3], 1);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p10, POINTS.MusketeerDrive.p10, 10);
	crossing_objcon = 20;
	game_save_no_timeout();
	garbage_collect_now();
	ai_place(AI.sq_crossing_lake_phantom);
	ai_place(AI.sq_crossing_lake_cov02);

	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_30)], 1);
	
	crossing_objcon = 30;
	CreateThread(set_objective_blip, 6);
	ai_place(AI.sq_crossing_lake_cov03);
	SlipSpaceSpawn(AI.sq_crossing_lake_for07);
	SlipSpaceSpawn(AI.sq_crossing_cross_for02);
	

	SlipSpaceSpawn(AI.sq_crossing_lake_for02);
	SlipSpaceSpawn(AI.sq_crossing_lake_for04);
	SlipSpaceSpawn(AI.sq_crossing_lake_for05);
	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_40)], 1);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p11, nil, 12);
	crossing_objcon = 40;
	ai_place(AI.sq_crossing_lake_cov04);
	ai_place(AI.sq_crossing_lake_for08);

	SlipSpaceSpawn(AI.sq_crossing_lake_for03);
	SlipSpaceSpawn(AI.sq_crossing_lake_for06);
	--ai_prefer_target_team( AI.sq_crossing_lake_for08, TEAM.player);
	ai_prefer_target_team( AI.sq_crossing_lake_cov04, TEAM.player);
	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_50) or ai_living_count(AI.sg_crossing_all) < 7], 1);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p12, nil, 12);
	crossing_objcon = 50;
	ai_place(AI.sq_crossing_bridge_phantom);
	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_60) or ai_living_count(AI.sg_crossing_all) < 6], 1);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p13, POINTS.MusketeerDrive.p13, 10);
	--SlipSpaceSpawn(AI.sq_crossing_bridge_for01);
	SlipSpaceAndPreferTeam(AI.sq_crossing_bridge_for02, TEAM.player);
	crossing_objcon = 60;
	SleepUntil([| volume_test_players(VOLUMES.tv_crossing_objcon_70)], 1);
	crossing_objcon = 70;
		--	NARRATIVE CALL
	CreateThread(arrival_bridge_load);
	
	CreateThread(sassy_spark_init);

	sleep_s(1);
		--gamesave
	game_save_no_timeout();
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mon_gate_04_bridge)], 1);
	object_create_folder("mod_grasslands");
	object_cannot_take_damage(OBJECTS.sc_crossing_pelican_02);
	CreateThread(clearObjectiveBlips);

	n_mon_gate = n_mon_gate_04_bridge
			--	NARRATIVE CALL
		CreateThread(arrival_bridge);
	b_dialogue_random = false;	

	b_mon_at_bridge = true;
	--sassy_pull(POINTS.ps_mon_gate_04_bridge.p01);
	sleep_s(2);
	CreateThread(bridge_spawn);
end

function crossingGuardianShow()
	pup_play_show("vin_w3_arrival_crossing_guardian");
	RunClientScript ("arvlShakeSlipSpace");
	sleep_s(6);
	pup_play_show("vin_banshees_out_of_control_01");
	pup_play_show("vin_banshees_out_of_control_02");
	pup_play_show("vin_cov_ships_out_of_control");
end

function garbage_loop()
	repeat
		sleep_s(8);
		garbage_collect_now();
	until crossing_objcon >= 70
end

function cs_banshee_health()
	object_set_shield( unit_get_vehicle( ai_get_unit(ai_current_actor) ), 0 );
	object_set_shield_stun_infinite( unit_get_vehicle( ai_get_unit(ai_current_actor) ) );
end

function cs_cross_split_phantom()
	f_load_phantom_left(AI.sq_crossing_lake_phantom, AI.sq_crossing_lake_cov01.spawnpoint01,AI.sq_crossing_lake_cov01.spawnpoint02, AI.sq_crossing_lake_cov01.spawnpoint03, AI.sq_crossing_lake_cov01.spawnpoint04, true);
	
	cs_fly_to(POINTS.ps_crossing_split_phantom.p01);
	SlipSpaceSpawn(AI.sq_crossing_lake_for01);
	unit_open( unit_get_vehicle( AI.sq_crossing_lake_phantom ) );
	sleep_s(2);
	vehicle_unload( unit_get_vehicle( AI.sq_crossing_lake_phantom ), "phantom_p_lb" );
	vehicle_unload( unit_get_vehicle( AI.sq_crossing_lake_phantom ), "phantom_p_lf" );
	vehicle_unload( unit_get_vehicle( AI.sq_crossing_lake_phantom ), "phantom_p_ml_f" );
	vehicle_unload( unit_get_vehicle( AI.sq_crossing_lake_phantom ), "phantom_p_ml_b" );
	sleep_s(4);
	unit_close( unit_get_vehicle( AI.sq_crossing_lake_phantom ) );
	--f_unload_drop_ship( AI.sq_crossing_lake_phantom, "left");
	sleep_s(7);
	cs_fly_to(POINTS.ps_crossing_split_phantom.p02);
	cs_fly_to(POINTS.ps_crossing_split_phantom.p03);
	object_damage_damage_section( unit_get_vehicle( AI.sq_crossing_lake_phantom.spawnpoint01 ), "body", 10000 );
	sleep_s(1);
	ai_erase(AI.sq_crossing_lake_phantom);
end


function cs_cross_bridge_phantom()
	ai_place(AI.sq_crossing_bridge_cov02);
	Sleep(1);
	vehicle_load_magic(unit_get_vehicle( AI.sq_crossing_bridge_phantom.spawnpoint01), "phantom_mc01", unit_get_vehicle(AI.sq_crossing_bridge_cov02.spawnpoint01) );
	--f_load_drop_ship( AI.sq_crossing_bridge_phantom, AI.sq_crossing_bridge_cov02, true, false, "left" );
	cs_fly_to(POINTS.ps_crossing_bridge_phantom.p04);
	cs_fly_to(POINTS.ps_crossing_bridge_phantom.p01);
	sleep_s(1);
	vehicle_unload( unit_get_vehicle(AI.sq_crossing_bridge_phantom.spawnpoint01), "phantom_mc01" );
	--f_unload_drop_ship( AI.sq_crossing_bridge_phantom, "left");
	--ai_prefer_target_team( AI.sq_crossing_bridge_cov02, TEAM.player );
	sleep_s(4);
	cs_fly_to(POINTS.ps_crossing_bridge_phantom.p02);
	cs_fly_to(POINTS.ps_crossing_bridge_phantom.p03);
	object_damage_damage_section( unit_get_vehicle( AI.sq_crossing_bridge_phantom.spawnpoint01 ), "body", 10000 );
end

function SlipSpaceAndPreferTeam(squad:ai, target:team )
	CreateThread(SpawnAndPrefer, squad, target);
end

function SpawnAndPrefer(squad:ai, target:team )
	SlipSpaceSpawn(squad);	
	SleepUntil([| ai_living_count(squad) > 0 ], 1);
	ai_prefer_target_team( squad, target );
end

global easteregg:boolean = false;
global monitor_charmed:number = 0;

function ee_monitorCharm()
	if game_difficulty_get() == DIFFICULTY.legendary then
		object_create("bi_ee");
		object_create("ee_attach_01");
		object_create("ee_attach_02");
		object_create("ee_attach_03");
		object_create("ee_attach_04");
		CreateThread(bagcheck, VOLUMES.tv_ee_check01, OBJECTS.ee_attach_01, 117, PLAYERS.player0);
		CreateThread(bagcheck, VOLUMES.tv_ee_check01, OBJECTS.ee_attach_02, 117, PLAYERS.player1);
		CreateThread(bagcheck, VOLUMES.tv_ee_check01, OBJECTS.ee_attach_03, 117, PLAYERS.player2);
		CreateThread(bagcheck, VOLUMES.tv_ee_check01, OBJECTS.ee_attach_04, 117, PLAYERS.player3);
	end
end

function bagcheck(trig:volume, obj:object, bagsTotal:number, p_player:player)
	print("baginit");
	local n_currentBagCount:number = 0;
	
	repeat
		SleepUntil([| volume_test_objects(trig, p_player )], 1);
		Sleep(1);
		
		objects_attach( p_player, "target_head", obj, "" );
		
		repeat
			SleepUntil([|volume_test_objects(trig, obj) or not volume_test_object(trig, p_player)], 1);
			print("BAG1");
			if not volume_test_object(trig, p_player) then 
				n_currentBagCount = 0;
			else
				SleepUntil([| not volume_test_objects(trig, obj) or not volume_test_object(trig, p_player)], 1);
				print("BAG2");
				if not volume_test_object(trig, p_player) then
					n_currentBagCount = 0;
					print(n_currentBagCount);
				else
					n_currentBagCount = n_currentBagCount + 1;
					print(n_currentBagCount);
				end
			end	
		until not volume_test_objects(trig, p_player) or bagsTotal == n_currentBagCount 	
		
		objects_detach( p_player, obj);
		
		if bagsTotal == n_currentBagCount then
			easteregg = true;
		end
		
	until easteregg or cav_objcon == 20
	sleep_s(1);
	object_destroy(obj);
	
	if easteregg then
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		monitor_charmed = 1;
	end
end

function bridge_spawn()
	sleep_s(6);
	SleepUntil([|volume_test_players_lookat(VOLUMES.tv_lookat_lightbridge, 16, 16 )], 1);
	sleep_s(7);
	object_create("dm_lightbridge");
	RunClientScript ("arvlLightbridge_on");
	ai_enable_jump_hint( HINTS.jh_lightbridge_foot );
	ai_enable_jump_hint( HINTS.jh_lightbridge_v );
		--	NARRATIVE CALL
		CreateThread(arrival_bridge_created);	
		b_dialogue_random = true;
	CreateThread(set_objective_blip, 7);
	aiDriveUpdateDestination(POINTS.MusketeerDrive.p14, POINTS.MusketeerDrive.p14, 10);
	CreateThread(audio_arrival_lightbridge_activate);

end


--===============================================
--Grasslands
--===============================================

missionArrival.goal_arrival_grasslands = 
	{
	gotoVolume = VOLUMES.tv_goal_08_cavalier,
	zoneSet = ZONE_SETS.zn_crossing,
	next={"goal_arrival_cavalier"},
	}

function missionArrival.goal_arrival_grasslands.Start() :void		
	print("goal_arrival_grasslands");
	if is_blink then
		is_blink = false;
		b_disableNavData = false;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		object_create_folder("mod_grasslands");
		object_cannot_take_damage(OBJECTS.sc_crossing_pelican_02);
	end
	--CreateThread(CrossingGrasslandsRegroupControl);
	CreateThread(InitGateway);
	CreateThread(gateway_regroup);	
	CreateThread(audio_arrival_thread_up_crossing_end);
	CreateThread(ee_monitorCharm);
	n_mon_gate = n_mon_gate_05_easter;
	CreateThread(sassy_spark_init);
	sleep_s(1);
	CreateThread(clearObjectiveBlips);
	CreateThread(placeCavGrass);
	--	NARRATIVE CALL
	CreateThread(arrival_grasslands_load);
	sleep_s(4);
	CreateThread(audio_arrival_thread_up_grasslands);
	ObjectSetSpartanTrackingEnabled(ai_get_object (AI.sq_grasslands_for_01), true);	
	CreateThread(cavGrasslandsKill);
	--ai_place(AI.sq_gateway_cov_phantom_01);
	CreateThread(grassObjcon);
end

function placeCavGrass()
	SlipSpaceSpawn(AI.sq_grasslands_for_01);
	sleep_s(3);
	if checkSpartanInVehicleAny() or object_get_health(OBJECTS.v_road_tank_01) > 0 then
		ai_place_with_slip_space(AI.sq_grasslands_for_04);
		SlipSpaceSpawn(AI.sq_grasslands_for_05);
	else
		sleep_s(3);
		ai_place_with_slip_space(AI.sq_grasslands_for_06);
		SlipSpaceSpawn(AI.sq_grasslands_for_07);
	end
end

function grassObjcon()
	SleepUntil([| ai_living_count(AI.sg_grasslands ) <= 1 ], 1);
	grass_objcon = 10;
end
	
function cavGrasslandsKill()
	SleepUntil([| ai_living_count(AI.sq_grasslands_for_01 ) <= 0 ], 1);
	grass_objcon = 20;
	CreateThread(set_objective_blip, 8);
	aiDriveUpdateDestination(nil, nil, 0);
	sleep_s(3);
	CreateThread(killTurret, AI.sq_grasslands_for_04);
	CreateThread(killTurret, AI.sq_grasslands_for_05);
	sleep_s(1);
	ai_erase(AI.sg_grasslands);

end

function gateway_regroup()
	SleepUntil([| volume_test_players(VOLUMES.tv_teleport_gateway_regroup)], 1);
	RunClientScript ("arvlLightbridge_off");
	ai_disable_jump_hint( HINTS.jh_lightbridge_foot );
	ai_disable_jump_hint( HINTS.jh_lightbridge_v );
	object_destroy(OBJECTS.dm_lightbridge);
	CreateThread(regroup_and_warning,  VOLUMES.tv_teleport_gateway, FLAGS.fl_gateway_regroup , true);
	object_destroy_folder("mod_crossing_weapons");
	object_destroy_folder("mod_crossing");
	b_gateway_zone_locked = true;
	kill_volume_enable( VOLUMES.playerkill_cross_grass_lightbridge);
	--CreateThread(set_objective_blip, 8);
end

function CrossingGrasslandsRegroupControl()
	repeat
		SleepUntil([|volume_test_players(VOLUMES.tv_begin_gateway_teleport)], 1);
			if volume_test_players(VOLUMES.tv_begin_gateway_teleport) and volume_test_players(VOLUMES.tv_begin_crossing_teleport) then
				volume_teleport_players_inside( VOLUMES.tv_begin_crossing_teleport, FLAGS.fl_crossing_grasslands_reqroup )
			end
			volume_teleport_players_not_inside( VOLUMES.tv_grasslands_regroup, FLAGS.fl_crossing_grasslands_reqroup )
			sleep_s(1);
		SleepUntil([|volume_test_players(VOLUMES.tv_begin_crossing_teleport)], 1);
			if volume_test_players(VOLUMES.tv_begin_gateway_teleport) and volume_test_players(VOLUMES.tv_begin_crossing_teleport) then
				volume_teleport_players_inside( VOLUMES.tv_begin_gateway_teleport, FLAGS.fl_crossing_grasslands_reqroup )
			end
				volume_teleport_players_not_inside( VOLUMES.tv_grasslands_regroup, FLAGS.fl_crossing_grasslands_reqroup )
			sleep_s(1);
	until b_gateway_zone_locked
end

--===============================================
--Arrival_Cavalier
--===============================================
--teleport players accross bridge and to grasslands and shut off bridge
missionArrival.goal_arrival_cavalier = 
	{
	zoneSet = ZONE_SETS.zn_gateway,
	}

function cavEscape()
	if ai_living_count(AI.sq_grasslands_for_01) <= 0 then 
		pup_play_show("comp_cav_escape");
	end
end

function missionArrival.goal_arrival_cavalier.Start() :void		
	print("goal_arrival_cavalier");
	if is_blink then
		is_blink = false;
		b_disableNavData = false;
		pup_stop_show(showGuardIdle);
		pup_stop_show(showGuardRun);
		object_create_folder("mod_grasslands");
		object_cannot_take_damage(OBJECTS.sc_crossing_pelican_02);
		--object_create_folder("mod_gateway");
		--object_destroy_folder("mod_gaurdian_run");
		n_mon_gate = n_mon_gate_05_easter;
	end
	CreateThread(set_objective_blip, 9);
	CreateThread(cavSaveLoop);
	CreateThread(InitGateway);
			--	NARRATIVE CALL
	CreateThread(arrival_cavalier_load);
	CreateThread(sassy_spark_init);
	b_dialogue_random = false;
	CreateThread(cavEscape);
	ai_erase(AI.sg_crossing_bridge);
	CreateThread(setMuskGateStart);
	CreateThread(audio_arrival_thread_up_gateway_start);
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_start)], 1);
	CreateThread(cavSpawnControl);
	sleep_s(2);
	CreateThread(ObjectiveShow, TITLES.obj_arrival_5);
	n_mon_gate = n_mon_gate_06_gateway;
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_objcon_10)], 1);
	if cav_objcon < 10 then
		cav_objcon = 10;
	end
	game_save_no_timeout();
	if monitor_charmed > 0 then
		monitor_charmed = 10;
	end
	CreateThread(cavFallback_1);
	CreateThread(cavSniperKillerKnight);
	CreateThread(cavDoorSniperKillerKnight);
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_objcon_20)], 1);	
	if cav_objcon < 20 then
		cav_objcon = 20;
	end
	game_save_no_timeout();
	SlipSpaceSpawn(AI.sq_gw_for_left_01);
	SlipSpaceSpawn(AI.sq_gw_for_right_01);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_objcon_30)], 1);
	if cav_objcon < 30 then
		cav_objcon = 30;
	end
	game_save_no_timeout();

	sleep_s(7);
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_objcon_40) or cavLivingCount() < 2 ], 1);
	if cav_objcon < 40 then
		cav_objcon = 40;
	end	
	CreateThread(cavKillAll);	
	SleepUntil([| ai_living_count(AI.sg_gateway_all) <= 6 or cavLivingCount() < 2 ], 1);
	game_save_no_timeout();
	if cav_objcon < 50 then
		cav_objcon = 50;
	end
	
	SleepUntil([| ai_living_count(AI.sg_gateway_all) <= 0 ], 1);	
	game_save_no_timeout();
	CreateThread(audio_arrival_thread_up_gateway_end);
	sleep_s(2);	
	CreateThread(set_objective_blip, 9);
	cav_objcon = 55;
	SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_06_gateway) ], 1);
	game_save_no_timeout();
	b_mon_at_gateway = true;
	if cav_objcon < 60 then
		cav_objcon = 60;
	end
	--sassy_pull(POINTS.ps_mon_gate_06_gateway.p01);
	CreateThread(ObjectiveShow, TITLES.obj_arrival_6);	
	SleepUntil([| volume_test_players(VOLUMES.tv_goal_09_gateway) ], 1);
	PushForwardVOStandBy();											-- For Narrative. Ends the nudges.
	--device_set_power(OBJECTS.dm_gateway_door, 1);
	sleep_s(0.5);
	CreateThread(audio_arrival_thread_up_mission_end);
	EndMission(missionArrival);
end

function cavSaveLoop()
	repeat
		game_save_no_timeout();
		sleep_s(40);
	until cav_objcon >= 55
end

function cavFallback_1()
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_objcon_15)], 1, seconds_to_frames(15));
	if cav_objcon < 15 then
		cav_objcon = 15;
	end 
end

function cavSniperKillerKnight()
	sleep_s(random_range(3, 5));
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_overwatch) and not volume_test_players(VOLUMES.tv_cav_gateway_all) or cavLivingCount() <= 1], 1);
	sleep_s(random_range(7, 10));
	if cavLivingCount() > 1 then
		SlipSpaceSpawn(AI.sq_grasslands_for_02);
		sleep_s(random_range(5, 7));
		SleepUntil([| ai_living_count(AI.sq_grasslands_for_02) < 1 ], 1);
		sleep_s(random_range(12, 17));
	end
	
	repeat
		if cavLivingCount() > 1 then
			if volume_test_players(VOLUMES.tv_cavalier_overwatch) and not volume_test_players(VOLUMES.tv_cav_gateway_all)	then
				SlipSpaceSpawn(AI.sq_grasslands_for_03);
				SleepUntil([| ai_living_count(AI.sq_grasslands_for_03) < 1 or cavLivingCount() <= 1], 1);
				sleep_s(random_range(17, 27));
			end
			sleep_s(random_range(7, 17));
		end
	until cavLivingCount() <= 1
		if volume_test_players(VOLUMES.tv_cavalier_overwatch) and not volume_test_players(VOLUMES.tv_cav_gateway_all) then
			sleep_s(random_range(5, 7));
			SlipSpaceSpawn(AI.sq_grasslands_for_02);
		end
end

function cavDoorSniperKillerKnight()
	sleep_s(random_range(7, 14));
	SleepUntil([| volume_test_players(VOLUMES.tv_cav_door_sniper) and not volume_test_players(VOLUMES.tv_cav_gateway_all) or cavLivingCount() <= 1], 1);
	sleep_s(random_range(4, 7));
	if cavLivingCount() > 1 then
		SlipSpaceSpawn(AI.sq_gw_for_backup_02);
		sleep_s(random_range(5, 7));
		SleepUntil([| ai_living_count(AI.sq_gw_for_backup_02) < 1 ], 1);
		sleep_s(random_range(8, 17));
	end
	
	repeat
		if cavLivingCount() > 1 then
			if volume_test_players(VOLUMES.tv_cav_door_sniper) and not volume_test_players(VOLUMES.tv_cav_gateway_all) then
				SlipSpaceSpawn(AI.sq_gw_for_backup_01);
				SleepUntil([| ai_living_count(AI.sq_gw_for_backup_01) < 1 or cavLivingCount() <= 1], 1);
				sleep_s(random_range(17, 24));
			end
			sleep_s(random_range(10, 17));
		end
	until cavLivingCount() <= 1

end
function cavKillAll()
	SleepUntil([| cavLivingCount() <= 0], 1);
	local squadList:object_list = ai_actors(AI.sg_gateway_all)	
	local listIndex:number = list_count(squadList);
	if listIndex > 0 then
		repeat
			listIndex = listIndex - 1;
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), list_get(squadList, listIndex));			
		until listIndex <= 0;
	end
	
	CreateThread(killTurret, AI.sq_gw_for_center_06);
	CreateThread(killTurret, AI.sq_gw_for_center_07);
	sleep_s(1);
	ai_kill(AI.sg_gateway_all);
	sleep_s(2);
	ai_erase(AI.sg_gateway_all);
end

function killTurret(turret:ai)
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
		damage_objects_effect( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), object_get_parent(ai_get_object(turret)));
end


--object_damage_damage_section( object_get_parent(ai_get_object(AI.sq_gw_for_center_06)), "body", 100000 );
--object_damage_damage_section( unit_get_vehicle(AI.sq_gw_for_center_06), "weakpoint", 100000 );
function cavSpawnControl()
	CreateThread(clearObjectiveBlips);
	SlipSpaceSpawn(AI.sq_gw_for_cav_01);
	SlipSpaceSpawn(AI.sq_gw_for_cav_02);
	--SlipSpaceSpawn(AI.sq_gw_for_front_01);
	SlipSpaceSpawn(AI.sq_gw_for_front_02);
	SlipSpaceSpawn(AI.sq_gw_for_front_03);
	sleep_s(4);
	ObjectSetSpartanTrackingEnabled(ai_get_object (AI.sq_gw_for_cav_01), true);
	ObjectSetSpartanTrackingEnabled(ai_get_object (AI.sq_gw_for_cav_02), true);
	SleepUntil([| ai_living_count(AI.sg_gateway_all) < 4 or cav_objcon >= 10], 1);
	if cav_objcon < 10 then
		cav_objcon = 10;
	end
	ai_place_with_slip_space(AI.sq_gw_for_front_04);
	ai_place_with_slip_space(AI.sq_gw_for_front_05);
	sleep_s(7);
	
	SleepUntil([| ai_living_count(AI.sg_gateway_all) < 5 or cav_objcon >= 20 ], 1);	
	if cav_objcon < 20 then
		cav_objcon = 20;
	end
	SlipSpaceSpawn(AI.sq_gw_for_front_06);
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_gateway_all) < 5 or cav_objcon >= 30 ], 1);	
	if cav_objcon < 30 then
		cav_objcon = 30;
	end
	CreateThread(reinforce_cav, AI.sq_gw_for_center_04, AI.sq_gw_for_center_02, AI.sq_gw_for_cav_01);
	CreateThread(reinforce_cav, AI.sq_gw_for_center_05, AI.sq_gw_for_center_03, AI.sq_gw_for_cav_02);

	SlipSpaceSpawn(AI.sq_gw_for_center_01);
	SlipSpaceSpawn(AI.sq_gw_for_center_02);
	SlipSpaceSpawn(AI.sq_gw_for_center_03);
	
		--turrets init
	CreateThread(reinforce_turrets);
	CreateThread(reinforce_bishops);
	
end

function cavLivingCount():number
	return ( ai_living_count(AI.sq_gw_for_cav_01) + ai_living_count(AI.sq_gw_for_cav_02) );
end

function wagonLivingCount():number
	return ( ai_living_count(AI.sq_gw_for_center_02) + ai_living_count(AI.sq_gw_for_center_03) );
end

function reinforce_turrets()
	SleepUntil([|cavLivingCount() < 2 ], 1);
	SlipSpaceSpawn(AI.sq_gw_for_center_06);
	SlipSpaceSpawn(AI.sq_gw_for_center_07);
end

function reinforce_sniper(tv:volume, squad:ai, cav:ai)
	SleepUntil([| volume_test_players(tv) ], 1);
	if ai_living_count(cav) > 0 then
		SlipSpaceSpawn(squad);
	end
end

function difficultySetWaveCount():number
	if game_difficulty_get() == DIFFICULTY.normal then
		return 3
	else
		return 6
	end
end

function reinforce_cav(squad01:ai, squad02:ai, cav:ai)
	local waveLimiter:number = difficultySetWaveCount()
	local waveCurrent:number = 0
	repeat
		if ai_living_count(cav) > 0 then
			if ai_living_count(squad01) <= 0 and cavLivingCount() > 1 and waveCurrent <= waveLimiter then
				ai_place_with_slip_space(squad01);
				waveCurrent = waveCurrent + 1;
				sleep_s(random_range( 7, 14 ));
			end
		end
	sleep_s(random_range( 17, 25 ));
	until ai_living_count(cav) <= 0 or waveCurrent > waveLimiter
end

function reinforce_bishops()
	SleepUntil([| cavLivingCount() < 2
								or ai_living_count(AI.sg_gateway_center) <= 3 
								or ai_living_count(AI.sg_gateway_all) < 8
						 ], 1);
					 
	if ai_living_count(AI.sq_gw_for_center_01) > 0 then
		ai_place_with_birth( AI.sq_gw_for_center_01_01 );
	end
	sleep_s(3);
	if ai_living_count(AI.sq_gw_for_center_02) > 0 and ai_living_count(AI.sg_gateway_center) >= 5  then
		ai_place_with_birth( AI.sq_gw_for_center_02_01 );
	end
	sleep_s(3);
	if ai_living_count(AI.sq_gw_for_center_03) > 0 then
		ai_place_with_birth( AI.sq_gw_for_center_03_01 );
	end
end

function setMuskGateStart()
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_gateammo_buck, 1);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_gateammo_tanaka, 1);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_gateammo_vale, 1);
	end
	SleepUntil([| volume_test_players(VOLUMES.tv_cavalier_start) ], 1);
	sleep_s(1);
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_gatestart_buck, 2.5);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_gatestart_tanaka, 2.5);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_gatestart_vale, 2.5);
	end
	SleepUntil([| cav_objcon >= 20 ], 1);
	CreateThread(setMuskDestClear);
	sleep_s(1);
	CreateThread(gatewayMusketeerControl);
end

function setMuskDestClear()
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			MusketeerDestClear(spartan);
		end
	end
end

function setMuskMountOrderClear()
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			print("MusketeerClearMountOrder");
			MusketeerClearMountOrder(spartan);
		end
	end
end


function setMuskOutro()
	for _, spartan in ipairs(spartans()) do
		if object_get_health(spartan) <= 0 then
		 print("respawn");
		end
	end
end

function gatewayMusketeerControl()
	local b_assign_areas:boolean = volume_test_players( VOLUMES.tv_cavalier_right ) or volume_test_players( VOLUMES.tv_cavalier_left ) or volume_test_players( VOLUMES.tv_cavalier_middle );
	local b_gateSides:boolean    = volume_test_players( VOLUMES.tv_cavalier_right ) or volume_test_players( VOLUMES.tv_cavalier_left );
	local b_gateCenter:boolean   = volume_test_players( VOLUMES.tv_cavalier_middle );
	local b_gateBuddySet:boolean = false;
	local leftMusketeer:boolean  = false;
	
	SleepUntil([| volume_test_players( VOLUMES.tv_cavalier_right ) or volume_test_players( VOLUMES.tv_cavalier_left ) or volume_test_players( VOLUMES.tv_cavalier_middle ) ], 1);	
	repeat
		if b_assign_areas then
			for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
				if not b_gateBuddySet then
						b_gateBuddySet = true;
				else
					if b_gateSides then
							MusketeerDestSetPoint(obj, FLAGS.fl_musk_gateway_center, 12);
					elseif b_gateCenter then
						if not leftMusketeer then
							leftMusketeer = true;
							MusketeerDestSetPoint(obj, FLAGS.fl_musk_gateway_left, 10);
						else
							MusketeerDestSetPoint(obj, FLAGS.fl_musk_gateway_right, 10);
						end
					end
				end
			end
		else
			for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
				MusketeerDestClear(obj);
			end
		end
	sleep_s( random_range(40,60) );
	until cav_objcon == 55;
	
	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
		MusketeerDestClear(obj);
	end
end

--===================================================
--OBJECTIVES
--===================================================
function set_objective_blip(blip:number)
	clearObjectiveBlips();
	sleep_s(0.25);
	object_create(t_objectiveList[blip]);
end

global t_objectiveList:table=
	{
		OBJECT_NAMES.sc_objective_track01,
		OBJECT_NAMES.sc_objective_track02,
		OBJECT_NAMES.sc_objective_track03,		
		OBJECT_NAMES.sc_objective_track04,		
		OBJECT_NAMES.sc_objective_track05,		
		OBJECT_NAMES.sc_objective_track06,
		OBJECT_NAMES.sc_objective_track07,
		OBJECT_NAMES.sc_objective_track08,
		OBJECT_NAMES.sc_objective_track09
	};
	
function clearObjectiveBlips()
	for _,blip in ipairs(t_objectiveList) do
		print("clear");
		print(blip);
		if object_valid(blip) then	
			object_destroy(blip);	
		end
	end
end

--===============================================
--Sassy Spark
--===============================================
function sassy_spark_init()
	if not b_sassy then
		CreateThread(sassy_spark_control);
		b_sassy = true;
	end
end

function sassy_spark_control()
	repeat 	
		SleepUntil([| ai_living_count(AI.sq_sassy_spark) <= 0], 1);
		ai_place (set_sassy_spawn());
		print(set_sassy_spawn());
		--navpoint_track_object( ai_get_object(AI.sq_sassy_spark), true );
		print ("monitor set up");
		sleep_s(2);
	until(false)
end

global  b_monGateActive:boolean = false;

function cs_monitor_follow()
	object_set_scale (ai_current_actor, 1.2, 0.1);
	--object_cannot_take_damage (ai_current_actor);
	ai_cannot_die( ai_current_actor, true );
	cs_face_player( ai_current_actor, true);
	ai_object_set_targeting_bias( ai_get_object(ai_current_actor), -1 );
	ai_disregard(ai_current_actor, true );
	local n_spartans_current:number = list_count_not_dead( spartans() );
	sp_follow = SPARTANS.locke;
	CreateThread(sassy_catchUp, ai_current_actor);
	repeat
	print(n_mon_gate);
	--MONITOR_GATES
		if n_mon_gate < n_mon_gate_01_landing and not b_mon_at_landing then
			print("==========================================");
			print("movingtogate01");
			print("==========================================");
			sp_follow = nil;
			b_monGateActive = true;
			objects_physically_attach( OBJECTS.dm_monitor_elevator, "m_attach_mon", ai_get_object(ai_current_actor), "" );
			SleepUntil([| n_mon_gate >= n_mon_gate_01_landing], 1);
			sleep_s(1);
			SleepUntil([| b_landingElevatorStage3], 1);
			sleep_s(1);
			objects_detach( OBJECTS.dm_monitor_elevator, ai_get_object(ai_current_actor) );
			cs_fly_to(POINTS.ps_mon_gate_01_landing.p05);
			SleepUntil([| n_mon_gate >= n_mon_gate_02_tank ], 1);
			cs_fly_to(POINTS.ps_mon_gate_01_landing.p06);
			SleepUntil([| b_player_past_tank], 1);
			b_monGateActive = false;
		elseif n_mon_gate == n_mon_gate_03_cave and not b_mon_at_cave then
			print("==========================================");
			print("movingtogate03");
			print("==========================================");
			sp_follow = nil;
			b_monGateActive = true;
			cs_fly_to(POINTS.ps_mon_gate_03_cave.p01);
			cs_fly_to(POINTS.ps_mon_gate_03_cave.p02);
			SleepUntil([| b_mon_at_cave and device_get_position(OBJECTS.dm_cave_door_01) >= 0.3], 1);
			cs_fly_to(POINTS.ps_mon_gate_03_cave.p03);
			cs_fly_to(POINTS.ps_mon_gate_03_cave.p04);
			SleepUntil([| device_get_position(OBJECTS.dm_cave_door_01) <= 0], 1);
			sleep_s(1);
			b_monGateActive = false;
			
		elseif n_mon_gate == n_mon_gate_04_bridge and not b_mon_at_bridge then
		print("==========================================");
		print("movingtogate04");
		print("==========================================");
			sp_follow = nil;
			b_monGateActive = true;
			cs_fly_to(POINTS.ps_mon_gate_04_bridge.p01);
			SleepUntil([| b_mon_at_bridge ], 1);
			cs_fly_to(POINTS.ps_mon_gate_04_bridge.p02);
			sleep_s(3);
			cs_fly_to(POINTS.ps_mon_gate_04_bridge.p03);
			SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_04a_tank_exit) ], 1);
			b_monGateActive = false;
		elseif n_mon_gate >= n_mon_gate_05_easter and not b_mon_at_easter and volume_test_players(VOLUMES.tv_mon_gate_05_easter ) then
			sp_follow = nil;	
			b_monGateActive = true;
			cs_fly_to(POINTS.ps_mon_gate_05_easter.p01);
			--SleepUntil([| b_mon_at_easter ], 1);
			b_monGateActive = false;
		elseif n_mon_gate == n_mon_gate_06_gateway and not b_mon_at_gateway then
			sp_follow = nil;
			cs_fly_to(POINTS.ps_mon_gate_06_gateway.p01);	
			ai_disregard( ai_current_actor, true );
			b_monGateActive = true;
			SleepUntil([| cav_objcon >= 30 or monitor_charmed > 1 ], 1);
			if monitor_charmed < 1 then
				cs_fly_to(POINTS.ps_mon_gate_06_gateway.p02);	
			end
			SleepUntil([| cav_objcon > 50 or monitor_charmed > 1 ], 1);
			if monitor_charmed < 1 then
				cs_fly_to(POINTS.ps_mon_gate_06_gateway.p03);	
			end
			ai_disregard( ai_current_actor, false );
			SleepUntil([| b_mon_at_gateway or monitor_charmed > 1 ], 1);		
			
			b_monGateActive = false;
		end
		
--MONITOR_ASSIGN_FOLLOW	
		if IsPlayer(SPARTANS.locke) and object_get_health (SPARTANS.locke) > 0  then
			sp_follow = SPARTANS.locke;
		elseif object_get_health (SPARTANS.tanaka) > 0 and IsPlayer(SPARTANS.tanaka) then
			sp_follow = SPARTANS.tanaka;
		elseif object_get_health (SPARTANS.buck) > 0 and IsPlayer(SPARTANS.buck) then 
			sp_follow = SPARTANS.buck;	
		elseif object_get_health (SPARTANS.vale) > 0 and IsPlayer(SPARTANS.vale) then
			sp_follow = SPARTANS.vale;	
		else 
			sp_follow = SPARTANS.locke;	
		end

		print(sp_follow);
	
--MONITOR_FOLLOW_PLAYER
		if objects_distance_to_object (ai_current_actor, sp_follow) >= 10 and objects_distance_to_object (ai_current_actor, sp_follow) >= 1  then
			if unit_in_vehicle( sp_follow ) then
				cs_approach (ai_current_actor, true, sp_follow, 9, 35, 50);
				cs_face_player( ai_current_actor, false);
			else
				cs_approach (ai_current_actor, true, sp_follow, 3, 35, 50);
				cs_face_player( ai_current_actor, true);
			end
				sleep_s(2);
		end
		
		sleep_s(1);
	
	until monitor_charmed > 1;
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	ai_disregard(ai_current_actor, false );
end

function sassy_catchUp(guy:ai)
 repeat 
 	SleepUntil([|not b_monGateActive and objects_distance_to_object(sp_follow, guy) > 40], 1);	
		if object_get_health (sp_follow) > 0 then
			RunClientScript("SassyPhaseOutEffect", ai_get_object(guy));
			sleep_s(1);
			ObjectTeleportToObjectOffset( ai_get_object(guy), sp_follow, vector( 1, 1, 1.5 ) )
			sleep_s(1);
			RunClientScript("SassyPhaseInEffect", ai_get_object(guy));
		end
	sleep_s(2);
	until ai_living_count(guy) < 1;
end	
		
function sassy_pull(ps_point:point)
	if objects_distance_to_point( AI.sq_sassy_spark, ps_point ) > 5 then
		ai_erase(AI.sq_sassy_spark)
		ai_place(set_sassy_spawn());
		object_teleport_to_ai_point( AI.sq_sassy_spark, ps_point )
	end
end


function set_sassy_spawn():ai
	local valid_spawn = AI.sq_sassy_spark.spawn_gate_01_landing;
	
	if current_zone_set() == ZONE_SETS.zn_landing or current_zone_set() == ZONE_SETS.zn_road then
		if n_mon_gate <= n_mon_gate_01_landing then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_01_landing;
			print("validLanding");
		elseif n_mon_gate == n_mon_gate_02_tank then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_02_tank;
			print("validtank");
		end
	elseif current_zone_set() == ZONE_SETS.zn_road or current_zone_set() == ZONE_SETS.zn_crossing then
		if n_mon_gate == n_mon_gate_03_cave then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_03_cave;
			print("validcave");
		elseif n_mon_gate == n_mon_gate_04_bridge then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_04_bridge;
			print("validbridge");
		end
	elseif current_zone_set() == ZONE_SETS.zn_crossing or current_zone_set() == ZONE_SETS.zn_gateway then
		if n_mon_gate == n_mon_gate_05_easter then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_05_easter;		
			print("validegg");
		elseif n_mon_gate >= n_mon_gate_06_gateway then
			valid_spawn = AI.sq_sassy_spark.spawn_gate_06_gateway;			
			print("validgateway");
		end
	end
	print(valid_spawn);
	return valid_spawn;
	
end

function monitor_get_vector( obj )
	--return vector( object_get_x(obj) + 1, object_get_y(obj) + 1, ( object_get_z(obj) + 2 ) );
		return vector( 1, 1, 1.5 );
end

function objective_complete()
		ObjectiveShow(TITLES.obj_complete);	
end

function audio_cinematic_mute_arrival()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end



----------------------------------------------------------------------------
-- CHEEVOS -----------------------------------------------
----------------------------------------------------------------------------
function cheevoTankStillBeatsEverything()
	SleepUntil([| grass_objcon >= 20 and volume_test_objects(VOLUMES.tv_goal_07_grasslands,OBJECTS.v_road_tank_01 ) and object_get_health(OBJECTS.v_road_tank_01) > 0 and game_difficulty_get() == DIFFICULTY.legendary], 1);
	print("cheevoTankStillBeatsEverything");
	CampaignScriptedAchievementUnlocked(19);
end

function cheevoRollingThunder()
	if game_difficulty_get() == DIFFICULTY.heroic or game_difficulty_get() == DIFFICULTY.legendary then
		SleepUntil([|  checkSpartanLiving() and checkSpartanInVehicleAll() and checkSpartanInVehicleAllUnique()], 10);
		print("cheevoRollingThunder");
		CampaignScriptedAchievementUnlocked(20);
	end
end

function checkSpartanInVehicleAll():boolean
	for _, spartan in ipairs(spartans()) do
		if not unit_in_vehicle(spartan) then
			return false;
		end
	end
	return true;
end

function checkSpartanLiving():boolean
	if SPARTANS.locke == nil or object_get_health(SPARTANS.locke) <= 0 or IsUnitDowned(SPARTANS.locke) then
		return false;
	end
	
	if SPARTANS.vale == nil or object_get_health(SPARTANS.vale) <= 0 or IsUnitDowned(SPARTANS.vale) then
		return false;
	end
	
	if SPARTANS.tanaka == nil or object_get_health(SPARTANS.tanaka) <= 0 or IsUnitDowned(SPARTANS.tanaka) then
		return false;
	end
	
	if SPARTANS.buck == nil or object_get_health(SPARTANS.buck) <= 0 or IsUnitDowned(SPARTANS.buck) then
		return false;
	end
	
	return true;
end

function checkSpartanInVehicleAny():boolean
	for _, spartan in ipairs(spartans()) do
		if unit_in_vehicle(spartan) then
			return true;
		end
	end
	return false;
end

function checkSpartanInVehicleAllUnique():boolean
	for _, spartan1 in ipairs(spartans()) do
		for _, spartan2 in ipairs(spartans()) do
			if spartan1 ~= spartan2 then
				if unit_get_vehicle(spartan1) == unit_get_vehicle(spartan2) then
					return false;
				end
			end	
		end
	end
	return true;
end

function checkPlayerAliveAny():boolean
	for _, player in ipairs(players()) do
		if unit_get_health(player) > 0 then
			return true;
		end
	end
	return false;
end

function remoteServer.cinematicZonesetSwitch():void
	switch_zone_set(ZONE_SETS.cin170_arrival);
end

function fx_landingKillAll()
	KillEffectGroup(EFFECTS.fx_landing_fr_tower_top_hero_flare_xlg);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_01);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_02);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_03);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_05);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_06);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_07);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_08);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_09);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_10);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_11);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_12);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_13);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_14);
	KillEffectGroup(EFFECTS.fx_landing_ground_flare_15);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_03);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_05);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_06);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_07);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_08);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_lg_09);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_sm_01);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_sm_02);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_sm_03);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_sm_04);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_volume_01);
	KillEffectGroup(EFFECTS.fx_landing_ground_spores_volume_02);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_03);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_04);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_05);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_06);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_08);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_09);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_10);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_12);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_13);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_lg_14);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_med_01);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_med_02);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_med_04);
	KillEffectGroup(EFFECTS.fx_landing_low_fog_med_05);
	KillEffectGroup(EFFECTS.fx_landing_mosquitoes_01);
	KillEffectGroup(EFFECTS.fx_landing_mosquitoes_02);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_cap_light_sm_03);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_cap_light_sm_07);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_spores_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_spores_lg_03);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_spores_med_01);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_spores_med_02);
	KillEffectGroup(EFFECTS.fx_landing_mushroom_spores_med_05);
	KillEffectGroup(EFFECTS.fx_landing_top_fr_archway_flare_01);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_lg_04);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_lg_05);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_lg_06);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_sm_01);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_sm_02);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_sm_03);
	KillEffectGroup(EFFECTS.fx_landing_top_ground_spores_sm_04);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_med_01);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_med_02);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_med_03);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_med_05);
	KillEffectGroup(EFFECTS.fx_landing_top_low_fog_med_06);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_cap_light_sm_01);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_cap_light_sm_02);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_cap_light_sm_04);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_cap_light_sm_05);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_med_01);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_med_02);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_med_03);
	KillEffectGroup(EFFECTS.fx_landing_top_mushroom_spores_med_04);
	KillEffectGroup(EFFECTS.fx_landing_tower_falling_fr_energy_fog);
	KillEffectGroup(EFFECTS.fx_landing_tower_main_glass_fr_energy_base_01);
	KillEffectGroup(EFFECTS.fx_landing_tower_main_glass_fr_energy_base_02);
	KillEffectGroup(EFFECTS.fx_landing_tower_main_glass_fr_energy_wall);
	KillEffectGroup(EFFECTS.fx_landing_tower_side_fr_flare_lg_01);
	KillEffectGroup(EFFECTS.fx_landing_tower_side_fr_flare_lg_02);
	KillEffectGroup(EFFECTS.fx_landing_tower_side_fr_flare_lg_03);
	KillEffectGroup(EFFECTS.fx_landing_tower_side_fr_flare_lg_04);
	KillEffectGroup(EFFECTS.fx_landing_tower_top_fr_flare_lg);
end



----------------------------------------------------------------------------
-- CLIENT ONLY UNDER HERE -----------------------------------------------
----------------------------------------------------------------------------
--## CLIENT

function remoteClient.arvlLightbridge_on()
	interpolator_stop("grasslands_lightbridge_01");
end


function remoteClient.arvlLightbridge_off()
	interpolator_start("grasslands_lightbridge_01");
end

global flipBirds:boolean = true;

function remoteClient.flockFlipAll()
	flockFlip("flock_gaurdian_run_bird01");
	flockFlip("flock_gaurdian_run_bird02");
end
	
function remoteClient.flockFlipOFF()
	flipBirds = false;
end

function flockFlip(flock:string)
	local list_flockCreatures:object_list = flock_get_creatures(flock);

	repeat
		list_flockCreatures = flock_get_creatures(flock);

		for _,creature in ipairs(list_flockCreatures) do
			object_set_function_variable( creature, "manta_sideways", 1 )
		end
		sleep_s(0.1);
	until not flipBirds

end

--RunClientScript("arvlShakeGaurdian");
--RunClientScript("arvlShakeSlipSpace");
----------------------------------------------------------------------------
-- AMBIENT Shakes -----------------------------------------------
----------------------------------------------------------------------------
function remoteClient.arvlShakeSlipSpace()
	camera_shake_all_coop_players (.4,.4, 3);
end

function remoteClient.arvlShakeGaurdian()
	camera_shake_all_coop_players (.2, .2, 2);
end

function remoteClient.arvlShakeGaurdianSmall()
	camera_shake_all_coop_players (.2, .2, 2);
end

function remoteClient.arvlShakeGaurdianRumble01()
	camera_shake_all_coop_players (.1, .1, 3);
end

function remoteClient.arvlShakeGaurdianRumble02()
	camera_shake_all_coop_players (.3, .3, 4);
end

function remoteClient.arvlShakeGaurdianRumble03()
	camera_shake_all_coop_players (.2, .2, 3);
end

function remoteClient.arvlShakeGaurdianRumble04()
	camera_shake_all_coop_players (.6, .6, 0.2);
end

function remoteClient.arvlShakePulse()
	camera_shake_all_coop_players (.5, .5, 2);
end

function remoteClient.impactSmall(numSeconds:number)
		start_global_rumble_shake(numSeconds, TAG('levels\assets\osiris\effects\rumble_shakes\global_rumble_shake_small.effect'));
end

function remoteClient.PhaseOutEffect(ai_object:object)
	object_dissolve_from_marker( ai_object, "incineration", "phase_in" );
end

function remoteClient.phaseTank()
	object_dissolve_from_marker( OBJECTS.v_road_tank_01, "phase_in", "" );
	sound_impulse_start_marker(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3arrival_scorpionphasein\018_vin_campaign_w3arrival_scorpionphasein.sound'), OBJECTS.v_road_tank_01, "phase_in", nil);
end


function remoteClient.phaseCav()
	object_dissolve_from_marker( AI.sq_grasslands_for_01.spawnpoint01, "phase_out", "" );
end

function remoteClient.SassyPhaseInEffect(monitor:object)
		object_dissolve_from_marker( monitor, "phase_in", "");
end	

function remoteClient.SassyPhaseOutEffect(monitor:object)
	object_dissolve_from_marker( monitor, "phase_out", "");	
end

function remoteClient.guardPulseDeath(spartan:object)
	if player_get_unit( PLAYERS.local0 ) == spartan then
		print("AUDIO - PULSE DEATH");
		audio_guardianrun_deathpulse();
	end
end

function remoteClient.guardPulseImpact(spartan:object)
	if player_get_unit( PLAYERS.local0 ) == spartan then
		print("AUDIO - PULSE IMPACT");
	end
end		

function remoteClient.guardPinBird()
	streamer_pin_tag( TAG('objects\characters\guardian_bird\guardian_bird.scenery'));
end		

function remoteClient.guardPinTank()
	streamer_pin_tag( TAG('objects\vehicles\human\scorpion\scorpion.vehicle'));
end		

function remoteClient.guardUnPinBird()
	streamer_unpin_tag( TAG('objects\characters\guardian_bird\guardian_bird.scenery'));	
end		

function remoteClient.guardUnPinTank()
	streamer_unpin_tag( TAG('objects\vehicles\human\scorpion\scorpion.vehicle'));
end			

--==========================================================================

