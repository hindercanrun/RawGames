--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 Sentinels*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- GLOBALS

global swarm_show:number = -1;
global b_cryptum_down:boolean = false;
global b_cryptum_lowering:boolean = false;
global n_hp_pin_state:number = 0;
global obj_con_ug:number = 0;
global b_sentinelswarm_start:boolean = false;

global g_ics_player01:object = nil;
global g_ics_player02:object = nil;
global g_ics_player03:object = nil;
global g_ics_player04:object = nil;

global n_health_max:number = 1;
global n_shield_max:number = 1;
global b_health_pin:boolean = true;
global b_first_pulse:boolean = true;

global showConDestruct:number = 0; 
global show_postswarm:number = 0;
global b_postswarm_show:boolean = true;
global pulseDelay:number = 8;
global showFall:string = "w3_first_fall";
global pulseCount:number = 0;
global pulseMax:number = 1;
global InputUpdate:number = 1;
global healthMultiplier:number = 0.9;
global shieldMultiplier:number = 0.75;
global pulseNow:boolean = false;
global fallActiveLocke:number = 0;
global fallActiveVale:number = 0;
global fallActiveTanaka:number = 0;
global fallActiveBuck:number = 0;
global showPulse:number = 0;
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
--  ********************  			      GOAL 7 - UNDERGROUND           *********************** --
--  **************************************************************************************** --


