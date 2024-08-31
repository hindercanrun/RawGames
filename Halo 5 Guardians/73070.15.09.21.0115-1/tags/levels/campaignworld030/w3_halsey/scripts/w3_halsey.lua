--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 HALSEY*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*


--SlipSpaceSpawnGroup(AI.sg_vault_cov)


global obj_con_camp:number = 0;
global obj_con_cliff:number = 0;
global obj_con_steps:number = 0;
global obj_con_crag:number = 0;
global obj_con_overlook:number = 0;
global obj_con_hill:number = 0;
global obj_con_vault:number = 0;

global is_blink:boolean = false;
global b_loop_tut:boolean = false;
global b_level_intro_ics = false;
global pup_show_intro:number = 0;

global b_jackpawn_show:boolean = false;
global b_airlock_tracking:boolean = false;
global b_hallway_hacked:boolean = false;
global b_vault_show:boolean = false;
global gruntFlee:number = 0;

global n_kraken_show:number = 0;
global b_kraken_pods:boolean = false;
global b_kraken_fill:boolean = false;
global b_kraken_leave:boolean = false;

global b_kraken_engage_state:number = 0;

global missionHalsey:table=
	{
		name = "w3_halsey",
		--profiles = {STARTING_PROFILES.sp_locke, STARTING_PROFILES.sp_buck, STARTING_PROFILES.sp_tanaka, STARTING_PROFILES.sp_vale},
		points = POINTS.ps_checkpoint_01_start,
		startGoals = {"goal_halsey_camp"},
		collectibles = {
										{objectName = "w3_halsey_collectible_01", collectibleName = "w3_halsey_collectible_01"},
										{objectName = "w3_halsey_collectible_02", collectibleName = "w3_halsey_collectible_02"},
										{objectName = "w3_halsey_collectible_03", collectibleName = "w3_halsey_collectible_03"},
										{objectName = "w3_halsey_collectible_04", collectibleName = "w3_halsey_collectible_04"},
										{objectName = "w3_halsey_collectible_05", collectibleName = "w3_halsey_collectible_05"},
										{objectName = "w3_halsey_collectible_06", collectibleName = "w3_halsey_collectible_06"},
										{objectName = "w3_halsey_collectible_07", collectibleName = "w3_halsey_collectible_07"},
										{objectName = "w3_halsey_skull", collectibleName = "collectible_skull_iwhbyd"},
									 },
	}

function startup.HalseyInit()
	if not editor_mode() then
		--156430, gmu moving this to client and having the movie call it
		--CreateThread(halsey_cinematic_subtitles);
		CreateThread(audio_cinematic_mute_halsey);
		fade_out(0,0,0,0);
		Sleep(5);
		StartHalsey();		
	end
end
--ObjectSetSpartanTrackingEnabled( object, boolean )

function StartHalsey()
	StartMission(missionHalsey);
end

function missionHalsey.Start()
	--nothing to start
end

function missionHalsey.End()
		print("cin_start");
		-- Fade out before loom to hide any hitch, then play cinematic.
		fade_out(0,0,0,60);
		Sleep(61);
		CinematicPlay ("cin_020_captured");
		print("end");
		sleep_s(1);
		SetGlobalFlag("Halsey_complete");
		sys_LoadCin_030();
end
function startup.icy_cool_fx()
	RunClientScript("fx_snow");
end


--CreateThread(impactSmallLocke);
--CreateThread(impactSmallBuck);
--CreateThread(impactSmallVale);
--CreateThread(impactSmallTanaka);
function rumble_large_shake_small(numSeconds:number)
                RunClientScript ("start_global_rumble_large_shake_small", numSeconds);
end

function impactSmallLocke(time:number)
	RunClientScript("impactSmallPlayer", SPARTANS.locke, time);
end

function impactSmallBuck(time:number)
	RunClientScript("impactSmallPlayer", SPARTANS.buck, time);
end

function impactSmallVale(time:number)
	RunClientScript("impactSmallPlayer", SPARTANS.vale, time);
end

function impactSmallTanaka(time:number)
	RunClientScript("impactSmallPlayer", SPARTANS.tanaka, time);
end



--========================================================
--Blinks
--========================================================
function BlinkCliff():void
	ai_erase_all();
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_cliffside", FLAGS.fl_blink_02_cliff);
	CreateThread(audio_halsey_stopallmusic);	
end

function BlinkCrag():void
	ai_erase_all();
	CreateThread(setRespawnProfile);
	ToggleLimboForAllPlayers(true);
	zone_prep_and_swap( ZONE_SETS.zn_crack);
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_crag", FLAGS.fl_blink_04_crag);
	CreateThread(audio_halsey_stopallmusic);
end
	
function BlinkAirlock():void
	is_blink = true;
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_airlock", FLAGS.fl_blink_05_airlock);
	CreateThread(audio_halsey_stopallmusic);
end

function BlinkOverlook():void
	is_blink = true;
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_overlook", FLAGS.fl_blink_06_overlook);
	CreateThread(audio_halsey_stopallmusic);
end

function BlinkHill():void
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_hill", FLAGS.fl_blink_07_hill);
	CreateThread(audio_halsey_stopallmusic);
end

function BlinkVault():void
	is_blink = true;
	ai_erase_all();
	CreateThread(setRespawnProfile);
	CreateThread(GoalBlink, missionHalsey, "goal_halsey_vault", FLAGS.fl_blink_09_vault);
	CreateThread(audio_halsey_stopallmusic);
end


--========================================================
--GOAL CAMP
--========================================================
 missionHalsey.goal_halsey_camp = 
	{
	gotoVolume = VOLUMES.tv_goal_02_cliffside,
	zoneSet = ZONE_SETS.zn_camp,
	next={"goal_halsey_cliffside"}
	}

function missionHalsey.goal_halsey_camp.Start() :void				
	print ("Halsey intro cinematic");
	CreateThread(flocksVista, true);
	CinematicPlay ("cin_010_halsey");
	ai_grenades( false );
	--queue up vignetted crashes
	CreateThread(banshee_crash);
	hud_show_navpoints_musketeer( false );
	hud_show_navpoints_player( false );
	--music start
	CreateThread(audio_halsey_thread_up_intro_start);
	
	-- kickoff fx/flocks
	pup_play_show("vin_theater_of_war");	

	CreateThread(firstSave);
	CreateThread(setProfileMusketeer);
	garbage_collect_set_category_tension_dev_only(13, 0.25, GARBAGE_CATEGORY.Bodies);
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen_off.sound'), nil, 1);
	pup_show_intro = pup_play_show("vin_level_intro_ics");
	CreateThread(nar_halsey_init);

	SleepUntil([| b_level_intro_ics ], 1);

	CreateThread(saveImmediateAfterIntro);
	ai_disregard(AI.vin_intro_ship_crash_squad, true);
	ai_disregard(AI.vin_intro_ics_grunt, true);
	
	CreateThread(setMuskStartPosition);
	CreateThread(gruntSetFlee);
	garbage_collect_over_time( 0, 1, GARBAGE_CATEGORY.Weapons, false );
	CreateThread(turret_comps_front);
	CreateThread(set_objective_blip, 1);
	ai_kill(AI.vin_intro_ics_grunt);	
	object_create("w_camp_sword");
	weapon_set_current_amount( OBJECTS.w_camp_sword, 0 );
	sleep_s(1);
	CreateThread(f_chapter_title, TITLES.ct_halsey_1);
	CreateThread(fadeInIdTags);
	CreateThread(trainingNormal);
	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_camp, nar_goal_halsey_camp);
	CreateThread(ee_setup);
	SleepUntil([| volume_test_players(VOLUMES.tv_camp_vin_ships)],1);
	garbage_collect_set_category_tension_dev_only(3, 1.0, GARBAGE_CATEGORY.Bodies);

	CreateThread(set_objective_blip, 2);
	CreateThread(vinVtolVsPhantom);
	obj_con_camp = 10;
end

function saveImmediateAfterIntro()
	-- Helbig: make sure the players are actually done with the show prior to saving... by just waiting a few seconds :).
	sleep_s(5);
	game_save_immediate();
end

function firstSave()
	CreateThread(setAiDeafBlind);
	sleep_s(7);
	print("SWQAP");
	switch_zone_set(ZONE_SETS.zn_camp);
	sleep_s(1);
	print("save");
	game_save_no_timeout();
end

function setAiDeafBlind()
	SleepUntil([| ai_living_count(AI.vin_intro_ship_crash_squad) > 0],1);
	sleep_s(1);
	ai_set_blind( AI.vin_intro_ics_grunt, true );
	ai_set_blind( AI.vin_intro_ship_crash_squad, true );
	ai_set_deaf( AI.vin_intro_ics_grunt, true );
	ai_set_deaf( AI.vin_intro_ship_crash_squad, true );
end

function fadeInIdTags()
	sleep_s(4);
	print("tag");
	hud_show_navpoints_musketeer(true);
	hud_show_navpoints_player(true);
end

function setMuskStartPosition()
	MusketeersOrderTurnAllOff();
	if not IsPlayer(SPARTANS.buck) then
		print("BUCK");
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_start_buck, 0.25);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_start_tanaka, 0.25);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_start_vale, 0.25);
	end
	SleepUntil([| volume_test_players(VOLUMES.tv_camp_objective)],1, seconds_to_frames(360));
	MusketeersOrderTurnAllOn();
	CreateThread(RegisterMusketeerOrderEvent, cheevo_teamWeapon);
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			MusketeerDestClear(spartan);
		end
	end
end

function setProfileMusketeer()
	if not IsPlayer(SPARTANS.buck) then
		unit_add_equipment( SPARTANS.buck, STARTING_PROFILES.sp_musk_buck, true, true );
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		unit_add_equipment( SPARTANS.tanaka, STARTING_PROFILES.sp_musk_tanaka, true, true );
	end
	if not IsPlayer( SPARTANS.vale ) then
		unit_add_equipment( SPARTANS.vale, STARTING_PROFILES.sp_musk_vale, true, true );
	end

end


global b_vinVtolShoot_phan01:boolean = true;
global b_vinVtolShoot_phan02:boolean = true;
global b_vinVtolSpawnValid:boolean = false;

function vinVtolVsPhantom()
		print("playshow3");
		ai_place(AI.sq_gaurdian_vtol01);
		sleep_s(0.1);
		local state = { 
			vtol01 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol01.spawnpoint01),
			vtol02 =  ai_vehicle_get_from_spawn_point(AI.sq_gaurdian_vtol01.spawnpoint02),
			pilot01 = AI.sq_gaurdian_vtol01.spawnpoint01,
			pilot02 = AI.sq_gaurdian_vtol01.spawnpoint02,
									};
		pup_play_show("vin_phantom_v_vtols", state);
end


