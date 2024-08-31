--## SERVER

global n_obelisk_objcon = 0;
global n_obelisk_combat_objcon = 0;

function f_w2_plateau_ob_start_combat():void
	Wake( dormant.f_objcon_controller );
	----ai_place( AI.sg_obelisk_soldiers );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_sold_pair_1 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_sold_pair_off );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_sold_pair_2 );
	sleep_s( 0.1 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_sold_pair_3 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_sold_pair_4 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_knight_1 );
		sleep_s( 0.75 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_knight_2 );
	CreateThread( f_ob_activate_covers );


	
	sleep_s(1.1);

	
	CreateThread( SlipSpaceSpawn, AI.sq_ob_watcher_live_01 );
	CreateThread( SlipSpaceSpawn, AI.sq_ob_watcher_live_02 );
	
	sleep_s(5);
	ai_place_with_birth(AI.sq_ob_watcher_birth_01);
	ai_place_with_birth(AI.sq_ob_watcher_birth_02);

	--CreateThread( SlipSpaceSpawn, AI.sg_ob_sold_pair_off );
	--ai_place(AI.sg_obelisk_knights);
	CreateThread( f_ob_get_moving );
end

function dormant.f_objcon_controller()

	print(" objcon setup");
	
	--	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_5 ) or n_obelisk_combat_objcon >= 5 ], 1);
	--	if n_obelisk_combat_objcon <= 5 then
	--		n_obelisk_combat_objcon = 5;
		--	print("n_obelisk_combat_objcon = 5 ");
		--end	
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_10 ) or n_obelisk_combat_objcon >= 10 ], 1);
		if n_obelisk_combat_objcon <= 10 then
			n_obelisk_combat_objcon = 10;
			print("n_obelisk_combat_objcon = 10 ");
		end
		if n_obelisk_objcon <= 10 then
			n_obelisk_objcon = 10;
			print("n_obelisk_objcon = 10 ");
		end
		
	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_20 ) or n_obelisk_combat_objcon >= 20 ], 1);
		if n_obelisk_combat_objcon <= 20 then
			n_obelisk_combat_objcon = 20;
			print("n_obelisk_combat_objcon = 20 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_25 ) or n_obelisk_combat_objcon >= 25 ], 1);
		if n_obelisk_combat_objcon <= 25 then
			n_obelisk_combat_objcon = 25;
			print("n_obelisk_combat_objcon = 25 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_30 ) or n_obelisk_combat_objcon >= 30 ], 1);
		if n_obelisk_combat_objcon <= 30 then
			n_obelisk_combat_objcon = 30;
			print("n_obelisk_combat_objcon = 30 ");
		end		

	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_40 ) or n_obelisk_combat_objcon >= 40 ], 1);
		if n_obelisk_combat_objcon <= 40 then
			n_obelisk_combat_objcon = 40;
			print("n_obelisk_combat_objcon = 40 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_50 ) or n_obelisk_combat_objcon >= 50 ], 1);
		if n_obelisk_combat_objcon <= 50 then
			n_obelisk_combat_objcon = 50;
			print("n_obelisk_combat_objcon = 50 ");
		end

	SleepUntil ([| volume_test_players ( VOLUMES.tv_objcon_ob_60 ) or n_obelisk_combat_objcon >= 60 ], 1);
		if n_obelisk_combat_objcon <= 60 then
			n_obelisk_combat_objcon = 60;
			print("n_obelisk_combat_objcon = 60 ");
		end	
		
end

function f_ob_get_moving()
	--print("dont hurt me");
	--object_set_melee_attack_inhibited(AI.sg_obelisk_all, true);
	--SleepUntil( [| n_obelisk_objcon  >= 20 ],1 );
		--object_set_melee_attack_inhibited(AI.sg_obelisk_all, false);
end

function cs_push_back_1()
	--print("burp");
	cs_move_towards_point( ai_current_actor, true, POINTS.ps_ob_push_back.p1, 3);
end

function cs_push_back_2()
	cs_move_towards_point( ai_current_actor, true, POINTS.ps_ob_push_back.p2, 3);
end

function cs_push_back_3()
	cs_move_towards_point( ai_current_actor, true, POINTS.ps_ob_push_back.p3, 3);
end

function cs_push_back_4()
	cs_move_towards_point( ai_current_actor,true,  POINTS.ps_ob_push_back.p4, 3);
end


function cs_push_back_5()
	cs_move_towards_point( ai_current_actor, true, POINTS.ps_ob_push_back.p5, 3);
end

function cs_push_back_6()
	cs_move_towards_point( ai_current_actor, true, POINTS.ps_ob_push_back.p6, 3);
end


function cs_ob_dummy_staging_soldier()

	cs_abort_on_alert( true );
	cs_abort_on_damage(  true);
	--cs_enable_moving ( false );
	
	SleepUntil( [| ai_combat_status(AI.sg_obelisk_all) >= 5 ],1 );
	
end

--function cs_ob_dummy_staging_knight()

--	cs_abort_on_alert( true );
	--cs_abort_on_damage(  true);
	--cs_enable_moving ( false );
--	-
--	SleepUntil( [| ai_combat_status(AI.sg_obelisk_all) >= 5 ],1 );
	
--end

function f_plat_ob_entry_door():void
	SleepUntil (	[|	volume_test_players(VOLUMES.tv_plat_ob_open_big_door) ], 5	 );
	print("open door");
	device_set_position( OBJECTS.dm_obelisk_entry_door,0.99 );
	-- 12/11/2014: Airlock: This is the spot for future zone set swapping/loading, whatever.  -tjp
	sleep_s(2);
	SleepUntil (	[|	volume_test_players(VOLUMES.tv_ob_open_door_2) ], 5	 );
	device_set_position( OBJECTS.dm_obelisk_entry_door_2, 0.99 );
	CreateThread(audio_plateau_soldierroom_start);
end


function start_obelisk_combat():void
	CreateThread(audio_plateau_soldierroom_combat);
	CreateThread(f_w2_plateau_ob_start_combat );
	CreateThread(f_ob_flutter_tabs );
end
function f_ob_flutter_tabs()
	device_set_position( OBJECTS.dm_ob_tabs_01, 1 );
	device_set_position( OBJECTS.dm_ob_tabs_02, 1 );
	device_set_position( OBJECTS.dm_ob_tabs_03, 1 );
	device_set_position( OBJECTS.dm_ob_tabs_04, 1 );
end
function cs_artifact_door()
	print("flying through door");
	cs_fly_by(POINTS.points_artifact_door.p0);
	cs_fly_by(POINTS.points_artifact_door.p1);
	cs_fly_by(POINTS.points_artifact_door.p2);
	cs_fly_by(POINTS.points_artifact_door.p3);
	cs_fly_to_and_face(POINTS.points_artifact_door.p4, POINTS.points_artifact_door.p3);
	sleep_s(2);
	cs_face_player(true);
	repeat
		sleep_s(2);
	until(false);
end




function f_ob_activate_covers()

local t_ob_cover:table = 
{
	"for_obel_cover_shield_01",
	"for_obel_cover_shield_02",
	"for_obel_cover_shield_03",
	"for_obel_cover_shield_04",
	"for_obel_cover_shield_05",
	"for_obel_cover_shield_06",
	"for_obel_cover_shield_07",
	"for_obel_cover_shield_08",
};

	for _, cover in ipairs( t_ob_cover ) do
		print("up ", cover);
		device_set_position( ObjectFromName(cover) , 1 );
		Sleep(4);
		
	end
end

function f_ob_all_platform_transform()
	--device_set_position( OBJECTS.dm_ob_platform_01, 1 );
        print ("FX - Steam on Platform Sections");
	--	RunClientScript("fx_soldier_platform_client")
end

function f_ob_all_grenade_floater_transform()
	sleep_s( 3 );
	--device_set_position( OBJECTS.dm_ob_floater_01, 1 );
	--RunClientScript("fx_soldier_floaters_client")
        print ("FX - Steam on Floater Pieces");   
end
