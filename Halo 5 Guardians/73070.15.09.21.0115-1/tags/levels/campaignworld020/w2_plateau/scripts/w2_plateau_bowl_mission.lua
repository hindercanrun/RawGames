--## SERVER

--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
--	343	//																			343	//	343
--	343	//																			343	//	343
--	343	//										Dingestan Plateau Bowl				343	//	343
--	343	//																			343	//	343
--	343	//																			343	//	343
--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
--	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	//	343	
global dp_gate1_incapacitated:boolean=false;
global dp_gate2_incapacitated:boolean=false;
global dp_playerhasarrived:boolean=false;
global dp_firstfrontisover:boolean=false;
global dp_reinforce2start:boolean=false;
global v_players_on_left:boolean=true;							-- starts true to keep snipers in position longer
global v_players_in_ghostcave:boolean=false;	
global n_dp_objcon = 0;

--//=========//	AI Spawn Scripts	//=========////

function plat_bowl_phantomstart():void
	ai_place_in_limbo (AI.sq_dp_phantom_1_bowl);
end

function dp_bowl_start():void
	SleepUntil([| volume_test_players(VOLUMES.tv_bowl_spawn_begin) ], 1);

		Sleep(1);
	
	-- first wave immediate spawns:
		CreateThread (plat_bowl_phantomstart);			-- results in sq_dp_tunneltop1 being spawned
		ai_place (AI.sq_dp_struc_1);					-- solo elite greeter
		ai_place (AI.sq_dp_struc_1_grunts.sleeper);		-- other 2 spawned by composition
		ai_place (AI.sq_dp_tunnel_1a);
		ai_place (AI.sq_dp_tunneltop1_grunts);
		ai_place (AI.sq_dp_floorright_jax);

	-- first wave spawn listeners:
		CreateThread(spawn_undertunnel);
		CreateThread(spawn_shadeturret_pilot);
		CreateThread(spawn_shadeturret_pilot_b);
		CreateThread(spawn_bottomleft_front);
		CreateThread(spawn_ghostcave_entrance);
		CreateThread(spawn_rockpile);
		CreateThread(dp_leftcavespawn);
		CreateThread(f_ghostcave_intro);

		Wake( dormant.f_db_objcon_controller );					-- objcon + reinforcement spawn
	
	-- helper functions:
		CreateThread( f_keep_bowl_pristine );					-- wait a bit before turning AI hearing on
		CreateThread( ghostcave_tracker);						-- is player in ghostcave?
		CreateThread (reinforcement_phantoms_listener);			-- at objcon 60 creates AI.sq_dp_phantom_3_w which carries	AI.sq_dp_topwraith, then
																-- at objcon 60 creates creates AI.sq_dp_phantom_3 which carries		AI.gr_tunneltop2 (	sq_dp_tunneltop2 and 
																--																							sq_dp_left_sweep_bulwark)

	--	CreateThread (dp_reinforcements_2);
	--	CreateThread (dp_backpathspawn);
		CreateThread( dp_shade_1_enter_turret );
		CreateThread( dp_shade_1_enter_turret2 );
end
function spawn_undertunnel():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_dp_objcon_20) 
				or	volume_test_players(VOLUMES.tv_spawn_underbridge_1) 
				], 3);
	ai_place (AI.sq_dp_undertunnel);
end
function spawn_shadeturret_pilot():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_dp_objcon_50) 
				], 3);
	ai_place (AI.sq_dp_shadeturret_gunner);
end
function spawn_shadeturret_pilot_b():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_dp_objcon_50) 
				], 3);
	ai_place(AI.sq_dp_hgground_turr_gunner);
end
function spawn_bottomleft_front():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_dp_objcon_20) 
				or	volume_test_players(VOLUMES.tv_spawn_floorleft) 
				], 3);
	ai_place (AI.sq_dp_floorleft_greeters);
end
function spawn_ghostcave_entrance():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_dp_objcon_30) 
				], 3);
	ai_place (AI.sq_dp_ghostcave_door);

end