function cs_vtol_shoot_phantom()
	repeat
		if b_vinVtolShoot_phan01 then
			cs_shoot_secondary_trigger(true);
			cs_shoot_at( true, FLAGS.fl_vin_vtol_shoot_phan01);
		end
		sleep_s(0.25);
	until( not b_vinVtolShoot_phan01 );
	
	repeat
		if b_vinVtolShoot_phan02 then
			cs_shoot_secondary_trigger(true);
			cs_shoot_at( true, FLAGS.fl_vin_vtol_shoot_phan02);
		end
		sleep_s(0.5);
	until(not b_vinVtolShoot_phan02  );
end

function gruntSetFlee()
	SleepUntil([| volume_test_players_lookat( VOLUMES.tv_camp_lookat_grunt, 30, 30 )],1);
	sleep_s(2);
	gruntFlee = 1;
	SleepUntil([| volume_test_players_lookat( VOLUMES.tv_camp_lookat_grunt, 30, 30 )],1);
	gruntFlee = 2;
end

function trainingNormal()
	sleep_s(3.5);
	CreateThread(train_move);
	sleep_s(6);
	CreateThread(train_look);
	SleepUntil([| volume_test_players(VOLUMES.tv_camp_tut_sprint)],1);
	CreateThread(train_sprint);
	sleep_s(6);
	SleepUntil([| volume_test_players(VOLUMES.tv_camp_tut_shoot)],1);
		CreateThread(train_shoot);
end

--Intro Puppet Show Cleanup
function cleanup_swords()
	garbage_collect_over_time( 0, 1, GARBAGE_CATEGORY.Weapons, false );
end

--CAMP AI COMMAND SCRIPT
function cs_camp_flee01()
	print("show");
	SleepUntil([|gruntFlee >= 1],1);
	cs_push_stance( ai_current_actor, "flee" );
	cs_go_to(POINTS.ps_camp_flee.p0, 2);
	cs_go_to(POINTS.ps_camp_flee.p1, 2);
	cs_go_to(POINTS.ps_camp_flee.p2, 2);
	cs_go_to(POINTS.ps_camp_flee.p3, 2);
end 

function cs_camp_flee02()
	print("show");
	SleepUntil([|gruntFlee >= 1],1);
	cs_push_stance( ai_current_actor, "flee" );
	cs_go_to(POINTS.ps_camp_flee.p2, 2);
	cs_go_to(POINTS.ps_camp_flee.p3, 2);
end 

function flocksVista( on:boolean )
	if on then
		flock_create("flock_banshee");
		flock_create("flock_phantom");
		flock_create("flock_vtol");
		flock_create("flock_vtol_1");
		flock_create("flock_vtol_2");
	else
		flock_destroy("flock_banshee");
		flock_destroy("flock_phantom");
		flock_destroy("flock_vtol");
		flock_destroy("flock_vtol_1");
		flock_destroy("flock_vtol_2");
	end
end

function banshee_crash_show(tv:volume, show_name:string)
	SleepUntil ([| volume_test_players(tv)], 1);
	composer_play_show (show_name);
end

function banshee_crash():void
	print ("banshee_crash all function started");	
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_long_loop_and_crash, "banshee_long_loop_then_crash");
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_crash_01, "vin_banshee_crash_01");
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_crash_02, "vin_banshee_crash_02");
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_crash_03, "vin_banshee_crash_03");
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_crash_04, "vin_banshee_crash_04");
	CreateThread( banshee_crash_show, VOLUMES.tv_banshee_crash_05, "vin_banshee_crash_05");
end

--vin explosion
function vin_phantom_explode(phantom:object)
		object_damage_damage_section( phantom, "body", 10000 );
end
--vin_phantom_explode(OBJECTS.sc_vin_phantom_01)
--vin_phantom_explode(OBJECTS.sc_vin_phantom_02)


function turret_comps_front()
	pup_play_show("comp_skybox_turret_01");
	sleep_s(1);
	pup_play_show("comp_skybox_turret_02");
	sleep_s(2);
	pup_play_show("comp_skybox_turret_03");
	sleep_s(3);
	pup_play_show("comp_skybox_turret_04");
	sleep_s(2);
	pup_play_show("comp_skybox_turret_05");
end


--========================================================
--GOAL CLIFFSIDE
--========================================================
 missionHalsey.goal_halsey_cliffside = 
	{
	gotoVolume = VOLUMES.tv_goal_03_steps,
	zoneSet = ZONE_SETS.zn_cliff,
	next={"goal_halsey_steps"}
	}

function missionHalsey.goal_halsey_cliffside.Start() :void		
	--Wake(dormant.w3_halsey_start);
	print("goal_halsey_cliffside");
	CreateThread(setRespawnProfile);
	game_save_no_timeout();
	ai_grenades( true );	
	CreateThread(set_objective_blip, 3);
	CreateThread(musketeerControlCliff);
	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_cliffside, nar_goal_halsey_cliffside);
	--cov
	ai_place(AI.sq_cliff_cov_01);
	ai_place(AI.sq_cliff_cov_02);
	ai_place(AI.sq_cliff_cov_05);
	ai_place(AI.sq_cliff_cov_spirit);
	ai_place(AI.sq_cliff_for_03);
	SlipSpaceSpawn(AI.sq_cliff_for_06);
	CreateThread(comp_jackpawn);
	
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_cliff_cov_04.spawn_points_0), true);
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_cliff_for_04), true);
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_cliff_for_06), true);
	--show spawns enemys
	pup_play_show("vin_crawlers_tug_war_grunt");
	
	ai_prefer_target_team( AI.sg_cliff_all, TEAM.player );
	SleepUntil([| volume_test_players(VOLUMES.tv_cliff_objcon_10)],1);
	print("OBJ 10");
	obj_con_cliff = 10;
	SlipSpaceSpawn(AI.sq_cliff_for_04);
	SlipSpaceSpawn(AI.sq_cliff_for_05);
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sq_cliff_for_04), false);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_cliff_objcon_20)],1);
	game_save_no_timeout();
	print("OBJ 20");	
	obj_con_cliff = 20;
	SlipSpaceSpawn(AI.sq_cliff_for_07);
	CreateThread(train_thrust);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_cliff_objcon_30)],1);
	ai_prefer_target_team( AI.sg_cliff_all, TEAM.player );
	game_save_no_timeout();
	print("OBJ 30");
	obj_con_cliff = 30;
	SlipSpaceSpawn(AI.sq_cliff_for_08);

	SleepUntil([| volume_test_players(VOLUMES.tv_cliff_objcon_40)],1);
	obj_con_cliff = 40;
end

function comp_jackpawn()
	pup_play_show("vin_crawler_v_jackal");
	SleepUntil([| volume_test_players_lookat( VOLUMES.tv_cliff_lookat_jackpawn, 17, 17 )], 1);
	b_jackpawn_show = true;
end

function setRespawnProfile()
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.locke );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.buck );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.vale );
	player_set_profile( STARTING_PROFILES.sp_respawn, SPARTANS.tanaka );
end

function cliff_spirit()
	f_load_drop_ship( AI.sq_cliff_cov_spirit, AI.sq_cliff_cov_04, true, false, "left" );
	--cs_fly_to (ai_current_actor, true, POINTS.ps_cliff_spirit.p0);
	--cs_fly_to_and_face (ai_current_actor, true, POINTS.ps_cliff_spirit.p1);
	--cs_fly_to_and_face(POINTS.ps_cliff_spirit.p1, POINTS.ps_cliff_spirit.p3);
	cs_fly_to_and_dock(POINTS.ps_cliff_spirit.p2, POINTS.ps_cliff_spirit.p3);
	sleep_s(2.5);
	ai_prefer_target_ai( ai_current_actor, AI.sg_cliff_for, true );
	sleep_s(1);
	SleepUntil([| volume_test_players_lookat( VOLUMES.tv_cliff_lookat_spirit, 22, 22 )], 1, 360);
	f_unload_drop_ship( AI.sq_cliff_cov_spirit, "left");
	sleep_s(3);
--	pup_play_show("comp_spirit_squad");
	cs_fly_to (ai_current_actor, true, POINTS.ps_cliff_spirit.p4);
	cs_fly_to (ai_current_actor, true, POINTS.ps_cliff_spirit.p5);
	cs_fly_to (ai_current_actor, true, POINTS.ps_cliff_spirit.p6);
	object_set_scale(object_get_parent(ai_current_actor), 0.1, 60 );
	sleep_s(1);
	ai_erase(AI.sq_cliff_cov_spirit);
end

--========================================================
--GOAL STEPS
--========================================================
 missionHalsey.goal_halsey_steps = 
	{
	gotoVolume = VOLUMES.tv_goal_04_crag,
	next={"goal_halsey_crag"}
	}

function missionHalsey.goal_halsey_steps.Start():void
	print("goal_halsey_steps");
	game_save_no_timeout();
	CreateThread(set_objective_blip, 4);
	CreateThread(train_jump);
	CreateThread(train_charge, VOLUMES.tv_steps_train_charge_start, VOLUMES.tv_steps_train_charge_end);
	CreateThread(train_climb, VOLUMES.tv_steps_train_climb_start, VOLUMES.tv_steps_train_climb_end);
	SleepUntil([| volume_test_players(VOLUMES.tv_steps_sol_spawn)], 1);
	
	CreateThread(setMuskStepsPosition);
	--pup_play_show("vin_soldier_bamf");
	pup_play_show("vin_sol_reveal");
	ai_disregard( AI.sq_crag_falls_01, true );
	ai_disregard( AI.sq_crag_falls_02, true );
	CreateThread(audio_soldier_reveal);
	
	CreateThread(solCheckReveal);
	CreateThread(crag_teleport);
	SleepUntil([| object_get_recent_body_damage( OBJECTS.sc_shoulderbash_steps01 ) > 0.5 or volume_test_players(VOLUMES.tv_steps_train_charge_end)], 1);
	ai_disregard( AI.sq_crag_falls_01, false );
	ai_disregard( AI.sq_crag_falls_02, false );
	CreateThread (audio_after_shoulderbash);
	CreateThread(set_objective_blip, 5);
end

global b_sol_reveal:boolean = false;

function solCheckReveal()

	SleepUntil([|volume_test_players_lookat( VOLUMES.tv_steps_sol_lookat, 9, 9 ) ], 1);
	print("stuff");
	b_sol_reveal = true;
end

function setMuskStepsPosition()
	ai_disable_jump_hint( HINTS.jh_crack_ice );
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_steps01_buck, 0.25);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_steps01_tanaka, 0.25);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_steps01_vale, 0.25);
	end
	SleepUntil([| object_get_recent_body_damage( OBJECTS.sc_shoulderbash_steps01 ) > 0.5 or volume_test_players(VOLUMES.tv_steps_train_charge_end)], 1);
	ai_enable_jump_hint( HINTS.jh_crack_ice );
	sleep_s(1);
	if not IsPlayer(SPARTANS.buck) then
		MusketeerDestSetPoint(SPARTANS.buck, FLAGS.fl_musk_steps02_buck, 0.25);
	end
	if not IsPlayer( SPARTANS.tanaka ) then
		MusketeerDestSetPoint(SPARTANS.tanaka, FLAGS.fl_musk_steps02_tanaka, 0.25);
	end
	if not IsPlayer( SPARTANS.vale ) then
		MusketeerDestSetPoint(SPARTANS.vale, FLAGS.fl_musk_steps02_vale, 0.25);
	end
	sleep_s(3);
	for _, spartan in ipairs(spartans()) do
		if not IsPlayer(spartan) then
			MusketeerDestClear(spartan);
		end
	end
