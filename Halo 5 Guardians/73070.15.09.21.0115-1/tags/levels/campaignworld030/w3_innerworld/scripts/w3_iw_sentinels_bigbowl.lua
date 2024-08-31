--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 Sentinels*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



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
--  ********************  			      GOAL 5 - TOWERS                *********************** --
--  **************************************************************************************** --
global n_TowerState:number = 0;
global n_Tower01_objcon:number = 0;
global n_Tower02_objcon:number = 0;
global core_count:number = 5;
global n_core_count_last:number = 99;
global b_core_right_front_active:boolean = false;
global b_core_right_front_dead:boolean = false;
global b_core_right_back_dead:boolean = false;
global b_core_left_front_dead:boolean = false;
global b_core_prime_dead:boolean = false;
global b_core_front_go:boolean = false;
global b_core_prime_active:boolean = false;
global b_core_prime_destroyed:boolean = false;
global b_core_prime_spawned:boolean = false;
global b_core_complete:boolean = false;
global b_big_door_opening:boolean = false;
global inside_coliseum:boolean = false;
global b_bowl_open_prime_console:boolean = false;
global n_sent_core_check_cheevo_count:number = 0;
global t_sen_cores:table = 
{
	"dc_core_first",
	"dc_core_left_back",
	"dc_core_left_front",
	"dc_core_right_back",
	"dc_core_right_front",
}

global t_sen_gryos:table = 
{
	"dm_core_first",
	"dm_core_left_back",
	"dm_core_left_front",
	"dm_core_right_back",
	"dm_core_right_front",
}

function core_living_count():number


	local count:number = 0;	
	for i, cores in ipairs(t_sen_cores) do
		if object_get_health( ObjectFromName( cores)) > 0 then
			count = count + 1;
		end
	end
	
	return count;
end

missionSentinels.goal_cores = 
	{
	gotoVolume = VOLUMES.tv_goal_coliseum,
	next={"goal_coliseum"},
	zoneSet = ZONE_SETS.zn_bowl,
	}


function missionSentinels.goal_cores.Start() :void		

	print ("goal_cores starting...");
	b_museShowStop = true;
		--	NARRATIVE CALL
	--CreateThread( f_bowl_entry_pause );
	CreateThread(sentinels_towers_wake);
	CreateThread (DoubleStuff);
	if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then
		CreateThread( f_sent_futurewarrior );
	end
	CreateThread(audio_sentinels_thread_up_cores_start);
	CreateThread(enemyDontShootCores);
	CreateThread( f_cores_muskeeter_helper_loop );
	CreateThread(f_bowl_snow_fx);
	CreateThread(f_stop_all_snow);
	object_create( "sn_coliseum_gap_blocker" );
	zone_set_trigger_volume_enable("begin_zone_set:zn_coliseum", false );	
	zone_set_trigger_volume_enable("zone_set:zn_coliseum", false );

	Sleep(5);

	game_save_no_timeout();
	print ("attempting to save...");
	
	f_bowl_create_all_tethers();
	


	Sleep(5);
	ai_disable_jump_hint(HINTS.jp_col_bowl_connection );
	sadpandatears();

	object_create_folder("mod_bbowl");

	CreateThread( f_setup_all_on_demand_vehicles );
	biped_ragdoll(OBJECTS.marine_zippy);
	biped_ragdoll(OBJECTS.marine_dan);	
	CreateThread(DeathEventCore);
	ai_place(AI.sg_core_empty_ghosts);
	CreateThread( f_core_front_stage );
	CreateThread(f_get_big_door_position);	
	sleep_s (5);
	CreateThread( f_setup_cov_shield_barrier );
	CreateThread( f_close_bowl_entrance_watcher );
	CreateThread( f_close_itty_bowl_door_side );

	garbage_collect_now();
	

	

	Wake( dormant.f_open_big_door );



	CreateThread( f_core_spawns );
	
	CreateThread( f_bowl_ghost_chasers );

	

	CreateThread(f_core_right_front_active);
	SleepUntil ([|core_count <= 3 ], 1);
		print("++++++++++++++ 3 cores left +++++++++++++++++++++");
		garbage_collect_now();
		game_save_no_timeout();
		
		
		Sleep(30);
		
	SleepUntil ([| core_count <= 1 ], 1);
	
		print("++++++++++++++ 1 cores left +++++++++++++++++++++");
		
		print("core count 1");
		garbage_collect_now();
		game_save_no_timeout();



	SleepUntil ([| core_count <= 0 ], 1);
		print("******* start prime *********");
		CreateThread(audio_sentinels_thread_up_cores_oneleft);
		CreateThread(audio_cryptum_powerdown);

	 	
		CreateThread( f_bowl_center_soldier_turrets);	
		garbage_collect_now();
		Sleep(5);
		game_save_no_timeout();


		Sleep(5);
		print("prime device machine active");

		b_core_prime_active = true;

		sleep_s(2);

		SleepUntil( [| volume_test_players( VOLUMES.tv_bowl_open_coliseum ) or b_bowl_open_prime_console] , 1 );
			print("prime area entered");
			game_save();
			f_bowl_prime_sequence();

	

end



function f_bowl_mark_front_failsafe()
	local l_timer:number = -1;
	
		l_timer = timer_stamp( 20 );	
		SleepUntil( [| timer_expired( l_timer ) or b_bowl_mark_front_set ] , 1 );		
		CreateThread( f_bowl_mark_front_core );
end

global b_bowl_mark_front_set:boolean = false;