function debug_spawn_db_front_struct()
	CreateThread( f_keep_bowl_pristine );
	object_create_folder("cr_bowl");
	object_create_folder("veh_entrance");
	ai_place_in_limbo (AI.sq_dp_phantom_1_bowl);
	Sleep(5);
	ai_place (AI.sq_dp_struc_1);
	ai_place (AI.sq_dp_struc_1_grunts.sleeper);
	ai_place (AI.sq_dp_tunnel_1a);
	ai_place (AI.sq_dp_tunneltop1_grunts);
	
	ai_place (AI.sq_dp_undertunnel);
	ai_place (AI.sq_dp_floorleft_greeters);
	ai_place (AI.sq_dp_floorright_jax);
	ai_place (AI.sq_dp_ghostcave_door );
	ai_place (AI.sq_dp_shadeturret_gunner);
	ai_place( AI.sq_dp_hgground_turr_gunner );
	


	--ai_place (AI.sq_dp_ghost);

	Wake( dormant.f_db_objcon_controller );
	print ("SPAWNED DUDES BE SPAWNED");
	sleep_s (1);
	
	CreateThread (reinforcement_phantoms_listener);
--	CreateThread (dp_reinforcements_2);
	CreateThread (dp_leftcavespawn);
	--CreateThread (dp_backpathspawn);
	CreateThread( dp_shade_1_enter_turret );
	CreateThread( dp_shade_1_enter_turret2 );
end

function debug_db_front_staging()
		ai_place (AI.sq_dp_struc_1_grunts.sleeper);
		ai_place (AI.sq_dp_struc_1);
		
end

function debug_bowl_delete_crates()
	object_destroy_folder("cr_bowl");
end

function debug_spawn_db_rear()
	object_create_folder("cr_bowl");
	object_create_folder("veh_entrance");
	Wake( dormant.f_db_objcon_controller );
	
	CreateThread( dp_spawnhg_enemies );
	ai_place (AI.sq_dp_leftcave);
	ai_place (AI.sq_dp_ghostcave);


	ai_place (AI.sq_left_sniper_a);
	ai_place (AI.sq_left_sniper_b);
	ai_place (AI.sq_dp_left_sweep_sniper);
	--ai_place (AI.sq_dp_left_sweep_bulwark);
	ai_place (AI.sq_dp_tunnel_2);

	ai_place (AI.sq_dp_hgsniper);
	ai_place (AI.sq_dp_shadeturret_gunner);
	CreateThread( dp_shade_1_enter_turret2 );
end

function debug_spawn_controller()
	object_create_folder("cr_bowl");
	object_create_folder("veh_entrance");
	Wake( dormant.f_db_objcon_controller );
end

function dp_spawnhg_enemies():void
	--SleepUntil ([|volume_test_players (VOLUMES.tv_spawnhg)], 1);
	ai_place (AI.sq_dp_hg_frontyard);
	ai_place (AI.sq_dp_hg_2ndflr);
	--ai_place (AI.sq_dp_hg_balcony);
	--ai_place (AI.sq_dp_hg_1stflr);
	ai_place (AI.sq_dp_hg_lookout);
end

function reinforcement_phantoms_listener():void
	print ("Reinforcements script loaded. Waiting for AI count to drop");
	SleepUntil ([|	(	ai_living_count (AI.gr_plat_all) <= 10 and ai_spawn_count (AI.gr_plat_all) > 0 ) 
				or		n_dp_objcon >= 60
				], 1);
	dp_firstfrontisover = true;
	ai_place_in_limbo (AI.sq_dp_phantom_3_w);					-- carries AI.sq_dp_topwraith
	
	SleepUntil( [| g_b_bowl_phantom_3_complete ] , 1 );
		ai_place_in_limbo (AI.sq_dp_phantom_3);					-- carries  AI.gr_tunneltop2
end

function reinforcement_phantoms_listener_test():void
	
	ai_place_in_limbo (AI.sq_dp_phantom_3_w);
	
	SleepUntil( [| g_b_bowl_phantom_3_complete ] , 1 );
		ai_place_in_limbo (AI.sq_dp_phantom_3);
	print ("Reinforcements wraith Loaded!");
end

function dp_reinforcements_2():void
	SleepUntil ([| ai_living_count (AI.gr_plat_all) <= 31 or volume_test_players (VOLUMES.tv_g_right_top)], 1);
	ai_place_in_limbo (AI.sq_dp_phantom_3);
	print ("Reinforcements 2 Loaded!");
end

