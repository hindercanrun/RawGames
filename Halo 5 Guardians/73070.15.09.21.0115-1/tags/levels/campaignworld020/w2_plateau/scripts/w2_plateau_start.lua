global n_templeFinalScanCount:number = 3; -- constant

--## SERVER

--	343	//														
--	343	//				Plateau Intro 
--	343	//														
--	343	//														

-- ///==========// Mission Definition //======////
-- variables
--PROFILE.core.oreo_button_release = false;															-- branching narrative
--PROFILE.core.oreo_destroyed_gate = false;

-- pelican vignette:
-- vehicle_load_magic 
-- vehicle_unload

global var_reveal_objcon:number=0;
global var_hollow_objcon:number=0;
global var_liftoff:number = 0;
global var_ward_phantom:number = 0;
global b_scout_dialog_done:boolean = false;
global b_pelican_loop:boolean= false;
global var_ramp_objcon:number=0;
global var_liftoff_events:number=0;
global sentry_show:number = 0;							
global sentry_show_lead_in:number = 0;							
global var_hollow_flipside:number = 0;
global b_liftoff_idle:boolean = true;
global b_stagger_complete:boolean = false;
global v_stagger:number = nil;						-- composition

global b_stagger_l:boolean = false;
global b_stagger_v:boolean = false;
global b_stagger_t:boolean = false;
global b_stagger_b:boolean = false;
				
global b_sentryleadsplayer:boolean = false;	
global var_liftoff_audio_thread:thread = nil;
global b_PlateauPelicanArrived:boolean = false;
global var_reveal_audio_thread:thread = nil;
global g_ics_player_0:player = nil;
global g_ics_player_1:player = nil;
global g_ics_player_2:player = nil;
global g_ics_player_3:player = nil;
global b_lookat_b:boolean = false;							-- used in soldier_taunt composition to end a loop state
global b_sentry_end_test:boolean = false;
global b_v2:boolean = false;								-- used for prototype of new boss encounter. Search on "v2" to find uses
global b_end_temple_goal:boolean = false;							-- temp shortcut through tracking section.
global var_kraken_killer_thread:thread = nil;				-- for removing resting kraken before players see it.
global b_mission_done:boolean = false;

global var_startscript_1:boolean = false;					-- prevent thread duplication

global missionPlateau:table=
{
	name = "w2_plateau",
	profiles = {STARTING_PROFILES.profile1, STARTING_PROFILES.profile2, STARTING_PROFILES.profile3, STARTING_PROFILES.profile4},
	startGoals = {"goal_Breach"},	

	collectibles = {	
						{objectName="w2_plat_skull", collectibleName="collectible_skull_catch"},
						{objectName="w2_plat_collectible_1", collectibleName="w2_plat_collectible_1"},
                        {objectName="w2_plat_collectible_2", collectibleName="w2_plat_collectible_2"},
                        {objectName="w2_plat_collectible_3", collectibleName="w2_plat_collectible_3"},
                        {objectName="w2_plat_collectible_4", collectibleName="w2_plat_collectible_4"},
						{objectName="w2_plat_collectible_5", collectibleName="w2_plat_collectible_5"},
                        {objectName="w2_plat_collectible_6", collectibleName="w2_plat_collectible_6"},
                        {objectName="w2_plat_collectible_7", collectibleName="w2_plat_collectible_7"},
						{objectName="w2_plat_collectible_8", collectibleName="w2_plat_collectible_8"},
                        {objectName="w2_plat_collectible_9", collectibleName="w2_plat_collectible_9"},
                    --	{objectName="w2_plat_collectible_10", collectibleName="w2_plat_collectible_10"},		DELETED
						{objectName="w2_plat_collectible_11", collectibleName="w2_plat_collectible_11"}
					--	,
                    --	{objectName="w2_plat_collectible_12", collectibleName="w2_plat_collectible_12"}		DELETED
					},
	startFadeOut = "no",
	endFadeOut = "no"	
}

function missionPlateau.Start()
	CreateMissionThread(PlateauStart);
	print("missionPlateau.Start");	
end

function StartPlateau():void
	teleport_player_to_flag (PLAYERS.player0, FLAGS.tpf0, false);
	teleport_player_to_flag (PLAYERS.player1, FLAGS.tpf0, false);
	teleport_player_to_flag (PLAYERS.player2, FLAGS.tpf0, false);
	teleport_player_to_flag (PLAYERS.player3, FLAGS.tpf0, false);
	StartMission(missionPlateau);
end
function missionPlateau.End()
	local frames:number = 90
-- fade player input for local var amount of time
-- fade (non-threaded) for local var amount of time
	CreateThread(fade_input, frames);
	fade_out(0,0,0, frames);
	Sleep(frames);
	CreateThread(TeleportNoFX, 8);
	Sleep(3);
	
	for _,spartan in ipairs (players()) do								--8-31-2015: hack to hide spartans bobbing through geometry
		object_teleport (spartan, FLAGS.tpf_exit_dummy);
	end
	
	ai_erase(AI.sq_fore_artifact_001);
	Sleep(2);
	phantom_fade_hack(); -- kill the phantom
--	switch_zone_set(ZONE_SETS.plateau_crevice);
	CinematicPlay("cin_t00_plateau_end", true);
	print("missionPlateau .end called -----");
	SetGlobalFlag("Plateau_complete");
	sys_LoadW2Hub_2();
end
function fade_input(frames:number):void
	player_control_fade_out_all_input(frames);
end
function phantom_fade_hack():void
--	Sleep(1);										-- if phantom still visible, try deleting this first
	if not (sentry_show == nil)then
		composer_stop_show(sentry_show);
	end
	sentry_show = nil;
end
--//=========//	Startup Scripts	//=========////

function PlateauStart()
--	debug_spartan_tracking = true;
	if(var_startscript_1 == false)then
		--	NARRATIVE CALL
		CreateThread(plateau_narrative_startup);
		CreateThread(audio_plateau_thread_up);
		CreateThread(remove_navmesh_dummy_ships);
		b_cov_projector_barrier = true;												-- this var defined in object script. Makes it so we can power on shield at hollow.
		var_startscript_1 = true;
		print("PlateauStart threadup complete");
	else
		print("duplicate PlateauStart ignored");
	end
end
function remove_navmesh_dummy_ships():void
	object_destroy(OBJECTS.vin_sent_machine);
	object_destroy(OBJECTS.vin_sent_machine_2);
end
--[[
  ______    ______    ______   __                __   
 /      \  /      \  /      \ |  \             _/  \  
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |   $$  
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$$$  
| $$|    \| $$  | $$| $$    $$| $$              | $$  
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              | $$  
| $$__| $$| $$__/ $$| $$  | $$| $$_____        _| $$_ 
 \$$    $$ \$$    $$| $$  | $$| $$     \      |   $$ \
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$
                                                      
--]]                                                  
-- deprecated


--[[
  ______    ______    ______   __               ______                       _______   _______   ________   ______    ______   __    __ 
 /      \  /      \  /      \ |  \             /      \                     |       \ |       \ |        \ /      \  /      \ |  \  |  \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |  $$$$$$\                    | $$$$$$$\| $$$$$$$\| $$$$$$$$|  $$$$$$\|  $$$$$$\| $$  | $$
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$__| $$       ______       | $$__/ $$| $$__| $$| $$__    | $$__| $$| $$   \$$| $$__| $$
| $$|    \| $$  | $$| $$    $$| $$             /      $$      |      \      | $$    $$| $$    $$| $$  \   | $$    $$| $$      | $$    $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$            |  $$$$$$        \$$$$$$      | $$$$$$$\| $$$$$$$\| $$$$$   | $$$$$$$$| $$   __ | $$$$$$$$
| $$__| $$| $$__/ $$| $$  | $$| $$_____       | $$_____                     | $$__/ $$| $$  | $$| $$_____ | $$  | $$| $$__/  \| $$  | $$
 \$$    $$ \$$    $$| $$  | $$| $$     \      | $$     \                    | $$    $$| $$  | $$| $$     \| $$  | $$ \$$    $$| $$  | $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$$$                     \$$$$$$$  \$$   \$$ \$$$$$$$$ \$$   \$$  \$$$$$$  \$$   \$$
                                                        
--]]                                           


missionPlateau.goal_Breach = 
{
	gotoVolume = VOLUMES.tv_breach_ender,
	zoneSet = ZONE_SETS.cin_plateau_start,
	next = {"goal_Caves"}
}

function missionPlateau.goal_Breach.Start():void
	prepare_to_switch_to_zone_set(ZONE_SETS.plateau_start);
	--	NARRATIVE CALL
	CreateThread(plateau_breach_load);
	CinematicPlay ("cin_t00_hubtoplat1b");											--	--	--	--	--		Opening Cinematic 
	composer_play_show("pelican_flight");														-- unsure if this is the best place, or if it should come prior to the audio thread up
	switch_zone_set(ZONE_SETS.plateau_start);
	Sleep(3);

	CreateThread(breach_touchdown);

	Sleep(3);
	print("__________________goal_Breach.start");
	CreateThread(black_bar_1);
		CreateThread(dropdown_ground_flocks);
	CreateThread(tracking_breach);
end
function tracking_breach():void
	object_create("track_breach");
	print("breach tracking on");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_breach_ender)
				or	IsGoalActive(missionPlateau.goal_Breach) == false
				], 3);
	print("breach tracking off");
	object_destroy(OBJECTS.track_breach);
end
function musket_breach():void
	sleep_s(1);
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;

			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					print("my buddy");
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					print("pos 2");
					CreateThread(musket_breach_1, obj);
				else
					print("pos 3");
					CreateThread(musket_breach_2, obj);
				end
			end
end
function musket_breach_1(musk:object):void
	print("------------------------------------tpt0")
	MusketeerDestSetPoint(musk, FLAGS.mt_breach1, 2);
	sleep_s(3);
	MusketeerDestSetPoint(musk, FLAGS.mt_breach1b, 2);
	print("------------------------------------tptA")
		SleepUntil( [| volume_test_players(VOLUMES.tv_breach_objcon_10) == true
					or IsGoalActive(missionPlateau.goal_Breach) == false
					],2);
	print("------------------------------------tptB")
	MusketeerDestSetPoint(musk, FLAGS.mt_breach1c, 2);
	sleep_s(3);
	MusketeerDestSetPoint(musk, FLAGS.mt_breach1d, 2);
	print("------------------------------------tptC")
		SleepUntil( [| IsGoalActive(missionPlateau.goal_Breach) == false
					],2);
	print("------------------------------------tptD")
	MusketeerDestClear(musk);
end
function musket_breach_2(musk:object):void
	MusketeerDestSetPoint(musk, FLAGS.mt_breach2, 2);
			SleepUntil( [| volume_test_players(VOLUMES.tv_breach_objcon_10) == true
					or IsGoalActive(missionPlateau.goal_Breach) == false
					],1);
	MusketeerDestSetPoint(musk, FLAGS.mt_breach2b, 2);
		SleepUntil( [| IsGoalActive(missionPlateau.goal_Breach) == false
					],2);
	MusketeerDestClear(musk);
end

function dropdown_ground_flocks():void
	sleep_s(2);
	CreateThread(flock_ground_caves_client);
end
function black_bar_1():void
	f_chapter_title(TITLES.ch_bb_1);
end
function breach_touchdown():void
	SleepUntil([| volume_test_object(VOLUMES.tv_breach_touchdown, SPARTANS.locke) 

				], 1);
	b_pelican_loop = true;
	CreateThread(musket_breach);
--	game_save_no_timeout();															-- moved here to prevent players spawning where pelican was
	game_save_immediate();															--tjp 8-27-2015 DEFCON 5
end

function breach_ender():void
	SleepUntil([| volume_test_players(VOLUMES.tv_breach_ender) ], 1);
	print("goal_breach end");
	PlayersSetWeaponRelaxed(false);
	GoalCompleteTask(missionPlateau.goal_Breach);
end

--[[
  ______    ______    ______   __               ______                        ______    ______   __     __  ________   ______  
 /      \  /      \  /      \ |  \             /      \                      /      \  /      \ |  \   |  \|        \ /      \ 
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |  $$$$$$\                    |  $$$$$$\|  $$$$$$\| $$   | $$| $$$$$$$$|  $$$$$$\
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$__| $$       ______       | $$   \$$| $$__| $$| $$   | $$| $$__    | $$___\$$
| $$|    \| $$  | $$| $$    $$| $$              |     $$      |      \      | $$      | $$    $$ \$$\ /  $$| $$  \    \$$    \ 
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             __\$$$$$\       \$$$$$$      | $$   __ | $$$$$$$$  \$$\  $$ | $$$$$    _\$$$$$$\
| $$__| $$| $$__/ $$| $$  | $$| $$_____       |  \__| $$                    | $$__/  \| $$  | $$   \$$ $$  | $$_____ |  \__| $$
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$                     \$$    $$| $$  | $$    \$$$   | $$     \ \$$    $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$                       \$$$$$$  \$$   \$$     \$     \$$$$$$$$  \$$$$$$ 
                                                                                                                             
--]]


missionPlateau.goal_Caves = 
{
--	description = "CAPTURE THE CONSTRUCTOR AT TOJINOK",
	gotoVolume = VOLUMES.tv_end_cave_goal,
	zoneSet = ZONE_SETS.plateau_start,
	next = {"goal_SentryShipEncounter"};
}

function missionPlateau.goal_Caves.Start():void
		--	NARRATIVE CALL
		CreateThread(plateau_dropdown_load);

    CreateThread(scout_spawner);
	CreateThread(scout_sight);
	print("__________________goal_Caves.start");
    object_create_folder("obj_reveal");
	CreateThread(slim_down_ss_for_reveal);
	CreateThread(flock_caves_client);
	game_save_no_timeout();
	CreateThread(audio_newobjective_beep);
	CreateThread(plateau_sentry_ship_composition_start_idle);
	CreateThread(musket_caves);
	CreateThread(tracking_caves);
	CreateThread(reveal_jump_hint_manager);
end
--[[
function tracking_caves():void
	object_create();
	SleepUntil(	[|	volume_test_players()
				or	IsGoalActive(missionPlateau.goal_Breach) == false
				, 5
				]);
	object_destroy();
end
--]]
function tracking_caves():void
	object_create("track_scouts");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_track_scouts)
				or	IsGoalActive(missionPlateau.goal_Caves) == false
				], 3);
	object_create("track_reveal_liftoff");
	object_destroy(OBJECTS.track_scouts);
	SleepUntil(	[|	IsGoalActive(missionPlateau.goal_Caves) == false
				and IsGoalActive(missionPlateau.goal_SentryShipEncounter) == false
				], 3);
	object_destroy(OBJECTS.track_reveal_liftoff);
end
function musket_caves():void
		CreateThread(muskbox, VOLUMES.tv_musk_dropdown, FLAGS.mt_dropdown1, 2, FLAGS.mt_dropdown2, 2, missionPlateau.goal_Caves);
end
function objective_text_goal_caves():void													
	sleep_s(2);
--	ObjectiveShow (TITLES.ch_get_to_temple);
	ObjectiveShow (TITLES.ch_retrieve_halseys);
end
function missionPlateau.goal_Caves.End():void
	--cleaning up breach
	ai_place(AI.sq_ward_vanguard);
	sleep_s(2);
	CreateThread(ward_vanguard_flee_listener);
end
function scout_spawner():void
    SleepUntil([| volume_test_players(VOLUMES.tv_scout_spawn) ], 1);
    ai_place(AI.sq_ward_scouts);
end
function scout_sight():void
	SleepUntil([| volume_test_players(VOLUMES.tv_scout_wake) ], 1);
	ai_set_blind(AI.sq_ward_scouts.spawn_points_0, false);
	ai_set_blind(AI.sq_ward_scouts.spawn_points_1, false);
	ai_set_blind(AI.sq_ward_scouts.spawn_points_2, false);
end
function plateau_sentry_ship_composition_start_idle():void									-- place initial ss
--	SleepUntil([|	volume_test_players(VOLUMES.tv_scout_wake)	], 5);

--	ai_place(AI.sg_reveal_vehicles);
	ai_place(AI.sq_reveal_gunship);
	Sleep(2);
	ai_set_blind(AI.sq_reveal_gunship.pilot, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun1, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun2, true);
--	CreateThread(flag_arbiter_banshees);
	CreateThread(reveal_show);
end
function test_reveal():void																	-- test function

--	ai_place(AI.sg_reveal_vehicles);
	ai_place(AI.sq_reveal_gunship);


	Sleep(2);
--	CreateThread(flag_arbiter_banshees);													-- set alliances so ai will shoot em
	CreateThread(reveal_show);																-- play show
	ai_set_blind(AI.sq_reveal_gunship.pilot, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun1, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun2, true);
	sleep_s(6);
	b_liftoff_idle = false;																	-- the composition waits until this bit is flipped
end
function flag_arbiter_banshees():void														-- set alliances so ai will fight 
	ai_object_set_team(OBJECTS.banshee1, TEAM.player);	
	ai_object_set_team(OBJECTS.banshee2, TEAM.player);	
	ai_object_set_team(OBJECTS.banshee3, TEAM.player);	
	cs_run_command_script(AI.sq_ss_gunner_4, "cs_gunner_v_banshee_1");						-- deck gunners
	cs_run_command_script(AI.sq_ss_gunner_5, "cs_gunner_v_banshee_2");
	cs_run_command_script(AI.sq_ss_gunner_6, "cs_gunner_v_banshee_2");
	cs_run_command_script(AI.sq_ss_gunner_7, "cs_gunner_v_banshee_1");
end
function reveal_jump_hint_manager():void
	Sleep(2);
	ai_disable_jump_hint(HINTS.jh_bashwall_reveal_1);
	ai_disable_jump_hint(HINTS.jh_bashwall_reveal_2);
	CreateThread(bashwall_jump_1);
	CreateThread(bashwall_jump_2);
end
function bashwall_jump_1():void
	SleepUntil([| object_get_health(OBJECTS.bashwall1) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bashwall_reveal_1);
end
function bashwall_jump_2():void
	SleepUntil([| object_get_health(OBJECTS.bashwall2) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bashwall_reveal_2);
end
--[[
  ______    ______    ______   __              __    __                      __        ______  ________  ________   ______   ________  ________ 
 /      \  /      \  /      \ |  \            |  \  |  \                    |  \      |      \|        \|        \ /      \ |        \|        \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            | $$  | $$                    | $$       \$$$$$$| $$$$$$$$ \$$$$$$$$|  $$$$$$\| $$$$$$$$| $$$$$$$$
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$__| $$       ______       | $$        | $$  | $$__       | $$   | $$  | $$| $$__    | $$__    
| $$|    \| $$  | $$| $$    $$| $$            | $$    $$      |      \      | $$        | $$  | $$  \      | $$   | $$  | $$| $$  \   | $$  \   
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             \$$$$$$$$       \$$$$$$      | $$        | $$  | $$$$$      | $$   | $$  | $$| $$$$$   | $$$$$   
| $$__| $$| $$__/ $$| $$  | $$| $$_____             | $$                    | $$_____  _| $$_ | $$         | $$   | $$__/ $$| $$      | $$      
 \$$    $$ \$$    $$| $$  | $$| $$     \            | $$                    | $$     \|   $$ \| $$         | $$    \$$    $$| $$      | $$      
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$             \$$                     \$$$$$$$$ \$$$$$$ \$$          \$$     \$$$$$$  \$$       \$$      
                                                                                                                                                
                                                                                                                                               
--]]

-- Sentry Ship Encounter

missionPlateau.goal_SentryShipEncounter = 
{
--	description = "Neutralize Covenant",

	gotoVolume = VOLUMES.tv_liftoff_passed,
	zoneSet = ZONE_SETS.plateau_start,
	next = {"goal_Hollow"};
}

function missionPlateau.goal_SentryShipEncounter.Start():void

		--	NARRATIVE CALL
		CreateThread(plateau_sentryreveal_load);	
		
	object_create_folder("f_reveal_weapons");

	CreateThread(spawn_reveal_encounter);
	CreateThread(reveal_encounter_stage_2);										
    CreateThread(reveal_encounter_stage_3);										-- objcon 10
	CreateThread(reveal_encounter_stage_4);										-- objcon 20, spawn reinforcements
	CreateThread(reveal_encounter_stage_5);										-- objcon 40, approaching pile
	CreateThread(reveal_encounter_stage_6);										-- objcon 50, players almost to hollow landing
	CreateThread(flock_cavern_client);
	CreateThread(musket_reveal);
	object_create_anew("scenery_lip");
	CreateThread(slim_down_ss_for_reveal);
	kill_volume_disable(VOLUMES.playerkill_sentryreveal);
	kill_volume_disable(VOLUMES.playerkill_sentryreveal_a);
	kill_volume_disable(VOLUMES.playerkill_liftoff);
-- =================================================							-- 2/24/14	- switched from reveal to evac
																				-- 4/15/14	- switching from evac to ward
																				-- 9/9/14	- shrinking ward
-- =================================================							
	CreateThread(reveal_boss_spawner_trigger);
	CreateThread(tracking_reveal);
	CreateThread(f_hollow_crates);
	sleep_s (1);
	game_save_no_timeout();

end
function tracking_reveal():void
	object_create("track_reveal_liftoff");
	object_destroy(OBJECTS.track_reveal_landing);
	SleepUntil(	[|	b_liftoff_idle == false
				or	IsGoalActive(missionPlateau.goal_SentryShipEncounter) == false
				], 3);
	object_destroy(OBJECTS.track_reveal_liftoff);
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_reveal_objcon_20)
				or	IsGoalActive(missionPlateau.goal_SentryShipEncounter) == false
				], 3);
	object_create("track_hollow");
	object_create("track_hollow_cache");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_liftoff_passed)
				or	IsGoalActive(missionPlateau.goal_SentryShipEncounter) == false
				], 3);
	object_destroy(OBJECTS.track_hollow);
	object_destroy(OBJECTS.track_hollow_cache);
