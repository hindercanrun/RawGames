--## SERVER

global vtols_break:boolean = false;
global destruction_end:boolean = false;
global unlocked:boolean = false;
--global composition_end:number = nil;

global locke_in:boolean = false;
global buck_in:boolean = false;
global tanaka_in:boolean = false;
global vale_in:boolean = false;

global g_ics_player01:object = nil;
global g_ics_player02:object = nil;
global g_ics_player03:object = nil;
global g_ics_player04:object = nil;

global endlevel_reached:boolean = false;

--  Clears values for ICS animations for later on in the level.
function f_clear_ics()

	locke_in = false;
	buck_in = false;
	tanaka_in = false;
	vale_in = false;

	g_ics_player01 = nil;
	g_ics_player02 = nil;
	g_ics_player03 = nil;
	g_ics_player04 = nil;

end

missionEvacuation.goal_scaffoldClimb =
{
	checkPoints = POINTS.ps_blink_02,
	gotoVolume = VOLUMES.tv_goal_scaffold,
	zoneSet = ZONE_SETS.elevator_top,
	next = {"goal_controlRoom"}

}

function missionEvacuation.goal_scaffoldClimb.Start()
	print("starting elevator top goal");
		
	--keep the musketeers close to the player
	MusketeersKeepClose();
	
	--objectives
	CreateThread (ObjectivesScaffoldEnter);
	
	CreateThread(f_scaffold_title);

	CreateThread(hallway_begin);
	CreateThread(f_scaffold_pieces);
	CreateThread(f_spawn_scaffold_encounter);
	CreateThread(f_back_up_encounters);
	
	CreateThread(nar_goal_evac_scaffold);
	CreateThread(f_scaffold_effects);

	object_destroy(OBJECTS.dm_elevator_base_walls);
	object_cannot_die(OBJECTS.sc_scaffold, true);
	object_create_anew("titan_emp");
	object_create_anew("titan_placeholder");
end

function blink_scaffold()
	NarrativeQueue.Kill();
	CreateThread(audio_evacuation_stopallmusic);
	--object_destroy(OBJECTS.dm_elevator_base_walls);
	object_destroy(OBJECTS.dm_elevator_walls);
	end_earthquakes = true;
	CreateThread (GuardianShowStarter);
	GoalBlink(missionEvacuation, "goal_scaffoldClimb");

end

function GuardianShowStarter()
	SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.elevator_top], 1);
	composer_play_show("vin_guardian_end");
end

---- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
---- *_*_*_*_*_*_*_* LEVEL SCRIPTS *_*_*_*_*_*_*_*_*_*
---- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
function MusketeersKeepClose()
	for _,musketeer in pairs (musketeers()) do
		MusketeerCombatSetMaxPlayerDistance(musketeer, 3);
	end
end

function ObjectivesScaffoldEnter()
	print ("starting scaffold enter tracking");
	object_create_folder ("tracking_objectives_scaffold_exit");
	SleepUntil([|volume_test_players(VOLUMES.tv_objective_scaffold)], 1);
	
	object_destroy_folder ("tracking_objectives_scaffold_exit");
	object_create ("tracking_objective_scaffold");
end

--chapter title and objective text
function f_scaffold_title()
	--removing per bug 143325
	--f_chapter_title (TITLES.ct_evacuation_4);
	sleep_s(1.5);
	ObjectiveShow(TITLES.obj_evacuation_4);
end



function f_spawn_scaffold_encounter()
	SleepUntil([|volume_test_players(VOLUMES.tv_scaffold_climb)], 1);
	rumble_shake_medium (2);
	CreateThread(audio_metal_rumble);
	--RunClientScript("f_shake_cam"); 
	CreateEffectGroup(EFFECTS.debris_falling);
	CreateEffectGroup(EFFECTS.debris_falling01);
	
	CreateThread(audio_evacuation_thread_up_scaffold_start);

	SlipSpaceSpawn(AI.sq_scaff_fore_bot);

	ai_place(AI.sq_vtol_chase);
	ai_place(AI.sq_vtol_chase01);

	object_create_folder_anew("falling_debris_01");

	CreateThread(vtols_break_off);
--	CreateThread(f_vtol_flyby_02);
--	CreateThread(f_vtol_flyby_03);
	CreateThread(f_mid_save);

	SleepUntil([|volume_test_players(VOLUMES.tv_spawn_chase)], 1);
	ai_place(AI.sq_scaff_sold);
	ai_place(AI.sq_vtol_flyby_01);
	--ai_place(AI.sq_scaff_bish);
end



--function f_vtol_flyby_02()
--
--	SleepUntil([|volume_test_players(VOLUMES.tv_vtol_flyby_02)], 1);
--	--ai_place(AI.sq_vtol_flyby_02);
--
--end
--
--function f_vtol_flyby_03()
--
--	SleepUntil([|volume_test_players(VOLUMES.tv_falling_scaffold)], 1);
--	--ai_place(AI.sq_vtol_flyby_03);
--
--end