function dp_leftcavespawn():void
	SleepUntil ([|volume_test_players (VOLUMES.tv_leftcave_spawn_a) or volume_test_players (VOLUMES.tv_leftcave_spawn_b) ], 1);
	-- CreateThread (dp_savegame);
	-- replaced with a dynamic checkpoint
	ai_place (AI.sq_dp_leftcave);
end

function dp_backpathspawn():void
	SleepUntil ([| volume_test_players (VOLUMES.tv_backpath1) or volume_test_players (VOLUMES.tv_backpath2)], 1);
	--ai_place (AI.sq_dp_backpath);
end

--//=========// Teleport Scripts	//=======////
function teleport_bowl():void
	Sleep (30);
	teleport_player_to_flag (PLAYERS.player0,FLAGS.fl_teleport_1, true);
	print ("Player teleported to plateau entrance");
end

function teleport_linear():void
	Sleep (30);
	teleport_player_to_flag (PLAYERS.player0,FLAGS.fl_teleport_2, true);
	print ("Player teleported to plateau linear");
end

--//=========//	Gate Progression Scripts	//=========////
function dp_entrancecheck():void
	SleepUntil([| volume_test_players(VOLUMES.tv_dp_objcon_110)], 1);
	dp_playerhasarrived = true;
	CreateThread(audio_plateau_bowl_outro);
	print("Player has passed the gate");
end

--//=========//	Narrative Scripts	//=========////
function dp_bowl_saves():void
	CreateThread (dp_savegame);
	CreateThread (dp_midgame_save);
end

function dp_bowlreminderobj():void
	SleepUntil ([| volume_test_players (VOLUMES.tv_spawnhg)], 1);
	ObjectiveShow (TITLES.ch_enter_site );
end

function dp_midgame_save():void
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_midsave)	
					or	volume_test_players (VOLUMES.tv_midsave_2)
					or	volume_test_players (VOLUMES.tv_midsave_3)
					], 5);
	CreateThread (dp_savegame);
end

function dp_savegame():void
	game_save_no_timeout();
end

--//=========//	Placement Scripts	//=========////

function dp_phantom_1()
	ai_set_blind (AI.sq_dp_phantom_1_bowl, true);
--	f_load_drop_ship_vehicle(AI.sq_dp_phantom_1_bowl, AI.sq_dp_topwraith, true, false);
	f_load_drop_ship (AI.sq_dp_phantom_1_bowl, AI.sq_dp_tunneltop1, true, false);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 01 ); --Shrink size over time
	
	
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_ghostcave_start)  ], 1);
	ai_exit_limbo (AI.sq_dp_phantom_1_bowl);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 180 ); --Shrink size over time
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p0, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p1, 0);
	cs_vehicle_speed(0.6);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p2, 0);
	
	cs_fly_to (ai_current_actor, true, POINTS.ps_dpphantom_1.p3, 3);
	cs_vehicle_speed(0.3);
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_dpphantom_1.p3, POINTS.ps_dpphantom_1.p3, 0.5);
	ai_set_blind (AI.sq_dp_phantom_1_bowl, false);
	f_unload_drop_ship(AI.sq_dp_phantom_1_bowl);
	sleep_s (1);	
	cs_vehicle_speed(1);

	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p5, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p6, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, (60 * 4) ); --Shrink size over time

	sleep_s (4);
	ai_erase (AI.sq_dp_phantom_1_bowl);
end

function dp_phantom_2()
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, .01 ); --Shrink size over time
	ai_exit_limbo (AI.sq_dp_phantom_2);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 180 ); --Shrink size over time
	print ("everything is ready for phantom. moving out now");
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p1, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p2, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p3, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p5, 0);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_dpphantom_2.p6, POINTS.ps_dpphantom_2.p6, 0);
	f_unload_drop_ship(AI.sq_dp_phantom_2);
	sleep_s (3);
	f_unload_drop_ship_vehicle(AI.sq_dp_phantom_2);
	--wander! kill!
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_2.p9, 0);
	cs_fly_by (AI.sq_dp_phantom_2.driver, true, POINTS.ps_dpphantom_2.p7, 0);
	cs_fly_by (AI.sq_dp_phantom_2.driver, true, POINTS.ps_dpphantom_2.p8, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p5, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p6, 0);

	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 240 ); --Shrink size over time
	sleep_s(4);
	ai_erase (AI.sq_dp_phantom_2);
