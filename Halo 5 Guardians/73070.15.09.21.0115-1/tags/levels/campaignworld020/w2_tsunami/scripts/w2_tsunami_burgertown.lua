--## SERVER

--[[
██████╗ ██╗   ██╗██████╗  ██████╗ ███████╗██████╗ ████████╗ ██████╗ ██╗    ██╗███╗   ██╗
██╔══██╗██║   ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
██████╔╝██║   ██║██████╔╝██║  ███╗█████╗  ██████╔╝   ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
██╔══██╗██║   ██║██╔══██╗██║   ██║██╔══╝  ██╔══██╗   ██║   ██║   ██║██║███╗██║██║╚██╗██║
██████╔╝╚██████╔╝██║  ██║╚██████╔╝███████╗██║  ██║   ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
--]] 
global v_burgertown_objcon:number=0;
global v_tangletown_objcon:number=0;
global v_turrettown_objcon:number=0;
global v_burgertown_gunner_apathy:number=0;
global b_turr0_explained:boolean=false;
global b_turr0_arbiter_in_place:boolean=false;
global blowuppowersource0:boolean=false;
global b_arbycanleave:boolean=false;
global b_arbycantalk:boolean=false;
global b_shrike_0:boolean = true;
global b_shrike_1:boolean = true;
global b_shrike_2:boolean = true;
global b_shrike_3:boolean = true;
global b_shrike_4:boolean = true;
global b_shrike_5:boolean = true;
global b_forko:boolean = true;
global v_shrike_tally:number=0;
global arbiter_turr0_timetoleave:boolean = false;
global g_chantinggrunts:number = nil;
global arbiter_make_control:boolean = false;
global arbiter_in_place:boolean = false;
global b_door1_enemystart:boolean = false;
global burgertown_fallback:boolean = false;
global b_turret_building_1_breach:boolean = false;
global b_turret_building_1:boolean = false;
global b_turret_building_2:boolean = false;
global b_chantbreak:boolean = false;
global b_ninjas_spotted:boolean = false;
global var_intro_ai_count:number = 0;

--//=========//	Table and Startup	//=========//--

function missionstart_spawner():void
	ai_place (AI.gr_turret0_all);
	ai_place (AI.gr_arbiter_turret0);
	composer_play_show("shrike_intro");
	composer_play_show("shrike_burgertown");	
	Sleep(2);
	NavpointShowAllServer(AI.sq_turr0_arbiter_c.spawnpoint99, "ally");
	NavpointShowAllServer(AI.sq_turr0_arbiter_b.spawnpoint97, "ally");
	NavpointShowAllServer(AI.sq_turr0_arbiter_b.spawnpoint98, "ally");
	CreateThread(shrike_0);
	var_intro_ai_count = ai_living_count(AI.gr_turret0_all);
	sleep_s (1);
	CreateThread (arbiter_turr0_tracker);
end

function burgertown():void											-- basically burgertown.start
	print("burgertown init");
	CreateThread (burgertown_aispawn);
	CreateThread (dogfight_01);
	CreateThread (dogfight_03);
	CreateThread (dogfight_04);
	CreateThread (dogfight_08);
	CreateThread (dogfight_09);
--	CreateThread (dogfight_10);
	CreateThread (phantom_crash_01);
	CreateThread (aa_fx_sequence_brgr);
	CreateThread (burgertown_crates);
	CreateThread (hamfisted_cleanup_of_intro);
	CreateThread (close_burgertown_entrance);
	CreateThread (flock_bt_tangle_transition);
	print ("Turret in Burgertown can be ordered destroyed meow");
		--	NARRATIVE CALL
		CreateThread(tsunami_burgertown_load);
	game_save_no_timeout();
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_init)], 1);
	--object_create("dm_shriketurret_01");
	CreateThread(shrike_1);
	CreateThread (shrike_1_reminder);
	CreateThread (tow_aa_battery_3);
	--CreateThread (burgertown_musicstart);
	CreateThread (bt_objcon_3);
	CreateThread (bt_objcon_7);
	CreateThread (bt_objcon_10);
	CreateThread (bt_objcon_20);
	CreateThread (bt_objcon_30);
	CreateThread (bt_objcon_40);
	CreateThread (bt_objcon_50);
end

function hamfisted_cleanup_of_intro():void
	SleepUntil(	[|	
					(	volume_test_players_all(VOLUMES.tv_burgertown_all) 
					and	MusketeersInVolume(VOLUMES.tv_turr0_arbiterexplains) == false
					)

					or

					(	volume_test_players_all(VOLUMES.tv_burgertown_all) 
					and	v_burgertown_objcon >= 7
					)

				], 5);
	
	device_set_position (OBJECTS.dm_tsu_door_01, 0);
	sleep_s(.5)
	battery_1 = 1;																					-- kill AA fire
	object_destroy_folder(MODULES.cr_turret0);
	object_destroy_folder(MODULES.cr_weap_intro);
	object_destroy (OBJECTS.shrike_power_source_0);
	object_destroy (OBJECTS.dm_shriketurret_00);
	CreateThread(stop_valid_composition, var_dogfight_07);
	KillThread(thread_rescuebox);
	Sleep(2);
	garbage_collect_now();

end
function close_burgertown_entrance():void
	SleepUntil([| volume_test_players(VOLUMES.tv_close_bt_door) == false], 20);
	object_create("dm_tsu_door_bte");
end
function burgertown_aispawn():void
	ai_place (AI.gr_burgertown_all_exterior);
	ai_place (AI.sq_bt_upperjumpers_a);
	ai_place (AI.sq_bt_upperjumpers_b);
	Sleep(2);
	CreateThread(jumper_replenisher);
	CreateThread(rearguard_replenisher);
	local n:number = ai_living_count(AI.gr_burgertown_all);											-- as of press time, 16
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_20)], 1);
	ai_place (AI.gr_burgertown_all_interior);
	CreateThread(burgertown_cheevo_listener);
	Sleep(1);
	n = n + ai_living_count(AI.gr_burgertown_all_interior);											-- as of press time, should total (up to a max of) 25
	ai_place (AI.sq_door_02);																		-- not part of burgertown_all
	print ("waiting for Burgertown fallback");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_fallback)
				or ai_living_count (AI.gr_burgertown_all) <= (n - 16)								-- as of press time, (n -16) == a max of 9
				], 1);
	burgertown_fallback = true;
	battery_2 = 1;																					-- kill AA fire
	print ("Burgertown falling back");
end
function rearguard_replenisher():void
	SleepUntil(	[|	(	ai_living_count(AI.sq_bt_rearground_greet)
					)	<= 0
				], 5);
	SleepUntil(	[|	(	ai_living_count(AI.gr_burgertown_all)	<= 18)
				], 5);
	if(v_burgertown_objcon <= 19)then
		ai_place (AI.sq_bt_rearground);
		Sleep(2);
	end
end

function jumper_replenisher():void
	SleepUntil(	[|	(	ai_living_count(AI.gr_bt_upperjumpers_a)
					+	ai_living_count(AI.gr_bt_upperjumpers_b)
					)	<= 2
				], 5);
	SleepUntil(	[|	(	ai_living_count(AI.gr_burgertown_all)	<= 18)
				], 5);
	if(v_burgertown_objcon <= 39)then
		ai_place (AI.sq_bt_upperjumpers_a2);
		Sleep(2);
	end
	SleepUntil(	[|	(	ai_living_count(AI.gr_bt_upperjumpers_a)
					+	ai_living_count(AI.gr_bt_upperjumpers_b)
					)	<= 2
				], 5);
	SleepUntil(	[|	(	ai_living_count(AI.gr_burgertown_all)	<= 18)
				], 5);
	if(v_burgertown_objcon <= 39)then
		ai_place (AI.sq_bt_upperjumpers_b2);
	end
end

function arbiter_turr0_tracker():void
	sleep_s(1);
	ai_object_set_team(OBJECTS.shrike_power_source_0, TEAM.brute);
	ai_allegiance (TEAM.player, TEAM.brute);
	SleepUntil ([|	ai_living_count (AI.gr_turret0_all) <= 0], 2);
	ai_object_set_team(OBJECTS.dm_shriketurret_00, TEAM.covenant);
	ai_object_set_team(OBJECTS.shrike_power_source_0, TEAM.brute);
	CreateThread(arbros_attack_turr0);
	ai_allegiance_break (TEAM.player, TEAM.brute);
	ai_object_enable_targeting_from_vehicle(OBJECTS.dm_shriketurret_00, true);
	ai_object_enable_targeting_from_vehicle(OBJECTS.shrike_power_source_0, true);
	ai_object_set_targeting_bias(OBJECTS.shrike_power_source_0, -.1);			-- to prevent Arbros from shooting (and killing before player has a chance) 7/13/15
	
	cs_run_command_script (AI.sq_turr0_arbiter_a.spawnpoint81, "cs_turr0_arbiter_goto");
	
	SleepUntil ([|	b_shrike_0 == false], 2);

	sleep_s (.2);
