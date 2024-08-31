--## SERVER
-- ==================================================================
-- ========= ARRIVAL AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_arrival_thread_up_guardianrun_start():void
	print("MUSIC_GuardianRun_Start");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_guardian_run_start.music_control'));
	CreateThread(audio_guardianrun_garbageimpact);
end

function audio_arrival_thread_up_guardianrun_end():void
	sleep_s(3.5);
	print("MUSIC_GuardianRun_End");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_guardian_run_end.music_control'));
end

function audio_arrival_thread_up_landing_start():void
	sleep_s(3);
	print("MUSIC_Landing_Start");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_landing_start.music_control'));
end

function audio_arrival_thread_up_landing_end():void
	print("MUSIC_Landing_End");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_landing_outro.music_control'));
end

function audio_arrival_thread_up_take_cave():void
	print("MUSIC_Tank_Cave");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_tank_cave.music_control'));
end

function audio_arrival_thread_up_crossing_end():void
	print("MUSIC_Crossing_End");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_crossing_end.music_control'));
end

function audio_arrival_thread_up_grasslands():void
	sleep_s(3);
	print("MUSIC_Grasslands");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_grasslands.music_control'));
end

function audio_arrival_thread_up_gateway_start():void
	sleep_s(8);
	print("MUSIC_Gateway_Start");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_gateway_start.music_control'));
end

function audio_arrival_thread_up_gateway_end():void
	print("MUSIC_Gateway_End");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_gateway_end.music_control'));
end

function audio_arrival_thread_up_mission_end():void
	print("MUSIC_Mission_End");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_mission_end.music_control'));
end

function audio_arrival_stopallmusic():void
	print("MUSIC_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\arrival\120_mus_arrival_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================
--  MUSIC



function startup.audio_arrival_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
	CreateThread(audio_guardianrun_end_pulse);
end

--[[t_audioLevelOneoffMusicTable[ZONE_SETS.zn_crossing] =
{
	[VOLUMES.tv_audio_crossing_hunter_route] = TAG('sound\120_music_campaign\arrival\120_mus_arrival_crossing_hunter_route.music_control'),
	
};--]]

-- sound effects ===========================================================================
function audio_guardianrun_deathcharge()
	print("Audio Guardian Run Death Charge");
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_VIN_CP_Guardian_W3Arrival_GuardianRunDeathPulse_Charge.sound'), nil, 1);
end

function audio_guardianrun_pulseimpact()
	print("Audio Guardian Run Pulse Impact");
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_VIN_CP_Guardian_W3Arrival_GuardianRunPulse_Blast.sound'), nil, 1);
end



function audio_guardianrun_end_pulse()
	--SleepUntil( [| volume_test_players(VOLUMES.tv_gaurdian_fall)] );
		--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w3arrival_guardianrun_outroblast.sound'), nil, 1);
end

function audio_arrival_lightbridge_activate():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_lightbridge\004_dm_lightbridge_activate_arrival.sound'), OBJECTS.dm_lightbridge, nil, 1);
	PlaySoundPlacement(SOUNDS.lightbridge_left);
	PlaySoundPlacement(SOUNDS.lightbridge_right);
end

function audio_guardianrun_garbageimpact()
	sleep_s(2.5);
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3arrival_guardianrun\018_vin_campaign_w3arrival_guardianrun_garbage_impact.sound'), OBJECTS.audio_crate_garbage_impact, nil, 1);
end

--## CLIENT

function audio_guardianrun_deathpulse():void
	sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast_arrival.sound'), nil, 1);
end

function startupClient.ArrivalMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w3_arrival.sound'), nil, 1)
end