function cortanaPulse()
	local state = {};

	CreateThread(healthPin);

	repeat
		sleep_s(3);
		CreateMissionThread(underground_timer_cortana_vo);
		SleepUntil ([| pulseNow ],1, seconds_to_frames(pulseDelay));
		--SleepUntil ([| not b_endgame_cortana_is_talking ],1);			--	I've put that to try for the timing with Cortana's speech and the pulses.		
		Sleep(10);
		--	NARRATIVE CALL
		b_pulse_loud = true;
		print("b_pulse_loud = true");
		pulseNow = false;
		
		if not b_pulse_player_at_the_relay then
			print("healthPinState");
			CreateThread(healthPinState, (n_health_max * healthMultiplier), (n_shield_max * shieldMultiplier) );
			KillEffectGroup(EFFECTS.fx_group_pulse );
			sleep_s(0.1);
			CreateEffectGroup( EFFECTS.fx_group_pulse );
			

			if b_first_pulse then
				b_first_pulse = false;
				for _, spartan in ipairs (spartans()) do
					CreateThread(gazeControl, spartan);
				end
			end

			CreateThread(rumble_shake_large,3);
			sleep_s(0.5);
			
			--NIL

			if not b_pulse_player_at_the_relay then
				PlayersScaleAllInput (InputUpdate, 0, 60);
				if pulseCount > pulseMax and not b_pulse_player_at_the_relay then
	 				CreateThread(killSpartans);
				end				
	
				--LOCKE
				state.locke_fall_1 = VolumeReturnPuppet(SPARTANS.locke,  VOLUMES.tv_walkway_stage1);
				state.locke_fall_2 = nil;
				state.locke_fall_3 = nil;
				state.locke_fall_4 = nil;
				if state.locke_fall_1 ~= SPARTANS.locke then
					state.locke_fall_1 = nil;
					state.locke_fall_2 = VolumeReturnPuppet(SPARTANS.locke,  VOLUMES.tv_walkway_stage2);
					state.locke_fall_3 = nil;
					state.locke_fall_4 = nil;
				end
				if state.locke_fall_1 ~= SPARTANS.locke and state.locke_fall_2 ~= SPARTANS.locke then 
					state.locke_fall_1 = nil;
					state.locke_fall_2 = nil;
					state.locke_fall_3 = VolumeReturnPuppet(SPARTANS.locke,  VOLUMES.tv_walkway_stage3);
					state.locke_fall_4 = nil;
				end
				if state.locke_fall_1 ~= SPARTANS.locke and state.locke_fall_2 ~= SPARTANS.locke  and state.locke_fall_3 ~= SPARTANS.locke  then
					state.locke_fall_1 = nil;
					state.locke_fall_2 = nil;
					state.locke_fall_3 = nil;
					state.locke_fall_4 = VolumeReturnPuppet(SPARTANS.locke,  VOLUMES.tv_walkway_stage4);
				end
				if state.locke_fall_1 ~= SPARTANS.locke and state.locke_fall_2 ~= SPARTANS.locke and state.locke_fall_3 ~= SPARTANS.locke and state.locke_fall_4 ~= SPARTANS.locke then
					state.locke_fall_1 = SPARTANS.locke;
					state.locke_fall_2 = nil;
					state.locke_fall_3 = nil;
					state.locke_fall_4 = nil;
				end
				
				--VALE PUP ASSIGNMENT
				state.vale_fall_1 = VolumeReturnPuppet(SPARTANS.vale,  VOLUMES.tv_walkway_stage1);
				state.vale_fall_2 = nil;
				state.vale_fall_3 = nil;
				state.vale_fall_4 = nil;
				if state.vale_fall_1 ~= SPARTANS.vale then
					state.vale_fall_1 = nil;
					state.vale_fall_2 = VolumeReturnPuppet(SPARTANS.vale,  VOLUMES.tv_walkway_stage2);
					state.vale_fall_3 = nil;
					state.vale_fall_4 = nil;
				end
				if state.vale_fall_1 ~= SPARTANS.vale and state.vale_fall_2 ~= SPARTANS.vale then 
					state.vale_fall_1 = nil;
					state.vale_fall_2 = nil;
					state.vale_fall_3 =	VolumeReturnPuppet(SPARTANS.vale,  VOLUMES.tv_walkway_stage3);
					state.vale_fall_4 = nil;
				end
				if state.vale_fall_1 ~= SPARTANS.vale and state.vale_fall_2 ~= SPARTANS.vale  and state.vale_fall_3 ~= SPARTANS.vale then
					state.vale_fall_1 = nil;
					state.vale_fall_2 = nil;
					state.vale_fall_3 = nil;
					state.vale_fall_4 = VolumeReturnPuppet(SPARTANS.vale,  VOLUMES.tv_walkway_stage4);
				end
				if state.vale_fall_1 ~= SPARTANS.vale and state.vale_fall_2 ~= SPARTANS.vale and state.vale_fall_3 ~= SPARTANS.vale and state.vale_fall_4 ~= SPARTANS.vale then
					state.vale_fall_1 = SPARTANS.vale;
					state.vale_fall_2 = nil;
					state.vale_fall_3 = nil;
					state.vale_fall_4 = nil;
				end
				
				--TANAKA
				state.tanaka_fall_1  = VolumeReturnPuppet(SPARTANS.tanaka, VOLUMES.tv_walkway_stage1);
				state.tanaka_fall_2 = nil;
				state.tanaka_fall_3 = nil;
				state.tanaka_fall_4 = nil;
				if state.tanaka_fall_1 ~= SPARTANS.tanaka then
					state.tanaka_fall_1 = nil;
					state.tanaka_fall_2 = VolumeReturnPuppet(SPARTANS.tanaka, VOLUMES.tv_walkway_stage2);
					state.tanaka_fall_3 = nil;
					state.tanaka_fall_4 = nil;
				end
				if state.tanaka_fall_1 ~= SPARTANS.tanaka and state.tanaka_fall_2 ~= SPARTANS.tanaka then 
					state.tanaka_fall_1 = nil;
					state.tanaka_fall_2 = nil;
					state.tanaka_fall_3 = VolumeReturnPuppet(SPARTANS.tanaka, VOLUMES.tv_walkway_stage3);
					state.tanaka_fall_4 = nil;
				end
				if state.tanaka_fall_1 ~= SPARTANS.tanaka and state.tanaka_fall_2 ~= SPARTANS.tanaka  and state.tanaka_fall_3 ~= SPARTANS.tanaka  then
					state.tanaka_fall_1 = nil;
					state.tanaka_fall_2 = nil;
					state.tanaka_fall_3 = nil;
					state.tanaka_fall_4 = VolumeReturnPuppet(SPARTANS.tanaka, VOLUMES.tv_walkway_stage4);
				end
				if state.tanaka_fall_1 ~= SPARTANS.tanaka and state.tanaka_fall_2 ~= SPARTANS.tanaka and state.tanaka_fall_3 ~= SPARTANS.tanaka and state.tanaka_fall_4 ~= SPARTANS.tanaka then
					state.tanaka_fall_1 = SPARTANS.tanaka;
					state.tanaka_fall_2 = nil;
					state.tanaka_fall_3 = nil;
					state.tanaka_fall_4 = nil;
				end
				--Buck
				state.buck_fall_1  = VolumeReturnPuppet(SPARTANS.buck, VOLUMES.tv_walkway_stage1);
				state.buck_fall_2 = nil;
				state.buck_fall_3 = nil;
				state.buck_fall_4 = nil;
				if state.buck_fall_1 ~= SPARTANS.buck then
					state.buck_fall_1 = nil;
					state.buck_fall_2 = VolumeReturnPuppet(SPARTANS.buck, VOLUMES.tv_walkway_stage2);
					state.buck_fall_3 = nil;
					state.buck_fall_4 = nil;
				end
				if state.buck_fall_1 ~= SPARTANS.buck and state.buck_fall_2 ~= SPARTANS.buck then 
					state.buck_fall_1 = nil;
					state.buck_fall_2 = nil;
					state.buck_fall_3 = VolumeReturnPuppet(SPARTANS.buck, VOLUMES.tv_walkway_stage3);
					state.buck_fall_4 = nil;
				end
				if state.buck_fall_1 ~= SPARTANS.buck and state.buck_fall_2 ~= SPARTANS.buck and state.buck_fall_3 ~= SPARTANS.buck then
					state.buck_fall_1 = nil;
					state.buck_fall_2 = nil;
					state.buck_fall_3 = nil;
					state.buck_fall_4 = VolumeReturnPuppet(SPARTANS.buck, VOLUMES.tv_walkway_stage4);
				end	
				if state.buck_fall_1 ~= SPARTANS.buck and state.buck_fall_2 ~= SPARTANS.buck and state.buck_fall_3 ~= SPARTANS.buck and state.buck_fall_4 ~= SPARTANS.buck then
					state.buck_fall_1  = SPARTANS.buck;
					state.buck_fall_2 = nil;
					state.buck_fall_3 = nil;
					state.buck_fall_4 = nil;
				end
				print("================================");
				print("STATELOCKE01", state.locke_fall_1);
				print("STATELOCKE02", state.locke_fall_2);
				print("STATELOCKE03", state.locke_fall_3);
				print("STATELOCKE04", state.locke_fall_4);
				print("================================");
				print("================================");
				print("STATEBUCK01", state.buck_fall_1);
				print("STATEBUCK02", state.buck_fall_2);
				print("STATEBUCK03", state.buck_fall_3);
				print("STATEBUCK04", state.buck_fall_4);
				print("================================");
				showPulse = pup_play_show("vin_pulse_falls", state);
				
				sleep_s(1);
				SleepUntil ([| not pup_is_playing(showPulse) ],1 );	
				pulseCount = pulseCount + 1;
				
				state.locke_fall_1  = nil;
				state.locke_fall_2  = nil;
				state.locke_fall_3  = nil;
				state.locke_fall_4  = nil;
				state.vale_fall_1	  = nil;
				state.vale_fall_2   = nil;
				state.vale_fall_3   = nil;
				state.vale_fall_4	  = nil;
				state.tanaka_fall_1 = nil;
				state.tanaka_fall_2 = nil;
				state.tanaka_fall_3 = nil;
				state.tanaka_fall_4 = nil;
				state.buck_fall_1   = nil;
				state.buck_fall_2   = nil;
				state.buck_fall_3   = nil;
				state.buck_fall_4   = nil;
			end
			
		end	
		--	NARRATIVE CALL
		print("b_pulse_loud = false");
		b_pulse_loud = false;
		g_cortana_vo_timer = 0;
		
	until volume_test_players(VOLUMES.tv_walkway_autobash) 
		b_gazeControlEnd = true;

