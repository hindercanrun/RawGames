--## SERVER

---------------------------------------------- Old stuff that's been removed from the demo

-- old arcade stuff:
function demo_arcade_reset():void															-- reset arcade demo sequence
	--for _, playa in ipairs(players()) do
	--	teleport_player_to_flag(playa, FLAGS.fl_demo);
	--end
	
	
	if(current_zone_set() ~= ZONE_SETS.w2_tsunami_arcade)then
		switch_zone_set(ZONE_SETS.w2_tsunami_arcade);
	end
	stop_valid_composition( var_tsunami_theater_arcade_e3 );
	stop_valid_composition( v_demo_arcade_wounded);
	demo_arcade_destroy_flocks();
	ai_erase(AI.sg_demo_arcade);
	object_destroy_all();
	demo_arcade_reset_loadout();
	Sleep(1);
	garbage_collect_now();
	Sleep(3);
	--b_demo_shade_grunt_spawned = false;
	b_demo_arcade_start = false;
	CreateThread(demo_arcade_kill_threads_and_restart);
end

function narr_demo_grunts_die_listener():void
	SleepUntil([| ai_living_count(AI.demo_v2_greeters) >= 1 ], 5);
	SleepUntil([| ai_living_count(AI.demo_v2_greeters) <= 1 ], 1);
--	Grunts die:
	NarrativeQueue.QueueConversation(E3Demo_grunts_die); 
end
function narr_demo_shade_attack_listener():void
	SleepUntil([| volume_test_players( VOLUMES.tv_demo_arcade_turret_switch)  ], 1);
	sleep_s(1);
--	Shade turrets target Osiris:
	NarrativeQueue.QueueConversation(E3Demo_shade_turret_attack);
	var_e3_wounded_stairs_elite = true;						-- sends wounded elite crawling up the stairs
end
function narr_demo_shade_destroyed_listener():void
	SleepUntil([| ai_living_count(AI.demo_arcade_phase2.shade) >= 1  ], 5);
	SleepUntil([| ai_living_count(AI.demo_arcade_phase2.shade) <= 0  ], 1);
	sleep_s(1);
--	Shade turret destroyed:
	NarrativeQueue.QueueConversation(E3Demo_shade_turret_destroyed);
end
function narr_demo_grenadier_dead_listener():void
	SleepUntil([|  ai_living_count(AI.demo_arcade_phase3.grenadier) >= 1  ], 5);
	SleepUntil([|  ai_living_count(AI.demo_arcade_phase3.grenadier) <= 0  ], 1);
--	Plastmacaster elite dies:
	NarrativeQueue.QueueConversation(E3Demo_PLASMACASTER_dies);
end
function narr_demo_grenadier_bro_dead_listener():void
	SleepUntil([|  ai_living_count(AI.demo_arcade_phase3_grunts ) >= 1  ], 5);
	SleepUntil([|  ai_living_count(AI.demo_arcade_phase3_grunts ) <= 5  ], 1);
--	Grunt with the plasmacaster elite dies:
	NarrativeQueue.QueueConversation(E3Demo_PLASMACASTER_grunt_dies);
end
function narr_demo_jackals_listener():void
	SleepUntil([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke )  ], 1);
--	Jackals arrive:
	NarrativeQueue.QueueConversation(E3Demo_JACKALS_arrive);
end
function narr_demo_jackals_die_listener():void
	SleepUntil([| ai_living_count(AI.demo_arcade_phase4 ) >= 1    ], 1);
	SleepUntil([| ai_living_count(AI.demo_arcade_phase4 ) <= 0    ], 1);
--	Jackals die:
	sleep_s(1);
	NarrativeQueue.QueueConversation(E3Demo_JACKALS_die);
end
function narr_demo_ninja_arrival_listener():void
	SleepUntil([| volume_test_objects( VOLUMES.tv_demo_ninja, SPARTANS.locke) ], 1);
--	Active camo elite zealot arrives:
	sleep_s(.5);
	NarrativeQueue.QueueConversation(E3Demo_ELITE_ZEALOT_arrives);
end
function narr_demo_ninja_dead_listener():void
	SleepUntil([| ai_living_count(AI.demo_arcade_phase5 ) >= 1    ], 1);
	SleepUntil([| ai_living_count(AI.demo_arcade_phase5 ) <= 0    ], 1);
--	Elite zealot dies:
	NarrativeQueue.QueueConversation(E3Demo_ELITE_ZEALOT_dies);
end
-- arcade narrative threads that are called directly:------------------------------------------------------------------------------
function narr_demo_grenadier_firing():void																	-- called from cs
	sleep_s(2);
