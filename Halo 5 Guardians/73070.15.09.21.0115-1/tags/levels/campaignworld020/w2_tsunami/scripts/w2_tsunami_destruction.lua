--## SERVER

--[[
████████╗███████╗██╗   ██╗███╗   ██╗ █████╗ ███╗   ███╗██╗    ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗                   
╚══██╔══╝██╔════╝██║   ██║████╗  ██║██╔══██╗████╗ ████║██║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║                   
   ██║   ███████╗██║   ██║██╔██╗ ██║███████║██╔████╔██║██║    ███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║                   
   ██║   ╚════██║██║   ██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║    ╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║                   
   ██║   ███████║╚██████╔╝██║ ╚████║██║  ██║██║ ╚═╝ ██║██║    ███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║                   
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝                   
                                                                                                                                         
██████╗ ███████╗███████╗████████╗██████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
██╔══██╗██╔════╝██╔════╝╚══██╔══╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
██║  ██║█████╗  ███████╗   ██║   ██████╔╝██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   
██║  ██║██╔══╝  ╚════██║   ██║   ██╔══██╗██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
██████╔╝███████╗███████║   ██║   ██║  ██║╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ███████║╚██████╗██║  ██║██║██║        ██║   
╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   
Tsunami Station Destruction Script
------------------------------------------------------------------------------------
--]]
-- GLOBALS
global b_destruction_start:boolean = false;
global b_explosion_alley:boolean = false;
global b_platfall_01:boolean = false;
global b_platfall_02:boolean = false;
global b_pawnreveal_01:boolean = false;
global b_walkway1_stagger:boolean = false;
global b_shipcrashthru_settle = false;
global b_pre_pulse:boolean=false;
global b_doorway_blocker:boolean=false;
global b_phandy_landy:boolean=false;
global b_w3_debris = false;
global b_landingpad_pulse_done = false;
global var_player_pulse_test:number=0;
global var_comp_guardian_rise:number=0;
global var_tsunami_pulse:number=0;
global var_tsu_pulse_ics_stagger:number=0;
global var_e3_spirit_phantom_flyby=0;
global var_tsunami_da_doorway_blocker=0;



--//----//----//----//----//--	Destruction Alley	--//----//----//----//----//--



-- Play Composition functions


function destruction():void
	if(var_tsunami_pulse ~= 0)then
		composer_stop_show(var_tsunami_pulse);
		Sleep(2);
		var_tsunami_pulse = 0;
	end
	b_destruction_start = true;
	b_pre_pulse = true;
	CreateThread(play_big_sequence);
end
function destruction_guardian_pulse():void
	print ("destruction_guardian_pulse is loaded and waiting");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_pulse_comp_start)], 1);
	var_e3_spirit_phantom_flyby = composer_play_show ("vin_e3_spirit_phantom_flyby");
	sleep_s(4);
	CreateThread(play_big_sequence);
end

function play_big_sequence():void
	if(var_tsunami_pulse == 0)then
		var_tsunami_pulse = composer_play_show ("vin_tsunami_destruction_alley");
		var_tsunami_da_doorway_blocker = composer_play_show ("vin_tsunami_da_doorway_blocker");
	end
end
function destruction_pre_pulse():void
	print ("guardians about to pop");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_pre_pulse)], 1);
	b_pre_pulse = true;
end
function phandy_landy():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_phandy_landy)], 1);
	print("LKSJ SLDKJF LSDKJ FLSKDJF DLSJFO IEJF OWEIJF OWEIJF LSJFL SKDJF LSIJF OSIJF SOIJF SDJF LSDJF LS");
	b_phandy_landy = true;
end

function player_ics_pulse_01():void
	print ("player_ics_pulse_01 is loaded and waiting");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_platfall_02)], 1);
	CreateThread (platfall);
end

function player_pulse_test():void
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_trailblazer01)], 1);
	print ("WEE TEST PATHING");
--	var_player_pulse_test = composer_play_show ("vin_ics_pulse_stagger_primary");
end


