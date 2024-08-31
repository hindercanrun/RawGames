--## SERVER

--[[
████████╗███████╗██╗   ██╗███╗   ██╗ █████╗ ███╗   ███╗██╗    ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
╚══██╔══╝██╔════╝██║   ██║████╗  ██║██╔══██╗████╗ ████║██║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
   ██║   ███████╗██║   ██║██╔██╗ ██║███████║██╔████╔██║██║    ███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║
   ██║   ╚════██║██║   ██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║    ╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
   ██║   ███████║╚██████╔╝██║ ╚████║██║  ██║██║ ╚═╝ ██║██║    ███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                                                      
██████╗ ██╗     ██╗███╗   ██╗██╗  ██╗███████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗                         
██╔══██╗██║     ██║████╗  ██║██║ ██╔╝██╔════╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝                         
██████╔╝██║     ██║██╔██╗ ██║█████╔╝ ███████╗    ███████╗██║     ██████╔╝██║██████╔╝   ██║                            
██╔══██╗██║     ██║██║╚██╗██║██╔═██╗ ╚════██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║                            
██████╔╝███████╗██║██║ ╚████║██║  ██╗███████║    ███████║╚██████╗██║  ██║██║██║        ██║                            
╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝                            
Tsunami Station Blinks
------------------------------------------------------------------------------------
--]]
global b_underbelly1_blink: boolean = false;


--					BLINKS FOR ALL TO ENJOY.

function blink_start():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Mission Start");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_start", FLAGS.fl_bl_start_1);
end

function blink_burgertown():void
	CreateThread(audio_tsunami_stopallmusic);
	CreateThread(track_burgertown);
	ai_erase_all();
	print ("teleport: Burger Town");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_burgertown", FLAGS.fl_bl_burgertown_1);
end

function blink_tangletown():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Tangle Town");
	NarrativeQueue.Kill()
	GoalBlink (w2_tsunami_station, "goal_tangletown", FLAGS.fl_tangle_1);
	switch_zone_set(ZONE_SETS.w2_tsunami_burgertown);
	Sleep(10);
	object_destroy (OBJECTS.shrike_power_source_0);
	object_destroy (OBJECTS.shrike_power_source_1);
	v_shrike_tally = 1;
end

function blink_turrettown():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Turret Town");
	NarrativeQueue.Kill()
	GoalBlink (w2_tsunami_station, "goal_turrettown", FLAGS.fl_bl_turrettown_1);
	object_destroy (OBJECTS.shrike_power_source_0);
	object_destroy (OBJECTS.shrike_power_source_1);
	object_destroy (OBJECTS.shrike_power_source_2);
	v_shrike_tally = 2;
	CreateThread(tow_test_mall_flock_delete_all);
end

function blink_windows():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Turret Town: Window(s) Edition");
	NarrativeQueue.Kill()
	GoalBlink (w2_tsunami_station, "goal_turrettown", FLAGS.fl_tp_windows);
	CreateThread(tow_test_mall_flock_delete_all);
	object_destroy (OBJECTS.shrike_power_source_0);
	object_destroy (OBJECTS.shrike_power_source_1);
	object_destroy (OBJECTS.shrike_power_source_2);
	v_shrike_tally = 2;
end