--	Elite with the plasma caster arrives:
	NarrativeQueue.QueueConversation(E3Demo_PLASMACASTER_arrives);
end


function demo_ninja():void
	ai_erase(AI.demo_arcade_phase5.swordboy);
	Sleep(2);
	ai_place(AI.demo_arcade_phase5.swordboy);
end
function demo_arcade_vale_bunker_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_arcade_1)], 2);
	v_demo_arcade_bunker_comp = composer_play_show("vin_e3_vale_bunker");
end

function cs_grunt_greeter_1()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		cs_enable_targeting(ai_current_actor, true);
		ai_braindead(ai_current_actor, false);
		cs_go_to(POINTS.ps_demo_greeters.a);
end
function cs_grunt_greeter_2()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		cs_enable_targeting(ai_current_actor, true);
		ai_braindead(ai_current_actor, false);
		cs_go_to(POINTS.ps_demo_greeters.b);
end
function cs_grunt_greeter_3()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		cs_enable_targeting(ai_current_actor, true);
		ai_braindead(ai_current_actor, false);
		cs_go_to(POINTS.ps_demo_greeters.c);
end

function cs_grunt_intro_01()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		sleep_s(0.25);  
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\grunt\grunt.model_animation_graph'),"combat:pistol:cheer", true);
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_09);
			sleep_s(0.12);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_09);
			sleep_s(0.75);  
		until false ;
end

function cs_grunt_intro_02()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_08);
		cs_go_to(POINTS.demo_arcade_intro.p03, 0 );
		cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_08);
		sleep_s(0.25);  
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_08);
			sleep_s(0.25);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_08);
			sleep_s(0.90);  
		until false ;
end

function cs_grunt_intro_03()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_02);
			sleep_s(0.12);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_02);
			sleep_s(0.75);  
		until false ;
end

function cs_grunt_intro_04()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_10);
		cs_go_to(POINTS.demo_arcade_intro.p08, 0.5 );
		cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_10);
		sleep_s(0.1);  
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_10);
			Sleep(5);
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_10);
			sleep_s(0.33);  
		until false ;
end

function cs_grunt_intro_05()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\grunt\grunt.model_animation_graph'),"combat:pistol:evade_right", true);
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_01);
			sleep_s(0.30);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_01);
			sleep_s(0.5);  
		until (false);
end

function cs_grunt_intro_06()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		--cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_10);
		--cs_go_to(POINTS.demo_arcade_intro.p08, 0.5 );
		--cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_10);
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\grunt\grunt.model_animation_graph'),"berserk:pistol:taunt:var1", true);
		sleep_s(0.1);  
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_10);
			Sleep(5);
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_10);
			sleep_s(0.33);  
		until false ;
end

function cs_grunt_intro_07()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_05);
			sleep_s(0.15);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_05);
			sleep_s(1);  
		until false ;
end

function cs_grunt_intro_08()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.1, 0.1 );
	SleepUntil( [| b_demo_arcade_start ] , 1 );
		ai_braindead(ai_current_actor, false);
		
		
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\grunt\grunt.model_animation_graph'),"berserk:pistol:charge_front:var1", false);
		cs_go_to(POINTS.demo_arcade_intro.p04, 0.5 );
		Sleep(5);
		
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_06);
			Sleep(5);
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_06);
			sleep_s(0.45);  
		until false ;
end

function cs_demo_shade():void																
	Sleep(4);
	CreateThread(demo_shade_health);
	unit_set_maximum_vitality( ai_get_object( ai_current_actor ) ,1, 0 );
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,1, 0);
	unit_set_current_vitality( ai_vehicle_get_from_squad(AI.demo_arcade_phase2) ,0.1, 0.1 );
	unit_set_current_vitality( object_at_marker(ai_vehicle_get_from_squad(AI.demo_arcade_phase2), "turret") ,0.1, 0.1 );
	local b_sky_target_switch: boolean = false;
	ai_braindead(ai_current_actor, false);
		repeat
		Sleep(1);
		 if b_sky_target_switch then
			cs_aim(true, POINTS.demo_shade.pfire_high_away);
			sleep_s(0.25);
			cs_shoot_at(true, POINTS.demo_shade.pfire_high_away);
			b_sky_target_switch = false;
		else
			cs_aim(true, POINTS.demo_shade.pfire_high_away2);
			sleep_s(0.25);
			cs_shoot_at(true, POINTS.demo_shade.pfire_high_away2);
			b_sky_target_switch = true;
		end
		
		if  not volume_test_players( VOLUMES.tv_demo_arcade_turret_switch )  then
			sleep_s(1);
		end
		
	--until( b_demo_shade_grunt_spawned and ai_living_count( AI.demo_arcade_phase2b.grunt_trigger_shade ) == 0);
	until volume_test_players( VOLUMES.tv_demo_arcade_turret_switch ) ;
	--SleepUntil([| ai_spawn_count( AI.demo_arcade_phase2b.grunt_trigger_shade ) > 0 and ai_living_count( AI.demo_arcade_phase2b.grunt_trigger_shade ) == 0], 3);	-- vale will shoot this grunt to trigger the
	repeat
		cs_aim(true, POINTS.demo_shade.p0);
		sleep_s(0.5);
		cs_shoot_at(true, POINTS.demo_shade.p0);
		sleep_s(random_range(2,6));
	until(false);
