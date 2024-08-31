--## SERVER
global guardian_rise:number = nil;
global end_earthquakes:boolean = false;
global save_loop:boolean = true;
global outpost_cleared:boolean = false;

missionEvacuation.goal_WarthogDrive =
{

	gotoVolume = VOLUMES.tv_goal_drive,
	next = {"goal_Outpost"}

}

function missionEvacuation.goal_WarthogDrive.Start()
	print("starting warthog goal");
	--creating pretty scenery
	CreateThread(f_proxy_drive02_glassupper_a_add);
	CreateThread(f_proxy_drive02_glassupper_a_remove);
	CreateThread(f_proxy_outpost_approach_remove);

	--player intro	
	PlayerIntro (2, 0.2);
	start_warthog_drive();
	f_close_bridge_door();
end

function PlayerIntro(sec:number, sec2:number)
	--CinematicPlay ("cin_100_evacuation");
	
	SleepUntil ([| AllClientViewsActiveAndStable()], 1);
	SleepUntil ([| PlayersAreAlive()], 1);
	--gadeyer: Make sure we have a few ticks to process the systemic GoalStart game_save_no_timeout before fading player input, https://entomo:8443/browse/OSR-159372
	-- Really, we need to wait 1 frame, and worse case scenario, that would be 4 ticks.
	Sleep(4);
	RunClientScript ("f_hud_show",false);
	--fading out again for testing purposes
	fade_out (255,255,255,0);
	local inputTime:number = sec or 3;
	PlayersScaleAllInput (0,0,inputTime);
	sleep_s(inputTime);
	
	RunClientScript("f_teleport_in");
	local comp = composer_play_show("vin_players_bamf_in");
	sleep_s (sec2);
	fade_in(255, 255, 255, seconds_to_frames(sec2));
	SleepUntil ([| not composer_show_is_playing(comp)], 1);
	-- gadeyer: https://entomo:8443/browse/OSR-159372
	-- This is a backup, the above fix doesn't seem to work 100% of the time.
	Sleep(1);
	print("vin_players_bamf_in is complete, saving");
	game_save_immediate();
	Sleep(4);
	PlayersScaleAllInput (1,0,0);
	-- gadeyer: https://entomo:8443/browse/OSR-159372
	CreateThread(PlayerObjectiveStart);
	
end

function PlayerObjectiveStart()
	f_chapter_title(TITLES.ct_evacuation_1);
	RunClientScript ("f_hud_show",true);
	sleep_s (0.2);
	ObjectiveShow(TITLES.obj_evacuation_1);
	game_save_no_timeout();
end

function start_warthog_drive()
	--gmu - saving first thing 8/26/2015 OSR-154032
	--gadeyer: Moved, https://entomo:8443/browse/OSR-159372
	--game_save_immediate();
	ai_place(AI.sq_warthog_intro);
	--gmu - removing for perf 8/04/2015
	--ai_place(AI.sq_warthog_intro01);
	
	sleep_s(1);

	CreateThread(f_mission_beginning);
	CreateThread(f_timer);
	CreateThread(f_earthquakes);
	CreateThread(nar_evac_warthog);

	RunClientScript("f_create_flocks_01");
	
	sleep_s(1);
	
	SleepUntil([|volume_test_players(VOLUMES.tv_mission_start)], 1);
	end_earthquakes = true;
	RunClientScript("f_flyby");
	guardian_rise = (composer_play_show("guardian_rise_transition"));
	CreateThread(airraid_alarm_start);
	CreateThread(airraid_alarm_stop);

	sleep_s(0.5);

	CreateThread(f_show_tutorial);
	CreateThread(f_close_town_gate);
	CreateThread(f_musketeer_warthog_drive);
	CreateThread(f_pawn_spawn_hill);
	CreateThread(f_start_flock_battle);
	CreateThread(f_spawn_drive_encounter);
	CreateThread(f_pelican_crash_bowl);
	CreateThread(f_spawn_hill_encounter);
	CreateThread(f_pelican_crash);
	sleep_s(5);
	CreateThread(nar_evac_level_start2);
end

function f_show_tutorial()
	SleepUntil([|volume_test_players(VOLUMES.tv_tutorial)],1);
	TutorialShowIfNotPerformed (unit_get_player(SPARTANS.locke), "training_orders_vehicle", TUTORIAL.OrdersVehicle, 15);
	SleepUntil([|unit_in_vehicle(SPARTANS.locke)], 1);
	TutorialStopAndMark(unit_get_player(SPARTANS.locke), "training_orders_vehicle_01");
--	TutorialShow(unit_get_player(SPARTANS.locke), "training_orders_vehicle", 15);
--	SleepUntil([|unit_in_vehicle(SPARTANS.locke)], 1);
--	TutorialStop(unit_get_player(SPARTANS.locke));
--	object_destroy(OBJECTS.vehicle_cache);
end

function f_close_town_gate()
	SleepUntil([|volume_test_players(VOLUMES.tv_close_town)],1);
	device_set_position(OBJECTS.minp_gate_large_town, 1);
	SleepUntil([| device_get_position(OBJECTS.minp_gate_large_town) == 1], 1);
	print ("miningtown gate down");
	local vol:volume = VOLUMES.tv_teleport_miningtown;
	volume_teleport_players_inside_with_vehicles(vol, FLAGS.miningtown_teleport_gate); 
	--teleporting the Musketeers
	f_volume_teleport_all_inside (vol, FLAGS.miningtown_teleport_gate);
	DeleteObjectsOutsideBSPS (VOLUMES.tv_delete_objects_miningtown);
	object_create_folder_anew ("minp_windmills");
end

