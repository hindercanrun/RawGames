--## SERVER

--[[

████████╗██╗  ██╗███████╗ █████╗ ████████╗███████╗██████╗      ██████╗ ███████╗    ██╗    ██╗ █████╗ ██████╗ 
╚══██╔══╝██║  ██║██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔══██╗██╔══██╗
   ██║   ███████║█████╗  ███████║   ██║   █████╗  ██████╔╝    ██║   ██║█████╗      ██║ █╗ ██║███████║██████╔╝
   ██║   ██╔══██║██╔══╝  ██╔══██║   ██║   ██╔══╝  ██╔══██╗    ██║   ██║██╔══╝      ██║███╗██║██╔══██║██╔══██╗
   ██║   ██║  ██║███████╗██║  ██║   ██║   ███████╗██║  ██║    ╚██████╔╝██║         ╚███╔███╔╝██║  ██║██║  ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═╝          ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝
-- Theater of War ]] 
global comp_dogfight_1:number = nil;
global comp_dogfight_2:number = nil;
global comp_elite_turret:number = nil;
global comp_intro_armada:number = nil;
global comp_random_slipspacers:number = nil;
global comp_phantom_crash:number = nil;
global comp_precombat_grunt:number = nil;
global comp_precombat_jackal:number = nil; 
global comp_precombat_elite:number = nil; 
global battery_1:number = 0;
global battery_2:number = 0;
global battery_3:number = 0;
global battery_4:number = 0;
global battery_5:number = 0;
global battery_6:number = 0;
global battery_7:number = 0;

function theater_of_war():void
	CreateThread(tow_aa_battery_1);
	CreateThread(tow_aa_battery_2);
	CreateThread(flock_cull_intro_when_no_one_is_looking);
	CreateThread(flock_cull_burgertown_when_no_one_is_looking_part_1);
	CreateThread(flock_cull_objcon_30);
	CreateThread(flock_cull_objcon_50);
	CreateThread(intro_composition_listener_1);
	CreateThread(intro_composition_listener_2);
	CreateThread(flock_intro_client);
end
function flock_intro_test():void
	print("start intro flocks"); 
	flock_create("flock_lz1_arb1");
	flock_create("flock_lz2_arb1");
	flock_create("flock_lz1_cov1");
	flock_create("flock_lz2_cov1");
	flock_create("flock_lz3_arb1");
	flock_create("flock_lz3_cov1");
	Sleep(4);
	flock_start("flock_lz1_arb1");
	flock_start("flock_lz2_arb1");
	flock_start("flock_lz1_cov1");
	flock_start("flock_lz2_cov1");
	flock_start("flock_lz3_arb1");
	flock_start("flock_lz3_cov1");
	sleep_s(1);
end

function tow_aa_battery_1():void
-- 6/25/15 replaced by fx objects --	aa_battery_control(1, 4);
	print("no thanks");
end
function tow_aa_battery_2():void
-- 6/25/15 replaced by fx objects --	aa_battery_control(2, 5);
	print("no thanks");
end
function tow_aa_battery_3():void
-- 6/25/15 replaced by fx objects --	aa_battery_control(3, 5);
	print("no thanks");
end
function tow_aa_battery_4():void
-- 6/25/15 replaced by fx objects --	aa_battery_control(4, 6);
	print("no thanks");
end
function tow_aa_battery_5():void
	print("no thanks");
-- 6/25/15 replaced by fx objects --	aa_battery_control(5, 1);
-- 6/25/15 replaced by fx objects --	aa_battery_control(6, 1);
-- 6/25/15 replaced by fx objects --	aa_battery_control(7, 2);
end
-- ====================================== AA BATTERIES\server:
function aa_battery_control(batt:number, guncount:number):void
	for v = 1,guncount do
		CreateThread(aa_gun_looper, batt, v);
		sleep_s(random_range(0.1, 1.5));
	end
end
function aa_gun_looper(batt:number, gunnum:number):void
	repeat
		RunClientScript("gun_battery_burst", batt, gunnum, false); 
		sleep_s(random_range(4, 6));
		RunClientScript("gun_battery_burst", batt, gunnum, true);
		sleep_s(random_range(2, 5));
	until(_G["battery_"..batt] >= 1);											-- battery_1 battery_2 battery_3 battery_4 battery_5 battery_6 battery_7 (for ctrl-f sake)
	RunClientScript("gun_battery_burst", batt, gunnum, true);