end 

global b_gazeControlEnd:boolean = false;

function gazeControl(sp:object)
	repeat
		SleepUntil ([|unit_get_health(sp) > 0 or b_gazeControlEnd], 1);	
		if not b_gazeControlEnd then
			if IsPlayer(sp) then
				player_control_lock_gaze( sp, FLAGS.vin_gazelock, 600 );
				sleep_s(1);
				player_control_unlock_gaze(sp);
				player_control_clamp_gaze( sp, FLAGS.vin_gazelock, 25 );
			else
				MusketeerControlGazePoint(FLAGS.vin_gazelock); 
			end
		end
		SleepUntil ([|unit_get_health(sp) <= 0 or b_gazeControlEnd], 1);	
		sleep_s(0.25);
	until b_gazeControlEnd
		if IsPlayer(sp) then
				player_control_unlock_gaze(sp);
			else
				MusketeerControlUnlockGaze();
		end
end

function VolumeReturnPuppet(character:object, vol:volume):object
	local spa_tab = VolumeReturnSpartans(vol)
	for _,spartan in pairs(spa_tab) do
		if spartan == character then
			return character
		end
	end
	return nil;
end

function spartanEndtest():void

	local sp_prime:object = nil;
	local sp_pickup:object = nil;
	local sp_spartan1:object = nil;
	local sp_spartan2:object = nil;
	print("setup");
	
	sp_prime = SPARTANS.locke;

	sp_pickup = SPARTANS.vale;
	
	for _,spartan in ipairs(spartans()) do
		if spartan ~= sp_pickup and spartan ~= sp_prime then
			if sp_spartan1 == nil then
				print("sp_spartan1");
				sp_spartan1 = spartan;
			else
				print("sp_spartan2");
				sp_spartan2 = spartan;
			end
		end
	end
		print(sp_prime);
		print(sp_pickup);
		print(sp_spartan1);
		print(sp_spartan2);
		
