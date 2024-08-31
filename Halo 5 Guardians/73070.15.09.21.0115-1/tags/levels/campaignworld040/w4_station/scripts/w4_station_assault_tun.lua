--## SERVER

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- Maintenance Tunnels
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
--navpoint_track_object_for_player( player, object, boolean ) 


global t_tunnel_data:table =
{
	{ flag_name = "fl_tun_1_telport", p_player_assigned = -1,},
	{ flag_name = "fl_tun_2_telport", p_player_assigned = -1,},
	{ flag_name = "fl_tun_3_telport", p_player_assigned = -1,},
	{ flag_name = "fl_tun_4_telport", p_player_assigned = -1,},
};

global w4_p1_fall_show:number = nil;
global w4_p2_fall_show:number = nil; 
global w4_p3_fall_show:number = nil; 
global w4_p4_fall_show:number = nil;  
global b_tun_1_slide_grunt = false;
global b_tun_hunter_w_1 = false;
global b_tun_hunter_w_2 = false;
global b_tun_hunter_w_3 = false;
global b_tun_1_hunter_1_show:number = nil;
global b_tun_1_hunter_2_show:number = nil;
global b_tun_1_cov_ship_show:number = nil; 
global b_temp_tun_players_invul = true;

global b_tunnels_intro_hunter_event:boolean = false;
global b_tunnels_begin:boolean = false;
global b_tunnels_hunter_glass_event:boolean = false;
global b_tunnels_armada_event:boolean = false;
global b_tunnels_end:boolean = false;
global b_skip_tun_cin:boolean = false;
global b_tun_cin_done:boolean = false;
global b_tun_assault_range:boolean = false;
global b_begin_040_cin:boolean = false;
global g_thread_tunnels_nar:thread = nil;
global n_tun_falling:number = -1;
global b_lamp_areas_complete = false; 
global b_tun_meridian_chat_done:boolean = false; 

AssaultOnTheStation.goal_tunnels = 

{
	gotoVolume = VOLUMES.tv_tunnel_fall_in,
	zoneSet = ZONE_SETS.zs_02_b,
	next={"goal_tunnels_landed"},

}

AssaultOnTheStation.goal_tunnels_landed = 

{
	gotoVolume = VOLUMES.tv_hunter_init,
	zoneSet = ZONE_SETS.zs_03,
	next={"goal_hunter"},

}



function blink_tunnels():void
	--switch_zone_set(ZONE_SETS.zs_02);
	CreateThread(audio_assault_stopallmusic);
	ai_erase_all();
	garbage_collect_now();
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_tunnels", FLAGS.fl_blink_tun_1);
	f_blink_clear_blips();

end

function blink_tunnels_landed():void
	--switch_zone_set(ZONE_SETS.zs_02);
	CreateThread(audio_assault_stopallmusic);
	ai_erase_all();
	garbage_collect_now();
	NarrativeQueue.Kill();
	GoalBlink(AssaultOnTheStation, "goal_tunnels_landed", FLAGS.fl_tun_start_in);
	f_blink_clear_blips();
	b_skip_tun_cin = true;
	b_tun_cin_done = true;
end

function AssaultOnTheStation.goal_tunnels.Start()
		f_tunnels_bridge_init();
end






function f_tunnels_bridge_init()
		--print("goooooooo");
		b_shipyard_end = true;
		print("bridge init");
		zone_set_trigger_volume_enable( "begin_zone_set:zs_03", false );
		CreateThread( f_tun_split_up_wait );
		g_thread_tunnels_nar =	CreateThread(nar_goal_assault_tunnels); 
		
		
		object_destroy(OBJECTS.sn_obj_shipyard_end);
		Sleep(5);
		object_create("sn_obj_shipyard_fake");
		composer_play_show("vin_hunter_bridge_destroy");
		CreateThread(audio_hunter_foreshadow);
		Sleep(15);
		ai_cannot_die( AI.AISquad_hunter_bridge, true );
end




function f_tun_split_up_wait():void
	Sleep(1);

	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_split) ] , 1 );

		
		TutorialStopAll();
		Sleep(1);
		CreateThread(f_hunter_spawn_break);
		CreateThread( f_tun_teleport_everyone );
		CreateThread( f_fun_zone_switch_failsafe );
		--create tunnels dynamics

		
		CreateThread( f_tun_fall_invul );	
		CreateThread( f_tun_fall_vision );