end
function demo_shade_health():void
	SleepUntil([| ai_living_count(AI.demo_arcade_phase2.shade) <= 0], 1);
	object_set_health(object_at_marker(ai_vehicle_get_from_squad(AI.demo_arcade_phase2), "turret") , 0);
end
function cs_demo_shade_bros():void															-- need to improve. Follows the lead of cs_demo_shade
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_arcade_1)], 10);
	ai_braindead(ai_current_actor, false);
	repeat
		local x:number = random_range(1,3);
		if(x==1)then
			cs_aim(true, POINTS.demo_shade.p0);
			sleep_s(0.5);
			cs_shoot_at(true, POINTS.demo_shade.p0);
			sleep_s(random_range(2,6));
		elseif(x==2)then
			cs_aim(true, POINTS.demo_shade.p01);
			sleep_s(0.5);
			cs_shoot_at(true, POINTS.demo_shade.p01);
			sleep_s(random_range(2,6));
		else
			cs_aim(true, POINTS.demo_shade.p02);
			sleep_s(0.5);
			cs_shoot_at(true, POINTS.demo_shade.p02);
			sleep_s(random_range(2,6));
		end
	until(false)
end

function cs_demo_grenadier_a():void																
	ai_braindead(ai_current_actor, false);
	object_set_shield(ai_get_object(ai_current_actor), .5);
	object_set_health(ai_get_object(ai_current_actor), .3);
--	unit_set_maximum_vitality( ai_get_object( ai_current_actor ), 50, 50 );
--	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,50, 50 );
	cs_aim(true, POINTS.demo_shade.p03);
	sleep_s(0.5);
	cs_shoot_at(true, POINTS.demo_shade.p03);
	--sleep_s(.5);
	CreateThread(narr_demo_grenadier_firing);
	repeat 
		cs_aim(true, POINTS.demo_shade.p03);
		Sleep(3);
		cs_shoot_at(true, POINTS.demo_shade.p03);
		Sleep(1);
	until object_get_health(AI.demo_arcade_phase2.shade) <= 0  ;
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_bolt.damage_effect'), SPARTANS.locke);
	--SleepUntil( [| volume_test_objects( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke ) ] ,1 );
		sleep_s(.5);
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_bolt.damage_effect'), SPARTANS.locke);
		cs_go_to(POINTS.demo_arcade.a);
		--sleep_s(.1);

		sleep_s(.5);
		damage_object_effect(TAG('objects\weapons\pistol\plasma_pistol\projectiles\damage_effects\plasma_pistol_bolt.damage_effect'), SPARTANS.locke);
		repeat
			cs_aim(true, POINTS.demo_shade.p17);
			sleep_s(0.15);  
			cs_shoot_at(true, POINTS.demo_shade.p17);
			Sleep(1);
		until  false ;
		sleep_s(9999);
end

function cs_grenadier_grunts()
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.6, 0.6 );
	
		repeat
			sleep_rand_s( 1,3);
			cs_aim(true, POINTS.demo_arcade_intro.pfireloc2);
			sleep_s(0.15);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfireloc2);	
			
		until( object_get_health(AI.demo_arcade_phase2.shade) <= 0 );
	--SleepUntil([| object_get_health(AI.demo_arcade_phase2.shade) <= 0  ] , 2 );
		sleep_rand_s( 0.25,1);
end

function cs_demo_leaper_a()

	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_kamikaze, SPARTANS.locke)], 3);
		cs_go_to( POINTS.demo_arcade_intro.p12);
		--cs_jump( 50,3.5 )
	
		--cs_go_to( POINTS.demo_arcade_intro.p12);
		ai_grunt_kamikaze( ai_current_actor );
		--cs_go_to( POINTS.demo_arcade_intro.p11);
		--Sleep(10000 );
end 



