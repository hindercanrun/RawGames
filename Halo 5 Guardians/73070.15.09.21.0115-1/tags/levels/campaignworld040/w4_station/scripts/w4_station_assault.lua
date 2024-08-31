--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------









--STATE VARS

--BOOLS
--global g_b_dropped: boolean = false;
--global g_b_assault_stat_drop_complete: boolean = false;
global g_b_shutters_open: boolean = false;	
global g_b_back_door_open: boolean = false;
global g_b_assault_mission_complete: boolean = false;
global b_assault_begin:boolean = false;
global b_assault_intro_cin_done:boolean = false;
--TEST VARS

--global g_b_musketeers = true;
global g_b_disable_jump = true;

global g_b_skip_intro = false;
global g_ics_player0:object = nil;

--OBJCONS




---------------------------------------------
---------------------------------------------
-- START
---------------------------------------------
---------------------------------------------


function startup.start_assault_main()


	if not editor_mode() then
		CreateThread(audio_cinematic_mute_assault);
		-- Fade out so that level is not seen before cinematic is started
		--switch_zone_set(ZONE_SETS.cin030_facade);
		fade_out(0,0,0,0);
		
		StartAssaultOnTheStation();
		
	else
		print("in editor");
		fade_in (0, 0, 0, 0);
		print("IN FABER USE BLINKS OR TYPE StartAssaultOnTheStation to start mission")
	end
	
	print("STARTUP W4 v4.7");

	

 SleepUntil( [|  player_get_first_valid() ], 1 );
		print( 	"GAME DIFFICULTY: ", game_difficulty_get_real() ); 

		--physics_set_gravity( 1.0 );
		--fade_in(0, 0, 0, 0);		
		
	--print ("Assault on the Station intro cinematic");
	RunClientScript ("w4_assualt_camera_dust_stop");
	CinematicPlay ("cin_035_blueteam" ); 
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen_off.sound'), nil, 1);
	RunClientScript ("w4_assualt_camera_dust");

	--gmu 8/12/2015 - OSR-146611 -- Waiting until after the teleport to fade
	if not editor_mode() then
		f_assault_move_to_starting_locations();
	end
	
	cinematic_show_letterbox_immediate(true);
	Sleep(1);
	fade_in (0,0,0,60);
	
	f_assault_intro_cin_end();
	game_save_immediate();
	Sleep(1);

	
	b_assault_intro_cin_done = true;

	print ("starting station assault");

	--coop acheevo setup listeners
	RegisterDeathEvent(AssaultAnyDeath, nil);
	CreateThread( f_check_for_elite_cheevo );
	
	Wake( dormant.f_assault_main_init );		
	SleepUntil( [| g_b_assault_mission_complete ] , 1 );
		EndMission(AssaultOnTheStation);		
	
		
end

function f_assault_move_to_starting_locations()
	SleepUntil([| SPARTANS.chief ] ,1 );
		TeleportNoFX();
		print("start locs");
		object_teleport( SPARTANS.chief, FLAGS.fl_assault_start_chief );
		object_teleport( SPARTANS.kelly, FLAGS.fl_assault_start_kelly );
		object_teleport( SPARTANS.fred, FLAGS.fl_assault_start_fred );
		object_teleport( SPARTANS.linda, FLAGS.fl_assault_start_linda );
end

function f_assault_intro_cin_end()

	if not editor_mode() then
		if current_zone_set_fully_active() ~= ZONE_SETS.zs_01 then
			--switch_zone_set(ZONE_SETS.zs_01);
			
		end
	end
	print("intro cinemaic done");
	
end

function debug_station_assault_complete()
	g_b_assault_mission_complete = true;
end


function test_headlamp_area()

	f_setup_headlamp_area( VOLUMES.tv_hunter_form, test_lamp_bool );
end

global b_test_lamp:boolean = false;

function test_lamp_bool():boolean
	--print("returning" , b_test_lamp );
	return b_test_lamp;
end




------------------------------------------------------
--  STATION INTERIOR
----------------------------------------------------


function dormant.f_assault_main_init()
--	CreateThread( f_assault_balance_fixer );
-- removing as per OSR-124310, Linda will have a sniper rifle in the tunnels now

	SleepUntil( [|  volume_test_players( VOLUMES.tv_assault_init ) and b_assault_intro_cin_done ], 1 );
		
		print("assault init");


		Wake( dormant.w4_assault_techcenter_init );

		
		b_assault_begin = true;
		print (b_assault_begin);

end



