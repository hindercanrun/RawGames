--## CLIENT

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- Maintenance Tunnels
---------------------------------------------------------------
---------------------------------------------------------------

---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
function remoteClient.f_tun_cl_start_fx():void
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_01);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_02);
--	CreateEffectGroup(EFFECTS.fx_tun_display_screen_03);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_04);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_05);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_06);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_07);
--	CreateEffectGroup(EFFECTS.fx_tun_display_screen_08);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_09);
	--CreateEffectGroup(EFFECTS.fx_tun_display_screen_10);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_01);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_02);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_03);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_04);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_05);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_06);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_07);
--	CreateEffectGroup(EFFECTS.fx_tun_display_spark_08);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_09);
	--CreateEffectGroup(EFFECTS.fx_tun_display_spark_10);
	CreateEffectGroup(EFFECTS.fx_fall_steam_01);
	CreateEffectGroup(EFFECTS.fx_fall_steam_01);
	CreateEffectGroup(EFFECTS.fx_tun_top_tunnel_01);
	CreateEffectGroup(EFFECTS.fx_tun_top_tunnel_02);
	CreateEffectGroup(EFFECTS.fx_tun_top_tunnel_03);
	CreateEffectGroup(EFFECTS.fx_tun_top_tunnel_04);
	--CreateEffectGroup(EFFECTS.fx_tun_hunter_w_1);
	--CreateEffectGroup(EFFECTS.fx_tun_hunter_w_2);
	
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_00);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_01);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_02);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_03);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_04);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_05);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_06);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_07);
	CreateEffectGroup(EFFECTS.fx_tun_breadcrumb_08);
	
--	CreateEffectGroup(EFFECTS.fx_tun_steam_01);
--	CreateEffectGroup(EFFECTS.fx_tun_steam_02);
	
	
	
	
	

	--CreateEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_01);
	--CreateEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_01);
	--CreateEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_02);
	

end

function remoteClient.f_tun_cl_hunter_intro():void
	CreateEffectGroup(EFFECTS.fx_tun_hunter_boom_01);
	CreateEffectGroup(EFFECTS.fx_tun_hunter_boom_03);
	--CreateEffectGroup(EFFECTS.fx_tun_hunter_boom_02);
	--CreateEffectGroup(EFFECTS.fx_tun_hunter_boom_04);
	CreateEffectGroup(EFFECTS.fx_tun_hunter_debris_01);
	--CreateEffectGroup(EFFECTS.fx_tun_hunter_debris_02);
end

function remoteClient.f_tun_cl_hunter_camera_shake():void
	--( attack:number, intensity:number, duration:number, decay:number, shake_sound:tag 
	camera_shake_all_coop_players(1, 0.3, 0.08, 1);
end

function remoteClient.f_tun_cl_hunter_fall_debris():void
	--CreateEffectGroup(EFFECTS.fx_fall_debris_01);
	--CreateEffectGroup(EFFECTS.fx_fall_debris_02);
end

--function f_tun_cl_hunter_door_boom():void
--	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_09involuntary_deathmajor.sound'), 3, 1);
--	Sleep(60);
--	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_02combat_shoot.sound'), 3, 1);
--	Sleep(120);
--	CreateEffectGroup(EFFECTS.fx_tun_door_blast_02);
--	Sleep(60);
--	CreateEffectGroup(EFFECTS.fx_tun_door_blast_03);
--	Sleep(30);
--	CreateEffectGroup(EFFECTS.fx_tun_door_blast_01);
--	CreateEffectGroup(EFFECTS.fx_tun_sparks_fall_red_05);
--end

function remoteClient.f_tun_cl_hunter_grenade_line():void
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt01\001_vo_ai_cv_grunt01_01contact_seefoe.sound'), 3, 1);
	Sleep(60);
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt01\001_vo_ai_cv_grunt01_02combat_throwgrenade.sound'), 3, 1);
end


--sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt01\001_vo_ai_cv_grunt01_02combat_flee.sound'), 3, 1);




function remoteClient.f_tun_cl_hunter_grenade_4():void
	CreateEffectGroup(EFFECTS.fx_tun_gren_ex_04);
	Sleep(15);
	StopEffectGroup(EFFECTS.fx_tun_gren_ex_04);

end

function remoteClient.f_tun_cl_hunter_floor_bash_01():void
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_smash_02);
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_09involuntary_deathmajor.sound'), 3, 1);
	Sleep(80)
	StopEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
