-- FX for Sentinels


--## SERVER

--	Cryptum Shield - Activation //
function fx_cryptum_shield_activate()
RunClientScript("fx_cryptum_shield_activate");
end

--	Cryptum Shield - Deactivation //
function fx_cryptum_shield_kill()
RunClientScript("fx_cryptum_shield_kill");
end

--	Cryptum Reaction to destroyed Power Core //
function fx_cryptum_shield_reaction()
RunClientScript("fx_cryptum_core_reaction");
end

--	Vista Snow fx - Kill //
function fx_vista_snow_kill()
RunClientScript("fx_vista_snow_kill");
end

--	Vista Snow fx - Activate //
function fx_vista_snow_activate()
RunClientScript("fx_vista_snow_activate");
end




-- // END GAME Sequence //

--	End Game – Player Screen Damage State 1 - Activate //
function fx_screen_damage_01_activate()
RunClientScript("fx_screen_damage_01_activate");
end




--	End Game – Player Screen Damage State 2 - Activate //
function fx_screen_damage_02_activate()
RunClientScript("fx_screen_damage_02_activate");
end

--	End Game – Player 'Buck' Screen Damage State 2 - Activate //
function fx_buck_screen_damage_02_activate()
RunClientScript("fx_buck_screen_damage_02_activate");
end

--	End Game – Player 'Locke' Screen Damage State 2 - Activate //
function fx_locke_screen_damage_02_activate()
RunClientScript("fx_locke_screen_damage_02_activate");
end

--	End Game – Player 'Tanaka' Screen Damage State 2 - Activate //
function fx_tanaka_screen_damage_02_activate()
RunClientScript("fx_tanaka_screen_damage_02_activate");
end

--	End Game – Player 'Vale' Screen Damage State 2 - Activate //
function fx_vale_screen_damage_02_activate()
RunClientScript("fx_vale_screen_damage_02_activate");
end




--	End Game – Player Screen Damage State 3 - Activate //
function fx_screen_damage_03_activate()
RunClientScript("fx_screen_damage_03_activate");
end

--	End Game – Player 'Buck' Screen Damage State 3 - Activate //
function fx_buck_screen_damage_03_activate()
RunClientScript("fx_buck_screen_damage_03_activate");
end

--	End Game – Player 'Locke' Screen Damage State 3 - Activate //
function fx_locke_screen_damage_03_activate()
RunClientScript("fx_locke_screen_damage_03_activate");
end

--	End Game – Player 'Tanaka' Screen Damage State 3 - Activate //
function fx_tanaka_screen_damage_03_activate()
RunClientScript("fx_tanaka_screen_damage_03_activate");
end

--	End Game – Player 'Vale' Screen Damage State 3 - Activate //
function fx_vale_screen_damage_03_activate()
RunClientScript("fx_vale_screen_damage_03_activate");
end




--	End Game – Player Screen Damage State 3 Fade Out - Activate //
function fx_screen_damage_03_fadeout_activate()
RunClientScript("fx_screen_damage_03_fadeout_activate");
end

--	End Game – Player Screen Fade Dim - Activate //
function fx_screen_fade_dim_activate()
RunClientScript("fx_screen_fade_dim_activate");
end

--	End Game – Player Screen Fade Dark - Activate //
function fx_screen_fade_dark_activate()
RunClientScript("fx_screen_fade_dark_activate");
end

--	End Game – Player Screen Fade Extended - Activate //
function fx_screen_fade_extend_activate()
RunClientScript("fx_screen_fade_extend_activate");
end

--	End Game – Player Screen Fade Black Long - Activate //
function fx_screen_fade_black_long_activate()
RunClientScript("fx_screen_fade_black_long_activate");
end




--	End Game – Player Screen Damage State 1 - Deactivate //
function fx_screen_damage_01_kill()
RunClientScript("fx_screen_damage_01_kill");
end




--	End Game – Player Screen Damage State 2 - Deactivate //
function fx_screen_damage_02_kill()
RunClientScript("fx_screen_damage_02_kill");
end

