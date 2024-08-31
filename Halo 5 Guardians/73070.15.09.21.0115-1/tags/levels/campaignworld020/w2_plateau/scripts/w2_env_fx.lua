--## SERVER

--	343	//														
--	343	//				FX - Environments and Events 
--	343	//														
--	343	//	


--//=========//	Environment and Event FX //=========//



-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT, thanks in advance.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT


--// FX - Hub Campsite - Statue Falling Dust
function remoteClient.fx_hub_statue_dust_client():void
	print ("FX - Dust falling from Statue");	
	CreateEffectGroup(EFFECTS.fx_hub_camp_statue_dust_02)
	sleep_s(0.6)
	CreateEffectGroup(EFFECTS.fx_hub_camp_statue_dust_01)
end	


--// FX - Bowl Area - EMP Blast
function remoteClient.fx_emp_blast_client():void
	print ("FX - EMP Blast");	
	CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_main)
	sleep_s(0.1)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_center)
	sleep_s(0.1)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_01)
	sleep_s(0.15)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_02)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_03)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_04)
	sleep_s(0.15)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_08)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_05)
	sleep_s(0.15)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_06)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_07)
	sleep_s(0.15)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_09)
	sleep_s(0.15)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_11)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_10)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_12)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_radius_13)
	--CreateEffectGroup(EFFECTS.fx_bowl_emp_blast_main_s)
end	


--// FX - Soldier Room - Platform Sections
function remoteClient.fx_soldier_platform_client():void
	print ("FX - Steam on Platform Sections");	
end	


--// FX - Soldier Room - Floater Pieces	
function remoteClient.fx_soldier_floaters_client():void
	print ("FX - Steam on Floater Pieces");
end	


--// FX - Soldier Room - Disable Artifact Stasis
function remoteClient.fx_disable_artifact_stasis_client():void
	print ("FX - Artifact Stasis Deactivated");	
	KillEffectGroup(EFFECTS.fx_soldier_rm_artifact_stasis_beam)
	KillEffectGroup(EFFECTS.fx_soldier_rm_artifact_hold)
end	


--// FX - Soldier Teleport Room - Teleport Flash
function fx_teleport_flash_client():void
	print ("FX - Teleport Flash");

	CreateEffectGroup(EFFECTS.fx_soldier_rm_teleport_flash);
end	


--// FX - Plateau Bowl - Shoulder Bash Wall Impact
function fx_shoulder_bash_impact_client():void
	print ("FX - Shoulder Bash Wall Impact");

	CreateEffectGroup(EFFECTS.fx_bowl_shoulder_bash_wall_dust);
end	