end

function remoteClient.f_tun_cl_hunter_floor_bash_01_05():void
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_smash_01);
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_09involuntary_deathmajor.sound'), 3, 1);
	Sleep(80)
	StopEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
end

function remoteClient.f_tun_cl_hunter_floor_bash_02():void
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_smash_03);
	--Sleep(60);
	CreateEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_09involuntary_deathmajor.sound'), 3, 1);
	
	StopEffectGroup(EFFECTS.fx_fall_steam_01);
	StopEffectGroup(EFFECTS.fx_fall_steam_02);
end


function remoteClient.f_tun2_cl_hunter_yells():void
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_09involuntary_deathmajor.sound'), 3, 1);
	Sleep(60);
	sound_impulse_start_3d(TAG('sound\001_vo\001_vo_ai\001_vo_ai_hunter01\001_vo_ai_cv_hunter01_02combat_shoot.sound'), 3, 1);
end


function remoteClient.f_tun_cl_flock_player_01():void
	flock_create("f_p1_worm_01");
	Sleep(4);
	flock_start("f_p1_worm_01");
	Sleep(60);
	flock_stop("f_p1_worm_01");
end

function remoteClient.f_tun_cl_flock_player_02():void
	flock_create("f_p1_worm_02");
	Sleep(4);
	flock_start("f_p1_worm_02");
	Sleep(60);
	flock_stop("f_p1_worm_02");
end

function remoteClient.f_tun_cl_flock_player_03():void
	flock_create("f_p1_worm_03");
	Sleep(4);
	flock_start("f_p1_worm_03");
	Sleep(60);
	flock_stop("f_p1_worm_03");
end

function remoteClient.f_tun_cl_flock_player_04():void
	flock_create("f_p1_worm_04");
	Sleep(4);
	flock_start("f_p1_worm_04");
	Sleep(60);
	flock_stop("f_p1_worm_04");
end

function remoteClient.f_tun_cl_flock_worm_window_01():void
	flock_create("f_worm_window_01");
	Sleep(4);
	flock_start("f_worm_window_01");
	Sleep(60);
	flock_stop("f_worm_window_01");
end

function remoteClient.f_tun_cl_flock_f_room_06():void
	flock_create("f_room_06");
	Sleep(4);
	flock_start("f_room_06");
	Sleep(60);
	flock_stop("f_room_06");
end

function remoteClient.f_tun_cl_flock_worm_hunter_smash():void
	flock_create("f_worm_hunter_smash");
	Sleep(4);
	flock_start("f_worm_hunter_smash");
	Sleep(60);
	flock_stop("f_worm_hunter_smash");
end

function remoteClient.f_tun_cl_flock_pre_armada():void
	flock_create("f_pre_armada");
	Sleep(4);
	flock_start("f_pre_armada");
	Sleep(60);
	flock_stop("f_pre_armada");
end

function remoteClient.f_tun_cl_flock_post_armada_01():void
	flock_create("f_post_armada_01");
	Sleep(4);
	flock_start("f_post_armada_01");
	Sleep(60);
	flock_stop("f_post_armada_01");
end

function remoteClient.f_tun_cl_flock_post_armada_02():void
	flock_create("f_post_armada_02");
	Sleep(4);
	flock_start("f_post_armada_02");
	Sleep(60);
	flock_stop("f_post_armada_02");
end

function remoteClient.f_tun_cl_flock_pre_hunter_room_01():void
	flock_create("f_pre_hunter_room_01");
	Sleep(4);
	flock_start("f_pre_hunter_room_01");
	Sleep(60);
	flock_stop("f_pre_hunter_room_01");
end

function remoteClient.f_tun_cl_flock_pre_hunter_room_02():void
	flock_create("f_pre_hunter_room_02");
	Sleep(4);
	flock_start("f_pre_hunter_room_02");
	Sleep(60);
	flock_stop("f_pre_hunter_room_02");
end

function remoteClient.f_tun_cl_flock_pre_hunter_room_03():void
	flock_create("f_pre_hunter_room_03");
	Sleep(4);
	flock_start("f_pre_hunter_room_03");
	Sleep(60);
	flock_stop("f_pre_hunter_room_03");
end

--function f_tun_cl_elite_roar():void
--	cs_custom_animation(AI.sq_tun_room_11_02.elite_01, true, TAG('objects\characters\elite\elite.model_animation_graph'), "any:go_berserk", false);
--end