end

function dp_phantom_3()
	f_load_drop_ship (AI.sq_dp_phantom_3, AI.gr_tunneltop2, true, false);

	--f_load_drop_ship_vehicle( AI.sq_dp_phantom_3, AI.sq_dp_topwraith, true, false );
	cs_vehicle_speed( 1.0 );
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); --Shrink size over time
	ai_exit_limbo (AI.sq_dp_phantom_3);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 240 ); --Shrink size over time
	
	print ("everything is ready for phantom. moving out now");
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_3.p1, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_3.p19, 0);
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_dpphantom_3.p20, POINTS.ps_dpphantom_3.p9, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_3.p2, 0);
	cs_vehicle_speed( 0.7 );
	cs_fly_to (ai_current_actor, true, POINTS.ps_dpphantom_3.p9, 0);
	
	cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_dpphantom_3.p9, POINTS.ps_dpphantom_3.p10, 3);
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_dpphantom_3.p9, POINTS.ps_dpphantom_3.p10, 5);
	f_unload_drop_ship(AI.sq_dp_phantom_3);
	
	--sleep_s (1);

	sleep_s (0.5);
	cs_vehicle_speed( 0.8 );
	cs_fly_to (ai_current_actor, true, POINTS.ps_dpphantom_3.p7, 0);

	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p5, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p6, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 240 ); --Shrink size over time



	sleep_s (4);
	ai_erase (AI.sq_dp_phantom_3);
end

global g_b_bowl_phantom_3_complete:boolean = false;

function dp_phantom_3_w()
	--f_load_drop_ship (AI.sq_dp_phantom_3_w, AI.gr_tunneltop2, true, false);
	--f_load_phantom( ai_vehicle_get( ai_current_actor ) , "right", AI.sq_dp_tunneltop2 );
	
	f_load_drop_ship_vehicle( AI.sq_dp_phantom_3_w, AI.sq_dp_topwraith, true, false );
	cs_vehicle_speed( 1.0 );
	--ai_set_blind (AI.sq_dp_phantom_3_w, true);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 0 ); --Shrink size over time
	ai_exit_limbo (AI.sq_dp_phantom_3_w);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 1.0, 180 ); --Shrink size over time
	object_cannot_die( ai_vehicle_get ( ai_current_actor ), true );

	--objects_attach(ai_vehicle_get (ai_current_actor) ,"fx_destroyed_phantom", OBJECTS.veh_plat_shade_2,nil ); 

	print ("everything is ready for phantom. moving out now");
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_4.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_4.p5, 0);
	cs_fly_to (ai_current_actor, true, POINTS.ps_dpphantom_4.p6, 0);
	--cs_fly_to (ai_current_actor, true, POINTS.ps_dpphantom_4.p7, 5);
	cs_vehicle_speed( 1.0 );
	--ai_set_blind (AI.sq_dp_phantom_3_w, false);
	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_dpphantom_4.p7, POINTS.ps_dpphantom_4.p8, 0);
	--sleep_s (1);
	f_unload_drop_ship_vehicle(AI.sq_dp_phantom_3_w);
	
	--cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_dpphantom_3.p9, POINTS.ps_dpphantom_3.p10, 0);
	--f_unload_drop_ship(AI.sq_dp_phantom_3);
	
	--sleep_s (1);
	g_b_bowl_phantom_3_complete = true;
	sleep_s (2);
	--g_b_bowl_phantom_3_complete = true;
	object_cannot_die( ai_vehicle_get ( ai_current_actor ), false );
	cs_vehicle_speed( 0.5 );
--	f_load_drop_ship (AI.sq_dp_phantom_3, AI.gr_reinforce_2, true, false);
--	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_3.p4, 0);
--	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_3.p5, 0);
--	cs_fly_to_and_dock (ai_current_actor, true, POINTS.ps_dpphantom_3.p11, POINTS.ps_dpphantom_3.p6, 0);
--	sleep_s (0.5);
--	f_unload_drop_ship(AI.sq_dp_phantom_3);
	--sleep_s (2);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_4.p9, 4);
	
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p4, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p5, 0);
	cs_fly_by (ai_current_actor, true, POINTS.ps_dpphantom_1.p6, 0);
	object_set_scale ( ai_vehicle_get ( ai_current_actor ), 0.01, 240 ); --Shrink size over time

	sleep_s (4);
	ai_erase (AI.sq_dp_phantom_3_w);