function f_bowl_mark_front_core()
	if not b_bowl_mark_front_set then
		b_bowl_mark_front_set = true;
		object_destroy( OBJECTS.bowl_objective_enter);
		Sleep(5);
		ObjectiveShow (TITLES.obj_sen_3);
		if object_valid("dc_core_first") then
			ObjectSetSpartanTrackingEnabled(OBJECTS.dc_core_first, true); 
		end
		
		if  game_difficulty_get_real() ~= DIFFICULTY.legendary then
			CreateThread( f_core_ping_loop );
		end
		
		SleepUntil( [| volume_test_players(VOLUMES.tv_check_center ) ] , 1 );  -- backup in case player doesn't shoot first core. dialogue should actually call this
			f_bowl_mark_all_cores()
	end
end



function f_bowl_mark_all_cores()
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_core_left_back, true); 
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_core_left_front, true); 
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_core_right_back, true); 
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_core_right_front, true); 

end




function f_bowl_prime_sequence()
		--print("button alignment prime");
		b_core_prime_dead = true;
		b_core_prime_active = false;


		SlipSpaceSpawn( AI.sg_prime_console);

		CreateThread(audio_console_start);
		Sleep(5);

		device_set_position( OBJECTS.dm_core_prime, 1 );
		
	SleepUntil ([| device_get_position(OBJECTS.dm_core_prime) >= 0.99 ], 1);
			
		
		object_create("dc_core_prime_button");
		Sleep(3)
		print("button ACTIVATE! Form of: bucket o water");
		device_set_power( OBJECTS.dc_core_prime_button, 1 );

		ObjectOverrideNavMeshCutting( OBJECTS.dm_core_prime, true );
		Sleep(3);
		
		

	SleepUntil ([| g_core_prime_action_done ], 1);

		zone_set_trigger_volume_enable("begin_zone_set:zn_coliseum", true );	
		object_destroy(OBJECTS.bowl_objective_button);
		object_destroy(OBJECTS.bowl_objective_clear);
		Sleep(2);

		object_create( "bowl_objective_go_in_coliseum" );
		CreateThread(audio_sentinels_thread_up_cores_end);
		sleep_s(7);
		zone_set_trigger_volume_enable("zone_set:zn_coliseum", true );
		

		
		sleep_s(3);
		CreateThread( f_bowl_restart_comp_endgame );
		Sleep(5);
		CreateThread(fx_cryptum_shield_kill);
		object_destroy( OBJECTS.sn_coliseum_gap_blocker );
		b_core_prime_destroyed = true;
		
		CreateThread( f_core_coliseum_state_continue );
		CreateThread( f_bowl_sassy_prime_sequence );
		CreateThread(audio_console_stop);
		ai_enable_jump_hint(HINTS.jp_col_bowl_connection );
		f_bowl_open_please_dear();
		sleep_s(3);
		CreateThread(fx_cryptum_shield_kill);
		b_core_prime_destroyed = true;		
		ObjectiveShow (TITLES.obj_sen_4);

		--print("player entered sassyville");
	
		garbage_collect_now();
		
		sleep_s(3);
		
		CreateThread( f_bowl_cover_trail );

		game_save();
		StopEffectGroup(EFFECTS.fx_monitor_open_col);
		n_endgame_state = 1;
		print("Completed opening coliseum");
end

function f_bowl_access_area_marker()

	object_create("bowl_objective_clear");
	b_bowl_open_prime_console = true;
end


function f_bowl_open_please_dear()

		if not composer_show_is_playing( vin_endgame ) then
			Sleep(1);
			print("coliseum is not playing...that's bad...restarting");
			vin_endgame =	composer_play_show ("vin_w3_endgame");

		end
end

function f_bowl_restart_comp_endgame()

			composer_stop_show (vin_endgame);
			vin_endgame =	composer_play_show ("vin_w3_endgame");
		
end

function f_bowl_access_control_marker()

	object_destroy(OBJECTS.bowl_objective_clear);
	Sleep(2);
	object_create("bowl_objective_button");
end





global g_core_prime_comp = nil;
global g_core_prime_action_done:boolean = false;
global g_core_prime_ics_vignette_begin:boolean = false;
function f_activator_get_sentinels(trigger:object, activator:object):void
	local this_activator:object = activator or PLAYERS.player0 ;
	--	NARRATIVE CALL
	CreateThread(Sentinels__TOWERS__last_button_interacted, this_activator);

	device_set_power( OBJECTS.dc_core_prime_button, 0 );
	g_core_prime_comp = composer_play_show("vin_w3_center_console_ics", { ics_player = this_activator});
		print("prime switch pushed");
	CreateThread( f_prime_button_action );
	--	composer_play_show("vin_player_ics_banshee_room_02", { ics_player = this_activator});
		

end
 
function f_prime_button_action()
	local l_timer:number = timer_stamp( 12 );
	SleepUntil( [| not composer_show_is_playing ( g_core_prime_comp )  or timer_expired(l_timer  )] ,1 );
		print("yay f_prime_button_action done ");
		g_core_prime_action_done = true;

		sleep_s(1)
		DeviceLayerPlayAnimation(OBJECTS.dm_core_prime, 2, "vin_w3_innerworld_center_console_close", 30);
end

function f_core_prime_ics_start_set()
	print("ics has started");
	g_core_prime_ics_vignette_begin = true;
	DeviceLayerPlayAnimation(OBJECTS.dm_core_prime, 2, "vin_w3_innerworld_center_console_interact", 30);
end

function f_bowl_cover_trail()

	device_set_position( OBJECTS.dm_bowl_trail_05, 1);
	device_set_position( OBJECTS.dm_bowl_trail_06, 1);


end