end
function musket_reveal():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox1, FLAGS.mt_reveal_1a, 2, FLAGS.mt_reveal_1b, 2, missionPlateau.goal_SentryShipEncounter);
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox5, FLAGS.mt_reveal_5a, 2, FLAGS.mt_reveal_5b, 2, missionPlateau.goal_SentryShipEncounter);
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox10, FLAGS.mt_reveal_10a, 2, FLAGS.mt_reveal_10b, 2, missionPlateau.goal_SentryShipEncounter);
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox15, FLAGS.mt_reveal_15a, 2, FLAGS.mt_reveal_15b, 2, missionPlateau.goal_SentryShipEncounter);
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox20, FLAGS.mt_reveal_20a, 2, FLAGS.mt_reveal_20b, 2, missionPlateau.goal_SentryShipEncounter);
		CreateThread(muskbox, VOLUMES.tv_reveal_muskbox25, FLAGS.mt_reveal_25a, 2, FLAGS.mt_reveal_25b, 2, missionPlateau.goal_SentryShipEncounter);
	end
end
function spawn_reveal_encounter():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_spawn) ], 1);
	CreateThread(ss_man_the_reveal_guns);
	CreateThread(f_reveal_gunners);
-- =================================================							-- 2/24/14	- switched from reveal to evac	
																				-- 4/15/14	- switching from evac to ward
																				-- 9/9/14	- paring down ward
	ai_place(AI.sq_ward_vangrunts);
	ai_place(AI.sq_ward_phantom);
	CreateThread(pf_sentry_liftoff_conditions);									-- kicked off here because of ai_living_count sleep condition
end
function reveal_encounter_stage_2():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_2) ], 1);
	var_reveal_objcon = 2;
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_5) ], 1);
	var_reveal_objcon = 5;
end

function reveal_encounter_stage_3():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_8) ], 1);
	var_reveal_objcon = 8;
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_10) ], 1);
    var_reveal_objcon = 10;
end

function reveal_encounter_stage_4():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_20) ], 1);
    var_reveal_objcon = 20;
	if(var_liftoff <= 1)then
		var_liftoff = 2;														--shut off flee
	end
	Sleep(10);
	game_save_no_timeout();
end
function reveal_encounter_stage_5():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_40) ], 1);
    var_reveal_objcon = 40;
	CreateThread(flock_hollow_client);
end
function reveal_encounter_stage_6():void
	SleepUntil([| volume_test_players(VOLUMES.tv_reveal_objcon_50) ], 1);
    var_reveal_objcon = 50;
end
function ward_vanguard_flee_listener():void											-- send vanguard elite back to boss area
	SleepUntil([| b_liftoff_idle == false ], 3);
	cs_run_command_script(AI.sq_ward_vanguard.e, "cs_ward_elite");
end
function give_gunship_sight():void
	Sleep(8);																		-- so that the phantom opens fire on frame 350
	ai_set_blind(AI.sq_reveal_gunship.pilot, false);
	ai_set_blind(AI.sq_reveal_gunship.doorgun1, false);
	ai_set_blind(AI.sq_reveal_gunship.doorgun2, false);
end
function sleep_n_shoot_1():void
	Sleep(120);
	cs_run_command_script(AI.sq_ss_gunner_3, "cs_reveal_dummyshoot_33");
	cs_run_command_script(AI.sq_ss_gunner_2, "cs_reveal_dummyshoot_23");
end
function pf_sentry_liftoff_conditions():void
	SleepUntil	((	[|	--volume_test_players(VOLUMES.tv_liftoff_sequence_initialize) or 
						volume_test_players(VOLUMES.tv_reveal_objcon_5) or											-- trying this out 2/20
						ai_living_count(AI.sg_reveal_all) <= 2			or
						var_ward_phantom >= 1
					] ), 1);
	sentry_liftoff_sequence();
end
function sentry_liftoff_sequence():void
	CreateThread(staggerguard);
--	RunClientScript("RecreateSentryLip_client");
	Sleep(3);																			-- NECESSARY
	CreateThread(sentry_ship_liftoff_lead_in);
	CreateThread(sentry_ship_liftoff_launch);
end
function sentry_ship_liftoff_lead_in():void												-- Concurrent Sequence A
	-- LEAD IN:
		--	NARRATIVE CALL
			CreateThread(plateau_sentryreveal_kraken_rise_lead_in);								-- Call Reaction VO when we hear the big Horn!

	if(var_reveal_audio_thread == nil) then
		var_reveal_audio_thread = CreateThread(audio_sentryreveal_horn_breach);
	end
	RunClientScript("fx_sentry_reveal_destruction_01_client");
	RunClientScript("fx_sentry_reveal_destruction_02_client");
	sleep_s(.5);
	sentry_show_lead_in = composer_play_show("sentryship_revealbuildup");
	sleep_s(3.0);
	b_liftoff_idle = false;																-- composition and co-routine both listen for this bool then advance
end
function sentry_ship_liftoff_launch():void												-- Concurrent Sequence B
	SleepUntil	(	[|	volume_test_players(VOLUMES.tv_liftoff) or						-- physical location of players or
						b_liftoff_idle == false;										-- sequence 
					]
					, 1
				);
	--	NARRATIVE CALL
	CreateThread(plateau_sentryreveal_kraken_rise_launch);								-- Call Reaction VO when we hear the big Horn!
	b_liftoff_idle = false;																-- composition listens for this bool then advances the scene
	var_liftoff = 1;
	var_liftoff_audio_thread = CreateThread(audio_plateau_sentrylaunched);
end
function var_checker():void
	repeat
		print ("var = ".. tostring(b_liftoff_idle) .." ---------------");
		Sleep(2);
	until(var_liftoff >= 3)
end
-- volume_test_players_lookat
-- LENGTH OF RAY  mAXVIEWDISTANCE
-- DEGREE OF CONE MAXVIEWANGLE
-- OCCLUDES
function reveal_boss_spawner_trigger():void
	SleepUntil	(	[|	volume_test_players(VOLUMES.tv_reveal_objcon_20)
--					or	var_liftoff_events >= 1
					] 
				, 1);
--	if(var_liftoff_events >= 1)then
--		sleep_s(2);
--	end
	reveal_boss_spawner();
end
-- blarg
function reveal_boss_spawner():void
	if(ai_living_count(AI.sq_ward_boss_1) <= 0)then
		ai_place(AI.sq_ward_boss_1);
		ai_place(AI.sq_ward_rooks);
	end
end
function var_liftoff_timer():void														-- this is in lieau of a script call from the composition. 5/27/14 DEPRECATED: now called on composition
	sleep_s(9);
	var_liftoff = 2;																	-- ward configuration; ends non-combat state. evac configuration; ends evac 
	sleep_s(4);
	var_liftoff = 3;																	