end
-- ===================================== FLOCKS
function look_at_test_flocks_burgertown():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_look_bt_2, 300, 13) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function look_at_test_flocks_intro():void
	repeat
		if	(	volume_test_players_all_lookat(VOLUMES.tv_look_bt, 200, 15) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end

function tow_test_mall_flock_create_all():void
	flock_create("flock_bt_amber_arb");
	flock_create("flock_bt_amber_cov");
	flock_create("flock_bt_blue_cov");
	flock_create("flock_bt_blue_arb");
	flock_create("flock_bt_green_cov");
	flock_create("flock_bt_green_arb");
	flock_create("flock_bt_orange_cov");
	flock_create("flock_bt_orange_arb");
	flock_create("flock_bt_red_cov");
	flock_create("flock_bt_red_arb");
	flock_create("flock_bt_yellow_cov");
	flock_create("flock_bt_yellow_arb");
	flock_create("flock_seraph_arb_1");
	flock_create("flock_seraph_cov_1");
	Sleep(3);
	flock_start("flock_bt_amber_arb");
	flock_start("flock_bt_amber_cov");
	flock_start("flock_bt_blue_cov");
	flock_start("flock_bt_blue_arb");
	flock_start("flock_bt_green_cov");
	flock_start("flock_bt_green_arb");
	flock_start("flock_bt_orange_cov");
	flock_start("flock_bt_orange_arb");
	flock_start("flock_bt_red_cov");
	flock_start("flock_bt_red_arb");
	flock_start("flock_bt_yellow_cov");
	flock_start("flock_bt_yellow_arb");
	flock_start("flock_seraph_arb_1");
	flock_start("flock_seraph_cov_1");
end
function tow_test_mall_flock_delete_all():void
	flock_delete("flock_bt_amber_arb");
	flock_delete("flock_bt_amber_cov");
	flock_delete("flock_bt_blue_cov");
	flock_delete("flock_bt_blue_arb");
	flock_delete("flock_bt_green_cov");
	flock_delete("flock_bt_green_arb");
	flock_delete("flock_bt_orange_cov");
	flock_delete("flock_bt_orange_arb");
	flock_delete("flock_bt_red_cov");
	flock_delete("flock_bt_red_arb");
	flock_delete("flock_bt_yellow_cov");
	flock_delete("flock_bt_yellow_arb");
	flock_delete("flock_seraph_arb_1");
	flock_delete("flock_seraph_cov_1");
end
function flock_cull_intro_when_no_one_is_looking():void
	SleepUntil([| volume_test_players(VOLUMES.tv_comp_intro_1) ], 2);
	SleepUntil([|	volume_test_players_all_lookat(VOLUMES.tv_look_bt, 200, 15) ], 5);
	CreateThread(flock_intro_cull_client);
end
function flock_cull_burgertown_when_no_one_is_looking_part_1():void
	SleepUntil([| volume_test_players(VOLUMES.tv_burgertown_objcon_20) ], 2);
	SleepUntil([|	volume_test_players_lookat(VOLUMES.tv_look_bt_2, 300, 13) ], 5);
	CreateThread(flock_burgertown_cull_20_client);
end
function flock_cull_objcon_30():void																		-- do we still need?
	SleepUntil([| volume_test_players(VOLUMES.tv_burgertown_objcon_30) ], 3);
	CreateThread(flock_burgertown_cull_30_client);
end
function flock_cull_objcon_50():void
	SleepUntil([| volume_test_players(VOLUMES.tv_burgertown_objcon_50) ], 3);
	CreateThread(flock_burgertown_cull_50_client); 
end

--[[
 ██████╗ ██████╗ ███╗   ███╗██████╗  ██████╗ ███████╗██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
██╔════╝██╔═══██╗████╗ ████║██╔══██╗██╔═══██╗██╔════╝██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
██║     ██║   ██║██╔████╔██║██████╔╝██║   ██║███████╗██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║   ██║╚════██║██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ╚██████╔╝███████║██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- compositions
--]]

function intro_composition_listener_1():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_comp_intro_1)], 1);
	CreateThread(play_intro_armada_composition);