function spartan_choreographer():void
	local vol1:volume = VOLUMES.tv_trailblazer;
	local state = {};
	local puppets = {};
	--SleepUntil ([|volume_test_players(vol1)], 1);
	SleepUntil ([|volume_return_players(vol1)[1] ~= nil], 1);
	state.player = volume_return_players(vol1)[1];
	print ("player is ",state.player);
--[[
		for _,puppet in ipairs(spartans()) do
			if puppet ~= state.player then
				puppets[(#puppets + 1)] = puppet;
				state["spartan"..(#puppets)] = puppet;
				object_teleport (puppet, FLAGS["fl_path_0"..(#puppets)]);
				print ("puppet ", _ ," is ",puppets[#puppets]);
			end
		end
--]]
-- uncomment this block to enable the ics for all (also need to unmute on stagger_primary composition instance)
	Sleep(4);
	if (v_is_demo == true) then
		SleepUntil([| object_is_puppet(SPARTANS.buck) == false], 3);
--		object_teleport(SPARTANS.tanaka, FLAGS.fl_demo_destro_t);
--		object_teleport(SPARTANS.vale, FLAGS.fl_demo_destro_v);
--		object_teleport(SPARTANS.buck, FLAGS.fl_demo_destruction_buck);
	end
		composer_play_show("vin_ics_pulse_stagger_primary", state );
end


--function trailblazer_path(char:player):void
--	print("MOVING TRAILBLAZER");
----	player_camera_control(true);
----	player_control_clamp_gaze(char, FLAGS.pulse_look, 25);
----	player_control_move_to_point(PLAYERS.player0, FLAGS.fl_path_03, .6, .2, 180);
--	RunClientScript("move_player", char, FLAGS.fl_path_03, .6, .2, 510);
----	player_control_move_to_point(char, FLAGS.fl_path_03, .6, .2, 180);
--	print("TRAILBLAZER MOVED");
--	Sleep(2);
--	CreateThread(trailblazer_reached_destination_listener, char);
--	print("TRAILBLAZER COMPLETE");
--end
--function trailblazer_reached_destination_listener(char:player):void
--	SleepUntil([|player_control_move_to_active(char) == false], 1)
--	Sleep(2);
--	RunClientScript("move_player", char, FLAGS.fl_path_03, 1, .1, 10);
--	SleepUntil([|volume_test_players(VOLUMES.tv_destruction_start) == true], 1);
--	start_destruction_sequence(char);
----	composer_play_show("vin_ics_pulse_stagger_primary", {	spartan = PLAYERS.player0} );							-- for testing
----	player_control_move_to_point(char, FLAGS.fl_path_03, 1, .1, 10);
--end
--function start_destruction_sequence(char:player):void
--	PlayersForceReviveAndRespawn();
--	Sleep(1);
--	CreateThread(fallback_teleporter);
--	b_destruction_start = true;																						-- sets composition in motion
--	var_tsu_pulse_ics_stagger = composer_play_show("vin_ics_pulse_stagger_primary", {	spartan = char} );
--	game_safe_to_respawn(false);																					
--	Sleep(2);
--	SleepUntil([|composer_show_is_playing(var_tsu_pulse_ics_stagger) == false],3 );
--	RunClientScript("move_player", char, FLAGS.fl_path_03, 1, .1, 10);												-- overkill
--end
--function secondary_player_path(char:object, fl1:flag, fl2:flag):void
----	player_camera_control(true);
----	player_control_clamp_gaze(char, FLAGS.pulse_look, 25);
--	RunClientScript("move_player", char, fl1, 1, .2, 240);
----	player_control_move_to_point(char, fl1, 1, .2, 180);
--	SleepUntil([|player_control_move_to_active(char) == false], 1)
--	RunClientScript("move_player", char, fl2, 1, .2, 240);
--	CreateThread(secondary_character_play_ics, char, fl2);
--end
--function secondary_character_play_ics(char:player, fl2:flag):void
--	SleepUntil([|composer_show_is_playing(var_tsu_pulse_ics_stagger) == true],3 );
--	if(objects_distance_to_point(char, fl2) <= 2)then
--		object_teleport(char, fl2);
--	end
--	local num:number = 	composer_play_show("vin_ics_pulse_stagger_secondary", {	spartan = char} );
--	Sleep(2);
--	SleepUntil([|composer_show_is_playing(num) == false],3 );
--	RunClientScript("move_player", char, fl2, 1, 2, 10);															-- overkill
--end
--function fallback_teleporter():void
--	for _,obj in ipairs(players()) do 
--		if (volume_test_object (VOLUMES.tv_destruction_pre_pulse, obj) == true)	then
--				object_teleport(obj, FLAGS.fl_path_tp);
--		end
--	end
--end
function platfall():void
	b_platfall_01 = true;
	Sleep(1);
	local vol1:volume = VOLUMES.tv_platfall_02;
--[[																												-- hook back up after e3
	SleepUntil ([|volume_return_players(vol1)[1] ~= nil], 1);
		--	--	--	--	--	TIME TO DETERMINE WHO WILL FALL.	--	--	--	--	--
	local playa:object = volume_return_players(vol1)[1];
	CreateThread(tsunami_destruction_alley_stagger, unit_get_player(playa)); --narr
	composer_play_show("vin_ics_platfall", {spartan = playa} );
--]] 
end
--function player_ics_stagger():void
	--print ("player_ics_stagger is loaded and waiting");
	--SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_start)], 1);
	--var_tsu_pulse_ics_stagger = composer_play_show ("vin_ics_pulse_stagger_primary");
--end
function slide_ics_trigger():void
	local vol1:volume = VOLUMES.tv_slider;
	SleepUntil ([|volume_return_players(vol1)[1] ~= nil], 1);
		--	--	--	--	--	TIME TO DETERMINE WHO WILL SLIDE.	--	--	--	--	--
	local playa:object = volume_return_players(vol1)[1];
	CreateThread(tsunami_destruction_alley_slide, playa);	-- narrative_func
	local show1:number = composer_play_show("vin_ics_slide", {	spartan = playa} );
end

------------------- Boolean Triggers for Pulse Vignette

function dest_pulse_triggers():void
--	CreateThread (dest_destructionstart_trigger);
	CreateThread (dest_explosionalley_trigger);
	CreateThread (dest_shipcrashthru_settle);
	CreateThread (dest_platfall02_trigger);
	--CreateThread (dest_pawnreveal_01);
end
--[[																					-- IF THIS ISNT MISSED, DELETE IT
function dest_destructionstart_trigger():void		-- might become obsolete
	SleepUntil ([|	volume_test_players (VOLUMES.tv_destruction_start)], 1);
	b_destruction_start = true;													-- sets composition in motion
	print ("b_destruction_start Composer Puppet Variable == TRUE");
end
--]]
function dest_explosionalley_trigger():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_explosion_alley)], 1);
	b_explosion_alley = true;
	print ("Explosion Alley Composer Puppet Variable == TRUE");
end

function dest_shipcrashthru_settle():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_shipcrashthru_settle)], 1);
	b_shipcrashthru_settle = true;
	print ("shipcrashthru_settle Composer Puppet Variable == TRUE");
	CreateThread (w3_debris);
end

function w3_debris():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_w3_debris)], 1);
	b_w3_debris = true;
	print ("w3 debris are falling");
end


function dest_platfall02_trigger():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_slider)
				or	volume_test_players (VOLUMES.tv_slide_bc)
				], 1);
	b_platfall_02 = true;
	KillThread(thread_slide);
	print ("Platfall 02 Composer Puppet Variable == TRUE");
end



--## CLIENT

function remoteClient.move_player(char:player, fl:flag, t:number, p:number, f:number):void
	player_control_move_to_point(char, fl, t, p, f);
end