end 
function reveal_show():void

	--print("_______________________  0000000000000000000000000000 ____________________________________");
	--print( current_zone_set_fully_active() );
	SleepUntil( [| current_zone_set_fully_active() == ZONE_SETS.plateau_start ] ,1 );  -- fix for sentry ship not showing up cf 8/18/2015
	print( current_zone_set_fully_active() );
	sentry_show = composer_play_show("sentryship_reveal", {	--phantom1 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_harrier.spawnpoint),
															--phantom2 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_shuttle.spawnpoint),`
															phantom3 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_gunship.pilot)
--															,
--															banshee1 = OBJECTS.banshee1,			-- need to make these ai-controlled as well
--															banshee2 = OBJECTS.banshee2,			-- need to make these ai-controlled as well
--															banshee3 = OBJECTS.banshee3});			-- need to make these ai-controlled as well
--															banshee1 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_banshee_1.spawnpoint),
--															banshee2 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_banshee_2.spawnpoint),
--															banshee3 = ai_vehicle_get_from_spawn_point(AI.sq_reveal_banshee_3.spawnpoint)
															});
end
-- archived: 
--	"ward_scramble_sequence"
--	cs_run_command_script(AI.sq_ward_vanguard.e, "cs_liftoff_1");
--	cs_run_command_script(AI.sq_ward_vanguard.g1, "cs_liftoff_grunt_scramble");
--	cs_queue_command_script(AI.sq_ward_vanguard.e,				"cs_return_ai_function");

function reveal_impact_kill():void
	kill_volume_enable(VOLUMES.playerkill_sentryreveal);
	CreateThread(reveal_impact_kill_kill);
end
function reveal_impact_kill_a():void
	kill_volume_enable(VOLUMES.playerkill_sentryreveal_a);
	CreateThread(reveal_impact_kill_kill_a);
end
function reveal_impact_kill_kill():void
	Sleep(80);
	kill_volume_disable(VOLUMES.playerkill_sentryreveal);
end
function reveal_impact_kill_kill_a():void
	Sleep(80);
	kill_volume_disable(VOLUMES.playerkill_sentryreveal_a);
end
-- =============== staggerguard stuff
-- =============== to do: make more durable, solo player only gets zapped once atm
function staggerguard():void
	kill_volume_enable(VOLUMES.playerkill_liftoff);
	v_stagger = composer_play_show("comp_player_losing_balance");
	CreateThread(staggerguard_locke);
	CreateThread(staggerguard_tanaka);
	CreateThread(staggerguard_buck);
	CreateThread(staggerguard_vale);

	SleepUntil([| b_stagger_complete == true], 2, 720);
	if(v_stagger ~= nil)then
		composer_stop_show (v_stagger);
		v_stagger = nil;
	end
	kill_volume_disable(VOLUMES.playerkill_liftoff);
end
function staggerguard_locke():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_liftoff_stagger , SPARTANS.locke)], 2);	
	b_stagger_l = true;	
end
function staggerguard_vale():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_liftoff_stagger , SPARTANS.vale)], 2);	
	b_stagger_v = true;	
end
function staggerguard_buck():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_liftoff_stagger , SPARTANS.buck)], 2);	
	b_stagger_b = true;	
end
function staggerguard_tanaka():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_liftoff_stagger , SPARTANS.tanaka)], 2);	
	b_stagger_t = true;	
end



function liftoff():void						-- test function for people working on the liftoff sequence
	
	--Cleanup: remove possible existing objects 
	ai_erase(AI.sg_ramp_ss_gunners);
	ai_erase(AI.sg_reveal_all);
	if not (sentry_show == nil)then
		composer_stop_show(sentry_show);
		sentry_show = nil;
	end
	if not (sentry_show_lead_in == nil)then
		composer_stop_show(sentry_show_lead_in);
		sentry_show_lead_in = nil;
	end
	if(IsThreadValid(var_liftoff_audio_thread))then
		KillThread(var_liftoff_audio_thread);
		var_liftoff_audio_thread = nil;
	end
	RunClientScript("fx_sentry_reveal_destruction_01_client_remove");
	RunClientScript("fx_sentry_reveal_destruction_02_client_remove");
	sentry_show = nil;
	sentry_show_lead_in = nil;
	var_liftoff = 0
	Sleep(2);

	RunClientScript("RecreateSentryLip_client");
	Sleep(3);

	-- Liftoff Sequence
	CreateThread (sentry_show_reset);
	Sleep(2);
	CreateThread(ss_man_the_reveal_guns);
	CreateThread(f_reveal_gunners);
	CreateThread(sentry_liftoff_sequence);
end
function sentry_show_reset():void

--	ai_place(AI.sg_reveal_vehicles);
	ai_place(AI.sq_reveal_gunship);


	if not (sentry_show == nil)then
		composer_stop_show(sentry_show);
		sentry_show = nil;
	end
	b_liftoff_idle = true;
	object_destroy(OBJECTS.vin_sent_machine);
--	ai_erase(AI.sq_reveal_gunship);
	Sleep(2);
	object_create_anew("vin_sent_machine");
--	ai_place(AI.sg_reveal_vehicles);
	ai_place(AI.sq_reveal_gunship);


	Sleep(2);
	CreateThread(reveal_show);
	ai_set_blind(AI.sq_reveal_gunship.pilot, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun1, true);
	ai_set_blind(AI.sq_reveal_gunship.doorgun2, true);
end
-- =============== /staggerguard stuff
-- WIP:
function reveal_ambient_sentry_ai():void
	-- drain to cleanup points
	CreateThread(sentry_ship_evac_erase_ai_by_volume);
	-- cs_return_ai_function
end
function sentry_ship_evac_erase_ai_by_volume():void
	repeat
		for _, obj in ipairs (volume_return_objects(VOLUMES.tv_sentry_ship_erase_ai)) do
			ai_erase(object_get_ai(obj));
		end
	Sleep(10);
	until(var_liftoff >= 3);
end
function f_hollow_crates():void
	SleepUntil([| volume_test_players(VOLUMES.tv_hollowcrates)], 2);	
	object_create_folder("obj_hollow");
end
--[[
  ______    ______    ______   __              __    __   ______                       __    __   ______   __        __        ______   __       __ 
 /      \  /      \  /      \ |  \            |  \  |  \ /      \                     |  \  |  \ /      \ |  \      |  \      /      \ |  \  _  |  \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            | $$  | $$|  $$$$$$\                    | $$  | $$|  $$$$$$\| $$      | $$     |  $$$$$$\| $$ / \ | $$
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$__| $$| $$__| $$       ______       | $$__| $$| $$  | $$| $$      | $$     | $$  | $$| $$/  $\| $$
| $$|    \| $$  | $$| $$    $$| $$            | $$    $$| $$    $$      |      \      | $$    $$| $$  | $$| $$      | $$     | $$  | $$| $$  $$$\ $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             \$$$$$$$$| $$$$$$$$       \$$$$$$      | $$$$$$$$| $$  | $$| $$      | $$     | $$  | $$| $$ $$\$$\$$
| $$__| $$| $$__/ $$| $$  | $$| $$_____             | $$| $$  | $$                    | $$  | $$| $$__/ $$| $$_____ | $$_____| $$__/ $$| $$$$  \$$$$
 \$$    $$ \$$    $$| $$  | $$| $$     \            | $$| $$  | $$                    | $$  | $$ \$$    $$| $$     \| $$     \\$$    $$| $$$    \$$$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$             \$$ \$$   \$$                     \$$   \$$  \$$$$$$  \$$$$$$$$ \$$$$$$$$ \$$$$$$  \$$      \$$
                                                                                                                                                    
--]]
missionPlateau.goal_Hollow = 
{
--	description = "CAPTURE THE CONSTRUCTOR AT TOJINOK",
	gotoVolume = VOLUMES.tv_hollow_objcon_80,
	zoneSet = ZONE_SETS.plateau_start,
	next = {"goal_Ramp"}
}

function missionPlateau.goal_Hollow.Start():void

		--	NARRATIVE CALL
		CreateThread(plateau_hollow_load);

		CreateThread(objective_text_goal_hollow);												--	ADDED here to replace the call of the objective text from the narrative script.	Guillaume	10/03

	object_create_folder("veh_hollow");
	object_create_folder("f_reveal_grenades");
	CreateThread(audio_newobjective_beep);		--play new objective sfx
-- ============================================== 4/18/2014 revision	
	CreateThread(hollow_spawner);
--	ai_place(AI.sq_hollow_flipside);
-- =============================================== 4/18/2014 revision	
	CreateThread(hollow_objcon_a);
	CreateThread(hollow_objcon_b);
	CreateThread(hollow_objcon_c);
	CreateThread(hollow_projected_barrier);
	CreateThread(musket_hollow);
	CreateThread(tracking_hollow);
	CreateThread(ramp_flocks_spawner);
	Sleep(10);
	--CreateThread(hollow_cpb_killer);
	game_save_no_timeout();
end
function tracking_hollow():void
	object_create("track_hollow_cache_2");
	object_create("track_hollow_cpb");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_hollow_barrier)
				or	IsGoalActive(missionPlateau.goal_Hollow) == false
				], 3);
	object_destroy(OBJECTS.track_hollow_cpb);
	object_destroy(OBJECTS.track_hollow_cache_2);
	ObjectSetSpartanTrackingEnabled(OBJECTS.hollow_projected_barrier, true);
--[[
	Sleep(1);
	local shield:object_list = 
				object_list_children(OBJECTS.hollow_projected_barrier,
				TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate')
				);
	for _, val in ipairs(shield) do
		ObjectSetSpartanTrackingEnabled(val, false);
	end--]]
--	ObjectSetSpartanTrackingEnabled(object_at_marker(OBJECTS.hollow_projected_barrier, ""), false);
	SleepUntil(	[|	object_get_health( OBJECTS.hollow_projected_barrier) <= 0 
				or plateau_hollow_shield_health() <= 0 
				or	IsGoalActive(missionPlateau.goal_Hollow) == false
				], 3);
	ObjectSetSpartanTrackingEnabled(OBJECTS.hollow_projected_barrier, false);
	object_create("track_ramp");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_ramp)
				or	IsGoalActive(missionPlateau.goal_Hollow) == false
				], 3);
	object_destroy(OBJECTS.track_ramp);
end
function hollow_cpb_killer():void									-- kills projector with shield
	Sleep(10);
	SleepUntil([|	plateau_hollow_shield_health() <= 0],5);
	object_damage_damage_section (OBJECTS.hollow_projected_barrier, "glass", 2000);
	Sleep(2);
	object_damage_damage_section (OBJECTS.hollow_projected_barrier, "default", 2000);
end
function musket_hollow():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.mx_hollow_1, FLAGS.mt_hollow_1a, 2, FLAGS.mt_hollow_1b, 2, missionPlateau.goal_Hollow);
		CreateThread(muskbox, VOLUMES.mx_hollow_2, FLAGS.mt_hollow_2a, 2, FLAGS.mt_hollow_2b, 2, missionPlateau.goal_Hollow);
		CreateThread(muskbox, VOLUMES.mx_hollow_3, FLAGS.mt_hollow_3a, 2, FLAGS.mt_hollow_3b, 2, missionPlateau.goal_Hollow);
		CreateThread(muskbox, VOLUMES.mx_hollow_4, FLAGS.mt_hollow_4a, 2, FLAGS.mt_hollow_4b, 2, missionPlateau.goal_Hollow);
		CreateThread(muskbox, VOLUMES.mx_hollow_5, FLAGS.mt_hollow_5a, 2, FLAGS.mt_hollow_5b, 2, missionPlateau.goal_Hollow);
		CreateThread(muskbox, VOLUMES.mx_hollow_6, FLAGS.mt_hollow_6a, 2, FLAGS.mt_hollow_6b, 2, missionPlateau.goal_Hollow);
	end
end
function ramp_flocks_spawner():void
	SleepUntil(	[|	object_get_health( OBJECTS.hollow_projected_barrier) <= 0 
				or plateau_hollow_shield_health() <= 0 
				or	IsGoalActive(missionPlateau.goal_Hollow) == false
				], 3);
	CreateThread(flock_ramp_client);
end
function objective_text_goal_hollow():void														
		--	NARRATIVE CALL
		plateau_hollow_objective();																		-- ************  REMOVED THE CALL FROM THE NARRATIVE SCRIPT, added the VO lines mentionning the objective.  Guillaume  12/08
end
function hollow_spawner():void																			-- doing it this way so it works better with blink
	SleepUntil([| volume_test_players(VOLUMES.tv_liftoff_passed) ], 1);
	ai_place(AI.sq_hollow_interior);
	ai_place(AI.sq_hollow_porch_elite);
	ai_place(AI.sq_hollow_bulwark);
	ai_place(AI.sq_hollow_porch_grunts);
--	ai_place(AI.sq_hollow_flipside);
end
function hollow_sleep_test():void
	SleepUntil([| object_valid( "hollow_projected_barrier") ], 3);
	print("aewfawefawefwfe");
end
function hollow_projected_barrier():void
	object_create_variant("hollow_projected_barrier","no_shield")
	SleepUntil(	[|	(var_hollow_flipside >= ai_living_count(AI.sq_hollow_flipside))		or				-- hack until we fix the probelm with the shield's collision - wait til all flipside squad are on the other side of the shield or dead
					(volume_test_players(VOLUMES.tv_hollow_barrier))					]
				, 1);		
	object_create_anew("hollow_projected_barrier");
	SleepUntil(	[|	(var_cov_projector_barrier >= 1) or
					(volume_test_players(VOLUMES.tv_hollow_barrier))
				], 1);
	var_cov_projector_barrier = 1;																		-- turn on the barrier
	ai_object_set_team(OBJECTS.hollow_projected_barrier, TEAM.covenant);
	ai_object_set_team(	--object_at_marker(OBJECTS.hollow_projected_barrier, "mkr_child")				-- 
						object_at_marker(OBJECTS.hollow_projected_barrier, "")
						, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.hollow_projected_barrier, true);
	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.hollow_projected_barrier, ""), true);
end
function hollow_objcon_a():void
	SleepUntil([| volume_test_players(VOLUMES.tv_hollow_objcon_10) ], 1);
	if(var_hollow_objcon < 10)then
		var_hollow_objcon = 10;
	end
end
function hollow_objcon_b():void
	SleepUntil([| volume_test_players(VOLUMES.tv_hollow_objcon_20) ], 1);
	if(var_hollow_objcon < 20)then
		var_hollow_objcon = 20;
	end
	SleepUntil([| volume_test_players(VOLUMES.tv_hollow_objcon_50) ], 1);
	if(var_hollow_objcon < 50)then
		var_hollow_objcon = 50;
	end
	SleepUntil([| volume_test_players(VOLUMES.tv_hollow_objcon_60) ], 1);
	if(var_hollow_objcon < 60)then
		var_hollow_objcon = 60;
	end
end

function hollow_objcon_c():void
	SleepUntil([| volume_test_players(VOLUMES.tv_hollow_objcon_80) ], 1);
	var_hollow_objcon = 80;
end

function test_flipsiders()
	ai_place(AI.sq_hollow_flipside);
	CreateThread(hollow_projected_barrier);
--	object_create("veh_ghost_8");
	sleep_s(3);
	var_hollow_objcon = 20;
end

--[[
  ______    ______    ______   __              _______                       _______    ______   __       __  _______  
 /      \  /      \  /      \ |  \            |       \                     |       \  /      \ |  \     /  \|       \ 
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            | $$$$$$$                     | $$$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$____         ______       | $$__| $$| $$__| $$| $$$\ /  $$$| $$__/ $$
| $$|    \| $$  | $$| $$    $$| $$            | $$    \       |      \      | $$    $$| $$    $$| $$$$\  $$$$| $$    $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             \$$$$$$$\       \$$$$$$      | $$$$$$$\| $$$$$$$$| $$\$$ $$ $$| $$$$$$$ 
| $$__| $$| $$__/ $$| $$  | $$| $$_____       |  \__| $$                    | $$  | $$| $$  | $$| $$ \$$$| $$| $$      
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$                    | $$  | $$| $$  | $$| $$  \$ | $$| $$      
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$                      \$$   \$$ \$$   \$$ \$$      \$$ \$$      

--]]

missionPlateau.goal_Ramp = 
{
--	gotoVolume = VOLUMES.tv_ramp_objcon_40,
	gotoVolume = VOLUMES.tv_transition_to_bowl,	-- 8-13-2015 tjp: new transition spaces
	zoneSet = ZONE_SETS.plateau_start,
	objectives = { "track_end_of_ramp"},
	next = {"goal_PreBowl"}
}


function missionPlateau.goal_Ramp.Start():void
	ai_erase (AI.sg_reveal_all);
	CreateThread(sentry_show_swap);
		--	NARRATIVE CALL
		CreateThread(plateau_ramp_load);

	object_destroy_folder	("obj_reveal");						-- 12/1/14:added for UR, might be too aggressive
	object_destroy_folder	("f_reveal_grenades");				-- 12/1/14:added for UR, might be too aggressive
	object_destroy_folder	("f_reveal_weapons");				-- 12/1/14:added for UR, might be too aggressive
	garbage_collect_now();										-- 12/1/14:added for UR, might be too aggressive

--	object_create_folder("f_ramp_grenades");					-- 5/12/2015 removed all grenades
	object_create_folder("f_ramp_weapons");
	object_create_folder("veh_rampo");
	object_create_folder("obj_ramp");

	CreateThread(ramp_encounter_start);
	CreateThread(rampikazes_1);
	CreateThread(rampikazes_2);
	CreateThread(ramp_grunts_4_scramble);
	CreateThread(ramp_objcon_10);
	CreateThread(ramp_objcon_20);
	CreateThread(ramp_objcon_30);
	CreateThread(ramp_objcon_40);
	CreateThread(ramp_objcon_50);
	Sleep(4);
	CreateThread(tracking_ramp);
	Sleep(4);
	game_save_no_timeout();
end
function tracking_ramp():void

	object_create("track_end_of_ramp");
	object_create("track_ramp_cache");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_ramp_objcon_40)
				or	IsGoalActive(missionPlateau.goal_Ramp) == false
				], 3);
	object_destroy(OBJECTS.track_end_of_ramp);
	object_destroy(OBJECTS.track_ramp_cache);
end

function sentry_show_swap():void
	composer_stop_show(sentry_show);
	b_liftoff_idle = true;
	object_destroy(OBJECTS.vin_sent_machine);
	Sleep(2);
	CreateThread(leadsplayer_show);
	Sleep(6);
	CreateThread(ss_man_the_ramp_guns);	
--	CreateThread(flag_arbiter_banshees_for_ramp);
	CreateThread(slim_down_ss_for_ramp);
end
function leadsplayer_show():void
	sentry_show = composer_play_show("comp_sentryleadsplayer");
		--														, {	phantom1 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_phantom_a.pilot),
		--															phantom3 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_phantom_b.pilot),
		--															phantom2 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_phantom_c.pilot),
		--															banshee1 = OBJECTS.banshee1,			-- need to make these ai-controlled banshees as well
		--															banshee2 = OBJECTS.banshee2,			-- need to make these ai-controlled banshees as well
		--															banshee3 = OBJECTS.banshee3});			-- need to make these ai-controlled banshees as well
		--															banshee1 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee1.a),
		--															banshee2 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee2.a),
		--															banshee3 = ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee3.a)});
end
function test_leadsplayer():void																	-- test function
	b_sentryleadsplayer = true;																		-- the composition waits until this bit is flipped
--	sentry_show_swap();
--	ai_place(AI.sg_ramp_aircraft);																	-- place ai-controlled vehicles that are used in the composition
--	ai_place(AI.sq_ramp_phantom_a);
--	ai_place(AI.sq_ramp_phantom_b);
--	ai_place(AI.sq_ramp_phantom_c);
	Sleep(2);
	CreateThread(leadsplayer_show);
	Sleep(6);
	CreateThread(ss_man_the_ramp_guns);	
--	CreateThread(flag_arbiter_banshees_for_ramp);
	CreateThread(slim_down_ss_for_ramp);
--	CreateThread(ramp_phantom_a);
--	CreateThread(ramp_phantom_b);
end
function ramp_phantom_a():void																					-- was a command script. Navigation now handled by vignette.
	unit_open(unit_get_vehicle(AI.sq_ramp_phantom_a));
	SleepUntil([| b_sentryleadsplayer == true], 1);
	sleep_s(4);
	unit_close(unit_get_vehicle(AI.sq_ramp_phantom_a));
end
function ramp_phantom_b():void																					-- was a command script. Navigation now handled by vignette.
--	ai_place(AI.sq_ramp_grunts_4);				-- made into rampikazes
--	ai_place(AI.sq_ramp_grunts_5);
--    f_load_drop_ship (AI.sq_ramp_phantom_c, AI.sq_ramp_grunts_4, true, false);
--	f_load_drop_ship (AI.sq_ramp_phantom_c, AI.sq_ramp_grunts_5, true, false);
	unit_open(ai_vehicle_get_from_spawn_point(AI.sq_ramp_phantom_c.pilot));
	SleepUntil([| b_sentryleadsplayer == true], 1);
	f_unload_drop_ship (AI.sq_ramp_phantom_c);
	unit_close(ai_vehicle_get_from_spawn_point(AI.sq_ramp_phantom_c.pilot));
end

function flag_arbiter_banshees_for_ramp():void
	ai_object_set_team(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee1.a), TEAM.player);	
	ai_object_set_team(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee2.a), TEAM.player);	
	ai_object_set_team(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee3.a), TEAM.player);	
	unit_set_enterable_by_player(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee1.a), false);	
	unit_set_enterable_by_player(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee2.a), false);	
	unit_set_enterable_by_player(ai_vehicle_get_from_spawn_point(AI.sq_ramp_banshee3.a), false);	
end
function ramp_encounter_start():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp) ], 1);
	CreateThread(audio_plateau_ramp_start);
--	ai_place(AI.sq_ramp_grunts_1b);
	ai_place(AI.sq_ramp_ghost_1);
	SleepUntil([| volume_test_players(VOLUMES.tv_leadsplayer) ], 1);
	b_sentryleadsplayer = true;																			-- sends SS on its merry way
	sleep_s(1);
	ai_place(AI.sq_ramp_grunts_1);
	ai_place(AI.sq_ramp_grunts_2);
	ai_place(AI.sq_ramp_grunts_5);
end
function ramp_swat():void
	CreateThread(standard_shake);
	damage_new(	TAG("objects/props/covenant/battery/fx/covenant_battery_explosion.damage_effect"), FLAGS.fl_swat);
	RunClientScript("swat");	
end
function ramp_grunts_4_scramble():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_tramp_7a) or
					volume_test_players(VOLUMES.tv_tramp_7b) 	
				], 1);
--	cs_run_command_script(AI.sq_ramp_grunts_4.a, "cs_ramp_flee_2");									-- snap out of command script so they don't grind against barrier
	Sleep(30);
--	cs_run_command_script(AI.sq_ramp_grunts_4.b, "cs_ramp_flee_2");									-- snap out of command script so they don't grind against barrier
	Sleep(30);
--	cs_run_command_script(AI.sq_ramp_grunts_4.c, "cs_ramp_flee_2");									-- snap out of command script so they don't grind against barrier
end

function ramp_objcon_10():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_10) ], 1);
	var_ramp_objcon = 10;
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_15) ], 1);
end
function ramp_objcon_20():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_20) ], 1);
	var_ramp_objcon = 20;
	game_save_no_timeout();
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_25) ], 1);
	var_ramp_objcon = 25;
end
function ramp_objcon_30():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_30) ], 1);
	var_ramp_objcon = 30;
end
function ramp_objcon_40():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_40) ], 1);
	var_ramp_objcon = 40;
end
function ramp_objcon_50():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_50) ], 1);
	var_ramp_objcon = 50;
end
function rampikazes_1():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_15) ], 3);
	ai_place(AI.sq_rampikaze_1);
end
function rampikazes_2():void
	SleepUntil([| volume_test_players(VOLUMES.tv_ramp_objcon_25) ], 3);
	ai_place(AI.sq_rampikaze_2);
	ai_place(AI.sq_rampikaze_3);
end
function cs_rampikaze_a():void
	ai_grunt_kamikaze(ai_current_actor);
	cs_abort_on_alert(ai_current_actor, true);
	cs_go_to(POINTS.ps_ramp.kaze_a);
end
function cs_rampikaze_b():void
	ai_grunt_kamikaze(ai_current_actor);
	cs_abort_on_alert(ai_current_actor, true);
	cs_go_to(POINTS.ps_ramp.kaze_b);
end
function cs_rampikaze_y():void
	ai_grunt_kamikaze(ai_current_actor);
	cs_abort_on_alert(ai_current_actor, true);
	cs_go_to(POINTS.ps_ramp.kaze_y);
end
function cs_rampikaze_z():void
	ai_grunt_kamikaze(ai_current_actor);
	cs_abort_on_alert(ai_current_actor, true);
	cs_go_to(POINTS.ps_ramp.kaze_z);
end
--[[
  ______    ______    ______   __              _______    ______                       _______                       _______                           __ 
 /      \  /      \  /      \ |  \            |       \  /      \                     |       \                     |       \                         |  \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            | $$$$$$$ |  $$$$$$\                    | $$$$$$$\  ______    ______  | $$$$$$$\  ______   __   __   __ | $$
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$____  | $$__| $$       ______       | $$__/ $$ /      \  /      \ | $$__/ $$ /      \ |  \ |  \ |  \| $$
| $$|    \| $$  | $$| $$    $$| $$            | $$    \ | $$    $$      |      \      | $$    $$|  $$$$$$\|  $$$$$$\| $$    $$|  $$$$$$\| $$ | $$ | $$| $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             \$$$$$$$\| $$$$$$$$       \$$$$$$      | $$$$$$$ | $$   \$$| $$    $$| $$$$$$$\| $$  | $$| $$ | $$ | $$| $$
| $$__| $$| $$__/ $$| $$  | $$| $$_____       |  \__| $$| $$  | $$                    | $$      | $$      | $$$$$$$$| $$__/ $$| $$__/ $$| $$_/ $$_/ $$| $$
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$| $$  | $$                    | $$      | $$       \$$     \| $$    $$ \$$    $$ \$$   $$   $$| $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$  \$$   \$$                     \$$       \$$        \$$$$$$$ \$$$$$$$   \$$$$$$   \$$$$$\$$$$  \$$
--]]

missionPlateau.goal_PreBowl = 
{
	gotoVolume = VOLUMES.tv_ghostcave_start,
	zoneSet = ZONE_SETS.plateau_transition,
	next = {"goal_Bowl"},
}

function missionPlateau.goal_PreBowl.Start():void
	ai_erase(AI.sg_hollow_all);

		--	NARRATIVE CALL
		CreateMissionThread(plateau_prebowl_load);
	
	object_destroy_folder	("obj_reveal");
	object_destroy_folder	("f_reveal_grenades");
	object_destroy_folder	("f_reveal_weapons");
	Sleep(3);
	object_create_folder	("veh_entrance");
	object_create_folder	("obj_bowl");
	object_create_folder	("cr_bowl");
	object_create_folder	("wp_bowl");
	object_create_anew		("dp_powersupply_1");
	object_create_folder	("f_bowl_grenades");

	CreateThread (dp_bowl_saves);
	CreateThread (dp_bowlreminderobj);
	CreateThread(dp_bowl_start);
	CreateThread(prebowl_ss_cleanup);
	CreateThread(update_profiles);
	CreateThread(tracking_prebowl);
	Sleep(10);
	CreateThread(audio_plateau_ramp_outro);
	ai_object_set_team	(OBJECTS.dp_powersupply_1, TEAM.covenant);
	ai_object_set_team(	object_at_marker(OBJECTS.dp_powersupply_1, ""), TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dp_powersupply_1, true);
	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.dp_powersupply_1, ""), true);
end
function tracking_prebowl():void
	-- 8-14-2015: needs to be updated for new transition geo
	Sleep(4);																							-- required
	object_create("track_end_of_ramp");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_bowl_spawn_begin)
				or	IsGoalActive(missionPlateau.goal_PreBowl) == false
				], 3);
	object_destroy(OBJECTS.track_end_of_ramp);
end
function update_profiles():void
	player_set_profile(STARTING_PROFILES.later, SPARTANS.locke);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.vale);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.tanaka);
	player_set_profile(STARTING_PROFILES.later, SPARTANS.buck);
end
function prebowl_ss_cleanup():void
	SleepUntil([| volume_test_players(VOLUMES.tv_bowl_spawn_begin) ], 1);
	ai_erase(AI.sg_ramp_ss_gunners);
	object_destroy(OBJECTS.vin_sent_machine);
	game_save_no_timeout();
end
function prebowl_objective():void
	ObjectiveShow (TITLES.ch_retrieve_constructor);
end
--[[
  ______    ______    ______   __               ______                       _______    ______   __       __  __       
 /      \  /      \  /      \ |  \             /      \                     |       \  /      \ |  \  _  |  \|  \      
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |  $$$$$$\                    | $$$$$$$\|  $$$$$$\| $$ / \ | $$| $$      
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$___\$$       ______       | $$__/ $$| $$  | $$| $$/  $\| $$| $$      
| $$|    \| $$  | $$| $$    $$| $$            | $$    \       |      \      | $$    $$| $$  | $$| $$  $$$\ $$| $$      
| $$ \$$$$| $$  | $$| $$$$$$$$| $$            | $$$$$$$\       \$$$$$$      | $$$$$$$\| $$  | $$| $$ $$\$$\$$| $$      
| $$__| $$| $$__/ $$| $$  | $$| $$_____       | $$__/ $$                    | $$__/ $$| $$__/ $$| $$$$  \$$$$| $$_____ 
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$                    | $$    $$ \$$    $$| $$$    \$$$| $$     \
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$                      \$$$$$$$   \$$$$$$  \$$      \$$ \$$$$$$$$
--]]

missionPlateau.goal_Bowl = 
{
--	description = "Enter the Holy Site",
--	zoneSet = ZONE_SETS.plateau_transition,
	next = {"goal_Tomb"};
}

function missionPlateau.goal_Bowl.Start():void

	--	NARRATIVE CALL
	CreateThread(plateau_bowl_load);
	CreateThread(bowl_zone_set_loader);
	CreateThread(teleport_players_into_bowl);


	object_destroy_folder("obj_hollow");
	object_destroy_folder("veh_hollow");
	object_destroy_folder("veh_rampo");

	game_save_no_timeout();
	CreateThread(f_bowl_objective);
	CreateThread (dp_entrancecheck);
	CreateThread(tracking_bowl);
	CreateThread(musket_bowl);
	--CreateThread(bowl_cpb_killer);
	CreateThread(bowl_jump_hint_manager);
--	CreateThread(bowl_ai_drain);
end
function missionPlateau.goal_Bowl.End():void
	print("goal_Bowl.End");
	--game_save_no_timeout();
	sleep_s(1.5);
end
function bowl_zone_set_loader():void
	SleepUntil(	[|	volume_test_players_all(VOLUMES.tv_bowl_all) == true	], 5);
	--if(current_zone_set() ~= ZONE_SETS.plateau_bowl)then
	--	switch_zone_set(ZONE_SETS.plateau_bowl);
	--end
	--object_create("blockwall1");
	--object_create("blockwall2");
--	object_destroy_folder("f_ramp_grenades");
	object_destroy_folder("f_ramp_weapons");
	object_destroy(OBJECTS.hollow_projected_barrier);
	object_destroy_folder("obj_ramp");
	ai_erase(AI.sg_ramp_all);
	garbage_collect_now();																	-- added for UR, might be too aggressive
end
function teleport_players_into_bowl():void													-- will trigger zone set swap
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_dp_objcon_20) == true	], 2);
	volume_teleport_players_not_inside(VOLUMES.tv_bowl_all, FLAGS.fl_bowl_entrance);
	CreateThread(bowl_zone_set_loader);
end
function tracking_bowl():void
	CreateThread(tracking_bowl_cache);														-- CreateThread for blip that dies on its own trigger
--	object_create("track_overload");													--
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scan_shieldgenerator, true);				-- turn on outline highlighting
	ObjectSetSpartanTrackingEnabled( OBJECTS.dp_powersupply_1, true);
	object_create("track_temple_entrance");
	ObjectSetSpartanTrackingEnabled( OBJECTS.track_ghost_cache, true);
	
	SleepUntil(	[|	
--						object_get_health( OBJECTS.dp_powersupply_1) <= 0					-- projector destroyed
--				or		plateau_bowl_shield_health() <= 0										-- shield destroyed
--				or		
						volume_test_players(VOLUMES.tv_dp_objcon_110)							-- a player gets behind the shield
				or		IsGoalActive(missionPlateau.goal_Bowl) == false							-- the goal is no longer valid
				], 3);
	object_destroy(OBJECTS.track_temple_entrance);											-- kill all blips
	object_destroy(OBJECTS.track_ghost_cache);
--	object_destroy(OBJECTS.track_overload);
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scan_shieldgenerator, false);				-- disable outline highlighting
	ObjectSetSpartanTrackingEnabled( OBJECTS.dp_powersupply_1, false);
	if(IsGoalActive(missionPlateau.goal_Bowl) == true)then									-- if we're still in the bowl goal
		CreateThread(tracking_temple_entrance);												-- fire off next tracking function 
	end
end
function tracking_bowl_cache():void
--	object_create("track_bowl_cache");						
	ObjectSetSpartanTrackingEnabled( OBJECTS.track_bowl_cache, true);
	SleepUntil(	[|	
--					volume_test_players(VOLUMES.tv_bowl_cache) or			nav				-- a player has reached the cache
					IsGoalActive(missionPlateau.goal_Bowl) == false							-- the goal is no longer valid
				], 3);
	object_destroy(OBJECTS.track_bowl_cache);												-- kill blip
end
function tracking_temple_entrance():void
	object_create("track_temple_exit");														-- turn on blip in the temple interior
	SleepUntil(	[|	IsGoalActive(missionPlateau.goal_Bowl) == false							-- wait until both of the goals are done
				and IsGoalActive(missionPlateau.goal_Tomb) == false
				], 3);
	object_destroy(OBJECTS.track_temple_exit);												-- turn off blip in the temple interior
end
function musket_bowl():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.mx_bowl_1, FLAGS.mt_bowl_1a, 3, FLAGS.mt_bowl_1b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_2, FLAGS.mt_bowl_2a, 3, FLAGS.mt_bowl_2b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_3, FLAGS.mt_bowl_3a, 3, FLAGS.mt_bowl_3b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_4, FLAGS.mt_bowl_4a, 3, FLAGS.mt_bowl_4b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_5, FLAGS.mt_bowl_5a, 3, FLAGS.mt_bowl_5b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mx_bowl_6, FLAGS.mt_bowl_6a, 3, FLAGS.mt_bowl_6b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_7, FLAGS.mt_bowl_7a, 3, FLAGS.mt_bowl_7b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_8, FLAGS.mt_bowl_8a, 3, FLAGS.mt_bowl_8b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_9, FLAGS.mt_bowl_9a, 3, FLAGS.mt_bowl_9b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_10, FLAGS.mt_bowl_10a, 3, FLAGS.mt_bowl_10b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mx_bowl_11, FLAGS.mt_bowl_11a, 3, FLAGS.mt_bowl_11b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_12, FLAGS.mt_bowl_12a, 3, FLAGS.mt_bowl_12b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_13, FLAGS.mt_bowl_13a, 3, FLAGS.mt_bowl_13b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_14, FLAGS.mt_bowl_14a, 3, FLAGS.mt_bowl_14b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_15, FLAGS.mt_bowl_15a, 3, FLAGS.mt_bowl_15b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mx_bowl_16, FLAGS.mt_bowl_16a, 3, FLAGS.mt_bowl_16b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_17, FLAGS.mt_bowl_17a, 3, FLAGS.mt_bowl_17b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_18, FLAGS.mt_bowl_18a, 3, FLAGS.mt_bowl_18b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_19, FLAGS.mt_bowl_19a, 3, FLAGS.mt_bowl_19b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_20, FLAGS.mt_bowl_20a, 3, FLAGS.mt_bowl_20b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mx_bowl_21, FLAGS.mt_bowl_21a, 3, FLAGS.mt_bowl_21b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_22, FLAGS.mt_bowl_22a, 3, FLAGS.mt_bowl_22b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_23, FLAGS.mt_bowl_23a, 3, FLAGS.mt_bowl_23b, 6, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_24, FLAGS.mt_bowl_24a, 3, FLAGS.mt_bowl_24b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_25, FLAGS.mt_bowl_25a, 3, FLAGS.mt_bowl_25b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
		CreateThread(muskbox, VOLUMES.mx_bowl_26, FLAGS.mt_bowl_26a, 3, FLAGS.mt_bowl_26b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_27, FLAGS.mt_bowl_27a, 3, FLAGS.mt_bowl_27b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_28, FLAGS.mt_bowl_28a, 3, FLAGS.mt_bowl_28b, 3, missionPlateau.goal_Bowl);
		CreateThread(muskbox, VOLUMES.mx_bowl_29, FLAGS.mt_bowl_29a, 3, FLAGS.mt_bowl_29b, 3, missionPlateau.goal_Bowl);
		Sleep(3);
	end
end
function f_bowl_objective():void
	SleepUntil ([| volume_test_players(VOLUMES.tv_entered_temple)], 1);
	GoalCompleteTask(missionPlateau.goal_Bowl);
	game_save_no_timeout();
	ClearAllDynamicCheckpoints();     
	print("goal complete");
end
function bowl_emp_event():void

	if(IsServer())then
		PROFILE.core.oreo_button_release = true;																-- branching narrative
	end
	sleep_s (.5);					-- slight sleep for ease in
	RunClientScript("overload_charge_up"); -- start swelling glow
	sleep_s (.5);					-- to maintain timing of audio script
	CreateThread(audio_emp_blast); -- sound has a charge up before the blast effect; triggering it before sleep_s
	sleep_s(2.5);
	print ("destroy shield.");
	object_damage_damage_section (OBJECTS.dp_powersupply_1, "glass", 2000);
	Sleep(2);
	object_damage_damage_section (OBJECTS.dp_powersupply_1, "default", 2000);
--	damage_new( TAG('levels/temp/ahogan/w2_hub/damage_effects/rockfall_blast.damage_effect'), FLAGS.fl_cpb );

	RunClientScript("fx_emp_blast_client");
	object_set_health(OBJECTS.dp_powersupply_1, -1);
--	effect_new_on_ground( TAG('levels/campaignworld020/w2_hub/fx/explosions/emp_console_blast.effect'), OBJECTS.dc_scan_shieldgenerator);

	f_emp_field(VOLUMES.tv_emp_radius);
end
function bowl_cpb_killer():void									-- kills projector with shield
	sleep_s(3);
	SleepUntil([|	plateau_bowl_shield_health() <= 0],5);
	object_damage_damage_section (OBJECTS.dp_powersupply_1, "default", 2000);
	object_damage_damage_section (OBJECTS.dp_powersupply_1, "glass", 2000);
end
function f_emp_field(vol:volume)																			-- Script that strips the shields of any biped or disables any piloted vehicle that pass through the trigger volume

		for _, spartan in ipairs (spartans()) do
			if(volume_test_object(VOLUMES.tv_emp_radius, spartan))then
			-- interior, back left building:
				damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), spartan); 
				if(unit_get_vehicle(spartan)~= nil)then
					damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), unit_get_vehicle(spartan)); -- EMP
				end
			end
			
		end
	-- new:
		if(volume_test_object(VOLUMES.tv_emp_radius, AI.sq_dp_hg_frontyard.spawn_points_0))then
			-- interior, back left building:
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_hg_frontyard.spawn_points_0); 
		end
		if(volume_test_object(VOLUMES.tv_emp_radius, AI.sq_dp_ranger_crew.e))then
			-- ranger leader:
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_ranger_crew.e); 
		end
		-- left gunner:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_shadeturret_gunner.gunner); 
		-- rockpile safeties:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_rockpile_crew.leader_e); 
		-- early tunnelmid
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunnel_1a.spawn_points_1); 
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunnel_1a.spawn_points_2); 
		-- early tunneltop phantom squad leader:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunneltop1.spawn_points_1); 
		-- left sweep:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_left_sweep_bulwark.spawn_points_0); 
		-- bridgetop general (either/or):
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunneltop2.spawn_points_0); 
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunneltop2.spawn_points_1); 
		-- underbridge elite:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_tunnel_2.spawn_points_2); -- strips shields
		-- wraith gunner:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), AI.sq_dp_topwraith);
		-- wraith:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), ai_vehicle_get_from_spawn_point(AI.sq_dp_topwraith.spawn_points_1)); -- EMPs
		-- near shade:
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), OBJECTS.veh_plat_shade_2); -- EMP
	-- /new
--[[ old: this just never worked well, if at all
	local f:object_list=volume_return_objects_by_type(vol, 1);
	local g:object_list=volume_return_objects_by_type(vol, 2);	
--	local render:object = OBJECTS[emp_field];
	local time = 1;
	print("emp");
	repeat
	SleepUntil (	[|	volume_return_objects_by_type(vol, 1)[1] ~= nil
					], 1);		
      	f=volume_return_objects_by_type(vol, 1);
		-- Applies the damage of the charged plasma pistol to any biped that passes through the field.
		for _,obj in pairs(f) do
--			damage_object_effect(TAG('objects\weapons\pistol\storm_plasma_pistol\projectiles\damage_effects\storm_plasma_pistol_charged_bolt_aoe.damage_effect'), obj);
--			damage_object_effect(TAG('objects\weapons\pistol\storm_plasma_pistol\projectiles\damage_effects\storm_plasma_pistol_charged_bolt.damage_effect'), obj);
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), obj);
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), obj);
			print("EMP'd type 1");
		end
	SleepUntil (	[|	volume_return_objects_by_type(vol, 2)[1] ~= nil
					], 1);		
		g=volume_return_objects_by_type(vol, 2);
		-- Applies the damage of the charged plasma pistol to any piloted vehicle that passes through the field.
		for _,obj in pairs(g) do
--			damage_object_effect(TAG('objects\weapons\pistol\storm_plasma_pistol\projectiles\damage_effects\storm_plasma_pistol_charged_bolt_aoe.damage_effect'), obj);
--			damage_object_effect(TAG('objects\weapons\pistol\storm_plasma_pistol\projectiles\damage_effects\storm_plasma_pistol_charged_bolt.damage_effect'), obj);
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), obj);
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), obj);
			print("EMP'd type 3");
		end
		sleep_s(1);
		time = time - 1;
	until time == 0;
--]]


end
--function bowl_ai_drain():void														-- sneaky AI cleanup
	--SleepUntil([|	n_dp_objcon >= 60], 10);
	--repeat
		--for _, obj in ipairs (volume_return_objects(VOLUMES.tv_bowl_drain_1)) do
			--if(volume_test_players(VOLUMES.tv_drainsafe) == false)then
				--ai_erase(object_get_ai(obj));
			--end
		--end
	--Sleep(10);
	--until(IsGoalActive(missionPlateau.goal_Bowl) == false);
--end


--//=========//	Tracking Scripts	//=========////
function f_dc_overload_interact(trigger:object, p_player:object):void
	local this_activator:object = p_player or PLAYERS.player0 ;
	composer_play_show("collectible", { scanner = this_activator});
--[[
	local pl:player = unit_get_player (p_player);
--	composer_play_show ("collectible", {scanner = pl});
	print("this far");
	if(pl == PLAYERS.player0)then
		print("player0")
		Sleep(3);
		composer_play_show ("collectible", {scanner = PLAYERS.player0});
	elseif(pl == PLAYERS.player1)then
		print("player1")
		Sleep(3);
		composer_play_show ("collectible", {scanner = PLAYERS.player1});
	elseif(pl == PLAYERS.player2)then
		print("player2")
		Sleep(3);
		composer_play_show ("collectible", {scanner = PLAYERS.player2});
	elseif(pl == PLAYERS.player3)then
		print("player3")
		Sleep(3);
		composer_play_show ("collectible", {scanner = PLAYERS.player3});
	end
-- this works: composer_play_show ("collectible", {scanner = PLAYERS.player0});
--]]
	device_set_power(OBJECTS.dc_scan_shieldgenerator, 0);
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_scan_shieldgenerator, false );
	
	CreateThread(bowl_emp_event);
end

function bowl_jump_hint_manager():void
	ai_disable_jump_hint(HINTS.jh_bowl_3);
	ai_disable_jump_hint(HINTS.jh_bowl_4);
	ai_disable_jump_hint(HINTS.jh_bowl_5);
	ai_disable_jump_hint(HINTS.jh_bowl_6);
	CreateThread(bashwall_jump_3);
	CreateThread(bashwall_jump_4);
	CreateThread(bashwall_jump_5);
	CreateThread(bashwall_jump_6);
end
function bashwall_jump_3():void
	SleepUntil([| object_get_health(OBJECTS.bashwall3) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bowl_3);
end
function bashwall_jump_4():void
	SleepUntil([| object_get_health(OBJECTS.bashwall4) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bowl_4);
end
function bashwall_jump_5():void
	SleepUntil([| object_get_health(OBJECTS.bashwall5) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bowl_5);
end
function bashwall_jump_6():void
	SleepUntil([| object_get_health(OBJECTS.bashwall6) <= 0 ], 20);
	ai_enable_jump_hint(HINTS.jh_bowl_6);
end

--[[
  ______    ______    ______   __              ________                      ________   ______   __       __  _______  
 /      \  /      \  /      \ |  \            |        \                    |        \ /      \ |  \     /  \|       \ 
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$             \$$$$$$$$                     \$$$$$$$$|  $$$$$$\| $$\   /  $$| $$$$$$$\
| $$ __\$$| $$  | $$| $$__| $$| $$                /  $$        ______          | $$   | $$  | $$| $$$\ /  $$$| $$__/ $$
| $$|    \| $$  | $$| $$    $$| $$               /  $$        |      \         | $$   | $$  | $$| $$$$\  $$$$| $$    $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              /  $$          \$$$$$$         | $$   | $$  | $$| $$\$$ $$ $$| $$$$$$$\
| $$__| $$| $$__/ $$| $$  | $$| $$_____        /  $$                           | $$   | $$__/ $$| $$ \$$$| $$| $$__/ $$
 \$$    $$ \$$    $$| $$  | $$| $$     \      |  $$                            | $$    \$$    $$| $$  \$ | $$| $$    $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$                              \$$     \$$$$$$  \$$      \$$ \$$$$$$$ 
--]]
missionPlateau.goal_Tomb = 
{
	gotoVolume = VOLUMES.tv_snapshut,						
	zoneSet = ZONE_SETS.plateau_bowl,
	next = {"goal_Temp_Bypass"};	--												temp BS while tracking is being revised
}
function missionPlateau.goal_Tomb.Start():void
	CreateThread(make_temple_stuff);
	CreateThread(tracking_temple_entrance);
	--	NARRATIVE CALL
		CreateThread(plateau_temple_load);
	if(IsServer())then
		if	(PROFILE.core.oreo_button_release ~= true)then															-- branching narrative
			PROFILE.core.oreo_destroyed_gate = true;
		end
	end
	PauseGame();
end
function make_temple_stuff():void
	object_create("dm_statue");
	object_create("dc_temple_switch");
end
function remove_temple_stuff():void
	object_destroy(OBJECTS.dm_statue);
	object_destroy(OBJECTS.dc_temple_switch);
end

-- =====================================================================			temp BS while tracking is being revised ^^^^^^
--[[
  ______                       __        ________                              ________  _______    ______    ______   __    __  ______  __    __   ______  
 /      \                     |  \      |        \                            |        \|       \  /      \  /      \ |  \  /  \|      \|  \  |  \ /      \ 
|  $$$$$$\  ______    ______  | $$       \$$$$$$$$______                       \$$$$$$$$| $$$$$$$\|  $$$$$$\|  $$$$$$\| $$ /  $$ \$$$$$$| $$\ | $$|  $$$$$$\
| $$ __\$$ /      \  |      \ | $$          /  $$|      \        ______          | $$   | $$__| $$| $$__| $$| $$   \$$| $$/  $$   | $$  | $$$\| $$| $$ __\$$
| $$|    \|  $$$$$$\  \$$$$$$\| $$         /  $$  \$$$$$$\      |      \         | $$   | $$    $$| $$    $$| $$      | $$  $$    | $$  | $$$$\ $$| $$|    \
| $$ \$$$$| $$  | $$ /      $$| $$        /  $$  /      $$       \$$$$$$         | $$   | $$$$$$$\| $$$$$$$$| $$   __ | $$$$$\    | $$  | $$\$$ $$| $$ \$$$$
| $$__| $$| $$__/ $$|  $$$$$$$| $$       /  $$  |  $$$$$$$                       | $$   | $$  | $$| $$  | $$| $$__/  \| $$ \$$\  _| $$_ | $$ \$$$$| $$__| $$
 \$$    $$ \$$    $$ \$$    $$| $$      |  $$    \$$    $$                       | $$   | $$  | $$| $$  | $$ \$$    $$| $$  \$$\|   $$ \| $$  \$$$ \$$    $$
  \$$$$$$   \$$$$$$   \$$$$$$$ \$$       \$$      \$$$$$$$                        \$$    \$$   \$$ \$$   \$$  \$$$$$$  \$$   \$$ \$$$$$$ \$$   \$$  \$$$$$$ 
--]]                                                                                                                                                             
missionPlateau.goal_Temp_Bypass = 
{
	zoneSet = ZONE_SETS.plateau_bowl,						
	next = {"goal_SoldierTaunt"};
}
function missionPlateau.goal_Temp_Bypass.Start():void
	CreateThread(end_bypass_goal_listener);								-- listens for bool to be set, then ends this goal
	CreateThread(seal_players_in_temple);								-- handles teleporting, closing the door
	CreateThread(temple_zone_set_swap);									-- preps, waits for all players to get inside, then swaps zone sets
	CreateThread(musket_tracking);										-- makes musketeers post up in positions out of the way
	game_save_no_timeout();												-- saves game, duh
end
function faux_tracking_sequence():void									-- called from narrative script
--	object_create("dc_temple_switch");
	ObjectSetSpartanTrackingEnabled( OBJECTS.dm_statue, true );	
	ObjectiveShow (TITLES.ch_exit_temple);
end
function musket_tracking():void
		CreateThread(muskbox, VOLUMES.tv_snapshut, FLAGS.mt_temple_1a, 5, FLAGS.mt_temple_1b, 5, missionPlateau.goal_Temp_Bypass);
end
function f_dc_temple_door_control(trigger:object, p_player:object):void
	CreateThread(f_dc_temple_door_control_2, trigger, p_player);
--	I moved the content in another function to be able to delay the opening of the door a little for VO.			--Guillaume
end
function f_dc_temple_door_control_2(trigger:object, p_player:object):void
	local this_activator:object = p_player or PLAYERS.player0 ;
	composer_play_show("collectible", { scanner = this_activator});
	device_set_power(OBJECTS.dc_temple_switch, 0);
	--	NARRATIVE CALL
	CreateThread(plateau_temple_mechanism_launcher,trigger, p_player);
	CreateThread(audio_temple_statue_trigger);
	sleep_s(0.5);
	CreateThread(open_door_sequence);
end
function test_push():void
	composer_play_show("comp_press_button", { ics_player = PLAYERS.player0});
	CreateThread(open_door_sequence);--test
	sleep_s(2);
	CreateThread(remove_temple_stuff);
	Sleep(3);
	CreateThread(make_temple_stuff);
end
function open_door_sequence():void
	Sleep(30);
	b_temple_zone_set_go = true;
	b_end_temple_goal = true;																		-- end objective
	ObjectSetSpartanTrackingEnabled( OBJECTS.dm_statue, false );
	sleep_s(1);
	device_set_power(OBJECTS.dm_statue, 1);
	device_set_position(OBJECTS.dm_statue, 1);
	RunClientScript("start_global_rumble_shake_small", 8);
--	SleepUntil(	[|	current_zone_set_fully_active() == ZONE_SETS.plateau_temple_advance	], 5);
	CreateThread(temple_door_open);
end
-- ============= mousetrap logic =================
global b_temple_zone_set_go:boolean = false;

function seal_players_in_temple():void
	local l_timer:number = -1;
	-- trailblazer makes it to interior:
	SleepUntil([|volume_test_players(VOLUMES.tv_snapshut)],3);	
	
	-- begin listening for snapshut conditions:
	-- (note: if players are force-teleported, these conditions will be met)
	
	l_timer = timer_stamp( 45 );   --failsafe for anyone leaving a controller and walking away  --cf 8/18/15
	SleepUntil(	[|	 volume_test_players_all(VOLUMES.tv_snapshut_2) == true					-- everyone is inside
				and	 ( volume_test_players_lookat(VOLUMES.tv_snapshut_look, 21, 66) == false	or timer_expired( l_timer ) ) -- no one is looking or failsafe timer has expired
				],3);
	
	-- place door to prevent backtracking:						
	object_create("cr_temple_entrance_door");

	-- permission to swap zone sets:
	b_temple_zone_set_go = true;

	-- rescue musketeers if stuck:
	CreateThread(round_up_musketeers_in_temple);
	-- 8-10-2015 overkill because I'm scared:
	CreateThread(round_up_players_in_temple);
end
function temple_zone_set_swap():void									-- called as soon as goal starts
	print("____ waiting on b_temple_zone_set_go .. ");
	SleepUntil([| b_temple_zone_set_go == true], 3);					-- set either:
																		--			- when all players are in temple and not looking at the entrance they came through
																		--			- when device is operated
		print("____ b_temple_zone_set_go == true ");
		CreateThread(round_up_players_in_temple);						--need to teleport right before the prepare because we drop bowl during a prepare -cf 8/17/15
		CreateThread(round_up_musketeers_in_temple);
		Sleep(2);
		print("conditions to begin zone set swap have been met");
		prepare_to_switch_to_zone_set(ZONE_SETS.plateau_temple_advance);
			
--		sleep_s(9);			-- tjp 8-27-2015
		zs_swap_buffer();	-- tjp 8-27-2015
			
		switch_zone_set(ZONE_SETS.plateau_temple_advance);
end
-- tjp 8-27-2015:	changing how the dumb-fire delay is done 
--					to esnure stone door doesn't open
--					on to a missing bsp
global b_zs_buffer_done:boolean = false
function zs_swap_buffer():void
		sleep_s(12);																	-- 9-3-2015
		b_zs_buffer_done = true;
end
---- /tjp8-27-2015
function round_up_players_in_temple():void												-- we don't want to jar players 
																						-- who don't absolutely need to 
																						-- to be teleported, so we judge 
																						-- where they are:
	-- if the door isn't there yet:
	if	(object_valid("cr_temple_entrance_door") == false)	then
	
		for _,spartan in ipairs (players()) do
			-- This is for all players just inside temple door, still in view of the bowl.
			-- If they're looking where the door is about to pop into existence, teleport them:

			if (
					volume_test_player_lookat(VOLUMES.tv_snapshut_look, spartan, 21, 66)	-- if they will see the door spawn
				and volume_test_object(VOLUMES.tv_snapshut, spartan) == false				-- and aren't already inside the temple room
				and volume_test_object(VOLUMES.tv_temple_climb, spartan) == false			-- and aren't in that one pocket (there's this little pocket where players who are climbing up to get to the device are likely to be, and fails the look-at test because look-at doesnt test occlusion. And we just don't want to jar players who are about to reach the puzzle solution with a teleport. I'd rather they saw the door pop into place.)
				)	then
				object_teleport (spartan, FLAGS.fl_temple_catchup);
			end
		end
	end
	Sleep(2);
	volume_teleport_players_not_inside(VOLUMES.tv_snapshut_2, FLAGS.fl_temple_catchup);			-- tv_snapshut_2 == the whole temple interior
																								-- this should cover all players in bowl
end
function round_up_test():void
	for _,spartan in ipairs (players()) do
		if (	volume_test_player_lookat(VOLUMES.tv_snapshut_look, spartan, 21, 66)			-- for players just
			and volume_test_object(VOLUMES.tv_snapshut, spartan) == false						-- inside temple
			and volume_test_object(VOLUMES.tv_temple_climb, spartan) == false
			)	then
			object_teleport (spartan, FLAGS.fl_temple_catchup);
		end
	end   
end
function round_up_musketeers_in_temple():void
	for _, musketeer in pairs( musketeers() ) do
		if volume_test_object (VOLUMES.tv_snapshut_2, musketeer) == false then
			object_teleport(musketeer, FLAGS.fl_temple_catchup);
		end
	end
end
-- // ============= end mousetrap logic =================
function temple_door_open():void
	SleepUntil([| b_zs_buffer_done == true], 5);
	CreateThread(temple_door_fx);
	device_set_power(OBJECTS.dm_temple_door, 1);
	device_set_position(OBJECTS.dm_temple_door, 1);
end
function temple_door_fx():void																-- this has been globalized 7-27-15
	RunClientScript("start_global_rumble_shake_small", 8);									-- this has been globalized 7-27-15
end
function end_bypass_goal_listener():void
	SleepUntil([| b_end_temple_goal == true ], 5);													-- 
	if(IsGoalActive(missionPlateau.goal_Temp_Bypass))then									-- prevents an error with blink_door
		end_temple_objective();						
	end
end
function end_temple_objective():void														-- broken out for blink
	GoalCompleteTask(missionPlateau.goal_Temp_Bypass);
end

function tracking_refresher():void
	SleepUntil (	[|	volume_return_players(VOLUMES.tv_snapshut)[1] ~= nil
					or	b_end_temple_goal == true
					], 1);
	if(b_end_temple_goal == false)then																-- if device hasn't been interacted with
		for _,obj in ipairs(volume_return_players(VOLUMES.tv_snapshut)) do
			train_players_track(obj);
		end
	end
end
function train_players_track(p_player:player)
--	TutorialShow(p_player, "training_ping", 6);
-- === TutorialShowIfNotPerformed: Shows the tutorial unless the player has completed that mechanic.
--		pl - player
--		text - the stringID to show
--		mechanic_id - mechanic enum to check if completed
-- 		max_time - OPTIONAL the number of seconds to show the tutorial string unless stopped by another script or another tutorial overwrites it
--  Example: TutorialShowIfNotPerformed (PLAYERS.player0, "example", TUTORIAL.example, 10) shows the stringID of Example for 10 seconds to player0 
	TutorialShowIfNotPerformed(unit_get_player(p_player), "training_ping", TUTORIAL.Tracking, 6);
--	TutorialShow(unit_get_player(p_player), "training_ping", 6);
-- test:
-- TutorialShowAll("training_ping", 5);
end
function tracking_reminder_loop():void
	repeat
		sleep_s(40);
		if(b_end_temple_goal == false)then
			CreateThread(tracking_refresher);
		end
	until(b_end_temple_goal == true);	-- dc operated
end
--]]

--[[
  ______    ______    ______   __              ________                               ______             __        __  __                   ________                               __     
 /      \  /      \  /      \ |  \            |        \                             /      \           |  \      |  \|  \                 |        \                             |  \    
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$             \$$$$$$$$_______                     |  $$$$$$\  ______  | $$  ____| $$ \$$  ______    ______\$$$$$$$$______   __    __  _______  _| $$_   
| $$ __\$$| $$  | $$| $$__| $$| $$                /  $$/       \       ______       | $$___\$$ /      \ | $$ /      $$|  \ /      \  /      \ | $$  |      \ |  \  |  \|       \|   $$ \  
| $$|    \| $$  | $$| $$    $$| $$               /  $$|  $$$$$$$      |      \       \$$    \ |  $$$$$$\| $$|  $$$$$$$| $$|  $$$$$$\|  $$$$$$\| $$   \$$$$$$\| $$  | $$| $$$$$$$\\$$$$$$  
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              /  $$ | $$             \$$$$$$       _\$$$$$$\| $$  | $$| $$| $$  | $$| $$| $$    $$| $$   \$$| $$  /      $$| $$  | $$| $$  | $$ | $$ __ 
| $$__| $$| $$__/ $$| $$  | $$| $$_____        /  $$  | $$_____                     |  \__| $$| $$__/ $$| $$| $$__| $$| $$| $$$$$$$$| $$      | $$ |  $$$$$$$| $$__/ $$| $$  | $$ | $$|  \
 \$$    $$ \$$    $$| $$  | $$| $$     \      |  $$    \$$     \                     \$$    $$ \$$    $$| $$ \$$    $$| $$ \$$     \| $$      | $$  \$$    $$ \$$    $$| $$  | $$  \$$  $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$      \$$$$$$$                      \$$$$$$   \$$$$$$  \$$  \$$$$$$$ \$$  \$$$$$$$ \$$       \$$   \$$$$$$$  \$$$$$$  \$$   \$$   \$$$$ 

--]]

missionPlateau.goal_SoldierTaunt = 
{
	gotoVolume = VOLUMES.tv_preplaza,
	zoneSet = ZONE_SETS.plateau_temple_advance,
	next = {"goal_Awakening"};
}
function missionPlateau.goal_SoldierTaunt.Start():void
	object_destroy	(OBJECTS.vin_sent_machine_2);
	CreateThread	(soldier_taunt_sequence);
	--	object_destroy	(OBJECTS.w2_plat_collectible_12);		DELETED
	object_destroy	(OBJECTS.w2_plat_skull);
	CreateThread	(flock_crevice);
	--	NARRATIVE CALL
	CreateThread	(plateau_temple_corridor_soldiers);
	CreateThread	(tracking_soldier_awakening);
end
function tracking_soldier_awakening():void							
	object_create("track_soldier_taunt");
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_temple_door)
				or	IsGoalActive(missionPlateau.goal_SoldierTaunt) == false
				], 3);
	object_destroy(OBJECTS.track_soldier_taunt);
	object_create("track_vtols");
	SleepUntil(	[| volume_test_players(VOLUMES.tv_vtol_pad)
				or		(	IsGoalActive(missionPlateau.goal_SoldierTaunt) == false
						and	IsGoalActive(missionPlateau.goal_Awakening) == false
						)
				], 3);
	object_destroy(OBJECTS.track_vtols);
end
function soldier_taunt_sequence():void											-- called one place
	SleepUntil(	[|	device_get_position(OBJECTS.dm_temple_door) >= .45
				or	volume_test_players(VOLUMES.tv_temple_door) == true
				],1
				);
	print("=================================door sequence; lookat a enabled");
	SleepUntil(	[|	volume_test_players_lookat(VOLUMES.tv_look_door_a, 7, 20) 
				or	volume_test_players(VOLUMES.tv_temple_door) == true
				],1
				);
	print("=================================door sequence; lookat a triggered");
	composer_play_show("comp_soldier_taunt");
	CreateThread(close_temple_door);
	CreateThread(evacuate_temple_listener);
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_temple_door) == true	],1);
	print("=================================door sequence; lookat b enabled");
	SleepUntil(	[|	volume_test_players_lookat(VOLUMES.tv_look_door_b, 12, 28) ],1);
	print("=================================door sequence; lookat b triggered");
	b_lookat_b = true;
	CreateThread(end_soldier_taunt_composition);										-- I would have liked to put this on the composition, but I could n't get that to work
end
function close_temple_door():void
	SleepUntil	(	[|	volume_test_players(VOLUMES.tv_temple_hall) == false
				and		volume_test_players(VOLUMES.tv_temple_all) == false
					], 5
				);
	object_create_anew("dm_temple_door");
	device_set_power(OBJECTS.dm_temple_door, 0);
	CreateThread(remove_temple_stuff);
	prepare_to_switch_to_zone_set(ZONE_SETS.plateau_crevice);							-- 9-3-2015
	sleep_s(5);																			-- 9-3-2015
	switch_zone_set(ZONE_SETS.plateau_crevice);
end
function evacuate_temple_listener():void
	SleepUntil(	[|		volume_test_players(VOLUMES.tv_evacuate_temple)
				], 2);
	print("trip");
	volume_teleport_players_not_inside(VOLUMES.tv_vtol_pad, FLAGS.tpf_vtol_pad);		-- should trigger close_temple_door
end
global var_taunt_vtol:number = 0;
function cs_vtol_soldier_1():void
	print("_start CS 1");
	cs_go_to(POINTS.ps_vtol_soldiers.p0_vtol_sol_1);
	object_set_scale(ai_current_actor, 0, 1);
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);	
	var_taunt_vtol = var_taunt_vtol + 1;
	ai_erase(ai_current_actor);
	print("_end CS 1");
end
function cs_vtol_soldier_2():void
	print("_start CS 2");
	cs_go_to(POINTS.ps_vtol_soldiers.p0_vtol_sol_2);
	object_set_scale(ai_current_actor, 0, 1);
	var_taunt_vtol = var_taunt_vtol + 1;
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);	
	ai_erase(ai_current_actor);
	print("_end CS 2");
end

function cs_vtol_soldier_vtol():void
	cs_fly_to(POINTS.ps_vtol_soldiers.p1);
	cs_shoot_at(true, POINTS.ps_vtol_soldiers.shoota);
	cs_fly_to_and_face(POINTS.ps_vtol_soldiers.p2, POINTS.ps_vtol_soldiers.look);
	cs_shoot_at(true, POINTS.ps_vtol_soldiers.shoot5);
	cs_fly_to_and_face(POINTS.ps_vtol_soldiers.p4, POINTS.ps_vtol_soldiers.look);
	cs_shoot_at(true, POINTS.ps_vtol_soldiers.shoot7);
	cs_fly_to_and_face(POINTS.ps_vtol_soldiers.p6, POINTS.ps_vtol_soldiers.look);
end

function end_soldier_taunt_composition():void
	sleep_s(0.63);
	CreateEffectGroup (EFFECTS.fx_5);
	CreateThread(kill_soldier_vtol_fx);
	print("_about to start CS");
	cs_run_command_script(AI.vin_soldier_taunt.soldier_sp, "cs_vtol_soldier_1");
	print("_about to start CS 1");
	cs_run_command_script(AI.vin_soldier_taunt.soldier_sp_2, "cs_vtol_soldier_2");
	print("_about to start CS 2");
	sleep_s(0.5);
	SleepUntil ([|	var_taunt_vtol >= 1], 5);
	sleep_s(random_range(0, 0.4));
	if(ai_living_count(AI.sq_soldier_vtol) <= 0)then
		ai_place(AI.sq_soldier_vtol);
	end
end
function kill_soldier_vtol_fx():void
	SleepUntil (	[|	ai_living_count(AI.vin_soldier_taunt) <= 0
					or	ai_living_count(AI.sq_soldier_vtol) >= 1
					], 5);
	StopEffectGroup(EFFECTS.fx_5);
end
--[[
  ______    ______    ______   __               ______                        ______                           __                            __                     
 /      \  /      \  /      \ |  \             /      \                      /      \                         |  \                          |  \                    
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |  $$$$$$\                    |  $$$$$$\ __   __   __   ______  | $$   __   ______   _______   \$$ _______    ______  
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$__/ $$       ______       | $$__| $$|  \ |  \ |  \ |      \ | $$  /  \ /      \ |       \ |  \|       \  /      \ 
| $$|    \| $$  | $$| $$    $$| $$             >$$    $$      |      \      | $$    $$| $$ | $$ | $$  \$$$$$$\| $$_/  $$|  $$$$$$\| $$$$$$$\| $$| $$$$$$$\|  $$$$$$\
| $$ \$$$$| $$  | $$| $$$$$$$$| $$            |  $$$$$$        \$$$$$$      | $$$$$$$$| $$ | $$ | $$ /      $$| $$   $$ | $$    $$| $$  | $$| $$| $$  | $$| $$  | $$
| $$__| $$| $$__/ $$| $$  | $$| $$_____       | $$__/ $$                    | $$  | $$| $$_/ $$_/ $$|  $$$$$$$| $$$$$$\ | $$$$$$$$| $$  | $$| $$| $$  | $$| $$__| $$
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$                    | $$  | $$ \$$   $$   $$ \$$    $$| $$  \$$\ \$$     \| $$  | $$| $$| $$  | $$ \$$    $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$                      \$$   \$$  \$$$$$\$$$$   \$$$$$$$ \$$   \$$  \$$$$$$$ \$$   \$$ \$$ \$$   \$$ _\$$$$$$$
                                                                                                                                                          |  \__| $$
                                                                                                                                                           \$$    $$
                                                                                                                                                            \$$$$$$ 
--]]
missionPlateau.goal_Awakening = 
{
	gotoVolume = VOLUMES.tv_plaza,
	zoneSet = ZONE_SETS.plateau_crevice,
	next = {"goal_SentryBoss"};
}

function missionPlateau.goal_Awakening.Start():void
	game_save_no_timeout();

	--	NARRATIVE CALL
	CreateThread(plateau_boss_load);

	CreateThread(awakening);
	CreateThread(kraken_objective_event);
--	object_create("dm_obelisk_entry_door");																						-- door to soldier room
	kill_volume_disable(VOLUMES.kill_tv_sentry_ship);
	kill_volume_disable(VOLUMES.kill_core_room);
	kill_volume_disable(VOLUMES.kill_back_right_claw);
	kill_volume_disable(VOLUMES.kill_front_claw);
	kill_volume_disable(VOLUMES.kill_back_left_claw);
end
function awakening():void
-- sequence leading up to comp
	SleepUntil([| volume_test_players(VOLUMES.tv_preplaza)],2);
	CreateThread(fire_off_end_sentry_composition);											-- start ss comp
	CreateThread(start_vtol_pilot_training_listeners);
--	CreateThread(f_chapter_title, TITLES.ch_bb_2);									-- black bar title
	sleep_s(6);
--	CreateThread(fr_turret_create, AI.sq_v2_fr_2, ai_vehicle_get_from_spawn_point(AI.sq_v2_fr_2.a));
	sleep_s(3);
--	CreateThread(fr_turret_create, AI.sq_v2_fr_3, ai_vehicle_get_from_spawn_point(AI.sq_v2_fr_3.a));
	sleep_s(1.2);
	CreateThread	(temp_slipspace_player_vtols);
	sleep_s(2);
--	CreateThread(fr_turret_lifecycle, AI.sq_v2_fr_2, ai_vehicle_get_from_spawn_point(AI.sq_v2_fr_2.a));
	sleep_s(4);
--	CreateThread(fr_turret_lifecycle, AI.sq_v2_fr_3, ai_vehicle_get_from_spawn_point(AI.sq_v2_fr_3.a));
end
function fr_turret_create(brain:ai, body:object):void
	if(brain == AI.sq_v2_fr_2)then
		CreateEffectGroup (EFFECTS.fx_2);
	else
		CreateEffectGroup (EFFECTS.fx_3);
	end
	sleep_s(5.9);
	ai_place(brain);
	Sleep(2);
	CreateThread(fr_turret_invulnerability_toggle, brain, body, true);
		if(brain == AI.sq_v2_fr_2)then
		StopEffectGroup (EFFECTS.fx_2);
	else
		StopEffectGroup (EFFECTS.fx_3);
	end
end
function fr_turret_lifecycle(brain:ai, body:object):void
	CreateThread(fr_turret_invulnerability_toggle, brain, body, true);
	repeat
		sleep_s(6);
		if(random_range(1,3) == 1)then
			CreateThread(fr_turret_invulnerability_toggle, brain, body, false);
		end
		if(ai_living_count(brain) <= 0)then
			CreateThread (fr_turret_create, brain, body);
		end
	until	(	volume_test_players(VOLUMES.tv_hangar_floor) 
			or	b_engine_breach == true
			);
	CreateThread(fr_turret_invulnerability_toggle, brain, body, false);
end
function fr_turret_invulnerability_toggle(brain:ai, body:object, bool:boolean):void
	ai_cannot_die(brain, bool);
	object_cannot_die(body, bool);
end

function temp_slipspace_player_vtols():void
	CreateEffectGroup (EFFECTS.fx_4);
	CreateEffectGroup (EFFECTS.fx_5);
    sleep_s (6);
	SleepUntil([|	volume_test_players(VOLUMES.tv_vtol_spawn_zone)	== false], 3);
	object_create_folder ("sentry_vehicles"); 
	sleep_s (.5);
	object_create_folder ("sentry_vehicles_backup"); 
	sleep_s(1);
	StopEffectGroup(EFFECTS.fx_4);
	StopEffectGroup(EFFECTS.fx_5);
		--	NARRATIVE
		b_vtols_are_present = true;
	CreateThread(vtol_spawner);
end
function start_vtol_pilot_training_listeners():void
	for _, playa in ipairs (players()) do
		train_players_vtol(playa)
	end
end
function train_players_vtol(p_player:player)
	SleepUntil([| unit_in_vehicle_type(p_player, 40) ], 5);
	sleep_s(1);
--	TutorialShow(unit_get_player(p_player), "training_phaeton_ascend", 4);
	TutorialShowIfNotPerformed(unit_get_player(p_player), "training_phaeton_ascend", TUTORIAL.VTOLAscend, 4);
	sleep_s(4.2);
--	TutorialShow(unit_get_player(p_player), "training_phaeton_descend", 4);
	TutorialShowIfNotPerformed(unit_get_player(p_player), "training_phaeton_descend", TUTORIAL.VTOLDescend, 4);
	sleep_s(4.2);
--	TutorialShow(unit_get_player(p_player), "training_phaeton_boost", 4);
	TutorialShowIfNotPerformed(unit_get_player(p_player), "training_phaeton_boost", TUTORIAL.VTOLEvade, 4);
	sleep_s(4.2);
--	TutorialShow(unit_get_player(p_player), "training_phaeton_weaponchange", 4);
	TutorialShowIfNotPerformed(unit_get_player(p_player), "training_phaeton_weaponchange", TUTORIAL.VTOLSwitchWeapons, 4);
-- test:
-- TutorialShowAll("training_phaeton_ascend", 4);
-- TutorialShowAll("training_phaeton_descend", 4);
-- TutorialShowAll("training_ping", 5);
end
function kraken_objective_event():void
	SleepUntil([|players_in_vehicle_fraction() == 1], 5);
	sleep_s(3);
	CreateThread(audio_newobjective_beep);		--play new objective sfx
	ObjectiveShow (TITLES.ch_destroy_kraken);
end
function fire_off_end_sentry_composition():void
	if not (sentry_show == nil)then
		composer_stop_show(sentry_show);
		sentry_show = nil;
	end
	CreateThread(audio_plateau_sentrybattle_start);
	b_liftoff_idle = true;
	Sleep(2);
	sentry_show = composer_play_show("comp_sentryshipend");
	Sleep(2);
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "front_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "left_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "right_leg_shield"));
end
function scatter_crevice_flock():void
	RunClientScript("scatter_crevice_flock_client");
end
function put_sentry_in_place():void
	b_sentry_end_test = true;
	CreateThread(flock_crevice);
	kill_volume_disable(VOLUMES.kill_tv_sentry_ship);
	Sleep(10);
	CreateThread(fire_off_end_sentry_composition);
end
--[[
  ______    ______    ______   __               ______                        ______   ________  __    __  ________  _______  __      __ 
 /      \  /      \  /      \ |  \             /      \                      /      \ |        \|  \  |  \|        \|       \|  \    /  \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |  $$$$$$\                    |  $$$$$$\| $$$$$$$$| $$\ | $$ \$$$$$$$$| $$$$$$$\\$$\  /  $$
| $$ __\$$| $$  | $$| $$__| $$| $$            | $$__/ $$       ______       | $$___\$$| $$__    | $$$\| $$   | $$   | $$__| $$ \$$\/  $$ 
| $$|    \| $$  | $$| $$    $$| $$             \$$    $$      |      \       \$$    \ | $$  \   | $$$$\ $$   | $$   | $$    $$  \$$  $$  
| $$ \$$$$| $$  | $$| $$$$$$$$| $$             _\$$$$$$$       \$$$$$$       _\$$$$$$\| $$$$$   | $$\$$ $$   | $$   | $$$$$$$\   \$$$$   
| $$__| $$| $$__/ $$| $$  | $$| $$_____       |  \__/ $$                    |  \__| $$| $$_____ | $$ \$$$$   | $$   | $$  | $$   | $$    
 \$$    $$ \$$    $$| $$  | $$| $$     \       \$$    $$                     \$$    $$| $$     \| $$  \$$$   | $$   | $$  | $$   | $$    
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$        \$$$$$$                       \$$$$$$  \$$$$$$$$ \$$   \$$    \$$    \$$   \$$    \$$   
--]]
missionPlateau.goal_SentryBoss = 
{
--	description = "DESTROY THE KRAKEN",
	zoneSet = ZONE_SETS.plateau_crevice,
	next = {"goal_Return"};
}
function missionPlateau.goal_SentryBoss.Start():void
	game_save_no_timeout();
	CreateThread(f_sentry_spawn_hack); --delete if possible. accept v2 changes -- 1 month later: I don't remember what I meant by this - tjp
	CreateThread(end_ss_goal);
	CreateThread(kraken_muskboxen);
end
function tracking_sentryboss():void																	-- currently called from stasis. Would be better to cue off appropriate VO.
	object_create("track_core");
	SleepUntil(	[|	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.04
				or	IsGoalActive(missionPlateau.goal_SentryBoss) == false
				], 3);
	object_destroy(OBJECTS.track_core);
end
function kraken_muskboxen():void
	CreateThread(airbox, VOLUMES.tv_airmusk_1, FLAGS.mxf_krak_1a, 7, FLAGS.mxf_krak_1b, 7, FLAGS.mxf_krak_1c, 7, missionPlateau.goal_SentryBoss);
	CreateThread(airbox, VOLUMES.tv_airmusk_2, FLAGS.mxf_krak_2a, 7, FLAGS.mxf_krak_2b, 7, FLAGS.mxf_krak_2c, 7, missionPlateau.goal_SentryBoss);
	CreateThread(airbox, VOLUMES.tv_airmusk_3, FLAGS.mxf_krak_3a, 7, FLAGS.mxf_krak_3b, 7, FLAGS.mxf_krak_3c, 7, missionPlateau.goal_SentryBoss);
end
		
function vtol_spawner()
--use objectcreatefolder?
	local t_vtols:table =
		{
			"vtol1",
			"vtol2",
			"vtol1b",
			"vtol2b",
		};
	repeat
		Sleep(seconds_to_frames(2));
		for _,name  in ipairs(t_vtols) do
			local v: object = ObjectFromName(name);
			if	v 
				and object_get_health (v) > 0
--				and volume_test_object(VOLUMES.tv_vtol_spawn_zone,v)							-- removed for april 15 UR. Might not need at all?
				then
					Sleep(1);
			else
				print("========== try to spawn =============");
				if  vtolAvailableForRespawn(ObjectFromName(name)) then
					object_create_anew(name);
					sleep_s(2);
				end
			end
		end
	until(	b_ship_destroyed == true);
end
--check to see if a VTOL is available to be created (or created anew)
function vtolAvailableForRespawn (vtol:object):boolean
	if not vtol then
		return true;
	end
	if vtol_is_occupied (vtol) then
		return false;
	end
	if object_get_health (vtol) == 0 then
		return true;
	end
	if volume_test_object(VOLUMES.tv_vtol_pad, vtol) then
		--print (vtol, " is in tv_vtol_pad");
		return false;
	end
	if		volume_test_object(VOLUMES.tv_beach_head, vtol) 
		or volume_test_object(VOLUMES.tv_hangar_floor, vtol)
		then
		--print (vtol, " is on the deck or in the hangar");
		return false;
	end
	print (vtol, "is available and returning true");
	return true;
end
--check to see if a musketeer is inside a VTOL
function vtol_is_occupied(vtol:object):boolean
	if vtol ~= nil then
		for _, spartan in ipairs (spartans()) do
			if(unit_get_vehicle(spartan) == vtol)then
				print(spartan, " in vtol", vtol);
				return(true);
			end
		end
	end
	return(false);
end
function faux_start_return_goal():void
	CreateThread(tractor_beam_enable);
	CreateThread(gutter_teleport);
end
function end_ss_goal():void
	SleepUntil( [| b_ss_goal_complete] );
	if(IsServer()) then
		GoalCompleteTask(missionPlateau.goal_SentryBoss);
		print("------------ ending ss boss goal -------------");
	end
end
function skip_boss():void
	b_ship_destroyed = true;
	b_ss_goal_complete	= true;
end
function missionPlateau.goal_SentryBoss.End():void
	print("boss battle complete");
--    object_destroy_folder ("sentry_props");
end
--[[
  ______    ______    ______   __                __    ______                       _______   ________  ________  __    __  _______   __    __ 
 /      \  /      \  /      \ |  \             _/  \  /      \                     |       \ |        \|        \|  \  |  \|       \ |  \  |  \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |   $$ |  $$$$$$\                    | $$$$$$$\| $$$$$$$$ \$$$$$$$$| $$  | $$| $$$$$$$\| $$\ | $$
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$$$ | $$$\| $$       ______       | $$__| $$| $$__       | $$   | $$  | $$| $$__| $$| $$$\| $$
| $$|    \| $$  | $$| $$    $$| $$              | $$ | $$$$\ $$      |      \      | $$    $$| $$  \      | $$   | $$  | $$| $$    $$| $$$$\ $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              | $$ | $$\$$\$$       \$$$$$$      | $$$$$$$\| $$$$$      | $$   | $$  | $$| $$$$$$$\| $$\$$ $$
| $$__| $$| $$__/ $$| $$  | $$| $$_____        _| $$_| $$_\$$$$                    | $$  | $$| $$_____    | $$   | $$__/ $$| $$  | $$| $$ \$$$$
 \$$    $$ \$$    $$| $$  | $$| $$     \      |   $$ \\$$  \$$$                    | $$  | $$| $$     \   | $$    \$$    $$| $$  | $$| $$  \$$$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$ \$$$$$$                      \$$   \$$ \$$$$$$$$    \$$     \$$$$$$  \$$   \$$ \$$   \$$
--]]

missionPlateau.goal_Return = 
{
	zoneSet = ZONE_SETS.plateau_sentry,
	next = {"goal_Map"};
}

function missionPlateau.goal_Return.Start():void
	print(" ");
	CreateThread(goal_return_ender);
	CreateThread(tracking_return);
	CreateThread(jump_hint_manager);
	CreateThread(return_muskbox);
end
function jump_hint_manager():void
	ai_disable_jump_hint(HINTS.jump_door_1);
	ai_disable_jump_hint(HINTS.jump_door_2);
	CreateThread(jump_door_1);
	CreateThread(jump_door_2);
end
function jump_door_1():void
	repeat
		if(device_get_position( OBJECTS.dm_obelisk_entry_door) > .50)then
			ai_enable_jump_hint(HINTS.jump_door_1)
		else
			ai_disable_jump_hint(HINTS.jump_door_1);
		end
		sleep_s(1);
	until(false);
end
function jump_door_2():void
	repeat
		if(device_get_position( OBJECTS.dm_obelisk_entry_door_2) > .50)then
			ai_enable_jump_hint(HINTS.jump_door_2)
		else
			ai_disable_jump_hint(HINTS.jump_door_2);
		end
		sleep_s(1);
	until(false);
end
function tracking_return():void
	object_create("track_soldier_room");
	SleepUntil(	[|	device_get_position(OBJECTS.dm_obelisk_entry_door) > 0
				], 3);
	object_destroy(OBJECTS.track_soldier_room);
end
function missionPlateau.goal_Return.End():void
	print(" ");
	--volume_teleport_players_inside(VOLUMES.tv_vtol, FLAGS.tpf_vtol);
end
function goal_return_ender():void
	SleepUntil	(	[|	all_players_in_goal_return_volume()
					and all_players_out_of_vehicles()
					], 5
				);
	print(" ----====== ENDING RETURN ======----");
--	CreateThread(kill_disobedient_musketeers);
	GoalCompleteTask(missionPlateau.goal_Return);
end

function keyhole_shield_listener():void
--	SleepUntil([| object_valid("keyhole_shield_1") ], 5);
--	object_cannot_take_damage(OBJECTS.keyhole_shield_1);
	-- NARRATIVE CALL 
--	CreateThread(plateau_sentrybattle_shield_lookat);
	SleepUntil([|	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05], 30);			-- 8-31-15
--	SleepUntil([|	b_ship_destroyed == true ], 30);																		-- 8-31-15
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tv_looky_aperture, 55, 15) ], 5);
	switch_zone_set(ZONE_SETS.plateau_sentry);
	sleep_s(2);
	RunClientScript("deres_shield_clients");
--	print("animate shield off");
	sleep_s(2.6);
	object_destroy(OBJECTS.keyhole_shield_1);
	CreateThread(audio_iris_open);
end

function look_at_test_aperture():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_looky_aperture, 55, 15) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end

function all_players_in_goal_return_volume():boolean														-- I suck.

	if(volume_test_players_all(VOLUMES.tv_goal_return))then
		return(true);
	else
		return(false);
	end
end
function all_players_out_of_vehicles():boolean
																											-- here's the better version
	local var_players:object_list = players();
	local player_count:number = 0;
	
	for _,obj in ipairs(var_players) do
		if(unit_get_vehicle(obj) == nil)then
			player_count = player_count + 1;
			print(" "..player_count);
		end
	end
	if(player_count == list_count(var_players))then
		return(true);
	else
		return(false);
	end
end
function tractor_beam_enable():void
	CreateThread(dock_dissolver);
	CreateThread(dock_musketeer_ejector);
end

function test_deres():void
	CreateThread(put_sentry_in_place);
	CreateThread(dock_dissolver);
	CreateThread(dock_musketeer_ejector);
end

function dock_dissolver():void
	local g:object_list=volume_return_objects_by_type(VOLUMES.tv_dock_dissolver, 2);	
	print("dissolver");
	repeat
		g=volume_return_objects_by_type(VOLUMES.tv_dock_dissolver, 2);
		-- Applies dissolve to vehicles that pass through the field.]
		for _,obj in pairs(g) do
			if(vehicle_driver(obj) == nil)then
				unit_set_enterable_by_player(obj, false);
				sleep_s(1);
				if(objects_distance_to_object(players(), obj) >= 2)then													-- hack around bug that shoots player across map on deres
					object_set_physics(obj, false);
					object_set_gravity(obj, .1);
					object_dissolve_from_marker( obj, "phase_out", "target_hull");
					print("attempted to de-res vehicle ");
					sleep_s(3);																							-- haaaaack
					object_destroy(obj);
				end
			end
		end
		sleep_s(.5);
	until 	n_obelisk_objcon >= 10;
end

function dock_ejector_0():void
	SleepUntil	([| volume_test_object(VOLUMES.tv_dock_ejector, player_get_unit(PLAYERS.player0))], 1);
	unit_exit_vehicle(player_get_unit(PLAYERS.player0), 0);																				-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	print("--- ejection 0 ---");
end
function dock_ejector_1():void
	SleepUntil	([| volume_test_object(VOLUMES.tv_dock_ejector, player_get_unit(PLAYERS.player1))], 1);
	unit_exit_vehicle(player_get_unit(PLAYERS.player1), 0);																				-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	print("--- ejection 1 ---");
end
function dock_ejector_2():void
	SleepUntil	([| volume_test_object(VOLUMES.tv_dock_ejector, player_get_unit(PLAYERS.player2))], 1);
	unit_exit_vehicle(player_get_unit(PLAYERS.player2), 0);																				-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	print("--- ejection 2 ---");
end
function dock_ejector_3():void
	SleepUntil	([| volume_test_object(VOLUMES.tv_dock_ejector, player_get_unit(PLAYERS.player3))], 1);
	unit_exit_vehicle(player_get_unit(PLAYERS.player3), 0);																				-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	print("--- ejection 3 ---");
end
function dock_musketeer_ejector():void
	if( IsPlayer(SPARTANS.locke) == false) then
		print("Locke attempting to exit vtol - if Locke isn't a musketeer, this is a bug.");
		dock_eject_musketeer_listener(SPARTANS.locke);
	end
	if( IsPlayer(SPARTANS.vale) == false) then
		print("Vale attempting to exit vtol - if Vale isn't a musketeer, this is a bug.");
		dock_eject_musketeer_listener(SPARTANS.vale);
	end
	if( IsPlayer(SPARTANS.thorne) == false) then
		print("Thuck attempting to exit vtol - if Thuck isn't a musketeer, this is a bug.");
		dock_eject_musketeer_listener(SPARTANS.thorne);
	end
	if( IsPlayer(SPARTANS.tanaka) == false) then
		print("Tankaka attempting to exit vtol - if Tankaka isn't a musketeer, this is a bug.");
		dock_eject_musketeer_listener(SPARTANS.tanaka);
	end
end
function dock_eject_musketeer_listener(spartan:ai):void
	SleepUntil	([| volume_test_object(VOLUMES.tv_dock_ejector, spartan)], 1);
	print("musketeer GET OUT OF THE VTOL MUSKETEER");
	print("musketeer GET OUT OF THE VTOL MUSKETEER");
	print("musketeer GET OUT OF THE VTOL MUSKETEER");
	print("musketeer GET OUT OF THE VTOL MUSKETEER");
	if(unit_get_vehicle(spartan)~=nil)then
		unit_exit_vehicle(spartan, 1);																										-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	end
	sleep_s(1);
	if(unit_get_vehicle(spartan)~=nil)then
		unit_exit_vehicle(spartan, 1);																										-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	end
	sleep_s(1);
	if(unit_get_vehicle(spartan)~=nil)then
		unit_exit_vehicle(spartan, 1);																										-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	end
	print("--- ejection 0 ---");
end

function deres_vehicle_sequence(spartan:object):void
	local veh = unit_get_vehicle(spartan);
	object_dissolve_from_marker( veh, "phase_out", "target_hull");
	sleep_s(0.9);
	object_cannot_take_damage(spartan);
	unit_exit_vehicle(spartan, 1);																										-- 0 = normal airborne exit, 1 = ejection, 2 = airborn +death, 3 = exit to ground)
	sleep_s(0.1);
	object_set_gravity(spartan, .3, true);
	player_control_scale_all_input(	1,	.1);
	sleep_s(1.1);
	object_destroy(veh);
	object_can_take_damage(spartan);
	object_set_gravity(spartan, 1, true);
end
function gutter_teleport():void
	local a:object_list = nil;
	print("");
	--  //////
	repeat
	SleepUntil (	[|	volume_return_objects_by_type(VOLUMES.tv_gutter, 1)[1] ~= nil
					], 5);
	    a=volume_return_objects_by_type(VOLUMES.tv_gutter,	1);
		for _,obj in ipairs(a) do
			object_teleport(obj, FLAGS.fl_keyhole_tp_spot);
			print("TELEP'RD");
		end
		Sleep(30);
	until(n_obelisk_objcon >= 100);
end
function return_muskbox():void
		SleepUntil( [| volume_test_players(VOLUMES.tv_dock_ejector)
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_keyhole_tp_spot, 1);
			end
		SleepUntil( [| volume_test_players(VOLUMES.tv_muskbox_end)
					],3);

		print("EXITEXITEXITEXITEXITEXIT");
	MusketeerUtil_SetDestination_Clear_All()
	sleep_s(1);
	MusketeerUtil_SetDestination_Clear_All()
end


--[[-- ======================================================
  ______    ______    ______   __                __      __                        __       __   ______   _______  
 /      \  /      \  /      \ |  \             _/  \   _/  \                      |  \     /  \ /      \ |       \ 
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |   $$  |   $$                      | $$\   /  $$|  $$$$$$\| $$$$$$$\
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$$$   \$$$$         ______       | $$$\ /  $$$| $$__| $$| $$__/ $$
| $$|    \| $$  | $$| $$    $$| $$              | $$    | $$        |      \      | $$$$\  $$$$| $$    $$| $$    $$
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              | $$    | $$         \$$$$$$      | $$\$$ $$ $$| $$$$$$$$| $$$$$$$ 
| $$__| $$| $$__/ $$| $$  | $$| $$_____        _| $$_  _| $$_                     | $$ \$$$| $$| $$  | $$| $$      
 \$$    $$ \$$    $$| $$  | $$| $$     \      |   $$ \|   $$ \                    | $$  \$ | $$| $$  | $$| $$      
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$ \$$$$$$                     \$$      \$$ \$$   \$$ \$$      
                         
--]]-- ======================================================                                         


missionPlateau.goal_Map = 
{
	zoneSet = ZONE_SETS.plateau_sentry,
	next = {"goal_Artifact"};
}
function missionPlateau.goal_Map.Start():void
		--	NARRATIVE CALL
			CreateThread(plateau_soldier_load);
	object_create("soldier_room_map");
	CreateThread(init_obelisk);
	CreateThread(end_this_map_goal);
	game_save_no_timeout();
	object_set_function_variable(OBJECTS.soldier_room_map, "disp", 1, 3);						-- disappear (must animate off in order to animate back on, due to how it's set up)
	CreateThread(turn_on_map);
	PauseGame();
end
function init_obelisk():void
	ObjectiveShow (TITLES.ch_retrieve_constructor);
	SleepUntil ( [| volume_test_players ( VOLUMES.tv_plat_ob_init ) ], 1 );
		CreateThread( f_plat_ob_entry_door );
		object_create_folder( "cr_soldier" );
--		object_create_folder( "dms_ob_cover" );													-- tabs in wall
end
function turn_on_map():void
	SleepUntil([|volume_test_players(VOLUMES.tv_objcon_ob_20)], 2);
	object_set_function_variable(OBJECTS.soldier_room_map, "disp", 0, 3);						-- animate in
	sleep_s(2);
	CreateThread(audio_soldierroom_hologram_activate);
	CreateEffectGroup(EFFECTS.fx_player_location_lf);
	CreateEffectGroup(EFFECTS.fx_player_location_lf03);
	CreateEffectGroup(EFFECTS.fx_holo_red_core_lf);
end
function end_this_map_goal():void																-- ends this goal and moves to RETRIEVE THE CONSTRUCTOR goal sequence
		--	NARRATIVE CALL
		plateau_obelisk_map();																	-- Added condition being the end of the VO lines		guillaume 12/18/14
	volume_teleport_players_not_inside(VOLUMES.tv_soldier_all, FLAGS.fl_soldier_gather);		-- 9-4-2015: prevents players from behind stranded outside closed door
	CreateThread(close_soldier_door);
	print("Map end condition hit");
	sleep_s(1.5);	
	GoalCompleteTask(missionPlateau.goal_Map);
	game_save_no_timeout();
end
function close_soldier_door():void
	SleepUntil	(	[|	volume_test_players(VOLUMES.tv_goal_return) == false
					], 5
				)
	device_set_position(OBJECTS.dm_obelisk_entry_door, 0);


end

--[[-- ======================================================   
  ______    ______    ______   __                __     ______                        ______   _______  ________  ______  ________   ______    ______  ________ 
 /      \  /      \  /      \ |  \             _/  \   /      \                      /      \ |       \|        \|      \|        \ /      \  /      \|        \
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |   $$  |  $$$$$$\                    |  $$$$$$\| $$$$$$$\\$$$$$$$$ \$$$$$$| $$$$$$$$|  $$$$$$\|  $$$$$$\\$$$$$$$$
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$$$   \$$__| $$       ______       | $$__| $$| $$__| $$  | $$     | $$  | $$__    | $$__| $$| $$   \$$  | $$   
| $$|    \| $$  | $$| $$    $$| $$              | $$   /      $$      |      \      | $$    $$| $$    $$  | $$     | $$  | $$  \   | $$    $$| $$        | $$   
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              | $$  |  $$$$$$        \$$$$$$      | $$$$$$$$| $$$$$$$\  | $$     | $$  | $$$$$   | $$$$$$$$| $$   __   | $$   
| $$__| $$| $$__/ $$| $$  | $$| $$_____        _| $$_ | $$_____                     | $$  | $$| $$  | $$  | $$    _| $$_ | $$      | $$  | $$| $$__/  \  | $$   
 \$$    $$ \$$    $$| $$  | $$| $$     \      |   $$ \| $$     \                    | $$  | $$| $$  | $$  | $$   |   $$ \| $$      | $$  | $$ \$$    $$  | $$   
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$ \$$$$$$$$                     \$$   \$$ \$$   \$$   \$$    \$$$$$$ \$$       \$$   \$$  \$$$$$$    \$$   
--]]-- ======================================================                                                                                                                                                                  
missionPlateau.goal_Artifact = 
{
--	description = "RETRIEVE THE CONSTRUCTOR",
	zoneSet = ZONE_SETS.plateau_sentry,
	next = {"goal_Soldiers"};
}
function missionPlateau.goal_Artifact.Start():void
--	object_create("cr_punch_box");
	CreateThread(audio_newobjective_beep);															--play new objective sfx
	g_ics_player_0 = PLAYERS.player0;
	g_ics_player_1 = PLAYERS.player1;
	g_ics_player_2 = PLAYERS.player2;
	g_ics_player_3 = PLAYERS.player3;
	object_create_anew("dc_punchbox");
	Sleep(3);
	device_set_power(OBJECTS.dc_punchbox, 1);
	Sleep(3);
	CreateThread(artifact_retrieved_listener);
	CreateThread(objective_text_goal_Soldier_3);
end
function objective_text_goal_Soldier_3():void														-- Called from end of narrative script. It'd be good to find a better way to do this. UPDATE NEW SCRIPT
	SleepUntil([| ai_living_count( AI.sg_obelisk_all ) == 0], 1);									--	ADDED to replace the call of the objective text from the Narrative script - Temp.
	sleep_s(2);
	ObjectiveShow (TITLES.ch_retrieve_constructor);
	CreateThread(tracking_artifact);
	game_save_no_timeout();
end
function tracking_artifact():void
	object_create("track_punchbox");
	SleepUntil(	[|	device_get_power(OBJECTS.dc_punchbox) == 0
				or	IsGoalActive(missionPlateau.goal_Artifact) == false
				], 3);
	object_destroy(OBJECTS.track_punchbox);
end

function artifact_retrieved_listener():void
	SleepUntil([| device_get_power(OBJECTS.dc_punchbox) == 0], 2);
	Sleep(50);
	ai_place_in_limbo(AI.sq_fore_artifact_001);
	object_set_function_variable(OBJECTS.soldier_room_map, "disp", 1, 3);						-- disappear (must animate off in order to animate back on, due to how it's set up)
	Sleep(5);
	KillEffectGroup(EFFECTS.fx_player_location_lf);
	KillEffectGroup(EFFECTS.fx_player_location_lf03);
	KillEffectGroup(EFFECTS.fx_glow_inside_core);
	KillEffectGroup(EFFECTS.fx_energy_01);
	KillEffectGroup(EFFECTS.fx_energy_02);
	KillEffectGroup(EFFECTS.fx_red_lg_01);
	KillEffectGroup(EFFECTS.fx_red_lg_02);
	KillEffectGroup(EFFECTS.fx_holo_red_core_lf);
	n_obelisk_objcon = 100;
	sleep_s(7);
	GoalCompleteTask(missionPlateau.goal_Artifact);
end
function f_dc_constructor_device(device:object, activator:object)
	composer_play_show("soldierroom_constructor_ics_0", { ics_player = activator});
	--	NARRATIVE CALL
		CreateThread(plateau_obelisk_constructor, activator);
	device_set_power(device, 0);
end
function missionPlateau.goal_Artifact.End():void
--	CreateThread(audio_plateau_pickedupartifact);
end
--[[-- ======================================================            
  ______                       __          __     ______      _______                        ______             __        __  __                     
 /      \                     |  \       _/  \   /      \    |       \                      /      \           |  \      |  \|  \                    
|  $$$$$$\  ______    ______  | $$      |   $$  |  $$$$$$\   | $$$$$$$                     |  $$$$$$\  ______  | $$  ____| $$ \$$  ______    ______  
| $$ __\$$ /      \  |      \ | $$       \$$$$   \$$__| $$   | $$____         ______       | $$___\$$ /      \ | $$ /      $$|  \ /      \  /      \ 
| $$|    \|  $$$$$$\  \$$$$$$\| $$        | $$   /      $$   | $$    \       |      \       \$$    \ |  $$$$$$\| $$|  $$$$$$$| $$|  $$$$$$\|  $$$$$$\
| $$ \$$$$| $$  | $$ /      $$| $$        | $$  |  $$$$$$     \$$$$$$$\       \$$$$$$       _\$$$$$$\| $$  | $$| $$| $$  | $$| $$| $$    $$| $$   \$$
| $$__| $$| $$__/ $$|  $$$$$$$| $$       _| $$_ | $$_____  __|  \__| $$                    |  \__| $$| $$__/ $$| $$| $$__| $$| $$| $$$$$$$$| $$      
 \$$    $$ \$$    $$ \$$    $$| $$      |   $$ \| $$     \|  \\$$    $$                     \$$    $$ \$$    $$| $$ \$$    $$| $$ \$$     \| $$      
  \$$$$$$   \$$$$$$   \$$$$$$$ \$$       \$$$$$$ \$$$$$$$$ \$$ \$$$$$$                       \$$$$$$   \$$$$$$  \$$  \$$$$$$$ \$$  \$$$$$$$ \$$      

--]]-- ======================================================            

missionPlateau.goal_Soldiers = 
{
--	description = "Defeat the Promethean Defenses",
	zoneSet = ZONE_SETS.plateau_sentry,
	next = {"goal_Exit"};
}
function missionPlateau.goal_Soldiers.Start():void
	CreateThread(start_obelisk_combat);
	CreateThread(end_this_soldier_goal);
	RunClientScript("fx_kraken_vista_smoke");		
end
function end_this_soldier_goal():void
	sleep_s(5);
	SleepUntil	([| ai_living_count	(AI.sg_obelisk_all) < 1 ], 5);
	print("soldier 2 end condition hit");
	CreateThread(audio_plateau_soldierroom_end);		--soldier room outro music
	sleep_s(7);
	game_save_no_timeout();
	LoomNextCampaignMission();
	GoalCompleteTask(missionPlateau.goal_Soldiers);
end

--[[-- ===============================================
  ______    ______    ______   __                __    ______                       ________            __    __     
 /      \  /      \  /      \ |  \             _/  \  /      \                     |        \          |  \  |  \    
|  $$$$$$\|  $$$$$$\|  $$$$$$\| $$            |   $$ |  $$$$$$\                    | $$$$$$$$ __    __  \$$ _| $$_   
| $$ __\$$| $$  | $$| $$__| $$| $$             \$$$$  \$$__| $$       ______       | $$__    |  \  /  \|  \|   $$ \  
| $$|    \| $$  | $$| $$    $$| $$              | $$   |     $$      |      \      | $$  \    \$$\/  $$| $$ \$$$$$$  
| $$ \$$$$| $$  | $$| $$$$$$$$| $$              | $$  __\$$$$$\       \$$$$$$      | $$$$$     >$$  $$ | $$  | $$ __ 
| $$__| $$| $$__/ $$| $$  | $$| $$_____        _| $$_|  \__| $$                    | $$_____  /  $$$$\ | $$  | $$|  \
 \$$    $$ \$$    $$| $$  | $$| $$     \      |   $$ \\$$    $$                    | $$     \|  $$ \$$\| $$   \$$  $$
  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$       \$$$$$$ \$$$$$$                      \$$$$$$$$ \$$   \$$ \$$    \$$$$ 
--]]-- ===============================================
missionPlateau.goal_Exit = 
{
	gotoVolume = VOLUMES.tv_exit_dustoff,
	objective = {"track_exit_platform"},
	zoneSet = ZONE_SETS.plateau_sentry
}
function missionPlateau.goal_Exit.Start():void
	CreateThread(objective_text_goal_exit);
	if not (sentry_show == nil)then
		composer_stop_show(sentry_show);
	end
	object_create_anew("track_exit_platform");
	sentry_show = nil;
	Sleep(2);
	sentry_show = composer_play_show("trans_soldroom_phantidle");
	device_set_position(OBJECTS.dm_obelisk_entry_door, .99);
	cs_run_command_script(AI.sq_fore_artifact_001, "cs_artifact_door");
end
function objective_text_goal_exit():void
	sleep_s(2);
	ObjectiveShow (TITLES.ch_return_camp);
end
function missionPlateau.goal_Exit.End():void
	object_destroy(OBJECTS.track_exit_platform);
	b_mission_done = true;
	--FadeOutMission();
	--CreateThread(FadeInMission);

--	composer_play_show("trans_soldroom_phantom");
	
--	CreateThread(vs_missing_content_artifact_inserted);
	EndMission(missionPlateau);
end

-- ========================================
-- ==== cleanup
-- =======================================

-- brute force shit. 
function bowl_encounter_cleanup():void
	ai_erase(AI.gr_plat_all);
	object_destroy_folder("obj_bowl");
	object_destroy_folder(MODULES.veh_entrance);
	object_destroy_folder(MODULES.wp_bowl);
	object_destroy_folder(MODULES.cr_bowl);
	object_destroy(OBJECTS.dp_powersupply_1);
	object_destroy_folder(MODULES.f_bowl_grenades);
end
-- ========================================
-- ==== musketeer steering
-- =======================================
function muskore_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_engine_room), 5]);
	
	ai_object_set_team(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), TEAM.covenant);				-- make core an enemy
	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), true);	-- handle jiggling bullshit
	MusketeersOrderTurnAllOn();																						-- more preamble
	Sleep(20);	
	-- i really wish we could set this per-musketeer
			for _, obj in ipairs (players()) do
				print("attacking core");
				MusketeersOrderProsecuteTarget(obj, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), true);
			end
end

function muskbox(vol:volume, flag1:flag, dist1:number, flag2:flag, dist2:number, goal:table):void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	
	repeat
		b_pos_1_set = false;
		b_pos_2_set = false;
		SleepUntil( [| volume_test_players(vol)
					or IsGoalActive(goal) == false
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					print("my buddy");
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					print("pos 2");
					MusketeerDestSetPoint(obj, flag1, dist1);
				else
					print("pos 3");
					MusketeerDestSetPoint(obj, flag2, dist2);
				end
			end
		SleepUntil( [| volume_test_players(vol) == false
					or IsGoalActive(goal) == false
					],1);
		print("EXITEXITEXITEXITEXITEXIT");
		MusketeerUtil_SetDestination_Clear_All()
	until (IsGoalActive(goal) == false);
	MusketeerUtil_SetDestination_Clear_All()
end
function airbox(vol:volume, flag1:flag, dist1:number, flag2:flag, dist2:number, flag3:flag, dist3:number, goal:table):void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	
	repeat
		b_pos_1_set = false;
		b_pos_2_set = false;
		SleepUntil( [|	volume_test_players(vol)
					or	IsGoalActive(goal) == false
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					print("my buddy");
					MusketeerDestSetPoint(obj, flag3, dist3);
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					print("pos 2");
					MusketeerDestSetPoint(obj, flag1, dist1);
				else
					print("pos 3");
					MusketeerDestSetPoint(obj, flag2, dist2);
				end
			end
		SleepUntil( [| volume_test_players(vol) == false
					or beachhead == true
					or IsGoalActive(goal) == false
					],1);
		print("EXITEXITEXITEXITEXITEXIT");
		MusketeerUtil_SetDestination_Clear_All()
	until	(	IsGoalActive(goal) == false
			or	var_boss_objcon >= 30
			);
	MusketeerUtil_SetDestination_Clear_All()
end
-- ============================================
--//=========//	Command Scripts	//=========////
-- ============================================
function cs_get_on_the_damn_turret_asshole():void
	ai_vehicle_enter(ai_current_actor, OBJECTS.plasma_turret, "turret_g");
end
function cs_ward_scout_1():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	ai_set_blind(ai_current_actor, true);
	cs_go_to(POINTS.ps_ward_scouts.p1);
	cs_go_to_and_face(POINTS.ps_ward_scouts.p1, POINTS.ps_ward_scouts.look1);
	ai_set_blind(ai_current_actor, false);
	cs_enable_looking(ai_current_actor, true);
	SleepUntil( [|	ai_combat_status(AI.sq_ward_scouts) >= 5			or
					volume_test_players(VOLUMES.tv_scout_wake)
				],1 );
	Sleep(random_range(0, 50));
	cs_enable_targeting(true);
	ai_set_blind(ai_current_actor, false);
end
function cs_ward_scout_2():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	ai_set_blind(ai_current_actor, true);
	cs_go_to(POINTS.ps_ward_scouts.p2);
	cs_go_to_and_face(POINTS.ps_ward_scouts.p2, POINTS.ps_ward_scouts.look2);
	ai_set_blind(ai_current_actor, false);
	cs_enable_looking(ai_current_actor, true);
	SleepUntil( [|	ai_combat_status(AI.sq_ward_scouts) >= 5			or
					volume_test_players(VOLUMES.tv_scout_wake)
				],1 );
	Sleep(random_range(0, 50));
	cs_enable_targeting(true);
	ai_set_blind(ai_current_actor, false);
end
function cs_ward_scout_3():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	ai_set_blind(ai_current_actor, true);
	cs_go_to(POINTS.ps_ward_scouts.p3);
	cs_go_to_and_face(POINTS.ps_ward_scouts.p3, POINTS.ps_ward_scouts.look3);
	ai_set_blind(ai_current_actor, false);
	cs_enable_looking(ai_current_actor, true);
	repeat
	local dice:number = random_range(1,3);
	if(dice == 1)then
		cs_go_to_and_face(POINTS.ps_ward_scouts.p3, POINTS.ps_ward_scouts.look4);
		elseif(dice == 2)then
			cs_go_to_and_face(POINTS.ps_ward_scouts.p3, POINTS.ps_ward_scouts.look1);
		else
			cs_go_to_and_face(POINTS.ps_ward_scouts.p3, POINTS.ps_ward_scouts.look3);
	end
	if(ai_combat_status(AI.sq_ward_scouts) <= 4	)then
		Sleep(random_range(30, 90));
	end
	until(ai_combat_status(AI.sq_ward_scouts) >= 5	);
end
function cs_breaker():void																			-- 9/9/14: called from ai objectives?
	ai_set_blind(ai_current_actor, false);
	cs_approach_player(ai_current_actor, true, 3, 15, 25);
end
function cs_ward_elite():void
	cs_push_stance(ai_current_actor, "flee");
	ai_set_blind(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
	cs_go_to(POINTS.ps_reveal_reinforcements.p1);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
end
function cs_breaker_scouts():void																	-- 9/9/14: called from ai objectives?
	ai_set_blind(ai_current_actor, false);
	ai_magically_see(ai_current_actor, SPARTANS.locke);
end
function cs_hollow_flipside_1():void
	Sleep(3);
	cs_enable_looking(true);
	repeat
		cs_go_to_and_face(POINTS.ps_hollow.pa1, POINTS.ps_hollow.look4);
		cs_go_to_and_face(POINTS.ps_hollow.pa2, POINTS.ps_hollow.look4);
	until	(	(var_hollow_objcon >= 20)	or
				(ai_living_count(AI.sq_hollow_flipside) < 3)
			);
	cs_go_to_and_face(POINTS.ps_hollow.p3, POINTS.ps_hollow.look3);
	var_hollow_flipside = var_hollow_flipside + 1;
	cs_action(ai_current_actor, true, POINTS.ps_hollow.look3, 13);		--point
	var_cov_projector_barrier = 1;
	cs_push_stance(ai_current_actor, "flee");
	ai_set_blind(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
	cs_go_to(POINTS.ps_hollow.p7);
	ai_erase (ai_current_actor);
    ai_erase (ai_current_actor);        -- no idea why, but if I don't do this, it doesn't erase the AI immediately.
end
function cs_hollow_flipside_2():void
	Sleep(3);
	cs_enable_looking(true);
	repeat
		cs_go_to_and_face(POINTS.ps_hollow.pb1, POINTS.ps_hollow.look4);
		cs_go_to_and_face(POINTS.ps_hollow.pb2, POINTS.ps_hollow.look4);
	until	(	(hollow_objcon_20()	)	or
				(ai_living_count(AI.sq_hollow_flipside) < 3)
			);
	cs_go_to_and_face(POINTS.ps_hollow.p4, POINTS.ps_hollow.look4);
	var_hollow_flipside = var_hollow_flipside + 1;
	cs_action(ai_current_actor, true, POINTS.ps_hollow.look3, 13);		--point
	var_cov_projector_barrier = 1;
	ai_set_blind(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
	cs_push_stance(ai_current_actor, "flee");
	cs_go_to(POINTS.ps_hollow.p7);
	ai_erase (ai_current_actor);
    ai_erase (ai_current_actor);        -- no idea why, but if I don't do this, it doesn't erase the AI immediately.

end
function cs_hollow_flipside_3():void
	cs_enable_looking(true);
	SleepUntil	(	[|	hollow_objcon_10()							or
						ai_living_count(AI.sq_hollow_flipside) < 3
					]
				);
--	unit_enter_vehicle(ai_current_actor, OBJECTS.veh_ghost_8, "ghost_d");
	cs_go_by(POINTS.ps_hollow.p5, POINTS.ps_hollow.p5b);
	cs_go_by(POINTS.ps_hollow.p6, POINTS.ps_hollow.p6b);
	CreateThread(hollow_counter);
	cs_go_by(POINTS.ps_hollow.p7, POINTS.ps_hollow.p7b);
	object_destroy(ai_vehicle_get(ai_current_actor));
	ai_erase (ai_current_actor);
    ai_erase (ai_current_actor);        -- no idea why, but if I don't do this, it doesn't erase the AI immediately.
end
function hollow_objcon_10():boolean
	if(var_hollow_objcon >= 10)then
		return true;
	else
		return false;
	end
end

function hollow_objcon_20():boolean
	if(var_hollow_objcon >= 20)then
		return true;
	else
		return false;
	end
end
function hollow_counter():void
	var_hollow_flipside = var_hollow_flipside + 1;
end
function cs_hollow_scout_0():void
	cs_abort_on_alert(true);
	cs_abort_on_damage(true);
    cs_go_to(POINTS.ps_reveal_scouts.p6);
end

function cs_hollow_scout_1():void
	cs_abort_on_alert(true);
	cs_abort_on_damage(true);
    cs_go_to(POINTS.ps_reveal_scouts.p7);
end

function cs_reveal_phantom_pilot_1():void
	cs_enable_looking(ai_current_actor, true);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_phantom_gunner_1():void
	cs_enable_looking(ai_current_actor, true);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_phantom_gunner_2():void
	cs_enable_looking(ai_current_actor, true);
	ai_set_blind(ai_current_actor, true);
end

function cs_dummy_pilot_2():void
	unit_enter_vehicle_immediate(ai_current_actor, OBJECTS.vin_phant2, "phantom_d");
	print("piloting 2");
end
function cs_berserk():void
	ai_berserk(ai_current_actor, true);
end
function cs_evac_scout_flee():void
	cs_push_stance(ai_current_actor, "flee");
	CreateThread(stir_the_van);
	cs_go_to(POINTS.ps_reveal_scouts.p10);
end
function stir_the_van():void
	sleep_s(3.3);
	if(ai_living_count(AI.sq_ward_scouts) >= 1)then
		cs_force_combat_status(AI.sq_ward_vanguard, 2);
	end
end
function cs_flee():void
	cs_push_stance(ai_current_actor, "flee");
	cs_go_to(POINTS.ps_evac.p1);
end
function cs_scouts_look_dumb_1():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	cs_enable_moving(false);
	cs_enable_looking(true);
	repeat
		cs_look(true, POINTS.ps_reveal_scouts.p8);
		scout_random_behavior_generator();
		Sleep(90);
	until(b_scout_dialog_done == true);											-- need to hook up to real dialog line once it's implemented
	repeat
		scout_random_behavior_generator();
		sleep_s(2);
	until(volume_test_players(VOLUMES.tv_scout_wake));
end
function cs_scouts_look_dumb_2():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	cs_enable_moving(false);
	cs_enable_looking(true);
	repeat
		cs_look(true, POINTS.ps_reveal_scouts.p8);
		scout_random_behavior_generator();
		Sleep(90);
	until(b_scout_dialog_done == true);											-- need to hook up to real dialog line once it's implemented
	repeat
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p1, POINTS.ps_reveal_scouts.p8);
		scout_random_behavior_generator();
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p2, POINTS.ps_reveal_scouts.look2);
		sleep_s(random_range(0,2));
		scout_random_behavior_generator();
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p3, POINTS.ps_reveal_scouts.look3);
		scout_random_behavior_generator();
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p4, POINTS.ps_reveal_scouts.look4);
		scout_random_behavior_generator();
	until(false);
end
function cs_scouts_look_dumb_3():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	cs_enable_moving(false);
	cs_enable_looking(true);
	sleep_s(1);
	repeat
		cs_look(true, POINTS.ps_reveal_scouts.p8);
		scout_random_behavior_generator();
		Sleep(90);
	until(b_scout_dialog_done == true);											-- need to hook up to real dialog line once it's implemented
	repeat
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p8, POINTS.ps_reveal_scouts.p2);
		scout_random_behavior_generator();
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p5, POINTS.ps_reveal_scouts.p3);
		sleep_s(random_range(0,2));
		scout_random_behavior_generator();
		cs_go_to_and_face(POINTS.ps_reveal_scouts.p9, POINTS.ps_reveal_scouts.look4);
		scout_random_behavior_generator();
	until(false);
end

function scout_random_behavior_generator():void
	local dice:number = random_range(1,5);
	if(dice == 1)then
		cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 13);		-- point
	elseif(dice == 2)then
		cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 14);		-- pose (multiple
	elseif(dice == 3)then
		cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 18);		-- same as 14?
	else
		sleep_s(random_range(1,3));
	end
end

function cs_scouts_look_dumb():void
	cs_abort_on_alert( true);
	cs_abort_on_damage(true);
	cs_enable_moving(false);
--	cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 13);		-- point
--	cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 14);		-- pose (multiple
	cs_action(ai_current_actor, true, POINTS.ps_reveal_scouts.p8, 18);		-- same as 14?
	cs_look(true, POINTS.ps_reveal_scouts.p8);
	sleep_s(35);															-- change to be at end of dialog once dialog is in better shape.
end
function one_in_four():boolean
	if(random_range(1,4) == 1)then	
		return true;
	else
		return false;
	end
end
function cs_return_ai_function():void
	cs_enable_looking(ai_current_actor, true);
	cs_enable_moving(ai_current_actor, true);
	cs_enable_targeting(ai_current_actor, true);
end
function cs_ward_phantom():void
    ai_set_blind(ai_current_actor, false);
	unit_open(ai_vehicle_get(ai_current_actor));
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p1, POINTS.ps_ward_gunship.look1);
	SleepUntil([|var_reveal_objcon >= 5]);
	unit_close(ai_vehicle_get(ai_current_actor));
	sleep_s(1);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p1, POINTS.ps_ward_gunship.look1);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p2, POINTS.ps_ward_gunship.look2);
	sleep_s(1);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p2, POINTS.ps_ward_gunship.look3);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p2, POINTS.ps_ward_gunship.look4);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p2, POINTS.ps_ward_gunship.look5);
	sleep_s(1);
	var_ward_phantom = 1;															-- triggers liftoff sequence
	ai_set_blind(AI.sq_ward_phantom.b, true);
	ai_set_blind(AI.sq_ward_phantom.c, true);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p5, POINTS.ps_ward_gunship.look5);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p6, POINTS.ps_ward_gunship.look6);
	cs_fly_to_and_face(POINTS.ps_ward_gunship.p7, POINTS.ps_ward_gunship.look7);
	cs_fly_to(POINTS.ps_ward_gunship.p8);
	f_vehicle_scale_destroy(ai_vehicle_get(ai_current_actor));
	ai_erase(ai_current_actor);
end
function cs_reveal_dummyshoot_52():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_aa.p5_2);
	sleep_s(1);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_aa.p5_2);
	sleep_s(3);
end
function cs_reveal_dummyshoot_33():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(1);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(3);
end
function cs_reveal_dummyshoot_23():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(1);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(3);
end
function cs_reveal_dummyshoot_31():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(1);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_aa.p3_3);
	sleep_s(3);
end
function cs_reveal_dummyshoot_81():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_aa.p8_1);
	sleep_s(1);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_aa.p8_1);
	sleep_s(3);
end
function cs_gunner_v_banshee_1():void
	cs_aim_object(ai_current_actor, true, OBJECTS.banshee1);
	cs_shoot(ai_current_actor, true, OBJECTS.banshee1);
	sleep_s(3);
end
function cs_gunner_v_banshee_2():void
	cs_aim_object(ai_current_actor, true, OBJECTS.banshee3);
	cs_shoot(ai_current_actor, true, OBJECTS.banshee3);
	sleep_s(3);
end
function cs_liftoff_1():void
	cs_enable_looking(ai_current_actor, false);							-- autonomous look off
	cs_enable_moving(ai_current_actor, false);							-- autonomous movement off
	cs_face(ai_current_actor, true, POINTS.ps_liftoff.p0);
	cs_action(ai_current_actor, true, POINTS.ps_liftoff.p0, 13);		--point
	cs_abort_on_damage(true);
	cs_action(ai_current_actor, true, POINTS.ps_liftoff.p0, 15);		--shakefist
	cs_go_to(ai_current_actor, true, POINTS.ps_liftoff.p2);
	cs_enable_looking(ai_current_actor, true);							-- autonomous look on
	cs_face(ai_current_actor, true, POINTS.ps_hollow.p2);
	cs_action(ai_current_actor, true, POINTS.ps_hollow.p2, 13);			--point
end
function cs_liftoff_grunt_scramble():void
	cs_push_stance(ai_current_actor, "flee");
	repeat
		local dice:number = nil;
		dice = random_range(1, 5);
		if(dice == 1)then
			cs_go_to(POINTS.ps_liftoff.p1);
		elseif(dice == 2)then
			cs_go_to(POINTS.ps_liftoff.p2);
		elseif(dice == 3)then
			cs_go_to(POINTS.ps_liftoff.p3);
		elseif(dice == 4)then
			cs_go_to(POINTS.ps_liftoff.p4);
		elseif(dice == 5)then
			cs_go_to(POINTS.ps_liftoff.p6);
		end
	until(var_liftoff >= 2);
end

--0		_ai_atom_action_berserk,			-- works - roar
--1       _ai_atom_action_surprise_front,	-- works - hop back
--2       _ai_atom_action_surprise_back,	-- works - flip aroun - translates
--3       _ai_atom_action_evade_left,
--4       _ai_atom_action_evade_right,
--5       _ai_atom_action_dive_forward,
--6       _ai_atom_action_dive_back,		-- works - roll backward + jump
--7       _ai_atom_action_dive_left,
--8       _ai_atom_action_dive_right,
--9       _ai_atom_action_advance,			-- point (no foot slide)
--10       _ai_atom_action_cheer,			-- no
--11       _ai_atom_action_fallback,		-- no
--12       _ai_atom_action_hold,			-- no
--13       _ai_atom_action_point,			-- works! elites and grunts (not sure about jax)
--14       _ai_atom_action_posing,			-- works on grunts, not on elites. Same as 18?
--15       _ai_atom_action_shakefist,		-- works great
--16       _ai_atom_action_signal_attack,	-- no
--17       _ai_atom_action_signal_move,		-- no
--18       _ai_atom_action_taunt,			-- works on grunts, not on elites. Same as 14?
--19       _ai_atom_action_warn,			-- works on elites - looks like a point with a foot slide
--20       _ai_atom_action_wave,			-- no


function cs_arbiter():void	--onSpawn
	object_set_scale ( ai_current_actor, 1.1, 0);
	object_cannot_take_damage(ai_get_object(ai_current_actor));
end

function cs_hollow_leader():void
	cs_abort_on_damage(true);
	cs_go_to_and_face(POINTS.ps_hollow.p1, POINTS.ps_hollow.p2);
	cs_action(ai_current_actor, true, POINTS.ps_hollow.p2, 15);		--shakefist
	cs_action(ai_current_actor, true, POINTS.ps_hollow.p2, 13);		--point
end
function cs_ramp_ghostgrunt():void
	cs_abort_on_damage(false);
	cs_vehicle_boost(ai_current_actor, true);
	cs_go_to(POINTS.ps_ramp.p7);
	cs_go_to_and_face(POINTS.ps_ramp.p8, POINTS.ps_ramp.look8);
	cs_go_to_and_face(POINTS.ps_ramp.p3, POINTS.ps_ramp.look8);
end
function cs_ramp_foot4_backpedal_1():void
	cs_abort_on_damage(true);
	cs_aim(true, POINTS.ps_ramp.look8);
	cs_go_to_and_face(POINTS.ps_ramp.p9, POINTS.ps_ramp.look8);
end
function cs_ramp_foot4_backpedal_2():void
	cs_abort_on_damage(true);
	cs_aim(true, POINTS.ps_ramp.p3);
	cs_go_to_and_face(POINTS.ps_ramp.p10, POINTS.ps_ramp.p3);
end
function cs_ramp_foot4_backpedal_3():void
	cs_abort_on_damage(true);
	cs_aim(true, POINTS.ps_ramp.look11);
	cs_go_to_and_face(POINTS.ps_ramp.p11, POINTS.ps_ramp.look11);
end
function cs_ramp_flee_2():void
	cs_push_stance(ai_current_actor, "flee");
	local dice:number = random_range(1,3);
	if(dice == 1)then
		cs_go_to(POINTS.ps_ramp.p4);
	elseif(dice == 1)then
		cs_go_to(POINTS.ps_ramp.p5);
	elseif(dice == 1)then
		cs_go_to(POINTS.ps_ramp.p6);
	end
end
function cs_ghostcave_elite():void
	print("ghostcave elite");
	cs_abort_on_damage(true);
	cs_go_to(POINTS.ps_ghostcave.p1);
	cs_face(true, POINTS.ps_ghostcave.look1);

	cs_action(ai_current_actor, true, POINTS.ps_ghostcave.look1, 13);		--play a "point" animation in the direction of .ps_ghostcave.look1
	cs_look(true, POINTS.ps_ghostcave.look2);
		sleep_s(.6);
		cs_abort_on_alert(true);
	cs_go_to_and_face(POINTS.ps_ghostcave.p1, POINTS.ps_ghostcave.look2);
	cs_action(ai_current_actor, true, POINTS.ps_ghostcave.look2, 15);		--shakefist
		sleep_s(1);
	cs_action(ai_current_actor, true, POINTS.ps_ghostcave.look2, 13);		--point
		sleep_s(.7);
	cs_go_to_and_face(POINTS.ps_ghostcave.p1, POINTS.ps_ghostcave.look3);
	cs_action(ai_current_actor, true, POINTS.ps_ghostcave.look3, 13);		--point
		sleep_s(1);
	cs_look(true, POINTS.ps_ghostcave.look2);
		sleep_s(1);
end

function cs_constructor():void
	object_set_scale (ai_get_object(AI.sq_fore_artifact_001), 0.01, .01 ); --Shrink size over time
	ai_exit_limbo(AI.sq_fore_artifact_001);
	object_set_scale (ai_get_object(AI.sq_fore_artifact_001), 1.0, .75 ); --Shrink size over time
	object_dissolve_from_marker(ai_current_actor, "phase_in", "fx_engine");
	object_cannot_take_damage(ai_current_actor);
	SleepUntil([|n_obelisk_objcon >= 100]);
	sleep_s(2);
	cs_face_player(true);
end
function be_sure_to_call_this_at_the_end_of_the_mission()
	EndMission(missionPlateau);
end


function vs_missing_content_artifact_inserted():void
--	missing_content_text("Players insert the Artifact into the Device.", 240);
	missing_content_text("Arbiter Phantom picks up Osiris", 180);
	missing_content_text("Osiris returns to base camp", 180);
--	missing_content_text("NPCs freak out", 180);
	fade_out_for_player(PLAYERS.player0);
	fade_out_for_player(PLAYERS.player1);
	fade_out_for_player(PLAYERS.player2);
	fade_out_for_player(PLAYERS.player3);
	player_control_fade_out_all_input(1);
	sleep_s(1);
	--CreateThread(audio_plateau_logo);
	sleep_s(3);
	fade_in_for_player(PLAYERS.player0);
	fade_in_for_player(PLAYERS.player1);
	fade_in_for_player(PLAYERS.player2);
	fade_in_for_player(PLAYERS.player3);
	player_control_fade_in_all_input(1);
end
function black_bar_chapter_title(tit:title)
  cinematic_show_letterbox (true);
  sleep_s ( 1.5 );
  cinematic_set_chud_objective (tit);
  sleep_s ( 6 );
  cinematic_show_letterbox (false);
end
-- =======================================
-- == development & test shortcuts
-- ======================================
function look_at_test_snapshut():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_snapshut_look, 21, 66) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function start_vs():void
	SetGlobalFlag("TsunamiLocke_complete");
	SetGlobalFlag("Grotto_complete");
	SetGlobalFlag("Beach_complete");
end
function blink_start():void
	print ("shortcut: Start Plateau, no intro");
	StartPlateau();
end
function blink_breach():void
	print ("teleport: Breach, Plateau");
	GoalBlink(missionPlateau, "goal_Breach", FLAGS.tpf0);
	CreateThread(blink_fixer);
end
function blink_dropdown():void
	GoalBlink(missionPlateau, "goal_Caves", FLAGS.tpf_dropdown);
	print ("teleport: Caves, Plateau");
	CreateThread(blink_fixer);
end
function blink_sentry():void
	GoalBlink(missionPlateau, "goal_Caves", FLAGS.tpf1);
	CreateThread(blink_fixer);
	print ("teleport: Sentry Reveal, Plateau");
end
function blink_test_liftoff():void
--	switch_zone_set(ZONE_SETS.plateau_start);
	teleport_player_to_flag (PLAYERS.player0,FLAGS.tpf_liftoff, true);
	teleport_player_to_flag (PLAYERS.player1,FLAGS.tpf_liftoff, true);
	teleport_player_to_flag (PLAYERS.player2,FLAGS.tpf_liftoff, true);
	teleport_player_to_flag (PLAYERS.player3,FLAGS.tpf_liftoff, true);
	CreateThread(blink_fixer);
	print ("teleport: *TEST* Sentry Reveal, Plateau");
	print ("teleport: *TEST* Mission Logic Not In Progress");
	CreateThread(warning_text, "Type 'liftoff' to start the sentry ship sequence", 360, 1);
end
function blink_hollow():void
	GoalBlink(missionPlateau, "goal_Hollow", FLAGS.tpf_hollow);							-- also creates objects folder
	CreateThread(blink_fixer);
	object_create_folder_anew("obj_reveal");
	object_create_folder_anew("f_reveal_grenades");
	object_create_folder_anew("f_reveal_weapons");
	print ("teleport: Hollow, Plateau");
end
function blink_ramp():void
--	switch_zone_set(ZONE_SETS.plateau_start);
	GoalBlink(missionPlateau, "goal_Ramp",FLAGS.tpf_ramp);
	CreateThread(blink_fixer);
	print ("teleport: Ramp, Plateau");
	object_create_anew("hollow_projected_barrier");	
    object_create_folder_anew("veh_hollow");
    object_create_anew("hollow_projected_barrier");
end
function blink_bowl():void
--	switch_zone_set(ZONE_SETS.plateau_bowl);
	GoalBlink(missionPlateau, "goal_PreBowl",FLAGS.tpf2);
	CreateThread(blink_fixer);
	print ("teleport: Approach to Bowl, Plateau");
	Sleep(20);
	var_cov_projector_barrier = 1;					-- turn on shield barrier
	ai_erase(AI.sg_hollow_all);
end
function blink_tracking():void
	GoalBlink(missionPlateau, "goal_Tomb", FLAGS.tpf_tracking);
	CreateThread(blink_fixer);
	print ("teleport: Interior of Temple, Plateau");
end
function blink_door():void
	GoalBlink(missionPlateau, "goal_Temp_Bypass", FLAGS.tpf_door);
	CreateThread(blink_fixer);
	print ("teleport: Interior of Temple, Plateau");
	Sleep(2);
	CreateThread(end_temple_objective);
	Sleep(2);
	open_door_sequence();
end
function blink_boss():void
	GoalBlink(missionPlateau, "goal_Awakening", FLAGS.tpf3);
	CreateThread(blink_fixer);
	CreateThread(flock_crevice);
	print ("teleport: Sentry Ship Battle, Plateau");
end
function blink_soldier():void
	blink_obelisk();
end
function blink_obelisk():void
	CreateThread(audio_plateau_stopallmusic);		--stop all looping music
--	object_create_anew("dm_obelisk_entry_door");
	Sleep (2);
	GoalBlink(missionPlateau, "goal_Map", FLAGS.fl_ob_1);
	CreateThread(blink_fixer);
	object_dissolve_from_marker(OBJECTS.keyhole_shield_1, "phase_out", "tj_smells");
	print ("teleport: Soldier fight at the obelisk");
end
function blink_soldier_knight():void
	blink_obelisk();
end
function blink_artifact():void
	GoalBlink(missionPlateau, "goal_Artifact", FLAGS.tpf_soldier);
	CreateThread(blink_fixer);
	device_set_position(OBJECTS.dm_obelisk_entry_door_2, .99);
	print ("teleport: Soldier Room, Artifact, Plateau");
end
function blink_fixer():void 
	-- Thread up
	CreateThread(PlateauStart);							-- fires up a bunch of threads that were supposed to be kicked off at mission start
	game_save_no_timeout();								-- 3-19-2014 Theoretically, this will prevent some weirdness that wouldn't otherwise happen, if the player were progressing through the mission in normal play
	object_destroy(OBJECTS.vin_sent_machine);
	object_destroy(OBJECTS.vin_sent_machine_2);
	CreateThread(audio_plateau_stopallmusic);			-- stop all looping music
	PlayersSetWeaponRelaxed(false);
--	CreateCollectibles(missionPlateau);					-- removing for CVS
	--CreateThread(blink_fixer_narrative);				--	Disable Idle chatter when blinking.
end
function sequential_shake():void
	lighter_shake();
	sleep_s(1);
	standard_shake();
end
function standard_shake():void
-- does a standard shake for all clients
	RunClientScript("start_global_rumble_shake_large", 1.5);
end
function lighter_shake():void
-- does a smaller shake for all clients
	RunClientScript("start_global_rumble_shake_medium", 1);
end
-- ------------------------------------------------- /flocks
function flock_caves_client():void
	print("start flocks");
	flock_create("vin_ambient_cavern_birdies_1");
	flock_create("vin_ambient_cavern_birdies_2");
	flock_create("vin_ambient_cavern_birdies_3");
	flock_create("flocks_dropdown_fliers_a1");
	flock_create("flocks_dropdown_fliers_a2");
--	flock_create("flocks_dropdown_fliers_a3");
	flock_create("flocks_dropdown_fliers_b1");
	flock_create("flocks_dropdown_fliers_b2");
	flock_create("flocks_dropdown_fliers_b3");
	flock_create("flocks_dropdown_crawlers_a");
	flock_create("flocks_dropdown_crawlers_b");
	Sleep(4);
	flock_start("vin_ambient_cavern_birdies_1");
	flock_start("vin_ambient_cavern_birdies_2");
	flock_start("vin_ambient_cavern_birdies_3");
	flock_start("flocks_dropdown_fliers_a1");
	flock_start("flocks_dropdown_fliers_a2");
--	flock_start("flocks_dropdown_fliers_a3");
	flock_start("flocks_dropdown_fliers_b1");
	flock_start("flocks_dropdown_fliers_b2");
	flock_start("flocks_dropdown_fliers_b3");
	flock_start("flocks_dropdown_crawlers_a");
	flock_start("flocks_dropdown_crawlers_b");
	sleep_s(1.5);
	flock_stop("vin_ambient_cavern_birdies_1");
	flock_stop("vin_ambient_cavern_birdies_2");
	flock_stop("vin_ambient_cavern_birdies_3");
	flock_stop("flocks_dropdown_fliers_a1");
	flock_stop("flocks_dropdown_fliers_a2");
--	flock_stop("flocks_dropdown_fliers_a3");
	flock_stop("flocks_dropdown_fliers_b1");
	flock_stop("flocks_dropdown_fliers_b2");
	flock_stop("flocks_dropdown_fliers_b3");
	flock_stop("flocks_dropdown_crawlers_a");
	flock_stop("flocks_dropdown_crawlers_b");
	sleep_s(1.5);
	flock_stop("vin_ambient_cavern_birdies");
end
function flock_ground_caves_client():void
	flock_stop("vin_ambient_cavern_beetles");
end
function flock_cavern_client():void
	print("start flocks");
	flock_create("flocks_dropdown_fliers_c1");
	flock_create("flocks_dropdown_fliers_c2");
	flock_create("flocks_reveal_crawlers_1");
	Sleep(4);
	flock_start("flocks_dropdown_fliers_c1");
	flock_start("flocks_dropdown_fliers_c2");
	flock_start("flocks_reveal_crawlers_1");
	sleep_s(1.5);
	flock_stop("flocks_dropdown_fliers_c1");
	flock_stop("flocks_dropdown_fliers_c2");
	sleep_s(8.5);
	flock_stop("flocks_reveal_crawlers_1");													-- ground flock spawned at slower rate to stagger grazing movement. Takes longer to spawn a full flock.
end
function flock_hollow_client():void
	print("start flocks");
	flock_create("flocks_dropdown_fliers_1");
	flock_create("flocks_dropdown_fliers_2");
--	flock_create("flocks_hollow_crawlers_1");
	Sleep(4);

	flock_start("flocks_dropdown_fliers_1");
	flock_start("flocks_dropdown_fliers_2");
--	flock_start("flocks_hollow_crawlers_1");
	sleep_s(1.5);
	flock_stop("flocks_dropdown_fliers_1");
	flock_stop("flocks_dropdown_fliers_2");
	sleep_s(8.5);
--	flock_stop("flocks_hollow_crawlers_1");													-- ground flock spawned at slower rate to stagger grazing movement. Takes longer to spawn a full flock.
end
function flock_ramp_client():void
	print("start flocks");
	flock_create("flocks_rampcave_crawlers_1");
	flock_create("flocks_ramp_fliers_1");
	flock_create("flocks_ramp_fliers_1b");
	flock_create("flocks_ramp_fliers_1g");
	flock_create("flocks_ramp_fliers_2");
	flock_create("flocks_ramp_fliers_2g");
	Sleep(4);

	flock_start("flocks_rampcave_crawlers_1");
	flock_start("flocks_ramp_fliers_1");
	flock_start("flocks_ramp_fliers_1b");
	flock_start("flocks_ramp_fliers_1g");
	flock_start("flocks_ramp_fliers_2");
	flock_start("flocks_ramp_fliers_2g");
	sleep_s(1.5);
	flock_stop("flocks_ramp_fliers_1");
	flock_stop("flocks_ramp_fliers_1b");
	flock_stop("flocks_ramp_fliers_1g");
	flock_stop("flocks_ramp_fliers_2");
	flock_stop("flocks_ramp_fliers_2g");
	sleep_s(8.5);
	flock_stop("flocks_rampcave_crawlers_1");												-- ground flock spawned at slower rate to stagger grazing movement. Takes longer to spawn a full flock.
end
function flock_crevice():void
	print("start flocks");
	flock_create("crevice_flock");
	sleep_s(1.5);
	flock_start("crevice_flock");
	sleep_s(2);
	flock_stop("crevice_flock");
end
--## COMMON
function GetLocalPlayerKey(p:player):number
	for key,value in pairs(local_players()) do
		if (player_get_unit(p) == value) then
			return key;
		end
	end
end
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT, thanks in advance.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT

global n_clientTempleScanCount:number = 0;
global n_localPlayerLastTrackerToggleTick = {-1,-1,-1,-1};
global n_trackingTutorialSleepWait = 10.0;
global b_trackingTutorialIsSleeping = false;
global b_trackingSuccessIsActive = false;


function horn_distant_client():void
	sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_w2plateau_sentryship_horndistant_2d.sound'), nil, 1)
	--sound_impulse_start_marker(tag, object, string, number)	
end

function horn_3d_client():void
	sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipramp_horn.sound'), object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 1)
	--sound_impulse_start_marker(tag, object, string, number)	
end

function horn_3d_bis_client():void
	sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipramp_horn.sound'), object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 1)
	--sound_impulse_start_marker(tag, object, string, number)	
end
function remoteClient.RecreateSentryLip_client():void
	object_destroy(OBJECTS.am_sangp_sentryreveal_reg1);
	object_destroy(OBJECTS.am_sangp_sentryreveal_reg2);
	object_destroy(OBJECTS.am_sangp_sentryreveal_reg3);
	object_destroy(OBJECTS.am_sangp_sentryreveal_reg4);
	object_destroy(OBJECTS.am_sangp_sentryreveal_rockfall1);
	object_destroy(OBJECTS.am_sangp_sentryreveal_rockfall2);
	object_destroy(OBJECTS.am_sangp_sentryreveal_rockfall3);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall1);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall2);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall3);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall4);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall5);
	object_destroy(OBJECTS.am_sangp_sentryreveal_skyfall6);
	Sleep(2);
	object_create_anew("am_sangp_sentryreveal_reg1");
	object_create_anew("am_sangp_sentryreveal_reg2");
	object_create_anew("am_sangp_sentryreveal_reg3");
	object_create_anew("am_sangp_sentryreveal_reg4");
	object_create_anew("am_sangp_sentryreveal_rockfall1");
	object_create_anew("am_sangp_sentryreveal_rockfall2");
	object_create_anew("am_sangp_sentryreveal_rockfall3");
	object_create_anew("am_sangp_sentryreveal_skyfall1");
	object_create_anew("am_sangp_sentryreveal_skyfall2");
	object_create_anew("am_sangp_sentryreveal_skyfall3");
	object_create_anew("am_sangp_sentryreveal_skyfall4");
	object_create_anew("am_sangp_sentryreveal_skyfall5");
	object_create_anew("am_sangp_sentryreveal_skyfall6");
end
function remoteClient.swat():void
	print("sr_impact_upwards_xlg_01");
	effect_new( TAG("levels/campaignworld020/w2_plateau/fx/destruction/sr_impact_upwards_xlg_01.effect"), FLAGS.fl_swat);
	print("sr_rock_hit_flat_xlg_01");
	effect_new( TAG("levels/campaignworld020/w2_plateau/fx/destruction/sr_rock_hit_flat_xlg_01.effect"), FLAGS.fl_swat);
end
function remoteClient.ClientMuralScanRight():void
	effect_new( TAG('levels/campaignworld020/w2_hub/fx/tracking/temple/w2_hub_tracking_temple_right.effect'), FLAGS.mural_right_fx_locator);
end

function remoteClient.ClientMuralScanLeft():void
	effect_new( TAG('levels/campaignworld020/w2_hub/fx/tracking/temple/w2_hub_tracking_temple_left.effect'), FLAGS.mural_left_fx_locator);
end

function remoteClient.ClientMuralScanFinal():void
	effect_new( TAG('levels/campaignworld020/w2_hub/fx/tracking/temple/w2_hub_tracking_temple_middle.effect'), FLAGS.mural_final_fx_locator);
end

function remoteClient.f_clientIncrementTempleScanCount():void
	n_clientTempleScanCount = n_clientTempleScanCount + 1;
end

function remoteClient.f_clientSetLastTrackerToggleTick_Player(key:number):void
	if key==1 then
		ShowEquipTrackerMessage(PLAYERS.player0, false);
	elseif key==2 then
		ShowEquipTrackerMessage(PLAYERS.player1, false);
	elseif key==3 then
		ShowEquipTrackerMessage(PLAYERS.player2, false);
	elseif key==4 then
		ShowEquipTrackerMessage(PLAYERS.player3, false);
	end
	n_localPlayerLastTrackerToggleTick[key] = game_tick_get();
	print("f_clientSetLastTrackerToggleTick_Player SET: ", n_localPlayerLastTrackerToggleTick[key]);
end

function remoteClient.f_clientPlateauTrackingTutorial():void
	
	-- Kick it off
	for key,value in pairs(local_players()) do
		StartPlayerTrackingTutorial(key, value);
	end
end
function StartPlayerTrackingTutorial(key:number, p:player):void
	
	-- Show equip message until player actually does so
	ShowEquipTrackerMessage(p, true);
	while ((not IsTrackerEquipped(p)) and n_clientTempleScanCount ~= n_templeFinalScanCount) do
		Sleep(1);
	end
	ShowEquipTrackerMessage(p, false);
	
	-- Periodically remind the player, as necessary
	while (n_clientTempleScanCount ~= n_templeFinalScanCount) do
	
		local currentTick = game_tick_get();
			
		if IsTrackerEquipped(p) then
		
			print("Player in Tracking mode: " .. key);
			
		-- elseif ((currentTick - n_localPlayerLastTrackerToggleTick[key]) / n_fps) <= n_trackingTutorialSleepWait then
		
			--print("Detected a Tracking mode toggle during sleep: " .. key);
			
		else
		
			ShowEquipTrackerMessage(p, true);
			SleepUntil([| b_trackingSuccessIsActive], 4, 5.0 * n_fps());
			ShowEquipTrackerMessage(p, false);

		end
		
		b_trackingTutorialIsSleeping = true;
		CreateThread(ClientTrackingTutorialSleep);
		
		SleepUntil([| not (b_trackingTutorialIsSleeping or b_trackingSuccessIsActive) ], 4);

	end
	
end
function remoteClient.ClientTrackingSuccessActive():void
	print("ClientTrackingSuccessActive");
	b_trackingSuccessIsActive = true;
end

function remoteClient.ClientTrackingSuccessComplete():void
	print("ClientTrackingSuccessComplete");
	b_trackingSuccessIsActive = false;
	ClientTrackingTutorialSleepKill();
end

function ClientTrackingTutorialSleep():void
	print("ClientTrackingTutorialSleep");
	sleep_s(n_trackingTutorialSleepWait);
	ClientTrackingTutorialSleepKill();
end

function ClientTrackingTutorialSleepKill():void
	print("ClientTrackingTutorialSleepKill");
	b_trackingTutorialIsSleeping = false;
end
function remoteClient.scatter_crevice_flock_client():void
	flock_change_destination("crevice_flock", "circle0", "sink0");
	flock_change_destination("crevice_flock", "circle1", "sink0");
	flock_change_destination("crevice_flock", "circle2", "sink2");
	flock_change_destination("crevice_flock", "circle3", "sink1");
	flock_change_destination("crevice_flock", "circle4", "sink1");
	flock_change_destination("crevice_flock", "circle5", "sink2");
end
function remoteClient.overload_charge_up():void
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_overload_station\fx\overload_station_pulse_shield.effect'), OBJECTS.dc_scan_shieldgenerator,"fx_top");
end


--[[

This list starts at 0

enum e_campaign_metagame_bucket_type
{
0       _campaign_metagame_bucket_type_brute,
1       _campaign_metagame_bucket_type_grunt,
2       _campaign_metagame_bucket_type_jackal,
3       _campaign_metagame_bucket_type_skirmisher,
4       _campaign_metagame_bucket_type_marine,
5       _campaign_metagame_bucket_type_spartan,
6       _campaign_metagame_bucket_type_bugger,
7       _campaign_metagame_bucket_type_hunter,
8       _campaign_metagame_bucket_type_flood_infection,
9       _campaign_metagame_bucket_type_flood_carrier,
10       _campaign_metagame_bucket_type_flood_combat,
11       _campaign_metagame_bucket_type_flood_pure,
12       _campaign_metagame_bucket_type_sentinel,
13       _campaign_metagame_bucket_type_elite,
14       _campaign_metagame_bucket_type_engineer,
15       _campaign_metagame_bucket_type_mule,

16       _campaign_metagame_bucket_type_turret,
17       _campaign_metagame_bucket_type_mongoose,
18       _campaign_metagame_bucket_type_warthog,
19       _campaign_metagame_bucket_type_scorpion,
20       _campaign_metagame_bucket_type_hornet,
21       _campaign_metagame_bucket_type_pelican,
22       _campaign_metagame_bucket_type_revenant,
23       _campaign_metagame_bucket_type_seraph,

24       _campaign_metagame_bucket_type_shade,
25       _campaign_metagame_bucket_type_watchtower,
26       _campaign_metagame_bucket_type_ghost,
27       _campaign_metagame_bucket_type_chopper,
28       _campaign_metagame_bucket_type_mauler,
29       _campaign_metagame_bucket_type_wraith,
30       _campaign_metagame_bucket_type_banshee,
31       _campaign_metagame_bucket_type_phantom,
32       _campaign_metagame_bucket_type_scarab,
33       _campaign_metagame_bucket_type_guntower,

34       _campaign_metagame_bucket_type_tuning_fork,
35       _campaign_metagame_bucket_type_broadsword,
36       _campaign_metagame_bucket_type_mammoth,
37       _campaign_metagame_bucket_type_lich,
38       _campaign_metagame_bucket_type_mantis,
39       _campaign_metagame_bucket_type_wasp,
40       _campaign_metagame_bucket_type_phaeton,

41       _campaign_metagame_bucket_type_bishop,
42       _campaign_metagame_bucket_type_knight,
43       _campaign_metagame_bucket_type_pawn,
44       _campaign_metagame_bucket_type_soldier,
45       _campaign_metagame_bucket_type_packmaster,
46       _campaign_metagame_bucket_type_cavalier,

       k_campaign_metagame_bucket_type_count,

       _campaign_metagame_bucket_type_none= NONE,
};
--]]