end
--========================================================
--GOAL CRAG
--========================================================
 missionHalsey.goal_halsey_crag = 
	{
	gotoVolume = VOLUMES.tv_goal_05_airlock,
	next={"goal_halsey_airlock"}
	}


function missionHalsey.goal_halsey_crag.Start() :void		
	print("goal_halsey_crag");
	if is_blink then
		is_blink = false;
		ai_place(AI.sq_crag_falls_01);
		ai_place(AI.sq_crag_falls_02);
		CreateThread(turret_comps_front);
		CreateThread(crag_BlinkTeleport);
	end
	render_low_res_transparents = false;
	CreateThread(turret_comp_crag);
	CreateThread(crag_turret_kill);
	game_save_no_timeout();
	CreateThread(train_groundPound, VOLUMES.tv_crag_train_groundpound);
	CreateThread(flocksVista, false);

	CreateThread(muskControlCragAll);
	ai_disable_jump_hint( HINTS.jh_airlock_door );
	
	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_crag, nar_goal_halsey_crag);
	
	SlipSpaceSpawnGroup(AI.sg_crag_door_w01);
	SlipSpaceSpawn(AI.sq_crag_falls_08);
	SlipSpaceSpawn(AI.sq_crag_falls_05);
	CreateThread(crag_falls_ai_control);
		
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_10)], 1);
	game_save_no_timeout();
	obj_con_crag = 10;
	CreateThread(set_objective_blip, 6);
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_15)], 1);
	obj_con_crag = 15;
	SlipSpaceSpawnGroup(AI.sg_crag_trident_w01);
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_20)], 1);
	game_save_no_timeout();
	garbage_collect_now();
	obj_con_crag = 20;
	SlipSpaceSpawn(AI.sq_crag_trident_w1_02);
	CreateThread(crag_trident_ai_control);
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_30)], 1);
	game_save_no_timeout();
	garbage_collect_now();
	obj_con_crag = 30;
	SlipSpaceSpawnGroup(AI.sg_crag_trident_w02);
	SlipSpaceSpawn(AI.sq_crag_trident_w3_01);

	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_40) or ai_living_count(AI.sg_crag_trident) < 4], 1);
	game_save_no_timeout();
	garbage_collect_now();
	obj_con_crag = 40;
	ai_place(AI.sg_crag_door_w02);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_obj_con_50) or ai_living_count(AI.sg_crag_door) < 2], 1);
	game_save_no_timeout();
	garbage_collect_now();
	obj_con_crag = 50;
	SlipSpaceSpawn(AI.sq_crag_door_w3_01);

	SleepUntil([| livingCountDoorDefenders() <= 0], 1);
	NarrativeQueue.QueueConversation(nar_crag_combat_complete);
	sleep_s(3);
	
	SleepUntil([| volume_test_players_lookat(VOLUMES.tv_airlock_door_lookat, 15, 15) ], 1);
	device_set_power(OBJECTS.dm_airlock_door_01, 1);
	render_low_res_transparents = true;
	ai_enable_jump_hint( HINTS.jh_airlock_door );	
end

function crag_turret_kill()
	repeat
		SleepUntil([| volume_test_players(VOLUMES.playerkill_crag_turret_derez) or current_zone_set_fully_active() == ZONE_SETS.zn_airlock], 1);
		if volume_test_players(VOLUMES.playerkill_crag_turret_derez) then
			damage_objects_effect( TAG('objects\weapons\support_high\incineration_cannon\projectiles\damage_effects\incineration_cannon_impact.damage_effect'), volume_return_players(VOLUMES.playerkill_crag_turret_derez));							
		end
	until current_zone_set_fully_active() == ZONE_SETS.zn_airlock
end

function livingCountDoorDefenders():number
	return (ai_living_count(AI.sq_crag_door_w2_03) + ai_living_count(AI.sq_crag_door_w2_04) + ai_living_count(AI.sq_crag_door_w3_01) );
end

function crag_falls_ai_control()
	SleepUntil([| volume_test_players_lookat(VOLUMES.tv_crag_falls_lookat, 25, 25) ], 1);
	CreateThread(fallsTutZoom);
	SlipSpaceSpawn(AI.sq_crag_falls_04);
	SleepUntil([| obj_con_crag >= 15 or ai_living_count(AI.sg_crag_falls) < 3], 1);
	--SlipSpaceSpawn(AI.sq_crag_falls_03);
	SlipSpaceSpawn(AI.sq_crag_falls_07);
	SlipSpaceSpawn(AI.sq_crag_falls_06);	

end

function crag_trident_ai_control()
	SleepUntil([| obj_con_crag >= 40 or ai_living_count(AI.sg_crag_falls) < 10], 1);
	--SlipSpaceSpawn(AI.sq_crag_trident_w3_02);
	SlipSpaceSpawn(AI.sq_crag_trident_w3_03);
end

function fallsTutZoom()
	SleepUntil([| volume_test_players(VOLUMES.tv_crag_falls_zoom)], 1);
	CreateThread(train_zoom);
end

function crag_teleport()
	SleepUntil([| volume_test_players(VOLUMES.tv_teleport_start_crag) ], 1);
	device_set_power(OBJECTS.dm_steps_door02, 0);
	sleep_s(1);
	SleepUntil([| device_get_position(OBJECTS.dm_steps_door02) == 0 ], 1);
	CreateThread(flocksCrag, true);
	zone_set_trigger_volume_enable( "begin_zone_set:zn_steps", false );
	zone_set_trigger_volume_enable( "zone_set:zn_steps", false );
	sleep_s(1);
	volume_teleport_players_not_inside( VOLUMES.tv_teleport_regroup_crag, FLAGS.fl_steps_regroup );
	sleep_s(1);
	zone_prep_and_swap( ZONE_SETS.zn_crack);
end

function crag_BlinkTeleport()
	device_set_power(OBJECTS.dm_steps_door02, 0);
	zone_set_trigger_volume_enable( "begin_zone_set:zn_steps", false );
	zone_set_trigger_volume_enable( "zone_set:zn_steps", false );
	volume_teleport_players_not_inside( VOLUMES.tv_goal_04_crag, FLAGS.fl_crag_teleport );
	zone_prep_and_swap( ZONE_SETS.zn_crack);
end

function turret_comp_crag()
	pup_play_show("comp_skybox_turret_crag");
end

function flocksCrag(on:boolean)
	if on then
		flock_create("flock_crack_banshee");
		flock_create("flock_crack_phantom");
		flock_create("flock_crack_vtol");
		flock_create("flock_crack_vtol_1");
		flock_create("flock_crack_vtol_2");
	else
		flock_destroy("flock_crack_phantom");
		flock_destroy("flock_crack_phantom");
		flock_destroy("flock_crack_vtol");
		flock_destroy("flock_crack_vtol_1");
		flock_destroy("flock_crack_vtol_2");
	end
end
--createThread(flocksVault, true);
--createThread(flocksVista, true);
function flocksVault( on:boolean )
	if on then
		flock_create("flock_banshee");
		flock_create("flock_vtol");
		flock_create("flock_vtol_2");	
		flock_create("flock_crack_banshee");
		flock_create("flock_crack_vtol");
	else
	
		flock_destroy("flock_banshee");
		flock_destroy("flock_vtol");
		flock_destroy("flock_vtol_2");
		flock_destroy("flock_crack_vtol");
	end
end

--========================================================
--GOAL Airlock
--========================================================
 missionHalsey.goal_halsey_airlock = 
	{
	gotoVolume = VOLUMES.tv_goal_06_overlook,
	zoneSet = ZONE_SETS.zn_crack,
	next={"goal_halsey_overlook"}
	}

function missionHalsey.goal_halsey_airlock.Start() :void		
	if is_blink then
		is_blink = false;
	end
	print("goal_halsey_airlock");
	game_save_no_timeout();
	object_destroy_folder("mod_obj_blip");
	CreateThread(flocksHill, false);
	--CreateThread(flocksVista, true);
	CreateThread(audio_halsey_thread_up_airlock)
	CreateThread(musketeerControlAirlock);
	ai_disable_jump_hint( HINTS.jh_airlock_out );
	sleep_s(2);	
	--narstuff
	CreateThread(nar_goal_halsey_airlock);
	sleep_s(2);	
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_tr_airlock_02, true);
	SleepUntil([| b_airlock_tracking or b_halsey_tracking_tutorial], 1);
	if not b_airlock_tracking then
		CreateThread(train_tracking);
	end
	CreateThread(new_objective, TITLES.obj_halsey_2, false);
	sleep_s(2);
	
	SleepUntil([| b_airlock_tracking], 1);
	CreateThread(rumble_shake_small, 4);
	CreateThread(airlock_teleport);
	sleep_s(2);
	pup_play_show("comp_track_room_activate");
	sleep_s(0.5);
	SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.zn_airlock], 1);
	game_save_no_timeout();
	sleep_s(2);
	device_set_position(OBJECTS.dm_airlock_tr_door, 1);
	CreateThread(set_objective_blip, 7);
	sleep_s(5);
	device_set_power(OBJECTS.dm_airlock_door_02, 1);
	device_set_position(OBJECTS.dm_airlock_door_02, 1);
	CreateThread(airlockHintOutOn);
	--CreateThread(objective_complete);
end

function airlockHintOutOn()
	SleepUntil([|device_get_position(OBJECTS.dm_airlock_door_02) >= 0.5 ], 1);
	ai_enable_jump_hint( HINTS.jh_airlock_out );
	CreateThread(halseyMuskClearOrder);
end
--Airlock Regroup

function airlock_teleport()
	device_set_power(OBJECTS.dm_airlock_door_01, 0);
	sleep_s(1);
	SleepUntil([| device_get_position(OBJECTS.dm_airlock_door_01) == 0 ], 1);
	sleep_s(2.5);
	volume_teleport_players_not_inside(VOLUMES.tv_goal_05_airlock, FLAGS.fl_airlock_teleport);
	sleep_s(1);
	zone_prep_and_swap( ZONE_SETS.zn_airlock);
	CreateThread(flocksCrag, false);
end

function zone_prep_and_swap(zone:zone_set)
	
	if current_zone_set_fully_active() ~= zone then
		prepare_to_switch_to_zone_set( zone );
		sleep_s(3);
		SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
		Sleep(1);
		switch_zone_set( zone );
	end
	
end