end


function f_tun_fall_invul()

		for _,spartan in ipairs (spartans()) do
			CreateThread(f_tun_temp_invul, spartan);
		end

end


function f_hunter_spawn_break():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_1_hunter_spawn) ] , 1 );
		CreateThread(audio_hunter_foreshadow_stop);
		CreateThread( f_tunnels_hunter_stumble_player_logic );
		CreateThread( f_tun_break_failsafe );
		CreateThread( f_tunnels_hunter_fall_player_logic );
		CreateThread(audio_assault_stopallmusic);
		b_tunnels_intro_hunter_event = true;

		TutorialStopAll();

		CreateThread(nar_ass_bridge_hunters);	
		n_tun_falling = composer_play_show("vin_player_ics_falling");  ---oops loops foreever
		SoundImpulseStartServerVolume (VOLUMES.tv_audio_shipyard_end_door, TAG('sound\120_music_campaign\assault\120_mus_assault_hunter_stinger.music_control'));
	

end

function f_fun_zone_switch_failsafe()
	SleepUntil( [| volume_test_players( VOLUMES.tv_force_zone_set_zs_02_b  ) ] ,1 );	
		if current_zone_set_fully_active() ~= ZONE_SETS.zs_02_b then
			print("force switching to zone set zs_02_b");
			switch_zone_set( ZONE_SETS.zs_02_b );
		end
end



function f_tun_fall_vision()
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_1_fall_vision_begin  ) ] ,1 );		
		print("vision fx");
	---	RunClientScript("fx_tun_vision");  --removed by request of bug OSR-90865
		sleep_s( 0.75 );
		TutorialStopAll();
		Sleep(2);
		fade_out(1, 1, 1, 1);
		sleep_s(0.5);
		b_begin_040_cin = true;
		if not b_skip_tun_cin then
			print("cin 40 start");	
			SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_fall_in  ) ] ,1 );	
				f_tun_cin_040();

		end
		Sleep(1);

		f_tun_teleport_everyone_post_cin();
end

function f_tun_teleport_everyone()

	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_1_fall_teleport_all or b_begin_040_cin ) ] ,1 );
	

		--fade_out(0, 0, 0, 0);
		Sleep(2);
		if n_tun_falling ~= -1 then
			composer_stop_show( n_tun_falling );
		end
		print("safety net");
		--TeleportNoFX();
		object_teleport (SPARTANS.chief, FLAGS.fl_tun_teleport_player_1);
		object_teleport (SPARTANS.fred, FLAGS.fl_tun_teleport_player_2);
		object_teleport (SPARTANS.kelly, FLAGS.fl_tun_teleport_player_3);
		object_teleport (SPARTANS.linda, FLAGS.fl_tun_teleport_player_4);
		
end

function f_tun_teleport_everyone_post_cin()

	SleepUntil( [| b_tun_cin_done ] ,1 );
		
		print("another safety net");
		--gmu 8/14/2015 for bug OSR-149489
		TeleportNoFX();
		object_teleport (SPARTANS.chief, FLAGS.fl_tun_teleport_player_1);
		object_teleport (SPARTANS.fred, FLAGS.fl_tun_teleport_player_2);
		object_teleport (SPARTANS.kelly, FLAGS.fl_tun_teleport_player_3);
		object_teleport (SPARTANS.linda, FLAGS.fl_tun_teleport_player_4);

end


function f_tun_temp_invul(spartan:object):void
--print(spartan , "ready for invul");
	SleepUntil( [| volume_test_objects( VOLUMES.tv_tunnels_invul , spartan ) ] , 1);
		unit_falling_damage_disable(spartan, true);
		--object_cannot_take_damage(spartan);
		--print("think about it");
	SleepUntil ([| b_temp_tun_players_invul == false ],1);
		--object_can_take_damage(spartan);	
			--print("shiiiiit"); 
			unit_falling_damage_disable(spartan, false);
end