end
		--if volume_test_object(VOLUMES.tv_walkway_stage4, SPARTANS.vale) then
		
function endSafeToSpawn(b_safe:boolean)
	game_safe_to_respawn( b_safe, SPARTANS.locke );
	game_safe_to_respawn( b_safe, SPARTANS.vale );
	game_safe_to_respawn( b_safe, SPARTANS.buck );
	game_safe_to_respawn( b_safe, SPARTANS.tanaka );
end

function spartanEndChoreographer():void
	local vol1:volume = VOLUMES.tv_walkway_autobash;
	local state = {};
	local puppets = {};
	local sp_prime:object = nil;
	local sp_pickup:object = nil;
	local sp_spartan1:object = nil;
	local sp_spartan2:object = nil;
	print("setup");
	SleepUntil ([|volume_return_players(vol1)[1] ~= nil], 1);
	sp_prime = volume_return_players(vol1)[1];
	
	endSafeToSpawn(true);
	PlayersForceReviveAndRespawn();
	sleep_s(1);
	repeat
	
	if sp_prime == SPARTANS.locke then
		sp_pickup = SPARTANS.vale;
	else
		sp_pickup = SPARTANS.locke;
	end
	
	if sp_prime ~= SPARTANS.vale and sp_pickup ~= SPARTANS.vale then
			sp_spartan1 = SPARTANS.vale;
	end
	
	if sp_spartan1 == nil and sp_prime ~= SPARTANS.buck then
		sp_spartan1 = SPARTANS.buck
	elseif sp_prime ~= SPARTANS.buck then
		sp_spartan2 = SPARTANS.buck
	end
	
	if sp_prime ~= SPARTANS.tanaka then
		sp_spartan2 = SPARTANS.tanaka
	end
		
	print("pickup");
		print("=============");
	print(sp_prime);
	print(sp_pickup);
	print(sp_spartan1);
	print(sp_spartan2);
	print("=============")
	
	until sp_prime ~= nil and sp_pickup ~= nil and sp_spartan1 ~= nil and sp_spartan2 ~= nil	
	
	state.prime = sp_prime;
	if volume_test_object(VOLUMES.tv_walkway_stage4, sp_pickup) then
		state.pickup = sp_pickup;
		state.pickup_slant = nil;
	else
		state.pickup = nil;
		state.pickup_slant = sp_pickup;
	end
	if volume_test_object(VOLUMES.tv_walkway_stage4, sp_spartan1) then
		state.spartan1 = sp_spartan1
		state.spartan1_slant = nil
	else
		state.spartan1 = nil;
		state.spartan1_slant = sp_spartan1;
	end
	
	if volume_test_object(VOLUMES.tv_walkway_stage4, sp_spartan2) then
		state.spartan2 = sp_spartan2;
		state.spartan2_slant = nil;
	else
		state.spartan2 = nil;
		state.spartan2_slant = sp_spartan2;
	end

  Sleep(1);
 	hud_show_navpoints_player(false);
 	hud_show_navpoints_musketeer(false);
 	hud_show_navpoints_major_biped(false);
	showConDestruct = composer_play_show("w3_final_conduit_destruction", state );
	SleepUntil ([| not pup_is_playing(showConDestruct)], 1);	
	object_set_shield_stun( PLAYERS.player0, 0 );
	object_set_shield_stun( PLAYERS.player1, 0 );
	object_set_shield_stun( PLAYERS.player2, 0 );
	object_set_shield_stun( PLAYERS.player3, 0 );
	state.prime = nil;
	state.pickup = nil;
	state.spartan1 = nil
	state.spartan2 = nil;
	state.pickup_slant = nil;
	state.spartan1_slant = nil;
	state.spartan2_slant = nil;
	sleep_s(0.1);
	pup_stop_show(swarm_show);
	composer_stop_all();

	state.prime = sp_prime;
	state.pickup = sp_pickup;
	state.spartan1 = sp_spartan1;
	state.spartan2 = sp_spartan2;
	
	sleep_s(0.1);
	show_postswarm = pup_play_show ("vin_w3_sentinels_postswarm", state);