function blink_trans_underbelly():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Transition to Underbelly");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_trans_underbelly", FLAGS.fl_bl_trans_underbelly_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_underbelly1():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Underbelly 1");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_underbelly_1", FLAGS.fl_bl_underbelly1_1);
	device_set_position_immediate (OBJECTS.dm_elev_1, 1);
	b_underbelly1_blink = true;
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_underbelly2():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Underbelly 2");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_underbelly_2", FLAGS.fl_bl_underbelly2_1);
	CreateThread(underbelly_create_crates);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_trans_arcade():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Transition to arcade");
	NarrativeQueue.Kill()
	kill_volume_disable(VOLUMES.playerkill_watervolume);
	GoalBlink (w2_tsunami_station, "goal_trans_arcade", FLAGS.fl_bl_trans_arcade_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_arcade():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	device_set_position_immediate (OBJECTS.dm_elev_2, 1);
	print ("teleport: arcade");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_arcade", FLAGS.fl_bl_arcade_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_destruction():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Destruction Alley");
	NarrativeQueue.Kill()
	GoalBlink (w2_tsunami_station, "goal_destructionalley", FLAGS.fl_bl_destruction_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_building():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Destroyed Building Interior");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_bldg_interior", FLAGS.fl_bl_building_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_trans_final():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Transition to Final Fight");
	NarrativeQueue.Kill()
	GoalBlink (w2_tsunami_station, "goal_trans_final", FLAGS.fl_bl_trans_final_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_finalfight():void
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	print ("teleport: Final Fight");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_finalfight", FLAGS.fl_bl_final_1);
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
end

function blink_demo_arcade():void
	CreateThread(demo_blink_setup);
	print("a");
	print ("teleport: e3 start");
	NarrativeQueue.Kill();
	print("b");
	GoalBlink(w2_tsunami_station, "goal_demo_arcade", FLAGS.fl_demo);
	print("c");
end
function blink_demo_interior():void
	CreateThread(demo_blink_setup);
	print ("teleport: demo interior");
	NarrativeQueue.Kill()
	GoalBlink(w2_tsunami_station, "goal_demo_interior", FLAGS.fl_demo_interior);
end
function blink_demo_fight():void
	CreateThread(demo_blink_setup);
	print ("teleport: demo fight");
	NarrativeQueue.Kill();
	GoalBlink(w2_tsunami_station, "goal_demo_fight", FLAGS.fl_demo_fight);
end
function demo_blink_setup():void
	v_is_demo = true;
--	force_player_nav_points_off = true;
	_G.cheat_deathless = 1;
--	_G.cheat_infinite_ammo = 1;
	--_G.cheat_bottomless_clip = 1;
	RunClientScript("demo_client_setup");
	if(IsPlayer(SPARTANS.buck))then
		object_create("mlrs");
		Sleep(1);
		unit_add_weapon(SPARTANS.buck, OBJECTS.mlrs, 4);		-- can't get to work on secondary weapon for some reason :\
	end
	CreateThread(demo_update_profiles);
	CreateThread(demo_dampen_all);
	CreateThread(clear_starting_tows);
	CreateThread(audio_tsunami_stopallmusic);
	ai_erase_all();
	CreateThread(tow_test_mall_flock_delete_all);
	CreateThread (turret_destroyer);
	ai_grenades(false);
--	effect_kill_object_marker(TAG('levels/campaignworld020/w2_tsunami/fx/vignettes/cruiser_tracer_distant_loop_02.effect'), OBJECTS.e3_arb_cap1_03, "fx_banshee_phaser_front_r");
end

--	--	--	--	--	--	Under the Hood	--	--	--	--	--	--	
function clear_starting_tows():void
	stop_valid_composition( var_tsunami_theater_intro );	
	stop_valid_composition( var_tsunami_theater_slip );	
	stop_valid_composition( var_tsunami_theater_turret );	
	stop_valid_composition( var_tsunami_theater_burger );	
	stop_valid_composition( var_cruiser_crash );	
end
function turret_destroyer():void
	if	(object_valid ("shrike_power_source_0"))	then
		object_destroy (OBJECTS.shrike_power_source_0);
	end
	if	(object_valid ("dm_shriketurret_00"))	then
		object_destroy (OBJECTS.dm_shriketurret_00);
	end
	if	(object_valid ("shrike_power_source_1"))	then
		object_destroy (OBJECTS.shrike_power_source_1);
	end
	if	(object_valid ("dm_shriketurret_01"))	then
		object_destroy (OBJECTS.dm_shriketurret_01);
	end
	if	(object_valid ("shrike_power_source_2"))	then
		object_destroy (OBJECTS.shrike_power_source_2);
	end
	if	(object_valid ("dm_shriketurret_02"))	then
		object_destroy (OBJECTS.dm_shriketurret_02);
	end
	if	(object_valid ("shrike_power_source_3"))	then
		object_destroy (OBJECTS.shrike_power_source_3);
	end
	if	(object_valid ("dm_shriketurret_03"))	then
		object_destroy (OBJECTS.dm_shriketurret_03);
	end
	if	(object_valid ("shrike_power_source_4"))	then
		object_destroy (OBJECTS.shrike_power_source_4);
	end
	if	(object_valid ("dm_shriketurret_04"))	then
		object_destroy (OBJECTS.dm_shriketurret_04);
	end
	if	(object_valid ("shrike_power_source_5"))	then
		object_destroy (OBJECTS.shrike_power_source_5);
	end
	if	(object_valid ("dm_shriketurret_05"))	then
		object_destroy (OBJECTS.dm_shriketurret_05);
	end
end

--## CLIENT
function remoteClient.demo_client_setup():void
	_G.cheat_deathless = 1;
--	_G.cheat_infinite_ammo = 1;
--	_G.cheat_bottomless_clip = 1;
end