--	SleepUntil ([|	b_turr0_arbiter_in_place == true], 1);											-- set in composition
--	print ("Arbiter awaiting player");

	SleepUntil ([|	b_turr0_explained], 1);
	--	b_turr0_explained = true;																--	Commented from Here, added at the end of the dialogue W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__arbiter  - guillaume
	print ("Arby should be talking now");
	CreateThread(arbiter_eraser);
	sleep_s (2.5);
	blowuppowersource0 = true;
	sleep_s (3.6);
	b_arbycanleave = true;
	sleep_s (1.9);
	NavpointStopAllServer(AI.sq_turr0_arbiter_c.spawnpoint99);
	NavpointStopAllServer(AI.sq_turr0_arbiter_b.spawnpoint97);
	NavpointStopAllServer(AI.sq_turr0_arbiter_b.spawnpoint98);
end
function cs_shoot_turr0():void
	cs_enable_moving(ai_current_actor, true);
	repeat
		cs_enable_moving(ai_current_actor, true);
		ai_set_blind(ai_current_actor, false);
		cs_shoot(ai_current_actor, true, OBJECTS.dm_shriketurret_00);
		sleep_s(random_range(1, 4));
		ai_set_blind(ai_current_actor, true);
		sleep_s(random_range(2, 4));
	until(b_shrike_0 == false);

end
function arbros_attack_test():void
	ai_place(AI.sq_turr0_arbiter_c.spawnpoint99);
	ai_place(AI.sq_turr0_arbiter_b.spawnpoint97);
	ai_place(AI.sq_turr0_arbiter_b.spawnpoint98);
	object_create("dm_shriketurret_00");
	sleep_s(8);
	arbros_attack_turr0();
end
function arbros_attack_turr0():void
	cs_run_command_script(AI.sq_turr0_arbiter_c.spawnpoint99, "cs_shoot_turr0");
	cs_run_command_script(AI.sq_turr0_arbiter_b.spawnpoint97, "cs_shoot_turr0");
	cs_run_command_script(AI.sq_turr0_arbiter_b.spawnpoint98, "cs_shoot_turr0");
end
function nuke_arbiter_sword():void	-- add to end of arbiter speech comp
	b_door1_enemystart = true;
	sleep_s(.5);
	unit_drop_weapon(AI.sq_turr0_arbiter_a.spawnpoint81, OBJECTS.w_arbysword, 1);
	Sleep(2);
	unit_add_weapon(AI.sq_turr0_arbiter_a.spawnpoint81, OBJECTS.w_arbygun, 3);
	cs_push_stance(AI.sq_turr0_arbiter_a.spawnpoint81, "flee");
end
function arbiter_eraser():void
	repeat
		for _, obj in ipairs (volume_return_objects(VOLUMES.tv_arbiter_erase)) do
			ai_erase(object_get_ai(obj));
		end
	Sleep(10);
	until(ai_living_count(AI.gr_arbiter_turret0) <= 0);
	ai_erase (AI.gr_arbiter_turret0);
end
function tsu_door_checker():void															-- needs to be split up for blinks
	SleepUntil( [| b_shrike_0 == false], 2 );
	CreateThread (flock_burgertown_client);													-- start Burgertown TOW flocks
	SleepUntil ([|	b_door1_enemystart == true], 1);
	sleep_s (.5);
	--object_create ("temp_alarmlights");
	--object_create ("temp_siren");
	--	sleep_s (2);																							---	for Grunt to be heard, they need to be present.			Guillaume 01/05/15
	--	NARRATIVE CALL
	CreateMissionThread (title_objective_disable);
	CreateThread(tsunami_missionstart_door_opening_covies);
	tsunami_missionstart_door_opening_osiris();
	--missing_content_text ("**GRUNTS CAN BE HEARD ON THE OTHER SIDE OF THE DOOR**", 360);
	device_set_position (OBJECTS.dm_tsu_door_01, 1);
	ai_place (AI.sq_door_01);
	--CreateThread (turret0_dooropen_musicstart);
	object_destroy (OBJECTS.temp_siren);
end
function bt_objcon_3():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_3)], 1);
	if( v_burgertown_objcon < 3)then
		v_burgertown_objcon = 3;
	end
end
function bt_objcon_7():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_7)], 1);
	if( v_burgertown_objcon < 7)then
		v_burgertown_objcon = 7;
	end
end
function bt_objcon_10():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_10)], 1);
	if( v_burgertown_objcon < 10)then
		v_burgertown_objcon = 10;
	end
end
function bt_objcon_20():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_20)], 1);
	if( v_burgertown_objcon < 20)then
		v_burgertown_objcon = 20;
	end
end
function bt_objcon_30():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_30)], 1);
	if( v_burgertown_objcon < 30)then
		v_burgertown_objcon = 30;
	end
end
function bt_objcon_40():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_40)], 1);
	if( v_burgertown_objcon < 40)then
		v_burgertown_objcon = 40;
	end
end
function bt_objcon_50():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_objcon_50)], 1);
	if( v_burgertown_objcon < 50)then
		v_burgertown_objcon = 50;
	end
end
function cs_go_on_3():void
	SleepUntil ([|	v_burgertown_objcon >= 3
				or	volume_test_players_lookat(VOLUMES.tv_burgo_look, 28, 3) 
				], 1);
end
function cs_go_on_7():void
	cs_abort_on_damage(true);
	SleepUntil ([|	v_burgertown_objcon >= 7], 1);
end
function cs_go_on_7_with_delay():void
	cs_abort_on_damage(true);
	SleepUntil ([|	v_burgertown_objcon >= 7], 1);
	sleep_s(random_range(0,3));
end
function cs_bt_upper_d():void
	SleepUntil ([|	v_burgertown_objcon >= 3
				or	volume_test_players_lookat(VOLUMES.tv_burgo_look, 28, 3) 
				], 1);
	cs_go_to(POINTS.ps_burger.a01);
	cs_go_to(POINTS.ps_burger.a02);
end
function cs_elite_greeter():void
	cs_abort_on_damage(true);
	cs_abort_on_alert(true);
	cs_go_to(POINTS.ps_burger.a03);
	cs_go_to(POINTS.ps_burger.a04);
end
function look_at_test_burgo():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_burgo_look, 28, 3) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
--- cheevo stuff:

global groundpoundStringID = get_string_id_from_string("ground_pound");
global num_gruntpount:number = 0;
global thread_cheevo:thread = nil;
global thread_cheevo_windowcloser:thread = nil;

function burgertown_cheevo_listener():void														-- called once the interior grunts are spawned in bt
	thread_cheevo				= CreateThread(cheevo_detecto);
	thread_cheevo_windowcloser	= CreateThread(gruntpount_windowcloser);
	SleepUntil([| volume_test_players_all(VOLUMES.tv_tangletown)], 3);
	KillThread(thread_cheevo);
	KillThread(thread_cheevo_windowcloser);
end
function cheevo_detecto():void
	
	for _, dude in pairs(ai_actors(AI.gr_burgertown_all)) do
		RegisterDeathEvent(BurgertownAnyDeath, dude);														-- register death events on everyone in burgertown
--		print("toetag issued");
	end

--	SleepUntil([|volume_test_players(VOLUMES.tv_cheevo_air)], 1);											-- wait until player passes through air volume [waive this requirement per strict reading of achievement text]

	SleepUntil( [| object_damage_section_get_health(OBJECTS.tsu_groundpound_vent_a, "center") <=0], 1 );	-- wait until grate is broken
	print("============= ACHIEVEMENT WINDOW OPEN =====================");
	print("============= ACHIEVEMENT WINDOW OPEN =====================");
	print("     ========== GRATE BUSTED =================");
	print("     ========== GRATE BUSTED =================");
	print("============= ACHIEVEMENT WINDOW OPEN =====================");
	print("============= ACHIEVEMENT WINDOW OPEN =====================");
	local tick:number = 0;
	repeat 
		if	(num_gruntpount >= 1)	then
			print("CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO");
			print("CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO");
			print("CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO");
			print("CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO");
			print("CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO CHEEVO");
			print("Achievement Awarded: Death From Above");
			CampaignScriptedAchievementUnlocked( 17 ) ;
			tick = 90;
		end
		tick = tick + 1
		Sleep(1);
	until(tick >= 90);
	print("============= ACHIEVEMENT WINDOW PASSED =====================");
	print("============= ACHIEVEMENT WINDOW PASSED =====================");
	print("============= ACHIEVEMENT WINDOW PASSED =====================");
	print("============= ACHIEVEMENT WINDOW PASSED =====================");
	-- that's it. Window closed.