function f_musketeer_warthog_drive()
	repeat
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			if(MusketeerIsDrivingPlayer(obj)) then
				print (obj, " musketeers driving the player");
				--cs_throttle_set (object_get_ai(obj), true, 0.6);
				-- use this line if in Faber because current_zone_set doesn't return correct
				if editor_mode() then
					if current_zone_set_fully_active() == ZONE_SETS.drive01_miningtown then 
						MusketeerFirstLeg(obj);
					elseif current_zone_set() == ZONE_SETS.drive02_glassupper_a then 
						MusketeerSecondLeg(obj);
					elseif current_zone_set_fully_active() == ZONE_SETS.outpost_approach then 
						MusketeerThirdLeg(obj);
					end
				else
					if current_zone_set() == ZONE_SETS.drive01_miningtown then 
						MusketeerFirstLeg(obj);
						--print ("can I sleep here?");
						--SleepUntil([| not MusketeerIsDrivingPlayer(obj) or current_zone_set() == ZONE_SETS.outpost_approach  ], 1);
					elseif current_zone_set() == ZONE_SETS.drive02_glassupper_a then 
						MusketeerSecondLeg(obj);
					elseif current_zone_set() == ZONE_SETS.outpost_approach then 
						MusketeerThirdLeg(obj);
					--MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p12);
					--SleepUntil([| not MusketeerIsDrivingPlayer(obj) or current_zone_set() ~= ZONE_SETS.outpost_approach  ], 1);
					end
				end
			elseif volume_test_players(VOLUMES.tv_musketeer_goto_outpost) then
				--cs_throttle_set (object_get_ai(obj), false, 1);
				print ("musketeers going to the outpost");
				MusketeerUtil_SetMusketeerGoal(FLAGS.outpost_teleport , 3);
			else
				--cs_throttle_set (object_get_ai(obj), false, 1);
				MusketeerDestClear(obj);
			end
		end
		sleep_s(1);	
	until object_valid("dm_outpost_gate") and device_get_position(OBJECTS.dm_outpost_gate) > 0.5;

	--clear the musketeer set point
	MusketeerUtil_SetDestination_Clear_All()
end

function MusketeerFirstLeg(obj:object)
	print ("first leg");
	MusketeerDestSetPoint(obj, POINTS.p_musketeer_drive.p03, 5);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p0);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p01);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p02);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p03);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p04);
end

function MusketeerSecondLeg(obj:object)
	print ("second leg");
	MusketeerDestSetPoint(obj, POINTS.p_musketeer_drive2.p0, 5);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p02);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p03);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p04);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p04);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p05);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p06);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p07);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive.p08);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p0);
	--MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p01);
	--MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p02);
	--MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p03);
end

function MusketeerThirdLeg(obj:object)
	print ("third leg");
	MusketeerDestSetPoint(obj, POINTS.p_musketeer_drive2.p12, 3);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p01);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p02);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p03);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p04);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p05);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p06);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p07);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p08);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p09);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p10);
	MusketeerDestAddWayPoint(obj, POINTS.p_musketeer_drive2.p11);
end

function f_mission_beginning()
	sleep_s(3);
	rumble_shake_small (1);
	--RunClientScript("f_earthquake_shake");
end

function f_earthquakes()
	repeat
		rumble_shake_small (1);
		--RunClientScript("f_earthquake_shake");
		sleep_s(10);
	until end_earthquakes == true;
	
	SleepUntil([|volume_test_players(VOLUMES.tv_earthquake_01)], 1);
	rumble_shake_small (1);
	--RunClientScript("f_earthquake_shake");

	SleepUntil([|volume_test_players(VOLUMES.tv_earthquake_02)], 1);
	rumble_shake_small (1);
	--RunClientScript("f_earthquake_shake");

	SleepUntil([|volume_test_players(VOLUMES.tv_earthquake_03)], 1);
	rumble_shake_small (1);
	--RunClientScript("f_earthquake_shake");

end

function f_start_flock_battle()
	SleepUntil([|volume_test_players(VOLUMES.tv_start_flock_battle)], 1);

	RunClientScript("f_create_flocks_02");
	--ai_place(AI.sg_pelican_chase);

end

function f_pawn_spawn_hill()
	SleepUntil([|volume_test_players(VOLUMES.tv_pawn_hill)], 1);
	SlipSpaceSpawn(AI.sq_pawns_hill_01);
	game_save_no_timeout();
	--ai_erase(AI.sq_warthog_intro);
	--ai_erase(AI.sq_warthog_intro01);

end

function f_pelican_crash_bowl()
	SleepUntil([|volume_test_players(VOLUMES.tv_play_crash)], 1);
	composer_play_show("vin_pel_crash");

end


function f_spawn_drive_encounter()
	SleepUntil([|volume_test_players(VOLUMES.tv_warthog_jump)], 1);
	CreateThread(f_vtol_bridge);
	--gmu - removing for perf 8/04/2015
	--CreateThread(f_warthog_bridge);
	CreateThread(f_offset_windmills);
	ai_place(AI.sq_warthog01);
	object_destroy(OBJECTS.drive_breadcrumb_01);
	object_create("drive_breadcrumb_02");
	

	SleepUntil([|volume_test_players(VOLUMES.tv_drive_encounter)], 1);

	
	ai_place(AI.sg_convoy);
	ai_place(AI.sg_vtols);
	ai_place(AI.sq_warthog_soldier);
	--gmu - removing for perf 8/04/2015
	--ai_place(AI.sq_warthog_soldier01);

	--allows for vehicles to explode more on drive.
	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog01, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_mongoose, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog03, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_mongoose, 0), .01);

	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog, 1), .01);
	--object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog01, 1), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_mongoose, 1), .01);
	--object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog, 2), .01);
	--object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog03, 2), .01);
	--object_set_health(ai_vehicle_get_from_squad(AI.sq_mongoose, 2), .01);
	

	ai_prefer_target_ai(AI.sg_vtol_targets, AI.sg_convoy_targets, true);

	ai_place(AI.sq_miners_pinned);


	SlipSpaceSpawn(AI.sq_fore_siege);

	SleepUntil([|volume_test_players(VOLUMES.tv_start_bridge)], 1);
	game_save_no_timeout();
	--CreateThread(f_retreat);
	ai_place(AI.sq_marine_bridge);
	ai_place(AI.sq_sold_bridge);


	SlipSpaceSpawn(AI.sq_running_pawns);

	