function f_tun_break_failsafe()
	--SleepUntil( [| volume_test_players( VOLUMES.tv_tunnels_fall_failsafe  ) ] , 1);

	repeat
	  if (volume_test_object (VOLUMES.tv_tunnels_fall_failsafe, SPARTANS.chief) == true)               then
	  	--print ("Chief Stumble");

	    object_teleport( SPARTANS.chief, FLAGS.fl_tun_fall_failsafe );
	  end            
		Sleep(1);
		if (volume_test_object (VOLUMES.tv_tunnels_fall_failsafe, SPARTANS.linda) == true)               then
	  	--print ("Chief Stumble");
	     object_teleport( SPARTANS.linda, FLAGS.fl_tun_fall_failsafe );
	  end   
	  
	  Sleep(1);
	  if (volume_test_object (VOLUMES.tv_tunnels_fall_failsafe, SPARTANS.fred) == true)               then
	  	--print ("Chief Stumble");
	    object_teleport( SPARTANS.fred, FLAGS.fl_tun_fall_failsafe );
	  end   
	  
	  Sleep(1);
	  if (volume_test_object (VOLUMES.tv_tunnels_fall_failsafe, SPARTANS.kelly) == true)               then
	  	 object_teleport( SPARTANS.kelly, FLAGS.fl_tun_fall_failsafe );
		end
	until b_tun_cin_done;
end

--for _,spartan in ipairs (spartans()) do
--	CreateThread (f_tun_teleport_players, spartan);
--end
--
--function f_tun_teleport_players (dude:object)
--	SleepUntil ([| volume_test_objects (VOLUMES.tv_tun_1_fall_teleport, dude)], 1);
--		if IsPlayer (dude) then
--   	end             
--end

-- vingette bools
global b_tun_chief_fall:boolean = false;
global b_tun_chief_stumble:boolean = false;
global b_tun_kelly_fall:boolean = false;
global b_tun_kelly_stumble:boolean = false;
global b_tun_fred_fall:boolean = false;
global b_tun_fred_stumble:boolean = false;
global b_tun_linda_fall:boolean = false;
global b_tun_linda_stumble:boolean = false;
global b_crate_hits:boolean = false;    
global b_bridge_falls:boolean = false;


function f_tunnels_hunter_stumble_player_logic()
  local vol_stumble:volume = VOLUMES.tv_tun_player_stumble;

--	SleepUntil ([|    volume_test_players (vol1)], 1);
	 repeat
	 	Sleep(2);
	  if (volume_test_object (vol_stumble, SPARTANS.chief) == true)               then
	  	--print ("Chief Stumble");
	    b_tun_chief_stumble = true;
	  end            
		Sleep(1);
		if (volume_test_object (vol_stumble, SPARTANS.linda) == true)               then
	  	--print ("Chief Stumble");
	    b_tun_linda_stumble = true;
	  end   
	  Sleep(1);
	  
	  if (volume_test_object (vol_stumble, SPARTANS.fred) == true)               then
	  	--print ("Chief Stumble");
	    b_tun_fred_stumble = true;
	  end   
	  
	  Sleep(1);
	  if (volume_test_object (vol_stumble, SPARTANS.kelly) == true)               then
	  	--print ("Chief Stumble");
	    b_tun_kelly_stumble = true;
	  end   	
	  Sleep(1);
	until b_tun_cin_done;

end

function f_tunnels_hunter_fall_player_logic()

  local vol_fall:volume = VOLUMES.tv_tun_player_fall;
--	SleepUntil ([|    volume_test_players (vol1)], 1);

	  repeat
	    Sleep(2);	            
		  if (volume_test_object (vol_fall, SPARTANS.chief) == true)      then
		  	--print ("chief will fall");
		  	b_tun_chief_fall = true;
	  	end
	  	
	  	Sleep(1);
		  if (volume_test_object (vol_fall, SPARTANS.linda) == true)      then
		  	--print ("chief will fall");
		  	b_tun_linda_fall = true;
	  	end
	  	Sleep(1);
		  if (volume_test_object (vol_fall, SPARTANS.fred) == true)      then
		  	--print ("chief will fall");
		  	b_tun_fred_fall = true;
	  	end
	  	Sleep(1);
		  if (volume_test_object (vol_fall, SPARTANS.kelly) == true)      then
		  	--print ("chief will fall");
		  	b_tun_kelly_fall = true;
	  	end
	  		Sleep(1);  		  	
	until b_tun_cin_done;