function f_bowl_center_soldier_turrets()
	SleepUntil( [| volume_test_players( VOLUMES.tv_check_center ) ] , 1 );	
		SlipSpaceSpawn( AI.sq_c_for04_sold_01 );
		SlipSpaceSpawn( AI.sq_c_for04_knights_01 );	
		SlipSpaceSpawn( AI.sq_c_for04_knights_02 );	
		SlipSpaceSpawn(AI.sq_c_for01);

	SleepUntil( [| ai_living_count( AI.sg_core_center_cov ) <= 12 ] , 1 );
		
		SlipSpaceSpawn(AI.sq_c_for02);
		SlipSpaceSpawn(AI.sq_c_for03);
		sleep_s(5);
		print("prime all spawned");
		b_core_prime_spawned = true;
end



--this is  called when the task opens up
function shade_1_enter_turret_task():boolean	

		ai_vehicle_enter ( AI.sq_c_for03.a, OBJECTS.shade01_center_01 );
		return true;
end
--this is  called when the task opens up
function shade_2_enter_turret_task():boolean	

		ai_vehicle_enter ( AI.sq_c_for02.a, OBJECTS.shade01_center_02 );
		return true;
end


function grunt_shade_enter_turret_task():boolean	

		ai_vehicle_enter ( AI.sq_c_cov06.b, OBJECTS.shade01_center_02 );
		ai_vehicle_enter ( AI.sq_c_cov06.a, OBJECTS.shade01_center_01 );
		return true;
end

function grunt_shade_1_enter_turret_task():boolean	

		ai_vehicle_enter ( AI.sq_c_cov05.a, OBJECTS.shade01_center_01 );
		return true;
end

function dormant.f_open_big_door()
	device_set_position (OBJECTS.dm_lb_gate03, 1);
	ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_gate03, false );
	b_itty_done = true;
end

function f_get_big_door_position()
	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_jump)],1);
		b_big_door_opening = true;

end



function f_close_itty_bowl_door_side()
	SleepUntil( [| volume_test_players( VOLUMES.tv_bowl_front_fight_go ) ], 1);		
		device_set_position (OBJECTS.dm_lb_gate02, 0);
		SleepUntil( [| device_get_position(OBJECTS.dm_lb_gate02 ) == 0 ] , 3 );
			ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_gate02, true );
			Sleep(5);
			f_volume_teleport_all_inside (VOLUMES.tv_check_bring_past_door, FLAGS.fl_bowl_bring_forward);	
end

function f_close_bowl_entrance_watcher()


	SleepUntil( [| ( volume_test_players(VOLUMES.tv_bowl_leaving_intro_area) or core_count <= 4 or volume_test_objects_all(VOLUMES.tv_bowl_in_intro_area, spartans()) ) and b_big_door_opening ] , 3 );
		sleep_s(1);
		f_close_bowl_entrance();
end

function f_close_bowl_entrance()
	
	--backup vista fx killing
	CreateThread (fx_vista_snow_kill);
	print ("killing vista FX");	
	
	f_volume_teleport_all_inside (VOLUMES.tv_check_bring_past_door, FLAGS.fl_bowl_bring_forward);	
	

		ObjectOverrideNavMeshCutting( OBJECTS.dm_lb_gate03, true );
		device_set_power (OBJECTS.dm_lb_gate03, 0);
		Sleep(10);
		object_destroy_folder( "lil_big_airlock" );
		object_destroy (OBJECTS.dm_lb_mid_gate);	

		--safety for anyone trying to mess with getting past closing door
		SleepUntil( [| device_get_position(OBJECTS.dm_lb_gate03 ) == 0 ] , 3 );
			f_volume_teleport_all_inside (VOLUMES.tv_check_bring_past_door, FLAGS.fl_bowl_bring_forward);	
				ai_erase(AI.sg_lb_all_enemies);
				ai_erase(AI.sg_lb_all);
				object_destroy_folder("mod_lilbowl");
				
			if not volume_test_objects( VOLUMES.tv_bowl_in_intro_area, ai_get_object( f_sent_get_sassy() ) )then
				object_teleport( ai_get_object( f_sent_get_sassy()), POINTS.ps_monitor_bigbowl.pfailsafe_enter);

				print("force bumping sassy");


				
			end
		SleepUntil( [| b_core_front_go ] , 1 );		
			sleep_s(1);	
			cs_run_command_script( f_sent_get_sassy(), "f_monitor_bigbowl" );
			
end

function  missionSentinels.goal_cores.End() :void		

end
function  missionSentinels.goal_cores.Cleanup() :void		

	b_core_complete = true;
end
function f_core_spawns()


	ai_place(AI.sg_core_center_cov);
	ai_place(AI.sg_core_left_front_for);

	CreateThread( f_core_right_front_spawn );
	CreateThread( f_core_right_back_spawn );
	
	CreateThread( f_core_left_back_spawn );
	CreateThread( f_core_left_front );
	CreateThread( f_bowl_center_cov_reinforce );
	--ai_place(AI.sg_core_right_back_cov);
end

function f_bowl_center_cov_reinforce()

		SleepUntil ([|ai_living_count(AI.sg_core_center_cov) <= 2 or core_count <= 2 ], 1);	
		CreateThread(audio_sentinels_thread_up_cores_3to4);
			print("wraith reinforce");
			ai_place( AI.sq_ai_phantom_01 );
			sleep_s(20);
		SleepUntil ([| core_count <= 0 ], 1);		
			if coop_players_4() or f_bowl_mantis_count() > 1 then
				ai_place( AI.sq_ai_phantom_02 );
			end		
			
end