function f_assault_volume_teleport_all_not_inside(tv:volume, fl:flag)
	for _,spartan in ipairs( spartans() ) do
		if not volume_test_object (tv, spartan) then
			object_teleport( spartan , fl);
		end
	end
end





function MusketeerUtil_SetDestination_Assault(dest:location)

	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
		
		MusketeerDestSetPoint(obj, dest, 5);
	
	end
end


function MusketeerUtil_SetDestination_Assault_Clear()

	for _, obj in ipairs (ai_actors(GetMusketeerSquad())) do
			MusketeerDestClear(obj);
	end
end

global b_assault_objective_avail:boolean = true;
 
global ct_assault_current_objective:title = TITLES.ct_obj_assault_1_main;

function f_assault_set_objective( ch_title:title, b_complete:boolean )


		
		if b_complete then
			--f_assault_complete_objective();
		end
		b_assault_objective_avail = false;
		ObjectiveShow ( ch_title );
		ct_assault_current_objective = ch_title;
		sleep_s(8);
		b_assault_objective_avail = true;		
end

function f_assault_complete_objective( )


		b_assault_objective_avail = false;
		cinematic_clear_title( ct_assault_current_objective );
 		ObjectiveShow ( TITLES.ct_obj_complete);
		sleep_s(4);
		b_assault_objective_avail = true;

end

function f_assault_place_dead_bodies(t:table):boolean


	if t == nil then
		print("ERROR:f_assault_place_dead_bodies passed empty table");
		return false;
		
	end
	
	for i, ped in ipairs( t ) do
		--print("create " .. ped );
		object_create( ped ) ;
	end
	
	Sleep(5);
	
	for i, ped in ipairs( t ) do 
		--print("wake up " .. ped );
		if OBJECTS[ped] then
			object_wake_physics( OBJECTS[ped] ) ;
		end
	end

	return true;
end

function f_dead_body_cleanup(t:table):boolean
	
	if t == nil then
		print("ERROR:f_assault_place_dead_bodies passed empty table");
		return false;
		
	end
	
	for i, ped in ipairs( t ) do
		--print("create " .. ped );
		object_destroy( OBJECTS[ped] ) ;
	end
	return true;
end

function f_ass_objective_pulse( sn_objective:object, n_time:number ):void
	local n_time_pulse:number = n_time or 5;
	
	navpoint_track_object( sn_objective, true );
	sleep_s( n_time_pulse );
	navpoint_track_object( sn_objective, false );
end


function f_ass_track_blip_per_player( tv:volume,  blip:flag ):void
		for _, this_player in ipairs ( players())  do
			CreateThread( sys__ass_track_blip_per_player, tv, this_player, blip );
		end
end

function sys__ass_track_blip_per_player( tv:volume, sparta:object, blip:flag ):void
		navpoint_track_flag_for_player(  sparta,blip, true );
	SleepUntil ([| volume_test_object ( tv, sparta )  ], 1);
		navpoint_track_flag_for_player(   sparta,blip, false );
end

function f_set_gravity_exterior()

	--for i, spartan in ipairs() do
	print("xxxx", PLAYERS.player0);
	
		object_set_gravity( PLAYERS.player0,.3, true );
		object_set_gravity( PLAYERS.player1, .3, true );
		object_set_gravity( PLAYERS.player2, .3, true );
		object_set_gravity( PLAYERS.player3, .3, true );
	--nd
end

function f_reset_gravity()

end



function AssaultStationTrackBreadCrumbs(mission:table)

	--Make sure we have players available
	--print("a");
	SleepUntil([| player_get_first_alive()], 3);

		local index:number = 1;
	--print("b");

	SleepUntil( [| g_b_assault_mission_complete ] , 1 );
		EndMission(mission);
end



function f_assault_wait_for_coop_buddy( tv:volume ):boolean
		local obj_list = {};
		local b_block_for_buddy_complete = false;

		if not game_is_cooperative() then
			return true;
		end

		obj_list = volume_return_players( tv );
		
		--print("number of real players in volume" , #obj_list );
		if ( game_is_cooperative() and #obj_list > 1 )   then
			-- continue
			b_block_for_buddy_complete = true;
		end

		return b_block_for_buddy_complete;
end

function f_assault_coop_buddy_test()
	f_assault_wait_for_coop_buddy( VOLUMES.tv_main_elevator );
end

function f_player_temp_text( tv:volume, text:string ):void

	SleepUntil( [| volume_test_players(tv) ],1 );
		clear_all_text();
		set_text_defaults();
		set_text_color(1, 1, 1, 1);
		set_text_lifespan(150);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.center);
		set_text_scale(1);
		set_text_margins(0, 0.12, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);	
		 
		 show_text ( text );
end

function f_player_area_text(  text:string ):void

	
		clear_all_text();
		set_text_defaults();
		set_text_color(1, 1, 1, 1);
		set_text_lifespan(150);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.center);
		set_text_scale(1);
		set_text_margins(0, 0.12, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);	
		 
		 show_text ( text );