end
function intro_composition_listener_2():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_comp_intro_2)], 1);
	CreateThread(play_dogfight_2_composition);
	print("AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
end
function play_dogfight_1_composition():void
	comp_dogfight_1	= composer_play_show("vin_tsunami_dogfight_01");
--	Have this placed around ‘Space for Rent’ area for temp.
--	We can move it with the CutSceneFlag: dogfight_01_flag
end
function play_dogfight_2_composition():void
	comp_dogfight_2 = composer_play_show("vin_tsunami_dogfight_02");
	print("PLAYING DOGFIGHT2");
--	I’d like this to play just as the player sees Arbiter forces entering the fray. 
--	CutSceneFlag: dogfight_02_flag
end
function play_elite_turret_composition():void
	comp_elite_turret = composer_play_show("vin_tsunami_elite_turret");
--	Added Elite standing next to the first turret, barking orders.
--	Also a global animation added to the pre-battle Elite composition.
--	Instance needs to be added to the main scenario.
end
function play_intro_armada_composition():void
	comp_intro_armada = composer_play_show("vin_tsunami_landing");
--	This is the primary Theater of War composition. Has octopi driving 
--	Capitol ships towards the player, eventually ending in a looping idle.
end
function debug_counter():void
	local num:number = 0;
	repeat
		print(num);
		num = num + 1;
		sleep_s(1);
	until(false)
end
function play_random_slipspacers_composition():void
	comp_random_slipspacers = composer_play_show("vin_tsunami_landing_randcrusiers");
--	Simple, single octopus/cruiser animation to be instanced randomly.
--	These will be the additional cruisers slipspacing in. 
end
function play_phantom_crash_composition():void
	comp_phantom_crash	= composer_play_show("vin_tsunami_phantom_crash_01");
--	Made a couple of first pass Phantoms crashing. At the moment 
--	they’re sharing a composition, but we can split them up if necessary. 
end
function play_precombat_grunt_composition():void
	comp_precombat_grunt = composer_play_show("pre_combat_grunt");
--	E:\Corinth\Osiris\Main\tags\compositions\vignettes\w2_tsunaimi_station\w2_tsunami_pre_combat\pre_combat_grunt\pre_combat_grunt.composition
end
function play_precombat_jackal_composition():void
	comp_precombat_jackal = composer_play_show("pre_combat_jackal");
--	E:\Corinth\Osiris\Main\tags\compositions\vignettes\w2_tsunaimi_station\w2_tsunami_pre_combat\pre_combat_jackal\pre_combat_jackal.composition
end
function play_precombat_elite_composition():void
	comp_precombat_elite = composer_play_show("pre_combat_elite");
--	\compositions\vignettes\w2_tsunaimi_station\w2_tsunami_pre_combat\pre_combat_elite\pre_combat_elite.composition
end

--[[
-- From Jeff P:
//depot/Osiris/Main/tags/levels/campaignworld020/w2_tsunami_locke/fx/theater/arb_dummy_firing_spray.effect
//depot/Osiris/Main/tags/levels/campaignworld020/w2_tsunami_locke/fx/theater/arb_dummy_firing_straight.effect
//depot/Osiris/Main/tags/levels/campaignworld020/w2_tsunami_locke/fx/theater/cov_dummy_firing_spray.effect
//depot/Osiris/Main/tags/levels/campaignworld020/w2_tsunami_locke/fx/theater/cov_dummy_firing_straight.effect
-- older:
-- TAG('objects\vehicles\human\turrets\storm_unsc_artillery\weapon\fx\dummy_firing.effect')
-- TAG('objects\vehicles\human\turrets\storm_unsc_artillery\weapon\fx\dummy_firing_blue.effect')
--  e:\corinth\osiris\main\tags\objects\vehicles\human\turrets\storm_unsc_artillery\weapon\fx\dummy_firing.effect
--  e:\corinth\osiris\main\tags\objects\vehicles\human\turrets\storm_unsc_artillery\weapon\fx\dummy_firing_blue.effect
--]]
function boid_counter():void
	repeat
		print(" boidcount == ", flock_get_boid_count_total());
		sleep_s(.5);
	until(false);
end

-- ===================================== FLOCKS\client Start:
function flock_intro_client():void
	print("start intro flocks");

	flock_create("flock_lz1_arb1");
	flock_create("flock_lz1_cov1");

	flock_create("flock_lz2_arb1");
	flock_create("flock_lz2_cov1");

	flock_create("flock_lz3_arb1");
	flock_create("flock_lz3_cov1");

	Sleep(4);

	flock_start("flock_lz1_arb1");
	flock_start("flock_lz1_cov1");

	flock_start("flock_lz2_arb1");
	flock_start("flock_lz2_cov1");

	flock_start("flock_lz3_arb1");
	flock_start("flock_lz3_cov1");

	sleep_s(1);
end
function flock_burgertown_client():void
	-- broad triangular pattern, 40% off the horizon
	-- provides bulk
	flock_create("flock_bt_amber_arb");
	flock_create("flock_bt_amber_cov");
--	overhead, fragile, just beyond gamespace structures
--  good occasional swoop lows 
	flock_create("flock_bt_blue_cov");
	flock_create("flock_bt_blue_arb");	
-- triangle over gamepsace structures, sturdy 
-- helps those airspaces appear not empty
	flock_create("flock_bt_green_cov");
	flock_create("flock_bt_green_arb");
--	action tangle in burgertown vista foreground
--  was dipping below waterplane and through vista buildings
	flock_create("flock_bt_orange_cov");
	flock_create("flock_bt_orange_arb");
-- high population
-- parallel strafe tracks x 2
-- up-close shoot n explode
	flock_create("flock_bt_red_cov");
	flock_create("flock_bt_red_arb");
-- high population
-- parallel strafe tracks x 2
-- up-close shoot n explode
	flock_create("flock_bt_yellow_cov");
	flock_create("flock_bt_yellow_arb");	
	-- crisscrossing on 5 linear routes
	flock_create("flock_seraph_arb_1");
	flock_create("flock_seraph_cov_1");
	
	Sleep(2);
	flock_start("flock_bt_amber_arb");
	flock_start("flock_bt_amber_cov");
	flock_start("flock_bt_blue_cov");
	flock_start("flock_bt_blue_arb");
	flock_start("flock_bt_green_cov");
	flock_start("flock_bt_green_arb");
	flock_start("flock_bt_orange_cov");
	flock_start("flock_bt_orange_arb");
	flock_start("flock_bt_red_cov");
	flock_start("flock_bt_red_arb");
	flock_start("flock_bt_yellow_cov");
	flock_start("flock_bt_yellow_arb");
	flock_start("flock_seraph_arb_1");
	flock_start("flock_seraph_cov_1");
end
function flock_bt_tangle_transition():void
	SleepUntil([|volume_test_players(VOLUMES.tv_burgertown_objcon_30)], 3);
	flock_create("flock_mall_transition_a");
	Sleep(2);
	flock_start("flock_mall_transition_a");
	SleepUntil([|volume_test_players(VOLUMES.tv_tangletown_entrance)], 3);
	flock_stop("flock_mall_transition_a");
end
function flock_tangletown_client():void		-- called at start of tangletown
	flock_create("flock_tt_amber_arb");
	flock_create("flock_tt_amber_cov");
	flock_create("flock_tt_aqua_arb");
	flock_create("flock_tt_aqua_cov");
	flock_create("flock_tt_blue_arb");
	flock_create("flock_tt_blue_cov");
	flock_create("flock_tt_green_arb");
	flock_create("flock_tt_green_cov");
	flock_create("flock_tt_lime_arb");
	flock_create("flock_tt_lime_cov");
	flock_create("flock_tt_orange_arb");
	flock_create("flock_tt_orange_cov");
	flock_create("flock_tt_red_arb");
	flock_create("flock_tt_red_cov");
	flock_create("flock_tt_yellow_arb");
	flock_create("flock_tangle_seraph_1");
	flock_create("flock_tangle_seraph_2");
	Sleep(4);
	flock_start("flock_tt_amber_arb");
	flock_start("flock_tt_amber_cov");
	flock_start("flock_tt_aqua_arb");
	flock_start("flock_tt_aqua_cov");
	flock_start("flock_tt_blue_arb");
	flock_start("flock_tt_blue_cov");
	flock_start("flock_tt_green_arb");
	flock_start("flock_tt_green_cov");
	flock_start("flock_tt_lime_arb");
	flock_start("flock_tt_lime_cov");
	flock_start("flock_tt_orange_arb");
	flock_start("flock_tt_orange_cov");
	flock_start("flock_tt_red_arb");
	flock_start("flock_tt_red_cov");
	flock_start("flock_tt_yellow_arb");
	flock_start("flock_tangle_seraph_1");
	flock_start("flock_tangle_seraph_2");
	sleep_s(1);
end
function flock_turrettown_client():void		-- called at start of turrettown
	-- sky mass, spread broadly
	-- above vista structures in direction AA guns are firing
	-- 12 to 20 boids per flock
	flock_create("flock_trt_arb01");
	flock_create("flock_trt_cov01");
	-- cockeyed triangle pattern
	-- swoops over AA fire
	-- 12 to 20 boids per flock
	flock_create("flock_trt_arb02");
	flock_create("flock_trt_cov02");
	-- linear paths
	-- near gamespace
	-- 5-10
	flock_create("flock_trt_arb03");
	flock_create("flock_trt_cov03");
	Sleep(4);
	flock_start("flock_trt_arb01");
	flock_start("flock_trt_cov01");
	flock_start("flock_trt_arb02");
	flock_start("flock_trt_cov02");
	flock_start("flock_trt_arb03");
	flock_start("flock_trt_cov03");
end
function flock_underbelly_client():void
	flock_create ("flock_ub1_arb_left");
	flock_create ("flock_ub1_arb_left_rev");
	flock_create ("flock_ub1_cov_left");
	flock_create ("flock_ub1_cov_left_rev");
	flock_create ("flock_ub1_arb_right");
	flock_create ("flock_ub1_arb_rightrev");
	flock_create ("flock_ub1_cov_right");
	flock_create ("flock_ub1_cov_rightrev");
	Sleep(2);
	flock_start ("flock_ub1_arb_left");
	flock_start ("flock_ub1_arb_left_rev");
	flock_start ("flock_ub1_cov_left");
	flock_start ("flock_ub1_cov_left_rev");
	flock_start ("flock_ub1_arb_right");
	flock_start ("flock_ub1_arb_rightrev");
	flock_start ("flock_ub1_cov_right");
	flock_start ("flock_ub1_cov_rightrev");
end
function flock_underbelly1_kill_sequence():void
	SleepUntil ([|		volume_test_players(VOLUMES.tv_greenplat_50)], 5);
	flock_stop ("flock_ub1_arb_right");
	flock_stop ("flock_ub1_arb_rightrev");
	flock_stop ("flock_ub1_cov_right");
	flock_stop ("flock_ub1_cov_rightrev");


	SleepUntil ([|		volume_test_players(VOLUMES.tv_spirit_unload)], 5);
	flock_stop ("flock_ub1_arb_left");
	flock_stop ("flock_ub1_arb_left_rev");
	flock_stop ("flock_ub1_cov_left");
	flock_stop ("flock_ub1_cov_left_rev");

	SleepUntil ([|		volume_test_players(VOLUMES.tv_ub2_spawn)], 5);
	-- these clip through geo in ub2, "stop" should've handled it by now, but just in case:
	flock_delete ("flock_ub1_arb_right");
	flock_delete ("flock_ub1_arb_rightrev");
	flock_delete ("flock_ub1_cov_right");
	flock_delete ("flock_ub1_cov_rightrev");
end
function flock_underbelly_2():void
	flock_create ("flock_ub2_arb_right");
	flock_create ("flock_ub2_cov_right");
	flock_create ("flock_ub2_arb_left");
	flock_create ("flock_ub2_cov_left");
	Sleep(2);
	flock_start ("flock_ub2_arb_right");
	flock_start ("flock_ub2_cov_right");
	flock_start ("flock_ub2_arb_left");
	flock_start ("flock_ub2_cov_left");
end
function flock_underbelly_2_remove():void
	flock_stop ("flock_ub2_arb_right");
	flock_stop ("flock_ub2_cov_right");
	flock_stop ("flock_ub2_arb_left");
	flock_stop ("flock_ub2_cov_left");
	Sleep(2);
	flock_delete ("flock_ub2_arb_right");
	flock_delete ("flock_ub2_cov_right");
	flock_delete ("flock_ub2_arb_left");
	flock_delete ("flock_ub2_cov_left");
end
function flock_seraph_blast_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_seraph_blast)], 5);
	CreateThread(flock_seraph_blast);
