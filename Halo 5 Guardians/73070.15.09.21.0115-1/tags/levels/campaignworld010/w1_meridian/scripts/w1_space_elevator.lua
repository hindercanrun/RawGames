--## SERVER
		--UPDATE 4/24/14 - COMMENTED OUT ABOUT 12 LINES BECAUSE THEY WERE BREAKING SCRIPTS. JUST SEARCH MY NAME TO FIND THEM ALL. -JAYCE

function f_starry_sky()
	DeviceSetLayerPos(OBJECTS.dm_space_elevator_tube_01, 1 ,1);
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_01, 2, "device:exit");
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_01, 2, 60);
	CreateThread(f_mer_the_long_shake);
	sleep_s(1);
	object_destroy(OBJECTS.dm_space_elevator_tube_01);
	sleep_s(7);
	object_create("tube_02");
	CreateThread (f_shake_cam_elevator_02);
	object_create_anew("dm_space_elevator_tube_02");
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 1, "device:loop");
	DeviceSetLayerPlaybackLoop(OBJECTS.dm_space_elevator_tube_02, 1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 45);
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 2, "device:exit");
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 2, 30);
	object_create("dm_landscape");
	sleep_s(1);
	flock_create ("mining_ship_flock_elevator");	--	--	--	--	--	--	--	--	--	--	Delete at Outpost Start
	DeviceSetLayerAnimation(OBJECTS.dm_landscape, 1, "device:rise");
	DeviceSetLayerRate(OBJECTS.dm_landscape, 1, 0.5);
	sleep_s(3);
	object_create("dm_space_elevator_tube_01");
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_01, 1, "device:loop");
	DeviceSetLayerPlaybackLoop(OBJECTS.dm_space_elevator_tube_01, 1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_01, 1, 60);
	sleep_s(5);
	DeviceSetLayerPos(OBJECTS.dm_space_elevator_tube_01, 1 ,1);
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_01, 2, "device:exit");
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_01, 2, 60);
	sleep_s(1);
	object_destroy(OBJECTS.dm_space_elevator_tube_01);
	sleep_s(7);
	object_create("tube_02");
	CreateThread (f_shake_cam_elevator_02);
	object_create_anew("dm_space_elevator_tube_02");
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 1, "device:loop");
	DeviceSetLayerPlaybackLoop(OBJECTS.dm_space_elevator_tube_02, 1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 45);
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 2, "device:exit");
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 2, 30);
	object_create("dm_landscape");
	sleep_s(1);
	sleep_s(1);
	--object_destroy(OBJECTS.white_plane);	<------------------------------------------------		4/24/14 HAD TO COMMENT OUT (WAS BREAKING SCRIPTS) -JAYCE
	--object_destroy(OBJECTS.moving_clouds_1);	<------------------------------------------------		4/24/14 HAD TO COMMENT OUT (WAS BREAKING SCRIPTS) -JAYCE
	--object_destroy(OBJECTS.moving_clouds_2);	<------------------------------------------------		4/24/14 HAD TO COMMENT OUT (WAS BREAKING SCRIPTS) -JAYCE
	print("go faster");
	DeviceSetLayerRate(OBJECTS.dm_landscape, 1, 5);
	sleep_s(1);
	object_create_anew("dm_space_elevator_tube_02");
	DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 1, "device:loop");
	--DeviceSetLayerAnimation(OBJECTS.dm_space_elevator_tube_02, 2, "device:exit");
	DeviceSetLayerPlaybackLoop(OBJECTS.dm_space_elevator_tube_02, 1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 60);
	sleep_s(1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 45);
	sleep_s(1);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 30);
	--DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 2, 120);
	object_destroy(OBJECTS.dm_landscape);
	sleep_s(2.5);
	CreateThread(f_shake_cam_elevator_02);
	DeviceSetLayerRate(OBJECTS.dm_space_elevator_tube_02, 1, 0);
	b_elevator_over = true;
end

function f_mer_the_long_shake():void
	rumble_shake_small(20.0);
end

function f_shake_cam_elevator_01()
	rumble_shake_small(4.25);
end

function f_shake_cam_elevator_02()
	rumble_shake_small(2.0);
end

function f_shake_cam_elevator_02_5()
	rumble_shake_small(2.5);
end

function f_shake_cam_elevator_03()
	rumble_shake_small(9.4);
end

function f_shake_cam_elevator_end()
	rumble_shake_medium(1.0);
end

--## CLIENT

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_*_*_ FX SCRIPTS *_*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*