end

function BurgertownAnyDeath( deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64  )
--    print("Something died");
	local b_found_grunt:boolean = false;
	
	local grunt_check:object_list = deadObject;
	local grunt_list:object_list =	metalabel_filter_objectlist( "grunt", deadObject );

	if grunt_list then
		for i, grunt in ipairs ( grunt_list ) do
--			print( grunt_list );
			b_found_grunt = true;
--			print("hi grunt!", grunt );
		end
	end

    if b_found_grunt and ( damageType == groundpoundStringID ) then  
--		print("GRUNTPOUNT!!!");
		num_gruntpount = 90;     				-- reset gruntpount clock
    end
end
function gruntpount_windowcloser():void
	repeat
		num_gruntpount = num_gruntpount - 1;
		Sleep(1);
	until(false);
end







--[[ -- pretangle
██████╗ ██████╗ ███████╗████████╗ █████╗ ███╗   ██╗ ██████╗ ██╗     ███████╗
██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔══██╗████╗  ██║██╔════╝ ██║     ██╔════╝
██████╔╝██████╔╝█████╗     ██║   ███████║██╔██╗ ██║██║  ███╗██║     █████╗  
██╔═══╝ ██╔══██╗██╔══╝     ██║   ██╔══██║██║╚██╗██║██║   ██║██║     ██╔══╝  
██║     ██║  ██║███████╗   ██║   ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗
╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝
--]]                                                           
function pretangle_drop_listener():void
	SleepUntil(	[|	volume_test_players_lookat(VOLUMES.tv_pretangle_look, 13, 20) 
				or	volume_test_players(VOLUMES.tv_pretangle) == true
				],2
				);
	--	NARRATIVE CALL
	CreateThread(tsunami_burgertown_droppods);
	dropoddamus();
end
function dropoddamus():void
--	object_create_folder(MODULES.f_mall_droppods);		--- delete me later... just here for testing and double spawns
	CreateThread(tanglepod2);
	CreateThread(pretangle_awareness_listener);
	Sleep(45);
	damage_new( TAG('levels\campaignworld020\w2_tsunami\fx\explosions\drop_pod_impact.damage_effect'), FLAGS.fl_pretangle_1 );
	damage_new( TAG('levels\campaignworld020\w2_tsunami\fx\explosions\drop_pod_impact.damage_effect'), FLAGS.fl_pretangle_2 ); 
	sleep_s(1);
	CreateThread(tanglepod1);
--	cs_run_command_script(AI.sq_tangle_gate_jax.a, "cs_run_to_tangletown_jackal");
--	cs_run_command_script(AI.sq_tangle_gate_jax.b, "cs_run_to_tangletown_jackal");
	sleep_s(1);
	cs_run_command_script(AI.sq_tangle_lip_elite.a, "cs_run_to_tangletown_elite");
end
function tanglepod1():void
	--OBJECTS.droppod_1:start(AI.sq_pretangle);
	OBJECTS.droppod_1:start(AI.sq_tangle_lip_elite);
end
function tanglepod2():void
	OBJECTS.droppod_2:start(AI.sq_tangle_gate_jax);
end
function look_at_test_a():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_pretangle_look, 14, 20) )	then
			print( "can see");
		else
			print( " ");
		end
		Sleep(3);
	until(false)
end
function cs_run_to_tangletown_jackal():void
	ai_set_blind(ai_current_actor, true);
	cs_abort_on_damage(true);
	cs_abort_on_alert(true);
	cs_go_to(POINTS.ps_tangle.p1); 
--	cs_go_by(POINTS.ps_tangle.p1, POINTS.ps_tangle.p2); 
	ai_set_blind(ai_current_actor, false);
--	cs_go_to(POINTS.ps_tangle.p2); 
--	cs_go_to(POINTS.ps_tangle.p3);
	ai_set_task(ai_current_actor, "aio_tangletown", "gate_jax_base");
end
function cs_run_to_tangletown_elite():void
	ai_set_blind(ai_current_actor, true);
	cs_abort_on_damage(true);
	cs_abort_on_alert(true);
	cs_go_to(POINTS.ps_tangle.p1); 
--	cs_go_by(POINTS.ps_tangle.p1, POINTS.ps_tangle.p2); 
	ai_set_blind(ai_current_actor, false);
--	cs_go_to(POINTS.ps_tangle.p2); 
--	cs_go_to(POINTS.ps_tangle.p3);
	ai_set_task(ai_current_actor, "aio_tangletown", "lip_agressors_base");
end
function pretangle_awareness_listener():void
	SleepUntil( [|		ai_combat_status(AI.sq_tangle_gate_jax) >= 3 
					or	ai_combat_status(AI.sq_tangle_lip_elite) >= 3
				],2 );
	print("=====================INTERRUPT=========================================");
	print("=====================INTERRUPT=========================================");
	cs_run_command_script(AI.sq_tangle_gate_jax.a, "cs_pretangle_interrupt");
	cs_run_command_script(AI.sq_tangle_gate_jax.b, "cs_pretangle_interrupt");
	cs_run_command_script(AI.sq_tangle_lip_elite.a, "cs_pretangle_interrupt");
	Sleep(2);
	ai_set_task(AI.sq_tangle_gate_jax, "aio_pretangle", "pretangle_main");
	ai_set_task(AI.sq_tangle_lip_elite, "aio_pretangle", "pretangle_main");
end
function go_to_tangletown():void
	print("=============== CLEAR OUT =================");
	ai_set_task(AI.sq_tangle_gate_jax, "aio_tangletown", "gate_jax_base");
	ai_set_task(AI.sq_tangle_lip_elite, "aio_tangletown", "lip_agressors_base");
end
function cs_pretangle_interrupt():void
	print("=============== INTERRUPTED =================");
	ai_set_blind(ai_current_actor, false);
end
function hamfisted_cleanup_of_burgertown():void
	SleepUntil([| volume_test_players_all(VOLUMES.tv_tangletown)], 3);
	object_create("dm_tsu_door_666");
	ai_erase(AI.gr_burgertown_all);
	battery_2 = 1;																					-- kill AA fire
	battery_3 = 1;																					-- kill AA fire
	object_destroy_folder(MODULES.cr_burgertown);
	object_destroy_folder(MODULES.cr_burgertown_2);
	object_destroy_folder(MODULES.cr_turret0);
	object_destroy_folder(MODULES.veh_burger);
	--object_destroy_folder(MODULES.cr_weapons_burgertown);
	-- in case players didn't complete burgertown properly:
	object_destroy (OBJECTS.shrike_power_source_0);
	object_destroy (OBJECTS.shrike_power_source_1);
	object_destroy (OBJECTS.dm_shriketurret_00);
	object_destroy (OBJECTS.dm_shriketurret_01);
	object_destroy (OBJECTS.dm_tsu_door_01);
	Sleep(2);
	garbage_collect_now();
	if(v_shrike_tally == 0)then
		v_shrike_tally = 1;
	end
end


--[[ -- tangletown
████████╗ █████╗ ███╗   ██╗ ██████╗ ██╗     ███████╗████████╗ ██████╗ ██╗    ██╗███╗   ██╗
╚══██╔══╝██╔══██╗████╗  ██║██╔════╝ ██║     ██╔════╝╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
   ██║   ███████║██╔██╗ ██║██║  ███╗██║     █████╗     ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
   ██║   ██╔══██║██║╚██╗██║██║   ██║██║     ██╔══╝     ██║   ██║   ██║██║███╗██║██║╚██╗██║
   ██║   ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗   ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
--]]
function tangletown():void
	SleepUntil([| volume_test_players(VOLUMES.tv_burgertown_complete) ], 1);
	CreateThread(start_tangletown);
end
-- OBJECTS.droppod_1:start(AI.sq_pretangle);
-- damage_new( TAG('objects/vehicles/covenant/wraith/turrets/wraith_mortar/invisiwraith_weapon/projectiles/damage_effects/wraith_mortar_round_impact.damage_effect'), FLAGS.fl_pretangle_1 );
-- damage_new( TAG('fx/library/sandbox/explosions/covenant_explosion_large/covenant_explosion_large.damage_effect'), FLAGS.fl_pretangle_1 );
-- damage_object_effect( TAG('objects/vehicles/covenant/wraith/turrets/wraith_mortar/invisiwraith_weapon/projectiles/damage_effects/wraith_mortar_round_impact.damage_effect'), OBJECTS.crate1 );

