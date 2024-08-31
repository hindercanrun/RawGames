--## SERVER

--	343	//														
--	343	//				FX - Sentry Vignettes 
--	343	//														
--	343	//	




--//=========//	Sentry Reveal (liftoff) Vignette FX //=========//


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT, thanks in advance.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT
function remoteClient.fx_kraken_vista_smoke():void
	print ("Kraken vista smoke");
	CreateEffectGroup(EFFECTS.kraken_vista_smoke)
end	

function remoteClient.fx_sentry_reveal_destruction_01_client():void
	print ("FX - Sentry Reveal Destruction - Stage 1");
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_05)
	sleep_s(0.5)
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_04)
	sleep_s(1)
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_01)
	sleep_s(0.48)
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_03)
	sleep_s(1.16)
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_02)
end	
function remoteClient.fx_sentry_reveal_destruction_02_client():void
	print ("FX - Sentry Reveal Destruction - Stage 02");
	CreateEffectGroup(EFFECTS.fx_sr_int_falling_debris_06)
	sleep_s(0.5)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_10)
	sleep_s(1.2)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_11)
	sleep_s(0.55)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_12)
end	
function remoteClient.fx_sentry_reveal_destruction_03_client():void
	print ("FX - Sentry Reveal Destruction - Stage 03");
	CreateEffectGroup(EFFECTS.fx_sr_impact_xlg_01)
	CreateEffectGroup(EFFECTS.fx_sr_impact_debris_05)
	sleep_s(0.1)
	CreateEffectGroup(EFFECTS.fx_sr_impact_debris_06)
	sleep_s(0.2)
	CreateEffectGroup(EFFECTS.fx_sr_impact_xlg_02)
	CreateEffectGroup(EFFECTS.fx_sr_impact_debris_04)
	sleep_s(0.35)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_01)
	sleep_s(0.7)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_03)
	sleep_s(1.2)
	CreateEffectGroup(EFFECTS.fx_sr_impact_debris_01)
	sleep_s(0.6)
	CreateEffectGroup(EFFECTS.fx_sr_impact_debris_07)
	sleep_s(0.48)
	CreateEffectGroup(EFFECTS.fx_sr_falling_debris_02)
end
function remoteClient.fx_sentry_reveal_destruction_01_client_remove():void	-- 12/26/2014 tjp
	print ("KILL FX - Sentry Reveal Destruction - Stage 1");
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_05);
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_04);
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_01);
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_03);
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_02);
	Sleep(2);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_05);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_04);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_01);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_03);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_02);
end	
function remoteClient.fx_sentry_reveal_destruction_02_client_remove():void	-- 12/26/2014 tjp
	print ("KILL FX - Sentry Reveal Destruction - Stage 02");
	StopEffectGroup(EFFECTS.fx_sr_int_falling_debris_06)
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_10);
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_11);
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_12);
	Sleep(2);
	KillEffectGroup(EFFECTS.fx_sr_int_falling_debris_06)
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_10);
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_11);
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_12);
end	
function remoteClient.fx_sentry_reveal_destruction_03_client_remove():void	-- 12/26/2014 tjp
	print ("KILL FX - Sentry Reveal Destruction - Stage 03");
	StopEffectGroup(EFFECTS.fx_sr_impact_xlg_01);
	StopEffectGroup(EFFECTS.fx_sr_impact_debris_05);
	StopEffectGroup(EFFECTS.fx_sr_impact_debris_06);
	StopEffectGroup(EFFECTS.fx_sr_impact_xlg_02);
	StopEffectGroup(EFFECTS.fx_sr_impact_debris_04);
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_01);
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_03);
	StopEffectGroup(EFFECTS.fx_sr_impact_debris_01);
	StopEffectGroup(EFFECTS.fx_sr_impact_debris_07);
	StopEffectGroup(EFFECTS.fx_sr_falling_debris_02);
	Sleep(2);
	KillEffectGroup(EFFECTS.fx_sr_impact_xlg_01);
	KillEffectGroup(EFFECTS.fx_sr_impact_debris_05);
	KillEffectGroup(EFFECTS.fx_sr_impact_debris_06);
	KillEffectGroup(EFFECTS.fx_sr_impact_xlg_02);
	KillEffectGroup(EFFECTS.fx_sr_impact_debris_04);
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_01);
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_03);
	KillEffectGroup(EFFECTS.fx_sr_impact_debris_01);
	KillEffectGroup(EFFECTS.fx_sr_impact_debris_07);
	KillEffectGroup(EFFECTS.fx_sr_falling_debris_02);
