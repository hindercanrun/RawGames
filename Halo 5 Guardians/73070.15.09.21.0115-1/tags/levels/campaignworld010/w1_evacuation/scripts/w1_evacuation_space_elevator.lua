--## SERVER

--global start_elevator:boolean = false;
global space_elevator_ride:number = nil;
global guardian_elevator_ride:number = nil;
global lobby_vignette:number = nil;

global elevator_combat:boolean = false;
global waves_cleared:boolean = false;
global knights_dead:boolean = false;
global tanaka_activate:boolean = false;

global g_ics_player:object = nil;

missionEvacuation.goal_elevatorBase =
{
	zoneSet = ZONE_SETS.elevator_lobby,
	checkPoints = POINTS.ps_blink_01,
	next = {"goal_elevatorRide"}

}


function blink_base()
	CreateThread(audio_evacuation_stopallmusic);
	NarrativeQueue.Kill();
	end_earthquakes = true;
	guardian_rise = (composer_play_show("guardian_rise_transition"));
	GoalBlink(missionEvacuation, "goal_elevatorBase");

end

function missionEvacuation.goal_elevatorBase.Start()
	print("starting elevator goal");
	object_create_folder ("cache_base_lobby");
	--object_create_folder ("tracking_objective_base");
	
	f_elevator_base();
end



function f_elevator_base()
	--open the exterior door
	device_set_position(OBJECTS.dm_exterior_door, 1);

	--create the tracking objective
	object_create ("tracking_objective_lobby");

	--start the lobby vignette
	LobbyVignettePlay();
	composer_play_show("vin_minor_wave");
	
	CreateThread(firstfloor_alarm_unfilter);

	--set the musketeer path
	CreateThread (MusketeerMovementLobby);
	
	CreateThread(nar_goal_evac_elevatorbase);
	--object_create_folder("ride_module");

	--this is called from the nar_goal_evac_elevatorbase and is hit when players hit an interior trigger volume
	SleepUntil([|b_elevator_entered], 1);
	SleepUntil([|device_get_position(OBJECTS.dm_exterior_door) == 1], 1);
	
	--close the exterior door
	sleep_s(4);
	device_set_position(OBJECTS.dm_exterior_door, 0);
	
	--turn on the kill volume for squishing anybody taking a ride on the door
	SleepUntil([|device_get_position(OBJECTS.dm_exterior_door) < 0.3], 1);
	kill_volume_enable (VOLUMES.kill_exterior_door);
	
	SleepUntil([|device_get_position(OBJECTS.dm_exterior_door) == 0], 1);
	--teleporting all the spartans inside
	--volume_teleport_players_not_inside(VOLUMES.tv_goal_outpost, FLAGS.blink_base_01);
	f_volume_teleport_all_not_inside(VOLUMES.tv_goal_outpost, FLAGS.blink_base_01);
	DeleteObjectsNotInBSP("mod_miningtown_vehicles");
	DeleteObjectsNotInBSP("mod_approach_vehicles");
	DeleteObjectsNotInBSP("mod_bridge_vehicles");
	DeleteObjectsNotInBSP("mod_outpost_turrets");
	DeleteObjectsOutsideBSPS(VOLUMES.entire_outpost_area);
	
	game_save_no_timeout();
	prepare_to_switch_to_zone_set(ZONE_SETS.elevator_lobby);
	
	--remove blips on Outpost marines
	ClearOutpostAllies();
	
	sleep_s(1);

	object_destroy_folder("destroyed_vehicles");
	object_destroy_folder("outpost_crates");
	composition_killer(guardian_rise);

	--sleep_s(20);
	SleepUntil([|nar_door_open == true], 1);
		
	CreateThread(firstfloor_alarm_start);
	CreateThread(audio_evacuation_thread_up_door_open);

	switch_zone_set(ZONE_SETS.elevator_lobby);
	SleepUntil([|current_zone_set() == ZONE_SETS.elevator_lobby], 1);

	sleep_s(2.5);
	object_create("dm_elevator_base_walls");
	device_set_position(OBJECTS.dm_interior_door, 1);
	
	--tell the musketeers to go into the elevator when the doors are open
	CreateThread (MusketeerMovementElevator);
	
	--destroying previous objective, creating the new objective
	object_destroy (OBJECTS.tracking_objective_lobby);
	object_create_folder ("tracking_objective_base");
	CreateThread(audio_space_elevator_int_door);
	CreateThread(f_elevator_title);
	game_save_no_timeout();

	--close the interior door and then the elevator gate
	CreateThread(ElevatorGateClose);
	
	--spawn the forerunner enemies, blip them when there are only a few left
	ai_place (AI.sg_fore_base);
	BlipAI(AI.sg_fore_base, 3);
	
	SleepUntil([|ai_living_count(AI.sg_fore_base) <= 0 and device_get_position(OBJECTS.dm_elevator_gate) == 1], 1);

	--GoalCompleteTask(missionEvacuation.goal_elevatorBase);
	GoalCompleteCurrent();