end



-----------------------------------------------------------------------
--
--	ON GROUND START
--
--------------------------------------------------------------

function AssaultOnTheStation.goal_tunnels_landed.Start()

		f_tunnels_init();

end

function f_tunnels_init()
		b_shipyard_end = true;
		CreateThread(f_tunnel_start);

		if not g_thread_tunnels_nar then
			print("starting up tunnels narrative because thread isn't active")
			CreateThread(nar_goal_assault_tunnels); 
		end
		

	object_destroy(OBJECTS.sn_obj_shipyard_fake);
	object_destroy(OBJECTS.sn_obj_shipyard_end);

	CreateThread(audio_hunter_firstquake);
	CreateThread(audio_hunter_quake_exit);
	CreateThread(audio_hunter_callout);
end


function f_tunnel_start():void

	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_fall_in ) and b_tun_cin_done] , 1 );
		--RunClientScript("fx_tun_vision");
		
		ai_erase( AI.sg_yard_all );
		f_assault_update_weapon_profile_post_start();
		sleep_s(2);
		
		if editor_mode() then -- i need this in fabers
			fade_in(0, 0, 0, 60);
		end
		game_save_no_timeout();
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel_stream\018_vin_campaign_w4assault_huntertunnel_firstroar.sound'), nil, 1);
		b_tun_assault_range = true;
		b_tunnels_begin = true;
		--sleep_s(3.0);
		--f_unblip_flag( FLAGS.fl_tun_fake_tunnel_blip );	 
		object_destroy( OBJECTS.sn_obj_shipyard_fake);
		f_volume_teleport_all_not_inside( VOLUMES.tv_tunnel_fall_teleport_forward, FLAGS.fl_tun_start_in );
		
		b_meridian_temp_cin_complete = true;

		sleep_s(2);
		
			zone_set_trigger_volume_enable( "begin_zone_set:zs_03", true );
		sleep_s(1);
		CreateThread( nar_lights_on );
		b_temp_tun_players_invul = false;
		game_save_no_timeout();
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_start ) ] , 1 );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel_stream\018_vin_campaign_w4assault_huntertunnel_secondroar.sound'), nil, 1);
		game_save_no_timeout();
		Sleep(5);
	
	
		Sleep(30);
		CreateThread( f_chapter_title, TITLES.ch_assault_3);
		



		CreateThread(f_tunnel_armada_room);	
		CreateThread(f_tun_hunter_smash_window_1);
		--CreateThread( f_tun_hunter_smash_window_egg );
		CreateThread(f_tun_armada_door);

		CreateThread(f_tun_new_suic_grunt_01);
		CreateThread(f_tun_new_suic_grunt_02);
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed,f_tunnel_steam_room_04_03);
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed,f_tunnel_steam_room_04_01);
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tunnel_steam_room_04_02 );
		CreateThread( f_tun_end_room_spawner );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_lemmy_spawner );
		if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
			GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_front_assassinate_tut );
		end
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tunnel_front_room_vent_roar );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tunnel_rear_room_zealot_roar );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_musketeer_goal_room_1 );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_musketeer_goal_wait_room_1 );		
		CreateThread( f_tun_musketeer_clear_room_1 );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_musketeer_goal_room_2 );
		GoalCreateThread(AssaultOnTheStation.goal_tunnels_landed, f_tun_musketeer_goal_wait_room_2 );		
		CreateThread( f_tun_musketeer_clear_room_2 );		
		--
		--
		CreateThread( f_tun_front_room_spawner );


		if game_difficulty_get_real() ~= DIFFICULTY.legendary  then
			GoalCreateThread( AssaultOnTheStation.goal_tunnels_landed, f_assault_volume_tutorial_setup,  VOLUMES.tv_tun_crouch_tut_01,"training_crouch",TUTORIAL.Crouch,  false  );	
		end
		if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
			GoalCreateThread( AssaultOnTheStation.goal_tunnels_landed, f_assault_volume_dislay_tutorial_setup,  VOLUMES.tv_tun_crouch_tut_02,"training_crouch",  TUTORIAL.Crouch, 5  );
		end

		SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs_03 ], 1);
			Sleep(1);
			game_save_no_timeout();
			Sleep(1);
			ai_place( AI.sq_tun_new_grunt_patrol);
			sleep_s(6);
			CreateThread( f_tunnel_lamp_flicker_all );  -- backup, should be called from narrative script
	