end



-- tjp: moved here from main .lua

function remoteClient.fx_dmg_steam():void
	print ("Play fx_dmg_steam FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_027");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_026");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_025");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_024");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_023");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_022");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_021");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_020");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_019");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_012");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_013");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_014");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_015");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_016");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_017");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_018");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_028");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_029");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_030");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_031");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_032");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_033");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_034");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_035");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_036");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_037");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_038");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_039");
end

function remoteClient.fx_dmg_steam_mid():void
	print ("Play fx_dmg_steam_mid FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_033");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_032");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_031");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_030");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_012");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_013");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_014");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_015");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_016");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_017");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_018");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_019");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_020");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_021");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_022");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_023");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_024");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_025");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_026");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_027");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_028");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_029");
end

function remoteClient.fx_dmg_steam_mid_lower():void
	print ("Play fx_dmg_steam_mid_lower FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_038");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_037");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_036");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_035");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_034");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_033");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_032");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_031");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_030");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_012");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_013");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_014");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_015");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_016");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_017");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_018");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_019");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_020");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_021");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_022");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_023");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_024");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_025");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_026");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_027");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_028");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_mid_lower_029");
end

function remoteClient.fx_dmg_steam_lower():void
	print ("Play fx_dmg_steam_lower FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_022");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_021");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_019");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_018");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_017");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_016");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_015");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_014");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_013");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_012");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_lg.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_steam_md.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_steam_lower_020");
end


--/////////////// sparks FX ///////////////////
function remoteClient.fx_dmg_sparks():void
	print ("Play fx_dmg_sparks FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_022");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_017");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_016");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_015");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_014");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_013");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_012");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_018");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_019");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_020");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_021");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_023");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_024");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_025");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_026");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_027");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_028");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_029");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_030");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_031");
end

function remoteClient.fx_dmg_sparks_mid():void
	print ("Play fx_dmg_sparks_mid FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_mid_011");
end

function remoteClient.fx_dmg_sparks_lower():void
	print ("Play fx_dmg_sparks_lower FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_01");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_light.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_011");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_internal_damage_pop_heavy.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_sparks_lower_012");
end


--/////////////// smoke FX ///////////////////

function remoteClient.fx_dmg_smoke():void
	print ("Play fx_dmg_smoke FX");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_010");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_09");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_08");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_07");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_06");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_05");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_04");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_03");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_02");
	effect_new_on_object_marker(TAG('levels\campaignworld020\w2_plateau\fx\sentryship_destruction\boss_ss_smoke.effect'), OBJECTS.vin_sent_machine_2, "fx_dmg_smoke_01");
end

function remoteClient.fx_initiate_lightning_on_core_rings_clients():void
	print ("Play lightning FX on Sentry Ship Ring");
	-- start Lightning on rings
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn01")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn02")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn03")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn04")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn05")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn06")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn07")
	effect_new_on_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn08")
end

function remoteClient.fx_derez_sentry_ship_core_clients():void
	print ("Play fx_derez_sentry_ship_core FX new tacos 9000");
	-- derez ring
	object_dissolve_from_marker( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_2"), "phase_out", "fx_derez_core_center");
	-- shut off Lightning on ring
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn01")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn02")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn03")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn04")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn05")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn06")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn07")
	effect_kill_object_marker(TAG('levels\assets\osiris\props\generic_covenant\cov_sentry_ship\cov_sentry_ship_core_control\fx\fx_sentryship_ring_electricity.effect'), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "fx_lgtn08")
end
function remoteClient.deres_shield_clients():void
	object_dissolve_from_marker(OBJECTS.keyhole_shield_1, "phase_out", "tj_smells");
end
