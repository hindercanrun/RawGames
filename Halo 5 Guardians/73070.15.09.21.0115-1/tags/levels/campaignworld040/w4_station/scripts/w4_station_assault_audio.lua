--## SERVER
-- ==================================================================
-- ========= STATION ASSAULT AUDIO LUA SCRIPT =======================
-- ==================================================================

-- MUSIC
--===========================================================================================

-- Intro and Shipyard

function audio_assault_thread_up_mission_start():void
	print("MUSIC_MissionStart");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_mission_start.music_control'));

end

function audio_assault_thread_up_activate_hologram():void
	print("MUSIC_Activate_Hologram");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_start.music_control'));

end

function audio_assault_thread_up_elevator_end():void
	print("MUSIC_Shipyard_Elevator_End");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_elevator_end.music_control'));

end

function audio_assault_thread_up_shipyard_combat_start():void
	print("MUSIC_Shipyard_Combat_Start");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_combat_start.music_control'));

end

--[[function audio_assault_thread_up_shipyard_combat_low():void
	print("MUSIC_Shipyard_Combat_Low");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_combat_low.music_control'));

end--]]

function audio_assault_thread_up_shipyard_combat_secondwave():void
	print("AUDIO_Music_Assault_Shipyard_Combat_SecondWave");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_combat_secondwave.music_control'));
 
end

function audio_assault_thread_up_shipyard_combat_fade():void
	print("MUSIC_Shipyard_Combat_Fade");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_fade.music_control'));

end

function audio_assault_thread_up_hunter_room():void
	print("MUSIC_HunterRoom");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_hunter_room.music_control'));
	
end

function audio_assault_thread_up_reactor_combat():void
	print("MUSIC_Reactor_Combat");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_reactor_combat.music_control'));
	
end

function audio_assault_thread_up_activate_reactor():void
	print("MUSIC_Activate_Reactor");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_activate_reactor.music_control'));
	
end

function audio_assault_thread_up_move_reactor():void
	print("MUSIC_Move_Reactor");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_move_reactor.music_control'));
	
end

function audio_assault_thread_up_switch_off():void
	print("MUSIC_Switch_Off");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_switch2_off.music_control'));

end

function audio_assault_thread_up_vents_dead():void
	print("MUSIC_Vents_Dead");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_vents_dead.music_control'));

end

function audio_assault_thread_up_mark_entrance():void
	print("MUSIC_Mark_Entrance");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_mark_entrance.music_control'));

end

function audio_assault_thread_up_hangar_switch():void
	print("MUSIC_Hangar_Switch");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_hangarfight_switch.music_control'));
	
end

function audio_assault_thread_up_hangar_end():void
	print("MUSIC_Hangar_End");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_hangarfight_end.music_control'));
	
end

function audio_assault_thread_up_mission_end():void
	print("MUSIC_Mission_End");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_mission_end.music_control'));
	
end

