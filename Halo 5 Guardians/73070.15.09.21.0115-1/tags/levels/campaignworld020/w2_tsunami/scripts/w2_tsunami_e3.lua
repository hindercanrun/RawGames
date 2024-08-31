--## SERVER
--[[ ---------------------------------------------------------------------------------------------- demo & e3
                         _______   ________  __       __   ______   
                        /       \ /        |/  \     /  | /      \  
 ____  ____  ____       $$$$$$$  |$$$$$$$$/ $$  \   /$$ |/$$$$$$  | 
/    |/    |/    |      $$ |  $$ |$$ |__    $$$  \ /$$$ |$$ |  $$ | 
$$$$/ $$$$/ $$$$/       $$ |  $$ |$$    |   $$$$  /$$$$ |$$ |  $$ | 
/    |/    |/    |      $$ |  $$ |$$$$$/    $$ $$ $$/$$ |$$ |  $$ | 
$$$$/ $$$$/ $$$$/       $$ |__$$ |$$ |_____ $$ |$$$/ $$ |$$ \__$$ | 
                        $$    $$/ $$       |$$ | $/  $$ |$$    $$/  
                        $$$$$$$/  $$$$$$$$/ $$/      $$/  $$$$$$/   
--]] ---------------------------------------------------------------------------------------------- demo & e3


-- THREADS:	
-- Putting many threads in variables so that they  
-- can be tracked and killed easily, so we can 
-- quickly reset sequences without a map reset.
global v_demo_thread_arcade_sequence:thread = nil;				 
global v_demo_arcade_vale_bunker_thread:thread = nil;
global v_demo_arcade_dogfight_thread:thread = nil;
global b_demo_shade_grunt_spawned:boolean = false;
global b_demo_arcade_start:boolean = false;
global b_demo_arcade_start_vale:boolean = false;
global b_demo_arcade_start_buck:boolean = false;
global var_tsunami_theater_arcade_e3 = -1;
global v_demo_thread_interior_sequence:thread = nil;				
global v_demo_soldier_thread:thread = nil;
global v_demo_pawn_room_thread:thread = nil;
global v_demo_knight_thread:thread = nil;
global v_practice_thread:thread = nil;

global v_demo_thread_fight_sequence:thread = nil;
global v_demo_pawns_thread:thread = nil;
global v_demo_soldiers_thread:thread = nil;
global v_demo_knights_thread:thread = nil;
global v_demo_pin:thread = nil;
-- COMPOSITIONS
global v_demo_arcade_wounded:number = nil;
global v_demo_arcade_bunker_comp:number = nil;
global v_demo_vtol_comp:number = nil;
global v_demo_soldier_comp:number = nil; 
global v_demo_condemned_comp:number = nil; 
global v_demo_condemned_grunty_comp:number = nil; 
global v_demo_knight_comp:number = nil;
global v_demo_warden:number = nil; 
global v_demo_bamf_comp:number = nil;
global v_interior_theater:number = nil;
-- OTHER
global v_damp:number = .7;												-- dampening factor
global b_demo_soldier:boolean = false;
global var_demo_fight_objcon:number = 0;
global b_pull_up:boolean = false;										-- set in slide comp, for e3 demo only (vo-related)
global b_vale_loop:boolean = false;										-- set in soldier comp, for e3 demo only (vo-related)
global b_destruction_e3_vo:boolean = false;								-- vo, destruction alley
global b_vtol_vo:boolean = false;										-- for vo in vtol segment
global b_soldier_vo:boolean = false;									-- soldier vo in composition
global var_e3_wounded_elite = false;
global var_e3_wounded_stairs_elite = false;
global b_heads_down:boolean = false;									-- vo
global b_condemned_endloop:boolean = false;
global b_condemned_faceloop:boolean = false;
global b_condemned_grunty_faceloop:boolean = false;
global b_knight_vale:boolean = false;
global b_knight_stuck:boolean = false;
global b_soldierstorm_1:boolean = false;
global b_soldierstorm_2:boolean = false;
--global b_landingpad_pulse_done:boolean = false;

-- Common Functions:
function demo():void
	blink_demo_arcade();
end
function isDemo():boolean
	return(v_is_demo);
end
function maybe_pin_texture():void
	if (v_demo_pin == nil)then
		v_demo_pin = CreateThread(pin_texture);
	end
end
function pin_texture():void
	repeat
		RunClientScript("client_pin_texture");
		Sleep(20);
	until(false)
end
function clear_demo_thread(thrd:thread):void
	if (thrd ~= nil)then
		KillThread(thrd);
		thrd = nil
	end
end
function demo_update_profiles():void
	player_set_profile(STARTING_PROFILES.demobuck, SPARTANS.buck);
	player_set_profile(STARTING_PROFILES.demolocke, SPARTANS.locke);
	unit_add_equipment( SPARTANS.buck, STARTING_PROFILES.demobuck, true, true);
	unit_add_equipment( SPARTANS.locke, STARTING_PROFILES.demolocke, true, true);
end
function demo_dampen_all():void
--	player_control_scale_all_input(v_damp, .1);
--	RunClientScript("client_dampen", v_damp);
	RunClientScript("client_dampen_player", v_damp);
end
--[[
function demo_dampen_all():void
	RunClientScript("client_dampen_player", v_damp, SPARTANS.vale);
	RunClientScript("client_dampen_player", v_damp, SPARTANS.tanaka);
	RunClientScript("client_dampen_player", v_damp, SPARTANS.buck);
end
--]]

function demo_undampen_all():void
	v_damp = 1;
	player_control_scale_all_input(1, .1);
	RunClientScript("client_undampen")
end
function damp_5():void
	v_damp = .5
end
function damp_6():void
	v_damp = .6
end
function damp_7():void
	v_damp = .7
end
function damp_8():void
	v_damp = .8
end
function damp_9():void
	v_damp = .9
end
function damp_1():void
	demo_undampen_all();
end
function damp_0():void
	demo_undampen_all();
end
function demo_ai_place_no_drops( demo_enemies:ai )
		ai_place( demo_enemies );
		unit_doesnt_drop_items(ai_actors( demo_enemies ));
end
function slip_space_spawn_no_drops( demo_enemies:ai )
		SlipSpaceSpawnBlocking(demo_enemies);
		Sleep(2);
		unit_doesnt_drop_items(ai_actors( demo_enemies ));
end
function demo_locke_scan():void
	composer_play_show("vin_e3_tracking", {scanner = SPARTANS.locke});
end
function kennysky():void
	CreateThread(clear_starting_tows);
	stop_valid_composition( v_interior_theater ); 
	Sleep(5);
	v_interior_theater = composer_play_show("vin_e3_interior_theater");
end
-- Objective Specific Functions:
--[[ 
 █████╗ ██████╗  ██████╗ █████╗ ██████╗ ███████╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝
███████║██████╔╝██║     ███████║██║  ██║█████╗  
██╔══██║██╔══██╗██║     ██╔══██║██║  ██║██╔══╝  
██║  ██║██║  ██║╚██████╗██║  ██║██████╔╝███████╗
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═════╝ ╚══════╝
--]]                                           

function demo_arcade_sequence():void														-- Main thread for the capture. Should have correct timing (eventually, when we get to that.)
		object_create_folder_anew(MODULES.demo_arcade);
		hud_show_navpoints ( false );
		ai_grenades(false);
		CreateThread(demo_tow_arcade_start);
		CreateThread(demo_replenish_ammo);
		CreateThread(maybe_pin_texture);
--		force_player_nav_points_off = true;
		v_demo_arcade_wounded = composer_play_show("vin_e3_wounded_cov");
		demo_arcade_fx_remove();
		demo_arcade_create_flocks();
		b_demo_arcade_start = false;
--		streamer_pin_tag(TAG('levels\assets\osiris\texture_tiles\sangheli\tsunami_station\tsun_metal_debris_a_control.bitmap'));
		if var_tsunami_theater_arcade then
			stop_valid_composition( var_tsunami_theater_arcade );
		end
		game_save_no_timeout();
		Sleep(2);
		var_tsunami_theater_arcade_e3 = composer_play_show( "vin_e3_arcade_theater" );
		CreateThread(demosys_thread_up_arcade_narrative);
		demo_arcade_set_start_positions();
		object_create_anew("demo_ar");
		CreateThread( demo_arcade_locke_start);
		CreateThread( demo_arcade_locke_start_vale);
		CreateThread( demo_arcade_locke_start_buck);
		CreateThread(arcade_snapshut);
		CreateThread(demo_wraith);
		CreateThread(demo_condemned);
		CreateThread(demo_shade);
		v_demo_arcade_dogfight_thread = CreateThread(demo_arcade_dogfight_listener);
--		demo_ai_place_no_drops(AI.demo_v2_greeters);
		RunClientScript("client_arcade_explosion", FLAGS.fl_demo_arcade_fx_3);
		SleepUntil( [| b_demo_arcade_start ] , 1 );
		sleep_s(.5);
		RunClientScript("client_arcade_explosion", FLAGS.fl_demo_arcade_fx_1);
		SleepUntil([| volume_test_players( VOLUMES.tv_demo_arcade_splosions)  ], 2);
		RunClientScript("client_arcade_explosion", FLAGS.fl_demo_arcade_fx_2);
		sleep_s(1);
		RunClientScript("client_arcade_explosion", FLAGS.fl_demo_arcade_fx_3);
		SleepUntil([| volume_test_objects(VOLUMES.tv_demo_undampen, SPARTANS.locke)], 1);
		CreateThread(demo_undampen_all);
		CreateThread(demo_fleebie_listener);
		CreateThread(demo_arcade_alliances);
--[[
		v_demo_arcade_vale_bunker_thread = CreateThread(demo_arcade_vale_bunker_listener);		-- sets up Vale's bunkering anim at the cover piece
		demo_ai_place_no_drops(AI.demo_arcade_phase1);
		demo_ai_place_no_drops(AI.demo_arcade_phase2);
	SleepUntil([| ai_living_count(AI.demo_arcade_phase1) <= 3 ], 10);
		demo_ai_place_no_drops(AI.demo_arcade_phase2b);
		demo_ai_place_no_drops(AI.demo_arcade_phase4);
	SleepUntil([| ai_living_count(AI.demo_arcade_phase2) <= 2 ], 10);
		sleep_s(2);
		ai_place(AI.demo_arcade_phase3);
		demo_ai_place_no_drops(AI.demo_arcade_phase3_grunts );
	SleepUntil([| ai_living_count(AI.demo_arcade_phase3) <= 1 ], 10);
		var_e3_wounded_elite = true;				-- makes an elite stagger into view
	SleepUntil([| ai_living_count(AI.demo_arcade_phase4) <= 0 ], 10);
		demo_ai_place_no_drops(AI.demo_arcade_phase5);

--]]
end