end

function fallSelect(spartan:object):number
	local showIndex:number = 0
	if volume_test_object(VOLUMES.tv_walkway_stage4, spartan) then
		showIndex = 4;
	elseif volume_test_object(VOLUMES.tv_walkway_stage3, spartan) then
		showIndex = 3;
	elseif volume_test_object(VOLUMES.tv_walkway_stage2, spartan) and pulseCount < 1 then
		showIndex = 2;
	elseif volume_test_object(VOLUMES.tv_walkway_stage1, spartan) and pulseCount < 1 then
		showIndex = 1;
	else 
		showIndex = random_range(1,2);
	end
	return showIndex
end
	
missionSentinels.goal_underground = 
	{
	zoneSet = ZONE_SETS.zn_factory,
	}
	
function missionSentinels.goal_underground.Start() :void	

	g_ics_player01 = SPARTANS.locke;
	g_ics_player02 = SPARTANS.vale;
	g_ics_player03 = SPARTANS.tanaka;
	g_ics_player04 = SPARTANS.buck;
	print ("goal_underground starting...");
	MusketeersOrderTurnAllOff();
	CreateThread(audio_prep_factory);
	CreateThread(endMuskControl);
	print("============================");
	CreateThread (f_chapter_title, TITLES.ct_sen_4);

	-- NARRATIVE CALL
	CreateThread(sentinels_underground_wake);
	print ("narrative call starting");

	Sleep(5);
	
	swarm_show = pup_play_show ("vin_w3_sentinels_swarm");
	composer_play_show ("vin_rad_proj");
	CreateThread(spartanEndChoreographer);
	-- CLEANUP COLISEUM STUFF
	object_destroy_folder("crs_col_cannons");
	
	SleepUntil ([| b_sentinels_end_pulse_shielded_01 ],1 );
		sleep_s (1);
		CreateEffectGroup( EFFECTS.fx_group_pulse );
		sleep_s (1);
		print ("NEED FX PULSE");
		CreateThread(rumble_shake_large, 3);
		sleep_s (2);
		KillEffectGroup(EFFECTS.fx_group_pulse );
	SleepUntil ([| b_sentinels_end_pulse_shielded_02 ],1 );
		sleep_s (2);
		CreateEffectGroup( EFFECTS.fx_group_pulse );
		sleep_s (1);
		CreateThread(rumble_shake_large, 3);
		print ("pulse 2 hit");	
		sleep_s (2);
		KillEffectGroup(EFFECTS.fx_group_pulse );
	SleepUntil ([| b_sentinels_end_pulse_shielded_03 ],1 );
		sleep_s (6);
		KillEffectGroup(EFFECTS.fx_group_pulse );
		sleep_s(0.1);
		CreateEffectGroup( EFFECTS.fx_group_pulse );
	CreateThread(rumble_shake_large, 3);

	sleep_s (1);
	
	CreateThread(rumble_shake_large, 3);
	
	print ("pulse 3 hit");	
	CreateThread(zone_prep_and_swap, ZONE_SETS.zn_end);
	sleep_s (1);
	SleepUntil ([| b_sentinels_end_remove_shield ],1 );
	endSafeToSpawn(false);
	ObjectiveShow (TITLES.obj_sen_6);
	sleep_s (1);
	CreateThread(audio_sentinels_thread_up_underground_start);
	
	CreateThread (col_elevator_domedetach);	
	CreateThread(audio_factory_domeshielddown);
	
	if object_index_valid(OBJECTS.cr_domeshield) then	
		object_destroy (OBJECTS.cr_domeshield);
	end
	   -- clearing their elevator goal from coliseum;
	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			MusketeerDestClear(obj);
	end
	--MusketeerUtil_SetDestination_Clear_All();
	game_save_no_timeout();
	scripting_revive_enabled = false;

	CreateThread(cortanaPulse);
	object_create("sn_final_obj");
	-- STAGE ONE STARTS
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage1) ],1 );
	--	NARRATIVE CALL
	b_pulse_stage_01 = true;
	pulseNow = true;

	-- STAGE TWO STARTS
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage2) ],1 );
	--	NARRATIVE CALL
	b_pulse_stage_02 = true;
	pulseNow = true;

	pulseDelay = 7;
	pulseCount = 0;
	InputUpdate = 0.8;
	healthMultiplier = 0.8;
	shieldMultiplier = 0.07;

	--	NARRATIVE CALL FOR MAGBOOTS
	b_endgame_magboots_vo = true;
	PrintNarrative("b_endgame_magboots_vo = true;");
	--	To activate the MagBoots AFTER the VO, wait for that boolean to become true: b_endgame_magboots_are_on			--guillaume
	CreateThread(gravbootFloorSwap);

	-- STAGE THREE STARTS
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage3) ],1 );
	--	NARRATIVE CALL
	b_pulse_stage_03 = true;
	--	I need a delay for VO to play before the pulse is coming for Cortana's VO. Tell me if it screw up something for you.
	--sleep_s(1);
	pulseNow = true;
	pulseDelay = 8;
	showFall = "w3_second_fall";
	pulseCount = 0;
	InputUpdate = 0.5;
	healthMultiplier = 0.65;
	shieldMultiplier = 0;
	sleep_s (1);
	-- camera FX here for weakness
	--CreateThread (weakness_rumble_small);
	
	-- STAGE FOUR STARTS
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage4) ],1 );	
	--	NARRATIVE CALL
	b_pulse_stage_04 = true;
	pulseNow = true;
	pulseDelay = 14;
	showFall = "w3_third_fall";
	pulseCount = 0;
	pulseMax = 0;
	InputUpdate = 0.3;
	healthMultiplier = 0.10;
	shieldMultiplier = 0;
	sleep_s (1);

	--	NARRATIVE CALL
	b_sentinels_end_pulse = true;
	-- FINAL STAGE STARTS
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_autobash) ],1 );			
	--	NARRATIVE CALL
	b_pulse_player_at_the_relay = true;
	object_destroy(OBJECTS.sn_final_obj);
	sleep_s(1);
	PlayersScaleAllInput (0.1, 0, 30);
	sleep_s (3);
	
	CreateThread(audio_sentinels_thread_up_underground_core_destroyed);
	SleepUntil ([| not pup_is_playing(showConDestruct)], 1);
	game_save_no_timeout();
	--fade_out( 0, 0, 0, 5 );
	
	scripting_revive_enabled = true;
	sleep_s(0.2);

	--	NARRATIVE CALL
	b_endgame_osiris_get_up = true;
	sleep_s(0.1);
	--fade_in();
	
	--b_health_pin = false;
	
	--	NARRATIVE CALL
	CreateThread(sentinels_endgame_wake);
	
	RunClientScript("ShakeHard");
	sleep_s (0.5);
	--print ("sentinel swarm is a go!");
	b_sentinelswarm_start = true;
	n_endgame_state = 3;
	SleepUntil ([| not pup_is_playing(show_postswarm)], 1);
	
	--SleepUntil ([| not b_postswarm_show], 1);

	print("playcin");
	--CreateThread(audio_sentinels_thread_up_underground_end);
	--composer_stop_all()
	--composer_stop_show( show_postswarm );
	EndMission(missionSentinels);

