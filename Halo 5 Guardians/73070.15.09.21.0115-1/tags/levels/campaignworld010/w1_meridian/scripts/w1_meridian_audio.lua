--## SERVER
-- ==================================================================
-- ========= MERIDIAN AUDIO LUA SCRIPT =======================
-- ==================================================================


function audio_mission_start_music()
	print ("MUSIC at mission start");
	music_event (TAG('sound\120_music_campaign\meridian\120_mus_meridian_intro.music_control'));
end

function audio_outpost_opening_music()
	print ("MUSIC at Outpost reveal with mining ship shot down");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_opening.music_control'));
	SleepUntil([|volume_test_players(VOLUMES.tv_outpost_player_chk) == true], 1);
end

function audio_outpost_knightspawn_music()
	print ("MUSIC when the outpost knight spawns");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_knight_spawn.music_control'));
end

function audio_outpost_knightdead_music()
	print ("MUSIC when the outpost AI is dead");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_knight_dead.music_control'));
end

function audio_outpost_end_music()
	print ("MUSIC when the outpost encounter is over");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_gate_exit.music_control'));
end

function audio_playerinscorpion()
	print ("Music - Player in Scorpion");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_scorpion.music_control'));
end	

function audio_gate_defend_start_music()
	print ("MUSIC - gate defend start music");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_gate_defend_start.music_control'));
end

function audio_gate_defend_end_music()
	print ("MUSIC defend gate over");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_outpost_gate_defend_outro.music_control'));
end

function audio_meridian_stopallmusic():void
	print("AUDIO_Music_Meridian_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\meridian\120_mus_meridian_stopallmusic.music_control'));
	-- stopping all music in event of blink
end


-- SFX ======================= 

function audio_activate_turret_a()
	print("Turret button sounds triggered");
	sleep_s(1.0)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_press_meridian.sound'), OBJECTS.sfx_button_turretactivation, nil, 1);
	sleep_s(1.0)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_activate_meridian.sound'), OBJECTS.sfx_button_turretactivation, nil, 1);
end


function town_alarm_start()
	print("Town_Alarm_Start");
	PlaySoundPlacement(SOUNDS.meridiantown_alarm);
	
end

function town_alarm_stop()
	print("Town_Alarm_Stop");
	StopSoundPlacement(SOUNDS.meridiantown_alarm);
end

function audio_distant_explosion()
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_explosionsdistantlow_meridian_loop_a.sound'), nil, 1)
end



--## CLIENT

function startupClient.MeridianMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w1_meridian.sound'), nil, 1)
end