end

function f_offset_windmills()
	--sleep_s(0.5);
	--device_set_power(OBJECTS.dm_bowl_1_windmill_01, 1);

	SleepUntil([|object_valid ("dm_bowl_1_windmill_03")],1);
	sleep_s(1.25);
	device_set_power(OBJECTS.dm_bowl_1_windmill_03, 1);
	
	SleepUntil([|object_valid ("dm_bowl_1_windmill_04")],1);
	sleep_s(0.75);
	device_set_power(OBJECTS.dm_bowl_1_windmill_04, 1);

end

function f_vtol_bridge()
	SleepUntil([|volume_test_players(VOLUMES.tv_vtol_bridge)],1);
	ai_place(AI.sq_fore_vtol_chase02);

end

function f_warthog_bridge()
	ai_place(AI.sq_warthog_bridge);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog_bridge, 0), .05);

end


function f_close_bridge_door()
	SleepUntil([|volume_test_players(VOLUMES.tv_start_bridge)], 1);
	
	object_destroy(OBJECTS.drive_breadcrumb_02);
	object_create("drive_breadcrumb_03");
	
	print ("entered bridge");
	device_set_position(OBJECTS.dm_bridge_start, 1);
	--teleport players stuck behind the bridge start gate
	CreateThread (BridgeStartTeleport);

	SleepUntil([|volume_test_players(VOLUMES.tv_bridge_door)], 1);
	
	object_destroy(OBJECTS.drive_breadcrumb_03);
	object_create("drive_breadcrumb_04");
	
	print ("exited bridge");
	CreateThread(audio_evacuation_thread_up_drive_exit_bridge);
	device_set_position(OBJECTS.dm_bridge_gate, 1);
	--teleport players stuck behind the bridge end gate
	CreateThread (BridgeGateTeleport);

	ai_erase_out_of_context();
	--ai_erase(AI.sq_fore_siege);
	--ai_erase(AI.sq_miners_pinned);
	--ai_erase(AI.sq_running_pawns);
end

function BridgeStartTeleport()
	SleepUntil([| device_get_position(OBJECTS.dm_bridge_start) == 1], 1);
	
	local vol:volume = VOLUMES.tv_teleport_bridge_start;
	volume_teleport_players_inside_with_vehicles(vol, FLAGS.bridge_teleport_start); 
	--teleporting the Musketeers
	f_volume_teleport_all_inside (vol, FLAGS.bridge_teleport_start);
	print ("bridge start gate down");
	--delete unseen objects
	DeleteObjectsOutsideBSPS(VOLUMES.tv_delete_objects_bridge_start);
	DeleteObjectsNotInBSP("mod_miningtown_vehicles");

end

function BridgeGateTeleport()
	SleepUntil([| device_get_position(OBJECTS.dm_bridge_gate) == 1], 1);
	
	local vol:volume = VOLUMES.tv_teleport_bridge_gate;
	volume_teleport_players_inside_with_vehicles(vol, FLAGS.bridge_teleport); 
	--teleporting the Musketeers
	f_volume_teleport_all_inside (vol, FLAGS.bridge_teleport); 
	print ("bridge end gate down");
	--delete unseen objects
	DeleteObjectsOutsideBSPS(VOLUMES.tv_delete_objects_bridge_gate);
	DeleteObjectsNotInBSP("mod_miningtown_vehicles");
end

function f_pelican_crash()

	SleepUntil([|volume_test_players(VOLUMES.tv_ship_fall)], 1);
	composer_play_show("vin_gate_crash");

end

--Bowl Going to Outpost
function f_spawn_hill_encounter()

	SleepUntil([|volume_test_players(VOLUMES.tv_ghost_spawn)], 1);
	
	ai_place(AI.sq_mongoose01);
	ai_place(AI.sq_warthog02);
	ai_place(AI.sq_fore_vtol01);
	ai_place(AI.sq_warthog_destroy);
	SlipSpaceSpawn(AI.sg_rand_pawns);

	object_set_health(OBJECTS.ve_warthog_destroy, 0.05);

	object_set_health(ai_vehicle_get_from_squad(AI.sq_warthog02, 0), .01);
	object_set_health(ai_vehicle_get_from_squad(AI.sq_mongoose01, 0), .01);

	vehicle_set_unit_interaction(ai_vehicle_get_from_squad(AI.sq_warthog02, 0), "", false, true);
	vehicle_set_unit_interaction(ai_vehicle_get_from_squad(AI.sq_mongoose01, 0), "", false, true);
end

--function f_retreat()
--
--	cs_vtol_retreat();
--
--end

--==================================================================
--					proxy objects scripts
--==================================================================
function f_proxy_drive02_glassupper_a_add()
	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_drive02_glassupper_a_add)], 1);
	object_create("w1_evacuation_bridge_scenery_bsp");
	object_create("w1_evacuation_glassupper_a_scenery_bsp");
	object_create("w1_evacuation_outpost_scenery_bsp");
	object_create("w1_evacuation_ship_scenery_bsp");
