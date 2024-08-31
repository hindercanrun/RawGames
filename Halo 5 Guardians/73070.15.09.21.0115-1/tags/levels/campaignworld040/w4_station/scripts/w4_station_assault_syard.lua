--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- Ship Yard
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------


global n_shipyard_objcon:number = 0;
global b_shipyard_is_for: boolean = false;
global b_shipyard_hardline_done: boolean = false;
global b_shipyard_begin:boolean = false;
global b_shipyard_part_2_begin:boolean = false;
global b_shipyard_end:boolean = false;


global t_shipyard_dead_marines:table =
{ 
	"ped_madrak",
	"ped_jarl",

};

AssaultOnTheStation.goal_shipyard = 

{
	gotoVolume = VOLUMES.tv_tunnels_init_01,
	zoneSet = ZONE_SETS.zs_02,
	next={"goal_tunnels"},
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	--checkPoints = POINTS.ps_intro_blink,
}



function blink_shipyard()
	ai_erase_all();

	CreateThread(audio_assault_stopallmusic);
	f_blink_clear_blips();
	b_shipyard_is_for = false;
	garbage_collect_now();
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_shipyard", FLAGS.fl_shipyard_1);
	--Wake(dormant.w4_assault_shipyard_init);
	

end


function blink_shipyard_2nd_half()
	ai_erase_all();
	switch_zone_set(ZONE_SETS.zs_02);
	CreateThread(audio_assault_stopallmusic);
	teleport_player_to_flag (PLAYERS.player0,FLAGS.fl_shipyard_5, false);
	teleport_player_to_flag (PLAYERS.player1,FLAGS.fl_shipyard_6, false);
	teleport_player_to_flag (PLAYERS.player2,FLAGS.fl_shipyard_7, false);
	teleport_player_to_flag (PLAYERS.player3,FLAGS.fl_shipyard_8, false);
	
	object_create_folder( "crs_shipyard");
	object_create_folder( "wpns_shipyard");
	Sleep(10);
	--object_create_folder( "wpns_shipyard");
	Wake(dormant.f_shipyard_objcon_controller);
	CreateThread( f_shipyard_2nd_spawns );
	n_shipyard_objcon = 50;
end





function AssaultOnTheStation.goal_shipyard.Start()
	
	--SleepUntil( [| volume_test_players(VOLUMES.tv_shipyard_init ) ],1);
		print("Shipyard init");
		CreateThread(AudioMissionSoundStart);
		f_intro_cleanup();
		garbage_collect_now();
		--AI.sg_yard_musketeer = 
		----assault_game_save_no_timeout();  --dont save on elevator
		--CreateThread( f_player_area_text , "Ship Yard");
		object_create_folder( "crs_shipyard");
		object_create_folder( "wpns_shipyard");
		CreateThread(nar_goal_assault_shipyard); 
		CreateThread( f_ship_objective_blips );
		Wake( dormant.f_shipyard_objcon_controller );
		Wake( dormant.f_shipyard_hardline_clear );
		--CreateThread( f_assault_place_dead_bodies, t_shipyard_dead_marines );
		CreateThread( f_shipyard_spawner );
		CreateThread( f_ship_save_beginning );
		CreateThread( f_assault_volume_tutorial_blocking_setup, VOLUMES.tv_shipyard_tut_bash, "training_charge", "training_chief_charge_01", true );
		
		GoalCreateThread( AssaultOnTheStation.goal_shipyard, f_assault_volume_dislay_tutorial_setup, VOLUMES.tv_shipyard_tut_gp_01, "training_groundpound", TUTORIAL.GroundPound, 6 );
		GoalCreateThread( AssaultOnTheStation.goal_shipyard, f_assault_volume_dislay_tutorial_setup, VOLUMES.tv_shipyard_tut_gp_02, "training_groundpound", TUTORIAL.GroundPound, 6 );
		GoalCreateThread( AssaultOnTheStation.goal_shipyard, f_assault_volume_dislay_tutorial_setup, VOLUMES.tv_shipyard_tut_gp_03, "training_groundpound", TUTORIAL.GroundPound, 6 );
		GoalCreateThread( AssaultOnTheStation.goal_shipyard, f_shipyard_delete_elevator );
		
		--CreateThread( f_assault_volume_tutotrial_setup, VOLUMES.tv_shipyard_tut_bash, "training_charge", true );
		GoalCreateThread( AssaultOnTheStation.goal_shipyard, f_assault_volume_dislay_tutorial_setup, VOLUMES.tv_shipyard_tut_thrust, "training_thruster", TUTORIAL.Thruster, 10 );
	SleepUntil( [| volume_test_players(VOLUMES.tv_shipyard_enter ) ],1);
		b_shipyard_begin = true;
		f_ship_objective();
		
		
		--
end


function f_ship_save_beginning()
	SleepUntil( [| volume_test_players(VOLUMES.tv_shipyard_tut_bash ) ],1);	
		print("...attempting save");
		assault_game_save_no_timeout();
end