-- TEAM FACING FUNCTIONS, ARCADE: --------------------------------------------------------------------------------------------------------------------------------------
-- These are on the wiki page, and people use them to iterate.
-- It's improtant that these functions are self-contained
-- and that the name doesn't change.

function demo_arcade_kill_all():void														-- remove all AI. Also kills spawning sequence thread.
	CreateThread(demo_arcade_kill_threads);
	ai_erase(AI.sg_demo_arcade);
end

function demo_arcade_spawn_all():void														-- place all AI. Instant, direct spawns. i.e. Doesn't spawn them sequentially.
	CreateThread(demo_arcade_kill_threads);
	if (ai_living_count(AI.sg_demo_arcade) >= 1)then
		ai_erase(AI.sg_demo_arcade);
	end
	ai_place(AI.sg_demo_arcade);
end

function demo_arcade_dogfight():void
	CreateThread(stop_valid_composition, var_e3_spirit_phantom_flyby);
	Sleep(2);
	var_e3_spirit_phantom_flyby = composer_play_show ("vin_e3_spirit_phantom_flyby");
end

function demo_arcade_reset_loadout():void
	unit_add_equipment( SPARTANS.buck, STARTING_PROFILES.demobuck, true, true);
	unit_add_equipment ( SPARTANS.locke, STARTING_PROFILES.demolocke, true, true );
	unit_add_equipment ( SPARTANS.tanaka, STARTING_PROFILES.tanaka, true, true );
	unit_add_equipment ( SPARTANS.vale, STARTING_PROFILES.vale, true, true );
end
-- SUPPORTING FUNCTIONS, ARCADE:--------------------------------------------------------------------------------------------------------------------------------------
function demo_arcade_kill_threads():void
	CreateThread(clear_demo_thread, v_demo_thread_arcade_sequence);
	CreateThread(clear_demo_thread, v_demo_arcade_vale_bunker_thread);
	CreateThread(clear_demo_thread, v_demo_arcade_dogfight_thread);
	CreateThread(demosys_kill_all_aracade_narrative);
end
function demo_arcade_set_start_positions()
	object_teleport( SPARTANS.locke , FLAGS.fl_demo_start_locke);
	object_teleport( SPARTANS.vale , FLAGS.fl_demo_start_vale);
	object_teleport( SPARTANS.buck , FLAGS.fl_demo_start_buck);
	object_teleport( SPARTANS.tanaka , FLAGS.fl_demo_start_tanaka);
end
function demo_arcade_locke_start():void
	SleepUntil([| volume_test_players_lookat(VOLUMES.tv_demo_look_8, 40, 1) ], 2);
		b_demo_arcade_start = true;
		b_demo_arcade_start_vale = true;			-- got moved here, now poorly named
		b_demo_arcade_start_buck = true;			-- got moved here, now poorly named
end
function demo_arcade_locke_start_vale():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_arcade_start, SPARTANS.vale)], 1);
--		b_demo_arcade_start_vale = true;
end
function demo_arcade_locke_start_buck():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_arcade_start, SPARTANS.buck)], 1);
--		b_demo_arcade_start_buck = true;
end
function demo_replenish_ammo():void
		weapon_set_current_amount(unit_get_primary_weapon(SPARTANS.buck), 1);
		weapon_set_current_amount(unit_get_primary_weapon(SPARTANS.tanaka), 1);
		weapon_set_current_amount(unit_get_primary_weapon(SPARTANS.vale), 1);
end
function demo_grunty_shot_listener():void
	object_can_take_damage(OBJECTS.e3_wounded_elite_03);
	object_set_shield_stun_infinite(OBJECTS.e3_wounded_elite_03);
	object_set_shield(OBJECTS.e3_wounded_elite_03, 0);
	SleepUntil([| object_get_health(OBJECTS.e3_wounded_grunty) < 1], 2);
	print("BANG");
	print("BANG");
	print("BANG");
	print("BANG");
	print("BANG");
	print("BANG");
	print("BANG");
	print("BANG");
end
function demo_arcade_dogfight_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_dogfight)], 2);
	demo_arcade_dogfight();
end
function demo_arcade_kill_threads_and_restart():void										-- kill sequence if it's already running. Then start sequence.
	CreateThread(demo_arcade_kill_threads);
	Sleep(2);
	v_demo_thread_arcade_sequence = CreateThread(demo_arcade_sequence);
end
function demo_arcade_fx_remove()
	StopEffectGroup( EFFECTS.fx_dest_alley_smolder_06 );
	StopEffectGroup( EFFECTS.fx_dest_alley_fire_03 );
--	StopEffectGroup( EFFECTS.fx_dest_alley_embers_08 );
	StopEffectGroup( EFFECTS.effectplacement31 );
	StopEffectGroup( EFFECTS.fx_dest_alley_smolder_05 );
end
function demo_fleebie_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_fleebie)], 5);	
	CreateThread(demo_fleebie);
end
function demo_fleebie():void
	RunClientScript("client_arcade_explosion", FLAGS.fl_demo_arcade_fx_4);
	demo_ai_place_no_drops(AI.demo_arcade_fleebie);
	sleep_s(.4);
	--NarrativeQueue.QueueConversation(E3Demo_grunt_runsaway);
end
function demo_wraith():void 
--	SleepUntil([| volume_test_players( VOLUMES.tv_demo_wraith)  ], 2);
	SleepUntil([| volume_test_player_lookat(VOLUMES.tv_demo_look_6, SPARTANS.locke, 11, 40) ], 2);
	RunClientScript("client_arcade_explosion_large", FLAGS.fl_demo_wraith);
	RunClientScript("demo_wraith_client", FLAGS.fl_demo_wraith);
end
function demo_shade():void
	object_create("demo_shade");
	object_destroy(object_at_marker(OBJECTS.demo_shade, "turret")); 
	RunClientScript("demo_shade_client", OBJECTS.demo_shade);
	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_covenant\fire_cov_sml_nosmoke_t0.effect'), OBJECTS.demo_shade,  "body"); 
end
function demo_condemned():void
	object_destroy(OBJECTS.e3_wounded_elite_03);
	object_destroy(OBJECTS.e3_wounded_grunty);
	stop_valid_composition (v_demo_condemned_comp);
	stop_valid_composition (v_demo_condemned_grunty_comp);
	b_condemned_endloop = false;
	b_condemned_faceloop = false;
	b_condemned_grunty_faceloop = false;
	sleep_s(.5);
	v_demo_condemned_comp = composer_play_show("vin_e3_injured_elite");
	v_demo_condemned_grunty_comp = composer_play_show("vin_e3_injured_grunty");
	object_create_anew("cr_condemned_target");
	object_create_anew("cr_condemned_grunty_target");
	object_set_shield_stun_infinite(OBJECTS.e3_wounded_elite_03);
	object_set_shield(OBJECTS.e3_wounded_elite_03, 0);
	unit_doesnt_drop_items(OBJECTS.e3_wounded_elite_03);
	unit_doesnt_drop_items(OBJECTS.e3_wounded_grunty);
	sleep_s(.1);
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_arcade_buck)], 2);
	b_condemned_endloop = true;
	SleepUntil([| object_get_health(OBJECTS.cr_condemned_target) <= 0 ], 2); 
	b_condemned_faceloop = true;
	var_e3_wounded_stairs_elite = true;						-- sends wounded elite crawling up the stairs
	SleepUntil([| object_get_health(OBJECTS.e3_wounded_grunty) < 1], 2);
	b_condemned_grunty_faceloop = true;
end
--	unit_set_maximum_vitality( ai_get_object( ai_current_actor ) ,1, 0 );
--	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,1, 0);

function practice_look_at():void
	if (v_practice_thread ~= nil)then
		CreateThread(clear_demo_thread, v_practice_thread);
		Sleep(3);
		v_practice_thread = nil;
	else
		v_practice_thread = CreateThread(sys_look_at_practice);
	end
end

function sys_look_at_practice():void
	repeat
		if	(	
				volume_test_players_lookat(VOLUMES.tv_demo_look_8, 40, 1) ) then
				--volume_test_player_lookat(VOLUMES.tv_demo_look_6, SPARTANS.locke, 11, 20) ) then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function demo_arcade_alliances():void
	ai_object_set_team(OBJECTS.e3_wounded_elite_01,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_elite_02,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_elite_03,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_grunty,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_grunt_01,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_jackal_01,TEAM.covenant);
	ai_object_set_team(OBJECTS.e3_wounded_jackal_02,TEAM.covenant);
end

-- NARRATIVE LOGIC:------------------------------------------------------------------------------------------------------------------------------------------------------
-- globals used to track listener threads
-- so they can be killed/restarted
-- for faster iteration
global v_demo_narrative_begins:thread = nil;
global v_demo_narrative_grunts_die:thread = nil;
global v_demo_narrative_shade_attack:thread = nil;
global v_demo_narrative_shade_destroyed:thread = nil;
global v_demo_narrative_grenadier_arrives:thread = nil;
global v_demo_narrative_grenadier_dies:thread = nil;
global v_demo_narrative_grenadier_bro_dies:thread = nil;
global v_demo_narrative_plasmacaster_pickup:thread = nil;
global v_demo_narrative_jackals_arrive:thread = nil;
global v_demo_narrative_jackals_die:thread = nil;
global v_demo_narrative_ninja_arrive:thread = nil;
global v_demo_narrative_ninja_die:thread = nil;
global v_demo_narrative_dogfight:thread = nil;