end
function dormant.f_db_objcon_controller()

	print("dp objcon setup");
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_10 ) or n_dp_objcon >= 10 ], 1);
		if n_dp_objcon <= 10 then
			n_dp_objcon = 10;
			print("n_dp_objcon = 10 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_15 ) or n_dp_objcon >= 15 ], 1);
		if n_dp_objcon <= 15 then
			n_dp_objcon = 15;
			print("n_dp_objcon = 15 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_20 ) or n_dp_objcon >= 20 ], 1);
		if n_dp_objcon <= 20 then
			n_dp_objcon = 20;
			print("n_dp_objcon = 20 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_30 ) or n_dp_objcon >= 30 ], 1);
		if n_dp_objcon <= 30 then
			n_dp_objcon = 30;
			print("n_dp_objcon = 30 ");
		end	
	ai_place (AI.sq_left_sniper_a);
	ai_place (AI.sq_left_sniper_b);

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_40 ) or n_dp_objcon >= 40 ], 1);
		if n_dp_objcon <= 40 then
			n_dp_objcon = 40;
			print("n_dp_objcon = 40 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_50 ) or n_dp_objcon >= 50 ], 1);
		if n_dp_objcon <= 50 then
			n_dp_objcon = 50;
			print("n_dp_objcon = 50 ");
		end
	CreateThread (dp_spawnhg_enemies);	

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_60 ) or n_dp_objcon >= 60 ], 1);
		if n_dp_objcon <= 60 then
			n_dp_objcon = 60;
			print("n_dp_objcon = 60 ");
		end
	CreateThread(maybe_spawn_sweep_sniper);
	CreateThread(maybe_spawn_tunnel_2);

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_65 ) or n_dp_objcon >= 65 ], 1);
		if n_dp_objcon <= 65 then
			n_dp_objcon = 65;
			print("n_dp_objcon = 65 ");
		end

	ai_place (AI.sq_dp_hgsniper);
	CreateThread(maybe_spawn_rangers);
	--CreateThread(audio_plateau_bowl_combat2);
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_70 ) or n_dp_objcon >= 70 ], 1);
		if n_dp_objcon <= 70 then
			n_dp_objcon = 70;
			print("n_dp_objcon = 70 ");
		end
	CreateThread(leftside_tracker);

		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_80 ) or n_dp_objcon >= 80 ], 1);
		if n_dp_objcon <= 80 then
			n_dp_objcon = 80;
			print("n_dp_objcon = 80 ");
		end
		
	
	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_90 ) or n_dp_objcon >= 90 ], 1);
		if n_dp_objcon <= 90 then
			n_dp_objcon = 90;
			print("n_dp_objcon = 90 ");
		end	

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_100 ) or n_dp_objcon >= 100 ], 1);
		if n_dp_objcon <= 100 then
			n_dp_objcon = 100;
			print("n_dp_objcon = 100 ");
		end	

	SleepUntil ([| volume_test_players ( VOLUMES.tv_dp_objcon_110 ) or n_dp_objcon >= 110 ], 1);
		if n_dp_objcon <= 110 then
			n_dp_objcon = 110;
			print("n_dp_objcon = 110 ");
		end	
		
end
function leftside_tracker():void
	repeat
		if(volume_test_players(VOLUMES.tv_bowl_left_all))then
			v_players_on_left = true;
		else
			v_players_on_left = false;
		end
	sleep_s(1);
	until(IsGoalActive(missionPlateau.goal_Bowl) == false);
end
function ghostcave_tracker():void
	repeat
		if(volume_test_players(VOLUMES.tv_bowl_ghostcave_all))then
			v_players_in_ghostcave = true;
		else
			v_players_in_ghostcave = false;
		end
	sleep_s(1);
	until(IsGoalActive(missionPlateau.goal_Bowl) == false);
end
function maybe_spawn_sweep_sniper():void
	if(ai_living_count(AI.gr_leftsniper_b) <= 0)then
		ai_place (AI.sq_dp_left_sweep_sniper);
	end
end
function maybe_spawn_tunnel_2():void
--	if(ai_living_count(AI.gr_bridge_a) <= 7)then
		ai_place (AI.sq_dp_tunnel_2);
