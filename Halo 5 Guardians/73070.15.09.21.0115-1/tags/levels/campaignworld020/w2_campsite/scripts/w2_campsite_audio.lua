--## SERVER
-- ==================================================================
-- ========= CAMPSITE AUDIO LUA SCRIPT =======================
-- ==================================================================

function startup.test_startup_01()
	AudioMissionSoundStart();
	--sfx for lookat and enter
	print ("Audio_MissionSoundStartup");
end

function startup.test_startup_02()
	AudioMissionStart();
	--music for lookat and enter
	print ("Audio_MissionStartup");
end

function audio_campsite_briefings_halsey ():void														-- called from mission script
	print("AUDIO_Campsite_Halsey");
	music_event(TAG('sound\120_music_campaign\campsite\120_mus_campsite_briefings_start.music_control'));
end

function audio_campsite_briefings_palmer ():void														-- called from mission script
	print("AUDIO_Campsite_Palmer");
	music_event(TAG('sound\120_music_campaign\campsite\120_mus_campsite_briefings_palmer.music_control'));
end

function audio_campsite_stopallmusic():void
	print("AUDIO_Music_Campsite_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\campsite\120_mus_campsite_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

--## CLIENT

function startupClient.CampsiteMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w2_campsite.sound'), nil, 1)
end