function demosys_kill_all_aracade_narrative():void
	CreateThread(clear_demo_thread, v_demo_narrative_begins);
	CreateThread(clear_demo_thread, v_demo_narrative_grunts_die);
	CreateThread(clear_demo_thread, v_demo_narrative_shade_attack);
	CreateThread(clear_demo_thread, v_demo_narrative_shade_destroyed);
	CreateThread(clear_demo_thread, v_demo_narrative_grenadier_dies);
	CreateThread(clear_demo_thread, v_demo_narrative_grenadier_bro_dies);
	CreateThread(clear_demo_thread, v_demo_narrative_plasmacaster_pickup);
	CreateThread(clear_demo_thread, v_demo_narrative_jackals_arrive);
	CreateThread(clear_demo_thread, v_demo_narrative_jackals_die);
	CreateThread(clear_demo_thread, v_demo_narrative_ninja_arrive);
	CreateThread(clear_demo_thread, v_demo_narrative_ninja_die);
	CreateThread(clear_demo_thread, v_demo_narrative_dogfight);

end

function demosys_thread_up_arcade_narrative():void
	CreateThread(narr_demo_begins_listener);			--	let's go
	CreateThread(narr_demo_dogfight_listener);			-- conversation about arbiter's forces
	CreateThread(narr_demo_tracking_convo_listener);								-- so, you think chief...
																					-- ..activating artemis
end
function demosys_reset_arcade_narrative_threads():void
	demosys_kill_all_aracade_narrative();
	demosys_thread_up_arcade_narrative();
end
function narr_demo_tracking_convo_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_tracking, SPARTANS.locke)], 2);	
	NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_enter);	-- so, did the chief come this way?
																	-- let's see, activating the artemis
	sleep_s(2.6);
	CreateThread(demo_locke_scan);
	sleep_s(4);
	object_create("footprints");
	Sleep(2);
	object_set_function_variable(OBJECTS.footprints, "fx_footprints_show", 1, 12.3);
	sleep_s(.8);	--add'l delay 5/28/15
	NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_ping);
	CreateThread(vale_track_listener);		-- Vale's lines
end
function artmeis():void
	NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_enter);	-- so, did the chief come this way?
																	-- let's see, activating the artemis
	sleep_s(2.6);
	CreateThread(demo_locke_scan);
end
function vale_track_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demov2_vale, SPARTANS.vale)], 2);
--	After Vale kneels down before the tracked objects:
	CreateThread(vale_track);
--	SleepUntil([| NarrativeQueue.HasConversationFinished(E3Demo_TRACKING_ROOM_approach_clue)], 3);
end
function vale_track():void
	if(object_valid("footprints") ~= true)then
		object_create_anew("footprints");
	end
	composer_play_show("vin_e3_vale_tracking");
	SleepUntil([| b_vale_loop == true ], 1); 
	NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_approach_clue);
	sleep_s(1.5);
	object_destroy(OBJECTS.footprints);	
end
function narr_demo_begins_listener():void
	SleepUntil([| b_demo_arcade_start_buck == true;  ], 1);
	sleep_s(2);
	NarrativeQueue.QueueConversation(E3Demo_BEGINS); 
end
function narr_demo_dogfight_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_dogfight)], 1);
	sleep_s(1.4);
--	Phantom chasing spirit passes by:
	NarrativeQueue.QueueConversation(E3Demo_PHANTOM_CHASES_SPIRIT);
end
-- COMMAND SCRIPTS, ARCADE:------------------------------------------------------------------------------------------------------------------------------------------
function cs_low_health()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
end


-----GRUNTS INTRO
function cs_fleebie():void
	CreateThread(fleebie_trap);
	Sleep(2);
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.demo_arcade_fleebie.fleebie, "head");
	RunClientScript("firefleebie", ai_get_unit(ai_current_actor));
	cs_push_stance(ai_current_actor, "flee");
	ai_set_blind(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	cs_go_to(POINTS.ps_fleebie.a01);
--[[
	RunClientScript("explodeyfleebie", ai_get_unit(ai_current_actor));
	Sleep(1);
	damage_new( TAG('objects\weapons\melee\gravity_hammer\damage_effects\gravity_hammer_impulse.damage_effect'), FLAGS.fl_fleeb );
	damage_new( TAG('objects\weapons\melee\gravity_hammer\damage_effects\gravity_hammer_explosion.damage_effect'), FLAGS.fl_fleeb );
	Sleep(2);
	ai_kill(ai_current_actor);
--]]

--	damage_object_effect(TAG('objects\weapons\rifle\sniper_rifle\projectiles\sniper_rifle_bullet.damage_effect'),ai_get_unit(AI.demo_arcade_fleebie));

--	damage_new( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), FLAGS.fl_fleeb );
--	damage_new( TAG('objects\weapons\rifle\shotgun\projectiles\shotgun_bullet.damage_effect'), FLAGS.fl_fleeb );
--	damage_new( TAG('objects\weapons\rifle\shotgun\projectiles\shotgun_bullet_v001_uber.damage_effect'), FLAGS.fl_fleeb );
--	damage_new( TAG('objects\weapons\rifle\sniper_rifle\projectiles\sniper_rifle_bullet.damage_effect'), FLAGS.fl_fleeb );
--	damage_new( TAG('objects\weapons\pistol\sticky_detonator\projectiles\damage_effects\sticky_detonator_grenade_explosion.damage_effect'), FLAGS.fl_fleeb );
--	damage_new( TAG('objects\characters\grunt\damage_effects\grunt_backpack_destroyed.damage_effect'), FLAGS.fl_fleeb );
--	RunClientScript("fleebie_sniped", ai_get_unit(ai_current_actor));
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "methane_tank", 250);
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "armor_pack", 250);
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "body", 120);
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "head", 120);

--	Sleep(3);	


--	cs_go_to(POINTS.ps_fleebie.a03);
--	cs_go_to(POINTS.ps_fleebie.a04);
--	cs_go_to(POINTS.ps_fleebie.a05);
--	cs_go_to(POINTS.ps_fleebie.a06);
end
function fleebie_trap():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_fleebie_trap, AI.demo_arcade_fleebie)], 1);
	RunClientScript("explodeyfleebie", ai_get_unit(AI.demo_arcade_fleebie));
	Sleep(1);
	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "rocket", 200);
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "methane_tank", 180);
--	object_damage_damage_section(ai_get_unit(AI.demo_arcade_fleebie), "armor_pack", 180);
	unit_kill(ai_get_unit(AI.demo_arcade_fleebie));
	CreateThread(demo_tow_arcade_end);
end

--[[
██████╗ ███████╗███████╗████████╗██████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
██║  ██║█████╗  ███████╗   ██║   ██████╔╝██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║
██║  ██║██╔══╝  ╚════██║   ██║   ██╔══██╗██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║
██████╔╝███████╗███████║   ██║   ██║  ██║╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
--]]
--- destruction
function undampen_destruction_listener():void
	SleepUntil([| b_destruction_start == true ], 1);
	v_damp = 1;
end
-- destruction narrative --------------------------------------------------------------------------------------------------

global v_demo_narrative_guardian_rise:thread = nil;
global v_demo_narrative_guardian_phantom_crash:thread = nil;
global v_demo_narrative_alley_start:thread = nil;
global v_demo_narrative_locke_fall:thread = nil;
global v_demo_narrative_locke_stand:thread = nil;

function demosys_kill_all_destruction_narrative():void
	CreateThread(clear_demo_thread, v_demo_narrative_guardian_rise);
--	CreateThread(clear_demo_thread, v_demo_narrative_guardian_phantom_crash);
	CreateThread(clear_demo_thread, v_demo_narrative_alley_start);
	CreateThread(clear_demo_thread, v_demo_narrative_locke_fall);
	CreateThread(clear_demo_thread, v_demo_narrative_locke_stand);
end
function demosys_thread_up_destruction_narrative():void
	v_demo_narrative_begins = CreateThread(narr_demo_alley_start_listener);
--	v_demo_narrative_guardian_phantom_crash = CreateThread(narr_demo_guardian_phantom_listener);
	v_demo_narrative_alley_start = CreateThread(narr_demo_guardian_rise_listener);
	v_demo_narrative_locke_fall = CreateThread(narr_demo_locke_fall_listener);
--	v_demo_narrative_locke_stand = CreateThread(narr_demo_locke_stand_listener);
	CreateThread(head_down_and_run);
	CreateThread(buck_gogo);
end
function demosys_reset_destruction_narrative_threads():void
	demosys_kill_all_destruction_narrative();
	demosys_thread_up_destruction_narrative();
end
function narr_demo_alley_start_listener():void
	SleepUntil([| b_destruction_e3_vo == true ], 1);
-- Near start of Destruction Alley:
	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_start);  -- watch out!
end
function narr_demo_guardian_rise_listener():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_demo_destruction)], 1);
--	Guardian appears rising before them:
	sleep_s(1.5);
	NarrativeQueue.QueueConversation(E3Demo_GUARDIAN_RISES);		-- There's the guardian
																	-- Think the Chief's already on board?
end
function narr_demo_guardian_phantom_listener():void
--	SleepUntil([|   ], 1);
-- After the pelican crash:
	NarrativeQueue.QueueConversation(E3Demo_GUARDIAN_pelican_crash); -- Everyone in one piece? This is our only path to the guardian. Get moving.
end
function narr_demo_locke_fall_listener():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_slider)], 1);
-- After Locke falls:
	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_locke_falls); --"LOCKE!"
end
function narr_demo_locke_stand_listener():void
	SleepUntil([| b_pull_up == true ], 2);
-- Locke stands:
--	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_locke_stand);		-- "I'm OK"
end
function buck_gogo():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_demo_buck_gogo)], 1);
-- After Locke falls:
	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_buck_gogo); --"gogogo move spartans!"
	
end
function ff():void
	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_locke_stand);		-- "I'm OK"
end
function head_down_and_run():void
	SleepUntil([|b_heads_down], 2);
	sleep_s(.5);
	NarrativeQueue.QueueConversation(E3Demo_DESTRUCTION_ALLEY_second); -- KEEP YOUR HEAD DOWN AND RUN
end
function tanaka_says_incoming():void
	NarrativeQueue.QueueConversation(E3Demo_GUARDIAN_RISES_incoming); -- watch out!
end


--[[
██╗███╗   ██╗████████╗███████╗██████╗ ██╗ ██████╗ ██████╗ 
██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗██║██╔═══██╗██╔══██╗
██║██╔██╗ ██║   ██║   █████╗  ██████╔╝██║██║   ██║██████╔╝
██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗██║██║   ██║██╔══██╗
██║██║ ╚████║   ██║   ███████╗██║  ██║██║╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝
--]]                                                      
--- interior
function demo_interior_sequence():void														-- Main thread for the capture. Should have correct timing (eventually, when we get to that.)
	object_create_folder_anew(MODULES.demo_interior);
	CreateThread(demo_replenish_ammo);