--	end
end
function maybe_spawn_rangers():void
	if	(	ai_living_count(AI.gr_floor_right) >= 10)	then
		ai_place( AI.sq_dp_ranger_crew.e);
	else
		ai_place( AI.sq_dp_ranger_crew);
	end
end
function spawn_rockpile():void
	SleepUntil	(	[|		ai_living_count(AI.gr_bowl_l) >= 1
					or		n_dp_objcon >= 40
					], 5);
	Sleep(10);
	SleepUntil	(	[|		ai_living_count(AI.gr_bowl_l) <= 1
					or		n_dp_objcon >= 40
					], 5);
	if	(	game_coop_player_count() >= 2	)	then
		ai_place( AI.sq_dp_rockpile_crew);
	elseif(	game_difficulty_get_real() == DIFFICULTY.heroic 
		or	game_difficulty_get_real() == DIFFICULTY.legendary
		)then
		ai_place( AI.sq_dp_rockpile_crew.leader_e);
	else
		ai_place( AI.sq_dp_rockpile_crew.leader_j);
	end
end
function cs_dp_backpath_camo()


	ai_set_active_camo( ai_current_actor, true );
end

function dp_shade_1_enter_turret()
	SleepUntil ([| n_dp_objcon >= 65 or object_get_health(  OBJECTS.veh_plat_shade_1 ) < 1 ], 1);		
		--ai_vehicle_enter ( AI.sq_dp_hgground_turr_gunner, OBJECTS.veh_plat_shade_1  );
		dp_shade_1_enter_turret_task()
end


--this is also called when the task opens up
function dp_shade_1_enter_turret_task():boolean

		--print("gunner says task!");	
--		sleep_s(3.5);
		print("enter vehicle");
		ai_vehicle_enter ( AI.sq_dp_hgground_turr_gunner, OBJECTS.veh_plat_shade_1  );
		return true;
end

function dp_shade_1_enter_turret2()
	SleepUntil ([| n_dp_objcon >= 65 or object_get_health(  OBJECTS.veh_plat_shade_2 ) < 1 ], 1);		
		--print("gunner says mount up!");	
		--ai_vehicle_enter ( AI.sq_dp_shadeturret_gunner, OBJECTS.veh_plat_shade_2  );
		dp_shade_1_enter_turret2_task();
end


function debug_shade_1_turret1()
	object_create_anew("veh_plat_shade_1");
	Sleep(1);
	ai_place(AI.sq_dp_hgground_turr_gunner);
	n_dp_objcon = 65;
end

function debug_shade_1_turret2()
	--object_create("veh_plat_shade_2");
	Sleep(6);
	ai_place(AI.sq_dp_shadeturret_gunner);
	n_dp_objcon = 65;
end

--this is also called when the task opens up
function dp_shade_1_enter_turret2_task():boolean	
		--print("gunner says task!");	
		ai_vehicle_enter ( AI.sq_dp_shadeturret_gunner.gunner, OBJECTS.veh_plat_shade_2  );
		sleep_s(6.5);
		print("gunner enter vehicle");
		--unit_override_seats_yaw_angles(	OBJECTS.veh_plat_shade_2, -90,	90);
		ai_vehicle_enter ( AI.sq_dp_shadeturret_gunner.gunner, OBJECTS.veh_plat_shade_2  );
		sleep_s( 1 );
		
		--repeat
			Sleep(120);
			ai_vehicle_enter ( AI.sq_dp_shadeturret_gunner.gunner, OBJECTS.veh_plat_shade_2  );
			--print("try again");
			--print( unit_get_vehicle( ai_get_object(AI.sq_dp_shadeturret_gunner )) );
			--print( vehicle_driver( OBJECTS.veh_plat_shade_2 ) , AI.sq_dp_shadeturret_gunner);
		--until unit_get_vehicle( ai_get_object(AI.sq_dp_shadeturret_gunner ));
		--print("exit");
		return true;
end

--this is also called when the task opens up
function dp_shade_1_enter_turret3_task():boolean	
		--print("gunner says task!");	
	--	sleep_s(1);
		--print("enter vehicle");
		return true;
end
	


--
--TEMP STAGING BS