-- damage_new( TAG('objects/equipment/juggernaut/damage_effects/blast_wave_explosion.damage_effect'), FLAGS.fl_pretangle_1 ); -- maybe
-- damage_new( TAG('objects\weapons\multiplayer\blam_bomb\fx\ca_explosion_heavy_01a.damage_effect'), FLAGS.fl_pretangle_1 ); --no


-- damage_new(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), FLAGS.fl_pretangle_1 );
-- objects/vehicles/covenant/wraith/turrets/wraith_mortar/invisiwraith_weapon/projectiles/damage_effects/wraith_mortar_round_impact.damage_effect
-- fx/library/sandbox/explosions/covenant_explosion_large/covenant_explosion_large.damage_effect

function start_tangletown():void																-- I split this out so I can call it directly for debugging
	CreateThread(tangletown_spawn_sequence);
	composer_play_show("shrike_tangletown");
	ai_disable_jump_hint(HINTS.tangle_jump_hint);
--	object_create("dm_shriketurret_02");
--	CreateThread(tangletown_objcon_10);
--	CreateThread(tangletown_objcon_20);
--	CreateThread(tangletown_objcon_30);
	CreateThread(shrike_2);
	CreateThread(hamfisted_cleanup_of_burgertown);
	object_create_folder(MODULES.cr_tangletown);
	object_create_folder(MODULES.veh_tangletown);
	object_create_folder(MODULES.weap_tangletown);
	object_create_folder(MODULES.f_mall_droppods);
	object_create_folder(MODULES.f_tangle_grenades);
	object_create("dm_tsu_door_02");
	CreateThread(remove_shade_tops);
--	CreateThread(tangletown_banshee_watcher);
end
function tangletown_spawn_sequence():void
	SleepUntil([| volume_test_players(VOLUMES.tv_pretangle_spawn) ], 3);
	print("--------- tangletown all");
	ai_place(AI.sg_tangle_greeters);
	CreateThread(play_elite_turret_composition);
	SleepUntil( [| b_shrike_2 == false], 5 );
	f_proxy_turrettown_remove();
	sleep_s(2);
	switch_zone_set(ZONE_SETS.w2_tsunami_turrettown);
	sleep_s(2);
	CreateThread(flock_tangletown_progress_cull_1);
	SleepUntil( [| b_forko == true], 5 );
	ai_place(AI.sq_fork_1);
	Sleep(2);
	composer_play_show("vin_tsunami_spirit_tangle", {	spirit = ai_vehicle_get_from_squad(AI.sq_fork_1)} );
	object_create_folder(MODULES.cr_pre_turrettown);
end
function tangle_spirit_unload():void
	print ("-----------------spirit go.");
	f_load_drop_ship (AI.sq_fork_1, AI.sq_tangle_snip_jax_1, true, false, "right");
	f_load_drop_ship (AI.sq_fork_1, AI.sq_tangle_snip_jax_2, true, false, "right");
	if	(		game_coop_player_count() >= 2) then
		f_load_drop_ship (AI.sq_fork_1, AI.sq_tangle_snip_jax_3, true, false, "right");
		f_load_drop_ship (AI.sq_fork_1, AI.sq_tangle_snip_jax_4, true, false, "right");
	end
	ai_place(AI.sg_tangle_ground_reinforcements);
	CreateThread(tanglesnip_listener);
--	f_load_drop_ship (AI.sq_fork_1, AI.sg_tangle_ground_reinforcements, true, false, "left");
	Sleep(4);
	print ("Spirit is unloading!");
--	unit_open(ai_vehicle_get_from_squad(AI.sq_fork_1));
	CreateThread(f_unload_drop_ship, AI.sq_fork_1, "left");
	f_unload_drop_ship (AI.sq_fork_1, "right");
	sleep_s(1);
	device_set_position (OBJECTS.dm_tsu_door_02, 1);
	ai_enable_jump_hint(HINTS.tangle_jump_hint);
	sleep_s(4);
	object_create("tangle_jackwall_1");
	object_create("tangle_jackwall_2");
end
function jackwall_listener_debug():void
	repeat
		if(object_valid("tangle_jackwall_1"))then
			print("jackwall1");
		else
			print(" ");
		end
		if(object_valid("tangle_jackwall_2"))then
			print("jackwall2");
		else
			print(" ");
		end
		Sleep(30);
	until(false);
end
function remove_shade_tops():void
	object_destroy(object_at_marker(OBJECTS.shade_base_1, "turret"));
	object_destroy(object_at_marker(OBJECTS.shade_base_2, "turret"));
end
function hamfisted_cleanup_of_tangletown():void
	SleepUntil([| volume_test_players_all(VOLUMES.tv_turrettown)], 3);
	object_create_anew("dm_tsu_door_02");
	battery_4 = 1;																					-- kill AA fire
	ai_erase(AI.sg_tangle_greeters);
	ai_erase(AI.sg_tangle_lip_aggressors);
	ai_erase(AI.sg_tangle_gate_jax);
	ai_erase(AI.sg_tangle_ground_reinforcements);
	object_destroy_folder(MODULES.cr_tangletown);
	object_destroy_folder(MODULES.cr_pre_turrettown);
	object_destroy_folder(MODULES.f_tangle_grenades);
	object_destroy_folder(MODULES.veh_tangletown);
	object_destroy(OBJECTS.droppod_1);
	object_destroy(OBJECTS.droppod_2);
	object_destroy(OBJECTS.dm_shriketurret_02);
	object_destroy(OBJECTS.dm_tsu_door_666);
	Sleep(2);
	garbage_collect_now();
end
function tanglesnip_listener():void
	print("tanglesnip_listener____________________");
	SleepUntil([|volume_test_objects(VOLUMES.tv_tangletown, AI.sq_tangle_snip_jax_1);],5);
	print("tanglesnip_listener____gogogogogo________________");
	cs_run_command_script(AI.sq_tangle_snip_jax_1, "cs_tanglesnip_4");
	cs_run_command_script(AI.sq_tangle_snip_jax_2, "cs_tanglesnip_2");
	cs_run_command_script(AI.sq_tangle_snip_jax_3, "cs_tanglesnip_1");
	cs_run_command_script(AI.sq_tangle_snip_jax_4, "cs_tanglesnip_3");
end
function cs_tanglesnip_1():void
	cs_go_to(POINTS.ps_tangle.s01);
end
function cs_tanglesnip_2():void
	cs_go_to(POINTS.ps_tangle.s02);
end
function cs_tanglesnip_3():void
	cs_go_to(POINTS.ps_tangle.s03);
end
function cs_tanglesnip_4():void
	cs_go_to(POINTS.ps_tangle.s04);
end
function cs_tangle_backup():void
	cs_go_to(POINTS.ps_tangle.p01);
	SleepUntil([| device_get_position(OBJECTS.dm_tsu_door_02) >= .15], 2);
end
function tangleship():void
	ai_place(AI.sq_fork_1);
	Sleep(2);
	composer_play_show("vin_tsunami_spirit_tangle", {	spirit = ai_vehicle_get_from_squad(AI.sq_fork_1)} );
end
--[[
	volume_test_players(VOLUMES.tv_tangleplay_tip)
	volume_test_players(VOLUMES.tv_tangleplay_gate)
	volume_test_players(VOLUMES.tv_tangleplay_side)
--]]

--[[
████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗    ████████╗ ██████╗ ██╗    ██╗███╗   ██╗
╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝    ╚══██╔══╝██╔═══██╗██║    ██║████╗  ██║
   ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║          ██║   ██║   ██║██║ █╗ ██║██╔██╗ ██║
   ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║          ██║   ██║   ██║██║███╗██║██║╚██╗██║
   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║          ██║   ╚██████╔╝╚███╔███╔╝██║ ╚████║
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝    ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝
--]]         

global var_peakpop:number = 0;																-- peak population. Set when greeters placed.

