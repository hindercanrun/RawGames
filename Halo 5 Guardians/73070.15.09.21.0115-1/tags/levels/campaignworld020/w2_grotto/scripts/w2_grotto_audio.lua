--## SERVER
-- ==================================================================
-- ========= GROTTO AUDIO LUA SCRIPT =======================
-- ==================================================================


function audio_grotto_objective_find_arbiter_start():void
	
	print("AUDIO Music Grotto Find Arbiter Start");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_objective_find_arbiter.music_control'));
	
end

function audio_grotto_objective_falls_combat():void
	
	print("AUDIO Music Grotto Falls Combat");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_falls_combat_start.music_control'));
	
end

function audio_grotto_mantis_drop():void
	sleep_s(19);
	print("AUDIO Music Grotto Mantis Drop");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_mantis_drop.music_control'));
	
end

function audio_grotto_mantis_courtyard_door():void
	print("AUDIO Music Grotto Mantis Courtyard Door");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_courtyard_door.music_control'));
	
end

function audio_grotto_finaltemple_start():void
	
	print("AUDIO Music Grotto Final Temple Start");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_finaltemple_start.music_control'));
	
end

function audio_grotto_finaltemple_inside():void
	
	print("AUDIO Music Grotto Final Temple Inside");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_finaltemple_inside.music_control'));
	
end

function audio_grotto_thread_up_mission_end():void
	--sleep_s(2);
	print("AUDIO_Music_Grotto_Mission End");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_mission_end.music_control'));
	
end

function audio_grotto_stopallmusic():void
	print("AUDIO_Music_Grotto_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\grotto\120_mus_grotto_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================

function startup.audio_grotto_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end

t_audioLevelOneoffMusicTable[ZONE_SETS.w2_grotto_keyhole] =
{
	[VOLUMES.tv_audio_exit_temple] = TAG('sound\120_music_campaign\grotto\120_mus_grotto_exit_temple.music_control'),
	[VOLUMES.tv_audio_sinkhole_end] = TAG('sound\120_music_campaign\grotto\120_mus_grotto_tunnel_enter.music_control'),

};

--## CLIENT

function startupClient.GrottoMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w2_grotto.sound'), nil, 1)
end
