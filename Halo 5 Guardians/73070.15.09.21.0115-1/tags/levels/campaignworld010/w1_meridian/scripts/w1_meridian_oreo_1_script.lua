--## SERVER

-- Human World, Hub OREO 1
-- Matt Geer

-- NOTE: ENCFIX == Search Keyword for Encounter Functions.

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ GLOBAL VARIABLES *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*


global b_wave_2_summoned : boolean = false;
global b_encounter_completed : boolean = false;
global b_snipersgodown : boolean = false;
global b_garage_opened : boolean = false;
global b_fallback_1 : boolean = false;
global b_cliff_summoned : boolean = false;
global b_building_summoned : boolean = false;
global b_kill_commander : boolean = false;
global b_upper_power_off : boolean = false;
global b_lower_power_off : boolean = false;
global b_any_gen_off : boolean = false;
global b_dc_drop_hog_1_used : boolean = false;
global b_dc_drop_hog_2_used : boolean = false;
global b_dc_second_door_used : boolean = false;
global b_dc_gun_button_used : boolean = false;
global b_obj_any_gen_destroyed : boolean = false;


-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_* STARTUP SCRIPTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_*_*_ SPAWNING *_*_*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_* LEVEL SCRIPTS *_*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

function f_generator_door_drop()
	-- Once generators are used or destroyed the door will drop.
	print("Drop Door Now");
	Sleep(30);
	CreateThread(f_open_doors);
end

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_* DEVICE SCRIPTS _*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

function f_device_setup()
	GoalThread (f_spawn_turrets);
	CreateThread(f_check_generator);
end

function f_open_doors():void
	CreateThread(f_musketeer_bowl_1_drive);
	ObjectSetSpartanTrackingEnabled(OBJECTS.cr_outpost_generator, false);
	prepare_to_switch_to_zone_set(ZONE_SETS.zs_020);
	sleep_s(3);
-- Opens the front gate and destroys the lights when the player completes the encounter (only happens once, just in case the player completes another OREO after completing their first one.)
	n_tutorialpoint = 20;
	if b_encounter_completed == false then
		if 	b_wave_2_summoned == false then
			b_wave_2_summoned = true;	
		end
		b_encounter_completed = true;
		KillThread(s_thread_f_spawn_leftcave);
		KillThread(s_thread_f_mer_sq_op_topright_mid_02);
		KillThread(s_thread_f_mer_sq_op_upperleft);
		KillThread(s_thread_f_mer_sq_op_right_interior);
		KillThread(s_thread_f_mer_sq_op_mid_01);
		KillThread(s_thread_f_mer_sq_op_rear_mid_01);
		game_save_no_timeout();
		CreateThread (audio_outpost_knightdead_music);
		sleep_s(4);
		CreateThread (f_shake_cam_elevator_02);
		device_set_position(OBJECTS.dm_exit_door_1, 0.56);
		CreateThread(f_mer_navmesh_exit_door_1);
		ObjectSetSpartanTrackingEnabled( OBJECTS.dm_exit_door_1, false ); -- disable tracking after activating door
		SleepUntil ([|	device_get_position (OBJECTS.dm_exit_door_1) > 0.50], 1);
		sleep_s(2);
		device_set_position(OBJECTS.dm_exit_door_2, 0.64);
		CreateThread(f_mer_navmesh_exit_door_2);
		ObjectSetSpartanTrackingEnabled( OBJECTS.dm_exit_door_2, false ); -- disable tracking after activating door
		CreateThread (f_navblip_exitoutpost);
		sleep_s(1);
		CreateThread(w1_meridian_1_gates_open);
		CreateThread(audio_outpost_end_music);
	end
end

function f_mer_navmesh_exit_door_1():void
	SleepUntil([|device_get_position (OBJECTS.dm_exit_door_1) > 0.50], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_exit_door_1, false);
end

function f_mer_navmesh_exit_door_2():void
	SleepUntil ([|	device_get_position (OBJECTS.dm_exit_door_2) > 0.60], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.dm_exit_door_2, false);
end

function f_spawn_turrets()
--waits until the turret button is pressed and places the turrets.
	SleepUntil([|device_get_position(OBJECTS.dc_gun_button) == 1], 1);
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_gun_button, false); -- disables tracking for this object after use
	ai_place(AI.sq_outpost_turrets);
	print("have some turrets");
	device_set_power(OBJECTS.dc_gun_button, 0);
	b_dc_gun_button_used = true;
	CreateThread(audio_activate_turret_a);
	game_save_no_timeout();
	sleep_s (2);
	Wake(dormant.w1_turret_turned_back_on);
	game_save_no_timeout();
end