end






function f_tun_new_suic_grunt_01():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_new_grunt_suic_01 ) ] , 1 );
		if b_tun_meridian_chat_done then
			ai_place(AI.sq_tun_new_grunt_suic_01);
			Sleep(3);
			ai_grunt_kamikaze( AI.sq_tun_new_grunt_suic_01 );
		end
end

function f_tun_new_suic_grunt_02():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_new_grunt_suic_02 ) ] , 1 );
		ai_place(AI.sq_tun_new_grunt_suic_02);
		ai_grunt_kamikaze( AI.sq_tun_new_grunt_suic_02 );
		CreateThread( f_tun_post_kamikaze_taunt);
		CreateThread( f_tun_new_suic_grunt_03 );
		ai_place( AI.sq_tun_new_jackal_hallway );
end

function f_tun_new_suic_grunt_03():void

SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_last_death ) ] , 1 );
		ai_place(AI.sq_tun_new_grunt_suic_03);
		ai_grunt_kamikaze( AI.sq_tun_new_grunt_suic_03 );

end

function f_tun_post_kamikaze_taunt()

	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_grunt_giggle ) ] , 1 );
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_callout.sound'), OBJECTS.giggle_grunts_vo, 1);
	sleep_s(2.5);
	--CreateThread( f_player_area_text , "<Grunts giggling, laughing>");
	--cinematic_set_title (TITLES.ch_assault_tun_grunt_laugh);
	CreateThread(nar_ass_grunts_mocking);

end


function f_tunnel_lamp_areas_complete():boolean
	--print("returning" , b_test_lamp );
	return b_lamp_areas_complete;
end

function f_tunnels_mark_path_ahead():void
	object_create("sn_tunnels_mark_path_01");
end



function cs_tun_suicide():boolean
	ai_grunt_kamikaze( ai_current_actor );
	--print("---",ai_current_actor);
	return true;
end

function cs_tun_lemmy():boolean
	ai_grunt_kamikaze( AI.sq_tun_end_lemmy );
	--print("lemmy!!!");
	return true;
end

function grunt_suicide():void
	--ai_grunt_kamikaze( AI.sq_tun_grunt_1 );
	--print("---",ai_current_actor);
	--return true;
end


function f_tun_objective()
	--f_assault_complete_objective();
	f_assault_set_objective( TITLES.ct_obj_assault_5, true );
end


function f_tun_front_assassinate_tut()
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_front_assass_tut ) ] , 1 );
		sleep_s(1);
		if ai_combat_status( AI.sg_tunnels_front_all ) < 1 then
				--TutorialShowAll( "training_rearmelee" );
				TutorialShowAllIfNotPerformed ("training_rearmelee", TUTORIAL.Assassination, 10);
				local l_timer:number = timer_stamp( 10 );
				SleepUntil( [| timer_expired( l_timer ) or ai_combat_status( AI.sg_tunnels_front_all ) >= 1  ] , 2);
					TutorialStopAll();
		end
end

function f_tun_yipyap()


	object_create("ped_yipyap");
	Sleep(45);
	local obj_cr:object = object_create("cr_smash_yipyap");
	object_wake_physics( obj_cr );

end
	
function f_tun_yapyip()
	print("float");
	local yapyip:object = object_create_anew("ped_yapyip");
	Sleep(2);
	object_set_velocity( yapyip, 0.05, 0.4, -0.3 );
	object_set_angular_velocity( yapyip, 6,3,2);
	--sleep_s(15);
	--object_set_velocity( yapyip, 0.25, 0.4, 0 );
	--object_set_angular_velocity( yapyip, 1,1,1);
end

function f_tun_musketeer_clear_room_1():void
		SleepUntil( [| volume_test_players( VOLUMES.tv_tun_front_come_on ) ] , 1 );	
			MusketeerUtil_SetDestination_Assault_Clear();
end