function f_ship_objective_blips()
	sleep_s(3);
	object_create("sn_obj_shipyard_start");
	SleepUntil( [| volume_test_players(VOLUMES.tv_shipyard_enter ) ],1);		
		object_destroy(OBJECTS.sn_obj_shipyard_start);
		sleep_s(2);
		object_create("sn_obj_shipyard_mid");
	SleepUntil( [| volume_test_players(VOLUMES.tv_shipyard_top ) ],1);
		object_destroy(OBJECTS.sn_obj_shipyard_mid);
		sleep_s(2);
		object_create("sn_obj_shipyard_end");		
end

function f_ship_objective()
	--f_assault_complete_objective();
--	f_assault_set_objective( TITLES.ct_obj_assault_4, true );
end


function f_shipyard_spawner()
		if b_shipyard_is_for then		
			ai_place( AI.sg_yard_front );
		else
			ai_place( AI.sg_yard_front_cov );
			--CreateThread(AudioCheckEnemyCount, AI.sg_yard_front_cov, 1, audio_assault_thread_up_shipyard_combat_low);
		end
		CreateThread( f_shipyard_2nd_spawns );
end


function dormant.f_shipyard_hardline_clear()

	SleepUntil ([| n_shipyard_objcon >= 20  and  ( ai_task_count( AI.obj_yard_cov_front_elite.mid_elite ) + ai_task_count( AI.obj_yard_cov_front_elite.front_elite ) ) <= 1    ]  , 1);
		print("hardline crushed");
		b_shipyard_hardline_done = true;

end

function f_shipyard_2nd_spawns()
	SleepUntil ([| n_shipyard_objcon >= 50     ]  , 1);

		ai_place( AI.sg_yard_rear_1st );
		ai_place( AI.sg_yard_rear_ranger);
		if coop_players_3()  then
			ai_place( AI.sg_yard_rear_ranger_coop);
			ai_place( AI.sg_yard_rear_grunt_coop );
		end
		
		print("2nd half 1st wave");
		CreateThread(audio_assault_thread_up_shipyard_combat_secondwave);
		garbage_collect_now();
		Sleep(5);
		print(ai_living_count(AI.sg_yard_rear));
		CreateThread(nar_goal_assault_shipyard2); 
	SleepUntil ([| n_shipyard_objcon >= 70  or   ai_living_count( AI.sg_yard_rear )  <= 6    ]  , 1);
		print("2nd half 2nd wave");
		ai_place( AI.sg_yard_rear_res );
		--CreateThread(AudioCheckEnemyCount, AI.sg_yard_rear_res, 1, audio_assault_thread_up_shipyard_combat_low);
end

function dormant.f_shipyard_objcon_controller()

	print("shipyard objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_10 ) or n_shipyard_objcon >= 10 ], 1);
		if n_shipyard_objcon <= 10 then
			n_shipyard_objcon = 10;
			print("n_shipyard_objcon = 10 ");
		end

	

		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_20 ) or n_shipyard_objcon >= 20 ], 1);
		if n_shipyard_objcon <= 20 then
			n_shipyard_objcon = 20;
			print("n_shipyard_objcon = 20 ");
		end
		

		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_30 ) or n_shipyard_objcon >= 30 ], 1);
		if n_shipyard_objcon <= 30 then
			n_shipyard_objcon = 30;
			print("n_shipyard_objcon = 30 ");
		end		

		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_35 ) or n_shipyard_objcon >= 35 ], 1);
		if n_shipyard_objcon <= 35 then
			n_shipyard_objcon = 35;
			print("n_shipyard_objcon = 35 ");
		end	


	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_40 ) or n_shipyard_objcon >= 40 ], 1);
		if n_shipyard_objcon <= 40 then
			n_shipyard_objcon = 40;
			print("n_shipyard_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_50 ) or n_shipyard_objcon >= 50 ], 1);
		if n_shipyard_objcon <= 50 then
			n_shipyard_objcon = 50;
			print("n_shipyard_objcon = 50 ");
			
		end
		
		garbage_collect_now();
		assault_game_save_no_timeout();
		b_shipyard_part_2_begin = true;
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_55 ) or n_shipyard_objcon >= 55 ], 1);
		if n_shipyard_objcon <= 55 then
			n_shipyard_objcon = 55;
			print("n_shipyard_objcon = 55 ");
		end
		CreateThread( f_shipyard_musketeer_obj_0 );
			
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_60 ) or n_shipyard_objcon >= 60 ], 1);
		if n_shipyard_objcon <= 60 then
			n_shipyard_objcon = 60;
			print("n_shipyard_objcon = 60 ");
		end
			CreateThread( f_shipyard_musketeer_obj_1 );
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_70 ) or n_shipyard_objcon >= 70 ], 1);
		if n_shipyard_objcon <= 70 then
			n_shipyard_objcon = 70;
			print("n_shipyard_objcon = 70 ");
		end
			CreateThread( f_shipyard_musketeer_obj_2 );	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_75 ) or n_shipyard_objcon >= 75 ], 1);
		if n_shipyard_objcon <= 75 then
			n_shipyard_objcon = 75;
			print("n_shipyard_objcon = 75 ");
		end		

		CreateThread( f_shipyard_musketeer_obj_3 );
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_80 ) or n_shipyard_objcon >= 80 ], 1);
		if n_shipyard_objcon <= 80 then
			n_shipyard_objcon = 80;
			print("n_shipyard_objcon = 80 ");
		end		
		if game_difficulty_get_real() ~= DIFFICULTY.legendary then 
			game_save();
		end
		
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_90 ) or n_shipyard_objcon >= 90 ], 1);
		if n_shipyard_objcon <= 90 then
			n_shipyard_objcon = 90;
			print("n_shipyard_objcon = 90 ");
		end
		
		CreateThread( f_shipyard_musketeer_obj_4 );
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_100 ) or n_shipyard_objcon >= 100 ], 1);
		if n_shipyard_objcon <= 100 then
			n_shipyard_objcon = 100;
			print("n_shipyard_objcon = 100 ");
		end
		CreateThread( MusketeerUtil_SetDestination_Assault_Clear );
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_shipyard_objcon_110 ) or n_shipyard_objcon >= 110 ], 1);
		if n_shipyard_objcon <= 110 then
			n_shipyard_objcon = 110;
			print("n_shipyard_objcon = 110 ");
			CreateThread (audio_assault_thread_up_shipyard_combat_fade);
		end				
		
		assault_game_save_no_timeout();
