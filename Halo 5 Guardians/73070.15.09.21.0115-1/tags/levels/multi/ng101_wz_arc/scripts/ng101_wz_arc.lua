--// =============================================================================================================================
-- ============================================ ng101_wz_arc SCRIPTS ========================================================
-- =============================================================================================================================
--## SERVER




function cs_vtolcompstart()
	composer_play_show ("vin_warzone_arc_vtol", {vtol1 = ai_vehicle_get (ai_current_actor)});
end

function cs_loadvtolgunner()
	ai_vehicle_enter_immediate(ai_current_actor, ai_vehicle_get_from_squad(AI.hillside_boss_vtol), 'vtol_g');
end

function cs_pelican_reinforcement()
	cs_pelican_drop(nil,AI.sq_reinforcement_warthog,POINTS.ps_reinforcement_pelican, POINTS.ps_reinforcement_pelican.drop);
end

function cs_pelican_drop (ship_squad:ai, drop_squad:ai, ps:point_set, drop:point)
	ship_squad = ai_current_squad;
	
	if ship_squad == nil then
		print ("no dropship squad in function");
	end
	
	if ps == nil then
		print ("no point set specified");
		error ("you tried to call f_dropship without specifying a point set");
	end
	
	local driver:ai = ai_vehicle_get_driver(ai_vehicle_get_from_squad (ship_squad));
	local dropship:object = ai_vehicle_get_from_squad (ship_squad);
	
	--ai_place (drop_squad);
	
	--LOAD THE WARTHOG SQUAD TO THE PELICAN
	PelicanLoad (ship_squad, drop_squad);
	
	--FLY THE PELICAN TO THE POINTS
	--DROP OFF THE WARTHOG AT THE DESIGNATED SPOT
	--FLY THE REMAINDER OF THE POINTS
	--DESTROY ITSELF
	
	
	object_set_scale(dropship, 0.01, 1);
	object_cannot_die(dropship, true);
	sleep_s(1);
	object_set_scale(dropship, 1.0, seconds_to_frames (3));
	
	for i = 1, #ps do
		print ("flying to", ps[i]);
		cs_fly_by (driver, true, ps[i]);
		
		if ps[i] == drop then
			print ("unloading");
			sleep_s(0.3);
			--vehicle_hover (ai_vehicle_get_from_squad(ship_squad) , true);
	--======== DROP PASSENGERS HERE ======================
			
			PelicanDrop(ship_squad);
			
			--sleep_s(2);
			--vehicle_hover (ai_vehicle_get_from_squad(ship_squad) , false);
		end
	end
	
	object_set_scale(dropship, 0.01, (3 * n_fps()));
	sleep_s (3);
	ai_erase(ship_squad);
end

function PelicanLoad (ship_squad:ai, drop_squad:ai)
	print ("loading pelican");
	local pelican:object = ai_vehicle_get_from_squad(ship_squad);
	local warthog:object = ai_vehicle_get_from_squad(drop_squad);
	vehicle_load_magic (pelican, "pelican_lc", warthog);
end

function PelicanDrop(ship_squad:ai)
	print ("dropping pelican cargo");
	local pelican:object = ai_vehicle_get_from_squad(ship_squad);
	vehicle_unload (pelican, "pelican_lc");
end


function startup.audio_warzone_pa()

	repeat
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00100.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00100.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00100.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00100.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00200.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00200.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00200.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00200.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00300.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00300.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00300.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00300.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00400.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00400.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00400.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00400.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00500.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00500.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00500.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00500.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00600.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00600.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00600.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00600.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00700.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00700.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00700.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00700.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
		sleep_s(60);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00800.sound'), OBJECTS.audio_warzone_pa_crate_red_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00800.sound'), OBJECTS.audio_warzone_pa_crate_red_02, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00800.sound'), OBJECTS.audio_warzone_pa_crate_blue_01, 1);
		SoundImpulseStartServer(TAG('sound\001_vo\001_vo_multiplayer\001_vo_mul_elevatorpa\001_vo_mul_un_elevatorpa_warzone_paannouncement_00800.sound'), OBJECTS.audio_warzone_pa_crate_blue_02, 1);
		--print ("pa announcement");
	until false;
		
end

--## CLIENT

function startupClient.ArcMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_wz_arc.sound'), nil, 1)
end