function f_tun_musketeer_goal_wait_room_1():void

	repeat
		SleepUntil( [| volume_test_players( VOLUMES.tv_tun_room_1_vent_flank ) ] , 1 );	
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_tun_room_1_prep, 1);
			end			
		SleepUntil( [| not volume_test_players( VOLUMES.tv_tun_room_1_vent_flank ) ] , 1 );	
			if not b_tun_room_1_muskt_ready then
				MusketeerUtil_SetDestination_Assault_Clear();
			end
	until ai_combat_status( AI.sg_tunnels_front_all ) > 5 or b_tun_room_1_muskt_ready;

end



global b_tun_room_1_muskt_ready:boolean  = false;

function f_tun_musketeer_goal_room_1():void

	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_vent_roar_01 ) ] , 1 );	
			sleep_s(0.25);
			print("musk move up!");
			b_tun_room_1_muskt_ready = true;
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_tun_room_drop_in, 3);
			end
			
	SleepUntil( [| device_get_position( OBJECTS.dm_tunnel_door_03 ) >= 0.5  ] ,1 );
		MusketeerUtil_SetDestination_Assault_Clear();

end


function f_tun_musketeer_clear_room_2():void
		SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_unlock_armada_door ) ] , 1 );	
			MusketeerUtil_SetDestination_Assault_Clear();
end


function f_tun_musketeer_goal_wait_room_2():void

	repeat
		SleepUntil( [| volume_test_players( VOLUMES.tv_tun_room_2_drop_flank ) ] , 1 );	
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_tun_room_2_prep, 1);
			end			
		SleepUntil( [| not volume_test_players( VOLUMES.tv_tun_room_2_drop_flank ) ] , 1 );	
			if not b_tun_room_2_muskt_ready then
				MusketeerUtil_SetDestination_Assault_Clear();
			end
	until ai_combat_status( AI.sg_tunnels_end_all ) > 5 or b_tun_room_2_muskt_ready;

end



global b_tun_room_2_muskt_ready:boolean  = false;
function f_tun_musketeer_goal_room_2():void

	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_vent_room_2 ) ] , 1 );	
			sleep_s(0.75);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
					MusketeerDestSetPoint(obj, FLAGS.fl_tun_room_2, 1);
			end
			b_tun_room_2_muskt_ready = true;
	SleepUntil( [| device_get_position( OBJECTS.dm_tunnel_door_04 ) >= 0.5  ] ,1 );
		MusketeerUtil_SetDestination_Assault_Clear();

end

function f_tun_hunter_smash_window_1():void
	
	--CreateEffectGroup(EFFECTS.fx_tun_gotcha);
	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter_smash_worms ) ] , 1 );	
		composer_play_show("w4_station_tunnel_worms");
	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter1 ) ] , 1 );
			composer_play_show("vin_tunnel_hunters_01");
			b_tun_hunter_w_1 = true;
			b_tunnels_hunter_glass_event = true;

--	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter2 ) ] , 1 );
			b_tun_hunter_w_2 = true;
	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter3 ) ] , 1 );
			b_tun_hunter_w_3 = true;
			game_save();
			CreateThread( f_tun_hunter_smash_window_egg );
end

function f_tun_hunter_smash_window_egg()
	
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_grunt_giggle ) ] , 1 );
	SleepUntil( [| volume_test_players( VOLUMES.tv_hunter2 ) ] , 1 );
		b_tun_hunter_w_2 = true;
		composer_play_show("vin_tunnel_hunters_egg");
end

function f_tunnel_rear_room_zealot_roar()
	SleepUntil( [| ai_spawn_count( AI.sq_tun_end_zealot ) > 0 and ai_living_count(AI.sq_tun_end_zealot ) < 1 ] ,1 );
		sleep_rand_s(1.5, 3 );
		f_tunnel_hunter_roar_1(OBJECTS.dm_tunnel_door_05);

end

function f_tunnel_front_room_vent_roar()
	SleepUntil([| volume_test_players( VOLUMES.tv_tunnel_vent_roar_01 ) ],1 );
			sleep_rand_s(0.5, 1 );
			print("Roar");
			f_tunnel_hunter_roar_1(OBJECTS.cr_tun_ven_cue_01);
	
end