end
function flock_seraph_blast():void
	flock_create ("flock_ub2_seraphs");
	flock_create ("flock_ub2_seraphs_2");
	flock_create ("flock_ub2_seraphs_3");
	Sleep(2);
	flock_start ("flock_ub2_seraphs");
	flock_start ("flock_ub2_seraphs_2");
	flock_start ("flock_ub2_seraphs_3");
	sleep_s(2.2);
	RunClientScript ("start_global_rumble_shake_small", .75);
	sleep_s(.3);
	flock_stop("flock_ub2_seraphs");
	flock_stop("flock_ub2_seraphs_2");
	flock_stop("flock_ub2_seraphs_3");
	sleep_s(.45);
	RunClientScript ("start_global_rumble_shake_medium", 1.5);
	sleep_s(1.5);
	RunClientScript ("start_global_rumble_shake_small", .75);
end
function ffflock():void
	flock_create ("flock_ff_arb01");
	flock_create ("flock_ff_arb02");
	flock_create ("flock_ff_cov01");
	flock_create ("flock_ff_cov02");
	flock_create ("flock_seraph_ff_arb01");
	flock_create ("flock_seraph_ff_cov01");
	Sleep(2);
	flock_start ("flock_ff_arb01");
	flock_start ("flock_ff_arb02");
	flock_start ("flock_ff_cov01");
	flock_start ("flock_ff_cov02");
	flock_start ("flock_seraph_ff_arb01");
	flock_start ("flock_seraph_ff_cov01");