function audio_assault_stopallmusic():void
	print("AUDIO_Music_Assault_StopAllMusic");
	music_event(TAG('sound\120_music_campaign\assault\120_mus_assault_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================

-- MUSIC

function startup.audio_assault_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end

t_audioLevelOneoffMusicTable[ZONE_SETS.zs_01_b] =
{
	[VOLUMES.tv_audio_shipyard_start_door] = TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_combat_start.music_control'),
	[VOLUMES.tv_audio_shipyard_end_door] = TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_end.music_control'),
	
};

t_audioLevelOneoffMusicTable[ZONE_SETS.zs_02_b] =
{
	[VOLUMES.tv_audio_shipyard_end_door] = TAG('sound\120_music_campaign\assault\120_mus_assault_shipyard_end.music_control'),
};

t_audioLevelOneoffMusicTable[ZONE_SETS.zs_03] =
{
	[VOLUMES.tv_music_tunnels] = TAG('sound\120_music_campaign\assault\120_mus_assault_tunnels.music_control'),
	[VOLUMES.tv_tunnel_spot_armada] = TAG('sound\120_music_campaign\assault\120_mus_assault_armada_viewing.music_control'),
	--[VOLUMES.tv_reactor_spawn] = TAG('sound\120_music_campaign\assault\120_mus_assault_reactor_combat.music_control'),
};

--[[t_audioLevelOneoffMusicTable[ZONE_SETS.zs_04] =
{
	[VOLUMES.tv_music_hangar_view] = TAG('sound\120_music_campaign\assault\120_mus_assault_hangarfight_start.music_control'),
};--]]



--SFX
--========================================================================================================

--Reactor (MOVED TO COMPOSER IN FABER)
--===============================================================

--[[function audio_reactor_half_eject():void
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_reactor\018_vin_campaign_w4assault_reactor_half_eject.sound'), OBJECTS.dm_reactor_core, "audio_top", 1);
	--playing nonlooping sfx  attached to reactor
end

function audio_reactor_full_eject():void
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_reactor\018_vin_campaign_w4assault_reactor_full_eject.sound'), OBJECTS.dm_reactor_core, "audio_top", 1);
	StopSoundPlacement(SOUNDS.reactor_unstable_loop)
	--playing nonlooping sfx attached the reactor
end --]]

--intro elevator
--==================================================================

function audio_cinematic_mute_assault()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

function audio_activate_hologram()
	sleep_s(1.2)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_hologram\004_dm_hologram_techcenter_buttonpress.sound'), OBJECTS.dc_tech_halogram, "front", 1);
	sleep_s(1.5)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_hologram\004_dm_hologram_techcenter_datasecactivated.sound'), OBJECTS.dc_tech_halogram, "front", 1);
end

function audio_hologram_loop()
	sleep_s(3)
	PlaySoundPlacement(SOUNDS.station_hologram);
	end

function audio_elevator_button_press()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_buttonpress.sound'), OBJECTS.dc_tech_elevator, "m_pad", 1);
end

function audio_hunter_door_button_press()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assaulthunter\004_dm_elevator_assaulthunter_buttonpress.sound'), OBJECTS.dc_tun_hunter_door, "front", 1);
end

function audio_hunter_exit_plug()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_plug\004_dm_door_plug_punchspark.sound'), OBJECTS.dc_hunter_exit_control, "front", 1);
end

function audio_reactor_button_press()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_reactor\018_vin_campaign_w4assault_reactor_buttonpress.sound'), OBJECTS.dc_assault_reactor, "front", 1);
	StopSoundPlacement(SOUNDS.reactor_idle_loop)
	PlaySoundPlacement(SOUNDS.reactor_unstable_loop)
end

function audio_vent_control_activated()
	sleep_s(3)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_ventingsystem\004_dm_ventingsystem_controlbeep.sound'), OBJECTS.dc_banshee_vent_1, "front", 1);
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_ventingsystem\004_dm_ventingsystem_controlbeep.sound'), OBJECTS.dc_banshee_vent_2, "front", 1);
	sleep_s(1)
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_ventingsystem\004_dm_ventingsystem_activated.sound'), nil, 1);
end

function audio_vent_control_glassbreak1()
	sleep_s(0.9)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm_vfx\004_dm_vfx_small_assaultventcontrol\004_dm_vfx_small_assaultventcontrolglassbreak_nonplayer.sound'), OBJECTS.dc_banshee_vent_1, "front", 1);
end

function audio_vent_control_glassbreak2()
	sleep_s(0.9)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm_vfx\004_dm_vfx_small_assaultventcontrol\004_dm_vfx_small_assaultventcontrolglassbreak_nonplayer.sound'), OBJECTS.dc_banshee_vent_2, "front", 1);
end

function audio_generator_activated()
	sleep_s(1)
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_prowlerfuelpump\004_dm_prowlerfuelpump_start.sound'), nil, 1);
	--SoundImpulseStartMarkerServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_honing\002_ui_hud_3d_trackingping.sound'), OBJECTS.hum_keypad_generator, "front", 1);
	PlaySoundPlacement(SOUNDS.prowler_fuel_pump)
	--StopSoundPlacement(SOUNDS.prowler_fuel_pump)
	sleep_s(1)
	PlaySoundPlacement(SOUNDS.fuel_tube)
	PlaySoundPlacement(SOUNDS.fuel_tube01)
	PlaySoundPlacement(SOUNDS.fuel_tube02)
	PlaySoundPlacement(SOUNDS.fuel_tube03)
end

function audio_generator_stopfuel()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_prowlerfuelpump\004_dm_prowlerfuelpump_complete.sound'), nil, 1);
	StopSoundPlacement(SOUNDS.fuel_tube)
	StopSoundPlacement(SOUNDS.fuel_tube01)
	StopSoundPlacement(SOUNDS.fuel_tube02)
	StopSoundPlacement(SOUNDS.fuel_tube03)
	StopSoundPlacement(SOUNDS.prowler_fuel_pump)
end

function audio_prowlerbaseair_intense()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w4assault\031_st_osiris_campaign_w4assault_prowlerroombaseair.sound'), nil, 1);
end

function audio_cooling_system_alarm()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_ventingsystem\004_dm_ventingsystem_damagealarm.sound'), nil, 1);
end

function audio_fuel_cells_full()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_prowlerfuelpump\004_dm_prowlerfuelpump_complete.sound'), nil, 1);
end

function audio_elevator_door_close()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_door_close.sound'), OBJECTS.dm_intro_elevator, "audio_door1", 1);
end

function audio_elevator_door_open()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_door_open.sound'), OBJECTS.dm_intro_elevator, "audio_door2", 1);
end

function audio_elevator_start()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_start.sound'), OBJECTS.dm_intro_elevator, "audio_door2", 1);
end

--[[function audio_elevator_start_loop()
	sound_looping_start_server(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_running_loop.sound_looping'), nil, 1);
end--]]

function audio_elevator_stop()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_stop.sound'), OBJECTS.dm_intro_elevator, "audio_door2", 1);
end

function audio_hunter_foreshadow_stop()
	StopSoundPlacement(SOUNDS.hunter_foreshadow)
end

function audio_forcefield_door_open()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_assault_spaceopen.sound'), OBJECTS.dm_banshee_hangar_door, "audio_center", 1);
end

function audio_prowler_door_open()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_assault_prowleropen.sound'), OBJECTS.dm_arrival_door_01, "audio_center", 1);
end

--[[function audio_elevator_stop_loop()
	sound_looping_start_server(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_assault\004_dm_elevator_assault_running_loop.sound_looping'));
end--]]

--TRIGGER VOLUMES----
--==================================================================================================================================

--SFX
function audio_hunter_foreshadow():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_audio_shipyard_end_door) ] , 1 );     
                                PlaySoundPlacement(SOUNDS.hunter_foreshadow)
end

function audio_reactor_idle():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_reactor_charge_tut) ] , 1 );     
                                PlaySoundPlacement(SOUNDS.reactor_idle_loop)