function turret_town():void
	SleepUntil([| volume_test_players(VOLUMES.tv_turret_town) ], 1);
	object_create_folder(MODULES.cr_turrettown);
	object_create_folder(MODULES.f_turrettown_weapons);
	CreateThread(shrike_3);
	CreateThread(shrike_4);
	CreateThread(shrike_5);
	CreateThread(turrettown_ninja_listener);
	CreateThread(turrettown_objcon_10);
	CreateThread(turrettown_objcon_20);
	CreateThread(turrettown_objcon_30);
	game_save_no_timeout();
	CreateThread(hamfisted_cleanup_of_tangletown);
	CreateThread(turrettown_building_1_breach_listener);
	CreateThread(turrettown_building_2_attic_detector);
	CreateThread(turrettown_building_1_detector);
	CreateThread(turret_gunner_interrupt_listener);

	ai_place(AI.gr_turret_greeters);
	Sleep(2);
	var_peakpop = ai_living_count(AI.gr_turret_all);							-- 21 as of 7/13
	Sleep(2);
	CreateThread(spawn_b1f2_squad);
	CreateThread(spawn_b2_squads);
	CreateThread(spawn_chanters);

	if	(		game_coop_player_count() >= 3)
	or	(		game_difficulty_get_real() == DIFFICULTY.legendary) 
	then	
		CreateThread(turrettown_reinforcements_inner);
	end
--	CreateThread(turrettown_reinforcements_upper);
end
function shrikes_of_turrettown():void
	composer_play_show("shrike_turret_a");
	composer_play_show("shrike_turret_b");
	composer_play_show("shrike_turret_c");
--	object_create("dm_shriketurret_03");
	--DeviceLayerPlayBouncingAnimation( OBJECTS.dm_shriketurret_03,	--deviceMachine:object,
										--1,							--layer:number,
										--"device:position",			--name:string,
										--28)							-- rate:number, frames per second
		--DeviceSetLayerPos(OBJECTS.dm_shriketurret_03, 1, .85);
--	object_create("dm_shriketurret_04");
	--DeviceLayerPlayLoopingAnimation( OBJECTS.dm_shriketurret_04,	--deviceMachine:object,
										--1,							--layer:number,
										--"device:position",			--name:string,
										--20);						-- rate:number,
	--DeviceSetLayerPos(OBJECTS.dm_shriketurret_04, 1, .5);
--	object_create("dm_shriketurret_05");
end

function spawn_b2_squads():void
	SleepUntil(	[|	ai_living_count(AI.gr_turret_all) <= (var_peakpop - 2)
				or	volume_test_players(VOLUMES.tv_building_1_breach)
				], 3);
	ai_place(AI.sq_turret_grunts_hi);

	SleepUntil(	[|	ai_living_count(AI.gr_turret_all) <= (var_peakpop - 4)
				], 3);
	if	(	volume_test_players(VOLUMES.tv_bldg2_pocket) == false
		and	volume_test_players(VOLUMES.tv_vista) == false)	then
		ai_place(AI.gr_turret_building_2);
	end
end
function spawn_chanters():void
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_chantspawn)
				or	volume_test_players(VOLUMES.tv_bldg2_pocket)
				or	volume_test_players(VOLUMES.tv_building_2_attic)
				], 3);
	g_chantinggrunts = composer_play_show ("vin_turrtown_chanting");
	Sleep(2);
	CreateThread(chant_grunts_interrupt_listener);
end
function spawn_b1f2_squad():void
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_building_1_breach)
				or	ai_living_count(AI.gr_turret_all) <= (var_peakpop - 8)
				], 2);
	if	(ai_living_count(AI.gr_turret_all) <= (var_peakpop))	then
		ai_place(AI.gr_turret_b1_f2);
	end
end
function turret_gunner_interrupt_listener():void 
	local ai_count:number = ai_living_count(AI.gr_turret_greeters);
	SleepUntil	([|	ai_living_count(AI.gr_turret_greeters) < ai_count	], 3);
	cs_run_command_script(AI.sq_turret_mixed_shade.spawnpoint06, "cs_pretangle_interrupt");
end
function chant_grunts_interrupt_listener():void 
	local headcount:number = ai_living_count(AI.sq_turret_chantgrunts);
	CreateThread(chantlistener);
	SleepUntil	([|		ai_living_count		(AI.sq_turret_chantgrunts) < headcount 
				or		unit_get_health		(AI.sq_turret_chantgrunts.a1) < .9
				or		unit_get_health		(AI.sq_turret_chantgrunts.a2) < .9
				or		unit_get_health		(AI.sq_turret_chantgrunts.a3) < .9
				or		unit_get_health		(AI.sq_turret_chantgrunts.a4) < .9
				or		unit_get_health		(AI.sq_turret_chantgrunts.a5) < .9
				or		unit_get_health		(AI.sq_turret_chantgrunts.a6) < .9
				or		object_get_health	(OBJECTS.cr_cpb) <= 0
				or		volume_test_players (VOLUMES.tv_chantroom) 
				or		b_chantbreak == true
				], 3);
	b_chantbreak = true;
end
function chantest():void
	g_chantinggrunts = composer_play_show ("vin_turrtown_chanting");
	CreateThread(chant_grunts_interrupt_listener);
	CreateThread(chantlistener);
end
function chantlistener():void
	SleepUntil	([|		b_chantbreak == true
				], 3);
	composer_stop_show(g_chantinggrunts);
	Sleep(2);
	cs_run_command_script(AI.sq_turret_chantgrunts.a1, "cs_turrettown_grunt_scramble");
	cs_run_command_script(AI.sq_turret_chantgrunts.a2, "cs_turrettown_grunt_scramble");
	cs_run_command_script(AI.sq_turret_chantgrunts.a3, "cs_turrettown_grunt_scramble");
	cs_run_command_script(AI.sq_turret_chantgrunts.a4, "cs_turrettown_grunt_scramble");
	cs_run_command_script(AI.sq_turret_chantgrunts.a5, "cs_turrettown_grunt_scramble");
	cs_run_command_script(AI.sq_turret_chantgrunts.a6, "cs_turrettown_grunt_scramble");
	print("CHANTBREAK");
	print("CHANTBREAK");
	print("CHANTBREAK");
	print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
print("CHANTBREAK");
	print("CHANTBREAK");
end
function turrettown_reinforcements_inner():void
	SleepUntil	([|		volume_test_players(VOLUMES.tv_vista) 
				or		ai_living_count(AI.gr_turret_greeters) <= 10
				], 5);
	Sleep(2);
	SleepUntil	([|		volume_test_players(VOLUMES.tv_building_1) == false ], 5); 
	ai_place(AI.gr_turret_reinforcements_inner);
end
function turrettown_reinforcements_upper():void
	SleepUntil	([| volume_test_players(VOLUMES.tv_vista) 
				or	volume_test_players(VOLUMES.tv_building_1_breach) 
				], 5);
	ai_place(AI.gr_turret_reinforcements_upper);
end
function turrettown_building_1_breach_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_building_1_breach) ], 3);
	b_turret_building_1_breach = true;
end
function turrettown_objcon_10():void
	SleepUntil([| volume_test_players(VOLUMES.tv_turrettown_objcon_10) ], 3);
	if(v_turrettown_objcon <= 10)then
		v_turrettown_objcon = 10;
	end
end
function turrettown_objcon_20():void
	SleepUntil([| volume_test_players(VOLUMES.tv_turrettown_objcon_20) ], 3);
	if(v_turrettown_objcon <= 20)then
		v_turrettown_objcon = 20;
	end
end
function turrettown_objcon_30():void
	SleepUntil([| volume_test_players(VOLUMES.tv_turrettown_objcon_30) ], 3);
	if(v_turrettown_objcon <= 30)then
		v_turrettown_objcon = 30;
	end
end
function turrettown_building_1_detector():void							
	repeat
		if(volume_test_players(VOLUMES.tv_building_1))then
			b_turret_building_1 = true;
		else
			b_turret_building_1 = false;
		end
		Sleep(10);
	until(v_shrike_tally >= 5);
end
function turrettown_building_2_attic_detector():void										-- strictly for the ninjas
	repeat
		if(volume_test_players(VOLUMES.tv_building_2_attic))then
			b_turret_building_2 = true;
		else
			b_turret_building_2 = false;
		end
		Sleep(10);
	until(IsGoalActive(w2_tsunami_station.goal_turrettown) == false);
end
function turrettown_ninja_listener():void
	SleepUntil([| 	b_turret_building_2 == true ] ,5);
	ai_place(AI.sq_turret_ninja_guardian);
	if	(	game_coop_player_count() >= 3)
	or	(	(game_difficulty_get_real() == DIFFICULTY.heroic) and (game_coop_player_count() >= 2))
	or	(	game_difficulty_get_real() == DIFFICULTY.legendary) 
	then
		ai_place(AI.sq_turret_ninja_seeker);
	end
	CreateThread(looky_ninjas);