end

function f_proxy_drive02_glassupper_a_remove()
	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_drive02_glassupper_a_remove)], 1);
	object_destroy(OBJECTS.w1_evacuation_bridge_scenery_bsp);
	object_destroy(OBJECTS.w1_evacuation_glassupper_a_scenery_bsp);
end

function f_proxy_outpost_approach_remove()
	SleepUntil([|volume_test_players(VOLUMES.tv_proxy_outpost_approach_remove)], 1);
	object_destroy(OBJECTS.w1_evacuation_outpost_scenery_bsp);
end

function f_proxy_outpost_remove()
	object_destroy(OBJECTS.w1_evacuation_bridge_scenery_bsp);
	object_destroy(OBJECTS.w1_evacuation_glassupper_a_scenery_bsp);
	object_destroy(OBJECTS.w1_evacuation_glassupper_b1_scenery_bsp);
	object_destroy(OBJECTS.w1_evacuation_glassupper_b2_scenery_bsp);
	object_destroy(OBJECTS.w1_evacuation_ship_scenery_bsp);
end


--==================================================================
--					OUTPOST
--==================================================================



missionEvacuation.goal_Outpost =
{
	checkPoints = POINTS.cp_outpost,
	zoneSet = ZONE_SETS.outpost,
	next = {"goal_elevatorBase"}

}

function missionEvacuation.goal_Outpost.Start()
	print("starting outpost goal");
	f_proxy_outpost_remove();
	GoalCreateThread(missionEvacuation.goal_Outpost, start_outpost);
end

function blink_outpost()
	NarrativeQueue.Kill();
	CreateThread(audio_evacuation_stopallmusic);
	end_earthquakes = true;
	GoalBlink(missionEvacuation, "goal_Outpost");
end



function start_outpost()
	--destroy/create breadcrumbs
	object_destroy(OBJECTS.drive_breadcrumb_04);
	object_create("tracking_objective_outpost");
	
	CreateThread(f_outpost_title);
	CreateThread(f_miner_shot_composition);

	save_loop = false;

	--destroy/create objects
	object_destroy_folder("destroyed_vehicles");
	object_destroy_folder("glassland_machines");
	object_create_folder ("mod_outpost_turrets");
	
	CreateThread(nar_goal_evac_outpost);

	ai_erase(AI.sq_running_pawns);
	ai_erase(AI.sg_rand_pawns);
	ai_erase(AI.sg_vtols);
	
	ai_place(AI.sg_fore_outpost_intro);

	--spawn the miners
	CreateThread(SpawnOutpostAllies);
		
	--spawn the badguys
	CreateThread(f_spawn_outpost_pawns);
	CreateThread(f_spawn_upper_encounter);
	CreateThread(f_upper_building);
	CreateThread(f_outpost_zoneset);
	
	composer_play_show("vin_outpost_inj"); 
	composer_play_show("vin_miner_medic");

	CreateThread(f_miner_wave);
	outpost_goal();
	--CreateThread(f_hold_out);
	game_save_no_timeout();

	sleep_s(6);

	CreateThread(audio_evacuation_thread_up_outpost_clear);
	CreateThread(nar_evac_base_doors_opening);
	CreateThread(nar_evac_base_combat_complete);
	--CreateThread(f_elevator_reached);
		
	sleep_s(4);
	object_destroy(OBJECTS.tracking_objective_outpost);
	
	--end the goal
	GoalCompleteCurrent();
end

function SpawnOutpostAllies()
	--local ally_list = ai_actors(ai_place_return(AI.sg_marine_outpost));
	ai_place (AI.sg_marine_outpost);
	
	SleepUntil ([|ai_living_count (AI.sg_marine_outpost) > 0], 1);
	local ally_list = ai_actors (AI.sg_save_the_miners);
	repeat
		for k,actor in pairs (ally_list) do
			--table.dprint (ally_list);
			if actor ~= nil and object_get_health (actor) > 0 then
				if objects_distance_to_object (players(), actor) <= 10 and objects_distance_to_object (players(), actor) > 0 then
					navpoint_track_object_named (actor, "ally");
					table.remove(ally_list, k);
				end
			else
				table.remove(ally_list, k);
			end
			Sleep (1);
		end
		Sleep (1);
	until #ally_list == 0;
	print ("all miners blipped or dead");
	--sq_marine_intro
	--sq_marine_def_04
	--sq_marine_def_02
	--sq_marine_def_01
	--sq_marine_def_door
	--NavpointShowAllServer (allies, "ally");
end

--gets all AI out of vehicles and prevents them from getting in
--doing it this way instead of in their task is because some of the actors in the squad could still be driving up here
function OutpostUnloadVehicles()
	local col_objs:object_list = volume_return_objects( VOLUMES.tv_player_at_outpost);
	local vehicle_list:object_list = metalabel_filter_objectlist( "vehicle", col_objs );
	--local unit_list:object_list = metalabel_filter_objectlist( "character", col_objs );
	for _, veh in pairs (vehicle_list) do
		print("reserving seats on ", veh);
		ai_vehicle_reserve(veh, true);
		for _, body in pairs (vehicle_riders(veh)) do
			print(body, " is a rider");
			OutpostAiExitVehicle(body);
		end
		ai_vehicle_reserve(object_get_turret(veh, 0));
		ai_vehicle_reserve_seat(veh, "mongoose_p");
		OutpostAiExitVehicle(vehicle_driver(veh));
		OutpostAiExitVehicle(vehicle_gunner(veh));
		OutpostAiExitVehicle(vehicle_driver(object_get_turret(veh, 0)));
		OutpostAiExitVehicle(vehicle_gunner(object_get_turret(veh, 0)));
		if not vehicle_test_seat_unit_list(veh, "mongoose_p", players()) then
			vehicle_unload (veh, "mongoose_p");
		end
	end 