end








function f_setup_elevatora():boolean

	--object_move_to_flag( OBJECTS.intro_elevator,15, FLAGS.fl_elevator_stop  )
		device_set_position_immediate( OBJECTS.dm_intro_elevator ,0.88);	
	return true;
end



function run_phanton()
	--ai_place_in_limbo(AI.phantomx);
end






function assault_game_save_no_timeout()

	game_save_cancel();
	Sleep(2);
	game_save_no_timeout();
	Sleep(2);
	
	

end

function f_assault_update_weapon_profile_post_start()
	player_set_profile(STARTING_PROFILES.default, SPARTANS.chief);
	player_set_profile(STARTING_PROFILES.respawn_linda, SPARTANS.linda);
	player_set_profile(STARTING_PROFILES.respawn_fred, SPARTANS.fred);
	player_set_profile(STARTING_PROFILES.respawn_kelly, SPARTANS.kelly);


	print("updating profile");
	
	-- nothing but bugs with these functions
	--unit_add_equipment (SPARTANS.chief, STARTING_PROFILES.default, true, false);
	--unit_add_equipment (SPARTANS.linda, STARTING_PROFILES.respawn_linda, true, false);
	--unit_add_equipment (SPARTANS.fred, STARTING_PROFILES.respawn_fred, true, false);
	--unit_add_equipment (SPARTANS.kelly, STARTING_PROFILES.respawn_kelly, true, false);



end

function f_assault_balance_fixer()

	SleepUntil([| b_tun_assault_range ] , 1 );
		--
		
		if not IsPlayer(SPARTANS.linda) then
			--print("fix");
			object_create_anew("w_tun_l_packer");
			Sleep(1);
			--unit_add_weapon( SPARTANS.linda, OBJECTS.w_tun_l_packer, 2 );
		end
		
		repeat
			SleepUntil([| object_get_health( SPARTANS.linda ) <= 0 ] , 5 );
				--print("Dead");
				sleep_s(1);
			SleepUntil([| object_get_health( SPARTANS.linda ) > 0 ] , 5 );
				if not IsPlayer(SPARTANS.linda) then
				--print("alive");
				object_create_anew("w_tun_l_packer");
				Sleep(1);
					unit_add_weapon( SPARTANS.linda, OBJECTS.w_tun_l_packer, 2 );
				end
			Sleep(10);
		until false;
		
end

function f_activator_get( trigger:object, activator:object ) 



--	g_ics_player = activator;
end





----------------------------
--
--------------------------
-- TUTORIAL SCRIPTS ---
--
-------------------------
--
---------------------


function f_tut_test_a()
	TutorialShow(PLAYERS.player0, "training_charge"  );
end


function f_assault_volume_tutorial_blocking_setup( tv:volume, id:string, blocking_id:string, b_repeating:boolean )

		for _,spartan in ipairs ( players() ) do
			CreateThread( f_assault_volume_tutorial_blocking_wait, unit_get_player( spartan ) , tv, id, blocking_id ,b_repeating );
			sleep_s (0.1);
		end
		
		--CreateThread( f_assault_volume_tutotrial_wait, PLAYERS.local0 , tv, id, b_repeating );
	--
end

function f_assault_volume_tutorial_blocking_wait( pl:player, tv:volume, id:string, blocking_id:string, b_repeating:boolean )
	print("setup tut");
	
	repeat
		SleepUntil( [| volume_test_objects( tv, pl ) ] , 1 );
			--print("tut show " , id, pl );
			--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
			TutorialShowStartDelayed( pl, id, blocking_id );
		SleepUntil( [| not volume_test_objects( tv, pl ) ] , 1 );	
			print("clear tut " , id );	
			TutorialStopAndMark(pl, blocking_id );
			sleep_s(1);
	until b_repeating == false;

end