--	demo_ai_place_no_drops(AI.demo_interior_soldiers);
	CreateThread(interior_dampen_listener);
	CreateThread(interior_undampen_listener);
	CreateThread(maybe_pin_texture);
	ai_grenades(false);
--	v_demo_soldier_thread = CreateThread(demo_soldier_with_sleep_untils);
	v_demo_pawn_room_thread = CreateThread(demo_ass_pawn_with_sleep_until);
	demosys_thread_up_interior_narrative();

	stop_valid_composition (var_tsunami_theater_arcade);
	stop_valid_composition (var_tsunami_theater_arcade);
	stop_valid_composition (var_tsunami_theater_arcade_e3);
	stop_valid_composition (var_tsunami_pulse);
	game_save_no_timeout();
	--streamer_pin_tag(TAG('levels\assets\osiris\texture_tiles\sangheli\tsunami_station\tsun_metal_debris_a_control.bitmap'));
	CreateThread(demo_tow_interior_start);
	SleepUntil([|	volume_test_player_lookat(VOLUMES.tv_demo_look_4, SPARTANS.locke, 15, 5) 
				], 2);
	RunClientScript("client_tension_ripple");
	local theater_comp:number = nil;
--	sleep_s(.5);
	CreateThread(demo_bamf);

	SleepUntil(	[|	volume_test_players(VOLUMES.tv_demo_ass_pawn) 	], 2);
	theater_comp = composer_play_show("vin_e3_interior_theater");
	RunClientScript("client_tension_ripple_vtol");
	CreateThread(demo_ripple_ff);
	SleepUntil([| volume_test_objects(VOLUMES.tv_fight_dampen , SPARTANS.locke)], 2);	
--	stop_valid_composition (theater_comp);
--	CreateThread(demo_tow_interior_end);

--	CreateThread (soldierbamf);
--	CreateThread (grunt_crawler_war);
--	CreateThread (track_interior);
end
-- TEAM-FACING FUNCTIONS, INTERIOR: --------------------------------------------------------------------------------------------------------------------------------------
-- These are on the wiki page, and people use them to iterate.
-- It's improtant that these functions are self-contained
-- and that the name doesn't change.

function demo_interior_vtol():void
	CreateThread(stop_valid_composition, v_demo_vtol_comp);
	ai_erase(AI.demo_vtol);
	Sleep(2);
	ai_place(AI.demo_vtol);
	Sleep(2);
	v_demo_vtol_comp = composer_play_show("vin_e3_vtol_reveal", {vtol = ai_vehicle_get_from_squad(AI.demo_vtol)} );
	sleep_s(.5);
	SleepUntil([|( ai_living_count(AI.demo_vtol) <= 0)], 5);
	sleep_s(1);
	NarrativeQueue.QueueConversation(E3Demo_PHAETON_ROOM_PHAETON_down);				-- target down ; tanaka help vale ; on it
	sleep_s(1);
	NarrativeQueue.QueueConversation(E3Demo_tanaka_helps_vale);						-- on your feet, spartan
--	cs_run_command_script(AI.demo_vtol.spawnpoint33, "cs_vtol");

end

-- SUPPORTING FUNCTIONS, INTERIOR:--------------------------------------------------------------------------------------------------------------------------------------
function demo_interior_kill_threads_and_restart():void										-- kill sequence if it's already running. Then start sequence.
	CreateThread(demo_interior_kill_threads);
	CreateThread(demo_interior_kill_compositions);
	Sleep(2);
	v_demo_thread_interior_sequence = CreateThread(demo_interior_sequence);
end
function demo_interior_kill_threads():void
	CreateThread(clear_demo_thread, v_demo_soldier_thread);
	CreateThread(clear_demo_thread, v_demo_thread_interior_sequence);
	CreateThread(clear_demo_thread, v_demo_pawn_room_thread);
	demosys_kill_all_interior_narrative();
end
function demo_interior_kill_compositions():void
	CreateThread(stop_valid_composition, v_demo_soldier_comp);
	CreateThread(stop_valid_composition, v_demo_vtol_comp);
	b_demo_soldier = false;																	-- looping condition on soldier composition
end
function interior_dampen_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_interior_dampen , SPARTANS.locke)], 2);	
	sleep_s(1);
	NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_enter_made); -- made it
	v_damp = .5;
end
function interior_undampen_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_interior_undampen , SPARTANS.locke)], 2);	
	CreateThread(demo_undampen_all);
end
function demo_ripple_ff():void
	SleepUntil([|volume_test_player_lookat(VOLUMES.tv_demo_look_5, SPARTANS.locke, 8, 5) ], 1);
	RunClientScript("client_tension_ripple_ff");
end
function demo_ripple():void
	RunClientScript("client_tension_ripple");
end
function demo_vtol():void
	demo_interior_vtol();
end
function demo_bamf():void
	CreateThread(stop_valid_composition, v_demo_bamf_comp);
	v_demo_bamf_comp = composer_play_show("vin_e3_soldier_bamfs");
	sleep_s(1);
	--NarrativeQueue.QueueConversation(E3Demo_TRACKING_ROOM_soldier_fx);
	b_demo_bamf_playing = true;
end
function demo_ass_pawn(bit:boolean):void
--	v_demo_pawn_room_thread
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_demo_ass_pawn) 
					or	bit == false														-- this is for cheat function
					], 1);
--	CreateThread( slip_space_spawn_no_drops, AI.demo_interior_pawn_front);
--	sleep_s(1);
	CreateThread( slip_space_spawn_no_drops, AI.demo_interior_pawn_mid);
	sleep_s(1);
--	CreateThread( slip_space_spawn_no_drops, AI.demo_interior_pawn_back);
	CreateThread( sysdemo_last_pawns);
	sleep_s(.5);
	NarrativeQueue.QueueConversation(E3Demo_SOLDIER_ATTACK);
--	ai_place(AI.demo_interior_bishops);
--	var_grunt_crawler_war = composer_play_show ("w2_tsunami_grunt_crawler_war");
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_vtol) == true], 1);
	demo_interior_vtol();
end
function sysdemo_last_pawns():void
--	SleepUntil(	[|	ai_living_count(AI.sg_demo_interior_pawns_all) <= 6], 3);
	CreateThread( slip_space_spawn_no_drops, AI.demo_interior_pawn_post);
end

function demo_ass_pawn_immediate():void
	demo_ass_pawn(false);
end
function demo_ass_pawn_with_sleep_until():void
	demo_ass_pawn(true);
end
function test_look_at_demo():void
	--repeat
		--if	(	volume_test_player_lookat(VOLUMES.tv_demo_look_knight, SPARTANS.locke, 10, 1) ) then
			--print( "can see");
		--else
			--print( " ");
		--end
		--Sleep(3);
	--until(false)
end
-- NARRATIVE SCRIPTS, INTERIOR: --------------------------------------------------------------------------------------------------------------------------------------------
global v_demo_narrative_after_ping:thread = nil;
global v_demo_narrative_vale_kneeling:thread = nil;
global v_demo_narrative_soldier_attack:thread = nil;
global v_demo_narrative_soldier_bamf_away:thread = nil;
global v_demo_narrative_bunker_door:thread = nil;
global v_demo_narrative_vtol_appears:thread = nil;
global v_demo_narrative_vale_down:thread = nil;
global v_demo_narrative_up_ramp:thread = nil;

function demosys_kill_all_interior_narrative():void
	CreateThread(clear_demo_thread, v_demo_narrative_after_ping);
	CreateThread(clear_demo_thread, v_demo_narrative_vale_kneeling);
	CreateThread(clear_demo_thread, v_demo_narrative_soldier_attack);
	CreateThread(clear_demo_thread, v_demo_narrative_soldier_bamf_away);
	CreateThread(clear_demo_thread, v_demo_narrative_bunker_door);
	CreateThread(clear_demo_thread, v_demo_narrative_vtol_appears);
	CreateThread(clear_demo_thread, v_demo_narrative_vale_down);
	CreateThread(clear_demo_thread, v_demo_narrative_up_ramp);
end
function demosys_thread_up_interior_narrative():void
--	v_demo_narrative_soldier_attack = CreateThread(narr_demo_soldiers_attack_listener);
--	v_demo_narrative_soldier_bamf_away = CreateThread(narr_demo_soldiers_bamf_listener);
	v_demo_narrative_bunker_door = CreateThread(narr_demo_door_bunker_listener);
	v_demo_narrative_vtol_appears = CreateThread(narr_demo_vtol_listener);
--	v_demo_narrative_up_ramp = CreateThread(narr_demo_up_ramp_listener);
--	v_demo_narrative_vale_down = CreateThread(narr_demo_vale_down_listener);
end
function demosys_reset_interior_narrative_threads():void
	demosys_kill_all_interior_narrative();
	demosys_thread_up_interior_narrative();
end

function narr_demo_soldiers_attack_listener():void
	SleepUntil([| b_soldier_vo == true], 1);
--	Soldiers attack:
	sleep_s(1);
	NarrativeQueue.QueueConversation(E3Demo_SOLDIER_ATTACK);		-- heads up, promethean soldiers
end

function narr_demo_door_bunker_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_ass_pawn)], 1);
	sleep_s(2);
	NarrativeQueue.QueueConversation(E3Demo_DOOR_SCENE);				-- move in and clear
																		-- prometheans incoming
end
function narr_demo_vtol_listener():void		
	SleepUntil([| b_vtol_vo == true ], 3);
--	Phaeton appears:
	NarrativeQueue.QueueConversation(E3Demo_PHAETON_ROOM_PHAETON_FIGHT);			-- phaeton
	sleep_s(3);
	NarrativeQueue.QueueConversation(E3Demo_PHAETON_ROOM_PHAETON_light_it_up);
end
function narr_demo_up_ramp_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_up_ramp)], 1);
--	After phaeton, when climbing ramp:
	NarrativeQueue.QueueConversation(E3Demo_post_phaeton_ramp_climb);		-- I just realized, chief was fighting covenant but not prometheans
end
-- called directly:--------------------------------------------------------------
function narr_demo_vale_down_listener():void								-- called from script
	SleepUntil([| IsUnitDowned(SPARTANS.vale)], 1);
--	Vale hit, downed:
	NarrativeQueue.QueueConversation(E3Demo_phaeton_vale_hit);