end

global healthUpdate:boolean = false;

function healthPin()
	for _,spartan in ipairs(spartans()) do
		object_set_shield_stun_infinite( spartan )
	end
		
	repeat
		Sleep(9);
		RunClientScript("healthSet", n_health_max);	
		for _,spartan in ipairs(spartans()) do
			object_set_shield(spartan, n_shield_max);
		end
		
	until (not b_health_pin);

	for _,spartan in ipairs(spartans()) do
		object_set_shield_stun( spartan, 0 );
	end
end

function healthPinState( health:number, shields:number)
		SleepUntil ([| healthUpdate ], 1);	
		n_health_max = health;
		n_shield_max = shields;
		healthUpdate = false;
end

function weakness_rumble_small()
	repeat
		rumble_shake_medium(2);
		sleep_s (2);
	until volume_test_players(VOLUMES.tv_walkway_stage4);
end


function weakness_rumble_large()
	repeat
		rumble_shake_large();
		sleep_s (2);
	until volume_test_players(VOLUMES.tv_walkway_autobash);
end

function weakness_fade()
	repeat
		sleep_s (1);
		--RunClientScript ("FX_fade");	
		sleep_s (random_range (1, 3));
	until volume_test_players(VOLUMES.tv_walkway_autobash);
end


function ComposerFXCall()
	print("REMOVE");
	--CreateThread (temp_fx_pulses);