end

function OutpostAiExitVehicle(body:object)
	if body ~= nil and not IsPlayer(body) then
		print (body, " exiting vehicle");
		ai_vehicle_exit (object_get_ai(body),"");
		cs_pause (object_get_ai(body), true, 2);
	end	
end

--deletes all allies not in the lobby
function ClearOutpostAllies()
	--NavpointStopAllServer(AI.sg_marine_outpost);
	--ClearAllies (VOLUMES.tv_goal_outpost, AI.sg_marine_outpost);
	local squad = GetTableFromSquad(AI.sg_marine_outpost);
	for _,miner in pairs (squad) do
		if not volume_test_object (VOLUMES.tv_goal_outpost, miner) then
			ai_erase (object_get_ai(miner));
		end
	end
	--ai_survival_cleanup (AI.sg_marine_outpost, true, true);
end

function f_outpost_zoneset()
	device_set_position(OBJECTS.dm_outpost_gate, 1);
	SleepUntil([| device_get_position(OBJECTS.dm_outpost_gate) == 1], 1);
	
	f_volume_teleport_all_not_inside(VOLUMES.tv_teleport_outpost, FLAGS.outpost_teleport); 
	
	--I think we need to turn on the beginzone set here...
	prepare_to_switch_to_zone_set(ZONE_SETS.outpost);
	
	--delete objects and vehicles that can't be used again
	DeleteObjectsOutsideBSPS(VOLUMES.tv_delete_objects_outpost01);
	DeleteObjectsOutsideBSPS(VOLUMES.tv_delete_objects_outpost02);
	DeleteObjectsNotInBSP("mod_miningtown_vehicles");
	DeleteObjectsNotInBSP("mod_approach_vehicles");
	DeleteObjectsNotInBSP("mod_bridge_vehicles");
	
	--creating 
	object_create("w1_evacuation_bridge_scenery_bsp"); 
	object_create("w1_evacuation_glassupper_b1_scenery_bsp");
	object_create("w1_evacuation_glassupper_b2_scenery_bsp");

	--sleeping for zoneset to switch 
	sleep_s(10);

	switch_zone_set(ZONE_SETS.outpost);
	SleepUntil([|current_zone_set() == ZONE_SETS.outpost], 1);
	
	ai_erase_out_of_context();
end

function f_outpost_title()
	ObjectiveShow(TITLES.obj_evacuation_2);
end


function outpost_goal()
	SleepUntil([|volume_test_players(VOLUMES.tv_marine_fallback_01)], 1);
	SlipSpaceSpawnGroup(AI.sg_fore_outpost);

--	if GetTotalPlayerCount() == 4 then
--
--	--put squad for coop here.
--
--	end

	game_save_no_timeout();
	--gmu 8/12/2005 -- removing this sleep because players could run past this volume
	--SleepUntil([| volume_test_players(VOLUMES.tv_marine_follow)], 1, seconds_to_frames(5));
	
	CreateThread(f_check_enemy_count);
	BlipAI (AI.sg_fore_outpost_count);

	--GMU -- 8/06/2015 - making this blocking so that soldiers are always fought and don't spawn after killing all the other AI
	f_final_ramp_fight();
	outpost_cleared = true;
end

--miner that runs and gets thrown into the crates.
function f_miner_shot_composition()

	SleepUntil([| volume_test_players(VOLUMES.tv_miner_shot)], 1);

	composer_play_show("vin_miner_takedown");

end

--encounter on the cliff.
function f_upper_building()
	SleepUntil([| volume_test_players(VOLUMES.tv_catwalk) or ai_living_count(AI.sq_fore_outpost_sold02) <= 1], 1);
	sleep_s(.5);
	if outpost_cleared == false then
		SlipSpaceSpawn(AI.sq_fore_outpost_sold03);
	end
end

function f_final_ramp_fight()
	SleepUntil([| volume_test_players(VOLUMES.tv_marine_follow)], 1);
	SlipSpaceSpawn(AI.sq_fore_final_outpost);
	sleep_s (0.5);
	SleepUntil([|ai_living_count(AI.sq_fore_final_outpost) > 0], 1);
	SleepUntil([|ai_living_count(AI.sg_fore_outpost_count) <= 0], 1);
end

function f_check_enemy_count()
	SleepUntil([|ai_living_count(AI.sg_fore_outpost) <= 11],1);
		--CreateThread(audio_evacuation_thread_up_outpost_mid);
		print("half dead");

end


function f_miner_wave()
	
	SleepUntil([| volume_test_players(VOLUMES.tv_miner_wave)], 1);
	CreateThread(nar_evac_elevator_doors_closing);
end



function f_spawn_outpost_pawns()

	SleepUntil([|ai_living_count(AI.sg_fore_outpost) <= 6], 1);
	SlipSpaceSpawn(AI.sq_fore_outpost_pawn);

end

function f_spawn_upper_encounter()
	
	SleepUntil([| volume_test_players(VOLUMES.tv_upper_encounter)], 1);
	game_save_no_timeout();

	if outpost_cleared == false then
		SlipSpaceSpawn(AI.sq_fore_outpost_upper);
	end

end