function DeathEventCore()
	CreateThread(MADHAXXOR);
	
	for _, core in ipairs( t_sen_cores ) do

		ai_object_set_team( ObjectFromName (core), TEAM.brute );
		ai_object_enable_targeting_from_vehicle(ObjectFromName (core), true );
	end
	
	RegisterDeathEvent(DeathTest,OBJECTS.dc_core_first );
	RegisterDeathEvent(DeathTest,OBJECTS.dc_core_left_back);
	RegisterDeathEvent(DeathTest,OBJECTS.dc_core_left_front);
	RegisterDeathEvent(DeathTest,OBJECTS.dc_core_right_back);
	RegisterDeathEvent(DeathTest,OBJECTS.dc_core_right_front);
	
	CreateThread( f_core_turn_off_gyro_power, OBJECTS.dc_core_first, OBJECTS.dm_core_first, EFFECTS.fx_power_core1_to_cryptum_energy03 );
	CreateThread( f_core_turn_off_gyro_power, OBJECTS.dc_core_left_back, OBJECTS.dm_core_left_back, EFFECTS.fx_power_core1_to_cryptum_energy01 );
	CreateThread( f_core_turn_off_gyro_power, OBJECTS.dc_core_left_front, OBJECTS.dm_core_left_front, EFFECTS.fx_power_core1_to_cryptum_energy02 );
	CreateThread( f_core_turn_off_gyro_power, OBJECTS.dc_core_right_back, OBJECTS.dm_core_right_back, EFFECTS.fx_power_core1_to_cryptum_energy );
	CreateThread( f_core_turn_off_gyro_power, OBJECTS.dc_core_right_front, OBJECTS.dm_core_right_front, EFFECTS.fx_power_core1_to_cryptum_energy04 );

end


function f_bowl_create_all_tethers()

	CreateEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy);
	CreateEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy01);
	CreateEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy02);
	CreateEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy03);
	CreateEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy04);
end

function f_bowl_kill_all_tethers()

	StopEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy);
	StopEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy01);
	StopEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy02);
	StopEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy03);
	StopEffectGroup(EFFECTS.fx_power_core1_to_cryptum_energy04);
end



--HAXHERE fix for reals
function MADHAXXOR()
	CreateThread(HAXCORE, OBJECTS.dc_core_first );
	CreateThread(HAXCORE, OBJECTS.dc_core_left_front );
	CreateThread(HAXCORE, OBJECTS.dc_core_left_back );
	CreateThread(HAXCORE, OBJECTS.dc_core_right_back );
	CreateThread(HAXCORE, OBJECTS.dc_core_right_front );
end

function MADHAXXORPRIME()
	CreateThread(HAXCORE, OBJECTS.dc_core_prime );
end

function HAXCORE(core:object)
print("setupmadHAX");
	SleepUntil ([|object_get_health(core) < 0.05 ], 1);	
	print("haxboom");
	damage_object( core, "default", 10000 );
	sleep_s(1);

	sleep_s(1);
	object_destroy(core);
end


global groundpoundStringID = get_string_id_from_string("ground_pound");
----------------------------------
function DeathTest(core:object , killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64  )
	print("count update ", core);
	core_count = core_count - 1;
	n_sent_core_check_cheevo_count = n_sent_core_check_cheevo_count + 1;    

	if groundpoundStringID == damageType then
		print( "GROUND POUND CORE ACHIEVEMENT UNLOCKED!!!!" );
		CampaignScriptedAchievementUnlocked( 23 ) ;
	end
	
	fx_cryptum_shield_reaction();
	game_save_no_timeout();
	print(core_count);
	--sleep_s(5);

end


function DoubleStuff()
		local n_current_core_count:number = core_count;
		
		if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then
		
			
			CreateThread( f_check_for_coop_cheevo );
		
		elseif game_difficulty_get_real() == DIFFICULTY.normal or game_difficulty_get_real() == DIFFICULTY.easy then
	
			print ("not on heroic or legendary, no cheevo for you");

		end			
end

function f_check_for_coop_cheevo()

	repeat 
		SleepUntil( [|n_sent_core_check_cheevo_count  > 0 ], 1 );
			sleep_s(3);
	
		if n_sent_core_check_cheevo_count >= 2 then
			print( "COOP ACHIEVEMENT UNLOCKED!!!!" );
			CampaignScriptedAchievementUnlocked( 24 ) ;
		end
			n_sent_core_check_cheevo_count = 0;
	until false;

end



function f_core_ping_loop( )
	local l_timer:number = -1;
	
	CreateThread( TutorialShowAll , "training_ping", 5 );
	
	repeat
		l_timer = timer_stamp( 60 );
		n_core_count_last = core_count;
		--print("xoxo loop ping begin");
		SleepUntil( [| timer_expired(l_timer) or n_core_count_last > core_count or g_core_prime_action_done or b_core_complete] ,3 );
		--	print("xoxo loop ping check");
			
		
		if n_core_count_last > core_count then
			sleep_s( 3 );
		end
		
		if not g_core_prime_action_done then
		
			
			if ( b_bowl_open_prime_console and core_count <= 0 )  or  ( not b_bowl_open_prime_console and core_count > 0 ) then
				
				CreateThread( TutorialShowAll , "training_ping", 5 );
		--		print("xoxo succesful loop ping reminder");
			end
			
		end
		
		Sleep(5);
	until g_core_prime_action_done or b_core_complete;
end

function debug_kill_all_cores()
	for i = 1, 5 do
		CreateThread( DeathTest );
		sleep_s(1);
	end
end

function f_core_turn_off_gyro_power( core:object, gyro:object, tether:effect_placement )
	object_wake_physics( core );
	SleepUntil( [| object_get_health( core ) <= 0 ], 1 );
		StopEffectGroup(tether);

		sleep_s(1.5);
		DeviceLayerPlayAnimation(gyro, 1, "any:destroyed", 30);
		

		sleep_s( 3 );
	
		device_set_power( gyro , 0);

end



function getitworking()

	f_core_turn_off_gyro_power( OBJECTS.dc_core_first, OBJECTS.dm_core_first,  EFFECTS.fx_power_core1_to_cryptum_energy03 );
