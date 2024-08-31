--## SERVER
-- ==================================================================
-- ========= HALSEY AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_halsey_thread_up_intro_start():void	
	print("AUDIO_Music_Halsey_Intro_Start");
	sleep_s(16);
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_intro_start.music_control'));
end

function audio_soldier_reveal():void
	print("AUDIO_Music_Halsey_Soldier_Reveal");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_soldier_reveal.music_control'));
end

function audio_after_shoulderbash():void
	print("AUDIO_Music_Halsey_After_Shoulderbash");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_after_soldierbash.music_control'));
end

function audio_halsey_thread_up_airlock():void
	print("AUDIO_Music_Halsey_Airlock");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_airlock.music_control'));
end

function audio_halsey_thread_up_hill_secondwave():void
	print("AUDIO_Music_Halsey_hill_SecondWave");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_hill_secondwave.music_control'));
end

function audio_halsey_thread_up_hill_end():void	 												
	print("AUDIO_Music_Halsey_Hill_End");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_hill_stop.music_control'));
end

function audio_halsey_thread_up_vault_end():void
	print("AUDIO_Music_Halsey_Vault_End");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_knightcombat_outro.music_control'));
end

function audio_halsey_stopallmusic():void
	print("AUDIO_Music_Halsey_StopAllMusic");
	music_event(TAG('sound\120_music_campaign\halsey\120_mus_halsey_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================

-- MUSIC

function startup.audio_assault_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
	CreateThread(AudioMissionSoundStart);
	--CreateThread(audio_mixstate_firstencounter);
end

t_audioLevelOneoffMusicTable[ZONE_SETS.zn_hill] =
{
	[VOLUMES.tv_audio_hill_start] = TAG('sound\120_music_campaign\halsey\120_mus_halsey_hill_start.music_control'),
	[VOLUMES.tv_audio_vault_enter] = TAG('sound\120_music_campaign\halsey\120_mus_halsey_entervault.music_control'),
};

t_audioLevelOneoffMusicTable[ZONE_SETS.zn_vault] =
{
	[VOLUMES.tv_hallway_lookat] = TAG('sound\120_music_campaign\halsey\120_mus_halsey_knightcombat_start.music_control'),

};

--cinematic mute state on

function audio_cinematic_mute_halsey()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--SFX Mix State
-- This should trigger a one-off mix state for each player as they enter a volume at the first fight in Halsey.
t_audioOneoffStaticSoundTable[ZONE_SETS.zn_cliff] =
{
	inside =
	{
		[VOLUMES.tv_audio_mixstate_firstencounter] = TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w3halsey\031_st_osiris_campaign_w3halsey_firstencounter.sound'),
	}
};

--function audio_mixstate_firstencounter()
    --SleepUntil( [| volume_test_players( VOLUMES.tv_audio_mixstate_firstencounter) ] , 1 );     
		--SoundImpulseStartMarkerServer(TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w3halsey\031_st_osiris_campaign_w3halsey_firstencounter.sound'), nil, nil, 1);
--end

--## CLIENT

function startupClient.HalseyMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w3_halsey.sound'), nil, 1)
end