end
function foffflock():void
	flock_stop ("flock_ff_arb01");
	flock_stop ("flock_ff_arb02");
	flock_stop ("flock_ff_cov01");
	flock_stop ("flock_ff_cov02");
	flock_stop ("flock_seraph_ff_arb01");
	flock_stop ("flock_seraph_ff_cov01");
	Sleep(2);
	flock_delete ("flock_ff_arb01");
	flock_delete ("flock_ff_arb02");
	flock_delete ("flock_ff_cov01");
	flock_delete ("flock_ff_cov02");
	flock_delete ("flock_seraph_ff_arb01");
	flock_delete ("flock_seraph_ff_cov01");
end
-- =========================================================Flocks\client stop:

function flock_intro_cull_client():void
	print("cull intro flocks");
	flock_stop("flock_lz1_arb1");
	flock_stop("flock_lz2_arb1");
	flock_stop("flock_lz3_arb1");
	flock_stop("flock_lz1_cov1");
	flock_stop("flock_lz2_cov1");
	flock_stop("flock_lz3_cov1");
	Sleep(6);
	flock_delete("flock_lz1_arb1");
	flock_delete("flock_lz2_arb1");
	flock_delete("flock_lz3_arb1");
	flock_delete("flock_lz1_cov1");
	flock_delete("flock_lz2_cov1");
	flock_delete("flock_lz3_cov1");