function cs_demo_shade_grunt()
	b_demo_shade_grunt_spawned = true;
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_kamikaze, SPARTANS.locke)], 2);
		cs_aim(true, POINTS.demo_arcade_intro.pfireloc);
		sleep_s(0.15);  
		cs_shoot_at(true, POINTS.demo_arcade_intro.pfireloc);	
		cs_go_to( POINTS.demo_arcade_intro.p16);
	--cs_jump( 50,3.5 )

		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfire_loc_11);
			sleep_s(0.15);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfire_loc_11);	
			sleep_rand_s( 3,5);
		until( false);
	--cs_go_to( POINTS.demo_arcade_intro.p12);
	--ai_grunt_kamikaze( ai_current_actor );
	--cs_go_to( POINTS.demo_arcade_intro.p11);
	--sleep_s(10000 );
end 

function cs_demo_leaper_buddy()

	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_kamikaze, SPARTANS.locke)], 2);
		cs_aim(true, POINTS.demo_arcade_intro.pfireloc2);
		sleep_s(0.33);  
		cs_shoot_at(true, POINTS.demo_arcade_intro.pfireloc2);	
		cs_go_to( POINTS.demo_arcade_intro.p15);
		repeat
			cs_aim(true, POINTS.demo_arcade_intro.pfireloc2);
			sleep_s(0.15);  
			cs_shoot_at(true, POINTS.demo_arcade_intro.pfireloc2);	
			sleep_rand_s( 3,5);
		until( false);
	sleep_s(10000 );
end 



function cs_demo_shield_a():void
	ai_braindead(ai_current_actor, false);
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke ) ] , 2 );
	--	cs_go_to(POINTS.demo_arcade.s_a01);
	
	--SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_gun_grab , SPARTANS.locke ) ] , 2 );
	--	object_teleport( ai_get_object( ai_current_actor ), POINTS.demo_arcade.s_a02);
		cs_go_to(POINTS.demo_arcade.s_a);
end

function cs_demo_shield_b():void
	ai_braindead(ai_current_actor, false);
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke ) ] , 2 );
	--cs_go_to(POINTS.demo_arcade.s_b01);
--	cs_go_to(POINTS.demo_arcade.s_b);
	--SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_gun_grab , SPARTANS.locke ) ] , 2 );
	--object_teleport( ai_get_object( ai_current_actor ), POINTS.demo_arcade.s_b02);
	cs_go_to(POINTS.demo_arcade.s_b);

end

function cs_demo_shield_c():void
	ai_braindead(ai_current_actor, false);
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke ) ] , 2 );
	--cs_go_to(POINTS.demo_arcade.s_c01);
	--cs_go_to(POINTS.demo_arcade.s_c);
	--SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_gun_grab , SPARTANS.locke ) ] , 2 );
	--object_teleport( ai_get_object( ai_current_actor ), POINTS.demo_arcade.s_c02);
	cs_go_to(POINTS.demo_arcade.s_c);
end

function cs_demo_shield_d():void
	ai_braindead(ai_current_actor, false);
	SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_charge , SPARTANS.locke ) ] , 2 );
	--cs_go_to(POINTS.demo_arcade.s_d01);
	--SleepUntil ([| volume_test_objects ( VOLUMES.tv_demo_arcade_grenadier_gun_grab , SPARTANS.locke ) ] , 2 );
	--object_teleport( ai_get_object( ai_current_actor ), POINTS.demo_arcade.s_d02);
	cs_go_to(POINTS.demo_arcade.s_d);
end


function cs_demo_ninja():void
	object_set_shield(ai_get_object(ai_current_actor), 0);
	object_set_health(ai_get_object(ai_current_actor), .2);
	ai_set_active_camo(ai_current_actor, true);
	SleepUntil([|	volume_test_objects( VOLUMES.tv_demo_ninja, SPARTANS.locke)], 1);
		cs_face_object(ai_current_actor, true, SPARTANS.locke);	-- 5/5 to try to fix weird facing bug
		ai_set_active_camo(ai_current_actor, false);
		sleep_s(0.1); 
		object_set_shield(ai_get_object(ai_current_actor), 0);
		object_set_health(ai_get_object(ai_current_actor), .2);
--		unit_set_maximum_vitality( ai_get_object( ai_current_actor ) , 70, 0);
--		unit_set_current_vitality( ai_get_object( ai_current_actor ) , 70, 0);

--		ai_braindead(ai_current_actor, false);
		Sleep(2);
		
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:dive_front", true);
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:melee:var4", false);
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:turn_right_90", false);
		--s_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:melee:var1", false);
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:turn_left_180", false);
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:melee:var2", false);
		--cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:taunt", false);
		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:go_berserk", true);
--		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:idle", true);
--		cs_custom_animation(ai_current_actor, true, TAG('objects\characters\elite\elite.model_animation_graph'),"combat:sword:go_berserk", true);
		composer_play_show("vin_e3_arcade_elite_react");
		sleep_s(9999999999);
