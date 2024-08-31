--## SERVER
-- ==================================================================
-- ========= MININGTOWN AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_miningtown_stopallmusic():void
	print("AUDIO_Music_MiningTown_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\miningtown\120_mus_miningtown_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

function audio_miningtown_start():void															
	print("AUDIO_MiningTown_Start");
	music_event(TAG('sound\120_music_campaign\miningtown\120_mus_miningtown_start.music_control'));
end

function audio_miningtown_boardpelican():void															
	print("AUDIO_MiningTown_BoardPelican");
	music_event(TAG('sound\120_music_campaign\miningtown\120_mus_miningtown_boardpelican.music_control'));
end

--## CLIENT

function startupClient.MeridianHubMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w1_meridianhub.sound'), nil, 1)
end

function vin_sloan_addresses_miners_speech():void
	sound_impulse_start(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_00800.sound'), OBJECTS.sloan, 1);
end