function f_assault_volume_tutorial_setup( tv:volume, id:string, mechanic_id:tutorial , b_repeating:boolean )

		for _,spartan in ipairs ( players() ) do
			CreateThread( f_assault_volume_tutorial_wait, unit_get_player( spartan ) , tv, id,mechanic_id, b_repeating );
			sleep_s (0.1);
		end
		
		--CreateThread( f_assault_volume_tutotrial_wait, PLAYERS.local0 , tv, id, b_repeating );
	--
end

function f_assault_volume_tutorial_wait( pl:player, tv:volume, id:string, mechanic_id:tutorial, b_repeating:boolean )
	print("setup tut");
	
	repeat
		SleepUntil( [| volume_test_objects( tv, pl ) ] , 1 );
			print("tut show " , id, pl );
			--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
			--TutorialShow(pl, id );
			TutorialShowIfNotPerformed(unit_get_player(pl), id, mechanic_id, 5);
		SleepUntil( [| not volume_test_objects( tv, pl ) ] , 1 );	
			print("clear tut " , id );	
			TutorialStop(pl  );
			sleep_s(5);
	until b_repeating == false;

end


function f_assault_volume_dislay_tutorial_setup( tv:volume, id:string, mechanic_id,  n_time:number )
		local time = n_time or 5;
		for _,pl in ipairs ( players() ) do
			CreateThread( f_assault_volume_display_tutorial_wait, unit_get_player(pl) , tv, id, mechanic_id, time );
			sleep_s (0.1);
		end

	
end

function f_assault_volume_display_tutorial_wait( pl:player, tv:volume, train_mechanic:string, mechanic_id:tutorial, n_time:number )

	--SleepUntil( [| volume_test_objects( tv, pl ) ] , 1 );
		--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
		--TutorialShowAllIfNotPerformed( pl, id,  )
		--TutorialShow(pl, id, n_time );
	--	sleep_s( n_time );
		--TutorialStop(pl );
		--TutorialStopAll();
	local time = n_time or 5;

	SleepUntil([| volume_test_objects(tv, pl)], 1);
	 TutorialShowIfNotPerformed(unit_get_player(pl), train_mechanic, mechanic_id, time);		
	sleep_s(time);
	 TutorialStop(pl);
				
end







function f_assault_popup_dislay_tutorial_setup( id:string, n_time:number )
		local time = n_time or 5;
		--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
		TutorialShowAll (id, time);
		
--		for _,pl in ipairs ( players() ) do
--			CreateThread( f_assault_popup_display_tutorial_wait, unit_get_player( pl ) , id, n_time );
--			sleep_s (0.1);
--		end
	
end

function f_assault_tutorial_mechanic_all( id:string, n_time:number )
		local time = n_time or 5;
		--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
		TutorialShowAll (id, n_time);
		
end

function f_assault_tutorial_blocking_all( id:string, n_time:number )
		local time = n_time or 5;
		--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);
		--TutorialShowAll (id, n_time);
		--TutorialShowStartDelayed
end




function f_assault_popup_display_tutorial_wait( pl:player, id:string, mechanic_id:tutorial, n_time:number )
		--SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_textpopup.sound'), nil, 1);

		--gmu OSR-148903 -- switching these tutorials to be only play if not seen (register with the profile)
		TutorialShowIfNotPerformed (pl, id, mechanic_id, n_time)
end


function f_ai_active_camo_manager( ai_actor:ai ):void
 local l_timer:number = 0;
 local obj_actor:object  = ai_get_object( ai_actor );
--	--print( "cs_active_camo_use: ENABLED" );
--
	repeat
--	
--		-- activate camo
		if ( unit_get_health(ai_actor) > 0.0 ) then
			ai_set_active_camo( ai_actor, true );
			--print( "f_active_camo_manager: ACTIVE" ); 
		end
--		
--		-- disable camo
		SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or   objects_distance_to_object(players(),obj_actor) <= 5.5  or ((object_get_recent_body_damage(obj_actor) + object_get_recent_shield_damage(obj_actor)) > 0.2) ], 3 );
		if ( unit_get_health(ai_actor) > 0.0 ) then
			ai_set_active_camo( ai_actor, false );
			--print( "f_active_camo_manager: DISABLED" ); 
		end
		
		-- manage resetting
		if ( unit_get_health(ai_actor) > 0.0 ) then
			l_timer = timer_stamp( 2.5, 5.0 ); -- unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\storm_energy_sword\storm_energy_sword.weapon') )
			SleepUntil( [| (unit_get_health(ai_actor) <= 0.0) or (timer_expired(l_timer) and ( objects_distance_to_object( players(),obj_actor) >= 4.0 ) and ( not objects_can_see_object( players(),obj_actor,25.0 ))) ], 1 );
			
			
			if not unit_has_weapon_readied(ai_actor, TAG('objects\weapons\melee\energy_sword\energy_sword.weapon') ) then
				--print("ai switching back to sword");
				ai_swap_weapons( ai_current_actor);
			end
		
		end
		if ( unit_get_health(ai_actor) > 0.0 ) then
			--print( "f_active_camo_manager: RESET" ); 
			Sleep(1);
		end
		Sleep(1);
	until ( unit_get_health(ai_actor) <= 0.0 );