end
function camo_guard():void
	print("camo_guard");
	Sleep(2);
	cs_enable_moving(AI.sq_turret_ninja_guardian, true);
	ai_set_active_camo(AI.sq_turret_ninja_guardian, true);
end
function camo_seek():void
	print("camo_seek");
	Sleep(2);
	cs_enable_moving(AI.sq_turret_ninja_seeker, true);
	ai_set_active_camo(AI.sq_turret_ninja_seeker, true);
end
function looky_ninjas():void
	repeat
		if	(	volume_test_players_lookat(VOLUMES.tv_look_ninjas, 7, 20) 
			and	(volume_test_players(VOLUMES.tv_ninja_guardian) or volume_test_players(VOLUMES.tv_ninja_excess) )
			)
		then
			print( "can see guardian");
			b_ninjas_spotted = true;
		elseif	(	volume_test_players_lookat(VOLUMES.tv_look_ninjas, 10, 20) 
			and	(volume_test_players(VOLUMES.tv_ninja_seeker) or volume_test_players(VOLUMES.tv_ninja_excess) )
			)
		then
			print( "can see seeker");
			b_ninjas_spotted = true;
		end
		Sleep(3);
	until(b_ninjas_spotted == true);
end
function cs_ninja_lies_in_wait():void
	cs_enable_moving(ai_current_actor, false);
	SleepUntil([| b_ninjas_spotted == true or unit_get_shield(ai_current_actor) < 1]);
	cs_face_player(ai_current_actor, true);
	CreateThread(camo_guard);
	if(ai_living_count (AI.sq_turret_ninja_seeker) == 1)then
		CreateThread(camo_seek);
	end
end
--ai_task_count(AI.aio_turrettown.bulwark_main)

--[[
 ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ ██████╗ ███╗   ██╗
██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔═══██╗████╗  ██║
██║     ██║   ██║██╔████╔██║██╔████╔██║██║   ██║██╔██╗ ██║
██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██║   ██║██║╚██╗██║
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║╚██████╔╝██║ ╚████║
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
--]]


function shriketurret_animate(turret:object, powersource:object):void
	local turret_pointat:number=0;
	local turret_sleeptime:number=0;
	repeat
		turret_pointat = random_range (0, 10)/10;
		turret_sleeptime = random_range (1, 4);
		print ("Turret animation position is set to:", turret_pointat);
		print ("Turret animation sleep time is set to:", turret_sleeptime);
		sleep_s (1);
		device_set_position (turret, turret_pointat);
		sleep_s (turret_sleeptime);
		if	(object_get_health (turret) > 0 and object_get_health (powersource) > 0)	then
			RunClientScript ("shrike_gunfire", turret);
			print ("fire turret weapon!");
		else
			print ("Turret is dead!");
		end
		sleep_s (1.5);
	until (object_get_health (turret) <= 0);
end
function test():void
	print(ai_task_count(AI.obj_burgertown.turretguard_main) >= 1);
end
function mall_cleanup():void

	ai_erase(AI.gr_turrettown_allies);
	ai_erase(AI.gr_turrettown_ally_phantoms);
	ai_erase(AI.gr_turret_all);

	object_destroy_folder(MODULES.cr_turrettown);
	object_destroy_folder(MODULES.cr_pre_turrettown);
	object_destroy_folder(MODULES.f_mall_droppods);
	object_destroy_folder(MODULES.f_turrettown_weapons);

	object_destroy_folder(MODULES.cr_tangletown);
	object_destroy_folder(MODULES.f_tangle_grenades);
	object_destroy_folder(MODULES.veh_tangletown);
	object_destroy_folder(MODULES.weap_tangletown);
	object_destroy(OBJECTS.dm_shriketurret_02);
	object_destroy(OBJECTS.dm_tsu_door_666);

	object_destroy (OBJECTS.dm_shriketurret_00);
	object_destroy (OBJECTS.dm_shriketurret_01);
	object_destroy (OBJECTS.dm_shriketurret_02);
	object_destroy (OBJECTS.dm_shriketurret_03);
	object_destroy (OBJECTS.dm_shriketurret_04);
	object_destroy (OBJECTS.dm_shriketurret_05);

	CreateThread (flock_turrettown_final_cull_client);
	CreateThread (flock_ongoing_final_cull_client);
	battery_1 = 1;																					-- kill AA fire
	battery_2 = 1;																					-- kill AA fire
	battery_3 = 1;																					-- kill AA fire
	battery_4 = 1;																					-- kill AA fire
	battery_5 = 1;																					-- kill AA fire
	battery_6 = 1;																					-- kill AA fire
	battery_7 = 1;																					-- kill AA fire
	garbage_collect_now();
end
function shrike_1_reminder ():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burgertown_fallback)], 1);
	if	(b_shrike_1 == true)	then
		print ("player might be forgetting Shrike 1");
--		faux_mission_objective_text( "Don't forget that turret, Spartan!");
	else
		print ("player destroyed Shrike 1");
	end
end
function power_down_shrike(shrike:object):void
	DeviceLayerFadeInAnimation( shrike, 1, "any:powerdown", 30, 1.5);
--	This works:
--	DeviceLayerFadeInAnimation( OBJECTS.dm_shriketurret_04, 1, "any:powerdown", 30, 2);
end
function shrike_0():void
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_00, OBJECTS.shrike_power_source_0, FLAGS.fl_shrike_0a, FLAGS.fl_shrike_0b, FLAGS.fl_shrike_0c, FLAGS.fl_shrike_0d, "b_shrike_0", "dm_shriketurret_00");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_0) <= 0 ], 2 );
	interpolator_start("w2_tsun_intro_off");
end
function shrike_1():void
	object_create ("shrike_power_source_1");	
	sleep_s (1);
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_01, OBJECTS.shrike_power_source_1, FLAGS.fl_shrike_1a, FLAGS.fl_shrike_1b, FLAGS.fl_shrike_1c, FLAGS.fl_shrike_1d, "b_shrike_1", "dm_shriketurret_01");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_1) <= 0 ], 2 );
	interpolator_start("w2_tsun_burger_off");
end
function shrike_2():void
	object_create ("shrike_power_source_2");
	sleep_s (1);
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_02, OBJECTS.shrike_power_source_2, FLAGS.fl_shrike_2a, FLAGS.fl_shrike_2b, FLAGS.fl_shrike_2c, FLAGS.fl_shrike_2d, "b_shrike_2", "dm_shriketurret_02");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_2) <= 0 ], 2 );
	interpolator_start("w2_tsun_turret_off");
end
function shrike_3():void
	CreateThread(shrike_3x);
	object_create ("shrike_power_source_3");
	sleep_s (1);
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_03, OBJECTS.shrike_power_source_3, FLAGS.fl_shrike_3a, FLAGS.fl_shrike_3b, FLAGS.fl_shrike_3c, FLAGS.fl_shrike_3d, "b_shrike_3", "dm_shriketurret_03");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_3) <= 0 ], 2 );
	interpolator_start("w2_tsun_turrettown_a_off");
end
function shrike_4():void
	CreateThread(shrike_4x);
	object_create ("shrike_power_source_4");
	sleep_s (1);
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_04, OBJECTS.shrike_power_source_4, FLAGS.fl_shrike_4a, FLAGS.fl_shrike_4b, FLAGS.fl_shrike_4c, FLAGS.fl_shrike_4d, "b_shrike_4", "dm_shriketurret_04");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_4) <= 0 ], 2 );
	interpolator_start("w2_tsun_turrettown_c_off");
end
function shrike_5():void
	CreateThread(shrike_5x);
	object_create ("shrike_power_source_5");
	sleep_s (1);
	CreateThread(shrike_lifecycle, OBJECTS.dm_shriketurret_05, OBJECTS.shrike_power_source_5, FLAGS.fl_shrike_5a, FLAGS.fl_shrike_5b, FLAGS.fl_shrike_5c, FLAGS.fl_shrike_5d, "b_shrike_5", "dm_shriketurret_05");
	SleepUntil( [| object_get_health(OBJECTS.shrike_power_source_5) <= 0 ], 2 );
	interpolator_start("w2_tsun_turrettown_b_off");
end

global turret_shrike_death_health:number = 0.35;	--From guillaume:  Since I'm checking Turret's death several time, that would help me to keep up.