end

function LobbyVignettePlay()
	print (lobby_vignette);
	if lobby_vignette == nil then
		sleep_s(4);
		lobby_vignette = (composer_play_show("vin_elevator_lobby"));
		
		SleepUntil ([|ai_living_count(AI.elevator_lobby_guards) > 0]);
		for _, ally in pairs (ai_actors (AI.elevator_lobby_guards)) do
			navpoint_track_object_named( ally, "ally" );
		end
		--NavpointShowAllServer( AI.elevator_lobby_guards, "ally" );
		--navpoint_track_object_named
	end
end

function MusketeerMovementLobby()
	SleepUntil([|device_get_position(OBJECTS.dm_exterior_door) >= .5], 1);
	MusketeerUtil_SetMusketeerGoal (OBJECTS.cr_ammo_crate, 8);
end

function MusketeerMovementElevator()
	SleepUntil([|device_get_position(OBJECTS.dm_interior_door) < 0.3 and device_get_position(OBJECTS.dm_elevator_gate) < 0.3], 1);
	--tell musketeers to go into elevator
	MusketeerUtil_SetMusketeerGoal (FLAGS.flag_control, 8);
end

function ElevatorGateClose()
	SleepUntil([|volume_test_players(VOLUMES.tv_elevator01) or ai_living_count(AI.sg_fore_base) <= 0],1);
	InteriorDoorClose();

	device_set_position(OBJECTS.dm_elevator_gate, 1);
	
	--turn on the kill volume for squishing anybody in the way of the door
	SleepUntil([|device_get_position(OBJECTS.dm_elevator_gate) > 0.8], 1);
	kill_volume_enable (VOLUMES.kill_elevator_gate);
	
	SleepUntil([| device_get_position(OBJECTS.dm_elevator_gate) == 1], 1);
	f_volume_teleport_all_inside (VOLUMES.evacuation_covenant_fight, FLAGS.elevator_teleport_gate);
	ClearInteriorAllies();
	
	MusketeerUtil_SetDestination_Clear_All();
end

function InteriorDoorClose()
	device_set_position(OBJECTS.dm_interior_door, 0);
	CreateThread(audio_space_elevator_int_door_close);
	--turn on the kill volume for squishing anybody in the way of the door
	SleepUntil([|device_get_position(OBJECTS.dm_interior_door) < 0.3], 1);
	kill_volume_enable (VOLUMES.kill_interior_door);
	
	SleepUntil([| device_get_position(OBJECTS.dm_interior_door) == 0], 1);
	f_volume_teleport_all_inside (VOLUMES.tv_goal_outpost, FLAGS.elevator_teleport_interior_door);
	ClearLobbyAllies();
	print ("interior door is down");
	object_destroy_folder ("cache_base_lobby");
end

--kills all miners that are in the elevator lobby (this should also stop the vin_elevator_lobby vignette)
function ClearLobbyAllies()
	print ("CLEARING LOBBY ALLIES");
	ClearAllies (VOLUMES.tv_goal_outpost, AI.sg_elevator_miners);
	ClearAllies (VOLUMES.tv_goal_outpost, AI.sg_marine_outpost);
end

function ClearInteriorAllies()
	print ("CLEARING INTERIOR ALLIES");
	ClearAllies (VOLUMES.evacuation_covenant_fight, AI.sg_elevator_miners);
	ClearAllies (VOLUMES.evacuation_covenant_fight, AI.sg_marine_outpost);
end