end



function f_core_coliseum_state_continue()
	local l_timer = timer_stamp(30);
	
	SleepUntil ([|volume_test_players(VOLUMES.tv_coliseum_proximity) ], 1);	
		print("setting continue coliseum stat");
		b_coliseum_continue = true;
end

function core_pelican_init()	

end




function f_core_front_stage()
	SleepUntil( [| volume_test_players(VOLUMES.tv_bowl_front_fight_go) ], 1);
		--print("ambush");
		print("front core go");
		b_core_front_go = true;
		ai_place(AI.sq_ai_phantom_intro);
		sleep_s(1);
		

end

function f_core_right_front_spawn()
	SleepUntil( [| volume_test_players(VOLUMES.tv_core_right_front_spawn) ], 1);
		ai_place(AI.sg_core_right_front_cov);

end




function f_core_right_front_active(  )
	sleep_s(3);
	SleepUntil( [| object_get_health(OBJECTS.dc_core_right_front) < 1  or volume_test_players(VOLUMES.tv_core_right_front_mid)], 1);
		print("right front active");
		b_core_right_front_active = true;
		ai_place(AI.sg_core_right_front_cov_ambush);
	SleepUntil ([|object_get_health(OBJECTS.dc_core_right_front) <= 0.00 ], 5);	
		b_core_right_front_dead = true;
end

function cs_limbo_ambush()
	SleepUntil( [| b_core_right_front_active ], 1);
		--print("ambush");
		ai_exit_limbo( ai_current_actor);
end



function f_core_right_back_spawn()
	ai_place( AI.sg_core_right_back_cov_early );
	SleepUntil( [| volume_test_players(VOLUMES.tv_core_right_back_spawn_01) or volume_test_players( VOLUMES.tv_core_right_back_spawn_02 ) ], 1);
		ai_place(AI.sg_core_right_back_cov);
	SleepUntil ([|object_get_health(OBJECTS.dc_core_right_back) <= 0.00 ], 5);	
		b_core_right_back_dead = true;
end

function f_core_left_back_spawn()
	SleepUntil( [| volume_test_players(VOLUMES.tv_core_left_back_spawn_outer)  or object_get_health(OBJECTS.dc_core_left_back) < 1], 1);
		SlipSpaceSpawn(AI.sq_bowl_lb_for03_turret_a);
		sleep_s(0.5);
		SlipSpaceSpawn(AI.sq_bowl_lb_for03_turret_b); -- commenting out to reduce the number of vehicles spawned at once
		sleep_s(.5);

		SlipSpaceSpawn(AI.sq_bowl_lb_for04_turret_b);
		sleep_s(0.5);
		SlipSpaceSpawn( AI.sq_bowl_lb_for02 );
		sleep_s(0.5);
		SlipSpaceSpawn(AI.sq_bowl_lb_for05_turret_c);	

end

function cs_phase_in_turret()
	cs_phase_in();
	
end

function f_core_left_front()
	SleepUntil( [| object_get_health(OBJECTS.dc_core_left_front) <= 0.98], 1);
		if  coop_players_3()  then
			SlipSpaceSpawn( AI.sq_bowl_lf_for05_legendary );  --comin to get ya!
			SlipSpaceSpawn ( AI.sq_bowl_lf_for04 );
		end
		
		
		SlipSpaceSpawn( AI.sq_bowl_lf_for03 );
		SlipSpaceSpawn( AI.sq_bowl_lf_for06 );
		
		if  coop_players_4()  then
			sleep_s(3);
			SlipSpaceSpawn( AI.sq_bowl_lf_for07 );  
			SlipSpaceSpawn ( AI.sq_bowl_lf_for05 );
			
				
			SlipSpaceSpawn ( AI.sq_bowl_lf_for08 );

		end
		
	SleepUntil( [| object_get_health(OBJECTS.dc_core_left_front) <= 0.1], 1);
		b_core_left_front_dead = true;
end

function test_right_front()
	b_core_right_front_active = false;
	object_destroy(OBJECTS.dc_core_right_front);
	Sleep(3);
	object_create("dc_core_right_front");
	Sleep(3);
	CreateThread(f_core_right_front_active);
	CreateThread( f_core_right_front_spawn );

end

function sadpandatears()

	object_cinematic_visibility( OBJECTS.dm_col_roof, true );
end

function f_setup_all_on_demand_vehicles()

--tv_on_demand_veh_01
	CreateThread(f_setup_on_demand_vehicles, "bowl_on_demand_veh_01", VOLUMES.tv_on_demand_veh_01 );
	CreateThread(f_setup_on_demand_vehicles, "bowl_on_demand_veh_02", VOLUMES.tv_on_demand_veh_02 );
end


function f_setup_on_demand_vehicles( veh:string, tv:volume)

	SleepUntil( [| volume_test_players(tv)  ], 1);	
		object_create(veh);
end

global MAX_CHASERS_SPAWN:number = 14;
global total_chasers_spawned:number = 0;