--this is no longer called -- it blew out the AI budget especially if many miners were saved -- gmu 7/31/2015
function f_hold_out()
	sleep_s(20);

	SleepUntil([|volume_test_players(VOLUMES.tv_elevator_bot)], 1);

	SlipSpaceSpawn(AI.sq_fore_outpost_pawn_stampede);
end


--=========================================================================
--						COMMAND SCRIPTS
--=========================================================================
function cs_intro_drive()
	local veh = ai_vehicle_get(ai_current_actor);
	--vehicle_set_unit_interaction (veh , "", true, false);
	--vehicle_set_player_interaction (veh , "", true, true);
	
	--cs_throttle_set(ai_current_actor, true, 1);
--	cs_go_by(ai_current_actor,true, POINTS.p_intro_drive.p0, POINTS.p_intro_drive.p01);
--	cs_go_by(ai_current_actor, true,POINTS.p_intro_drive.p01, POINTS.p_intro_drive.p02);
--	cs_go_by(ai_current_actor,true, POINTS.p_intro_drive.p02, POINTS.p_intro_drive.p03);
----cs_throttle_set(ai_current_actor, false, 0);
--	cs_go_by(ai_current_actor, true,POINTS.p_intro_drive.p03, POINTS.p_intro_drive.p04);
--	cs_go_by(ai_current_actor,true, POINTS.p_intro_drive.p04, POINTS.p_intro_drive.p05);
--	cs_go_by(ai_current_actor,true, POINTS.p_intro_drive.p05, POINTS.p_intro_drive.p06);
--	cs_go_by(ai_current_actor,true, POINTS.p_intro_drive.p06, POINTS.p_intro_drive.p06);
	--cs_throttle_set (true, 0.5);
	--cs_ignore_obstacles (true);
	cs_go_to (POINTS.p_intro_drive.p0);
	cs_go_to (POINTS.p_intro_drive.p01);
	cs_go_to (POINTS.p_intro_drive.p02);
	cs_go_to (POINTS.p_intro_drive.p03);
	cs_go_to (POINTS.p_intro_drive.p04);
	cs_go_to (POINTS.p_intro_drive.p05);
	cs_go_to (POINTS.p_intro_drive.p06);

	cs_run_command_script(ai_current_actor, "cs_mongoose_drive");
	--vehicle_unload(veh,"");
	--ai_vehicle_reserve(veh, true);

end





function cs_mongoose_drive()
	local veh = ai_vehicle_get(ai_current_actor);
	--vehicle_set_unit_interaction (veh , "", true, false);
	--vehicle_set_player_interaction (veh , "", true, true);
	--cs_throttle_set(ai_current_actor, true, 1);
	sleep_s (random_range (0.5, 2));
	cs_go_to(POINTS.p_mongoose_drive.p0, 0.5);
	cs_go_to(POINTS.p_mongoose_drive.p01, 0.5);
	cs_go_to(POINTS.p_mongoose_drive.p02, 0.5);
	cs_go_to(POINTS.p_mongoose_drive.p03, 0.5);
	cs_go_to(POINTS.p_mongoose_drive.p04);
	cs_go_to(POINTS.p_mongoose_drive.p05);
	cs_go_to(POINTS.p_mongoose_drive.p06);
	cs_go_to(POINTS.p_mongoose_drive.p07);
	cs_go_to(POINTS.p_mongoose_drive.p08);
	cs_go_to(POINTS.p_mongoose_drive.p09);
	SleepUntil([|current_zone_set() == ZONE_SETS.outpost_approach], 1);
	print ("mongoose driving to outpost_approach points");
	
--	cs_go_by(ai_current_actor,true, POINTS.p_mongoose_drive.p0, POINTS.p_mongoose_drive.p01);
--	cs_go_by(ai_current_actor, true,POINTS.p_mongoose_drive.p01, POINTS.p_mongoose_drive.p02);
--
--
--	cs_go_by(ai_current_actor,true, POINTS.p_mongoose_drive.p02, POINTS.p_mongoose_drive.p03);
--
--
--	--cs_throttle_set(ai_current_actor, false, 0);
--
--	cs_go_by(ai_current_actor, true,POINTS.p_mongoose_drive.p03, POINTS.p_mongoose_drive.p04);
--	cs_go_by(ai_current_actor,true, POINTS.p_mongoose_drive.p04, POINTS.p_mongoose_drive.p05);
--	cs_go_by(ai_current_actor,true, POINTS.p_mongoose_drive.p05, POINTS.p_mongoose_drive.p06);
--	cs_go_by(ai_current_actor,true, POINTS.p_mongoose_drive.p06, POINTS.p_mongoose_drive.p06);
	cs_go_to(POINTS.p_mongoose_drive.p10);
	cs_go_to(POINTS.p_mongoose_drive.p11);
	vehicle_unload(ai_vehicle_get(ai_current_actor),"");
	ai_vehicle_reserve(ai_vehicle_get(ai_current_actor), true);
end

function cs_warthog_drive()
	local veh = ai_vehicle_get(ai_current_actor);
	--vehicle_set_unit_interaction (veh , "", true, false);
	--vehicle_set_player_interaction (veh , "", true, true);
	--cs_throttle_set(ai_current_actor, true, 1);
