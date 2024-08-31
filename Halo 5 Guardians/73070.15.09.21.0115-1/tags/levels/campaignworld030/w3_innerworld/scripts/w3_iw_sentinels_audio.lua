--## SERVER
-- ==================================================================
-- ========= SENTINELS AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_sentinels_thread_up_mission_start():void
	print("AUDIO_Music_Sentinels_Mission_Start");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_mission_start.music_control'));
end

function audio_sentinels_thread_up_gondola_emp():void 
	print("AUDIO_Music_Sentinels_Gondola_EMP");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_gondola_emp.music_control'));
end

function audio_sentinels_thread_up_gondola_start():void
	print("MUSIC_Gondola_Start");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_elevatorstart.music_control'));
end

function audio_sentinels_thread_up_gondola_exit():void
	print("MUSIC_Gondola_Exit");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_gondola_exit.music_control'));
end

function audio_sentinels_thread_up_cores_start():void
	print("MUSIC_Cores_Start");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_cores_start.music_control'));
end

function audio_sentinels_thread_up_cores_3to4():void
	print("MUSIC_Cores_3to4");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_cores_3-4.music_control'));
end

function audio_sentinels_thread_up_cores_oneleft():void
	print("MUSIC_Cores_5");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_cores_oneleft.music_control'));
end

function audio_sentinels_thread_up_cores_end():void
	print("MUSIC_Cores_End");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_cores_end.music_control'));
end

function audio_sentinels_thread_up_coliseum_start():void
	print("MUSIC_Coliseum_Start");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_coliseum_start.music_control'));
end

function audio_sentinels_thread_up_coliseum_calm():void
	print("MUSIC_Coliseum_Calm");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_coliseum_calm.music_control'));
end

function audio_sentinels_thread_up_coliseum_switches():void
	sleep_s(9);
	print("MUSIC_Coliseum_Switches");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_coliseum_switches.music_control'));
end

function audio_sentinels_thread_up_coliseum_end():void
	print("MUSIC_Coliseum_End");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_coliseum_end.music_control'));
end

function audio_sentinels_thread_up_coliseum_fadeout():void
	print("MUSIC_Coliseum_FadeOut");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_coliseum_fadeout.music_control'));
end

function audio_sentinels_thread_up_underground_start():void
	print("MUSIC_Underground_Start");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_underground_start.music_control'));
end

function audio_sentinels_thread_up_underground_core_destroyed():void
	sleep_s(24);
	print("MUSIC_Underground_Core_Destroyed");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_underground_core_destroyed.music_control'));
end

function audio_sentinels_stopallmusic():void
	print("AUDIO_Music_Sentinels_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================

function startup.audio_builder_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end
	
--[[t_audioLevelOneoffMusicTable[ZONE_SETS.zn_road] =
	{
		[VOLUMES.tv_audio_gondola_exit] = TAG('sound\120_music_campaign\sentinels\120_mus_sentinels_gondola_exit.music_control'),
	};--]]

-- =====================================
-- ========= SFX =======================
-- =====================================

t_audioOneoffStaticSoundTable[ZONE_SETS.zn_road] =
{
		
	inside =
	{
		[VOLUMES.tv_audio_emp_start] = TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w3sentinels\031_st_osiris_campaign_w3sentinels_emp_mute.sound'),
	}
};

function audio_cortana_smallbowl_activate()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_cortana_activate)] );
		SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w3sentinels_cortanaidle.sound'), OBJECTS.crate_audio_cortana_idle, nil, 1);
		PlaySoundPlacement(SOUNDS.cortana_smallbowl_idle);
end

function audio_cortana_smallbowl_deactivate()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_cortana_deactivate)] );
		StopSoundPlacement(SOUNDS.cortana_smallbowl_idle);
end

function audio_cryptum_pulse()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_powercore\004_dm_powercore_sentinals\004_dm_powercore_sentinals_cryptumpulse.sound'), OBJECTS.hero_cryptum01, "fx_cryptum_center", 1);
	--SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_powercore\004_dm_powercore_sentinals\004_dm_powercore_sentinals_cryptumpulse.sound'), OBJECTS.hero_cryptum02, "fx_cryptum_center", 1);
	--SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_powercore\004_dm_powercore_sentinals\004_dm_powercore_sentinals_cryptumpulse.sound'), OBJECTS.hero_cryptum, "fx_cryptum_center", 1);
end

function audio_console_start()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_cryptum\004_dm_cryptumcontrols_trigger_riseup.sound'), OBJECTS.dm_core_prime, 1);
	PlaySoundPlacement(SOUNDS.console_loop)
end
function audio_console_stop()
	StopSoundPlacement(SOUNDS.console_loop)
end

function audio_prep_factory()
	CreateThread(audio_factory_guardianstart);
	CreateThread(audio_factory_guardiana);
	CreateThread(audio_factory_guardianb);
	CreateThread(audio_factory_guardianc);
	CreateThread(audio_factory_guardiand);
end

function audio_factory_guardianstart()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_factory_guardianstart)] );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3sentinels_factory\018_vin_campaign_w3sentinels_factory_guardianoneoff_start.sound'), nil, 1);
end
function audio_factory_guardiana()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_factory_guardian_a)] );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3sentinels_factory\018_vin_campaign_w3sentinels_factory_guardianoneoff_stagea.sound'), nil, 1);
end
function audio_factory_guardianb()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_factory_guardian_b)] );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3sentinels_factory\018_vin_campaign_w3sentinels_factory_guardianoneoff_stageb.sound'), nil, 1);
end
function audio_factory_guardianc()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_factory_guardian_c)] );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3sentinels_factory\018_vin_campaign_w3sentinels_factory_guardianoneoff_stagec.sound'), nil, 1);
end
function audio_factory_guardiand()
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_factory_guardian_d)] );
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3sentinels_factory\018_vin_campaign_w3sentinels_factory_guardianoneoff_staged.sound'), nil, 1);
end

-- Exuberant removes the shield so fireteam can walk to the pedastal.
function audio_factory_domeshielddown()
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_energy\003_amb_positional_energy_shielddrop_sentinels.sound'), nil, 1);
end

-- Coliseum console a & b have a loop when they're activate and ready to be interacted with. Once acivated, they create a short burst of sparks.
function audio_coliseum_console_a_start()
	PlaySoundPlacement(SOUNDS.coliseum_control_a);
end

function audio_coliseum_console_a_stop()
	StopSoundPlacement(SOUNDS.coliseum_control_a);
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_spark\003_amb_positional_spark_smallspray_sentinels.sound'), OBJECTS.audio_coliseum_console_a, 1);
end

function audio_coliseum_console_b_start()
	PlaySoundPlacement(SOUNDS.coliseum_control_b);
end

function audio_coliseum_console_b_stop()
	StopSoundPlacement(SOUNDS.coliseum_control_b);
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_spark\003_amb_positional_spark_smallspray_sentinels.sound'), OBJECTS.audio_coliseum_console_b, 1);
end

function audio_cryptum_powerdown()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_cryptum\004_dm_cryptum_powerdown_sentinels_st.sound'), OBJECTS.audio_cryptum_powerdown, 1);
end

--## CLIENT

function startupClient.SentinelsMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w3_sentinels.sound'), nil, 1)
end