function f_tunnel_hunter_roar_1(spot:object)
	local spot = spot or nil;
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel_stream\018_vin_campaign_w4assault_huntertunnel_firstroar.sound'), spot, 1);
end

function f_tunnel_hunter_roar_2(spot:object)
	local spot = spot or nil;
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel_stream\018_vin_campaign_w4assault_huntertunnel_secondroar.sound'), spot, 1);
end



function f_tun_grunt_bang_door():void
	--SleepUntil( [| volume_test_players( VOLUMES.tv_tun_grunt_door_bang ) ] , 1 );
		--composer_play_show("vin_tunnel_grunts_hit_door");
end

function cs_tun_hunter_window_smash_1_move():void

end

function cs_tun_hunter_window_smash_2_move():void

end



function f_tun_armada_door():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_unlock_armada_door ) ] , 1 );

		b_tun_1_cov_ship_show = composer_play_show("vin_cov_ships_approach");
		b_tunnels_armada_event = true;
		sleep_s(1);
		ObjectSetSpartanTrackingEnabled( OBJECTS.sn_tunnels_mark_path_01, false );
		sleep_s(0.1);
		object_create("sn_tunnels_mark_path_window");
		SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_spot_armada ) ] , 1 );		
			sleep_s(5);
			object_destroy(OBJECTS.sn_tunnels_mark_path_window);		
			sleep_s(0.1);
			ObjectSetSpartanTrackingEnabled( OBJECTS.sn_tunnels_mark_path_01, true );
		
		
		--f_tun_objective();
end

function f_tun_open_tunnel_doors( trigger:object, activator:object ) 
	local this_activator:object = activator or PLAYERS.player0 ;

end




global b_tunnel_lights_on:boolean = false;

function f_tunnel_lamp_flicker_all()
		
		
		--sleep_s( 1.0 );
		--for i = 1, 4 do
		--	CreateThread(f_tunnel_lamp_flicker , i )
		--end
		--sleep_s( 0.5 );
		if not b_tunnel_lights_on then
			b_tunnel_lights_on = true;
			CreateThread( f_setup_headlamp_area, VOLUMES.tv_headlamp_1 , f_tunnel_lamp_areas_complete );
		end
end

function f_tunnel_lamp_flicker(spartan_index:number)

		--CreateThread( f_setup_headlamp_area, VOLUMES.tv_headlamp_1 , f_tunnel_disable_lamp );
	local index = spartan_index or 1;
		TurnOnSpartanFlashlight( SPARTANS[index] );
		Sleep(5);
	--sleep_s( 5);
		TurnOffSpartanFlashlight( SPARTANS[index] );
		Sleep(5);
	--	sleep_s( 5);
		TurnOnSpartanFlashlight( SPARTANS[index] );
		Sleep(5);
	--	sleep_s( 5);
		TurnOffSpartanFlashlight( SPARTANS[index] );
		Sleep(3);
		--TurnOnSpartanFlashlight( SPARTANS[index] );


end

function f_tunnel_disable_lamp():boolean
	return true;

end



function f_tun_front_room_spawner():void

	--CreateThread( f_tun_lead_worms );
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_spawn_front_room)] , 1 );
		
		game_save();
		Sleep(30);
		
		--ai_grunt_kamikaze(AI.sq_tun_2_grunt_last_gasp);
		ai_place( AI.sg_tunnels_front_all );
		
			
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_front_room) and ai_combat_status(AI.sg_tunnels_front_all) >= 7] , 1 );
		ai_grunt_kamikaze(AI.sq_tun_front_grunt_01);
		sleep_s( 2.5 );
		ai_grunt_kamikaze(AI.sq_tun_front_grunt_02);
		
	SleepUntil( [| ai_living_count(AI.sg_tunnels_front_all) <= 0 ] , 1 );
		MusketeerUtil_SetDestination_Assault_Clear();   -- safeguard
	
end

function f_tun_end_room_spawner():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_spawn_end_room)] , 1 );
		game_save();
		Sleep(30);
		CreateThread( f_tun_yipyap );

		ai_place( AI.sg_tunnels_end_fodder );
		Sleep(30);
	SleepUntil( [| volume_test_players( VOLUMES.tv_tun_spawn_end_room_zealot) or ai_living_count(AI.sg_tunnels_end_all) <= 1 or device_get_position( OBJECTS.dm_tunnel_door_05 ) >= 0.1 ] , 1 );
		--print("a;sldfkjaasdf;lkjasd");
		ai_place( AI.sq_tun_end_zealot );
		Sleep(2);
		device_set_position( OBJECTS.dm_tunnel_door_05, 1.0  ); 
		--ai_set_active_camo(AI.sg_tunnels_end_zealot , true);
