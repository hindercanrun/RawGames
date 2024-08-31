--## SERVER
-- ==================================================================
-- ========= TRIALS AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_trials_thread_up_mission_start():void
	print("MUSIC_MissionStart_Inside");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_intro_start.music_control'));
end

function audio_trials_thread_up_hallway1_door():void
	print("MUSIC_MissionStart_Outside");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_hallway1_door.music_control'));
end

function audio_trials_thread_up_elevator1_start():void
	print("MUSIC_Elevator1_Start");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_elevator1_start.music_control'));
end

function audio_trials_thread_up_tower_start():void
	print("MUSIC_Tower_Start");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_tower_start.music_control'));
end

function audio_trials_thread_up_tower_middlewave():void
	print("MUSIC_Tower_Middlewave");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_tower_middlewave.music_control'));
end

function audio_trials_thread_up_tower_middlewave_outro():void
	print("MUSIC_Tower_MiddlewaveOutro");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_tower_middlewave_outro.music_control'));
end

function audio_trials_thread_up_elevator2_start():void
	sleep_s(2);
	print("MUSIC_Elevator2_Start");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_elevator2_start.music_control'));
end

function audio_trials_thread_up_arena_start():void
	print("MUSIC_Arena_Start");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_tower_arena.music_control'));
end

function audio_trials_thread_up_arena_outro():void
	sleep_s(3);
	print("MUSIC_Arena_Outro");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_tower_arena_outro.music_control'));
end

function audio_trials_thread_up_wardenfight_start():void
	print("MUSIC_WardenFight_Start");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_wardenfight_start.music_control'));
end

function audio_trials_thread_up_wardenfight_outro():void
	print("MUSIC_WardenFight_Outro");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_wardenfight_outro.music_control'));
end

function audio_trials_thread_up_wardenfight_fade():void
	print("MUSIC_WardenFight_Fade");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_wardenfight_fade.music_control'));
end

function audio_trials_thread_up_postflashback3_start():void  -- in composition but unused
	--print("AUDIO_Music_Trials_PostFlashback3_Start");
	--music_event(TAG(''));
end

function audio_trials_thread_up_flashback3_stop():void -- in composition but unused
	--print("AUDIO_Music_Trials_Flashback3_Stop");
	--music_event(TAG(''));
end

function audio_trials_thread_up_flashback2_stop():void -- in composition but unused
	--print("AUDIO_Music_Trials_Flashback2_Stop");
	--music_event(TAG(''));
end

function audio_trials_thread_up_leap_start():void  -- in composition but unused
	--print("AUDIO_Music_Trials_Leap_Start");
	--music_event(TAG(''));
end

function audio_trials_stopallmusic():void
	print("AUDIO_Music_Trials_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\trials\120_mus_campaign_trials_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

function audio_trials_elevatorspawn_a():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_gondola\004_dm_gondola_trials_appear.sound'), OBJECTS.vin_lift1_dm, nil, 1);
end

function audio_trials_elevatorspawn_b():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_gondola\004_dm_gondola_trials_appear.sound'), OBJECTS.vin_lift2_dm, nil, 1);
end

--## CLIENT

function startupClient.CitadelMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w3_citadel.sound'), nil, 1)
end