function ClearAllies (vol:volume, squad:ai)
	local t_squad = GetTableFromSquad(squad);
	for _,miner in pairs (t_squad) do
		if volume_test_object (vol, miner) then
			ai_erase (object_get_ai(miner));
		end
	end

end
	
--SAVIOR ACHIEVEMENT
function AchievementSavior()
	--OSR-150210 -- this was firing simply because it was legendary difficulty, checking the difficulty first
	if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then
		local count = volume_return_objects_by_campaign_type (VOLUMES.tv_elevator_check_savior, 4);
		local living_count = 0;
		for _,miner in pairs (count) do
			if object_get_health (miner) > 0 then
				local is_musk = 0;
				for _,musk in pairs (musketeers()) do
					if miner == musk then
						print ("miner is musketeer");
						is_musk = is_musk + 1;						
					end
				end
				if is_musk == 0 then
					print ("miner is miner");
					living_count = living_count + 1;
				end
			end
		end
		print ("Savior -- number of alive miners is ", living_count);
		if living_count >= 6 then 
			print ("SAVIOR ACHIEVEMENT UNLOCKED");
			CampaignScriptedAchievementUnlocked(9);
		else
			print ("FAILED SAVIOR ACHIEVEMENT");
		end
	else
		print ("GAME DIFFICULTY NOT HEROIC OR LEGENDARY -- NO ACHIEVEMENT AWARDED");
	end
end

function check_type (num:number)
	local count = volume_return_objects_by_campaign_type (VOLUMES.tv_elevator_check_savior, num);
	print ("Savior -- number of types is ", #count);
	table.dprint (count);
end

--goal end
function missionEvacuation.goal_elevatorBase.End()
	object_destroy_folder ("tracking_objective_base");
	
end


--=======================================================================================================
--						GOAL RIDE
--=======================================================================================================




missionEvacuation.goal_elevatorRide =
{
	checkPoints = POINTS.cp_ride,

	zoneSet = ZONE_SETS.elevator_ride,
	next = {"goal_scaffoldClimb"}

}


function blink_ride()
	NarrativeQueue.Kill();
	CreateThread(audio_evacuation_stopallmusic);
	end_earthquakes = true;
	GoalBlink(missionEvacuation, "goal_elevatorRide");
end

function blink_ride_bots()
	NarrativeQueue.Kill();
	CreateThread(audio_evacuation_stopallmusic);
	end_earthquakes = true;
	CreateThread (DebugElevatorPushButton);
	GoalBlink(missionEvacuation, "goal_elevatorRide");
end

function DebugElevatorPushButton()
	SleepUntil ([| object_valid ("dc_elevator_control")]);
	SleepUntil ([| device_get_power(OBJECTS.dc_elevator_control) > 0]);
	device_set_position(OBJECTS.dc_elevator_control, 1);
	device_set_power(OBJECTS.dc_elevator_control, 0);
	object_destroy(OBJECTS.tracking_objective_elevator);
	CreateThread(f_start_elevator_ride);
end


function missionEvacuation.goal_elevatorRide.Start()
	print("starting elevator goal");
	AchievementSavior();
	if object_valid ("dm_elevator_gate") and device_get_position (OBJECTS.dm_elevator_gate) ~= 1 then
		print ("shutting elevator gate probably because of blinking");
		device_set_position_immediate (OBJECTS.dm_elevator_gate, 1);
	end
	GoalCreateThread(missionEvacuation.goal_elevatorRide,evacuate);
end


--this function is called from the device_control tag -- I might change this to be an event function
--this starts the elevator ride
function f_activate(device:object, activator:player)
	activator = activator or PLAYERS.player0;

	if device == OBJECTS.dc_elevator_control then
		CreateThread (ControlElevatorStart, device, activator);		
	end
	
	if device == OBJECTS.dc_side_elevator then
		CreateThread (SideElevatorControl, activator);
	end
end

function ControlElevatorStart(device:object, activator:object)
	--g_ics_player = activator;
	print(activator, " pressed the button");
	activator = activator or PLAYERS.player0;
	local t_elevatorcontrol = {activator = activator, pressed = false};
	local vin = composer_play_show("vin_tanaka_elevator_activate", t_elevatorcontrol );
	device_set_power(device, 0);
	object_destroy(OBJECTS.tracking_objective_elevator);
	CreateThread(f_start_elevator_ride);
	TutorialStopAll();
	
	--changing the elevator controls graphic at a specific point in the button push animation -- gmu 8/03 -- OSR-96464
	SleepUntil ([| t_elevatorcontrol.pressed ], 1);
	--SleepUntil ([| not composer_show_is_playing(vin) ], 1);
	object_set_variant (OBJECTS.cr_elevator_screen, "activated");
end

function SideElevatorControl(activator:player)
	print ("side elevator activated");
	activator = activator or PLAYERS.player0;
	device_set_power(OBJECTS.dc_side_elevator, 0);
	composer_play_show("lobby_elevator_press", {ics_player = activator});
--	if device_get_position (OBJECTS.dm_side_lift_001) == 0 then
--		SleepUntil ([| device_get_position (OBJECTS.dm_side_lift_001) == 1 ], 1);
--	else
--		SleepUntil ([| device_get_position (OBJECTS.dm_side_lift_001) == 0 ], 1);
--	end
--	device_set_power(OBJECTS.dc_side_elevator, 1);
end

function evacuate()
	CreateThread(nar_goal_evac_elevatorride);
	object_create("tracking_objective_elevator");
	device_set_power(OBJECTS.dc_elevator_control, 1);

	sleep_s(4);
	--if players haven't activated the elevator control then play VO telling them to find it
	if device_get_power(OBJECTS.dc_elevator_control) == 1 then
		nar_evac_elevator_base_combat_complete();
		--turn on tutorial for tracking reminder so players can find the button
		SleepUntil([| NarrativeQueue.HasConversationFinished(W1Evacuation_Space_elevator_base__TANAKA_STARTS_ELEVATOR) ], 1);
		sleep_s (1);
		--if players haven't activated the elevator control then remind them with VO and tutorial
		if device_get_power(OBJECTS.dc_elevator_control) == 1 then
			ElevatorTutorialReminder();
		end
	end
end

--variable for tracking the Elevator tutorial repeat function
global k_timer = 30
global n_timer = k_timer;

--shows the tutorial text to talk to the NPC's on a loop until talking to the NPC
function ElevatorTutorialReminder()
	RegisterSpartanTrackingPingObjectEvent(TrackingOnPing, OBJECTS.tracking_objective_elevator);
	repeat
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator_base_start_the_elevator);
		SleepUntil([| NarrativeQueue.HasConversationFinished(W1Evacuation_Space_elevator_base_start_the_elevator) ], 1);
		if device_get_power(OBJECTS.dc_elevator_control) == 1 then
			TutorialShowAll ("training_tracking_elevator", 5);
			n_timer = k_timer;
			TutorialTimer();
		end
	until device_get_power(OBJECTS.dc_elevator_control) == 0;
	UnregisterSpartanTrackingPingObjectEvent(TrackingOnPing, OBJECTS.tracking_objective_elevator);