end

function endgameDisableRevive(o_spartan:object)
	repeat
		SleepUntil([|unit_get_health(o_spartan) > 0], 1);
		sleep_s(1);
		SleepUntil([|IsUnitDowned(o_spartan)], 1);
 		unit_kill(o_spartan);
	until not b_health_pin
	print("reviveActive");	
end

function gravbootFloorSwap()
	object_create("dm_endfloor_gravboot");
	sleep_s(0.25);
	object_destroy(OBJECTS.dm_endfloor)
end

function temp_fx_pulses()
	--SoundImpulseStartServer(TAG(' sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_charge_2d.sound'), nil, 1);
--  CHARGE UP NOISE
--	CreateEffectGroup( EFFECTS.temp_fx_1 );

	sleep_s (0.1);
--	CreateEffectGroup( EFFECTS.temp_fx_2 );
	sleep_s (0.1);
--	CreateEffectGroup( EFFECTS.temp_fx_3 );
	sleep_s (0.1);
--	CreateEffectGroup( EFFECTS.temp_fx_4 );
	sleep_s (0.1);
--	CreateEffectGroup( EFFECTS.temp_fx_5 );
	sleep_s (0.1);
--	CreateEffectGroup( EFFECTS.temp_fx_6 );
	sleep_s (0.1);	
--	CreateEffectGroup( EFFECTS.temp_fx_7 );
	sleep_s (0.1);
--CreateEffectGroup( EFFECTS.temp_fx_8 );			
	--SoundImpulseStartServer(TAG(' sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_beamblastintense_2d.sound'), nil, 1);
--  PSCHEW EXPLOOOSSSIIIOOONN	
	sleep_s (0.1);
--	CreateEffectGroup (EFFECTS.temp_fx_flash);		
end

global t_endMusk0:table=	{ FLAGS.fl_musk_end_buck_0, FLAGS.fl_musk_end_tanaka_0, FLAGS.fl_musk_end_vale_0};
global t_endMusk01:table=	{ FLAGS.fl_musk_end_buck_01, FLAGS.fl_musk_end_tanaka_01, FLAGS.fl_musk_end_vale_01};
global t_endMusk02:table= { FLAGS.fl_musk_end_buck_02, FLAGS.fl_musk_end_tanaka_02, FLAGS.fl_musk_end_vale_02};
global t_endMusk03:table= { FLAGS.fl_musk_end_buck_03, FLAGS.fl_musk_end_tanaka_03, FLAGS.fl_musk_end_vale_03};
global t_endMusk04:table=	{	FLAGS.fl_musk_end_buck_04, FLAGS.fl_musk_end_tanaka_04,	FLAGS.fl_musk_end_vale_04};
global t_endMusk05:table= {	FLAGS.fl_musk_end_buck_05, FLAGS.fl_musk_end_tanaka_05, FLAGS.fl_musk_end_vale_05};
global n_playerEndAdvance:number = 0;