end

function audio_hunter_firstquake():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_audio_hunter_quake) ] , 1 );     
                                composer_play_show("vin_hunter_quake01");
end

function audio_hunter_quake_exit():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_audio_hunter_quake_exit) ] , 1 );     
                                composer_play_show("vin_hunter_quake_exit");
end

function audio_hunter_callout():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_audio_hunter_callout) ] , 1 );     
                                composer_play_show("vin_hunter_callout");
end

--[[function audio_silly_slide():void 
                SleepUntil( [| volume_test_players( VOLUMES.tv_audio_shipyard_slide) ] , 1 );     
                                SoundImpulseStartServer(TAG('sound\006_character\006_character_feet\006_chf_un_spartan\006_chf_un_spartan_generic_slide.sound'), nil, 1);
end

t_audioOneoffStaticSoundTable[ZONE_SETS.zs_02] =
{
	inside =
	{
		[VOLUMES.tv_audio_shipyard_slide] = TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_shipyard\018_vin_campaign_w4assault_shipyard_slide.sound'),

	}
};
--]]
t_audioOneoffPositionalSoundTable[ZONE_SETS.zs_02] =
{
	inside =
	{
		[VOLUMES.tv_audio_shipyard_slide] = 
			{
				soundtag = TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w4assault_shipyard\018_vin_campaign_w4assault_shipyard_slide.sound'),
				object = "silly_slide",
				marker = "",
			},
	},
};


--## CLIENT

function startupClient.AssaultMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w4_assault.sound'), nil, 1)
end