--in dc tag
function TrackingButton(device:object, p_player:object)
	
	local show:number = composer_play_show("collectible", {scanner = p_player});
	
	device_set_power(OBJECTS.dc_tr_airlock_02, 0);	
	ObjectSetSpartanTrackingEnabled(device, false);
	b_airlock_tracking = true;
end

function flocksHill(on:boolean)
	if on then
		flock_create("flock_hill_banshee");
		flock_create("flock_hill_vtol");
	else
		flock_destroy("flock_hill_banshee");
		flock_destroy("flock_hill_vtol");
	end
end

--========================================================
--GOAL Overlook
--========================================================
 missionHalsey.goal_halsey_overlook = 
	{
	gotoVolume = VOLUMES.tv_goal_07_hill,
	zoneSet = ZONE_SETS.zn_airlock,
	next={"goal_halsey_hill"}
	}

function missionHalsey.goal_halsey_overlook.Start() :void		
	if is_blink then
		is_blink = false;
	end
	print("goal_halsey_overlook");
	--ai_erase_all();
	ai_erase(AI.sg_crag_all);
	garbage_collect_now();
	game_save_no_timeout();
	CreateThread(set_objective_blip, 8);

	sleep_s(1);
	
	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_overlook, nar_goal_halsey_overlook);	
	CreateThread(kraken_tease);
	--CreateThread(nar_overlook_kraken);
	SleepUntil([| volume_test_players(VOLUMES.tv_overlook_objcon_10)], 1);	
	obj_con_overlook = 10;
	
	SleepUntil([| volume_test_players(VOLUMES.tv_overlook_objcon_20)], 1);	
	obj_con_overlook = 20;
	CreateThread(overlook_teleport);
end

function kraken_tease()
		n_kraken_show = pup_play_show("vin_sentry_ship_tease");
end

function overlook_teleport()
  --SleepUntil([| volume_test_players(VOLUMES.tv_begin_zn_hill) ], 1);
	device_set_power(OBJECTS.dm_airlock_door_02, 0);
	sleep_s(1);
	SleepUntil([| device_get_position(OBJECTS.dm_airlock_door_02) == 0 ], 1);
	volume_teleport_players_inside( VOLUMES.tv_overlook_regroup, FLAGS.fl_overlook_teleport );
	sleep_s(1);
	-- prepare_to_switch_to_zone_set( ZONE_SETS.zn_hill);
end

--========================================================
--GOAL HILL
--========================================================
global b_hill_playfight:boolean = true;

 missionHalsey.goal_halsey_hill = 
	{
	gotoVolume = VOLUMES.tv_goal_08_hallway,
	zoneSet = ZONE_SETS.zn_hill,
	next={"goal_halsey_hallway"}
	}

function missionHalsey.goal_halsey_hill.Start() :void		
	print("goal_halsey_hill");
	SleepUntil([| current_zone_set_fully_active() == ZONE_SETS.zn_hill ], 1);
	ai_disable_jump_hint( HINTS.jh_hill_hallway );
	ai_disable_jump_hint( HINTS.jh_hill_hallway01 );
	ai_disable_jump_hint( HINTS.jh_hill_hallway02 );
	CreateThread(jumpHintControl_hillCenter);
	CreateThread(jumpHintControl_hillRight);
	render_low_res_transparents = false;
	CreateThread(cheevo_enemymine);
	object_destroy_folder("mod_camp");
	object_destroy_folder("mod_cliffside");
	object_destroy_folder("mod_crag");
	object_destroy_folder("mod_steps");
	object_destroy_folder("mod_turrets_front");
	
	CreateThread(playfightSwitch);
	CreateThread(set_objective_blip, 9);
	CreateThread(turret_comps_hill);
	CreateThread(train_groundPound, VOLUMES.tv_hill_tut_pound);
	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_hill, nar_goal_halsey_hill);
	CreateThread(new_objective, TITLES.obj_halsey_1, true);
	garbage_collect_now();
	game_save_no_timeout();
	CreateThread(kraken_init);
	CreateThread(musketeerControlHill);
	CreateThread(hillLivingObjCon);
	CreateThread(aiPlaceTowerTurret, OBJECTS.dm_for_tower_01, AI.sq_hill_w1_turret);
	
	ai_place(AI.sq_hill_cov_pod_1);
	ai_place(AI.sq_hill_cov_pod_2);
	ai_place(AI.sq_hill_cov_pod_3);
	ai_place(AI.sq_hill_cov_pod_4);
	ai_object_set_targeting_bias( AI.sq_hill_cov_pod_1.spawn_points_0, -0.4 );
	ai_prefer_target_ai( AI.sq_musketeer, AI.sg_hill_for, true );
	--ai_prefer_target_ai( AI.sq_hill_cov_pod_1, AI.sg_hill_for, true );
	SlipSpaceSpawn(AI.sq_hill_w1_front_01);
	SlipSpaceSpawn(AI.sq_hill_w1_front_02);
	SlipSpaceSpawn(AI.sq_hill_w1_right_01);
	SlipSpaceSpawn(AI.sq_hill_w1_right_02);

	game_save_no_timeout();
	garbage_collect_now();
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_10) or obj_con_hill >= 10], 1);
	CreateThread(train_grenade);
	garbage_collect_now();
	print("OBJCONHILL10");
	if obj_con_hill < 10 then
		obj_con_hill = 10
	end

	SlipSpaceSpawn(AI.sq_hill_w1_right_03);
	SlipSpaceSpawn(AI.sq_hill_w1_right_04);
	SlipSpaceSpawn(AI.sq_hill_ledge_for_01);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_15) or obj_con_hill >= 15], 1);
	game_save_no_timeout();
	garbage_collect_now();
	
	if obj_con_hill < 15 then
		obj_con_hill = 15
	end
	SlipSpaceSpawn(AI.sq_hill_w2_mid_01);
	SlipSpaceSpawn(AI.sq_hill_w2_mid_02);
	SlipSpaceSpawn(AI.sq_hill_w2_mid_03);
	SlipSpaceSpawn(AI.sq_hill_w2_mid_04);
	SlipSpaceSpawn(AI.sq_hill_w2_right_01);
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_20) or obj_con_hill >= 20], 1);
	print("OBJCONHILL20");
	game_save_no_timeout();
	garbage_collect_now();
	if obj_con_hill < 20 then
		obj_con_hill = 20
	end
	

	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_30) or obj_con_hill >= 30], 1);
	print("OBJCONHILL30");
	game_save_no_timeout();
	if obj_con_hill < 30 then
		obj_con_hill = 30
	end
	CreateThread(cheevo_enemymine_helper);
	garbage_collect_now();
	SlipSpaceSpawn(AI.sq_hill_w2_back_01);
		
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_40) or obj_con_hill >= 40], 1);
	b_kraken_leave = true;
	print("OBJCONHILL40");
	
	CreateThread (audio_halsey_thread_up_hill_secondwave);
	
	SlipSpaceSpawn(AI.sq_hill_holdout_for_06);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_07);
	if obj_con_hill < 40 then
		obj_con_hill = 40
	end
	garbage_collect_now();
	
	if ai_living_count(AI.sg_hill_cov) > 0 then
		pup_play_show("vin_sol_v_elite");
	else
		SlipSpaceSpawn(AI.sq_hill_holdout_for_01);
		SlipSpaceSpawn(AI.sq_hill_holdout_for_01_01);
	end
	
	sleep_s(0.5);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_02);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_03);
	sleep_s(1);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_08);
	sleep_s(2);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_04);
	SlipSpaceSpawn(AI.sq_hill_holdout_for_05);
	sleep_s(5);
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_objcon_50)], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 50 then
		obj_con_hill = 50
	end
	sleep_s(1);
	SleepUntil([| (ai_living_count(AI.sq_hill_holdout_for_04) + ai_living_count(AI.sq_hill_holdout_for_05)) <= 0], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 60 then
		obj_con_hill = 60
	end
	render_low_res_transparents = true;
	CreateThread(audio_halsey_thread_up_hill_end);
	CreateThread(hillExitDoor);
end

function hillExitDoor()
	device_set_power(OBJECTS.dm_hallway_door_01, 1);
	device_set_position(OBJECTS.dm_hallway_door_01, 1);	
	SleepUntil ([| device_get_position(OBJECTS.dm_hallway_door_01) == 1 ], 1);
	ai_enable_jump_hint( HINTS.jh_hill_hallway );
	ai_enable_jump_hint( HINTS.jh_hill_hallway01 );
	ai_enable_jump_hint( HINTS.jh_hill_hallway02 );
end

function jumpHintControl_hillCenter()
	ai_disable_jump_hint( HINTS.jh_hill_sb_center );
	sleep_s(1);
	SleepUntil([| object_get_recent_body_damage( OBJECTS.sc_shoulderbash_hill01 ) > 0.5 or volume_test_players(VOLUMES.tv_jh_hill_center_backupcheck) ], 1);
	ai_enable_jump_hint( HINTS.jh_hill_sb_center );
end

function jumpHintControl_hillRight()
	ai_disable_jump_hint( HINTS.jh_hill_sb_right );
	sleep_s(1);
	SleepUntil([| object_get_recent_body_damage( OBJECTS.sc_shoulderbash_hill05 ) > 0.5 or volume_test_players(VOLUMES.tv_jh_hill_right_backupcheck) ], 1);
	ai_enable_jump_hint( HINTS.jh_hill_sb_right );
end

function hillLivingObjCon()
	print("stuff");
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_hill_all) < 11 or obj_con_hill >= 10 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 10 then
		obj_con_hill = 10
	end
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_hill_all) < 10 or obj_con_hill >= 15 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 15 then
		obj_con_hill = 15
	end
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_hill_all) < 7 or obj_con_hill >= 20 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 20 then
		obj_con_hill = 20
	end
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_hill_all) < 5 or obj_con_hill >= 30 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 30 then
		obj_con_hill = 30
	end
	sleep_s(7);
	SleepUntil([| ai_living_count(AI.sg_hill_all) < 4 or obj_con_hill >= 40 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 40 then
		obj_con_hill = 40
	end
	sleep_s(5);
	SleepUntil([| ai_living_count(AI.sg_hill_holdout) < 7 or obj_con_hill >= 50 ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 50 then
		obj_con_hill = 50
	end
	sleep_s(5);
	SleepUntil([| ai_living_count(AI.sg_hill_holdout) < 5 or obj_con_hill >= 60  or volume_test_players(VOLUMES.tv_hill_bunker) ], 1);
	CreateThread(cheevo_enemymine_helper);
	if obj_con_hill < 60 then
		obj_con_hill = 60
	end
	ai_prefer_target_ai( AI.sq_musketeer, AI.sg_hill_for, false );
	
end

function playfightSwitch()
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_playfight_over)], 1);
	b_hill_playfight = false;
end

function turret_comps_hill()
	local show_1:number = pup_play_show("comp_skybox_turret_hill01");
	sleep_s(1);
	local show_2:number = pup_play_show("comp_skybox_turret_hill02");
	sleep_s(2);
	local show_3:number = pup_play_show("comp_skybox_turret_hill03");
	sleep_s(20);
	SleepUntil([| obj_con_hill >= 10], 1, seconds_to_frames(60));
	n_turretTarget = 1;
	SleepUntil([|b_targetingTurret], 1, seconds_to_frames(15));
	b_targetingTurret = false;
	pup_stop_show( show_1 );
	DestroyTurret(OBJECT_NAMES.dm_for_tracer06);
	sleep_s(1);
	n_turretTarget = 2;
	SleepUntil([| obj_con_hill >= 30], 1, seconds_to_frames(60));
	n_turretTarget = 3;
	sleep_s(1);
	SleepUntil([|b_targetingTurret], 1, seconds_to_frames(15));
	b_targetingTurret = false;
	pup_stop_show( show_2 );
	DestroyTurret(OBJECT_NAMES.dm_for_tracer07);
	sleep_s(1);
	n_turretTarget = 4;
	SleepUntil([| obj_con_hill >= 40], 1, seconds_to_frames(60));
	n_turretTarget = 5;
	sleep_s(2);
	SleepUntil([|b_targetingTurret], 1, seconds_to_frames(15));
	b_targetingTurret = false;
	pup_stop_show( show_3 );
	DestroyTurret(OBJECT_NAMES.dm_for_tracer08);
	sleep_s(1);
	n_turretTarget = 6;
end

function aiPlaceTowerTurret( turret:object, guy:ai)
	ai_place(guy);
	Sleep(1);
	vehicle_load_magic( object_at_marker( turret, "turret_1_a" ), "", guy );
end

function kraken_init()
	if pup_is_playing(n_kraken_show) then
		pup_stop_show( n_kraken_show )
		sleep_s(0.25);
	end
	--RunClientScript("ShakeHard");
	pup_play_show("vin_sentry_ship_hill");
	sleep_s(0.25);
	object_cannot_die( OBJECTS.krakscen, true );
	object_cannot_take_damage( OBJECTS.krakscen );
	CreateThread(kraken_perf_boost);
	SleepUntil([|b_kraken_fill],1);
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_1, "mid_turret_3", "cs_krak_turret01");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_2, "top_turret_3", "cs_krak_turret02");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_3, "mid_turret_4", "cs_krak_turret03");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_4, "low_turret_3", "cs_krak_turret04");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_5, "low_turret_4", "cs_krak_turret05");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_6, "low_turret_5", "cs_krak_turret06");
	kraken_turret_activate(AI.sq_hill_cov_kraken.spawn_points_7, "low_turret_6", "cs_krak_turret07");
	SleepUntil([|b_kraken_leave],1);
	--narrative
	b_kraken_leaving = true;
	CreateThread(rumble_shake_small, 3);
	--replace when vignette leaves.
	ai_kill(AI.sq_hill_cov_kraken);
