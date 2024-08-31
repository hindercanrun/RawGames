--## CLIENT

--Owner: Chris French
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
-- HUNTER
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------

function remoteClient.f_hunter_cl_hunter_drop_boom():void
	CreateEffectGroup(EFFECTS.fx_hunter_arrive_boom_01);
	Sleep(20);
	CreateEffectGroup(EFFECTS.fx_hunter_arrive_boom_02);
	Sleep(10);
	CreateEffectGroup(EFFECTS.fx_hunter_arrive_boom_03);
end

function remoteClient.f_hunter_cl_clean_up_tunnel_fx():void
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_01);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_02);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_03);
--	StopEffectGroup(EFFECTS.fx_tun_display_screen_04);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_05);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_06);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_07);
--	StopEffectGroup(EFFECTS.fx_tun_display_screen_08);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_09);
	--StopEffectGroup(EFFECTS.fx_tun_display_screen_10);
	
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_01);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_02);
--	StopEffectGroup(EFFECTS.fx_tun_display_spark_03);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_04);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_05);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_06);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_07);
--	StopEffectGroup(EFFECTS.fx_tun_display_spark_08);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_09);
	--StopEffectGroup(EFFECTS.fx_tun_display_spark_10);
	--StopEffectGroup(EFFECTS.fx_tun_hunter_w_1);
	--StopEffectGroup(EFFECTS.fx_tun_hunter_w_2);
	StopEffectGroup(EFFECTS.fx_tun_hunter_ceiling_sparks_01);
	StopEffectGroup(EFFECTS.fx_fall_steam_01);
	StopEffectGroup(EFFECTS.fx_fall_steam_02);
	StopEffectGroup(EFFECTS.fx_tun_top_tunnel_01);
	StopEffectGroup(EFFECTS.fx_tun_top_tunnel_02);
	StopEffectGroup(EFFECTS.fx_tun_top_tunnel_03);
	StopEffectGroup(EFFECTS.fx_tun_top_tunnel_04);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_00);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_01);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_02);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_03);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_04);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_05);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_06);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_07);
	StopEffectGroup(EFFECTS.fx_tun_breadcrumb_08);
	
	
--	StopEffectGroup(EFFECTS.fx_tun_room_08_spark_01);
	StopEffectGroup(EFFECTS.fx_tun_room_08_spark_02);
	StopEffectGroup(EFFECTS.fx_tun_room_08_steam_01);
	StopEffectGroup(EFFECTS.fx_tun_room_08_steam_02);
	
	StopEffectGroup(EFFECTS.fx_room_04_01_steam_jet_02);
	StopEffectGroup(EFFECTS.fx_room_04_02_steam_jet_02);
	StopEffectGroup(EFFECTS.fx_room_04_03_steam_jet_02);
	
	

	--StopEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_01);
	--StopEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_01);
	--StopEffectGroup(EFFECTS.fx_tun_4_sparks_fall_red_02);
	--StopEffectGroup(EFFECTS.fx_tun_sparks_fall_red_05);
	--StopEffectGroup(EFFECTS.fx_tun_sparks_fall_red_01);
end