end


function f_assault_orders_watcher_setup()
	local orderedUnit:object = nil;
	RegisterMusketeerOrderEvent(f_assault_orders_watcher_callback, orderedUnit);

end

global n_ass_orders_given_count:number = 0;

function f_assault_orders_watcher_callback(orderedUnit:object)
	n_ass_orders_given_count = n_ass_orders_given_count + 1;
	print(orderedUnit);
	CreateThread(f_assault_orders_watcher_timeout);
end

global b_orders_watcher_active:boolean = false;

function f_assault_orders_watcher_timeout()
	local l_timer:number = 0;
	local this_orders_count:number = n_ass_orders_given_count;
	
	b_orders_watcher_active = true;
	print("b_orders_watcher_active ", b_orders_watcher_active );
	sleep_s( 15 );
	if n_ass_orders_given_count ==  this_orders_count then
		b_orders_watcher_active = false;
		print("b_orders_watcher_active ", b_orders_watcher_active );
	end	
	--print("-------" );
end

function f_blink_clear_blips()

	local t_objs = 
	{
		"sn_obj_reactor_console",
		"sn_obj_reactor_core",
		"sn_obj_hunter_hole",
		"sn_obj_hunter_exit_button",
		"sn_obj_hunter_elevator",
		"sn_obj_hunter_door",
		"sn_obj_hangar_generator",
		"sn_obj_hangar_escape",
		"sn_obj_flight_exit",
		"sn_obj_vent_1",
		"sn_obj_vent_2",
		"sn_obj_tech_elevator",
		"sn_obj_tech_holo",
		"sn_obj_shipyard_start",
		"sn_obj_shipyard_mid",
		"sn_obj_hangar_dropdown",
		"sn_obj_shipyard_end",
		"sn_obj_shipyard_fake",
		"sn_tunnels_mark_path_window",
		"sn_tunnels_mark_path_01",
		"sn_obj_hangar_big_door",
		"sn_obj_hangar_window",
		"sn_obj_intro_balcony",
		"sn_obj_intro_room",
		
	}
	
	for i, obj in ipairs ( t_objs  ) do
		if object_valid( obj ) then
			object_destroy( ObjectFromName( obj ) ); 
		end
	end

end

function TurnOnAllSpartanFlashlights():void
	TurnOnAllFlashlightsInObjectList(players());
	TurnOnAllFlashlightsInObjectList(ai_actors(GetMusketeerSquad()));
	
	-- Have any players that spawn in turn on their flashlights as well.
	RegisterPlayerSpawnEvent(TurnOnSpartanFlashlight);
end

function TurnOffAllSpartanFlashlights():void
	TurnOffAllFlashlightsInObjectList(players());
	TurnOffAllFlashlightsInObjectList(ai_actors(GetMusketeerSquad()));
	
	UnregisterPlayerSpawnEvent(TurnOnSpartanFlashlight);
end


function TurnOnAllFlashlightsInObjectList( objects:object_list ):void
	local objects_count:number = list_count(objects);
	
	for i = 1, objects_count do
		TurnOnSpartanFlashlight( list_get(objects, i - 1) );
	end
end

function TurnOffAllFlashlightsInObjectList( objects:object_list ):void
	local objects_count:number = list_count(objects);
	
	for i = 1, objects_count do
		CreateThread( TurnOffSpartanFlashlight,list_get(objects, i - 1) );
	end
end

global b_flashlight_on:boolean = false;
global b_flashlight_off:boolean = false;

function TurnOnSpartanFlashlight( spartan:object ):void
	 --effect_new_on_object_marker_loop(TAG('objects\characters\storm_masterchief\fx\shoulder_light\shoulder_light.effect'), spartan, "fx_shield_core");
	effect_new_on_object_marker_loop(TAG('objects\characters\storm_masterchief\fx\shoulder_light\shoulder_light.effect'), spartan, "flashlight");
	--effect_new_on_object_marker_loop(TAG('fx\library\light\flash_light\flash_light.effect'), spartan, "flashlight");
	if not b_flashlight_on then
		SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_flashlight\004_dm_flashlight_turnon_player.sound'), nil, 1);
		b_flashlight_on = true;
	end