--	cs_go_by(ai_current_actor,true, POINTS.p_warthog_drive.p0, POINTS.p_warthog_drive.p01);
--	cs_go_by(ai_current_actor, true,POINTS.p_warthog_drive.p01, POINTS.p_warthog_drive.p02);
--
--
--	cs_go_by(ai_current_actor,true, POINTS.p_warthog_drive.p02, POINTS.p_warthog_drive.p03);
--
--
--	--cs_throttle_set(ai_current_actor, false, 0);
--
--	cs_go_by(ai_current_actor, true,POINTS.p_warthog_drive.p03, POINTS.p_warthog_drive.p04);
--	cs_go_by(ai_current_actor,true, POINTS.p_warthog_drive.p04, POINTS.p_warthog_drive.p05);
--	cs_go_by(ai_current_actor,true, POINTS.p_warthog_drive.p05, POINTS.p_warthog_drive.p06);
--	cs_go_by(ai_current_actor,true, POINTS.p_warthog_drive.p06, POINTS.p_warthog_drive.p06);

	cs_go_to(POINTS.p_warthog_drive.p0 );
	cs_go_to(POINTS.p_warthog_drive.p01);
	cs_go_to(POINTS.p_warthog_drive.p02);
	cs_go_to(POINTS.p_warthog_drive.p03);
	cs_go_to(POINTS.p_warthog_drive.p04);
	cs_go_to(POINTS.p_warthog_drive.p05);
	cs_go_to(POINTS.p_warthog_drive.p06);
	cs_go_to(POINTS.p_warthog_drive.p07);
	cs_go_to(POINTS.p_warthog_drive.p08);
	cs_go_to(POINTS.p_warthog_drive.p09);
	cs_go_to(POINTS.p_warthog_drive.p10);
	cs_go_to(POINTS.p_warthog_drive.p11);
	cs_go_to(POINTS.p_warthog_drive.p12);
	cs_go_to(POINTS.p_warthog_drive.p13);
	cs_go_to(POINTS.p_warthog_drive.p14);
	SleepUntil([|current_zone_set() == ZONE_SETS.outpost_approach], 1);
	
	cs_go_to(POINTS.p_warthog_drive.p15);
	cs_go_to(POINTS.p_warthog_drive.p16);
	cs_go_to(POINTS.p_warthog_drive.p17);
	vehicle_unload(ai_vehicle_get(ai_current_actor),"");
	ai_vehicle_reserve(ai_vehicle_get(ai_current_actor), true);
end

function cs_soldier_drive()

	--cs_throttle_set(ai_current_actor, true, 1);
	--local veh = ai_vehicle_get(ai_current_actor);
	--vehicle_set_unit_interaction (veh , "", true, false);

--	cs_go_to(ai_current_actor, true, POINTS.p_soldier_drive.p0);
--	cs_go_to(ai_current_actor, true, POINTS.p_soldier_drive.p02);
--	cs_go_to(ai_current_actor, true, POINTS.p_soldier_drive.p03);
--	cs_go_to(ai_current_actor, true, POINTS.p_soldier_drive.p04);

	--cs_go_to(POINTS.p_soldier_drive.p0, 0.5);
	cs_go_to(POINTS.p_soldier_drive.p01, 0.5);
	cs_go_to(POINTS.p_soldier_drive.p02, 0.5);
	cs_go_to(POINTS.p_soldier_drive.p03, 0.5);
	cs_go_to(POINTS.p_soldier_drive.p04);
	cs_go_to(POINTS.p_soldier_drive.p05);
	cs_go_to(POINTS.p_soldier_drive.p06);
	cs_go_to(POINTS.p_soldier_drive.p07);
	cs_go_to(POINTS.p_soldier_drive.p08);
	cs_go_to(POINTS.p_soldier_drive.p09);
	cs_go_to(POINTS.p_soldier_drive.p10);

	vehicle_unload(ai_vehicle_get(ai_current_actor),"");
	ai_vehicle_reserve(ai_vehicle_get(ai_current_actor), true);
end

function cs_bridge_strafe()
	print ("starting bridge strafe");
	local shoot_set = POINTS.ps_bridge_shoot;
	local move_set = POINTS.ps_bridge_move;
	repeat
		local shoot_point = shoot_set[random_range(1, #shoot_set)];
		local move_point = move_set[random_range(1, #move_set)];
		
				
		if objects_can_see_object (ai_current_actor, PLAYERS.player0, 45) then
			print ("VTOL can see player");
			cs_shoot_at(ai_current_actor, true, PLAYERS.player0);
			cs_fly_to(ai_current_actor, true, move_point);
			sleep_s ( (random_range (1,20)/10) );
		else
			cs_aim(ai_current_actor, true, shoot_point);
			cs_shoot_secondary_trigger(ai_current_actor, true);
			cs_shoot_at(ai_current_actor, true, shoot_point);
			cs_fly_to(ai_current_actor, true, move_point);
		end
		--sleep_s(random_range(1, 3));
		
	until volume_test_players (VOLUMES.tv_bridge_door);


	
--	repeat
--		cs_aim(ai_current_actor, true, POINTS.ps_bridge_shoot.p1);
--		cs_shoot_secondary_trigger(ai_current_actor, true);
--		cs_shoot_at(ai_current_actor, true, POINTS.ps_bridge_shoot.p1);
--		cs_fly_to(ai_current_actor, true, POINTS.ps_bridge_move.p1);
--
--		sleep_s(1);
--
--		cs_aim(ai_current_actor, true, POINTS.ps_bridge_shoot.p2);
--		cs_shoot_at(ai_current_actor, true, POINTS.ps_bridge_shoot.p2);
--		cs_fly_to(ai_current_actor, true, POINTS.ps_bridge_move.p2);
--	
--		sleep_s(1);
--	until false;

end

function cs_exit_command_script()
	print ("exiting command script");
end


function cs_vtol_chase()
	cs_throttle_set(ai_current_actor, true, 1);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p0);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p01);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p02);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p03);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p04);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_chase.p05);
	ai_erase(ai_current_actor);

end