function endMuskControl()
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			MusketeerDestClear(spartan);
		end
	end
	CreateThread(endMuskSetPosition, t_endMusk01);
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage1)],1 );	
	CreateThread(endMuskSetPosition, t_endMusk02);
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage2)],1 );	
	CreateThread(endMuskSetPosition, t_endMusk03);
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage3)],1 );	
	CreateThread(endMuskSetPosition, t_endMusk04);
	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_stage4)],1 );	
	CreateThread(endMuskSetPosition, t_endMusk05);
end

function endMuskSetPosition(t_flag:table)
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, t_flag[1], 0.25);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, t_flag[2], 0.25);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, t_flag[3], 0.25);
	end
end


function ComposerExplosionCall()
	CreateThread (ExplosionFX);
end


function ExplosionFX()
	--CreateEffectGroup (EFFECTS.temp_fx_explosion_1);
	sleep_s (0.2);	
--	CreateEffectGroup (EFFECTS.temp_fx_explosion_2);
--	CreateEffectGroup (EFFECTS.temp_fx_explosion_3);	
	--KillEffectGroup(EFFECTS.temp_fx_flare_1);
--	KillEffectGroup(EFFECTS.temp_fx_flare_2);
--	KillEffectGroup(EFFECTS.temp_fx_core_beam_1);
--	KillEffectGroup(EFFECTS.temp_fx_core_beam_2);	
	sleep_s (0.2);
	object_destroy (OBJECTS.dm_final_conduit);	
	--RunClientScript ("FXstop");
end

function killSpartans()
	SleepUntil ([| not pup_is_playing(showPulse) ],1 );	
	damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), spartans());
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast_sentinals.sound'), nil, 1);
end

function cs_col_phase()
	cs_phase_in()
end

function zone_prep_and_swap(zone:zone_set)
	
	if current_zone_set_fully_active() ~= zone then
		prepare_to_switch_to_zone_set( zone );
		SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
		Sleep(1);
		switch_zone_set( zone );
	end
	
end




--## CLIENT

function remoteClient.healthSet(healthNumber)
	for i = 1, 11 do
		if object_get_health(PLAYERS.local0) >= healthNumber then
				object_set_health(PLAYERS.local0,  healthNumber);
		end
	end
end

function remoteClient.ShakeSoft()
	camera_shake_all_coop_players (0.2, 0.2, 3);
end

function remoteClient.ShakeHard()
	camera_shake_all_coop_players (0.5, 0.5, 2);
end

function remoteClient.FXstage1()
	screen_effect_new(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_01.area_screen_effect'),FLAGS.fl_screenfx);
end


function remoteClient.FXstage2()
	screen_effect_delete(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_01.area_screen_effect'),FLAGS.fl_screenfx);
	screen_effect_new(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_02.area_screen_effect'),FLAGS.fl_screenfx);
end


function remoteClient.FXstage3()

	screen_effect_delete(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_02.area_screen_effect'),FLAGS.fl_screenfx);
	screen_effect_new(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_03.area_screen_effect'),FLAGS.fl_screenfx);

end


function remoteClient.FX_fade()
	screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\sentinels_end_player_blink_fade_01.area_screen_effect'),FLAGS.fl_screenfx);
end


function remoteClient.FXstop()
	screen_effect_delete(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_01.area_screen_effect'),FLAGS.fl_screenfx);
	screen_effect_delete(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_02.area_screen_effect'),FLAGS.fl_screenfx);
	screen_effect_delete(TAG('fx\scratch\johnedwards\parts\player_overload_flash_state_03.area_screen_effect'),FLAGS.fl_screenfx);
end