end
-- COMMAND SCRIPTS, INTERIOR:------------------------------------------------------------------------------------------------------------------------------------------
function cs_vtol():void																				-- called from composition
	sleep_s(1.5);
--	unit_set_maximum_vitality( ai_vehicle_get_from_squad(AI.demo_vtol) ,0.5, 0.5 );
--	unit_set_maximum_vitality( ai_get_object( AI.demo_vtol.spawnpoint33) ,0.5, 0.5 );
	object_set_health( ai_vehicle_get_from_squad(AI.demo_vtol) ,0.20);
	object_set_shield( ai_vehicle_get_from_squad(AI.demo_vtol) ,0.20);
	object_set_health( ai_get_object( AI.demo_vtol.spawnpoint33) ,0.20);
	cs_aim_object(ai_current_actor, true, SPARTANS.vale);
	sleep_s(.2);
	cs_shoot_at(ai_current_actor, true, SPARTANS.vale);
	sleep_s(1.4);
	DownUnit(SPARTANS.vale);
	sleep_s(.3)
	NarrativeQueue.QueueConversation(E3Demo_phaeton_vale_hit);						
	repeat
		sleep_s(1);
		cs_aim(ai_current_actor, true, POINTS.ps_vtol.a);
		sleep_s(.2);
		cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol.a);
		sleep_s(1);
		cs_aim(ai_current_actor, true, POINTS.ps_vtol.c);
		sleep_s(.2);
		cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol.c);
		sleep_s(1);
		cs_aim(ai_current_actor, true, POINTS.ps_vtol.b);
		sleep_s(.2);
		cs_shoot_at(ai_current_actor, true, POINTS.ps_vtol.b);
		sleep_s(1);
	until(false);

--[[

	sleep_s(7);
--]]
end
function cs_pawn_b1():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	cs_go_to(POINTS.demo_interior.b1);
	sleep_s(1);
end
function cs_pawn_b2():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	cs_go_to(POINTS.demo_interior.b2);
	sleep_s(1);
	cs_enable_moving(ai_current_actor, true);
end
function cs_pawn_b3():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	cs_go_to(POINTS.demo_interior.b3);
	sleep_s(1);
end
function cs_pawn_l1():void
	cs_go_to(POINTS.demo_interior.l1);
	sleep_s(1);
end
function cs_pawn_l2():void
	cs_go_to(POINTS.demo_interior.l2);
	sleep_s(1);
	cs_enable_moving(ai_current_actor, true);
end
function cs_pawn_t1():void
	cs_go_to(POINTS.demo_interior.t1);
	sleep_s(1);
end
function cs_pawn_t2():void
	cs_go_to(POINTS.demo_interior.t2);
	sleep_s(1);
	cs_enable_moving(ai_current_actor, true);
end
function cs_pawn_v1():void
	cs_go_to(POINTS.demo_interior.v1);
	sleep_s(1);
end
function cs_pawn_v2():void
	Sleep(5);
	cs_custom_animation(AI.demo_interior_pawn_mid.spawnpoint12, true, TAG('objects\characters\pawn\pawn.model_animation_graph'),"combat:any:taunt", true);
	sleep_s(1);
end
function cs_pawn_x1():void
	cs_go_to(POINTS.demo_interior.x1);
	sleep_s(1);
end
function cs_pawn_x2():void
	cs_go_to(POINTS.demo_interior.x2);
	sleep_s(1);
	cs_enable_moving(ai_current_actor, true);
end
function cs_pawn_z1():void
	ai_jump_cost_scale(100);
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	ai_playfight(ai_current_actor, true);
	cs_enable_moving(ai_current_actor, true);
	sleep_s(1);
end
--[[
███████╗██╗ ██████╗ ██╗  ██╗████████╗
██╔════╝██║██╔════╝ ██║  ██║╚══██╔══╝
█████╗  ██║██║  ███╗███████║   ██║   
██╔══╝  ██║██║   ██║██╔══██║   ██║   
██║     ██║╚██████╔╝██║  ██║   ██║   
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
--]]                                
function demo_fight_sequence():void															-- Main thread for the capture. Should have correct timing (eventually, when we get to that.)
	ai_jump_cost_scale(1);
	CreateThread(soldierstorm);
--	CreateThread(demo_tow_fight_start);
	CreateThread(demo_replenish_ammo);
	object_create_folder_anew(MODULES.demo_fight);
	object_create_folder_anew(MODULES.demo_flight);
	object_create_folder_anew(MODULES.mod_demo_blips);
	object_create_folder_anew(MODULES.mod_demo_fight_crates);
	object_create_anew("cr_soldier_spawner_target");
	CreateThread(demosys_thread_up_fight_narrative);
	CreateThread(maybe_pin_texture);
	var_guardian_bail = composer_play_show ("vin_tsunami_guardian_bail");
	demo_ai_place_no_drops(AI.demo_fight_pawn_greeter);
--	CreateThread(fight_dampen_listener);
	CreateThread(demo_upper_soldier_listener);
	CreateThread(demo_start_pawn_fight_sequence);
	CreateThread(demo_fight_objcon_manager);
	CreateThread(demo_named_soldier_listener);
	CreateThread(vale_adds_listener);
	ai_grenades(false);
	streamer_pin_tag(TAG('levels\assets\osiris\texture_tiles\sangheli\tsunami_station\tsun_metal_debris_a_control.bitmap'));
	SleepUntil([| var_demo_fight_objcon >= 10], 2);
	demo_ai_place_no_drops(AI.sg_demo_soldiers_tanaka);
	SleepUntil([| var_demo_fight_objcon >= 20], 2);
	demo_ai_place_no_drops(AI.sg_demo_fight_phase_3);
	CreateThread(demo_replenish_ammo);
	CreateThread(officer_maker);
	CreateThread(demo_undampen_all);
--	CreateThread(demo_knight);
--	CreateThread(demo_officers);
end

-- TEAM FACING FUNCTIONS, FIGHT: --------------------------------------------------------------------------------------------------------------------------------------
-- These are on the wiki page, and people use them to iterate.
-- It's improtant that these functions are self-contained
-- and that the name doesn't change.

function demo_fight_reset():void															-- reset fight demo sequence
	for _, playa in ipairs(players()) do
		teleport_player_to_flag(playa, FLAGS.fl_demo_fight);
	end
	if(current_zone_set() ~= ZONE_SETS.w2_tsunami_finale)then
		switch_zone_set(ZONE_SETS.w2_tsunami_finale);
	end

	ai_erase(AI.sg_demo_fight_all);
	garbage_collect_now();
	Sleep(3);

	CreateThread(demo_fight_kill_threads_and_restart);
end
function demo_warden():void
--	force_player_nav_points_off = true;
	RunClientScript("hud_reduce");
	CreateThread(stop_valid_composition, v_demo_warden);
	Sleep(2);
	NarrativeQueue.QueueConversation(E3Demo_WARDEN_APPEARS);
	sleep_s(2);
	ai_play_slip_space_effect_at_lua_location(FLAGS.fl_wardener);
	sleep_s(1);
	-- Warden scene starts:
--	NarrativeQueue.QueueConversation(E3Demo_WARDEN_APPEARS);
	sleep_s(1.49);
	v_demo_warden = composer_play_show ("vin_e3_warden_reveal");
	sleep_s(.2);

	SleepUntil([| composer_show_is_playing(v_demo_warden) == false], 3);
	PlayersForceReviveAndRespawn();
	sleep_s(3);
	fade_in (1,1,1,20);
--	force_player_nav_points_off = false;
end
function warden_down_all():void
	damage_new( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), FLAGS.fl_warden1 );
	damage_new( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), FLAGS.fl_warden2 );
	damage_new( TAG('objects\vehicles\human\scorpion\turrets\scorpion_cannon\weapon\projectiles\damage_effects\scorpion_cannon_round.damage_effect'), FLAGS.fl_warden3 );
end
function demo_upper_ai():void
	demo_ai_place_no_drops(AI.demo_fight_pawn_greeter);
	demo_ai_place_no_drops(AI.demo_fight_upper_soldiers); 
end
function demo_officers():void
	ai_erase(AI.demo_fight_officers);
	Sleep(3);
	demo_ai_place_no_drops(AI.demo_fight_officers);
	sleep_s(.4);
	NarrativeQueue.QueueConversation(E3Demo_SOLDIER_captains);
end

-- SUPPORTING FUNCTIONS, FIGHT:----------------------------------------------------------------------------------------------------------------------------------------
function demo_fight_kill_threads_and_restart():void											-- kill sequence if it's already running. Then start sequence.
--	CreateThread(demo_tow_fight_end);
	CreateThread(demo_fight_kill_threads);
	CreateThread(demo_fight_kill_compositions);
	Sleep(2);
	v_demo_thread_fight_sequence = CreateThread(demo_fight_sequence);
end
function demo_fight_kill_threads():void
	CreateThread(clear_demo_thread, v_demo_thread_fight_sequence);
	demosys_kill_all_fight_narrative();
end
function demo_fight_kill_compositions():void
	CreateThread(stop_valid_composition, var_guardian_bail);
end
function fight_dampen_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_fight_dampen , SPARTANS.locke)], 2);	
--	v_damp = .5;
	CreateThread(demo_undampen_all);
end
function demo_start_pawn_fight_sequence():void
	local vs:number = .3;
	--SleepUntil([| volume_test_objects(VOLUMES.tv_demo_slipspawn, SPARTANS.locke)], 2);	
	--SleepUntil([| volume_test_player_lookat(VOLUMES.tv_demo_look_knight, SPARTANS.tanaka, 10, 1) ], 2, 960);
	SleepUntil([| ai_living_count(AI.e3_soldiers_sq_02.soldier_main)>=1], 2);
	SleepUntil([| ai_living_count(AI.e3_soldiers_sq_02.soldier_main)<=0], 2);
	sleep_s(3);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_a1);
	sleep_s(vs);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_a2);
	sleep_s(vs);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_b1);
	sleep_s(vs);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_b2);
	sleep_s(vs);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_c1);
	sleep_s(vs);
	CreateThread(slip_space_spawn_no_drops, AI.demo_fight_front_pawns_c2);
	sleep_s(vs);
	SleepUntil([|ai_living_count(AI.sg_demo_fight_pawns) >= 5], 3);
	sleep_s(vs);
	SleepUntil([|ai_living_count(AI.sg_demo_fight_pawns) <= 2], 3);
	CreateThread(narr_demo_buck_soldiers_listener);
	CreateThread( slip_space_spawn_no_drops, AI.demo_fight_upper_soldiers );	