end
-- OLD INTERIOR STUFF:

function demo_interior_restart():void
	for _, playa in ipairs(players()) do
		teleport_player_to_flag(playa, FLAGS.fl_demo_interior);
	end
	if(current_zone_set() ~= ZONE_SETS.w2_tsunami_destruction)then
		switch_zone_set(ZONE_SETS.w2_tsunami_destruction);
	end

	ai_erase(AI.sg_demo_interior);
	garbage_collect_now();
	Sleep(3);

	CreateThread(demo_interior_kill_threads_and_restart);
end
function demo_interior_pawn_reset():void
	ai_erase(AI.sg_demo_interior);
	CreateThread(demo_interior_kill_threads);
	CreateThread(demo_interior_kill_compositions);
	garbage_collect_now();
	Sleep(2);
	v_demo_pawn_room_thread = CreateThread(demo_ass_pawn_immediate);
end
function demo_interior_pawns_toggle():void
	if(ai_living_count(AI.sg_demo_interior_pawns_all) >= 1)then
		ai_erase(AI.sg_demo_interior_pawns_all);
	else
		demo_ai_place_no_drops(AI.sg_demo_interior_pawns_all);
	end
end
function demo_interior_soldiers_reset():void
	CreateThread(clear_demo_thread, v_demo_soldier_thread);
	CreateThread(stop_valid_composition, v_demo_soldier_comp);
	b_demo_soldier = false;				
	Sleep(2);
	v_demo_soldier_thread = CreateThread(demo_soldier_with_sleep_untils);
end
function demo_interior_soldiers_without_pauses():void
	CreateThread(clear_demo_thread, v_demo_soldier_thread);
	CreateThread(stop_valid_composition, v_demo_soldier_comp);
	b_demo_soldier = false;																	-- looping condition on soldier composition
	v_demo_soldier_thread = CreateThread(demo_soldier_immediate);
end
function demo_interior_locke_in_place():void
	object_teleport( SPARTANS.locke , FLAGS.fl_demo_soldier_locke);
end

function demo_soldier_listener(bit:boolean):void														
--	v_demo_soldier_thread
	if (bit == nil)then
		bit = true;
	end
	SleepUntil(	[|	volume_test_players(VOLUMES.tv_demo_vale_soldier)
				or	bit == false
				], 3);
	v_demo_soldier_comp = composer_play_show("vin_e3_soldier_encounter");
	
	SleepUntil([|	volume_test_player_lookat(VOLUMES.tv_demo_look_2, SPARTANS.tanaka, 9, 2) 
				or	player_action_test_melee() == true 
				or	bit == false
				], 1, 600);
	b_demo_soldier = true;
	CreateThread(demosys_set_soldier_health);
end
function demosys_set_soldier_health():void
	SleepUntil([|ai_living_count(AI.e3_soldiers_sq.soldier_main) >= 1], 5);
	object_cannot_die(ai_get_object( AI.e3_soldiers_sq.soldier_bg1), true);
	object_cannot_die(ai_get_object( AI.e3_soldiers_sq.soldier_bg2), true);
	object_cannot_die(ai_get_object( AI.e3_soldiers_sq.soldier_main), true);
	unit_doesnt_drop_items(AI.e3_soldiers_sq);
	unit_set_current_vitality( ai_get_object( AI.e3_soldiers_sq.soldier_main) ,0.20, 0.20 );
	
	SleepUntil([|ai_living_count(AI.e3_soldiers_sq.soldier_main) <= 0], 5);
	object_cannot_die(ai_get_object( AI.e3_soldiers_sq.soldier_bg1), false);
	sleep_s(.18);
	object_cannot_die(ai_get_object( AI.e3_soldiers_sq.soldier_bg2), false);
end
function demo_soldier_immediate():void
	demo_soldier_listener(false);
end
function demo_soldier_with_sleep_untils():void
	demo_soldier_listener(true);
end


function cs_bishop_1():void
	cs_fly_to(POINTS.demo_bishops.b);
	cs_fly_to(POINTS.demo_bishops.d);
	sleep_s(1);
end
function cs_bishop_2():void
	cs_fly_to(POINTS.demo_bishops.a);
	cs_fly_to(POINTS.demo_bishops.b);
	cs_fly_to(POINTS.demo_bishops.c);
	sleep_s(1);
end
function cs_bishop_3():void
	cs_fly_to(POINTS.demo_bishops.a);
	cs_fly_to(POINTS.demo_bishops.b);
	cs_fly_to(POINTS.demo_bishops.e);
	sleep_s(1);