function f_bowl_ghost_chasers()
	--If prime core is not active then spawn
	--SleepUntil we need them
	--Find a safe place to spawn
	--SleepUntil they are mostly gone
	--wait a certain amount of time
	
	local ghost_squad:ai = nil;
	SleepUntil ([| core_count <= 3 ], 1 );
	
		repeat
			Sleep(1);
			if not ( b_core_prime_active or b_core_prime_dead )  then
				print("waiting to add ghost chasers");
					
					
					--print
						
						ghost_squad = f_bowl_get_ghost_chaser();
						
						if ghost_squad and  not ( b_core_prime_active or b_core_prime_dead ) then
							print("got a valid ghost spawn location");
							
							if game_is_cooperative() then
								ai_place( ghost_squad );
								total_chasers_spawned = total_chasers_spawned + 2;
							else
								ai_place( ghost_squad,1 );
								total_chasers_spawned = total_chasers_spawned + 1;
							end
						else
							print("GHOST SQUAD IS NIL OR PRIME CORE HAS BEEN ACTIVATED, ABORT SPAWNING!");
						end
				SleepUntil ([| ( ai_task_count( AI.obj_bowl_chasers.chase_ghost ) <= 0 and ai_living_count(AI.sg_cores_all ) <= 36) or b_core_complete ], 1 );	
						print("start chaser re-timer ,");
						sleep_rand_s( 120,170 );
						garbage_collect_now();
			end
		until  b_core_prime_active or b_core_prime_dead or (  total_chasers_spawned >= MAX_CHASERS_SPAWN ) or b_core_complete;
end

function f_bowl_get_ghost_chaser():ai

	local ghost_squad:ai = nil;
	
	repeat
		Sleep(10)
			if not volume_test_players(VOLUMES.tv_check_front) then
				ghost_squad = AI.sq_bowl_ghost_chaser_02;
			elseif	not volume_test_players(VOLUMES.tv_check_left_under) then
				ghost_squad = AI.sq_bowl_ghost_chaser_04;
			elseif	not volume_test_players(VOLUMES.tv_check_right_back) then
				ghost_squad = AI.sq_bowl_ghost_chaser_01;
			--elseif	not volume_test_players(VOLUMES.tv_check_left_crashsite) then
			--	ghost_squad = AI.sq_bowl_ghost_chaser_03;			

			--
			end
		--print(AnyUnitCanSeePoint( players(), POINTS.ps_bowl_chaser_spawns.spawn_loc_2a, 15 ));
	until ghost_squad ~= nil or b_core_prime_active or b_core_prime_dead or b_core_complete;
	return ghost_squad;
end




function f_bowl_phantom_01_drop()

	
	if ai_living_count( AI.sq_c_cov04 ) <= 1 then
		f_load_drop_ship (AI.sq_ai_phantom_01, AI.sg_core_center_cov_drop_02, true, false, "left");
	end
	f_load_drop_ship (AI.sq_ai_phantom_01, AI.sg_core_center_cov_drop_01, true, false, "right");

	local wraith_squad:ai = nil;
	if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
		wraith_squad = AI.sq_c_cov01_wraith_normal;
	else
		wraith_squad = AI.sq_c_cov01_wraith;
	end
	ai_place( wraith_squad );
	print(ai_living_count ( wraith_squad ));

	

	vehicle_load_magic( ai_vehicle_get_from_squad(AI.sq_ai_phantom_01) , "phantom_mc01", ai_vehicle_get_from_squad(wraith_squad, 0)  );


	cs_vehicle_speed( 1.0 );

	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); --Shrink size over time
	ai_exit_limbo (AI.sq_ai_phantom_01);
		cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p01, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 4* 60 ); --Shrink size over time




	print ("everything is ready for phantom. moving out now");

	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p02, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p05, 0);

	cs_vehicle_speed( 0.5 );

	cs_fly_to (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pdock, 0);
	cs_vehicle_speed( 0.3 );
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pdock, POINTS.ps_bowl_phantom_path_01.pface, 0);
	f_unload_drop_ship(AI.sq_ai_phantom_01);
	sleep_s (3);
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pdock2, POINTS.ps_bowl_phantom_path_01.pface, 0);
	CreateThread( grunt_shade_enter_turret_task );
	f_unload_drop_ship_vehicle(AI.sq_ai_phantom_01);
	vehicle_unload( ai_vehicle_get_from_squad (AI.sq_ai_phantom_01), "phantom_mc01")
		sleep_s (3);

	cs_vehicle_speed( 0.5 );
	
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p08, 4);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p09, 4);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p10, 4);
	
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pexit, 0);
	sleep_s (6);
	ai_erase (AI.sq_ai_phantom_01);
end


function f_bowl_phantom_02_drop()

	local wraith_squad:ai = nil;
	if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
		wraith_squad = AI.sq_c_cov02_wraith_normal;
	else
		wraith_squad = AI.sq_c_cov02_wraith;
	end

	ai_place(wraith_squad);
	print(ai_living_count (wraith_squad));

	vehicle_load_magic( ai_vehicle_get_from_squad(AI.sq_ai_phantom_02) , "phantom_mc02", ai_vehicle_get_from_squad(wraith_squad, 0)  );

	cs_vehicle_speed( 1.0 );

	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); --Shrink size over time
	ai_exit_limbo (AI.sq_ai_phantom_02);
		cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p01, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 4* 60 ); --Shrink size over time




	print ("everything is ready for phantom. moving out now");

	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p02, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p05, 0);

	cs_vehicle_speed( 0.5 );

	cs_fly_to (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pdock, 0);
	cs_vehicle_speed( 0.3 );
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pdock, POINTS.ps_bowl_phantom_path_01.pface, 0);


	f_unload_drop_ship_vehicle(AI.sq_ai_phantom_02);
	vehicle_unload( ai_vehicle_get_from_squad (AI.sq_ai_phantom_02), "phantom_mc02")
		sleep_s (8);

	cs_vehicle_speed( 0.5 );
	
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p08, 4);
	sleep_s (5);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p09, 4);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.p10, 4);
	
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_path_01.pexit, 0);
	sleep_s (6);
	ai_erase (AI.sq_ai_phantom_02);
end