end
function officer_maker():void
	SleepUntil([| volume_test_object(VOLUMES.tv_demo_objcon_30, SPARTANS.locke)], 2);
	RunClientScript("client_officerstorm");
	demo_officers();
end
function demo_upper_soldier_listener():void
	SleepUntil( [|	object_valid("cr_soldier_spawner_target")	], 5);
	SleepUntil(	[|	object_get_health(OBJECTS.cr_soldier_spawner_target) <= 0 ], 5);		-- invisible crate that needs to be shot in order to spawn soldiers

end
function demo_named_soldier_listener():void
	SleepUntil(	[|	ai_living_count(AI.demo_fight_upper_soldiers) >= 1], 5);
	SleepUntil(	[|	ai_living_count(AI.demo_fight_upper_soldiers) <= 0], 2, 1800);
	sleep_s(.3);
	slip_space_spawn_no_drops(AI.sg_demo_fight_named_soldiers);
end
function demo_soldier_squad():void
	slip_space_spawn_no_drops(AI.sg_demo_fight_named_soldiers);
end
function demo_fight_objcon_manager():void
	SleepUntil([|	volume_test_players(VOLUMES.tv_demo_objcon_10)
				or	var_demo_fight_objcon >= 10
				], 2);
	if( var_demo_fight_objcon <= 10)then
		var_demo_fight_objcon = 10;
	end
	SleepUntil([|	volume_test_players(VOLUMES.tv_demo_objcon_20)
				or	var_demo_fight_objcon >= 20
				], 2);

	if( var_demo_fight_objcon <= 20)then
		var_demo_fight_objcon = 20;
	end
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_objcon_30)				-- look at approaching spartans and taunt, then shoot )30( 
				or	var_demo_fight_objcon >= 30
				], 2);
	if( var_demo_fight_objcon <= 30)then
		var_demo_fight_objcon = 30;
	end
	SleepUntil([| ai_living_count(AI.demo_fight_officers) >= 1], 2);
	Sleep(3);
	SleepUntil([| ai_living_count(AI.demo_fight_officers) <= 0], 2);
	sleep_s(1);
--	NarrativeQueue.QueueConversation(E3Demo_reach_Guardian);
--	SleepUntil([| NarrativeQueue.HasConversationFinished(E3Demo_reach_Guardian)], 3);
	CreateThread(demo_warden);
end
function vale_adds_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_vale_fight , SPARTANS.vale)], 2);
	ai_place(AI.demo_fight_pawns_knight);
end


-- COMMAND SCRIPTS, FIGHT:---------------------------------------------------------------------------------------------------------------------------------------------
function cs_fight_soldier_a():void
	cs_aim_object(ai_current_actor, true, SPARTANS.tanaka);
	sleep_s(.2);
	cs_shoot(ai_current_actor, true, SPARTANS.tanaka);
	sleep_s(1);
	ai_set_blind(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
	sleep_s(.05);
	cs_push_stance(ai_current_actor, "flee");
	cs_go_to(POINTS.demo_fight_pts.a);
	cs_go_to(POINTS.demo_fight_pts.b);
	ai_erase(ai_current_actor);
end
function cs_fight_pawn_c():void
	cs_go_to(POINTS.demo_fight_pts.c);
end
function cs_fight_pawn_d():void
	cs_go_to(POINTS.demo_fight_pts.d);
end
function cs_fight_pawn_e():void
	cs_go_to(POINTS.demo_fight_pts.e);
end
function cs_fight_pawn_greeter():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_pawn_go)], 2);
	cs_go_to(POINTS.demo_fight_pts.pg);
	ai_erase(AI.demo_fight_soldiers_a);
end
function cs_officer_a():void
	object_set_shield( ai_get_object( ai_current_actor) ,0.60);
	object_set_health( ai_get_object( ai_current_actor) ,0.60);
	sleep_s(.7);
	cs_custom_animation(AI.demo_fight_officers.spawnpoint28, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:cheer", true);
	unit_get_custom_animation_time(AI.demo_fight_officers.spawnpoint28);
	cs_stop_custom_animation(AI.demo_fight_officers.spawnpoint28);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
				cs_aim(true, POINTS.demo_fight_pts.o1);
				Sleep(20);
				cs_shoot_at(true, POINTS.demo_fight_pts.o1);
				sleep_s(.5);		
	repeat
		local dice:number = random_range(1,3);
			if(dice == 1)then
				cs_aim(true, POINTS.demo_fight_pts.o1);
				Sleep(3);
				cs_shoot_at(true, POINTS.demo_fight_pts.o1);
				sleep_s(.5);		
			elseif(dice == 2)then
				cs_aim(true, POINTS.demo_fight_pts.o2);
				Sleep(3);
				cs_shoot_at(true, POINTS.demo_fight_pts.o2);
				sleep_s(.5);		
			else
				cs_aim(true, POINTS.demo_fight_pts.o3);
				Sleep(3);
				cs_shoot_at(true, POINTS.demo_fight_pts.o3);
				sleep_s(.5);		
			end
	until(false);
end

function cs_officer_b():void
	cs_enable_targeting(ai_current_actor, true);
--	sleep_s(.5);
--	cs_custom_animation(AI.demo_fight_officers.spawnpoint29, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:dive_front", true);
--	unit_get_custom_animation_time(AI.demo_fight_officers.spawnpoint29);
--	cs_stop_custom_animation(AI.demo_fight_officers.spawnpoint29);
--	cs_go_to_and_face(POINTS.demo_fight_pts.ob1, POINTS.demo_fight_pts.ob2);
--	ai_prefer_target_ai(AI.demo_fight_officers.spawnpoint29, SPARTANS.buck);
	cs_enable_targeting(ai_current_actor, true);
	ai_set_blind(ai_current_actor, false);
	ai_set_deaf(ai_current_actor, false);
	cs_custom_animation(AI.demo_fight_officers.spawnpoint29, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:evade_left", true);
--	cs_enable_moving(ai_current_actor, true);
	cs_custom_animation(AI.demo_fight_officers.spawnpoint29, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:evade_right", true);
	unit_get_custom_animation_time(AI.demo_fight_officers.spawnpoint29);
	cs_stop_custom_animation(AI.demo_fight_officers.spawnpoint29);
	repeat
	cs_aim(true, POINTS.demo_fight_pts.ob3);
	sleep_s(.1);
	cs_shoot_at(true, POINTS.demo_fight_pts.ob3);
	sleep_s(2);
	cs_aim(true, POINTS.demo_fight_pts.ob2);
	sleep_s(.1);
	cs_shoot_at(true, POINTS.demo_fight_pts.ob2);
	sleep_s(2);
	until(false);
--[[
	repeat
				cs_aim(true, POINTS.demo_fight_pts.ob2);
				Sleep(3);
				cs_shoot_at(true, POINTS.demo_fight_pts.ob2);
				sleep_s(2);
				cs_aim(true, POINTS.demo_fight_pts.ob3);
				Sleep(3);
				cs_shoot_at(true, POINTS.demo_fight_pts.ob3);
				sleep_s(2);
	until(false);
--]]
end

function cs_fight_upper_soldier_a():void
	ai_braindead(ai_current_actor, true);
	SleepUntil(	[|	volume_test_players_lookat(VOLUMES.tv_demo_look_3, 10, 30) ], 1);
--	cs_enable_targeting(ai_current_actor, true);
--	cs_push_stance(ai_current_actor, "flee");
--	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);	
--	cs_go_to(POINTS.demo_fight_pts.up1);
	ai_braindead(ai_current_actor, false);
	repeat
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"bunker:rifle:any:right_crouch_closed:enter", true);
	--	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"bunker:rifle:any:right_crouch_closed:idle", true);
	--	sleep_s(1.4);		-- <---- ADJUST TIMING HERE
		cs_custom_animation(AI.demo_fight_upper_soldiers.spawnpoint38, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"bunker:rifle:any:right_crouch_closed:peek", true);
		cs_custom_animation(AI.demo_fight_upper_soldiers.spawnpoint38, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"bunker:rifle:any:right_crouch_closed:exit", true);
		unit_get_custom_animation_time(AI.demo_fight_upper_soldiers.spawnpoint38);
		cs_aim(true, POINTS.demo_fight_pts.upshot1);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_fight_pts.upshot1);
		sleep_s(3);
	until(false);
--	cs_stop_custom_animation(AI.demo_fight_upper_soldiers.spawnpoint38); 
	cs_enable_targeting(ai_current_actor, true);
	cs_enable_moving(ai_current_actor, true);
end
function cs_fight_upper_soldier_b():void
	SleepUntil(	[|	volume_test_player_lookat(VOLUMES.tv_demo_look_3, SPARTANS.locke, 10, 25) ], 1);
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.5, 0.5 );
	sleep_s(.75);
	cs_go_to(POINTS.demo_fight_pts.up2);
	cs_custom_animation(AI.demo_fight_upper_soldiers.spawnpoint37, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);
	unit_get_custom_animation_time(AI.demo_fight_upper_soldiers.spawnpoint37);
	cs_stop_custom_animation(AI.demo_fight_upper_soldiers.spawnpoint37);
--	cs_go_to(POINTS.demo_fight_pts.up3);
	cs_enable_targeting(ai_current_actor, true);
	cs_enable_moving(ai_current_actor, false);
	sleep_s(2);
	cs_custom_animation(AI.demo_fight_officers.spawnpoint29, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:evade_left", true);
--	cs_enable_moving(ai_current_actor, true);
	cs_custom_animation(AI.demo_fight_officers.spawnpoint29, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:evade_right", true);
	sleep_s(20);
end

global v_gpmg:boolean = false;
function gpmg_listener():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_gpmg, SPARTANS.locke)], 1);
	v_gpmg = true
end
function cs_groundpound_mcgee():void
	cs_enable_targeting(ai_current_actor, true);
	CreateThread(gpmg_listener);
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:dive_right", true); 
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);

	
	repeat
		cs_aim(true, POINTS.demo_fight_pts.gpmg_shot);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_fight_pts.gpmg_shot);
		sleep_s(.5);
	until(v_gpmg == true);