end

function kraken_perf_boost()
	object_destroy(object_at_marker(OBJECTS.krakscen, "top_turret_1"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "top_turret_2"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "low_turret_1"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "low_turret_2"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "low_turret_7"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "low_turret_8"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "mid_turret_1"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "mid_turret_2"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "mid_turret_5"));
	object_destroy(object_at_marker(OBJECTS.krakscen, "mid_turret_6"));
end

function cs_krak_turret01()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets01, 1, OBJECT_NAMES.dm_for_tracer06); 
end

function cs_krak_turret02()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets02, 1, OBJECT_NAMES.dm_for_tracer06);
end

function cs_krak_turret03()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets03, 5, OBJECT_NAMES.dm_for_tracer08);
end

function cs_krak_turret04()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets04, 5, OBJECT_NAMES.dm_for_tracer08);
end

function cs_krak_turret05()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets05, 3, OBJECT_NAMES.dm_for_tracer07);
end

function cs_krak_turret06()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets06, 3, OBJECT_NAMES.dm_for_tracer07);
end

function cs_krak_turret07()
	kraken_turret_shoot(POINTS.ps_karkTurretTargets07, 1, OBJECT_NAMES.dm_for_tracer06); 
end

global n_turretTarget:number = 0;
global b_targetingTurret:boolean = false;

function kraken_turret_shoot(source_point:point_set, turret:number, turret_object:object_name)
	local set_current:point = source_point[1];
	local set_new:point = source_point[1];
	local shoot_turret:point = source_point[10];
	local turretShot:boolean = false;
	sleep_s(17);
	repeat	
			if n_turretTarget == turret and not turretShot then 
					print("SHJOOTINGTURRET");
					cs_shoot_point( ai_current_actor, true, shoot_turret);
					sleep_s(2);
					cs_shoot_point( ai_current_actor, true, shoot_turret);
					b_targetingTurret = true;
					sleep_s(1);
					cs_shoot_point( ai_current_actor, true, source_point[1]);
					turretShot = true;
					print("STOPSHOOTINGTURRET");
			end
		set_new = source_point[random_range(1,9)];

		if set_current ~= set_new and set_current ~= shoot_turret then
				set_current = set_new;
				cs_shoot_point( ai_current_actor, true, set_current);
		end

		sleep_s(random_range (4, 7));
	until(1 == 0);
end

function DestroyTurret(turretName:object_name)
	object_dissolve_from_marker( ObjectFromName(turretName), "incineration", "audio_center" );
	RunClientScript("TurretDissolve", ObjectFromName(turretName));
	sleep_s(3.25);
	object_destroy(ObjectFromName(turretName));
end

function kraken_turret_activate(driver:ai, marker:string, command_script:string):void
	ai_place(driver);
	Sleep(2);
	vehicle_load_magic (object_at_marker(OBJECTS.krakscen, marker), "", driver);
	cs_run_command_script( driver, command_script);
end

function turretHitEffect(obj:object, target:number)

	if obj == OBJECTS.dm_for_tracer06 or obj == OBJECTS.dm_for_tracer07 or obj == OBJECTS.dm_for_tracer08 then
		if object_index_valid(obj) then
			if target == 1 then
				CreateEffectGroup( turretHitEffect01(obj) );
				sleep_s(4);
				if object_index_valid(obj) then
					StopEffectGroup( turretHitEffect01(obj) );
				end
			elseif target == 2 then
				CreateEffectGroup( turretHitEffect02(obj) );
				sleep_s(4);
				if object_index_valid(obj) then
					StopEffectGroup( turretHitEffect02(obj) );
				end
			elseif target == 3 then
				CreateEffectGroup( turretHitEffect03(obj) );
				sleep_s(4);
				if object_index_valid(obj) then
					StopEffectGroup( turretHitEffect03(obj) );
				end
			end
		end
	end
end

function turretHitEffect01(obj:object):effect_placement
	if obj == OBJECTS.dm_for_tracer06 then
		return EFFECTS.eg_t_hill1_target01
	elseif obj == OBJECTS.dm_for_tracer07 then
		return EFFECTS.eg_t_hill2_target01
	elseif obj == OBJECTS.dm_for_tracer08 then
		return EFFECTS.eg_t_hill3_target01
	end
	return EFFECTS.eg_t_hill1_target01
end

function turretHitEffect02(obj:object):effect_placement
	if obj == OBJECTS.dm_for_tracer06 then
		return EFFECTS.eg_t_hill1_target02
	elseif obj == OBJECTS.dm_for_tracer07 then
		return EFFECTS.eg_t_hill2_target02
	elseif obj == OBJECTS.dm_for_tracer08 then
		return EFFECTS.eg_t_hill3_target02
	end
	return EFFECTS.eg_t_hill1_target02
end

function turretHitEffect03(obj:object):effect_placement
	if obj == OBJECTS.dm_for_tracer06 then
		return EFFECTS.eg_t_hill1_target03
	elseif obj == OBJECTS.dm_for_tracer07 then
		return EFFECTS.eg_t_hill2_target03
	elseif obj == OBJECTS.dm_for_tracer08 then
		return EFFECTS.eg_t_hill3_target03
	end
	return EFFECTS.eg_t_hill1_target03
end

--========================================================
--GOAL VAULT
--========================================================
 missionHalsey.goal_halsey_hallway = 
	{
	gotoVolume = VOLUMES.tv_goal_09_vault,
	zoneSet = ZONE_SETS.zn_hill,
	next={"goal_halsey_vault"}
	}

function missionHalsey.goal_halsey_hallway.Start() :void		
	--CreateThread(audio_halsey_thread_up_hill_end);
	CreateThread(set_objective_blip, 10);
	CreateThread(flocksVault, true);
	sleep_s(4);
	CreateThread(ZoneSwapVaultRegroup, ZONE_SETS.zn_vault);
	game_save_no_timeout();
	garbage_collect_now();
	
end

function ZoneSwapVaultRegroup(zone:zone_set)
	print("vault_teleport");
	device_set_power(OBJECTS.dm_hallway_door_01, 0);	
	device_set_position(OBJECTS.dm_hallway_door_01, 0);	
	SleepUntil ([| device_get_position(OBJECTS.dm_hallway_door_01) == 0 ], 1);
	sleep_s(1);
	volume_teleport_players_not_inside( VOLUMES.tv_vault_regroup, FLAGS.fl_hallway_teleport );
		if current_zone_set_fully_active() ~= zone then
			prepare_to_switch_to_zone_set( zone );
			sleep_s(5);
			SleepUntil([| not PreparingToSwitchZoneSet() ], 1);
			Sleep(1);
			switch_zone_set( zone );
		end
end


--========================================================
--GOAL VAULT
--========================================================
function knightShowLookat()
	repeat
		SleepUntil ([| volume_test_players_lookat(VOLUMES.tv_hallway_lookat, 5, 5) and current_zone_set_fully_active() == ZONE_SETS.zn_vault ], 1);
		sleep_s(1);
		if volume_test_players_lookat(VOLUMES.tv_hallway_lookat, 5, 5) then
				CreateThread(nar_knight_breach_start);
				b_vault_show = true
		end	
	until b_vault_show
end



 missionHalsey.goal_halsey_vault = 
	{
	zoneSet = ZONE_SETS.zn_vault,
	}