end

--stops the tutorial playing on a client if they ping while the tutorial text is up
function TrackingOnPing(playerUnit:object, PingedObj:object):void
	print(PingedObj, " was pinged by ", playerUnit);
	TutorialStop(unit_get_player(playerUnit));
	n_timer = k_timer;
end

function TutorialTimer()
	repeat
		n_timer = (n_timer - 1);
		sleep_s (1);
		--print (n_timer);
	until n_timer == 0;
end

function f_elevator_title()
	--commenting out gmu 7/31/2015 OSR-143325
	--adding back in gmu 8/6/2015
	f_chapter_title (TITLES.ct_evacuation_3);
	--sleep_s(1.5);
	ObjectiveShow(TITLES.obj_evacuation_3);
end


function f_set_combat_bool()
	elevator_combat = true;
end


function f_start_elevator_ride()
	NarrativeQueue.EndConversationEarly (W1Evacuation_Space_elevator_base__TANAKA_STARTS_ELEVATOR);
	
	object_destroy(OBJECTS.dm_interior_door);
	--remove the objective
	object_destroy(OBJECTS.tracking_objective_elevator);

	sleep_s(2);

	--SleepUntil([|volume_test_players_all(VOLUMES.tv_elevator01)], 1);

	switch_zone_set(ZONE_SETS.elevator_ride);
	SleepUntil([|current_zone_set() == ZONE_SETS.elevator_ride], 1);

	CreateThread(nar_elevator_start);

	sleep_s(3.5);

	space_elevator_ride = (composer_play_show("comp_elevator_ride"));

	rumble_shake_medium (2);
	--RunClientScript("f_shake_cam");
	
	--Wake(dormant.evacuation_elevator_start);
	
	sleep_s(9);
	game_save_no_timeout();

	Wake(dormant.evacuation_guardian_view_2);
	
	--=================================
	--		ELEVATOR WAVES
	--=================================


	SleepUntil([|elevator_combat == true], 1);
	CreateThread(audio_evacuation_thread_up_elevator_wave01_start);
	CreateThread(wave_alarm);
	
	local wave1 = AI.sg_fore_wave_01
	SlipSpaceSpawnGroup(wave1);
	interpolator_start("em_light_01");
	sleep_s(4);
	
	--blip the second wave and wait for them to be dead
	BlipAI (wave1, 3);
	SleepUntil([|ai_living_count(wave1) <= 0] ,1);

	sleep_s(6);
	elevator_combat = false;
	CreateThread(audio_evacuation_thread_up_elevator_wave01_end);

	game_save_no_timeout();
	
	SleepUntil([|elevator_combat == true], 1);
	CreateThread(audio_evacuation_thread_up_elevator_wave02_start);
	CreateThread(wave_alarm);


	SlipSpaceSpawn(AI.sq_for_sold_w2);
	SlipSpaceSpawn(AI.sq_for_sold__02_w2);
	SlipSpaceSpawn(AI.sq_for_soldoff_w2);

	if GetTotalPlayerCount() == 4 then
		SlipSpaceSpawn(AI.sq_4p_for_sold_02_w2);
	end

	interpolator_start("em_light_01");
	sleep_s(4);
	
	--blip the second wave and wait for them to be dead
	BlipAI (AI.sg_fore_wave_02);
	SleepUntil([|ai_living_count(AI.sg_fore_wave_02) <= 0] ,1);

	sleep_s(6);
	elevator_combat = false;
	CreateThread(audio_evacuation_thread_up_elevator_wave02_end);

	game_save_no_timeout();

	SleepUntil([|elevator_combat == true], 1);
	CreateThread(audio_evacuation_thread_up_elevator_wave03_start);
	CreateThread(wave_alarm);
	
	--spawn second wave
	SlipSpaceSpawn(AI.sq_fore_knight_commander);
	SlipSpaceSpawn(AI.sq_fore_knights01);
	SlipSpaceSpawn(AI.sq_fore_knights02);

	if GetTotalPlayerCount() == 4 then
		SlipSpaceSpawn(AI.sq_fore_knights02);
	end

	interpolator_start("em_light_01");
	sleep_s(4);
	
	--blip the third wave and wait for them to be dead
	BlipAI (AI.sg_fore_wave_03);
	SleepUntil([|ai_living_count(AI.sg_fore_wave_03) <= 0] ,1);
	sleep_s(6);
	elevator_combat = false;
	knights_dead = true;
	CreateThread(audio_evacuation_thread_up_elevator_wave03_end);
	

	prepare_to_switch_to_zone_set(ZONE_SETS.elevator_top);
	sleep_s(2);

	CreateThread(nar_robards_call);
	--CreateThread(elevator_drop);
	
	--gmu 8/13/2015
	--sleep until the view is blocked, then spawn the guardian
	sleep_s(8);
	guardian_elevator_ride = (composer_play_show("guardian_rising_ride"));

	print ("GUARDIAN SPAWNED");
	--scripted_pause (true);