function cs_turret_1()

	unit_enter_vehicle_immediate(ai_current_actor, OBJECTS.v_turret_1, 'warthog_g');
	unit_open(OBJECTS.v_turret_1);
	
end

function cs_warthog_destroy()
	print ("warthog destroy started");
	cs_throttle_set(ai_current_actor, true, 0.9);
	cs_go_to(ai_current_actor, true, POINTS.p_warthog_destroy.p0);
	cs_go_to(ai_current_actor, true, POINTS.p_warthog_destroy.p1);

end

function cs_get_in_warthog()
	--cs_go_to_vehicle (OBJECTS.ve_warthog_destroy);
	ai_vehicle_enter(AI.sq_warthog_destroy, OBJECTS.ve_warthog_destroy, "");

end

function cs_vtol_flyby()

	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_flyby.p0);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_flyby.p01);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_flyby.p02);
	cs_fly_by(ai_current_actor, true, POINTS.p_vtol_flyby.p03);
	ai_erase(ai_current_actor);

end

function cs_vtol_retreat()

	cs_fly_by(AI.sq_fore_vtol_chase02, true, POINTS.p_vtol_flyby.p0);
	cs_fly_by(AI.sq_fore_vtol_chase02, true, POINTS.p_vtol_flyby.p01);
	cs_fly_by(AI.sq_fore_vtol_chase02, true, POINTS.p_vtol_flyby.p02);
	cs_fly_by(AI.sq_fore_vtol_chase02, true, POINTS.p_vtol_flyby.p03);
	ai_erase(AI.sq_fore_vtol_chase02);

end



function cs_shoot_warthog()
	repeat
		--cs_aim_object(ai_current_actor, true, ai_get_unit(AI.sq_warthog_destroy));
		cs_aim_object(ai_current_actor, true, OBJECTS.ve_warthog_destroy);
		cs_shoot_secondary_trigger(ai_current_actor, true);
		cs_shoot(ai_current_actor, true, OBJECTS.ve_warthog_destroy);
		cs_fly_to(ai_current_actor, true, POINTS.p_vtol_flyby.p0);
		
		sleep_s (0.5);
		
	until object_get_health(OBJECTS.ve_warthog_destroy) <= 0.5;
	--SleepUntil([|false], 1);
end


function cs_pelican_chase()
	cs_throttle_set(ai_current_actor, true, 1);

	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p0, 30);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p1, 30);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p2, 30);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p3, 10);

	ai_erase(ai_current_actor);
end


function cs_pelican_chase_vtol()
	cs_throttle_set(ai_current_actor, true, 1);

	cs_shoot(ai_current_actor, true, AI.vin_pelican);

	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p0, 20);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p1, 20);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p2, 20);
	cs_fly_by(ai_current_actor, true, POINTS.p_pelican_chase.p3, 10);

	ai_erase(ai_current_actor);

end

function f_bridge_miner_objective_set()
	print ("bridge miners are now outpost miners");
	ai_set_objective(AI.sq_marine_bridge,"obj_follow");
end

--========================================================
--				GOAL END
--========================================================

function missionEvacuation.goal_WarthogDrive.End():void

	CreateThread(audio_evacuation_thread_up_drive_end);

end


function missionEvacuation.goal_Outpost.End():void


end
--==========================================================================
--							Client Scripts
--==========================================================================
--## CLIENT

function remoteClient.f_flyby()
	flock_create("pelican_flyby");

	sleep_s(2);

	flock_stop("pelican_flyby");

	sleep_s(45);

	flock_delete("pelican_flyby");

end

function remoteClient.f_create_flocks_01()
	repeat

	flock_create("escaping_pelicans");
	flock_create("escaping_pelicans01");

	sleep_s(6);

	flock_stop("escaping_pelicans");
	flock_stop("escaping_pelicans01");

	sleep_s(35);

	flock_delete("escaping_pelicans");
	flock_delete("escaping_pelicans01");

	until false;

end

function remoteClient.f_create_flocks_02()
	repeat

	flock_create("chased_flock_pelican");
	flock_create("chased_flock_pelican01");
	flock_create("chased_flock_vtol");
	flock_create("chased_flock_vtol01");

	flock_create("sky_battle_pelican");
	flock_create("sky_battle_vtol");
	flock_create("sky_battle_vtol01");

	sleep_s(6);

	flock_stop("chased_flock_pelican");
	flock_stop("chased_flock_pelican01");
	flock_stop("chased_flock_vtol");
	flock_stop("chased_flock_vtol01");

	flock_stop("sky_battle_pelican");
	flock_stop("sky_battle_vtol");
	flock_stop("sky_battle_vtol01");

	sleep_s(40);

	flock_delete("chased_flock_pelican");
	flock_delete("chased_flock_pelican01");
	flock_delete("chased_flock_vtol");
	flock_delete("chased_flock_vtol01");

	flock_delete("sky_battle_pelican");
	flock_delete("sky_battle_vtol");
	flock_delete("sky_battle_vtol01");

	until false;

end


function remoteClient.f_teleport_in()
	CreateEffectGroup (EFFECTS.effect_spawn);
	--effect_attached_to_camera_new (TAG('levels\campaignworld010\w1_evacuation\fx\fx_teleport_scrfx_in.effect'));
end

--==========================================================================
--					EARTHQUAKE CAMERA SHAKES!!!!!
--==========================================================================



function remoteClient.f_earthquake_shake()
	camera_shake_all_coop_players_start (0.2, 0.2);
	sleep_s(1);
	camera_shake_all_coop_players_stop(0.1);
end

--SHOW HUD -- hopefully temp
function remoteClient.f_hud_show (bool:boolean)
	hud_show (bool);
end