function missionHalsey.goal_halsey_vault.Start() :void		
	if is_blink then
		is_blink = false;
	end
	print("goal_halsey_vault");
	game_save_no_timeout();
	garbage_collect_now();
	CreateThread(set_objective_blip, 11);

	--narstuff
	GoalCreateThread(missionHalsey.goal_halsey_vault, nar_goal_halsey_vault);
	
	
	ai_allegiance_break( TEAM.player, TEAM.covenant);
	CreateThread(knightShowLookat);

	SleepUntil ([| b_vault_show], 1);
	ai_place(AI.sg_vault_cov);	
	CreateThread(shield_stun_ai, AI.sq_vault_cov_04);
	CreateThread(shield_stun_ai, AI.sq_vault_cov_05);
	sleep_s(0.5);
	pup_play_show("vin_knight_reveal");
	sleep_s(4);
	game_save_no_timeout();
	
	b_hallway_hacked = true;	
	device_set_power(OBJECTS.dm_hallway_hack_door_02, 1);
	sleep_s(1.5);
	print("STARTSHOW");
	local knight_show:number = pup_play_show("vin_knights_attack");		
	
	SleepUntil([|volume_test_players(VOLUMES.tv_vault_objcon_10) or not pup_is_playing(knight_show) ] ,1);
	obj_con_vault = 10;
	game_save_no_timeout();
	CreateThread(tutOrders);
	SlipSpaceSpawn( AI.sq_vault_pawn_01);
	sleep_s(1);
	SlipSpaceSpawn( AI.sq_vault_pawn_02);
	sleep_s(1);
	SlipSpaceSpawn( AI.sq_vault_pawn_03);

	unit_only_takes_damage_from_players_team(ai_get_object(AI.sg_vault_pawn), true);
	unit_only_takes_damage_from_players_team(ai_get_object(AI.sg_vault_knight), true);
	CreateThread(crawler_reinforce);
	SleepUntil([|ai_living_count(AI.sg_vault_knight) < 2],1);
	game_save_no_timeout();
	obj_con_vault = 20;
	sleep_s(2);
	SlipSpaceSpawn(AI.sq_vault_knight_05);
	SlipSpaceSpawn(AI.sq_vault_pawn_04);
	SlipSpaceSpawn(AI.sq_vault_pawn_05);
	CreateThread(AudioCheckEnemyCount, AI.sg_vault, 1, audio_halsey_thread_up_vault_end);
	sleep_s(5);
	SleepUntil([|ai_living_count(AI.sg_vault) <= 3 ],1);
	game_save_no_timeout();
	obj_con_vault = 25;
	sleep_s(3);
	CreateThread(mysteryBlockerHackFix);
	SleepUntil([|ai_living_count(AI.sg_vault) <= 0 or obj_con_vault >= 30 ],1);
	ee_vault_valid = true;
	if obj_con_vault < 30 then	
		sleep_s(random_range(4,7));
		obj_con_vault = 30;
	end
	
	CreateThread(tutTrackRefresh)
	print("goal_halsey_control_room");
	game_save_no_timeout();
	--narstuff
	CreateThread(nar_goal_halsey_control_room);
	SleepUntil([| volume_test_players(VOLUMES.tv_goal_10_control_room)], 1);
	CreateThread(flocksVault, false);
	CreateThread(audio_halsey_stopallmusic);
	EndMission(missionHalsey);
end

function mysteryBlockerHackFix()
	sleep_s(60);
	SleepUntil([| volume_test_players(VOLUMES.tv_vault_hackfix)],1);
	if obj_con_vault < 30 then
		obj_con_vault = 30
		ai_kill(AI.sg_vault);
	end
end

function tutTrackRefresh()
	SleepUntil([| volume_test_players(VOLUMES.tv_goal_10_control_room) ], 1, 15);
	if not volume_test_players(VOLUMES.tv_goal_10_control_room) then
		CreateThread(train_tracking);
	end
end

global ordersGiven:number = 0
global ordersRecent:boolean = false;

function tutOrdersCallback()
	print("ordersCALLBACK");
	ordersGiven = ordersGiven + 1;
	ordersRecent = true;
end

function tutOrders()
	CreateThread(training_orders_enemy);
	CreateThread(RegisterMusketeerOrderEvent, tutOrdersCallback);
	sleep_s(25);
	if game_difficulty_get() ~= DIFFICULTY.legendary then
		repeat
			print("ordersLOOP");
			if ordersRecent then 
				sleep_s(40);
				ordersRecent = false
				print("ordersRECENTFALSE");
			end
			
			if not ordersRecent and ordersGiven < 3 then
				print("orders");
				CreateThread(training_orders_enemy);
			end
			
			sleep_s(40);
		until obj_con_vault >= 30 or ordersGiven > 3
	end
end

function crawler_reinforce()
	sleep_s(7);
	SleepUntil([|ai_living_count(AI.sg_vault_pawn) < 2 or ai_living_count(AI.sg_vault_knight) < 2],1);
	SlipSpaceSpawn(AI.sq_vault_pawn_03);
	SlipSpaceSpawn(AI.sq_vault_pawn_04);
end

function cs_elite_turret()
	object_set_shield_stun_infinite( ai_get_object(ai_current_actor) );
	object_set_shield( ai_get_object(ai_current_actor), 0 );
	repeat
	cs_shoot_point(ai_current_actor, true, POINTS.ps_vault.p1 );
	object_set_health(ai_get_object(ai_current_actor), 0.1);
	sleep_s(2);
	until ai_living_count(AI.sq_vault_knight_04.spawn_points_0) <= 0;
end

function cs_shield_stun_intro()
	object_set_shield_stun_infinite( ai_get_object(ai_current_actor) );
	object_set_shield( ai_get_object(ai_current_actor), 0 );
end

function cs_knight_prefer_turret()
	ai_prefer_target_ai( ai_current_actor, AI.sq_vault_cov_01, true );
end

function cs_shield_stun()
	object_set_shield_stun_infinite( ai_get_object(ai_current_actor) );
	object_set_shield( ai_get_object(ai_current_actor), 0 );
end

function shield_stun_ai(guy:ai)
	sleep_s(1);
	object_set_shield_stun_infinite( ai_get_object(guy) );
	object_set_shield( ai_get_object(guy), 0 );
	object_set_health(ai_get_object(guy), 0.1);
end

function vault_knight_damage(knight:object, region:string)
		object_damage_damage_section( knight, region, 300 );
		object_damage_damage_section( knight, "body", 50 );
end

function vault_knight_damage_no_body(knight:object, region:string)
		object_damage_damage_section( knight, region, 60 );
end

function killKnight()
	print("go");
	RunClientScript("dissolveKnight");
end



--========================================================
--Musketeers
--========================================================
function halseyMuskClearOrder()
	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
		MusketeerDestClear(obj);
	end
end

function musketeerControlCliff()
	local b_centerMusk:boolean = false;
	local b_leftMusk:boolean   = false;
	local b_rightMusk:boolean  = false;
	local b_frontMusk:boolean = false;
	local b_midMusk:boolean   = false;
	print("start");
	CreateThread(muskCliffOrderClear);
	halseyMuskClearOrder();
	sleep_s(1);	
	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_rightMusk then
				b_frontMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_00_front, 0.25);	
			elseif not b_leftMusk then
				b_midMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_00_mid, 0.25);
			elseif not b_centerMusk then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_00_back, 0.25);
			end
	end
	
	SleepUntil([| volume_test_players( VOLUMES.tv_cliff_musk_10) ], 1);	
		halseyMuskClearOrder();
		sleep_s(1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_rightMusk then
				b_rightMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_right, 3);	
			elseif not b_leftMusk then
				b_leftMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_left, 3);
			elseif not b_centerMusk then
				b_centerMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_center, 3);
			end
		end
	SleepUntil([| volume_test_players( VOLUMES.tv_cliff_musk_20) ], 1);	
		halseyMuskClearOrder();
		sleep_s(1);
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_rightMusk then
				b_rightMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_right, 3);	
			elseif not b_leftMusk then
				b_leftMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_left, 3);
			elseif not b_centerMusk then
				b_centerMusk = true;
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_cliff_01_center, 3);
			end
		end
	SleepUntil([| volume_test_players( VOLUMES.tv_cliff_objcon_30) or not volume_test_players(VOLUMES.tv_cliff_musk_orders) ], 1);	
		halseyMuskClearOrder();
end

function muskCliffOrderClear()
	SleepUntil([| not volume_test_players(VOLUMES.tv_cliff_musk_orders) ], 1);	
		halseyMuskClearOrder();
end

function muskControlCragAll()
	CreateThread(musketeerControlCrag01);
	CreateThread(musketeerControlCrag02);
	CreateThread(musketeerControlCrag03);
end

function musketeerControlCrag01()
	local b_gateBuddySet:boolean = false;
	
	SleepUntil([| volume_test_players( VOLUMES.tv_crag_musk_01_right) or volume_test_players(VOLUMES.tv_crag_musk_01_left) ], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_crag_musk_01_right) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_01_left, 3);	
			elseif volume_test_players(VOLUMES.tv_crag_musk_01_left) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_01_right, 3);
			end
		end
	SleepUntil([| obj_con_crag >= 20 ], 1, seconds_to_frames(70));	
	halseyMuskClearOrder();
end

function musketeerControlCrag02()
	local b_gateBuddySet:boolean = false;
	
	SleepUntil([| volume_test_players( VOLUMES.tv_crag_musk_02_right) or volume_test_players(VOLUMES.tv_crag_musk_02_left) ], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_crag_musk_02_right) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_02_left, 5);	
			elseif volume_test_players(VOLUMES.tv_crag_musk_02_left) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_02_right, 3);
			end
		end
	SleepUntil([| obj_con_crag >= 40 ], 1, seconds_to_frames(100));	
	halseyMuskClearOrder();
end

function musketeerControlCrag03()
	local b_gateBuddySet:boolean = false;

	SleepUntil([| volume_test_players( VOLUMES.tv_crag_musk_03_right) or volume_test_players(VOLUMES.tv_crag_musk_03_left) ], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_crag_musk_03_right) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_03_left, 5);	
			elseif volume_test_players(VOLUMES.tv_crag_musk_03_left) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_crag_03_right, 4);
			end
		end
	SleepUntil([|  obj_con_crag >= 50  ], 1, seconds_to_frames(100));	
	halseyMuskClearOrder();
end

function musketeerControlAirlock()
	local b_down_left:boolean = false;
	local b_down_right:boolean = false;
	
	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
		if not b_down_left then
			b_down_left = true;
			MusketeerDestSetPoint(obj, FLAGS.fl_musk_airlock_01, 2);	
		elseif not b_down_right then
			b_down_right = true;
			MusketeerDestSetPoint(obj, FLAGS.fl_musk_airlock_02, 2);	
		else
			MusketeerDestSetPoint(obj, FLAGS.fl_musk_airlock_03, 2);
		end
	end
end