function f_mid_save()
	SleepUntil([|volume_test_players(VOLUMES.tv_mid_scaff_save)], 1);
	game_save_no_timeout();


end



function f_back_up_encounters ()

	SleepUntil([|volume_test_players(VOLUMES.tv_sold_fallback)], 1);
	object_create_folder_anew("falling_debris_01");
	ai_place(AI.sq_scaff_sold01);

	SleepUntil([|volume_test_players(VOLUMES.tv_sold_fallback_02)], 1);
		
	game_save_no_timeout();
	object_create_folder_anew("falling_debris_01");
	SlipSpaceSpawn(AI.sq_scaff_sold02);
	SlipSpaceSpawn(AI.sq_scaff_sold03);
	SlipSpaceSpawn(AI.sq_scaff_sold04);
	SlipSpaceSpawn(AI.sq_scaff_bish);
	
end


function f_scaffold_effects()
	SleepUntil([|volume_test_players(VOLUMES.tv_sold_fallback_01)], 1);
		CreateEffectGroup(EFFECTS.debris_falling02);
		CreateEffectGroup(EFFECTS.debris_falling06);

	SleepUntil([|volume_test_players(VOLUMES.tv_sold_fallback_02)], 1);
		rumble_shake_medium (2);
		CreateThread(audio_metal_rumble);
		--RunClientScript("f_shake_cam"); 
		CreateEffectGroup(EFFECTS.debris_falling03);
		CreateEffectGroup(EFFECTS.debris_falling04);
		CreateEffectGroup(EFFECTS.debris_falling05);

end

function vtols_break_off()
	SleepUntil([|volume_test_players(VOLUMES.tv_final_fight)], 1);
	vtols_break = true;
	game_save_no_timeout();

	--gmu - commenting out for bug - OSR-141264, if the end encounter is too difficult, then fix these functions
--	CreateThread(cs_break_off_01);
--	CreateThread(cs_break_off_02);
--	CreateThread(cs_break_off_03);
end

function hallway_begin()

	SleepUntil([|volume_test_players(VOLUMES.tv_end)],1);
	
	Wake(dormant.evacuation_guardian_launch_start);
	CreateThread(audio_guardian_crateslam_charge);
	--composer_play_show("vin_pelican_evac");

end

function f_hallway_crates()
	SleepUntil([|volume_test_players(VOLUMES.tv_end_sequence)],1);
	CreateEffectGroup(EFFECTS.pulse_effect);
	CreateEffectGroup(EFFECTS.pulse_effect_quick);
	CreateThread(audio_guardian_crateslam_pulse);
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w1evacuation_scaffolding\018_vin_campaign_w1evacuation_scaffolding_cratetoss_sweetener.sound'), OBJECTS.crate_blast, 1);
	rumble_shake_medium (2);
	CreateThread(audio_metal_rumble);
	--RunClientScript("f_shake_cam");

end

--Script to call all of the pieces falling on the scaffolding.
function f_scaffold_pieces()
	SleepUntil([|volume_test_players(VOLUMES.tv_falling_scaffold)],1);
	--device_set_position(OBJECTS.dm_falling_scaffolding, 1);
	RunClientScript ("GuardianPulseEffect");
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_blast_walkwayfall.sound'), nil, 1)
	sleep_s (2.25);
	rumble_shake_medium (2);
	CreateThread(audio_metal_rumble);
	--RunClientScript("f_shake_cam"); 
	composer_play_show("vin_walkway_fall");

end


--=========================================================================
--				END GOAL
--=========================================================================

missionEvacuation.goal_controlRoom =
{
	zoneSet = ZONE_SETS.elevator_top,
	checkPoints = POINTS.cp_end,

}


function missionEvacuation.goal_controlRoom.Start()
	RunClientScript ("StopScaffoldFlocks");
	GoalCreateThread(missionEvacuation.goal_controlRoom, f_ending_sequence);
	CreateThread(audio_evacuation_thread_up_scaffolding_climax);
end


function blink_end()
	NarrativeQueue.Kill();
	CreateThread(audio_evacuation_stopallmusic);
	object_destroy(OBJECTS.dm_elevator_base_walls);
	end_earthquakes = true;
	CreateThread (GuardianShowStarter);
	GoalBlink(missionEvacuation, "goal_controlRoom");
end