end
function flock_burgertown_cull_20_client():void			-- objcon20
	flock_stop("flock_bt_orange_cov");
	flock_stop("flock_bt_red_cov");
	flock_stop("flock_bt_yellow_cov");
end
function flock_burgertown_cull_30_client():void			-- objcon30
	flock_delete("flock_bt_orange_cov");
	flock_delete("flock_bt_red_cov");
	flock_delete("flock_bt_yellow_cov");
end
function flock_burgertown_cull_50_client():void			-- objcon50
	flock_stop("flock_seraph_arb_1");
	flock_stop("flock_seraph_cov_1");
	sleep_s(12);
	flock_delete("flock_seraph_arb_1");
	flock_delete("flock_seraph_cov_1");
end
function flock_burgertown_final_cull_client():void		-- called at start of turrettown
	flock_stop("flock_bt_amber_arb");
	flock_stop("flock_bt_amber_cov");
	flock_stop("flock_bt_blue_cov");
	flock_stop("flock_bt_blue_arb");
	flock_stop("flock_bt_green_cov");
	flock_stop("flock_bt_green_arb");
	flock_stop("flock_bt_orange_cov");
	flock_stop("flock_bt_orange_arb");
	flock_stop("flock_bt_red_cov");
	flock_stop("flock_bt_red_arb");
	flock_stop("flock_bt_yellow_cov");
	flock_stop("flock_bt_yellow_arb");
	flock_stop("flock_seraph_arb_1");
	flock_stop("flock_seraph_cov_1");
	sleep_s(10);	
	flock_delete("flock_bt_amber_arb");
	flock_delete("flock_bt_amber_cov");
	flock_delete("flock_bt_blue_cov");
	flock_delete("flock_bt_blue_arb");
	flock_delete("flock_bt_green_cov");
	flock_delete("flock_bt_green_arb");
	flock_delete("flock_bt_orange_cov");
	flock_delete("flock_bt_orange_arb");
	flock_delete("flock_bt_red_cov");
	flock_delete("flock_bt_red_arb");
	flock_delete("flock_bt_yellow_cov");
	flock_delete("flock_bt_yellow_arb");
	flock_delete("flock_seraph_arb_1");
	flock_delete("flock_seraph_cov_1");
end
function flock_burgertown_delete_client():void
	flock_delete("flock_bt_amber_arb");
	flock_delete("flock_bt_amber_cov");
	flock_delete("flock_bt_blue_cov");
	flock_delete("flock_bt_blue_arb");
	flock_delete("flock_bt_green_cov");
	flock_delete("flock_bt_green_arb");
	flock_delete("flock_bt_orange_cov");
	flock_delete("flock_bt_orange_arb");
	flock_delete("flock_bt_red_cov");
	flock_delete("flock_bt_red_arb");
	flock_delete("flock_bt_yellow_cov");
	flock_delete("flock_bt_yellow_arb");
	flock_delete("flock_seraph_arb_1");
	flock_delete("flock_seraph_cov_1");
end
function flock_tangletown_progress_cull_1():void
	flock_stop("flock_tt_amber_cov");
	flock_stop("flock_tt_aqua_cov");
	flock_stop("flock_tt_orange_cov");
	flock_stop("flock_tangle_seraph_1");
	flock_stop("flock_tangle_seraph_2");
end

function flock_tangletown_final_cull_client():void			-- called at start of turrettown
	flock_stop("flock_tt_amber_arb");
	flock_stop("flock_tt_amber_cov");
	flock_stop("flock_tt_aqua_arb");
	flock_stop("flock_tt_aqua_cov");
	flock_stop("flock_tt_blue_arb");
	flock_stop("flock_tt_blue_cov");
	flock_stop("flock_tt_green_arb");
	flock_stop("flock_tt_green_cov");
	flock_stop("flock_tt_lime_arb");
	flock_stop("flock_tt_lime_cov");
	flock_stop("flock_tt_orange_arb");
	flock_stop("flock_tt_orange_cov");
	flock_stop("flock_tt_red_arb");
	flock_stop("flock_tt_red_cov");
	flock_stop("flock_tt_yellow_arb");
	flock_stop("flock_tangle_seraph_1");
	flock_stop("flock_tangle_seraph_2");
	sleep_s(6);
	flock_delete("flock_tt_amber_arb");
	flock_delete("flock_tt_amber_cov");
	flock_delete("flock_tt_aqua_arb");
	flock_delete("flock_tt_aqua_cov");
	flock_delete("flock_tt_blue_arb");
	flock_delete("flock_tt_blue_cov");
	flock_delete("flock_tt_green_arb");
	flock_delete("flock_tt_green_cov");
	flock_delete("flock_tt_lime_arb");
	flock_delete("flock_tt_lime_cov");
	flock_delete("flock_tt_orange_arb");
	flock_delete("flock_tt_orange_cov");
	flock_delete("flock_tt_red_arb");
	flock_delete("flock_tt_red_cov");
	flock_delete("flock_tt_yellow_arb");
	flock_delete("flock_tangle_seraph_1");
	flock_delete("flock_tangle_seraph_2");