function musketeerControlHill()
	local b_gateBuddySet:boolean = false;
	
	SleepUntil([| volume_test_players( VOLUMES.tv_hill_trench_right) or volume_test_players(VOLUMES.tv_hill_trench_left) or volume_test_players(VOLUMES.tv_hill_trench_middle) or obj_con_hill >= 20 ], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_hill_trench_right) or volume_test_players(VOLUMES.tv_crag_musk_01_right) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_center, 5);	
			elseif volume_test_players(VOLUMES.tv_hill_trench_middle) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_left, 5);
			end
		end 
	SleepUntil([| obj_con_hill >= 20 ], 1, seconds_to_frames(90));	
	halseyMuskClearOrder();
	sleep_s(1);
	SleepUntil([| volume_test_players( VOLUMES.tv_hill_trench_right) or volume_test_players(VOLUMES.tv_hill_trench_left) or volume_test_players(VOLUMES.tv_hill_trench_middle) or obj_con_hill >= 30], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_hill_trench_right) or volume_test_players(VOLUMES.tv_crag_musk_01_right) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_center_02, 5);	
			elseif volume_test_players(VOLUMES.tv_hill_trench_middle) then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_left_02, 5);
			end
		end 
	SleepUntil([| obj_con_hill >= 30 ], 1, seconds_to_frames(90));	
	halseyMuskClearOrder();
	sleep_s(1);
	SleepUntil([| volume_test_players( VOLUMES.tv_hill_holdout_right) or volume_test_players(VOLUMES.tv_hill_bunker) ], 1);	
		for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do	
			if not b_gateBuddySet then
				b_gateBuddySet = true;
			elseif volume_test_players(VOLUMES.tv_hill_holdout_right)  then
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_holdout_left, 5);	
			else
				MusketeerDestSetPoint(obj, FLAGS.fl_musk_hill_holdout_right, 5);	
			end
		end 
	SleepUntil([| volume_test_players(VOLUMES.tv_hill_bunker) ], 1, seconds_to_frames(90));	
	halseyMuskClearOrder();
end

--Objective Blips
function set_objective_blip(blip:number)
	clearObjectiveBlips();
	sleep_s(0.25);
	object_create(t_objectiveList[blip]);
end

global t_objectiveList:table=
	{
		OBJECT_NAMES.track_objblip_01,
		OBJECT_NAMES.track_objblip_02,	
		OBJECT_NAMES.track_objblip_03,
		OBJECT_NAMES.track_objblip_04,		
		OBJECT_NAMES.track_objblip_05,		
		OBJECT_NAMES.track_objblip_06,		
		OBJECT_NAMES.track_objblip_07,
		OBJECT_NAMES.track_objblip_08,
		OBJECT_NAMES.track_objblip_09,
		OBJECT_NAMES.track_objblip_10,
		OBJECT_NAMES.track_objblip_11
	};
	
function clearObjectiveBlips()
	for _,blip in ipairs(t_objectiveList) do
		if object_valid(blip) then	
			object_destroy(blip);	
		end
	end
end

--========================================================
--CHEEVO
--========================================================
function cheevo_enemymine()
	if game_difficulty_get() == DIFFICULTY.heroic or game_difficulty_get() == DIFFICULTY.legendary then
		SleepUntil([| obj_con_hill >= 50 or ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) < 1 ], 1);
			if ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) > 0 then
				CreateThread(cheevo_allegianceControl);
				sleep_s(1);
			end
		SleepUntil([| obj_con_hill >= 60 or ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) < 1 ], 1);
			if ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) > 0 then 
				cs_run_command_script( AI.sq_hill_cov_pod_1.spawn_points_0, "cs_enemyMine");
				sleep_s(1);
			end
		SleepUntil([| volume_test_objects(VOLUMES.tv_hill_bunker, ai_get_object(AI.sq_hill_cov_pod_1.spawn_points_0)) or ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) <= 0], 1);
			if ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) > 0 then				
				print("CHEEVO UNLOCKED: ENEMY MINE");
				CampaignScriptedAchievementUnlocked(2); 
			end
	end
end

function cheevo_allegianceControl()	
	ai_allegiance( TEAM.player, TEAM.covenant);
	sleep_s(1);
	SleepUntil([| ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) < 1 ], 1);
	ai_allegiance_break( TEAM.player, TEAM.covenant);
end

function cheevo_enemymine_helper()
	local generalAlive:boolean = ai_living_count(AI.sq_hill_cov_pod_1.spawn_points_0) > 0
	local	generalObject:object = ai_get_object(AI.sq_hill_cov_pod_1.spawn_points_0)
	local difficultyValid:boolean = game_difficulty_get() == DIFFICULTY.heroic or game_difficulty_get() == DIFFICULTY.legendary
	
	if  difficultyValid and generalAlive then
		if object_get_shield(generalObject) < 0.5 then
			object_set_shield(generalObject, 0.5 );
		elseif object_get_shield(generalObject) < 1 then
			object_set_shield(generalObject, 0.75 );
		end
	
		if object_get_health(generalObject) < 0.5 then
			object_set_health(generalObject, 0.5 );
		elseif object_get_health(generalObject) < 0.75 then
			object_set_health(generalObject, 0.75 );
		elseif object_get_health(generalObject) < 1 then
			object_set_health(generalObject, 1 );
		end
	end	
end

function cs_enemyMine()
	cs_go_to(POINTS.ps_hill_enemymine.p1);
end

function cheevo_teamWeapon()

	CreateThread(cheevo_teamWeaponUnregisterEvent);
	print("CHEEVO UNLOCKED: TEAM WEAPON");
	CampaignScriptedAchievementUnlocked(1); 
end

function cheevo_teamWeaponUnregisterEvent()
	CreateThread(UnregisterMusketeerOrderEvent, cheevo_teamWeapon);
end

--==============================
--OBJECTIVES UTILITY
--================================
function new_objective(obj_new:title, b_complete_previous:boolean)
	ObjectiveShow(obj_new);	
end

function objective_complete()
		ObjectiveShow(TITLES.obj_halsey_complete);	
end


--=========================================================
-- TUTORIALS/TRAINING
--=========================================================

function train_move()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_movement", TUTORIAL.Movement, 5, true);
	end
end

function train_look()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_camera", TUTORIAL.Camera, 5, true);
	end
end

function train_sprint()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_sprint", TUTORIAL.Sprint, 5, true);
	end
end

function train_shoot()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_shoot", TUTORIAL.Shoot, 5, true);
	end
end

function train_jump()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_jump", TUTORIAL.Jump, 5, true);
	end
end

function train_climb(vol_start:volume, vol_end:volume)
	for _,player in ipairs(players()) do
		CreateThread(train_players_volume_gate_delayed, player, vol_start, vol_end, "training_clamber", "training_clamber_halsey_01", false);
	end
end

function train_charge(vol_start:volume, vol_end:volume)
	for _,player in ipairs(players()) do
		CreateThread(train_players_volume_gate_delayed, player, vol_start, vol_end, "training_charge", "training_charge_halsey_01", true);
	end
end

function train_zoom()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_zoom", TUTORIAL.Zoom, 5, false);
	end
end

function train_thrust()
	for _,player in ipairs(players()) do
		CreateThread(train_players_if_not_performed, "training_thruster", TUTORIAL.Thruster, 5, false);
	end
end

function train_groundPound(trig:volume)
	for _,player in ipairs(players()) do
		CreateThread(train_players_volume_if_not_performed, player, "training_groundpound", TUTORIAL.GroundPound, 5, trig);
	end
end

function train_tracking()
	for _,player in ipairs(players()) do
		CreateThread(train_players_track, player, "training_ping", TUTORIAL.Tracking);
	end
end

function train_grenade()
	for _,player in ipairs(players()) do
		if unit_get_total_grenade_count( player ) > 0 and game_difficulty_get() == DIFFICULTY.normal then
			CreateThread(train_players_if_not_performed, "training_grenade", TUTORIAL.Grenade, 5, false);
		end
	end
end

function training_orders_enemy()
	CreateThread(train_players_if_not_performed, "training_orders_target", TUTORIAL.OrdersEnemy, 5, false);
end

--UTILITY
function train_players_if_not_performed(train_mechanic:string, mechanic_id:tutorial, n_time:number, only_normal:boolean)
	if not only_normal or game_difficulty_get() == DIFFICULTY.normal then
		 TutorialShowAllIfNotPerformed(train_mechanic, mechanic_id, 5);
			sleep_s(n_time);
		 TutorialStopAll(); 
	end
end

function train_players_volume_if_not_performed(p_player:object, train_mechanic:string, mechanic_id:tutorial, n_time:number, trig:volume)
	SleepUntil([| volume_test_objects(trig, p_player)], 1);
	 TutorialShowIfNotPerformed(unit_get_player(p_player), train_mechanic, mechanic_id, 5);		
	sleep_s(n_time);
	 TutorialStop(p_player);
end

function train_players_volume_gate_delayed(p_player:object, trig_start:volume, trig_end:volume, train_mechanic:string, blocking_id:string, kill_for_all:boolean)
		repeat
			SleepUntil([| volume_test_objects(trig_start, p_player) or volume_test_objects(trig_end, p_player)], 1);
			 if not volume_test_objects(trig_end, p_player) then
				 TutorialShowStartDelayed(unit_get_player(p_player), train_mechanic, blocking_id);
				end
			SleepUntil([| not volume_test_objects(trig_start, p_player) or volume_test_objects(trig_end, p_player) ], 1);
				if not volume_test_objects(trig_start, p_player) then
					TutorialStopAndMark(unit_get_player(p_player), blocking_id);
				end
		until volume_test_objects(trig_end, p_player)
		 if kill_for_all then
		 	for _,player in ipairs(players()) do
				 TutorialStopAndMark(unit_get_player(p_player), blocking_id); 
		 	end
		 else
		 	TutorialStopAndMark(unit_get_player(p_player), blocking_id); 
		 end
end

function train_players_track(p_player:object, train_mechanic:string, mechanic_id:tutorial)
	 TutorialShowIfNotPerformed(unit_get_player(p_player), train_mechanic, mechanic_id, 5);	
		SleepUntil([| b_airlock_tracking], 1);
	 TutorialStop(unit_get_player(p_player));
end

function ee_vault_scale01()
	object_set_scale(ai_current_actor, 1.70, 0);
end

function ee_vault_goto()
	cs_go_to(POINTS.ps_vault_cav_ee.p0)
end


global ee_active_count:number = 0
global ee_vault_valid:boolean = false;
function ee_setup()
	if game_difficulty_get() == DIFFICULTY.legendary then
			ee_switch(OBJECT_NAMES.ee_blade01, OBJECT_NAMES.cr_ee_switch01, EFFECTS.fx_ee_01); 
		SleepUntil([| ee_active_count >= 1 ], 1);
			CreateThread(ee_weaponSwap);
			ee_switch(OBJECT_NAMES.ee_blade02, OBJECT_NAMES.cr_ee_switch02, EFFECTS.fx_ee_02); 
		SleepUntil([| ee_active_count >= 2 ], 1);
			ee_switch(OBJECT_NAMES.ee_blade03, OBJECT_NAMES.cr_ee_switch03, EFFECTS.fx_ee_03);
		SleepUntil([| ee_active_count >= 3 ], 1);
			ee_switch(OBJECT_NAMES.ee_blade04, OBJECT_NAMES.cr_ee_switch04, EFFECTS.fx_ee_04); 
		SleepUntil([| ee_active_count >= 4 ], 1);
			ee_switch(OBJECT_NAMES.ee_blade05, OBJECT_NAMES.cr_ee_switch05, EFFECTS.fx_ee_05); 
		SleepUntil([| ee_active_count >= 5 ], 1);
			ee_switch(OBJECT_NAMES.ee_blade06, OBJECT_NAMES.cr_ee_switch06, EFFECTS.fx_ee_06); 
		SleepUntil([| ee_active_count >= 6 and ee_vault_valid ], 1);
			ee_switch(OBJECT_NAMES.ee_blade07, OBJECT_NAMES.cr_ee_switch07, EFFECTS.fx_ee_07); 
		SleepUntil([| ee_active_count >= 7 ], 1);	
		CreateThread(rumble_shake_large, 2);
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		sleep_s(2);

		for _,player in ipairs(players()) do
			unit_add_equipment( player, STARTING_PROFILES.ee_profile, true, true );
		end
	
		SlipSpaceSpawn(AI.sq_vault_ee_guy02);	
		sleep_s(1);
		SlipSpaceSpawn(AI.sq_vault_ee_guy01);
		sleep_s(7);
		SleepUntil([| ai_living_count(AI.sg_vault_ee) < 2 ], 1);
		object_set_scale(AI.sg_vault_ee, 2, 3);
	end