function shrike_lifecycle(shrike:object, power:object, explo1:flag, explo2:flag, explo3:flag, fire:flag, bool:string, shrike_name:string):void
--	===death
	object_cannot_die(shrike);
	ai_object_set_team(shrike, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(shrike, true);
	ai_object_set_team(power, TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(power, true);
	SleepUntil( [| object_get_health(power) <= 0 
				or object_get_health(shrike) <= turret_shrike_death_health				-- to prevent overkill
				], 2 );
	object_cannot_take_damage(shrike);
     _G[bool] = false;
	print(" bool set, presumably");
	if(object_get_health(power) > 0)then
		RunClientScript("shrike_explosion", explo1, explo2, explo3, fire);
		object_damage_damage_section (power, "default", 2000);
	end
	--RunClientScript("shrike_explosion", fl_shrike_0a, FLAGS.fl_shrike_0b, FLAGS.fl_shrike_0c, FLAGS.fl_shrike_0d);
--	==/death
	print(" bool set, presumably");
	ai_object_set_team(shrike, TEAM.human);
--	ai_object_set_team(shrike, TEAM.neutral);
	ai_allegiance (TEAM.player, TEAM.human);


--	ai_object_enable_targeting_from_vehicle(shrike, false);
	ai_object_set_targeting_ranges(shrike, 0, 0);
	ai_object_set_targeting_bias(shrike, -1);
	navpoint_track_object(power, false);
	if(shrike ~= OBJECTS.dm_shriketurret_00)then
		v_shrike_tally = v_shrike_tally + 1;
	end
	game_save_no_timeout();
	SleepUntil(  [| object_valid(shrike_name) == false], 30 );
	RunClientScript("fire_cleanup", fire);
end
function shrike_3x():void
	SleepUntil(  [| b_shrike_3 == false;], 30 );
	battery_5 = 1;																					-- kill AA fire
end
function shrike_4x():void
	SleepUntil(  [| b_shrike_4 == false;], 30 );
	battery_6 = 1;																					-- kill AA fire
end
function shrike_5x():void
	SleepUntil(  [| b_shrike_5 == false;], 30 );
	battery_7 = 1;																					-- kill AA fire
end
function burgertown_turret_checker(would_be_gunner:ai, turret_name:string, turret:object):void
	if(is_turret_available(turret_name, turret))then
		cs_run_command_script(would_be_gunner, "cs_burgertown_turret");
	end
end
function tangletown_turret_checker(would_be_gunner:ai, turret_name:string, turret:object):void
	if(is_turret_available(turret_name, turret))then
		cs_run_command_script(would_be_gunner, "cs_tangletown_turret");
	end
end
function shrike_turret_checker(would_be_gunner:ai, turret_name:string, turret:object):void
	if(is_turret_available(turret_name, turret))then
		cs_run_command_script(would_be_gunner, "cs_shrike_turret");
	end
end
function is_turret_available(turret_name:string, turret:object):boolean
	if (	object_valid( turret_name ) 
	and 	object_get_health(turret) >=0.2
	and		unit_has_empty_seat(turret)
		)	then
		print("turret meets requirements");
		return true;
	else
		print("turret doesn't meet requirements");
		return false;
	end
end

function f_dc_overload_interact(trigger:object, p_player:object):void
	local pl:player = unit_get_player (p_player);
	composer_play_show ("collectible", {scanner = pl});
--	composer_play_show ("collectible", {scanner = SPARTANS.locke});
	print("this far ", pl);
	device_set_power(OBJECTS.dc_turr_shield_shutdown, 0);
	print ("device now has no power");
	ObjectSetSpartanTrackingEnabled( OBJECTS.dc_turr_shield_shutdown, false );
	ObjectSetSpartanTrackingEnabled( OBJECTS.cr_cpb, false );
	print ("device now has no tracking");
	CreateThread(turrettown_emp_event);
	print ("emp event function called");
end

function turrettown_emp_event()
	sleep_s (.5);
	RunClientScript("emp_charge_up");
	sleep_s (2.5);
	print ("destroying shield.");
	object_damage_damage_section (OBJECTS.cr_cpb, "glass", 2000);
	Sleep(2);
	object_damage_damage_section (OBJECTS.cr_cpb, "default", 2000);
	CreateEffectGroup(EFFECTS.emp_blast_01);
	CreateEffectGroup(EFFECTS.emp_sm_light_01);
	emp_fallout();
	--CreateThread(audio_emp_blast);
end
function emp_fallout():void
	local elites:table =
	{
		AI.sq_turret_building_1.spawnpoint,
		AI.sq_turret_building_2.spawnpoint,
		AI.sq_turret_bulwark.spawnpoint,
		AI.sq_turret_bulwark.spawnpoint21,
		AI.sq_turret_mixed_shade.spawnpoint06,
		AI.sq_turret_mixed_shade_2.spawnpoint06,
		AI.sq_turret_ninja_guardian.spawnpoint,
		AI.sq_turret_ninja_seeker.spawnpoint,
		AI.sq_turret_reinforcements_inner.spawnpoint,
		AI.sq_turret_reinforcements_upper.spawnpoint06,
		AI.sq_turrtown_reinforcements_1.spawnpoint101,
		AI.sq_turrtown_reinforcements_1.spawnpoint102,
		AI.sq_turrtown_reinforcements_1.spawnpoint103,
		AI.sq_turrtown_reinforcements_1.spawnpoint150,
		AI.sq_turrtown_reinforcements_1.spawnpoint151,
		AI.sq_turrtown_reinforcements_1.spawnpoint152,
		AI.sq_turrtown_reinforcements_1.spawnpoint153,
		AI.sq_turrtown_reinforcements_2.spawnpoint104
	}
	for _,elite in ipairs(elites)do
		shieldstrippa(elite);
	end

	damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), ai_vehicle_get_from_squad(AI.sq_turret_mixed_shade)); -- EMP

	for _, spartan in ipairs (spartans()) do
			damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), spartan); 
			if(unit_get_vehicle(spartan)~= nil)then
				damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt_aoe.damage_effect'), unit_get_vehicle(spartan)); -- EMP
			end
	end
end
function shieldstrippa(guy:object):void
	if( biped_is_alive(guy))then
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_charged_bolt.damage_effect'), guy); 
	end
end
--[[
 ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ██████╗ ███████╗
██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗██╔══██╗██╔════╝
██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║    ███████╗██║     ██████╔╝██║██████╔╝██████╔╝███████╗
██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║    ╚════██║██║     ██╔══██╗██║██╔═══╝ ██╔═══╝ ╚════██║
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝    ███████║╚██████╗██║  ██║██║██║     ██║     ███████║
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝     ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝     ╚══════╝
--]]                        

function cs_turr0_arbiter()
	ai_cannot_die (ai_current_actor, true);
--	navpoint_track_object(ai_get_object(ai_current_actor), true);
end

global turr0_arbiter_composition_played:boolean = false;

function cs_turr0_arbiter_goto()
--	cs_ignore_obstacles(ai_current_actor, true);
	--CreateThread(arbiter_start_speech_composition);
	object_create_if_necessary ("w_arbysword");
	unit_add_weapon (AI.sq_turr0_arbiter_a.spawnpoint81, OBJECTS.w_arbysword, 2);
--	cs_move_towards_point (AI.sq_turr0_arbiter_a.spawnpoint81, true, POINTS.ps_arb_turr0.p02, 2);
--	cs_face(true, POINTS.ps_arb_turr0.p01);

	-- 8/11/2015
	--gmu osr-155053, 152451 - telling arbiter to go to a spot, face a spot, then play the comp.
	--if he doesn't make it to the point in 30 seconds, then play the comp no matter what
	--the comp is changed to teleport to the first spot, so once it plays, the mission will continue
	CreateThread (turr0_arbiter_failsafe);
	cs_go_to( AI.sq_turr0_arbiter_a.spawnpoint81, true, POINTS.ps_arbiter_turret0.p02);
	cs_face(AI.sq_turr0_arbiter_a.spawnpoint81, true, POINTS.ps_arbiter_turret0.p01);
	
	--object_teleport( AI.sq_turr0_arbiter_a.spawnpoint81, POINTS.ps_arbiter_turret0.p02);
	sleep_s (0.5);
	--object_set_facing( AI.sq_turr0_arbiter_a.spawnpoint81, POINTS.ps_arbiter_turret0.p01);
	print ("arbiter is in the turret destruction composition.");
	Sleep(30);
	turr0_arbiter_composition_played = true;
	local turr0_arbiter_composition = composer_play_show ("vin_turret0_arbiter_01");
end

function turr0_arbiter_failsafe()
	SleepUntil([| turr0_arbiter_composition_played ],1, seconds_to_frames (30));
	if turr0_arbiter_composition_played == false then
		print ("arbiter composer failsafe needed");
		composer_play_show ("vin_turret0_arbiter_01");
	else
		print ("arbiter composer failsafe not needed");
	end