--	End Game – Player 'Buck' Screen Damage State 2 - Deactivate //
function fx_buck_screen_damage_02_kill()
RunClientScript("fx_buck_screen_damage_02_kill");
end

--	End Game – Player 'Locke' Screen Damage State 2 - Deactivate //
function fx_locke_screen_damage_02_kill()
RunClientScript("fx_locke_screen_damage_02_kill");
end

--	End Game – Player 'Tanaka' Screen Damage State 2 - Deactivate //
function fx_tanaka_screen_damage_02_kill()
RunClientScript("fx_tanaka_screen_damage_02_kill");
end

--	End Game – Player 'Vale' Screen Damage State 2 - Deactivate //
function fx_vale_screen_damage_02_kill()
RunClientScript("fx_vale_screen_damage_02_kill");
end




--	End Game – Player Screen Damage State 3 - Deactivate //
function fx_screen_damage_03_kill()
RunClientScript("fx_screen_damage_03_kill");
end

--	End Game – Player 'Buck' Screen Damage State 3 - Deactivate //
function fx_buck_screen_damage_03_kill()
RunClientScript("fx_buck_screen_damage_03_kill");
end

--	End Game – Player 'Locke' Screen Damage State 3 - Deactivate //
function fx_locke_screen_damage_03_kill()
RunClientScript("fx_locke_screen_damage_03_kill");
end

--	End Game – Player 'Tanaka' Screen Damage State 3 - Deactivate //
function fx_tanaka_screen_damage_03_kill()
RunClientScript("fx_tanaka_screen_damage_03_kill");
end

--	End Game – Player 'Vale' Screen Damage State 3 - Deactivate //
function fx_vale_screen_damage_03_kill()
RunClientScript("fx_vale_screen_damage_03_kill");
end




--	End Game – Player Screen Fade Dim - Deactivate //
function fx_screen_fade_dim_kill()
RunClientScript("fx_screen_fade_dim_kill");
end

--	End Game – Player Screen Fade Dark - Deactivate //
function fx_screen_fade_dark_kill()
RunClientScript("fx_screen_fade_dark_kill");
end

--	End Game – Player Screen Fade Extended - Deactivate //
function fx_screen_fade_extend_kill()
RunClientScript("fx_screen_fade_extend_kill");
end

--	End Game – Cortana Guardian Pulse Shockwave - Scripted //
function fx_cortana_guardian_pulse()
RunClientScript("fx_cortana_guardian_pulse");
end

--	End Game – Cortana Guardian Pulse Impact - Scripted //
function fx_cortana_guardian_pulse_impact()
RunClientScript("fx_cortana_guardian_pulse_impact");
end



--## CLIENT

--	Cryptum Shield - Activation //
function remoteClient.fx_cryptum_shield_activate()
print ("FX - Cryptum Shield activated");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_innerworld\fx\cryptum\cryptum_shield.effect'), OBJECTS.hero_cryptum01, "fx_cryptum_center" );
end	

--	Cryptum Shield - Deactivation //
function remoteClient.fx_cryptum_shield_kill()
print ("FX - Cryptum Shield deactivated");
effect_kill_object_marker(TAG('levels\campaignworld030\w3_innerworld\fx\cryptum\cryptum_shield.effect'), OBJECTS.hero_cryptum01, "fx_cryptum_center" );
sleep_s(0.25)
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_innerworld\fx\cryptum\cryptum_shield_release.effect'), OBJECTS.hero_cryptum01, "fx_cryptum_center" );
end	

--	Cryptum Reaction to Destroyed Power Core //
function remoteClient.fx_cryptum_core_reaction()
print ("FX - Cryptum Reaction to destroyed Power Core");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_innerworld\fx\cryptum\cryptum_power_core_reaction.effect'), OBJECTS.hero_cryptum01, "fx_cryptum_center" );
end		

--	Vista Snow fx - Kill //
function remoteClient.fx_vista_snow_kill()
print ("FX - Kill Vista Snow");
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_01);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_02);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_03);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_04);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_05);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_06);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_07);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_08);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_09);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_10);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_11);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_12);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_16);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_17);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_18);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_19);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_20);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_21);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_22);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_23);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_24);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_27);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_29);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_35);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_40);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_41);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_42);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_43);

KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_01);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_02);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_03);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_04);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_05);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_06);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_07);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_08);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_09);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_10);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_11);

KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon01);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon02);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon03);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon04);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon05);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon06);

KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon01);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon02);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon03);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon04);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon05);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon06);

KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_01);
KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_02);
KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_03);
KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_04);
KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_05);
KillEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_06);

KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon_gust);
KillEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon_gust02);

KillEffectGroup(EFFECTS.fx_road_snow_flurry_lg_02);
KillEffectGroup(EFFECTS.fx_road_snow_flurry_lg_03);
end

--	Vista Snow fx - Activate //
function remoteClient.fx_vista_snow_activate()
print ("FX - Activate Vista Snow");
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_01);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_02);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_03);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_04);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_05);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_06);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_07);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_08);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_09);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_10);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_11);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_12);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_16);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_17);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_18);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_19);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_20);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_21);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_22);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_23);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_24);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_27);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_29);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_35);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_40);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_41);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_42);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_xlg_43);

CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_01);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_02);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_03);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_04);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_05);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_06);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_07);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_08);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_09);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_10);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_ground_xlrg_11);

CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon01);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon02);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon03);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon04);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon05);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon06);

CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon01);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon02);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon03);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon04);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon05);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon06);

CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_01);
CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_02);
CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_03);
CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_04);
CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_05);
CreateEffectGroup(EFFECTS.fx_vista_far_snow_gust_xlg_06);

CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon_gust);
CreateEffectGroup(EFFECTS.fx_vista_snow_flurry_canyon_gust02);

CreateEffectGroup(EFFECTS.fx_road_snow_flurry_lg_02);
CreateEffectGroup(EFFECTS.fx_road_snow_flurry_lg_03);
end




-- // END GAME Sequence //