end


function f_shipyard_delete_elevator()
	SleepUntil ([| volume_test_players_all ( VOLUMES.tv_shipyard_whole ) ], 1);
		print("deleting elevator");
		object_destroy(OBJECTS.dm_intro_elevator);

end


function f_shipyard_musketeer_obj_0()

	local b_tube_buddy_set:boolean = false;
	local b_tube_mid_set:boolean = false;

	
	for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
			
			if  not b_tube_buddy_set then
					b_tube_buddy_set = true;
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_mid, 3);
					print("Side");
			elseif not b_tube_mid_set then
					b_tube_mid_set = true;
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_top, 3);
					print("top");
			else
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_mid_2, 3);
					print("mid");
			end
			
	end	
	

end


function f_shipyard_musketeer_obj_1()

	local b_in_tube:boolean = volume_test_players( VOLUMES.tv_shipyard_tube );
	local b_tube_buddy_set:boolean = false;
	local b_tube_solo_set:boolean = false;

	if b_in_tube then
			for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
	
				if not b_tube_buddy_set then
						b_tube_buddy_set = true;
						--first musketeer will stay on follow in the tube
				--elseif not b_in_tube and not b_tube_solo_set then
					--	b_tube_solo_set = true;
					--	MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_tube_01, 2);
				else
						MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_01, 7);
				end
			end
			
	else
		MusketeerUtil_SetDestination_Assault_Clear()
	end
	
end




function f_shipyard_musketeer_obj_2()

	local b_in_tube:boolean = volume_test_players( VOLUMES.tv_shipyard_tube );
	local b_tube_buddy_set:boolean = false;
	local b_tube_solo_set:boolean = false;
	if b_in_tube then
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			
			if not b_tube_buddy_set then
					b_tube_buddy_set = true;
					
					--first musketeer will stay on follow in the tube
			--elseif not b_in_tube and not b_tube_solo_set then
			--	b_tube_solo_set = true;
			--	MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_tube_02, 4);
			else
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_02, 7);
			end
			end
	else
		MusketeerUtil_SetDestination_Assault_Clear()
	end	
	
end

function f_shipyard_musketeer_obj_3()

	local b_on_plat:boolean = volume_test_players( VOLUMES.tv_shipyard_tube_exit_plat );
	local b_plat_buddy_set:boolean = false;
	local b_tube_solo_set:boolean = false;
	
	if b_on_plat then
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			
			if not b_plat_buddy_set then
					b_plat_buddy_set = true;
					
					--print("tube _buddy");
			--elseif not b_on_plat and not b_tube_solo_set then
			--	b_tube_solo_set = true;
			--	MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_plat_1, 2);
			else
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_03, 7);
			end
			end
	else
		MusketeerUtil_SetDestination_Assault_Clear()
	end
	
end

function f_shipyard_musketeer_obj_4()

	local b_on_plat:boolean = volume_test_players( VOLUMES.tv_shipyard_ranger_advance );
	local b_plat_buddy_set:boolean = false;
	local b_tube_solo_set:boolean = false;
	
	if b_on_plat then
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			
			if not b_plat_buddy_set then
					b_plat_buddy_set = true;
			--elseif not b_on_plat and not b_tube_solo_set then
			--		b_tube_solo_set = true;
			--		MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_plat_2, 2);

					--print("tube _buddy");
			else
					MusketeerDestSetPoint(obj, FLAGS.fl_shipyard_musk_point_06, 12);
			end
			end
	else
		MusketeerUtil_SetDestination_Assault_Clear()
	end	
	
end


function ship_musk_test()
	MusketeerUtil_SetDestination_Assault(FLAGS.fl_shipyard_8 );

end

function f_shipyard_cleanup()
	ai_erase( AI.sg_yard_all );
	object_destroy_folder("crs_shipyard");
	object_destroy_folder("wpns_shipyard");	
end