end

function TurnOffSpartanFlashlight( spartan:object ):void
	print("off flashlight for ", spartan );
	 Sleep(3);
	 effect_stop_object_marker(TAG('objects\characters\storm_masterchief\fx\shoulder_light\shoulder_light.effect'), spartan, "flashlight");
	 Sleep(5);
	 effect_stop_object_marker(TAG('objects\characters\storm_masterchief\fx\shoulder_light\shoulder_light.effect'), spartan, "flashlight");
	 
	 --e:\corinth\osiris\main\tags\sound\004_device_machine\004_dm\004_dm_flashlight\004_dm_flashlight_turnoff.sound
	-- effect_stop_object_marker(TAG('fx\library\light\flash_light\flash_light.effect'), spartan, "flashlight")
end

function f_setup_headlamp_area( tv:volume, f_get_bool:ifunction  ):void

	--local objects_count:number = list_count(players());

	for i = 1, 4 do
		
		--print("thread started on ", spartans()[i] );
		CreateThread( sys_headlamp_area_watcher,  i, tv, f_get_bool ); 
	end

end

function sys_headlamp_area_watcher( spartan_index:number, tv:volume , f_get_bool:ifunction  ):void
	

	--print("Test");
	repeat
		Sleep(10);

		SleepUntil( [| ( volume_test_object( tv, SPARTANS[spartan_index] ) and object_get_health( SPARTANS[spartan_index] ) > 0 ) or f_get_bool() ], 3 );
			if not f_get_bool() then
				print("on headlamp ", SPARTANS[spartan_index]);
				CreateThread(TurnOnSpartanFlashlight, SPARTANS[spartan_index] );
			end
			print("Test ", SPARTANS[spartan_index], " waiting to leave  area");
		SleepUntil( [| not volume_test_object( tv, SPARTANS[spartan_index] ) or object_get_health(SPARTANS[spartan_index] ) <= 0 or f_get_bool()], 3 );
			print("off headlamp " , SPARTANS[spartan_index] , spartan_index);
			CreateThread( TurnOffSpartanFlashlight ,SPARTANS[spartan_index] );
			
	until f_get_bool();

	TurnOffAllSpartanFlashlights();
	print("EXIT ", SPARTANS[spartan_index]);
end

function f_assault_set_musketeer_goal( flag:flag , radius:number )

		local radius = radius or 3;
		for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				MusketeerDestSetPoint(obj, flag, radius);
		end

end






global n_assault_elite_assassination_count:number = 0;
--global assassinationStringID = get_string_id_from_string("Silent Melee");
--global melee_assassinationStringID = get_string_id_from_string("Fancy Assassination");

function AssaultAnyDeath( deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64  )
	local b_found_elite:boolean = false;
    --print("Something died");
 
 local elite_check:object_list = deadObject;
 local elite_list:object_list =	metalabel_filter_objectlist( "elite", deadObject );

	if elite_list then
		for i, elite in ipairs ( elite_list ) do
			--print( elite_list );
			b_found_elite = true;
			--print("hi elite!", elite );
		end
	end
	--print(damageType);
	-- print("Damage Modifier ", damageModifier);
    if b_found_elite and ( damageModifier == 6 ) then  -- silent melee kill is '3' but leaving out for now because full assassaintion is better! damageModifier == 3 
      print("ASSASSINATED!!!")
     	 n_assault_elite_assassination_count = n_assault_elite_assassination_count + 1;     	
    end

end

function f_check_for_elite_cheevo()

	repeat 
		SleepUntil( [| n_assault_elite_assassination_count  > 0 ], 1 );
			sleep_s(2);
	
		if n_assault_elite_assassination_count >= 2 then
			print( "COOP ACHIEVEMENT UNLOCKED!!!!" );
			CampaignScriptedAchievementUnlocked( 4 ) ;
		end
			n_assault_elite_assassination_count = 0;
	until false;

end

--## CLIENT

function remoteClient.f_assault_cl_hunter_camera_shake():void
	--( attack:number, intensity:number, duration:number, decay:number, shake_sound:tag 
	CreateThread( camera_shake_all_coop_players, 3, 2
	, 1, 1) ;
end