end
function flock_turrettown_progress_cull_a():void
	flock_stop("flock_trt_cov02");					-- swoop cov
end
function flock_turrettown_progress_cull_b():void
	flock_stop("flock_trt_cov01");					-- bulk cov
end
function flock_turrettown_progress_cull_c():void
	flock_stop("flock_trt_cov03");					-- near cov
	flock_stop("flock_trt_arb02");					-- swoop arb
end
function flock_turrettown_progress_cull_d():void
	flock_stop("flock_trt_arb03");					-- near arb
end
function flock_turrettown_final_cull_client():void
	flock_stop("flock_trt_arb01");
	flock_stop("flock_trt_arb02");
	flock_stop("flock_trt_cov01");
	flock_stop("flock_trt_cov02");
	Sleep(4);
	flock_delete("flock_trt_arb01");
	flock_delete("flock_trt_arb02");
	flock_delete("flock_trt_cov01");
	flock_delete("flock_trt_cov02");
end
function flock_ongoing_final_cull_client():void	
	flock_stop("flock_trt_arb01");
	flock_stop("flock_cu_arb01");
	flock_stop("flock_cu_arb02");
	flock_stop("flock_cu_arb03");
	flock_stop("flock_cu_cov01");
	flock_stop("flock_cu_cov02");
	flock_stop("flock_cu_cov03");
	Sleep(4);
	flock_delete("flock_trt_arb01");
	flock_delete("flock_cu_arb01");
	flock_delete("flock_cu_arb02");
	flock_delete("flock_cu_arb03");
	flock_delete("flock_cu_cov01");
	flock_delete("flock_cu_cov02");
	flock_delete("flock_cu_cov03");
end
function flock_underbelly_cull_client():void

	Sleep(4);

end
function aa_fx_sequence_intro():void
	CreateEffectGroup(EFFECTS.aa_intro_01);
	CreateEffectGroup(EFFECTS.aa_intro_02);
	CreateEffectGroup(EFFECTS.aa_intro_03);
	CreateEffectGroup(EFFECTS.aa_intro_04);
	CreateEffectGroup(EFFECTS.aa_intro_05);
	CreateEffectGroup(EFFECTS.aa_intro_06);
	CreateEffectGroup(EFFECTS.aa_intro_07);

	SleepUntil(		[| object_get_health(OBJECTS.shrike_power_source_0) <= .05 
					or object_get_health(OBJECTS.dm_shriketurret_00) <= 0
					or IsGoalActive(w2_tsunami_station.goal_start) == false
					], 5);
	-- first wave of cleanup:
	StopEffectGroup(EFFECTS.aa_intro_01);
	StopEffectGroup(EFFECTS.aa_intro_04);
	StopEffectGroup(EFFECTS.aa_intro_05);
	SleepUntil([|	volume_test_players_all(VOLUMES.tv_burgertown_all)
				or	battery_1 == 1
				or	IsGoalActive(w2_tsunami_station.goal_start) == false
				],	5);
	
	StopEffectGroup(EFFECTS.aa_intro_02);
	StopEffectGroup(EFFECTS.aa_intro_03);
	StopEffectGroup(EFFECTS.aa_intro_06);
	StopEffectGroup(EFFECTS.aa_intro_07);
	sleep_s(6);
	KillEffectGroup(EFFECTS.aa_intro_01);
	KillEffectGroup(EFFECTS.aa_intro_04);
	KillEffectGroup(EFFECTS.aa_intro_05);
	KillEffectGroup(EFFECTS.aa_intro_02);
	KillEffectGroup(EFFECTS.aa_intro_03);
	KillEffectGroup(EFFECTS.aa_intro_06);
	KillEffectGroup(EFFECTS.aa_intro_07);