end
function cs_demo_soldier_interior_a():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_top_of_ramp)], 2);
	cs_go_to_and_face(POINTS.demo_soldiers.a, POINTS.demo_soldiers.look1);
	SleepUntil([| volume_test_player_lookat(VOLUMES.tv_demo_look_1, SPARTANS.locke, 10, 25)], 2);
	cs_go_to_and_face(POINTS.demo_soldiers.c, POINTS.demo_soldiers.look1);
	sleep_s(3);
	cs_go_to_and_face(POINTS.demo_soldiers.e, POINTS.demo_soldiers.look1);
end
function cs_demo_soldier_interior_b():void
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_top_of_ramp)], 2);
	cs_go_to_and_face(POINTS.demo_soldiers.b, POINTS.demo_soldiers.look1);
	SleepUntil([| volume_test_player_lookat(VOLUMES.tv_demo_look_1, SPARTANS.locke, 10, 25)], 2);
	Sleep(30);
	cs_go_to_and_face(POINTS.demo_soldiers.d, POINTS.demo_soldiers.look1);
	sleep_s(2);
	cs_go_to_and_face(POINTS.demo_soldiers.e, POINTS.demo_soldiers.look1);
end

-- old fight stuff:
function knight_health():void
	local health:number = 0
	repeat
		health = unit_get_health(ai_get_object(AI.vin_e3_knight_squad));
		print(health);
		sleep_s(.2);
	until(false);
end
function knight_test_cycle():void
	local num:number = 10;
	sleep_s(1);
	repeat
		print(num)
		sleep_s(1);
		num = num - 1;
	until(num == 0);

	var_demo_fight_objcon = 30;
	num = 10;
	print("30");
	repeat
		print(num)
		sleep_s(1);
		num = num - 1;
	until(num == 0);

	var_demo_fight_objcon = 40;
	num = 10;
	print("40");
	repeat
		print(num)
		sleep_s(1);
		num = num - 1;
	until(num == 0);

	var_demo_fight_objcon = 50;
	print("50");
end
--[[
	repeat
		cs_custom_animation(AI.vin_e3_knight_squad, true, TAG('objects\characters\knight\knight.model_animation_graph'),"combat:any:smash_left", true);
		sleep_s(5);
	until(false);
--]]