end


function f_tun_lemmy_spawner():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_lemmy)  ], 1 );
		ai_place( AI.sq_tun_end_lemmy );

end

function f_tun_zealot_door()

		--device_set_position( OBJECTS.dm_tunnel_door_05, 1.0  ) 
end

function cs_tun_camo_delay()

	Sleep(4);
	ai_set_active_camo( ai_current_actor, true);
	--CreateThread(f_tun_camo_delay, ai_current_actor);
end
function f_tun_camo_delay( zealot:ai )

----	sleep_s(1.0);
----	SleepUntil([| device_get_position( OBJECTS.dm_tunnel_door_05 ) >= 0.50 ] ,1 )
		ai_set_active_camo( zealot, true);
end

function f_tun_lead_worms():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_room_4_steam_03)  ], 1 );
		composer_play_show("w4_station_tunnel_worms2");

end





function f_tunnel_steam_room_04_01():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_room_4_steam_01)] , 1 );
		--print("boo");
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_pipehit.sound'), nil, 1);
		CreateThread(rumble_shake_medium);
		CreateEffectGroup(EFFECTS.hunter_wall_hit);
		Sleep(5);
		
		CreateEffectGroup(EFFECTS.pipe_jet_1);
		sleep_s(1)
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_huntertunnel\018_vin_campaign_w4assault_huntertunnel_pipehit_run.sound'), nil, 1);

end



function f_tunnel_steam_room_04_02():void 
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_room_4_steam_02)] , 1 );
		CreateEffectGroup(EFFECTS.pipe_jet01);

	
end


--pipe_jet02
function f_tunnel_steam_room_04_03():void 
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_room_4_steam_03)] , 1 );

		CreateEffectGroup(EFFECTS.pipe_jet02);
		Sleep(5);

end


	
	

function cs_active_camo()
	Sleep(5);
	ai_set_active_camo( ai_current_actor, true );
end





function f_tunnel_armada_room():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_tunnel_spot_armada ) ] , 1 );
		assault_game_save_no_timeout();
end


	
function f_tun_cin_040()
	print("Start cin 040");
	ai_erase( AI.sg_yard_all );

	RunClientScript ("w4_assualt_camera_dust_stop");
	CinematicPlay ("cin_040_vision");
	RunClientScript ("w4_assualt_camera_dust");
	b_meridian_temp_cin_complete = true;
	b_tun_cin_done = true;
	
end


--
function f_tunnel_cleanup()
	print("tunnels cleanup");
	if  b_tun_1_cov_ship_show ~= nil then
			print("stopping cov ship vignette");
			composer_stop_show(b_tun_1_cov_ship_show);
	end	

	--object_destroy_folder("m_new_tunnel_crates");
--	object_destroy_folder("wpns_tunnels");

	ai_erase( AI.sg_tunnels_all);
	--object_destroy_folder("dm_tunnel_doors");
	object_destroy(OBJECTS.ped_yipyap);
	object_destroy(OBJECTS.cr_smash_yipyap);
	RunClientScript("f_hunter_cl_clean_up_tunnel_fx");
	

end








--function fx_tun_visionx():void
--	print ("FX - Vision Transition");  
--	effect_new(TAG('levels\campaignworld030\w3_citadel\fx\energy\halo_flashback_rampancy_transition.effect'),FLAGS.fl_tun_start_in);
--end




--## CLIENT

function remoteClient.fx_tun_vision():void
	--print ("FX - Vision Transition");
	effect_new(TAG('levels\campaignworld030\w3_citadel\fx\energy\halo_flashback_rampancy_transition.effect'),FLAGS.fl_tun_start_in);

	effect_new(TAG('levels\campaignworld030\w3_citadel\fx\energy\halo_flashback_rampancy_transition_out.effect'),FLAGS.fl_tun_start_in);	
end