function f_bowl_phantom_intro()

	

	--f_load_drop_ship (AI.sq_ai_phantom_intro, AI.sq_bowl_f_cov01, true, false, "right");
	--f_load_drop_ship (AI.sq_ai_phantom_intro, AI.sq_bowl_f_cov02, true, false, "left");
	f_load_phantom_left(AI.sq_ai_phantom_intro, AI.sq_bowl_f_cov01.spawnpoint,AI.sq_bowl_f_cov01.spawnpoint24, AI.sq_bowl_f_cov01.spawnpoint33, nil, true);
	f_load_phantom_right(AI.sq_ai_phantom_intro, AI.sq_bowl_f_cov02.spawnpoint25,AI.sq_bowl_f_cov02.spawnpoint24, AI.sq_bowl_f_cov02.spawnpoint, nil, true); 
	ai_exit_limbo (AI.sq_ai_phantom_intro);
	cs_vehicle_speed( 0.8 );
	cs_fly_to (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.p0, 0);
	
	

	print ("everything is ready for phantom. moving out now");
	


	cs_vehicle_speed( 0.8 );

	cs_vehicle_speed( 0.65 );
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.pdock, POINTS.ps_bowl_phantom_intro.pface, 0);
	cs_vehicle_speed( 0.4 );
	SlipSpaceSpawn(AI.sq_bowl_f_for03);
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.pdock, POINTS.ps_bowl_phantom_intro.pface, 0);


	SlipSpaceSpawn(AI.sq_bowl_f_for02);
	f_unload_drop_ship(AI.sq_ai_phantom_intro);



	sleep_s (5);

	cs_vehicle_speed( 0.5 );
	
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.p06, 4);
	--sleep_s (5);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.p03, 4);
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.p04, 4);
	
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 6*60 ); --Shrink size over time
	cs_fly_by (ai_current_actor, true, POINTS.ps_bowl_phantom_intro.pexit, 0);
	sleep_s (6);
	ai_erase (AI.sq_ai_phantom_intro);
end



-- called from task
function f_cores_hop_in_ghost():boolean
	--print("hi");
	sleep_s(2);
	if AI.sq_bowl_f_for03   then
		print( ai_vehicle_get_from_spawn_point(AI.sg_cov_empty_ghost_01.empty) );
		if  object_get_health( ai_vehicle_get_from_spawn_point(AI.sg_cov_empty_ghost_01.empty) ) > 0 then

			if random_range (1 , 100 ) < 33 then
				--print("hop in ghost");
				ai_vehicle_enter( AI.sq_bowl_f_for03 , ai_vehicle_get_from_spawn_point(AI.sg_cov_empty_ghost_01.empty));
			end
		end
	end
	return true;
end

global b_in_a_mantis:boolean = false;
function f_bowl_player_in_a_mantis():void
	local b_in_a_vehicle:boolean = false;
	local b_in_a_mantis:boolean = false;
	local spartan_vehicle_owner
	repeat

		
		for _, spartan in ipairs ( spartans() ) do
			if unit_in_vehicle ( spartan ) then
			
				if unit_get_vehicle(spartan  ) == OBJECTS.v_mantis_deff or 
					unit_get_vehicle(spartan  ) == OBJECTS.v_mantis_dred  then
				
					b_in_a_mantis = true;
					print("true");
				
					break;
				end
			else
				print("false");
				b_in_a_mantis = false;
			end
		end
		
	
	sleep_s(1.5);
	until b_core_complete;

end


--


function f_bowl_mantis_count():number
	local b_in_a_vehicle:boolean = false;
	local n_mantis_count:number = 0;



		
		for _, spartan in ipairs ( spartans() ) do
			if unit_in_vehicle ( spartan ) then
			
				if unit_get_vehicle(spartan  ) == OBJECTS.v_mantis_deff or 
					unit_get_vehicle(spartan  ) == OBJECTS.v_mantis_dred  then
				
					n_mantis_count = n_mantis_count + 1;

				end
			end
		end
		
	
	return n_mantis_count;

end

function cs_camo_foreever()

	Sleep(120);
	ai_set_active_camo( ai_current_actor , true );
end