function cs_dummy_staging_tunnel_top()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true);
	--cs_enable_moving ( false );
	SleepUntil( [| ai_combat_status(AI.gr_tunneltop1) >= 3 ],1 );
	
end

global g_bowl_staging_show:number=0;

function cs_dummy_staging_struct()



	--SleepUntil( [| ai_combat_status(AI.gr_struc) >= 5 ],1 );
	--CreateThread( debug_heartbeat_elite , ai_current_actor );
	g_bowl_staging_show = pup_play_show( "bowl_elite_grunt_convo" );
	
end

function debug_heartbeat_elite( buddy:ai )

	repeat
		Sleep(15);
		print(ai_combat_status( buddy ));
	until false;
end

function cs_dummy_staging_struct_jacks_1()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p1, POINTS.ps_struct.look1);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );

end
function cs_dummy_staging_struct_jacks_2()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p2, POINTS.ps_struct.look1);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );

end
function cs_tunneltop_1():void
	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p3, POINTS.ps_struct.look3);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );
end
function cs_tunneltop_2():void
	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p4, POINTS.ps_struct.look3);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );
end
function cs_strucright_jax_1():void
	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p5, POINTS.ps_struct.look6);
	cs_go_to_and_face(POINTS.ps_struct.p6, POINTS.ps_struct.look6);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );
end
function cs_strucright_jax_2():void
	sleep_s(1);
	cs_abort_on_alert( true );
	cs_abort_on_damage(  true );
	cs_go_to_and_face(POINTS.ps_struct.p5, POINTS.ps_struct.look6);
	cs_go_to_and_face(POINTS.ps_struct.p7, POINTS.ps_struct.look6);
	SleepUntil( [| ai_combat_status(AI.gr_struc) >= 3 ],1 );
end

function cs_sleeping_grunt_cave()
	--print("sleeep");

	
	--ai_set_clump ( ai_current_actor, 99 );
	--ai_designer_clump_perception_range( 2 );
	--ai_set_blind (ai_current_actor, true);
	--ai_set_deaf (AI.gr_firstfront, true);
	--CreateThread( abit, ai_current_actor );
end



function cs_sleeping_grunt_struct()
	--print("sleeep");
	--cs_custom_animation( TAG('objects\characters\storm_grunt\storm_grunt.model_animation_graph'), "act_asleep_1:idle:var0", true );
	--ai_set_blind (ai_current_actor, true);
	--cs_abort_on_alert( true );
	--cs_abort_on_damage(  true);
	--cs_enable_moving ( false );
	
	SleepUntil( [| ai_combat_status(AI.gr_firstfront) >= 3  ],1 );
		ai_set_blind (ai_current_actor, false);
end


function f_keep_bowl_pristine()

		SleepUntil ([| ai_living_count( AI.gr_firstfront ) > 0  ], 1);
			--ai_set_blind (AI.gr_firstfront, true);
			ai_set_deaf (AI.gr_firstfront, true);
		SleepUntil ([| volume_test_players ( VOLUMES.tv_bowl_pristine_start )  ], 1);
			print("pristine encounter");
			--ai_set_blind (AI.gr_firstfront, false);
			ai_set_deaf (AI.gr_firstfront, false);
end
function f_ghostcave_intro():void
	CreateThread(f_ghostcave_spawn_listener);
	SleepUntil ([| volume_test_players ( VOLUMES.tv_ghostcave_start)  ], 1);
		ai_place(AI.sq_dp_ghostcave_elite);
end
function f_ghostcave_spawn_listener():void
	SleepUntil (	[|	volume_test_players ( VOLUMES.tv_dp_objcon_30 ) 
					or	n_dp_objcon >= 30 
					or	volume_test_players ( VOLUMES.tv_ghostcave_breach) 
					], 2);
	ai_place (AI.sq_dp_ghostcave);
	ai_place(AI.sq_dp_ghostcave_grunts);
end
function cs_sleeping_grunt_shield()

	
	f_bowl_grunt_wait_for_shield( ai_current_actor )
	
end

function f_bowl_grunt_wait_for_shield( shield_grunt:ai )
	print("setup grunt shield wait");
	SleepUntil( [| ai_combat_status(AI.gr_firstfront) >= 3  ],1 );
	print("playing grunt show");
	pup_play_show("bowl_grunt_small_shield_1" );
	
end
--bowl_grunt_small_shield_1