end

function composer_waves_cleared()

	waves_cleared = true;
		
end


function composer_elevator_drop()
	--object_create_folder ("cr_elevator_curved_railings");
	CreateThread(elevator_drop);
	local comp_drop:number = composer_play_show("vin_elevator_drop");
	composition_killer(guardian_elevator_ride);
	object_destroy_folder ("cr_elevator_curved_railings");
	CreateThread(audio_elevatordrop_alarms_activate);
	CreateThread(audio_elevator_unstable_activate);
	CreateThread(GuardianStart);
--	repeat
--		ElevatorKillPlayersOnDropNotInside();
--	until composer_show_is_playing (comp_drop);
end

function GuardianStart()
	SleepUntil([|volume_test_players(VOLUMES.tv_start_guardian_end) or volume_test_players(VOLUMES.tv_objective_elevator_exit)], 1);
	composer_play_show("vin_guardian_end");
end

function elevator_drop()
	Wake(dormant.evacuation_guardian_emp);
	--kill all the miners just in case they are still around
	ai_kill(AI.sg_marine_outpost);
	ai_kill(AI.elevator_lobby_guards);
	ai_kill(AI.sg_convoy_targets);
	ai_kill(AI.sg_save_the_miners);
	object_create("elevator_phantom");
	--create the light blocker for sunlight streaming inside --gmu-8-07-2015
	object_create("cr_elevator_light_blocker");
	rumble_shake_medium (2);
	--RunClientScript("f_shake_cam");

	sleep_s(2);
	CreateThread(audio_evacuation_thread_up_elevator_after_emp);
	object_destroy(OBJECTS.elevator_phantom);
	switch_zone_set(ZONE_SETS.elevator_top);
	SleepUntil([|current_zone_set() == ZONE_SETS.elevator_top], 1);

	sleep_s(1);
	f_clear_ics();
	GoalCompleteTask(missionEvacuation.goal_elevatorRide);