end


function cs_turrtown_allies()
	ai_cannot_die (ai_current_actor, true);
--	navpoint_track_object(ai_get_object(ai_current_actor), true);
end
function cs_turrettown_gunner():void
	local dice:number = random_range(1,3);
	cs_abort_on_damage(true);
	repeat
		if(dice == 1)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p0);
		elseif(dice == 2)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p1);
		elseif(dice == 3)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p2);
		end
		sleep_s(random_range(1,3));
		dice = random_range(1,3);
	until(v_turrettown_objcon >= 30);
end
function cs_turrettown_gunner_2():void
	local dice:number = random_range(1,3);
	cs_abort_on_damage(true);
	repeat
		if(dice == 1)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p3);
		elseif(dice == 2)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p4);
		elseif(dice == 3)then
			cs_shoot_point(ai_current_actor, true, POINTS.ps_turret_town_targets.p5);
		end
		sleep_s(random_range(1,3));
		dice = random_range(1,3);
	until(v_turrettown_objcon >= 30);
	sleep_s(1.5);
end

function cs_turrettown_grunt_scramble():void
	sleep_s (random_range(0, .7)); 
	cs_push_stance(ai_current_actor, "flee");
	b_chantbreak = true;
	CreateThread(audio_grunt_chant_stop);
	repeat
		local dice:number = nil;
		local grunt_panictime:number = 0
		dice = random_range(1, 11);
		if(dice == 1)then
			cs_go_to(POINTS.ps_chant_flee.p0);
		elseif(dice == 2)then
			cs_go_to(POINTS.ps_chant_flee.p01);
		elseif(dice == 3)then
			cs_go_to(POINTS.ps_chant_flee.p02);
		elseif(dice == 4)then
			cs_go_to(POINTS.ps_chant_flee.p03);
		elseif(dice == 5)then
			cs_go_to(POINTS.ps_chant_flee.p04);
		elseif(dice == 6)then
			cs_go_to(POINTS.ps_chant_flee.p05);
		elseif(dice == 7)then
			cs_go_to(POINTS.ps_chant_flee.p06);
		elseif(dice == 8)then
			cs_go_to(POINTS.ps_chant_flee.p07);
		elseif(dice == 9)then
			cs_go_to(POINTS.ps_chant_flee.p08);
		elseif(dice == 10)then
			cs_go_to(POINTS.ps_chant_flee.p09);
		elseif(dice == 11)then
			cs_go_to(POINTS.ps_chant_flee.p10);
		end
		grunt_panictime = grunt_panictime + 1;
     until(grunt_panictime == 15);
end


function cs_turrtown_phantom()
	ai_cannot_die (ai_current_actor, true);
	cs_ignore_obstacles(ai_current_actor, true);
	object_cannot_die(unit_get_vehicle(ai_get_object(ai_current_actor)), true);
	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p00);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p01);
	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p02);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p03);
	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p04);
	cs_fly_to (POINTS.ps_turrettown_allyphantom1.p05);
	print ("Phantom is loading up!");
	f_load_drop_ship (AI.sq_turrtown_phantom1, AI.sq_turrtown_reinforcements_1, true, false, "any");
	sleep_s (1);
	f_load_drop_ship (AI.sq_turrtown_phantom1, AI.sq_turrtown_reinforcements_2, true, false, "any");
	sleep_s (1);
	print ("Phantom is unloading!");
	f_unload_drop_ship (AI.sq_turrtown_phantom1, "any");
	sleep_s (2);
	NavpointShowAllServer(AI.sq_turrtown_reinforcements_1, "ally");
	NavpointShowAllServer(AI.sq_turrtown_reinforcements_2, "ally");
	sleep_s (6);
	arbiter_in_place = true;
	print ("Arbiter Phantom is in place!");
end

function cs_turrtown_phantom2()
	ai_cannot_die (ai_current_actor, true);
	cs_ignore_obstacles(ai_current_actor, true);
	sleep_s (1);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom2.p00);
	cs_fly_to (POINTS.ps_turrettown_allyphantom2.p01);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom2.p02);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom2.p03);
	cs_fly_to (POINTS.ps_turrettown_allyphantom2.p04);
end

function cs_turrtown_phantom3()
	ai_cannot_die (ai_current_actor, true);
	cs_ignore_obstacles(ai_current_actor, true);
	sleep_s (2);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p00);
	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p01);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p02);
--	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p03);
	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p04);
	cs_fly_to (POINTS.ps_turrettown_allyphantom3.p05);
end

function cs_i_can_haz_burgertown_turret():void
	CreateThread(burgertown_turret_checker, ai_current_actor, "plasma_1", OBJECTS.plasma_1);
end
function cs_i_can_haz_shrike_turret():void
	--CreateThread(shrike_turret_checker, ai_current_actor, "plasma_3", OBJECTS.plasma_3);	--	--	--	--	--		Jayce did this
	print ("no more mounted turret in Tangletown");
end
function cs_tangletown_turret():void
	--ai_vehicle_enter(ai_current_actor, OBJECTS.shade_1, "shade_d");
	print ("no more shade_1 turret");
end
function cs_burgertown_turret():void
	ai_vehicle_enter(ai_current_actor, OBJECTS.plasma_1, "turret_g");
end
function cs_shrike_turret():void
	--ai_vehicle_enter(ai_current_actor, OBJECTS.plasma_3, "turret_g");
	print ("no entrance-facing turret in turret town");
end
function cs_tangletown_shade():void
	local dice:number = random_range(1,3);
end



function cs_friendly_banshee_1():void
	object_set_scale(ai_vehicle_get(ai_current_actor), 0.01, 0);
	object_set_scale(ai_vehicle_get(ai_current_actor), 1, 180);
	cs_fly_to(POINTS.ps_banshee_run.p0);
	cs_fly_to(POINTS.ps_banshee_run.p1);
	cs_fly_to(POINTS.ps_banshee_run.p2);
end
function cs_friendly_banshee_2():void
	object_set_scale(ai_vehicle_get(ai_current_actor), 0.01, 0);
	object_set_scale(ai_vehicle_get(ai_current_actor), 1, 180);
	cs_fly_to(POINTS.ps_banshee_run.p3);
	cs_fly_to(POINTS.ps_banshee_run.p4);
	cs_fly_to(POINTS.ps_banshee_run.p5);
end
function cs_friendly_banshee_3():void
	object_set_scale(ai_vehicle_get(ai_current_actor), 0.01, 0);
	object_set_scale(ai_vehicle_get(ai_current_actor), 1, 180);
	cs_fly_to(POINTS.ps_banshee_run.p6);
	cs_fly_to(POINTS.ps_banshee_run.p7);
	cs_fly_to(POINTS.ps_banshee_run.p8);
end



--## CLIENT
function remoteClient.shrike_explosion(fl1:flag, fl2:flag, fl3:flag, fl4:flag):void
	-- play explosions
	effect_new (TAG('levels\campaignworld020\w2_tsunami\fx\explosions\turret_explosion_md.effect'), fl1);
--	Sleep(15)
--	effect_new (TAG('levels\campaignworld020\w2_tsunami\fx\explosions\turret_explosion_md.effect'), fl2);
--	Sleep(15)
--	effect_new(TAG('levels\campaignworld020\w2_tsunami\fx\explosions\turret_explosion_md.effect'), fl3);
	effect_new(TAG('levels\campaignworld020\w2_tsunami\fx\fire\cov_dest_alley_fire_01.effect'), fl4);
end

function remoteClient.fire_cleanup(fl:flag):void
	effect_kill_from_flag(TAG('levels\campaignworld020\w2_tsunami\fx\fire\cov_dest_alley_fire_01.effect'), fl);
end
function remoteClient.shrike_gunfire(turret:object):void
	effect_new_on_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_l");
	sleep_s (.2);
	effect_new_on_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_r");
	sleep_s (.1);
	effect_kill_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_l");
	sleep_s (.2);
	effect_kill_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_r");
	sleep_s (.2);
	effect_new_on_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_l");
	sleep_s (.1);
	effect_new_on_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_r");
	sleep_s (.1);
	effect_kill_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_l");
	sleep_s (.1);
	effect_kill_object_marker (TAG('levels\campaignworld020\w2_tsunami\fx\theater\arb_dummy_firing_straight.effect'), turret, "mkr_turr_r");
end
function remoteClient.emp_charge_up():void
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_overload_station\fx\overload_station_pulse_shield.effect'), OBJECTS.dc_turr_shield_shutdown,"fx_top");
end
