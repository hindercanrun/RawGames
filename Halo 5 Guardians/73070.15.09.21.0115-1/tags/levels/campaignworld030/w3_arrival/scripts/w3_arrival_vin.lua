--## SERVER
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 ARRIVAL VIN*_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*


global var_banshees_out_of_control_01 = 0;
global var_banshees_out_of_control_02 = 0;
global var_cov_ships_crashing_close_call = 0;
global var_cov_ships_crashing_close_cliff_hit = 0;
global var_cov_ships_crashing_fly_under_bridge = 0;
global var_vin_misc_cov_ships_crashing = 0;
global var_cov_ships_out_of_control = 0;



--## Guardian 1
function cov_out_of_control():void
	print ("banshee_crash all function started");	
	CreateThread(banshees_out_of_control_01);
	CreateThread(banshees_out_of_control_02);
	CreateThread(cov_ships_crashing_close_call);
	CreateThread(cov_ships_crashing_close_cliff_hit);
	CreateThread(cov_ships_crashing_fly_under_bridge);
	CreateThread(vin_misc_cov_ships_crashing);	
	CreateThread(vin_cov_ships_out_of_control);		
end

function cov_ships_crashing_close_call():void
	print ("cov_ships_crashing_close_call function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_cov_ships_crashing_close_call)], 1);
	var_cov_ships_crashing_close_call = composer_play_show ("cov_ships_crashing_close_call");
end

function cov_ships_crashing_close_cliff_hit():void
	print ("cov_ships_crashing_close_cliff_hit function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_cov_ships_crashing_close_cliff_hit)], 1);
	var_cov_ships_crashing_close_cliff_hit = composer_play_show ("cov_ships_crashing_close_cliff_hit");
end

function vin_misc_cov_ships_crashing():void
	print ("vin_misc_cov_ships_crashing function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_vin_misc_cov_ships_crashing)], 1);
	var_vin_misc_cov_ships_crashing = composer_play_show ("vin_misc_cov_ships_crashing");
end

function cov_ships_crashing_fly_under_bridge():void
	print ("cov_ships_crashing_fly_under_bridge function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_cov_ships_crashing_fly_under_bridge)], 1);
	var_cov_ships_crashing_fly_under_bridge = composer_play_show ("cov_ships_crashing_fly_under_bridge");
end

--## Guardian 2

function banshees_out_of_control_01():void
	print ("banshees_out_of_control function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_banshees_out_of_control_01)], 1);
	var_banshees_out_of_control_01 = composer_play_show ("vin_banshees_out_of_control_01");
end

function banshees_out_of_control_02():void
	print ("banshees_out_of_control function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_banshees_out_of_control_02)], 1);
	var_banshees_out_of_control_02 = composer_play_show ("vin_banshees_out_of_control_02");
end

function vin_cov_ships_out_of_control():void
	print ("banshees_out_of_control function started");	
	SleepUntil ([| volume_test_players(VOLUMES.tv_cov_ships_out_of_control)], 1);
	var_cov_ships_out_of_control = composer_play_show ("vin_cov_ships_out_of_control");
end