--[[
	cs_push_stance(ai_current_actor, "flee");
	cs_go_to(POINTS.demo_fight_pts.gpmg);
--]]
-- hi. If you're here because the fake bamf/teleport bit isn't working out, that's ok. I forgive you.
-- Just comment out the following, and uncomment the preceding. Have a good rest of your weekend.
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);
	cs_teleport(ai_current_actor, POINTS.demo_gpm.tp1, POINTS.demo_gpm.tp2);
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf", true);
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);
------------------------------- /end

	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.2, 0.2 );
	cs_aim_object(ai_current_actor, true, SPARTANS.locke);
	sleep_s(.5);
	cs_shoot(ai_current_actor, true, SPARTANS.locke);
	sleep_s(4);
	cs_aim_object(ai_current_actor, true, SPARTANS.locke);
	sleep_s(.5);
	cs_shoot(ai_current_actor, true, SPARTANS.locke);
	sleep_s(4);
end
function cs_locke_soldier():void
	cs_enable_targeting(ai_current_actor, true);
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.5, 0.5 );
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:dive_back", true); 
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);
	cs_go_to(POINTS.demo_fight_pts.locke_root);
	repeat
		cs_aim(true, POINTS.demo_fight_pts.locke_shot);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_fight_pts.locke_shot);
		sleep_s(2);
	until(false) ;
end
function cs_vale_soldier():void
	cs_enable_targeting(ai_current_actor, true);
	unit_set_maximum_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:dive_left", true); 
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);
	cs_go_to(POINTS.demo_fight_pts.vale_root);
	repeat
		cs_aim(true, POINTS.demo_fight_pts.vale_shot);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_fight_pts.vale_shot);
		sleep_s(2);
	until(false) ;
end
function cs_tanaka_soldier():void
	SleepUntil([| var_demo_fight_objcon >= 20], 2);
	cs_go_to(POINTS.demo_gpm.a);
	repeat
		cs_aim(true, POINTS.demo_gpm.s1);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_gpm.s1);
		sleep_s(2);
	until(false) ;
end
function cs_buck_soldier():void
	cs_enable_targeting(ai_current_actor, true);
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.6, 0.6 );
	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:dive_front", true); 
	unit_get_custom_animation_time(ai_current_actor);
	cs_stop_custom_animation(ai_current_actor);
--	cs_custom_animation(ai_current_actor, true, TAG('objects\characters\soldier\soldier.model_animation_graph'),"combat:rifle:bamf:var1", true);	
--	cs_go_to(POINTS.demo_fight_pts.buck_root);
	repeat
		cs_aim(true, POINTS.demo_fight_pts.buck_shot);
		sleep_s(.5);
		cs_shoot_at(true, POINTS.demo_fight_pts.buck_shot);
		sleep_s(2);
	until(false) ;
end
function cs_gpm_soldier():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,.5, .5);
end

function soldierstorm():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_soldierstorm, SPARTANS.locke)], 1);
--	demo_ai_place_no_drops(AI.demo_soldierstorm);
	demo_ai_place_no_drops(AI.e3_soldiers_sq_02);
	Sleep(2);
	composer_play_show("vin_e3_soldier_encounter_02");
	RunClientScript("client_soldierstorm");
	Sleep(3);
	unit_set_current_vitality( ai_get_object( AI.e3_soldiers_sq_02.soldier_main) ,0.35, 0.35 );
--	unit_set_current_vitality( ai_get_object( AI.e3_soldiers_sq_02.soldier_main_bg) ,0.5, 0.5 );
	unit_doesnt_drop_items(ai_actors( AI.e3_soldiers_sq_02));
	SleepUntil([| b_soldierstorm_2 == true], 2);
	NarrativeQueue.QueueConversation(E3Demo_post_phaeton_soldier_appears);		-- target profiles are complete, soldiers
	RunClientScript("client_soldierstorm_2");

	SleepUntil([| ai_living_count(AI.e3_soldiers_sq_02)<=0], 2);
	sleep_s(4.8);											--    <--- delay for vo timing
--	NarrativeQueue.QueueConversation(E3Demo_FINAL_FIGHT_AREA_ENTER);			-- whatever deal the chief had, they're not letting us through -- NO LONGER PLAYS
--	SleepUntil([| NarrativeQueue.HasConversationFinished(E3Demo_FINAL_FIGHT_AREA_ENTER)], 3);
	NarrativeQueue.QueueConversation(E3Demo_FINAL_FIGHT_AREA_scan);				-- (tracking scan vo) you guys go left, buck go right
end

-- NARRATIVE SCRIPTS, FIGHT: ------------------------------------------------------------------------------------------------------------------------------------------------

global v_demo_narrative_enter_finale:thread = nil;
global v_demo_narrative_finale_scan:thread = nil;
global v_demo_narrative_buck_on_turret:thread = nil;
global v_demo_narrative_turret_soldiers:thread = nil;
global v_demo_narrative_knight_appears:thread = nil;
global v_demo_narrative_knight_plate_1:thread = nil;
global v_demo_narrative_knight_plate_2:thread = nil;
global v_demo_narrative_after_assassination:thread = nil;
global v_demo_narrative_warden:thread = nil;
function demosys_kill_all_fight_narrative():void
	CreateThread(clear_demo_thread, v_demo_narrative_enter_finale);
	CreateThread(clear_demo_thread, v_demo_narrative_finale_scan);
	CreateThread(clear_demo_thread, v_demo_narrative_buck_on_turret);
	CreateThread(clear_demo_thread, v_demo_narrative_turret_soldiers);
	CreateThread(clear_demo_thread, v_demo_narrative_knight_appears);
	CreateThread(clear_demo_thread, v_demo_narrative_knight_plate_1);
	CreateThread(clear_demo_thread, v_demo_narrative_knight_plate_2);
	CreateThread(clear_demo_thread, v_demo_narrative_after_assassination);
--	CreateThread(clear_demo_thread, v_demo_narrative_warden);
end
function demosys_thread_up_fight_narrative():void
--	v_demo_narrative_enter_finale = CreateThread(narr_demo_enter_fight_listener);
--	v_demo_narrative_finale_scan = CreateThread(narr_demo_scan_fight_listener);
--	v_demo_narrative_buck_on_turret = CreateThread(narr_demo_buck_turret_listener);
--	v_demo_narrative_turret_soldiers = CreateThread(narr_demo_buck_soldiers_listener);
--	v_demo_narrative_knight_appears = CreateThread(narr_demo_knight_listener);
--	v_demo_narrative_knight_plate_1 = CreateThread(narr_demo_knight_plate_1_listener);
--	v_demo_narrative_knight_plate_2 = CreateThread(narr_demo_knight_plate_2_listener);
--	v_demo_narrative_after_assassination = CreateThread(narr_demo_knight_dead_listener);
--	v_demo_narrative_warden = CreateThread();
	CreateThread(narr_demo_plasmacaster_pickup_listener);
end
function narr_demo_plasmacaster_pickup_listener():void
	SleepUntil([| unit_has_weapon(SPARTANS.locke,  TAG('objects\weapons\rifle\covenant_grenade_launcher\covenant_grenade_launcher.weapon'))  ], 1);
--	Locke picks up the plasmacaster:
	NarrativeQueue.QueueConversation(E3Demo_PLASMACASTER_pickup);
end
function demosys_reset_fight_narrative_threads():void
	demosys_kill_all_fight_narrative();
	demosys_thread_up_fight_narrative();
end
function narr_demo_enter_fight_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_enter_fight)], 1);
	-- Enter arena, see enemies:
	NarrativeQueue.QueueConversation(E3Demo_FINAL_FIGHT_AREA_ENTER);
end
function narr_demo_scan_fight_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_fight_start)], 1);
	-- Scan the weapon cache:
	sleep_s(2);
	NarrativeQueue.QueueConversation(E3Demo_FINAL_FIGHT_AREA_scan);
end
function narr_demo_buck_turret_listener():void
	SleepUntil( [|	object_valid("cr_soldier_spawner_target")	], 5);
	SleepUntil(	[|	object_get_health(OBJECTS.cr_soldier_spawner_target) <= 0 ], 5);		-- invisible crate that needs to be shot in order to spawn soldiers
	-- Buck shoots Vale with turret:
--	NarrativeQueue.QueueConversation(E3Demo_buck_on_turret);
end
function narr_demo_buck_soldiers_listener():void
	SleepUntil([| ai_living_count(AI.demo_fight_upper_soldiers) > 0], 2);
	-- Soldiers appear while buck's on turret:
	NarrativeQueue.QueueConversation(E3Demo_THE_BIG_FIGHT);
end
function narr_demo_knight_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_objcon_30)], 1);
	-- Knight appears:
	NarrativeQueue.QueueConversation(E3Demo_KNIGHT_appears);
end
function narr_demo_knight_plate_1_listener():void
	SleepUntil([| ai_living_count(AI.vin_e3_knight_squad) >= 1], 1);
	SleepUntil([| unit_get_health(ai_get_object(AI.vin_e3_knight_squad)) <= .8], 1);
	-- Knock one plate off Knight:
	NarrativeQueue.QueueConversation(E3Demo_KNIGHT_one_plate);
end
function narr_demo_knight_plate_2_listener():void
	SleepUntil([| ai_living_count(AI.vin_e3_knight_squad) >= 1], 1);
	SleepUntil([| unit_get_health(ai_get_object(AI.vin_e3_knight_squad)) <= .5], 1);
	-- Knock second plate off knight:
	NarrativeQueue.QueueConversation(E3Demo_two_plate);
end
function narr_demo_knight_dead_listener():void
	SleepUntil([| ai_living_count(AI.vin_e3_knight_squad) >= 1], 1);
	SleepUntil([| ai_living_count(AI.vin_e3_knight_squad) <= 0], 1);
	-- After knight assassination:
--	NarrativeQueue.QueueConversation(E3Demo_KNIGHT_ASSASSINATION_post);
end


--[[

--]]


-- FLOCKS ----------------------------------------------------------------

function demo_tow_arcade_start():void
	flock_create("flock_e3_arb01");
	flock_create("flock_e3_arb03");
	flock_create("flock_e3_cov01");
	flock_create("flock_e3_cov03");
	flock_create("flock_seraph_e3_arb_01");
	flock_create("flock_seraph_e3_cov_01");
	Sleep(3);
	flock_start("flock_e3_arb01");
	flock_start("flock_e3_arb03");
	flock_start("flock_e3_cov01");
	flock_start("flock_e3_cov03");
	flock_start("flock_seraph_e3_arb_01");
	flock_start("flock_seraph_e3_cov_01");