end

function ee_switch(blade:object_name, switch:object_name, fire_fx:effect_placement)
	object_create(blade);
	object_create(switch);
	SleepUntil([| object_get_health( ObjectFromName(switch)) <= 0], 1);
		CreateEffectGroup(fire_fx)
		ee_active_count = ee_active_count + 1;
end

global t_ee_crate_hu:table={
	OBJECT_NAMES.hu_weapon_rack_multi01,
	OBJECT_NAMES.hu_weapon_rack_multi02,
	OBJECT_NAMES.hu_weapon_rack_multi03,
	OBJECT_NAMES.hu_weapon_rack_multi04,
	OBJECT_NAMES.hu_weapon_rack_multi05,
	OBJECT_NAMES.hu_weapon_rack_multi06,
	OBJECT_NAMES.hu_weapon_rack_multi07,
	OBJECT_NAMES.hu_weapon_rack_multi08,
	OBJECT_NAMES.hu_weapon_rack_multi09,
	OBJECT_NAMES.hu_weapon_rack_multi11,
	OBJECT_NAMES.hu_weapon_rack_multi12,
	OBJECT_NAMES.hu_weapon_rack_multi13,
	OBJECT_NAMES.hu_weapon_rack_multi14,
	OBJECT_NAMES.hu_weapon_rack_multi15,
	OBJECT_NAMES.hu_weapon_rack_multi16,
	OBJECT_NAMES.hu_weapon_rack_multi17,
	OBJECT_NAMES.hu_weapon_rack_multi18,
	OBJECT_NAMES.hu_weapon_rack_multi19,
	OBJECT_NAMES.hu_weapon_rack_multi20,
	OBJECT_NAMES.hu_weapon_rack_multi23,
	OBJECT_NAMES.hu_weapon_rack_multi24,
	OBJECT_NAMES.hu_weapon_rack_multi25,
	OBJECT_NAMES.hu_weapon_rack_multi26,
	OBJECT_NAMES.hu_weapon_rack_multi27,
	OBJECT_NAMES.hu_weapon_rack_multi28,
	OBJECT_NAMES.hu_weapon_rack_multi29,
	OBJECT_NAMES.hu_weapon_rack_multi30,
	OBJECT_NAMES.hu_weapon_rack_multi31,
	OBJECT_NAMES.hu_weapon_rack_multi32,
	OBJECT_NAMES.hu_weapon_rack_multi33,
	OBJECT_NAMES.hu_weapon_rack_multi34,
	OBJECT_NAMES.hu_weapon_rack_multi35,
	OBJECT_NAMES.hu_weapon_rack_multi36,
	OBJECT_NAMES.hu_weapon_rack_multi37

		};
global t_ee_crate_for:table={
	OBJECT_NAMES.for_weapon_rack_multi01,
	OBJECT_NAMES.for_weapon_rack_multi02,
	OBJECT_NAMES.for_weapon_rack_multi03,
	OBJECT_NAMES.for_weapon_rack_multi04,
	OBJECT_NAMES.for_weapon_rack_multi05,
	OBJECT_NAMES.for_weapon_rack_multi06,
	OBJECT_NAMES.for_weapon_rack_multi07,
	OBJECT_NAMES.for_weapon_rack_multi08,
	OBJECT_NAMES.for_weapon_rack_multi09,
	OBJECT_NAMES.for_weapon_rack_multi11,
	OBJECT_NAMES.for_weapon_rack_multi12,
	OBJECT_NAMES.for_weapon_rack_multi13,
	OBJECT_NAMES.for_weapon_rack_multi14,
	OBJECT_NAMES.for_weapon_rack_multi15,
	OBJECT_NAMES.for_weapon_rack_multi16,
	OBJECT_NAMES.for_weapon_rack_multi17,
	OBJECT_NAMES.for_weapon_rack_multi18,
	OBJECT_NAMES.for_weapon_rack_multi19,
	OBJECT_NAMES.for_weapon_rack_multi20,
	OBJECT_NAMES.for_weapon_rack_multi23,
	OBJECT_NAMES.for_weapon_rack_multi24,
	OBJECT_NAMES.for_weapon_rack_multi25,
	OBJECT_NAMES.for_weapon_rack_multi26,
	OBJECT_NAMES.for_weapon_rack_multi27,
	OBJECT_NAMES.for_weapon_rack_multi28,
	OBJECT_NAMES.for_weapon_rack_multi29,
	OBJECT_NAMES.for_weapon_rack_multi30,
	OBJECT_NAMES.for_weapon_rack_multi31,
	OBJECT_NAMES.for_weapon_rack_multi32,
	OBJECT_NAMES.for_weapon_rack_multi33,
	OBJECT_NAMES.for_weapon_rack_multi34,
	OBJECT_NAMES.for_weapon_rack_multi35,
	OBJECT_NAMES.for_weapon_rack_multi36,
	OBJECT_NAMES.for_weapon_rack_multi37
		};		
	
function ee_weaponSwap()
	local index:number = 1;
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
		repeat
			SleepUntil([| object_valid( t_ee_crate_for[index] )], 1);
			print("validswap");
			print(index);
			print(t_ee_crate_for[index] );
			object_create(t_ee_crate_hu[index]);
			object_destroy(t_ee_crate_for[index]);
			index = index + 1;
			sleep_s(1);
			print("wait");
			print(index);
		until index >= 35	
end

--========================================================
--CLIENT ONLY BELOW
--========================================================

--## CLIENT
	global b_tracked:boolean = false;


	
-- Flock FX
function startupClient.HalseyStartup()
                FlockEffects("flock_banshee", TAG('levels\campaignworld030\w3_halsey\fx\explosions\flock_banshee_halsey_script_explosion_air_flak.effect'), 1);
end



function remoteClient.airlock_activate_stage_1()
	interpolator_start("airlock_si_materials");
end

function remoteClient.airlock_activate_stage_2()
	interpolator_start ("airlock_center_lights");
end

function remoteClient.airlock_activate_stage_3()
	interpolator_start("airlock_station_lights");
end
	
function remoteClient.fx_snow()
	repeat
	effect_attached_to_camera_new(TAG('levels\campaignworld030\w3_halsey\fx\atmospherics\snow_falling_gentle.effect'));
	SleepUntil([| 
			volume_test_object( VOLUMES.fx_volume_camera_snow_off_01, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_02, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_03, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_04, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_05, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_05a, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_05b, PLAYERS.local0 )
	 or volume_test_object( VOLUMES.fx_volume_camera_snow_off_06, PLAYERS.local0 )
	  ], 1);
			effect_attached_to_camera_stop(TAG('levels\campaignworld030\w3_halsey\fx\atmospherics\snow_falling_gentle.effect'));
		SleepUntil([| 
			 not volume_test_object( VOLUMES.fx_volume_camera_snow_off_01, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_02, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_03, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_04, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_05, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_05a, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_05b, PLAYERS.local0 )
	 and not volume_test_object( VOLUMES.fx_volume_camera_snow_off_06, PLAYERS.local0 )
	  ], 1);
	sleep_s(0.25);
	until false
end

function remoteClient.EquipTrackerTutorial():void
	repeat
		if player_get_unit(PLAYERS.local0) == SPARTANS.locke then
				print("ITS OFF");
		--	navpoint_track_flag( FLAGS.fl_temp_airlock_track, false );
		end
		
		ShowEquipTrackerMessage(SPARTANS.locke, true);
		
		SleepUntil([|IsTrackerEquipped(SPARTANS.locke)], 1);
		
		if player_get_unit(PLAYERS.local0) == SPARTANS.locke then
			print("ITS ON");
		--	navpoint_track_flag( FLAGS.fl_temp_airlock_track, true );
		end
		
		ShowEquipTrackerMessage(SPARTANS.locke, false);
		
		SleepUntil([|not IsTrackerEquipped(SPARTANS.locke)], 1);
		
	until b_tracked
	
	if player_get_unit(PLAYERS.local0) == SPARTANS.locke then
	print("nav");
	--	navpoint_track_flag( FLAGS.fl_temp_airlock_track, false );
	end
	
end

function remoteClient.ClientTrackingDone():void
	b_tracked = true;
end

----------------------------------------------------------------------------
-- AMBIENT Shakes -----------------------------------------------
----------------------------------------------------------------------------

function remoteClient.ShakeMinor()
	camera_shake_all_coop_players (.15,.15, 3);
end

function remoteClient.ShakeSoft()
	camera_shake_all_coop_players (.1,.1, 2);
end

function remoteClient.ShakeMid()
	camera_shake_all_coop_players (.3,.3, 2);
end

function remoteClient.ShakeHard()
	camera_shake_all_coop_players (.5,.5, 3);
end

function remoteClient.dissolveKnight()
	object_dissolve_from_marker( AI.sq_vault_knight_03.spawn_points_0, "incineration", "" );
end

function remoteClient.TurretDissolve(turret:object)
	--effect_new_on_object_marker( TAG('levels\assets\osiris\props\generic_forerunner\for_power_core_center\fx\fx_for_core_explode.effect'), turret, "audio_center");
	effect_new_on_object_marker( TAG('levels\assets\osiris\props\generic_forerunner\for_watchtower\fx\for_watchtower_explosion_lg.effect'), turret, "audio_center");
	object_dissolve_from_marker( turret, "incineration", "audio_center" );
	object_dissolve_from_marker( turret, "hard_kill", "audio_center" );
	
end

function remoteClient.impactSmallPlayer(spartan:object, numSeconds:number)
	if player_get_unit( PLAYERS.local0 ) == spartan then
		start_global_rumble_shake(numSeconds, TAG('levels\assets\osiris\effects\rumble_shakes\global_rumble_shake_small.effect'));
	end
end
 
function remoteClient.start_global_rumble_large_shake_small(numSeconds:number):void
                start_global_rumble_shake(numSeconds, TAG('levels\assets\osiris\effects\rumble_shakes\global_rumble_large_shake_small.effect'));
end