end
function aa_fx_sequence_brgr():void
	CreateThread(aa_fx_sequence_brgr_pt_2);
	CreateEffectGroup(EFFECTS.aa_brgr_01);
	CreateEffectGroup(EFFECTS.aa_brgr_02);
	CreateEffectGroup(EFFECTS.aa_brgr_03);
	CreateEffectGroup(EFFECTS.aa_brgr_04);
	CreateEffectGroup(EFFECTS.aa_brgr_05);
	CreateEffectGroup(EFFECTS.aa_brgr_06);
	SleepUntil(		[| object_get_health(OBJECTS.shrike_power_source_1) <= .05 
					or object_get_health(OBJECTS.dm_shriketurret_01) <= 0
					or volume_test_players (VOLUMES.tv_burgertown_objcon_30)
					or IsGoalActive(w2_tsunami_station.goal_burgertown) == false
					], 5);
	-- first wave of cleanup:
	StopEffectGroup(EFFECTS.aa_brgr_04);
	StopEffectGroup(EFFECTS.aa_brgr_05);
	StopEffectGroup(EFFECTS.aa_brgr_06);
	SleepUntil(		[| volume_test_players(VOLUMES.tv_burgertown_complete)
					or IsGoalActive(w2_tsunami_station.goal_burgertown) == false
					], 5);
	StopEffectGroup(EFFECTS.aa_brgr_01);
	StopEffectGroup(EFFECTS.aa_brgr_02);
	StopEffectGroup(EFFECTS.aa_brgr_03);
	sleep_s(6);
	KillEffectGroup(EFFECTS.aa_brgr_02);
	KillEffectGroup(EFFECTS.aa_brgr_01);
	KillEffectGroup(EFFECTS.aa_brgr_04);
	KillEffectGroup(EFFECTS.aa_brgr_05);
	KillEffectGroup(EFFECTS.aa_brgr_06);
	KillEffectGroup(EFFECTS.aa_brgr_03);
end
function aa_fx_sequence_tngl():void

	CreateEffectGroup(EFFECTS.aa_tngl_01);
	CreateEffectGroup(EFFECTS.aa_tngl_02);
	CreateEffectGroup(EFFECTS.aa_tngl_03);
	CreateEffectGroup(EFFECTS.aa_tngl_04);
	CreateEffectGroup(EFFECTS.aa_tngl_05);

	SleepUntil(		[| object_get_health(OBJECTS.shrike_power_source_2) <= .05 
					or object_get_health(OBJECTS.dm_shriketurret_02) <= 0
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 5);
	-- first wave of cleanup:
	StopEffectGroup(EFFECTS.aa_tngl_03);
	StopEffectGroup(EFFECTS.aa_tngl_04);
	SleepUntil (	[|	volume_test_players (VOLUMES.tv_end_tangletown)
					or IsGoalActive(w2_tsunami_station.goal_tangletown) == false
					], 3);
	StopEffectGroup(EFFECTS.aa_tngl_05);
	StopEffectGroup(EFFECTS.aa_tngl_01);
	StopEffectGroup(EFFECTS.aa_tngl_02);
	sleep_s(6);
	KillEffectGroup(EFFECTS.aa_tngl_03);
	KillEffectGroup(EFFECTS.aa_tngl_04);
	KillEffectGroup(EFFECTS.aa_tngl_05);
	KillEffectGroup(EFFECTS.aa_tngl_01);
	KillEffectGroup(EFFECTS.aa_tngl_02);
end
function aa_fx_sequence_brgr_pt_2():void
	SleepUntil(	[|	volume_test_players (VOLUMES.tv_burgertown_objcon_30)
					or IsGoalActive(w2_tsunami_station.goal_burgertown) == false
				],	5);
	CreateEffectGroup(EFFECTS.aa_brgr_b_01);
	CreateEffectGroup(EFFECTS.aa_brgr_b_02);
	SleepUntil(	[|	volume_test_players (VOLUMES.tv_end_tangletown)
					or	(	IsGoalActive(w2_tsunami_station.goal_burgertown) == false
						and	IsGoalActive(w2_tsunami_station.goal_tangletown) == false)
				], 5);
	StopEffectGroup(EFFECTS.aa_brgr_b_01);
	StopEffectGroup(EFFECTS.aa_brgr_b_02);
	KillEffectGroup(EFFECTS.aa_brgr_b_01);
	KillEffectGroup(EFFECTS.aa_brgr_b_02);
end


--## CLIENT
global AAFX:tag = TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_spray.effect');

-- ====================================== AA BATTERIES\client:
function remoteClient.gun_battery_burst(batt:number, gunnum:number, kill:boolean):void
	if (kill == true) then
			effect_kill_from_flag(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."a"]);
			effect_kill_from_flag(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."b"]);
			effect_kill_from_flag(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."c"]);
	else
		local dice:number = random_range(1,3);
		if(dice == 1)then
		effect_new(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."a"]);
		elseif(dice == 2)then
		effect_new(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."b"]);
		else 
		effect_new(AAFX, FLAGS["aa"..batt.."_p"..gunnum.."c"]);
		end
	end
end
--RunClientScript ("doomcruiser_fire");
function remoteClient.doomcruiser_fire():void
	print ("Play fx_dmg_smoke FX");
	effect_new_on_object_marker(TAG('levels/campaignworld020/w2_tsunami/fx/fire/cov_cruiser_fire.effect'), OBJECTS.doomcruiser, "fx_mid_top");
end