function f_ending_sequence()
	if unlocked == true then
		object_create("skull_thunderstorm");
	
	end

	volume_teleport_players_not_inside(VOLUMES.tv_teleport_end, FLAGS.fl_teleport_end);

	object_destroy(OBJECTS.tracking_objective_scaffold);
	--object_destroy(OBJECTS.tracking_supply_cache_scaffold_power);
	object_create("tracking_objective_pelican");
	RunClientScript("f_delete_top_flocks");
	CreateThread(f_hallway_crates);
	CreateThread(nar_goal_evac_control);
	
	--start a low rumble/shake
	rumble_shake_small (7);
	CreateThread(audio_metal_rumble);
	
	--composer_play_show("vin_hallway_destruction");

	local pelican_evac_end:number =(composer_play_show("vin_pelican_evac"));

	SleepUntil([|volume_test_players(VOLUMES.tv_begin_destruction)], 1);
	
	--canceling the game saves so that it doesn't save in the middle of destruction
	game_save_cancel();
	
	--start a low rumble/shake
	rumble_shake_small (7);
	CreateThread(audio_metal_rumble);
	
	destruction_end = true;
	--CreateThread(audio_evacuation_thread_up_scaffold_end);
	
	--wait until the destruction vignette is done or players have run close enough to the pelican
	SleepUntil([| not composer_show_is_playing (pelican_evac_end) or volume_test_players(VOLUMES.tv_end_pelican)], 1);
	
	--if the destruction vignette is still playing then end it
	if composer_show_is_playing (pelican_evac_end) then
		RunClientScript ("GuardianPulseEffect");
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_blast_final.sound'), nil, 1)
		print ("pulse started");
		sleep_s (3.5);
		print ("fade");
		fade_out (0,0,0, seconds_to_frames (0.1));
		sleep_s (0.1);
		if composer_show_is_playing (pelican_evac_end) then
			composer_stop_show (pelican_evac_end);
		end
		f_mission_ended();
	elseif volume_test_players(VOLUMES.tv_goal_control) then
		RunClientScript ("GuardianPulseEffect");
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_blast_final.sound'), nil, 1)
		sleep_s (2.25);
		fade_out (0,0,0, seconds_to_frames (0.1));
		sleep_s (0.1);
		local shake_time = 1;
		rumble_shake_large (shake_time);
		CreateThread(audio_metal_rumble);
		sleep_s (shake_time);
		f_mission_ended();
	else
		local shake_time = 1;
		rumble_shake_large (shake_time);
		CreateThread(audio_metal_rumble);
		sleep_s (shake_time);
		print ("kill all spartans");
		
		RunClientScript ("GuardianPulseEffect");
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast_evacuation.sound'), nil, 1)
		sleep_s (2.25);
		fade_out(255,255,255, 1);
		Sleep (1);
		composer_stop_all();
		unit_kill(SPARTANS.locke);
		unit_kill(SPARTANS.tanaka);
		unit_kill(SPARTANS.buck);
		unit_kill(SPARTANS.vale);
	end
end


--this destroys the objects for cin_105
function DestroyObjectsForCinema()
	print ("destroying objects for cin_105");
	ai_erase(AI.sg_scaffold_vtols);
	object_destroy(OBJECTS.pulse1);
	object_destroy(OBJECTS.pulse2);
	object_destroy(OBJECTS.crane);
	object_destroy(OBJECTS.tower);
	object_destroy(OBJECTS.evac_pel);
	object_destroy(OBJECTS.guardian_bird);
	RunClientScript ("DestroyObjectsForCinemaClient");
end

function f_mission_ended()
	endlevel_reached = true;
	CreateThread(audio_evacuation_thread_up_scaffold_end);
	print ("players made it to trigger volume, ending mission");
	GoalCompleteCurrent();
end

--================================================================
--				COMPOSER
--===============================================================
function f_end_mission()
	print ("testing the composition end");
	--CreateThread(f_mission_ended);

end




--Called from Composer
function f_stumble()

	CreateThread(play_stumble);
	print("stumbling");
end


function play_stumble()
	--this is ugy and I want to rewrite and fix the composition, but it is called in other scenarios -- gmu
	local puppets = 
		{
	 		g_ics_player01 = SPARTANS.locke,
	 		g_ics_player02 = SPARTANS.vale,
	 		g_ics_player03 = SPARTANS.tanaka,
			g_ics_player04 = SPARTANS.buck
		};
	
	for ics,sp in pairs (puppets) do
		if volume_test_object(VOLUMES.tv_stumble, sp) then
			_G[ics] = sp;
			object_set_shield (sp, 0);
			object_set_shield_stun (sp, 2);
		end
	end
	
	composer_play_show("vin_impact_front_stumble");
	rumble_shake_large(1);
	CreateThread(audio_metal_rumble);
	sleep_s(0.5);
	f_clear_ics();
	sleep_s(0.5);
	rumble_shake_small (2);
	CreateThread(audio_metal_rumble);
end

--called from composer
function f_fall()

	CreateThread(play_fall);
	print("falling");

end