function f_check_generator()
	SleepUntil([|object_get_health(OBJECTS.cr_outpost_generator) > 0], 1);
	damage_object(OBJECTS.cr_outpost_generator, "default", 45);
	--object_set_scale (OBJECTS.cr_outpost_generator, 1.5, 1); --remove this when they increase the size of the asset DLE
	SleepUntil([|object_get_health(OBJECTS.cr_outpost_generator) == 0], 1);
	game_save_no_timeout();
	b_any_gen_off = true;
	sleep_s(1);
	CreateThread (f_open_doors);
end
		
function f_check_gen_power_upper()
	repeat
		--SleepUntil([|device_get_position(OBJECTS.dc_generator_upper) > 0], 1);
		b_upper_power_off = true;
		--SleepUntil([|device_get_position(OBJECTS.dc_generator_upper) < 1], 1);
		b_upper_power_off = false;
	until(b_obj_any_gen_destroyed == true);
		b_upper_power_off = true;
end

function f_check_gen_power_lower()
	repeat
		--SleepUntil([|device_get_position(OBJECTS.dc_generator_lower) > 0], 1);
		b_lower_power_off = true;
		--SleepUntil([|device_get_position(OBJECTS.dc_generator_lower) < 1], 1);
		b_lower_power_off = false;
	until(b_obj_any_gen_destroyed == true);
		b_lower_power_off = true;
end

function f_any_power_check()
	repeat
		SleepUntil([|b_upper_power_off == true or b_lower_power_off == true], 1);
		print('either generator is off');
		b_any_gen_off = true;
		SleepUntil([|b_upper_power_off == false and b_lower_power_off == false], 1);
		b_any_gen_off = false;
	until(b_obj_any_gen_destroyed == true);
		b_any_gen_off = true;
end

function f_turn_off_generators()
	print('Checking generators');
	SleepUntil([|b_obj_any_gen_destroyed == true], 1);
	print('turn off generators');
	--device_set_power(OBJECTS.dc_generator_lower, 0);
	--device_set_power(OBJECTS.dc_generator_upper, 0);
end

function f_power_controls()
	repeat	
		SleepUntil([|b_any_gen_off == true], 1);
		device_set_power(OBJECTS.dc_gun_button, 0);
		ai_set_blind(AI.sq_outpost_turrets, true);
		ai_set_deaf(AI.sq_outpost_turrets, true);
		SleepUntil([|b_any_gen_off == false], 1);
		if b_dc_second_door_used == false then
			print ("nevermind");
		end
		if b_dc_gun_button_used == false then
			device_set_power(OBJECTS.dc_gun_button, 1);
		end
		ai_set_blind(AI.sq_outpost_turrets, false);
		ai_set_deaf(AI.sq_outpost_turrets, false);
	until(b_obj_any_gen_destroyed == true);
	device_set_power(OBJECTS.dc_gun_button, 0);
	ai_braindead(AI.sq_outpost_turrets, true);
end
	
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_* COMMAND SCRIPTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- Spawns the null turret AI, places them in the turrets, and opens them.

function cs_turret_1()
	ai_vehicle_reserve( OBJECTS.v_turret_1, false);
	ai_vehicle_enter_immediate( ai_current_actor, OBJECTS.v_turret_1); 
	unit_open(OBJECTS.v_turret_1);
	ai_braindead( ai_current_actor, false);
end

function cs_turret_2()
	ai_vehicle_reserve( OBJECTS.v_turret_2, false);
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_turret_2);
	unit_open(OBJECTS.v_turret_2);
	ai_braindead( ai_current_actor, false);
end

function cs_turret_3()
	ai_vehicle_reserve( OBJECTS.v_turret_3, false);
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_turret_3);
	unit_open(OBJECTS.v_turret_3);
	ai_braindead( ai_current_actor, false);
end

function cs_turret_4()
	ai_vehicle_reserve( OBJECTS.v_turret_4, false);
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_turret_4);
	unit_open(OBJECTS.v_turret_4);
	ai_braindead( ai_current_actor, false);
end

function cs_turret_5()
	ai_vehicle_reserve( OBJECTS.v_turret_5, false);
	ai_vehicle_enter_immediate(ai_current_actor, OBJECTS.v_turret_5);
	unit_open(OBJECTS.v_turret_5);
	ai_braindead( ai_current_actor, false);
end

--function cs_commander_killer()
--	cs_action_at_player(AI.sq_commander_killer, true, 0);
--	ai_erase(AI.sq_commander_killer);	
--end

function cs_front_marine_1()
	cs_crouch(ai_current_actor, true, 0);
end


-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*
-- *_*_*_*_*_*_*_*_*_ ENCOUNTER SCRIPTS *_*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*


--## CLIENT

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_*_*_ FX SCRIPTS *_*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



--                   o( @ ¸ @ )o 

-- 											                       -fin.