--	End Game - Player Screen Damage - State 1 Activate //
function remoteClient.fx_screen_damage_01_activate()
print ("FX - Player Screen Damage - State 1 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 2 Activate //
function remoteClient.fx_screen_damage_02_activate()
print ("FX - Player Screen Damage - State 2 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Buck' Screen Damage - State 2 Activate //
function remoteClient.fx_buck_screen_damage_02_activate()
print ("FX - Player 'Buck' Screen Damage - State 2 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Locke' Screen Damage - State 2 Activate //
function remoteClient.fx_locke_screen_damage_02_activate()
print ("FX - Player 'Locke' Screen Damage - State 2 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Tanaka' Screen Damage - State 2 Activate //
function remoteClient.fx_tanaka_screen_damage_02_activate()
print ("FX - Player 'Tanaka' Screen Damage - State 2 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Vale' Screen Damage - State 2 Activate //
function remoteClient.fx_vale_screen_damage_02_activate()
print ("FX - Player 'Vale' Screen Damage - State 2 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 3 Activate //
function remoteClient.fx_screen_damage_03_activate()
print ("FX - Player Screen Damage - State 3 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Buck' Screen Damage - State 3 Activate //
function remoteClient.fx_buck_screen_damage_03_activate()
print ("FX - Player 'Buck' Screen Damage - State 3 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Locke' Screen Damage - State 3 Activate //
function remoteClient.fx_locke_screen_damage_03_activate()
print ("FX - Player 'Locke' Screen Damage - State 3 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Tanaka' Screen Damage - State 3 Activate //
function remoteClient.fx_tanaka_screen_damage_03_activate()
print ("FX - Player 'Tanaka' Screen Damage - State 3 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Vale' Screen Damage - State 3 Activate //
function remoteClient.fx_vale_screen_damage_03_activate()
print ("FX - Player 'Vale' Screen Damage - State 3 Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 3 Fade Out Activate //
function remoteClient.fx_screen_damage_03_fadeout_activate()
print ("FX - Player Screen Damage - State 3 Fade Out Activation");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03_fadeout.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Fade Dim - Activate //
function remoteClient.fx_screen_fade_dim_activate()
print ("FX - Player Screen Fade Dim - Activate");
screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_dim.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player Screen Fade Dark - Activate //
function remoteClient.fx_screen_fade_dark_activate()
print ("FX - Player Screen Fade Dark - Activate");
screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_dim_dark.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player Screen Fade Extended - Activate //
function remoteClient.fx_screen_fade_extend_activate()
print ("FX - Player Screen Fade Extended - Activate");
screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_extended.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player Screen Fade Black Long - Activate //
function remoteClient.fx_screen_fade_black_long_activate()
print ("FX - Player Screen Fade Black Long - Activate");
screen_effect_new(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_black_long.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 1 Deactivate //
function remoteClient.fx_screen_damage_01_kill()
print ("FX - Player Screen Damage - State 1 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 2 Deactivate //
function remoteClient.fx_screen_damage_02_kill()
print ("FX - Player Screen Damage - State 2 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Buck' Screen Damage - State 2 Deactivate //
function remoteClient.fx_buck_screen_damage_02_kill()
print ("FX - Player 'Buck' Screen Damage - State 2 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);


end

--	End Game - Player 'Locke' Screen Damage - State 2 Deactivate //
function remoteClient.fx_locke_screen_damage_02_kill()
print ("FX - Player 'Locke' Screen Damage - State 2 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Tanaka' Screen Damage - State 2 Deactivate //
function remoteClient.fx_tanaka_screen_damage_02_kill()
print ("FX - Player 'Tanaka' Screen Damage - State 2 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Vale' Screen Damage - State 2 Deactivate //
function remoteClient.fx_vale_screen_damage_02_kill()
print ("FX - Player 'Vale' Screen Damage - State 2 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Damage - State 3 Deactivate //
function remoteClient.fx_screen_damage_03_kill()
print ("FX - Player Screen Damage - State 3 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Buck' Screen Damage - State 3 Deactivate //
function remoteClient.fx_buck_screen_damage_03_kill()
print ("FX - Player 'Buck' Screen Damage - State 3 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Locke' Screen Damage - State 3 Deactivate //
function remoteClient.fx_locke_screen_damage_03_kill()
print ("FX - Player 'Locke' Screen Damage - State 3 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Tanaka' Screen Damage - State 3 Deactivate //
function remoteClient.fx_tanaka_screen_damage_03_kill()
print ("FX - Player 'Tanaka' Screen Damage - State 3 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player 'Vale' Screen Damage - State 3 Deactivate //
function remoteClient.fx_vale_screen_damage_03_kill()
print ("FX - Player 'Vale' Screen Damage - State 3 Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_01.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);

screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_buck_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_locke_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_tanaka_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_02.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\player_vale_screen_flashing_state_03.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end




--	End Game - Player Screen Fade Dim - Deactivate //
function remoteClient.fx_screen_fade_dim_kill()
print ("FX - Player Screen Fade Dim - Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_dim.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player Screen Fade Dark - Deactivate //
function remoteClient.fx_screen_fade_dark_kill()
print ("FX - Player Screen Fade Dark - Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_dim_dark.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Player Screen Fade Extended - Deactivate //
function remoteClient.fx_screen_fade_extend_kill()
print ("FX - Player Screen Fade Extended - Deactivate");
screen_effect_delete(TAG('levels\campaignworld030\w3_innerworld\fx\screen_effects\parts\player_visor_fade_in_out_extended.area_screen_effect'),FLAGS.fx_player_visor_screen_damage);
end

--	End Game - Cortana Guardian Pulse Shockwave - Scripted //
function remoteClient.fx_cortana_guardian_pulse()
print ("FX - Cortana Guardian Pulse Shockwave - Scripted");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_innerworld\fx\guardian\cortana_guardian_pulse_shockwave.effect'), OBJECTS.cortana_guardian02, "fx_body_core" );
end

--	End Game - Cortana Guardian Pulse Impact - Scripted //
function remoteClient.fx_cortana_guardian_pulse_impact()
print ("FX - Cortana Guardian Pulse Impact - Scripted");
CreateEffectGroup(EFFECTS.fx_endgame_guard_pulse_impact_flash_01);
end








