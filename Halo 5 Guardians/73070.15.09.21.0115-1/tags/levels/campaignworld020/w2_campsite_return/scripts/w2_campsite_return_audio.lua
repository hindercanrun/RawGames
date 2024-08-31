--## SERVER
-- ==================================================================
-- ========= CAMPSITE RETURN AUDIO LUA SCRIPT =======================
-- ==================================================================


function audio_campsitereturn_stopallmusic():void
	print("AUDIO_Music_CampsiteReturn_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\campsitereturn\120_mus_campsite_return_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

--Constructor Powers Up																		
function audio_campsitereturn_constructorpowerup_start():void
	print("AUDIO_ConstructorPowerUp_Start");
    music_event(TAG('sound\120_music_campaign\campsitereturn\120_mus_campsitereturn_constructorup.music_control'));  
end

function audio_campsitereturn_mainloop_start():void
	print("MUSIC_MainLoop_Start");
    music_event(TAG('sound\120_music_campaign\campsitereturn\120_mus_campsite_return_mainloop.music_control'));  
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w2campsitereturn\031_st_osiris_campaign_w2campsitereturn_constructorlouder.sound'), nil, 1); -- increase Constructor volume for a few seconds
end

function audio_campsitereturn_mainloop_end():void
	print("MUSIC_MainLoop_End");
    music_event(TAG('sound\120_music_campaign\campsitereturn\120_mus_campsite_return_mainloop_end.music_control'));  
end

--Alarms are deactivated - if we want to hear them, trigger this at the appropriate time
--function audio_campsitereturn_activatealarms():void
--	print("AUDIO_ActivateAlarms");
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert01);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert02);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert03);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert04);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert05);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert06);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert07);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert08);
--	PlaySoundPlacement(SOUNDS.alarm_covenantbattlealert09);
--end

--## CLIENT

function startupClient.CampsiteReturnMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w2_campsitereturn.sound'), nil, 1)
end