function cs_knight_30():void																				-- look at approaching spartans and taunt, then shoot )30( 
	print("Knight Tender: 30 go----");
		cs_go_to(POINTS.demo_knight.root);
		cs_face_object(ai_current_actor, true, SPARTANS.locke);
		sleep_s(1.5);
		cs_custom_animation(AI.vin_e3_knight_squad, true, TAG('objects\characters\knight\knight.model_animation_graph'),"combat:any:taunt:var2", true);	-- pound fist
	
		repeat
			cs_aim(true, POINTS.demo_knight.shoot_1);
			sleep_s(.5);
			cs_shoot_at(true, POINTS.demo_knight.shoot_1);
			sleep_s(3);
			cs_aim(true, POINTS.demo_knight.shoot_2);
			sleep_s(.5);
			cs_shoot_at(true, POINTS.demo_knight.shoot_2);
			sleep_s(3);
		until(var_demo_fight_objcon >= 40) ;			--- BACKPANELS OFF -- SET VIA LOOK AT 
end
function knight_test_50():void
	cs_run_command_script(AI.vin_e3_knight_squad, "cs_knight_50");
end
function cs_knight_40():void																				-- face tanaka, roar )40(
	print("Knight Tender: 40 go----");
	cs_face_object(ai_current_actor, true, SPARTANS.tanaka); --test
--	cs_face_object(ai_current_actor, true, SPARTANS.tanaka);
	sleep_s(1.5);
	cs_custom_animation(AI.vin_e3_knight_squad, true, TAG('objects\characters\knight\knight.model_animation_graph'),"combat:any:go_berserk", true);	--roar
end
function cs_knight_50():void
	
	print("Knight Tender: 50 go----");
	cs_move_towards(SPARTANS.buck, true);
--	cs_face_object(ai_current_actor, true, SPARTANS.locke); --test
	--cs_face_object(ai_current_actor, true, SPARTANS.buck);
--	sleep_s(1.5);
--	cs_custom_animation(AI.vin_e3_knight_squad, true, TAG('objects\characters\knight\knight.model_animation_graph'),"combat:any:smash_left", true);	-- melee
	sleep_s(10);
end
function cs_pawn_knight_1():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	cs_go_to(POINTS.demo_gpm.a01);
	sleep_s(1);
end
function cs_pawn_knight_2():void
	unit_set_current_vitality( ai_get_object( ai_current_actor ) ,0.35, 0.35 );
	cs_go_to(POINTS.demo_gpm.a02);
	sleep_s(1);
end

function demo_knight():void
	b_knight_stuck = false;
	b_knight_vale = false;

	clear_demo_thread(v_demo_knight_thread);
		sleep_s(.05);
		v_demo_knight_thread = CreateThread(demo_knight_warning_shots);
	
	stop_valid_composition(v_demo_knight_comp);
		ai_erase(AI.vin_e3_knight_squad);
		Sleep(2);
		demo_ai_place_no_drops(AI.vin_e3_knight_squad);
		sleep_s(.05);
		v_demo_knight_comp = composer_play_show("vin_e3_knight");
end
function demo_reset_knight():void
	for _, playa in ipairs(players()) do
		teleport_player_to_flag(playa, FLAGS.fl_demo_knight_sequence);
	end
	var_demo_fight_objcon = 20;
	CreateThread(demo_fight_objcon_manager);
	CreateThread(demo_knight);
end
function demo_knight_live():void
	cs_run_command_script(AI.vin_e3_knight_squad, "cs_demo_knight_live");
end
function demo_knight_warning_shots():void
	SleepUntil([| volume_test_objects(VOLUMES.tv_demo_warning_shots, SPARTANS.locke)], 1);
	RunClientScript("client_incinerate", FLAGS.fl_incinerate_1);
	sleep_s(1);
	RunClientScript("client_incinerate", FLAGS.fl_incinerate_2);
	SleepUntil([| volume_test_players(VOLUMES.tv_demo_objcon_30)], 1);
	NarrativeQueue.QueueConversation(E3Demo_KNIGHT_appears);			-- knight on the field
--	SleepUntil([| volume_test_objects(VOLUMES.tv_vale_mine, SPARTANS.vale)], 1, 300);
	SleepUntil([| b_knight_vale == true], 2);							--- from comp
	RunClientScript("client_incinerate", FLAGS.fl_incinerate_3);
	sleep_s(.05);
	DownUnit(SPARTANS.vale);
	SleepUntil([| unit_get_health(ai_get_object(AI.vin_e3_knight_squad)) <= .8], 1);
	b_knight_stuck = true;												--- advances comp to death prep action
	damage_object( ai_get_object(AI.vin_e3_knight_squad), "", 200 );
end
function demo_start_pawn_fight_listener():void
	--SleepUntil([| volume_test_objects(VOLUMES.tv_demo_slipspawn, SPARTANS.locke)], 2);	
	--SleepUntil([| volume_test_player_lookat(VOLUMES.tv_demo_look_knight, SPARTANS.tanaka, 10, 1) ], 2, 960);
--[[	
	slip_space_spawn_no_drops(AI.demo_fight_soldiers_a);
	sleep_s(.2);
	slip_space_spawn_no_drops(AI.demo_fight_front_pawns_b);
	sleep_s(.2);
	slip_space_spawn_no_drops(AI.demo_fight_front_pawns_a);
	sleep_s(.2);
	slip_space_spawn_no_drops(AI.demo_fight_front_pawns_c);
	SleepUntil([|ai_living_count(AI.sg_demo_fight_pawns) >= 6], 3);
	sleep_s(.1)
	SleepUntil([|ai_living_count(AI.sg_demo_fight_pawns) <= 3], 3);
	CreateThread( SlipSpaceSpawn, AI.demo_fight_upper_soldiers );	
--]]
end
function cs_demo_knight_live():void
--	ai_set_deaf(ai_current_actor, false);
--	SleepUntil([| object_is_puppet(ai_get_object(ai_current_actor)) == false], 1);
--	cs_face(true, POINTS.demo_knight.end_face);
--	cs_enable_moving(ai_current_actor, false);
--	ai_braindead(ai_current_actor, true);
--	ai_set_blind(ai_current_actor, true);
--	ai_set_deaf(ai_current_actor, true);
--	cs_face(true, POINTS.demo_knight.end_face);
end

-- old fight stuff we used to block out the sequence:
-- delete and remove from wiki when possible:
function demo_fight_spawn_all():void
	object_create_folder_anew(MODULES.demo_fight);
	object_create_folder_anew(MODULES.demo_flight);
	CreateThread(demo_fight_kill_threads);
	ai_erase(AI.sg_demo_fight_dummies);
	CreateThread(demo_fight_thread_all);
end
function demo_fight_reset_OLD():void
	CreateThread(demo_fight_kill_threads);
	Sleep(2);
	CreateThread(demo_crawlers_off);
	CreateThread(demo_soldiers_off);
	CreateThread(demo_knights_off);
	Sleep(10);
	garbage_collect_now();
	sleep_s(1);
	CreateThread(demo_fight_thread_all);
end
function demo_fight_thread_all():void
	v_demo_pawns_thread		= CreateThread(demo_crawlers_on);
	v_demo_soldiers_thread	= CreateThread(demo_soldiers_on);
	v_demo_knights_thread	= CreateThread(demo_knights_on);
end
function demo_fight_kill_threads_OLD():void
	CreateThread(clear_demo_thread, v_demo_pawns_thread);
	CreateThread(clear_demo_thread, v_demo_soldiers_thread);
	CreateThread(clear_demo_thread, v_demo_knights_thread);
end
function demo_crawlers_on():void
	demo_spawn_crawlers_repeatedly(true);
end
function demo_crawlers_off():void
	demo_spawn_crawlers_repeatedly(false);
end
function demo_soldiers_on():void
	demo_spawn_soldiers_repeatedly(true);
end
function demo_soldiers_off():void
	demo_spawn_soldiers_repeatedly(false);
end
function demo_knights_on():void
	demo_spawn_knights_repeatedly(true);
end
function demo_knights_off():void
	demo_spawn_knights_repeatedly(false);
end



function demo_spawn_crawlers_repeatedly(bool:boolean):void
	demo_crawlers_respawn = bool;
	if	(		ai_living_count(AI.demo_crawlers) >= 1
		or		bool == false
		)then
			ai_erase(AI.demo_crawlers);
			return;
	else
			demo_ai_place_no_drops(AI.demo_crawlers);
	end
	local guys:table =
		{
			AI.demo_crawlers.a,
			AI.demo_crawlers.b,
			AI.demo_crawlers.c,
			AI.demo_crawlers.d,
			AI.demo_crawlers.e,
			AI.demo_crawlers.f,
			AI.demo_crawlers.g,
			AI.demo_crawlers.h,
			AI.demo_crawlers.i,
			AI.demo_crawlers.j,
			AI.demo_crawlers.k,
			AI.demo_crawlers.l,
			AI.demo_crawlers.m
		};
	if(demo_crawlers_respawn) then
		repeat
			sleep_s(1);
			for _,guy  in ipairs(guys) do
				if	(	ai_living_count(guy) <= 0
					) 
				then
					sleep_s(10);
					if(demo_crawlers_respawn) then
						demo_ai_place_no_drops(guy);
					end
				end
			end
		until(demo_crawlers_respawn == false)
	end
end
function demo_spawn_soldiers_repeatedly(bool:boolean):void
	demo_soldiers_respawn = bool;
	if	(	ai_living_count(AI.demo_soldiers) >= 1
		or	bool == false
		)then
		ai_erase(AI.demo_soldiers);
		return;
	else
		demo_ai_place_no_drops(AI.demo_soldiers);
		
	end
	local guys:table =
		{
			AI.demo_soldiers.a,
			AI.demo_soldiers.b,
			AI.demo_soldiers.c,
			AI.demo_soldiers.d,
			AI.demo_soldiers.e,
			AI.demo_soldiers.f,
			AI.demo_soldiers.g,
			AI.demo_soldiers.h,
			AI.demo_soldiers.i,
			AI.demo_soldiers.j,
			AI.demo_soldiers.k,
			AI.demo_soldiers.l,
			AI.demo_soldiers.m,
			AI.demo_soldiers.n,
			AI.demo_soldiers.o,
			AI.demo_soldiers.p,
			AI.demo_soldiers.q,
			AI.demo_soldiers.r,
		};
	if(demo_soldiers_respawn) then
		repeat
			sleep_s(1);
			for _,guy  in ipairs(guys) do
				if	(	ai_living_count(guy) <= 0
					) 
				then
					sleep_s(10);
					if(demo_soldiers_respawn)then
						demo_ai_place_no_drops(guy);
					end
				end
			end
		until(demo_soldiers_respawn == false)
	end
end
function demo_spawn_knights_repeatedly(bool:boolean):void
	demo_knights_respawn = bool;
	if	(		ai_living_count(AI.demo_knights) >= 1
		or		bool == false
		)then
		ai_erase(AI.demo_knights);
		return;
	else
		demo_ai_place_no_drops(AI.demo_knights);
	end
	local guys:table =
		{
			AI.demo_knights.a,
			AI.demo_knights.b,
			AI.demo_knights.c,
			AI.demo_knights.d,
			AI.demo_knights.e
		};
	if(demo_knights_respawn) then
		repeat
			sleep_s(1);
			for _,guy  in ipairs(guys) do
				if	(	ai_living_count(guy) <= 0
					) 
				then
					sleep_s(10);
					if(demo_knights_respawn) then
						demo_ai_place_no_drops(guy);
					end
				end
			end
		until(demo_knights_respawn == false)
	end
	
end