end

--kill players not in the elevator for bug OSR-127457 -gmu 8/10/2015
function ElevatorKillPlayersOnDropNotInside()
	for _, spartan in pairs (spartans()) do
		if not volume_test_object (VOLUMES.tv_elevator_kill_outside, spartan) then
			print ("killing spartan because they are out of the elevator ", spartan);
			unit_kill (spartan);
		end
	end
	Sleep(1);
end

function missionEvacuation.goal_elevatorRide.End()
	composition_killer(space_elevator_ride);
	
		
	object_destroy(OBJECTS.dm_elevator_base_walls);
	object_destroy(OBJECTS.tracking_supply_cache_placeholder);
	object_destroy(OBJECTS.tracking_supply_cache_placeholder01);
	
	object_create_folder("tracking_objective_elevator_exit");

	game_save_no_timeout();

	Wake(dormant.evacuation_osiris_come_to);

	--tell musketeers to get close to the doors
	MusketeerUtil_SetMusketeerGoal(FLAGS.fl_elevator_musketeer_goal);

	SleepUntil([|volume_test_players(VOLUMES.tv_objective_elevator_exit)], 1);
	CreateThread(audio_evacuation_thread_up_elevator_exit);

	object_destroy_folder("tracking_objective_elevator_exit");
	
	--tell musketeers to return to follow the player
	MusketeerUtil_SetDestination_Clear_All();
	
	CreateThread(nar_tracking_exit);
end


function composition_killer(composition:number):void
	if composition then
		composer_stop_show(composition);
		composition = nil;
	end
end



--==========================================================================
--					CAMERA SHAKES!!!!!
--==========================================================================

--## CLIENT


function remoteClient.f_shake_cam()

	camera_shake_all_coop_players_start (0.6, 0.6);

	sleep_s(2);

	camera_shake_all_coop_players_stop(0.2);

end

function f_shake_cam_02()

	camera_shake_all_coop_players_start (0.6, 0.6);

	sleep_s(2);

	camera_shake_all_coop_players_stop(0.2);

end



function camera_shake_all_coop_players_start (attack, intensity):void
	
                print ("SHAKE START");
				sound_impulse_start(TAG('sound\002_ui\002_ui_hud\002_ui_hud_rumble\002_ui_hud_2d_rumble_short.sound'), nil, 1)
                for key,value in pairs(players()) do
                                player_shake (value, attack, intensity);
                end
end

function camera_shake_all_coop_players_stop (decay):void
                print ("SHAKE STOP");
                for key,value in pairs(players()) do
                                print (value);
				player_shake_stop (value, decay);
                end
end

function player_shake (p_player, attack, intensity):void
                player_effect_set_max_rotation_for_player (p_player, (intensity*3), (intensity*3), (intensity*3));
                player_effect_set_max_rumble_for_player (p_player, 1, 1);
                player_effect_start_for_player (p_player, intensity, attack);
end

function player_shake_stop (p_player, decay):void
                player_effect_set_max_rumble_for_player (p_player, 0, 0);
                player_effect_stop_for_player (p_player, decay);
end