function f_sent_futurewarrior()
	object_create( "cr_future_warrior");
	Sleep(15)
	SleepUntil( [| 	object_get_health( OBJECTS.cr_future_warrior ) <= 0 ] ,1 );
	
	if IsPlayer(SPARTANS.locke) and unit_has_weapon_readied(SPARTANS.locke, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon')) then
			print("visions of future warrior, can you catch him?");
			SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
			CreateEffectGroup(EFFECTS.fx_future_warrior_1);
			sleep_s(2);
			StopEffectGroup(EFFECTS.fx_future_warrior_1);
			sleep_s(2);
			CreateEffectGroup(EFFECTS.fx_future_warrior_2);
			sleep_s(2);
			ai_place(AI.sg_cov_el_gigante);
			sleep_s(2);
			StopEffectGroup(EFFECTS.fx_future_warrior_2);
	end
	
		local l_timer:number = timer_stamp( 45 );
		SleepUntil( [| 	object_get_health( AI.sg_cov_el_gigante ) <= 0 or timer_expired( l_timer )] ,1 );
				if IsPlayer(SPARTANS.locke) and unit_has_weapon_readied(SPARTANS.locke, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon')) then
					if not timer_expired( l_timer ) then
						print("victory over the future warrior...good luck with the omelet king");
						SoundImpulseStartServer(TAG(' sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
						b_sent_omelet_king_unlock = true;
					else
						print("you have missed the future warrior");
					end
						
				end
				ai_kill( AI.sg_cov_el_gigante );
		
end

function f_bowl_snow_fx()
	
	CreateThread (fx_vista_snow_kill);
	print ("killing vista FX");	
	
	repeat 

	SleepUntil([|volume_test_players(VOLUMES.tv_bowl_snow_fx) or b_core_complete],1);

		RunClientScript("f_start_snow");
		sleep_s (0.2);
		
	SleepUntil([|not volume_test_players(VOLUMES.tv_bowl_snow_fx) or b_core_complete],1);

		RunClientScript("f_stop_snow");

	until inside_coliseum or b_core_complete;
end

function f_stop_all_snow()
	SleepUntil([|volume_test_players(VOLUMES.tv_goal_coliseum)],1);
		inside_coliseum = true;
end


------MUSKETEER LOGISTICS





function f_cores_musketeer_driving_util( waypoints:point_set, spacing:number )
	local spacing:number = spacing or 5;
	local nearest_active_core:object = OBJECTS.dm_core_first;
	
	for _, musket in ipairs (ai_actors(GetMusketeerSquad())) do
		
		if( MusketeerIsDrivingPlayer( musket )) then
			nearest_active_core = f_cores_get_next_core( musket );
			if nearest_active_core then
				MusketeerDestSetPoint( musket, nearest_active_core, spacing );

				for i = 1, #waypoints do
					MusketeerDestAddWayPoint( musket, waypoints[i]);
				end
			end
		else
			MusketeerDestClear( musket );
		end
	end
end 



function f_cores_get_next_core(musket:ai):object
	local musk_obj:object = musket ;
	local nearest_core_distance:number = 9999999;
	local this_core_distance:number = -1;
	local nearest_core:object = OBJECTS.dm_core_prime;
	

	for i, cores in ipairs(t_sen_cores) do
		local this_core:object = ObjectFromName( cores);
		if this_core and object_get_health( this_core) > 0 then
			
			
			this_core_distance = objects_distance_to_object(musk_obj , this_core );
			--print( "this core distance", this_core_distance, " ---- current nearest distance ", nearest_core_distance );
			if this_core_distance < nearest_core_distance then
				nearest_core = this_core;
				nearest_core_distance = this_core_distance;
			end
		end
	end
	--print("returning nearest core ", nearest_core );
	
	if nearest_core == OBJECTS.dc_core_right_front then
		if object_get_health( OBJECTS.cr_cov_shield_barrier_04 ) > 0 and object_get_health( OBJECTS.cr_cov_shield_barrier_03 ) > 0 and object_get_health( OBJECTS.cr_cov_shield_barrier_02 ) > 0 then --test all three shields?
			print("nearest core is protected by shield");
				nearest_core = OBJECTS.cr_cov_shield_barrier_04;
		end
	end
		
	return nearest_core;
end

function f_setup_cov_shield_barrier()
		local shield:object = nil;
		ai_object_set_team(OBJECTS.cr_cov_shield_barrier_04, TEAM.covenant);
		ai_object_set_team(OBJECTS.cr_cov_shield_barrier_03, TEAM.covenant);
		ai_object_set_team(OBJECTS.cr_cov_shield_barrier_02, TEAM.covenant);
		ai_object_enable_targeting_from_vehicle(OBJECTS.cr_cov_shield_barrier_04, true);
		ai_object_enable_targeting_from_vehicle(OBJECTS.cr_cov_shield_barrier_03, true);
		ai_object_enable_targeting_from_vehicle(OBJECTS.cr_cov_shield_barrier_02, true);

		ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.cr_cov_shield_barrier_02,""), true);
		ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.cr_cov_shield_barrier_03,""), true);
		ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.cr_cov_shield_barrier_04,""), true);	
		ai_object_set_team( object_at_marker(OBJECTS.cr_cov_shield_barrier_04,""), TEAM.covenant);
		ai_object_set_team( object_at_marker(OBJECTS.cr_cov_shield_barrier_03,""), TEAM.covenant);
		ai_object_set_team( object_at_marker(OBJECTS.cr_cov_shield_barrier_02,""), TEAM.covenant);	

end

function andnowthis()
	local shield:object = nil;
	shield = object_at_marker(OBJECTS.cr_cov_shield_barrier_02, "" );
	print( shield );
		ObjectOverrideNavMeshCutting( shield, false );
end

function f_cores_muskeeter_helper_loop()


	repeat
		f_cores_musketeer_driving_util( POINTS.ps_bowl_road_points, 8 ); 
		sleep_s(1);
	until n_endgame_state == 1 or b_core_complete;
end
------------------------------


--fun

--  **************************************************************************************** --
--  ********************  			      GOAL 6 - COLISEUM              *********************** --
--  **************************************************************************************** --



function wipeBigBowl()
	ai_erase(AI.sg_core_front);
	ai_erase(AI.sg_core_center_cov);
	ai_erase(AI.sg_core_left_front_cov);
	ai_erase(AI.sg_core_left_back_cov);
	ai_erase(AI.sg_core_right_front_cov);
	ai_erase(AI.sg_core_right_back_cov);
	ai_erase(AI.sg_core_right_back_for);
	ai_erase(AI.sg_core_left_back_for);
	ai_erase(AI.sg_core_left_front_for);
	ai_erase(AI.sg_bowl_enemy_all);
	ai_erase(AI.sg_cores_all );
	--object_destroy(OBJECTS.bowl_on_demand_veh_01 );
end


function f_bigbowl_cleanup()

	wipeBigBowl();
	object_destroy_folder("mod_bbowl");
end


function debug_cores()
	object_create_folder("mod_bbowl");
end



function cs_cores()
	unit_only_takes_damage_from_players_team(ai_get_object(ai_current_actor), true);
	object_hide(ai_get_object(ai_current_actor), true);
end

function enemyDontShootCores()
print("teamup");
	ai_allegiance(TEAM.forerunner, TEAM.brute);
	ai_allegiance(TEAM.covenant, TEAM.brute);
	ai_allegiance(TEAM.brute, TEAM.forerunner);
	ai_allegiance(TEAM.brute, TEAM.covenant);
end