end
function demo_tow_arcade_end():void
	flock_stop("flock_e3_arb01");
	flock_stop("flock_e3_arb03");
	flock_stop("flock_e3_cov01");
	flock_stop("flock_e3_cov03");
	flock_stop("flock_seraph_e3_arb_01");
	flock_stop("flock_seraph_e3_cov_01");
	Sleep(3);
	flock_delete("flock_e3_arb01");
	flock_delete("flock_e3_arb03");
	flock_delete("flock_e3_cov01");
	flock_delete("flock_e3_cov03");
	flock_delete("flock_seraph_e3_arb_01");
	flock_delete("flock_seraph_e3_cov_01");
end
function demo_tow_interior_start():void
	flock_create("flock_int_e3_arb01");
	flock_create("flock_int_e3_cov02");
	flock_create("flock_seraph_int_e3_arb_01");
	flock_create("flock_seraph_int_e3_cov_01");
	Sleep(3);
	flock_start("flock_int_e3_arb01");
	flock_start("flock_int_e3_cov02");
	flock_start("flock_seraph_int_e3_arb_01");
	flock_start("flock_seraph_int_e3_cov_01");
end
function demo_tow_interior_end():void 
	flock_stop("flock_int_e3_arb01");
	flock_stop("flock_int_e3_cov02");
	flock_stop("flock_seraph_int_e3_arb_01");
	flock_stop("flock_seraph_int_e3_cov_01");
	Sleep(3);
	flock_delete("flock_int_e3_arb01");
	flock_delete("flock_int_e3_cov02");
	flock_delete("flock_seraph_int_e3_arb_01");
	flock_delete("flock_seraph_int_e3_cov_01");
end
function demo_tow_fight_start():void
	flock_create("flock_int_e3_arb02");
	flock_create("flock_int_e3_cov01");
	flock_create("flock_seraph_int_e3_arb_02");
	flock_create("flock_seraph_int_e3_cov_02");
	Sleep(3);
	flock_start("flock_int_e3_arb02");
	flock_start("flock_int_e3_cov01");
	flock_start("flock_seraph_int_e3_arb_02");
	flock_start("flock_seraph_int_e3_cov_02");
end
function demo_tow_fight_end():void
	flock_stop("flock_int_e3_arb02");
	flock_stop("flock_int_e3_cov01");
	flock_stop("flock_seraph_int_e3_arb_02");
	flock_stop("flock_seraph_int_e3_cov_02");
	Sleep(2);
	flock_delete("flock_int_e3_arb02");
	flock_delete("flock_int_e3_cov01");
	flock_delete("flock_seraph_int_e3_arb_02");
	flock_delete("flock_seraph_int_e3_cov_02");
end
function demo_arcade_create_flocks()
	flock_create("flock_e3_arb03");
	flock_create("flock_e3_cov03");
	flock_create("flock_seraph_e3_arb_01");
	flock_create("flock_seraph_e3_cov_01");
end
function demo_arcade_destroy_flocks()
	flock_stop("flock_e3_arb03");
	flock_stop("flock_e3_cov03");
	flock_stop("flock_seraph_e3_arb_01");
	flock_stop("flock_seraph_e3_cov_01");
	Sleep(2);
	flock_destroy("flock_e3_arb03");
	flock_destroy("flock_e3_cov03");
	flock_destroy("flock_seraph_e3_arb_01");
	flock_destroy("flock_seraph_e3_cov_01");
end






--## CLIENT
function remoteClient.client_dampen(v_damp:number):void
	player_control_scale_all_input(v_damp, .1);
end
function remoteClient.client_undampen():void
	player_control_scale_all_input(1, .1);
end
function remoteClient.client_dampen_player(v_damp:number):void
	if (PLAYERS.local0 ~= unit_get_player(SPARTANS.locke)) then
		player_control_scale_all_input(v_damp, .1);
	end
end
function remoteClient.client_arcade_explosion_small(fl:flag):void
		effect_new (TAG('fx\library\sandbox\explosions\covenant_explosion_small\covenant_explosion_small.effect'), fl);
end
function remoteClient.client_arcade_explosion_medium(fl:flag):void
		effect_new (TAG('fx\library\sandbox\explosions\covenant_explosion_medium\covenant_explosion_medium.effect'), fl);
end
function remoteClient.client_arcade_explosion_large(fl:flag):void
		effect_new (TAG('fx\library\sandbox\explosions\covenant_explosion_large\covenant_explosion_large.effect'), fl);
end
function remoteClient.client_arcade_explosion(fl:flag):void
		effect_new (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), fl);
end
--effect_new (TAG('fx\library\sandbox\explosions\covenant_explosion_medium\covenant_explosion_medium.effect'), FLAGS.fl_demo_arcade_fx_1);
function remoteClient.client_tension_ripple():void
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_1);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_2);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_3);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_4);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_5);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_6);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a1);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_7);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a2);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_8);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a3);

		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_9);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a4);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_10);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a5);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_11);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a6);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_tension_a7);
		sleep_s(.12);
		sleep_s(.12);
		sleep_s(.12);
--		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_eyes.effect'), FLAGS.fl_demo_tension_eyes);
end
function remoteClient.client_tension_ripple_vtol():void
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_vtt_1);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_vtt_2);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_vtt_3);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_vtt_4);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_demo_vtt_5);
		sleep_s(.12);
end
function remoteClient.client_tension_ripple_ff():void
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_ff_lead_1);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_ff_lead_2);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_ff_lead_3);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_ff_lead_4);
		sleep_s(.12);
		effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_black_fade.effect'), FLAGS.fl_ff_lead_5);
		sleep_s(.12);
end

function remoteClient.client_soldierstorm():void
	effect_new (TAG('fx\library\slip_space\generic\slipspace_main_sandbox_nolead.effect'), FLAGS.fl_demo_soldierstorm_1);
end
function remoteClient.client_soldierstorm_2():void
	effect_new (TAG('fx\library\slip_space\generic\slipspace_main_sandbox_nolead.effect'), FLAGS.fl_demo_soldierstorm_2);
end
function remoteClient.client_officerstorm():void
	effect_new (TAG('fx\library\slip_space\generic\slipspace_main_sandbox_nolead.effect'), FLAGS.fl_officer_a);
	effect_new (TAG('fx\library\slip_space\generic\slipspace_main_sandbox_nolead.effect'), FLAGS.fl_officer_b);
end

-- RunClientScript("client_eyes");
function remoteClient.client_eyes():void
	effect_new (TAG('fx\scratch\jeffpalmer\for_spawn_in_eyes.effect'), FLAGS.fl_demo_tension_01);
end
function remoteClient.demo_shade_client(obj:object):void
	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_covenant\fire_cov_sml_nosmoke_t0.effect'), obj,  "body"); 
end
function remoteClient.demo_wraith_client(fl:flag):void
	effect_new (TAG('fx\library\fire\fire_covenant\fire_cov_md_nosmoke_t0.effect'), fl); 
--	effect_new (TAG('fx\library\fire\fire_covenant\fire_cov_sml_nosmoke_t0.effect'), FLAGS.fl_demo_wraith); 
end

function remoteClient.client_incinerate(fl:flag):void
--		effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_main_detonation.effect'), fl);
		effect_new (TAG('objects\weapons\support_high\rocket_launcher\fx\detonation.effect'), fl);
		effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\forerunner_incineration_rocket_explode.effect'), fl);
		effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_main_detonation.effect'), fl);
		effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_submunition_detonation.effect'), fl);
end
function remoteClient.firefleebie(grunt:object):void
--	effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_sml_t0.effect'), grunt,  "left_foot");
-- effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_md_nosmoke_t0.effect'), grunt,  "weapon_thigh");
	effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_md_nosmoke_t0.effect'), grunt,  "target_backpack");
--	effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_sml_t0.effect'), grunt,  "weapon_thigh");

--	effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_md_t0.effect'), grunt,  "left_foot");
--	effect_new_on_object_marker (TAG(''), grunt,  "left_foot");
--	effect_new_on_object_marker (TAG('fx\library\fire\fire_covenant\fire_cov_hero.effect'), grunt,  "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), grunt,  "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_covenant\fire_cov_sml_nosmoke_t0.effect'), grunt,  "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt2, "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt3, "head");
end
function remoteClient.explodeyfleebie(grunt:object):void
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_small\covenant_explosion_small.effect'), grunt,  "weapon_thigh");
--	Sleep(1);
--	object_damage_damage_section(grunt, "rocket", 120);
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt2, "head");
--	effect_new_on_object_marker_loop (TAG('fx\library\fire\fire_unsc\fire_unsc_flames_md_t0.effect'), AI.sq_dest_panicgrunts.grunt3, "head");
end
function remoteClient.fleebie_sniped(grunt:object):void
	effect_new_on_object_marker(TAG('objects\weapons\rifle\sniper_rifle\projectiles\sniper_rifle_bullet.damage_effect'), grunt, "target_backpack");
end
function remoteClient.hud_reduce():void
	hud_show_messages(false);
	hud_show_navpoints(false);
	hud_show_navpoints_offscreen(false);
	hud_show_navpoints_revive(false);
end

function remoteClient.client_pin_texture():void
		streamer_pin_tag(TAG('levels\assets\osiris\material_tiles\sangheli\tsunami_station\tsun_concrete_01_floor_wz_finalfight.material'));
		
end
-- effect_new (TAG('objects\weapons\support_high\rocket_launcher\fx\detonation.effect'), FLAGS.fl_incinerate_1);
-- effect_new (TAG('objects\weapons\support_high\storm_forerunner_incineration_launcher\fx\forerunner_incineration_rocket_explode.effect'), FLAGS.fl_incinerate_1);
-- effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_submunition_detonation.effect'), FLAGS.fl_incinerate_1);
-- effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_grenade_detonation.effect'), FLAGS.fl_incinerate_1);
-- effect_new (TAG('objects\weapons\support_high\incineration_cannon\fx\fr_incin_main_detonation.effect'), FLAGS.fl_incinerate_1);
-- RunClientScript("client_incinerate", FLAGS.fl_incinerate_1);