function play_fall()
	--this is ugy and I want to rewrite and fix the composition, but it is called in other scenarios -- gmu
	local puppets = 
		{
	 		g_ics_player01 = SPARTANS.locke,
	 		g_ics_player02 = SPARTANS.vale,
	 		g_ics_player03 = SPARTANS.tanaka,
			g_ics_player04 = SPARTANS.buck
		};
	
	for ics,sp in pairs (puppets) do
		if volume_test_object(VOLUMES.tv_stumble, sp) then
			_G[ics] = sp;
			object_set_shield (sp, 0);
			object_set_shield_stun_infinite (sp);
		end
	end

	composer_play_show("vin_impact_front_to_fall");
	rumble_shake_large(1);
	CreateThread(audio_metal_rumble);
	sleep_s(0.5);
	f_clear_ics();
	sleep_s(0.5);
	rumble_shake_small (4);
	CreateThread(audio_metal_rumble);
end


function missionEvacuation.goal_controlRoom.End()
	EndMission(missionEvacuation);

end

--=====================================================
--					COMMAND SCRIPTS
--====================================================
function cs_break_off()
	sleep_s (random_range (0.5, 3));
	cs_fly_by(POINTS.ps_break_off.p01);
	cs_fly_by(POINTS.ps_break_off.p02);
	cs_fly_by(POINTS.ps_break_off.p03, 4);
	print (ai_vehicle_get(ai_current_actor));
	object_destroy(ai_vehicle_get(ai_current_actor));
end


function cs_break_off_01()

	cs_fly_by(AI.sq_vtol_chase, true, POINTS.ps_break_off.p01);
	
	cs_fly_by(AI.sq_vtol_chase, true, POINTS.ps_break_off.p02);

	cs_fly_by(AI.sq_vtol_chase, true, POINTS.ps_break_off.p03);
	
	ai_erase(AI.sq_vtol_chase);

end

function cs_break_off_02()

	cs_fly_by(AI.sq_vtol_chase01, true, POINTS.ps_break_off.p01);
	
	cs_fly_by(AI.sq_vtol_chase01, true, POINTS.ps_break_off.p02);

	cs_fly_by(AI.sq_vtol_chase01, true, POINTS.ps_break_off.p03);
	
	ai_erase(AI.sq_vtol_chase01);

end

function cs_break_off_03()

	cs_fly_by(AI.sq_vtol_flyby_01, true, POINTS.ps_break_off.p01);
	
	cs_fly_by(AI.sq_vtol_flyby_01, true, POINTS.ps_break_off.p02);

	cs_fly_by(AI.sq_vtol_flyby_01, true, POINTS.ps_break_off.p03);
	
	ai_erase(AI.sq_vtol_flyby_01);

end

function cs_flyby_01()
	
	cs_aim(ai_current_actor, true, POINTS.ps_shootat_01.p01);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_01.p01);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_01.p01);

	sleep_s(2.5);

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_01.p02);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_01.p02);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_01.p02);
	
	sleep_s(2.5);

end

function cs_flyby_02()
	
	repeat

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_02.p01);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_02.p01);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_02.p01);

	sleep_s(2.5);

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_02.p02);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_02.p02);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_02.p02);
	
	sleep_s(2.5);

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_02.p03);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_02.p03);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_02.p03);

	sleep_s(2.5);

	until false;
end

function cs_flyby_03()
	

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_03.p01);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_03.p01);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_03.p01);

	sleep_s(2.5);

	cs_aim(ai_current_actor, true, POINTS.ps_shootat_03.p02);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_shootat_03.p02);
	cs_fly_to(ai_current_actor, true, POINTS.ps_flyby_03.p02);
	
	sleep_s(2.5);

end


--## CLIENT

function remoteClient.f_delete_top_flocks()

	flock_delete("vtol_scaffold_flock");

end

--pulse effect for when the players are killed
function remoteClient.GuardianPulseEffect()
	--CreateThread(death_pulse_sound_state);
	--sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast_evacuation.sound'), nil, 1)
	-- this location is a custom point called in "vin_pelican_evac" subaction fx: Effect
	local loc:vector = vector(156.2491, -154.4233, 91.51424);
	effect_new (TAG('levels\campaignworld020\w2_tsunami\fx\guardian\guardian_pulse_main.effect'), loc);
					
end

function remoteClient.DestroyObjectsForCinemaClient()
	StopEffectGroup(EFFECTS.tracers_pelican_08);
	for i = 1, 9 do
		flock_delete ("vtol_scaffold_flock0"..i)
	end
	flock_delete ("vtol_scaffold_flock");
	flock_delete ("vtol_scaffold_flock10");
end

function remoteClient.StopScaffoldFlocks()
	for i = 1, 9 do
		flock_destroy ("vtol_scaffold_flock0"..i)
	end
	flock_destroy ("vtol_scaffold_flock");
	flock_destroy ("vtol_scaffold_flock10");
end