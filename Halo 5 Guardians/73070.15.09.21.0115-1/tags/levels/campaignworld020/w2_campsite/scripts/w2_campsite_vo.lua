--## SERVER

--GLOBAL VARIABLES

--
----  ================================================================================================================================
----   ______ .______       __  .___________.   .______      ___   .___________. __    __  
----  /      ||   _  \     |  | |           |   |   _  \    /   \  |           ||  |  |  | 
---- |  ,----'|  |_)  |    |  | `---|  |----`   |  |_)  |  /  ^  \ `---|  |----`|  |__|  | 
---- |  |     |      /     |  |     |  |        |   ___/  /  /_\  \    |  |     |   __   | 
---- |  `----.|  |\  \----.|  |     |  |        |  |     /  _____  \   |  |     |  |  |  | 
----  \______|| _| `._____||__|     |__|        | _|    /__/     \__\  |__|     |__|  |__| 
----  **CRIT PATH**
----  ================================================================================================================================


--[========================================================================[
          Ext. Level start

          HALSEY PIPs in
--]========================================================================]
global W2Hub1stVisit_Ext__Level_start = {
	name = "W2Hub1stVisit_Ext__Level_start",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Guns down, Osiris. We're guests here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_00800.sound'),
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						moniker = "Halsey",
			sleepBefore = 1,
			text = "Locke, I have a briefing prepared. Given Cortana's show of power, I am reluctant to discuss it over open channels.",
						tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_01500.sound'),
		},
		[3] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Understood, Doctor. We're on our way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02000.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				print ("report to halsey");
				
				return;
			end,
		},
---           PIP ends

	},

	OnFinish = function (thisConvo, queue)
	CreateThread(nar_camp_no_chatter_zone);
	CreateThread(nar_camp_turn_chatter_on);
		hud_hide_radio_transmission_hud();
		--[[]]
		--CreateThread(W2HubHalseyAfterVO);
	end,

	localVariables = {},
};
 
 global W2Hub1stVisit_Ext__Scouts_at_entrance = {
	name = "W2Hub1stVisit_Ext__Scouts_at_entrance",
CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_guards_scouts.sp_speaker_left) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_guards_scouts.sp_speaker_left)) < 3 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_guards_scouts.sp_speaker_left, -- GAMMA_CHARACTER: elite02
			text = "[Dismissive snort]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};



global HalseyNearby = {
	name = "HalseyNearby",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Halsey");
		CreateThread(HalseyWave);
	end,

	lines = {
		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_before == 0 ;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		  						moniker = "Halsey",
			--un comment this when pip gets in
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			
			text = "over here, Osiris",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_00100.sound'),
		},
		[2] = {

		If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_receptacle.sp_halsey)) < 8 ) and n_halsey_approach_before == 0 ; -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You found a way to activate the Guardian? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_receptacle.sp_halsey)) < 8 ) and n_halsey_approach_before == 0 ; -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "You have something for us, ma'am? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_receptacle.sp_halsey)) < 8 ) and n_halsey_approach_before == 0 ; -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris reporting in, Doctor Halsey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01400.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_receptacle.sp_halsey)) < 8 ) and n_halsey_approach_before == 0 ; -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Orders, ma'am?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01700.sound'),
		},
			[6] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_before == 1 ;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: HalSEY
			text = "Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_01700.sound'),
		},
		[7] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_before == 2 ;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Listen up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_01800.sound'),
		},
		[8] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_before == 3 ;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "About time you got here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_01900.sound'),
		},
		[9] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_before == 4 ;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "I have a job for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_02000.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
		if n_halsey_approach_before == 0 then
			n_halsey_approach_before = 1;
		elseif n_halsey_approach_before == 1 then
			n_halsey_approach_before = 2;
		elseif n_halsey_approach_before == 2 then
			n_halsey_approach_before = 3;
		elseif n_halsey_approach_before == 3 then
			n_halsey_approach_before = 4;
		elseif n_halsey_approach_before == 4 then
			n_halsey_approach_before = 5;
		end;
	end,

	--localVariables = {},
};

function HalseyWave()
	b_halsey_wave = true;
	Sleep(2);
	b_halsey_wave = false;
end


global HalseyReportConversation = {
	name = "HalseyReportConversation",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Halsey Report Conversation");
		CreateThread(nar_turn_off_interact);
		--tell the composition to continue
		--gmu -- I don't like this, I'd like to make this more foolproof
		b_halsey_wake = true;
	end,

	lines = {
		
		[1] = {

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		  						moniker = "Halsey",
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "This is a Constructor, a Forerunner tool I can use to interface with the Guardian. \r\n ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_00200.sound'),
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		  						moniker = "Halsey",
			sleepBefore = 0.5,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: HalSEY
			text = "Constructors were ubiquitous in Forerunner facilities. These hills are riddled with support stations for the Sanghelios Guardian.\r\n ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_00300.sound'),
		},
		[3] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		  						moniker = "Halsey",
			sleepBefore = 0.5,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Palmer has the coordinates of one such station. Finding a Constructor there should be simple.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_00400.sound'),
			},


	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
			b_halsey_scene_played = true;
		b_TalkedToHalsey = true;
		CreateThread(nar_turn_on_interact);
		CreateThread(nar_camp_turn_chatter_back_on);
	end,

	--localVariables = {},
};

global HalseyAfterConversation = {
	name = "HalseyAfterConversation",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Halsey after");
				CreateThread (HalseyWave2);
		
		
	end,

	lines = {
		
		[1] = {
									If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_after == 0 ;
			end,

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "There's nothing more you can do from here.  Head out. \r\n ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_00900.sound'),
		},

		
		[2] = {
									If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_after == 1 ;
			end,
			
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
	text = "Get moving, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_02100.sound'),
		},
	[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_after == 2 ;
			end,
			
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "You're wasting time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_02200.sound'),
		},
	[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_after == 3 ;
			end,
			
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "You're wasting time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_02200.sound'),
		},
	[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_halsey_approach_after == 4 ;
			end,
			
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "You're wasting time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_halsey_02200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		if n_halsey_approach_after == 0 then
			n_halsey_approach_after = 1;
		elseif n_halsey_approach_after == 1 then
			n_halsey_approach_after = 2;
		elseif n_halsey_approach_after == 2 then
			n_halsey_approach_after = 3;
		elseif n_halsey_approach_after == 3 then
			n_halsey_approach_after = 4;
		elseif n_halsey_approach_after == 4 then
			n_halsey_approach_after = 5;
		end;
				hud_hide_radio_transmission_hud();
		b_TalkedToHalsey = true;
		CreateThread(nar_camp_turn_chatter_back_on);
	end,

	--localVariables = {},
};


function HalseyWave2()
	b_halsey_wave2 = true;
	Sleep(2);
	b_halsey_wave2 = false;
end


-- PALMER

global PalmerNotReadyVo= {
	name = "PalmerNotReadyVo",

--	CanStart = function (thisConvo, queue)
--		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_palmer.sp_palmer)) < 6 and b_spoke_with_halsey == false; -- GAMMA_CONDITION
--	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "PalmerNotReadyVo");
		CreateThread(PalmerWave);
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_show_radio_transmission_hud("palmer_transmission_name");
					hud_set_radio_transmission_team_string_id("unscteam_transmission_name");
				hud_set_radio_transmission_portrait_index(10);
			end,
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: PalMER
			text = "Osiris. Been briefed by Halsey already? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_palmer_00100.sound'),
		},
		
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_palmer, SPARTANS.vale); -- GAMMA_TRANSITION: If VALE
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We'll check in with her right away.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02300.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
			[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_palmer, SPARTANS.locke); -- GAMMA_TRANSITION: If VALE
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Not yet, commander. I'll talk to her asap.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02100.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
--           If VALE

--           If TANAKA

		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_palmer, SPARTANS.tanaka); -- GAMMA_TRANSITION: If VALE
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Not yet, commander. Just headed over.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_02000.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
--           If BUCK

		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_palmer, SPARTANS.buck); -- GAMMA_TRANSITION: If VALE
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sorry, commander. Knew I forgot to do something.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01700.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},


	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
				CreateThread(nar_camp_turn_chatter_back_on);
	end,

	--localVariables = {},
};

function PalmerWave()
	b_palmer_wave = true;
	Sleep(2);
	b_palmer_wave = false;
end


global PalmerReadyVo= {
	name = "PalmerReadyVo",

--	CanStart = function (thisConvo, queue)
--		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_palmer.sp_palmer)) < 6 and b_spoke_with_halsey == true; -- GAMMA_CONDITION
--	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "PalmerReadyVo");
		CreateThread(PalmerWave2);
	end,

	lines = {
	
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_show_radio_transmission_hud("palmer_transmission_name");
					hud_set_radio_transmission_team_string_id("unscteam_transmission_name");
				hud_set_radio_transmission_portrait_index(10);
			end,
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "Ready when you are, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_palmer_00300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
				CreateThread(nar_camp_turn_chatter_back_on);
	end,

	--localVariables = {},
};

function PalmerWave2()
	b_palmer_wave2 = true;
	Sleep(2);
	b_palmer_wave2 = false;
end


global PalmerPelicanStart= {
	name = "PalmerPelicanStart",

	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "PalmerPelicanStart");
		--set the palmer composition to continue
		b_palmer_wake=true;
	end,

	lines = {
			[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_palmer.sp_palmer)) < 3 ); -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "We're ready, Commander Palmer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02200.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If VALE

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_palmer.sp_palmer)) < 3 ); -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We're all set here, Commander Palmer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02400.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If TANAKA

		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_palmer.sp_palmer)) < 3 ); -- GAMMA_TRANSITION: If masterchief
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Ready to move, Commander Palmer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_02100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If BUCK

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_palmer.sp_palmer)) < 3 ); -- GAMMA_TRANSITION: If masterchief
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We're ready, Commander Palmer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_show_radio_transmission_hud("palmer_transmission_name");
					hud_set_radio_transmission_team_string_id("unscteam_transmission_name");
				hud_set_radio_transmission_portrait_index(10);
			end,
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: PALMER
			text = "Okay let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_palmer_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	--localVariables = {},
};


--
---- ===============================================================================================
---- ____    __    ____  ___    __    __   __    __  .______        ______   ______    __    __  .______       __   _______ .______          _______.
---- \   \  /  \  /   / |__ \  |  |  |  | |  |  |  | |   _  \      /      | /  __  \  |  |  |  | |   _  \     |  | |   ____||   _  \        /       |
----  \   \/    \/   /     ) | |  |__|  | |  |  |  | |  |_)  |    |  ,----'|  |  |  | |  |  |  | |  |_)  |    |  | |  |__   |  |_)  |      |   (----`
----   \            /     / /  |   __   | |  |  |  | |   _  <     |  |     |  |  |  | |  |  |  | |      /     |  | |   __|  |      /        \   \    
----    \    /\    /     / /_  |  |  |  | |  `--'  | |  |_)  |    |  `----.|  `--'  | |  `--'  | |  |\  \----.|  | |  |____ |  |\  \----.----)   |   
----     \__/  \__/     |____| |__|  |__|  \______/  |______/      \______| \______/   \______/  | _| `._____||__| |_______|| _| `._____|_______/    
---- **W2 HUB COURIERS (crazy James stuff)**
---- ===============================================================================================
--
--
---- =================================================================================================       
----   _______  __        ______   .______        ___       __          _______.
----  /  _____||  |      /  __  \  |   _  \      /   \     |  |        /       |
---- |  |  __  |  |     |  |  |  | |  |_)  |    /  ^  \    |  |       |   (----`
---- |  | |_ | |  |     |  |  |  | |   _  <    /  /_\  \   |  |        \   \    
---- |  |__| | |  `----.|  `--'  | |  |_)  |  /  _____  \  |  `----.----)   |   
----  \______| |_______| \______/  |______/  /__/     \__\ |_______|_______/    
---                                                                                                                                       
-- *** GLOBALS ***
--- =================================================================================================                                                                                                                                           

--- ================= --
-- User Content Data --
--- ================= --


--- Destination Node Data
global destination_node:table = {
	-- Character References
	takerCharacter = AI.sq_couriers.sp_hub_elite,
	
	-- Flags
	isInDiscussion = false,	-- SET/UNSET BY CODE : TRUE - Taker is in a convo ; FALSE - convo ended
};


--- Source Nodes Data
global source_nodes:table = {

--- Wraiths
-------------
	wraiths = {
		courierCharacter = AI.sq_couriers.sp_wraith,
		giverCharacter = AI.sq_couriers.sp_wraith_elite,

		isGiverInDiscussion = false,	-- SET/UNSET BY CODE : TRUE - Giver is in a convo ; FALSE - convo ended
		isCourierAtSource = false,		-- UNSET BY CODE : TRUE - Courier has reached Source Node ; FALSE - Courier has left Source Node
		isCourierAtDestination = false,	-- UNSET BY CODE : TRUE - Courier has reached Destination Node ; FALSE - Courier has left Destination Node
	},
	
--- Quartermaster (Living Fallen)
----------------------------------
	quartermaster = {
		courierCharacter = AI.sq_couriers.sp_livingfallen,
		giverCharacter = AI.sq_couriers.sp_lf_elite,

		isGiverInDiscussion = false,
		isCourierAtSource = false,
		isCourierAtDestination = false,
	},

--- Medical --
	medical = {
		-- Character References
		courierCharacter = AI.sq_couriers.sp_medical,
		giverCharacter = AI.sq_couriers.sp_medic_elite,
		
		-- Flags
		isGiverInDiscussion = false,
		isCourierAtSource = false,
		isCourierAtDestination = false,
	},

--- Arbiter --
	arbiter = {
		-- Character References
		courierCharacter = AI.sq_couriers.sp_arbiter,
		giverCharacter = AI.sq_couriers.sp_arbiter_elite,
		
		-- Flags
		isGiverInDiscussion = false,
		isCourierAtSource = false,
		isCourierAtDestination = false,
	},

--- Banshee Nest --
	banshee = {
		-- Character References
		courierCharacter = AI.sq_couriers.sp_banshee,
		giverCharacter = AI.sq_couriers.sp_banshee_elite,
		
		-- Flags
		isGiverInDiscussion = false,
		isCourierAtSource = false,
		isCourierAtDestination = false,
	},

--- Halsey --
	halsey = {
		-- Character References
		courierCharacter = AI.sq_receptacle.sp_courier,
		giverCharacter = AI.sq_receptacle.sp_halsey,
		
		-- Flags
		isGiverInDiscussion = false,
		isCourierAtSource = false,
		isCourierAtDestination = false,
	},

};


--- News Items
global courierNewsItems:table = {

--- Wraiths
-------------
	wraiths = {
		-- News Item 1
		{
			source = {
				text = "These Wraiths need fresh plasma charges.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_00700.sound'),
			},
			destination = {
				text = "Wraith plasma needs refreshment.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01700.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "Some of this plating is coming loose. The bolts are shearing off. We need another shipment.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_00800.sound'),
			},
			destination = {
				text = "Wrath armors are loose, so get some bolts.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01800.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "I need more starters. I've been idling these Wraith cannons to keep them cycling.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_00900.sound'),
			},
			destination = {
				text = "The head mechanic orders some starters.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01900.sound'),
			},
		},
	},

--- Quartermaster (Living Fallen)
----------------------------------
	quartermaster = {
		-- News Item 1
		{
			source = {
				text = "Supplies delayed. Rations will be late.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite04_00600.sound'),
			},
			destination = {
				text = "Supply says rations will be late. AGAIN.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02000.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "Carbine crate missing from shipment. Must have been 'Mdama loyalists.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite04_00700.sound'),
			},
			destination = {
				text = "Supply says we didn't get a crate of guns.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02100.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "Nearly out of Unggoy infusions.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite04_00800.sound'),
			},
			destination = {
				text = "Unggoy infusions are almost gone ... Wait, UNGGOY INFUSIONS ARE ALMOST GONE?!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02200.sound'),
			},
		},
	},


--- Medical --
	medical = {
		-- News Item 1
		{
			-- Giver's news line here
			source = {
				text = "We need more disinfectant!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite02_02600.sound'),
			},

			-- Courier's delivery line here
			destination = {
				text = "Medics saying to order more disinfecters!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00200.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "My patients need a place to recuperate. We require more beds.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06200.sound'),
			},
			destination = {
				text = "Medical tent wants to have some more cots.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00300.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "We have treated many plasma burns. If this continues, we will require a burn specialist!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite03_01600.sound'),
			},
			destination = {
				text = "The medics really want another medic who is a burn person.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00400.sound'),
			},
		},
		-- News Item 4
		{
			source = {
				text = "We will need another shipment of modified biofoam!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite03_01700.sound'),
			},
			destination = {
				text = "Medical tent needs more biofroth!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00500.sound'),
			},
		},
	},


 -- Arbiter --
	arbiter = {
		-- News Item 1
		{
			source = {
				text = "Arbiter wishes supplies routed through the north caverns.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ArbiterAdvisor01_00100.sound'),
			},
			destination = {
				text = "Arbiter says take things through the north caverns!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00600.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "Intel reports 'Mdama's forces are weakening but holding position.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ArbiterAdvisor01_00200.sound'),
			},
			destination = {
				text = "'Mdama's forces are weak and holding position!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00700.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "Next watch is up, rotate the sentries.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ArbiterAdvisor01_00300.sound'),
			},
			destination = {
				text = "The sentries should all face the other way!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00800.sound'),
			},
		},
		-- News Item 4
		{
			source = {
				text = "We're moving our troops into the third quadrant.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ArbiterAdvisor01_00400.sound'),
			},
			destination = {
				text = "Troops are moving into a different quadrant!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00900.sound'),
			},
		},
		-- News Item 5
		{
			source = {
				text = "The eastern cavern perimeter is secure.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ArbiterAdvisor01_00500.sound'),
			},
			destination = {
				text = "Eastern cavern has a very good perimeter.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01000.sound'),
			},
		},
	},

--- Banshee Nest
	banshee = {
		-- News Item 1
		{
			source = {
				text = "This datapad shorted out. I'll need a replacement.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite03_01800.sound'),
			},
			destination = {
				text = "Banshee mechanic datapad is too short, needs a different one.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01400.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "We could always use more armor plating for the Banshees.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite03_01900.sound'),
			},
			destination = {
				text = "Banshee mechanics want another plate of armor.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01500.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "The Banshees are doing well and will be ready to fly when the Arbiter needs them.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite03_02000.sound'),
			},
			destination = {
				text = "Banshees reporting as very good, in flying shape.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_01600.sound'),
			},
		},
	},


	-- Halsey
-------------
	halsey = {
		-- News Item 1
		{
			source = {
				text = "These fusion beams are almost completely degraded. I'll need a new array to calibrate the Receptacle.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_UN_Halsey_00500.sound'),
			},
			destination = {
				text = "Old science human needs a fusion beam to calibrate something.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02300.sound'),
			},
		},
		-- News Item 2
		{
			source = {
				text = "Stop bothering me, Grunt! I have work to do!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_UN_Halsey_00600.sound'),
			},
			destination = {
				text = "Old science human says to stop bothering her!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02400.sound'),
			},
		},
		-- News Item 3
		{
			source = {
				text = "Those idling Wraith cannons are interfering with our energy readings.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_UN_Halsey_00700.sound'),
			},
			destination = {
				text = "Lizard woman says Wraith cannons are messing up readings!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02500.sound'),
			},
		},
		-- News Item 4
		{
			source = {
				text = "Nothing to report.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_UN_Halsey_00800.sound'),
			},
			destination = {
				text = "Security alert! I think somebody stole the old science human's arm!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_02600.sound'),
			},
		},
	},



	--[[ -- EXAMPLE ENTRY --
	ROUTE NAME HERE = {
		-- News Item 1
		{
			-- Giver's news line here
			source = {
				text = "LINE_TEXT_HERE",
				tag = VO_TAG_HERE,
			},

			-- Courier's delivery line here
			destination = {
				text = "LINE_TEXT_HERE",
				tag = VO_TAG_HERE,
			},
		},
	},
--]]
};


--- Random Courier Greets
global randomCourierGreets:table = {
	{
		text = "Ready for report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Grunt03_00100.sound'),
	},
	{
		text = "You, report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_02700.sound'),
	},
	{
		text = "Report up!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_02800.sound'),
	},
	{
		text = "Ready to take report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_02900.sound'),
	},
	{
		text = "Any new info?",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03000.sound'),
	},
	{
		text = "Anything important happening?",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03100.sound'),
	},
	{
		text = "Give me a report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03200.sound'),
	},
	{
		text = "I'll take your report now!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03300.sound'),
	},
	{
		text = "Give me updates!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03400.sound'),
	},
	{
		text = "Anything we need to know?",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03500.sound'),
	},
	{
		text = "Report time!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03600.sound'),
	},
	{
		text = "Here to take report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03700.sound'),
	},
	{
		text = "Station report!",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03800.sound'),
	},
	{
		text = "Status report?",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_grunt03_03900.sound'),
	},
};


--- Random Taker Goodbyes
global randomTakerGoodbyes:table = {
	{
		text = "Affirmative.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_00600.sound'),
	},
	{
		text = "Copy.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01000.sound'),
	},
	{
		text = "Copy that.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01100.sound'),
	},
	{
		text = "Received.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01200.sound'),
	},
	{
		text = "Aye aye.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01300.sound'),
	},
	{
		text = "Good.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01400.sound'),
	},
	{
		text = "Yes, fine.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01500.sound'),
	},
	{
		text = "Yes, next?",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01600.sound'),
	},
	{
		text = "I hear you.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01700.sound'),
	},
	{
		text = "Don't mumble, unggoy.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01800.sound'),
	},
	{
		text = "Message received.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_01900.sound'),
	},
	{
		text = "All right.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02000.sound'),
	},
	{
		text = "Message logged.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02100.sound'),
	},
	{
		text = "Got it.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02200.sound'),
	},
	{
		text = "Yes, yes.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02300.sound'),
	},
	{
		text = "Noted.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02400.sound'),
	},
	{
		text = "All right, got it.",
		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_Elite05_02500.sound'),
	},
};



---- ====================== --
---- !! END OF USER DATA !! --
---- ====================== --




--- =============================== --
-- Courier Behavior Control System --
--- =============================== --

function StartAllCourierRoutes()
	for name, sourceNode in pairs(source_nodes) do
		CreateCourierSourceConvo(sourceNode, courierNewsItems[name], name);
		NarrativeQueue.QueueConversation(sourceNode.sourceConvo);
	end
end


function PickRandomItemFromTable(availableTable, usedTable)
	-- Reset the tables if necessary
	if (#availableTable == 0) then
		for key, value in pairs(usedTable) do
			availableTable[key] = value;
			usedTable[key] = nil;
		end
	end

	local randomIndex = math.random(#availableTable);
	local item = availableTable[randomIndex];

	-- Maintain continuous, numeric indices
	table.remove(availableTable, randomIndex);
	table.insert(usedTable, item);

	return item;
end


function CreateCourierDestinationConvo(nodeTable, name)
	local randomGoodbyes:table = {};
	local randomNews:table = {};

	for index, voTag in pairs(randomTakerGoodbyes) do
		randomGoodbyes[index] = voTag;
	end

	for index, voTag in pairs(randomTakerGoodbyes) do
		randomGoodbyes[index] = voTag;
	end

	local destinationConvo = {
		name = name .. "_destination_convo",

		CanStart = function (thisConvo, queue) -- BOOLEAN
			return thisConvo.localVariables.nodeTable.isCourierAtDestination;
		end,

		CheckFrequency = function (thisConvo, queue) -- NUMBER
			return 1;
		end,

		Priority = function (thisConvo, queue) -- ENUM
			return CONVO_PRIORITY.NPC;
		end,

		OnStart = function (thisConvo, queue) -- VOID
			destination_node.isInDiscussion = true;	-- Our "taker" character is now in a discussion
		end,

		lines = {
			[1] = {
				character = nodeTable.courierCharacter,
				text = "",
				tag = nil,
			},

			[2] = {
				character = destination_node.takerCharacter,
				text = "",
				tag = nil,
			},
		},

		OnFinish = function (thisConvo, queue) -- VOID
			local nodeTable = thisConvo.localVariables.nodeTable;
			local sourceConvo = nodeTable.sourceConvo;

			nodeTable.isCourierAtDestination = false;
			destination_node.isInDiscussion = false;
			
			-- Set the lines for the Destination Convo			
			local randomGreet = PickRandomItemFromTable(sourceConvo.localVariables.availableGreets, sourceConvo.localVariables.usedGreets);
			sourceConvo.lines[1].text = randomGreet.text;
			sourceConvo.lines[1].tag = randomGreet.tag;

			sourceConvo.localVariables.currentNews = PickRandomItemFromTable(sourceConvo.localVariables.availableNews, sourceConvo.localVariables.usedNews);
			sourceConvo.lines[2].text = sourceConvo.localVariables.currentNews.source.text;
			sourceConvo.lines[2].tag = sourceConvo.localVariables.currentNews.source.tag;

			NarrativeQueue.QueueConversation(sourceConvo);
		end,

		-- DATA
		localVariables = {
			availableGoodbyes = randomGoodbyes,
			usedGoodbyes = {},

			nodeTable = nodeTable,
		},
	};

	return destinationConvo;
end


function CreateCourierSourceConvo(nodeTable, newsTable, name)
	if (not newsTable) then
		error("ERROR CREATING COURIER CONVO ['" .. name .. "'] : news table was nil (make sure all news index names match all source node index names)");
	end

	local randomGreets:table = {};

	for index, voTag in pairs(randomCourierGreets) do
		randomGreets[index] = voTag;
	end

	local destinationConvo = CreateCourierDestinationConvo(nodeTable, name);

	local sourceConvo = {
		name = name .. "_source_convo",

		CanStart = function (thisConvo, queue) -- BOOLEAN
			return thisConvo.localVariables.nodeTable.isCourierAtSource;
		end,

		CheckFrequency = function (thisConvo, queue) -- NUMBER
			return 1;
		end,

		Priority = function (thisConvo, queue) -- ENUM
			return CONVO_PRIORITY.NPC;
		end,

		OnStart = function (thisConvo, queue) -- VOID
			thisConvo.localVariables.nodeTable.isGiverInDiscussion = true;	-- Our "giver" character is now in a discussion
		end,

		lines = {
			[1] = {
				character = nodeTable.courierCharacter,
				text = "",
				tag = nil,
			},

			[2] = {
				character = nodeTable.giverCharacter,
				text = "",
				tag = nil,
			},
		},

		OnFinish = function (thisConvo, queue) -- VOID
			local nodeTable = thisConvo.localVariables.nodeTable;
			local destinationConvo = nodeTable.destinationConvo;

			nodeTable.isCourierAtSource = false;
			nodeTable.isGiverInDiscussion = false;

			-- Set the lines for the Destination Convo
			destinationConvo.lines[1].text = thisConvo.localVariables.currentNews.destination.text;
			destinationConvo.lines[1].tag = thisConvo.localVariables.currentNews.destination.tag;
			
			local randomGoodbye = PickRandomItemFromTable(destinationConvo.localVariables.availableGoodbyes, destinationConvo.localVariables.usedGoodbyes);
			destinationConvo.lines[2].text = randomGoodbye.text;
			destinationConvo.lines[2].tag = randomGoodbye.tag;

			NarrativeQueue.QueueConversation(destinationConvo);
		end,

		-- DATA
		localVariables = {
			availableGreets = randomGreets,
			usedGreets = {},

			availableNews = newsTable,
			usedNews = {},

			currentNews = {},

			nodeTable = nodeTable,
		},
	};

	-- Set the very first random greet
	local randomGreet = PickRandomItemFromTable(sourceConvo.localVariables.availableGreets, sourceConvo.localVariables.usedGreets);
	sourceConvo.lines[1].text = randomGreet.text;
	sourceConvo.lines[1].tag = randomGreet.tag;

	-- Set the very first news item
	sourceConvo.localVariables.currentNews = PickRandomItemFromTable(sourceConvo.localVariables.availableNews, sourceConvo.localVariables.usedNews);
	sourceConvo.lines[2].text = sourceConvo.localVariables.currentNews.source.text;
	sourceConvo.lines[2].tag = sourceConvo.localVariables.currentNews.source.tag;

	-- Register convos with the node
	nodeTable.sourceConvo = sourceConvo;
	nodeTable.destinationConvo = destinationConvo;

	return sourceConvo;
end



--- =========================================================================================================================
-- **conversation VO scripts                                                                                                
--- =========================================================================================================================

global secret_elite_vo = {
	name = "secret_elite_vo",

	volume = VOLUMES.tv_elites_secret,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		print("Secret Elites convo");
		AIDialogManager.DisableAIDialog();
	end,

	-- DIALOG
	lines = {

--           Chunk 1

		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 0;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: ELITE04 (QUIETELITE01)
			text = "Jul 'Mdama, Thel 'Vadam ... they're all the same. Nothing more than power-hungry despots. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02100.sound'),
		},
		[2] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 0;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (QUIETELITE02)
			text = "Talking like that might get you gutted around here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00100.sound'),
		},
		[3] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 0;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: ELITE04 (qUIETELITE01)
			text = "Then my point is proven. They rule by fear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02200.sound'),
		},
		[4] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 0;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (quiETELITE02)
			text = "Even just rulers have their limits.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00200.sound'),
		},
--           Chunk 2

		[5] = {
									If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 1;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: Elite04 (quietelite01)
			text = "You know who was a true leader? Sali 'Nyon. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02300.sound'),
		},
		[6] = {
									If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 1;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (quietelite02)
			text = "Who?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00300.sound'),
		},
		[7] = {
									If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 1;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: Elite04 (quietELITE01)
			text = "Sali 'Nyon, the true Hand, blessed by the Forerunners. He moved against 'Mdama and sought to unite us under a single leader. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02400.sound'),
		},
		[8] = {
											If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 1;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (quietELITE02)
			text = "And since I have never heard of this nishum, I assume he failed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00400.sound'),
		},
--           Chunk 3

		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 2;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: Elite04 (qUIETELITE01)
			text = "All I am saying, brother, is that we must not follow simply because we are told to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02500.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 2;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (qUIETELITE02)
			text = "You talk of following, like a lowly grunt. We are at war, fool. Orders are orders. Act like you understand that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00500.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 2;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_1, -- GAMMA_CHARACTER: ELITE04 (quIETELITE01)
			text = "The Arbiter is a soldier, just like you. He is not perfect.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_02600.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_secretive_elites == 2;
			end,
			character = AI.sq_elites_secretive.elite_secretive_stand_2, -- GAMMA_CHARACTER: EliteFriend02 (quietELITE02)
			text = "He is wise and brave. That is more than I can say for you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elitefriend02_00600.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue) -- VOID
	AIDialogManager.EnableAIDialog();
		if n_secretive_elites == 0 then
			n_secretive_elites = 1
		elseif n_secretive_elites == 1 then
			n_secretive_elites = 2
		elseif n_secretive_elites == 2 then
			n_secretive_elites = 3
		end
	end,


	localVariables = {
	
	
	--speakerBank = CreateRandomizedBank ({1,2,3,4}),
	
	},
};


global ask_arbiter_vo = {
	name = "ask_arbiter_vo",

	volume = VOLUMES.tv_arbiter_base,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		print("Ask Arbiter convo");
		AIDialogManager.DisableAIDialog();
	end,

	-- DIALOG
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 0;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_02, -- GAMMA_CHARACTER: Elite02 (arbiteradvisor01)
			text = "Our systems have been compromised.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06800.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 0;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "By the human AI. Not the Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01400.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 0;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_02, -- GAMMA_CHARACTER: Elite02 (arbiteradvisor01)
			text = "It is sabotage! We must respond!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06900.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 0;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: ArBITER
			text = "We fight one enemy at a time. Today, the Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01500.sound'),
		},
--           Chunk 2

		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 1;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_02, -- GAMMA_CHARACTER: elite03 (arbiteradvisor02)
			text = "Our airstrikes will drive them out of hiding and into our ground troops. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04100.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 1;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_01, -- GAMMA_CHARACTER: Elite02 (arbiteradvisor01)
			text = "We clear and hold the indicated zones. We have sufficient military strength to handle the Covenant defenses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07000.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 1;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "If the human plan holds, they will awaken the Guardian. And then Sunaion is ours.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01600.sound'),
		},
--           Chunk 3

		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 2;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_01, -- GAMMA_CHARACTER: Elite02 (arbiteradvisor01)
			text = "Arbiter, you know I do not follow the old ways ... but to allow a human to awaken the Guardian... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07100.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 2;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "That discomfort you feel? That betrayal? I am depending on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01700.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 2;
			end,
			character = AI.sq_arbiter_crew.sp_advisor_01, -- GAMMA_CHARACTER: Elite02 (arbiteradvisor01)
			text = "Sir?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07200.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 2;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: ARBITER
			text = "The Covenant soldiers will hear the Guardian wake from its slumber. They will look up, over the bodies of their brothers, through the smoke of their burning city. They will look to the horizon as their holy idol rises from the sea and forsakes them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01800.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_arbiter_advisors == 2;
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "And THAT is when the Covenant dies.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_arbiter_01900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	AIDialogManager.EnableAIDialog();
		if n_arbiter_advisors == 0 then
			n_arbiter_advisors = 1
		elseif n_arbiter_advisors == 1 then
			n_arbiter_advisors = 2
		elseif n_arbiter_advisors == 2 then
			n_arbiter_advisors = 3
			b_arbiter_scene_played = true;
		end
	end,


	localVariables = {
	
	
	--speakerBank = CreateRandomizedBank ({1,2,3,4}),
	
	},
};


global turnin_traitor_vo = {
	name = "turnin_traitor_vo",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)

		print("Turn in the traitor convo");
	end,

	-- DIALOG
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.buttonpusher == SPARTANS.locke);
			end,

			sleepBefore = 0,	-- Optional sleep before playing line (copy paste to other lines as needed)

			character = CHARACTER_SPARTANS.locke,
			text = "Arbiter, this is likely of interest to you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_00100.sound'),
		},
		
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.buttonpusher == SPARTANS.vale);
			end,

			character = CHARACTER_SPARTANS.vale,
			text = "Arbiter, we have evidence of treason in your keep.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_00600.sound'),
			sleepAfter = 0.2,
		},
		
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.buttonpusher == SPARTANS.tanaka);
			end,

			character = CHARACTER_SPARTANS.tanaka,
			text = "Arbiter? Reckon this is of interest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01200.sound'),
			sleepAfter = 0.2,
		},
		
		[4] = {
			Else = true,

			character = CHARACTER_SPARTANS.buck,
			text = "Arbiter, got something here you should hear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_00600.sound'),
		},
	},

	localVariables = {},
};


global cliff_grunt_vo = {
	name = "cliff grunt vo",
	volume =  VOLUMES.tv_cliff_grunt,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		print("Singing Grunt convo");
		print (thisConvo.localVariables.speaker);
		AIDialogManager.DisableAIDialog();
		CreateThread(nar_turn_off_interact);
	end,

	-- DIALOG
	lines = {
		[1] = {
				character = AI.sq_phantom.sp_cliff_grunt,
				text = "Where sun and moon and planets roll ... hmm.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00100.sound'),
			},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.lockeSpoke=true;
			end,

			sleepBefore = 0,	-- Optional sleep before playing line (copy paste to other lines as needed)

			character = CHARACTER_SPARTANS.locke,
			text = "Interesting song.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 6;
			end,

		},
		
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.valeSpoke=true;
			end,

			character = CHARACTER_SPARTANS.vale,
			text = "Nice song.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01300.sound'),
			sleepAfter = 0.2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 6;
			end,
		},
		
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.tanakaSpoke=true;
			end,

			character = CHARACTER_SPARTANS.tanaka,
			text = "Real pretty tune.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01500.sound'),
			sleepAfter = 0.2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 6;
			end,
		},
		
		[5] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.buckSpoke=true;
				-- composer_play_show(ics name);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "And stars that glow from pole to pole.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will abort the entire conversation here
				return 6;
			end,
		},
			[6] = {
			character = AI.sq_phantom.sp_cliff_grunt, -- GAMMA_CHARACTER: Grunt02 (SITTINGGRUNT)
			text = "Thanks! Human prisoner used to sing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00900.sound'),
		},
		[7] = {
			character = AI.sq_phantom.sp_cliff_grunt, -- GAMMA_CHARACTER: grunt02 (sittinggrunt)
			text = "I thought maybe practice, sing with him? But then he was in corpse pile. So no singing with him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00400.sound'),
		},
		[8] = {
			character = AI.sq_phantom.sp_cliff_grunt, -- GAMMA_CHARACTER: Grunt02 (sittiNGGRUNT)
			text = "Happy to sing to you, though!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04500.sound'),
		},

		-- Repeatable response
		[9] = {
			character = AI.sq_phantom.sp_cliff_grunt, -- GAMMA_CHARACTER: grunt02 (sittinggrunt)
			text = "Where sun and moon and planets roll, and stars that glow from pole to pole.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		CreateThread(nar_turn_on_interact);
--		CreateThread(devcon_sing_renew);
			thisConvo.localVariables.speaker = nil;
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {
	
	lockeSpoke=false,
	valeSpoke=false,
	tanakaSpoke=false,
	buckSpoke=false,
	complete = false,
	},
};


global wraith_interact_vo = {
	name = "wraith_interact_vo",
	volume = VOLUMES.tv_wraith_base,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		--print("Talk to Wraith mechanic");
		--thisConvo.localVariables.speaker = thisConvo.localVariables.speakerBank.GetNext();
		print ("this is the speaker for wraith mechanic ", thisConvo.localVariables.speaker);
		AIDialogManager.DisableAIDialog();
	end,

	-- DIALOG
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,

--			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
--				thisConvo.localVariables.buckSpoke=true;
--				print("MISSING LINE");
--			end,

			sleepBefore = 0,	-- Optional sleep before playing line (copy paste to other lines as needed)

			character = CHARACTER_SPARTANS.buck,
			text = "MISSING LINE",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 12;
			end,

		},
		
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,

--			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
--				thisConvo.localVariables.valeSpoke=true;
--				print("MISSING LINE");
--			end,

			character = CHARACTER_SPARTANS.vale,
			text = "MISSING LINE",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01300.sound'),
			sleepAfter = 0.2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 12;
			end,
		},
		
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,

--			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
--				thisConvo.localVariables.tanakaSpoke=true;
--				print("MISSING LINE");
--			end,

			character = CHARACTER_SPARTANS.tanaka,
			text = "MISSING LINE",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01500.sound'),
			sleepAfter = 0.2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 12;
			end,
		},
		
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber)
				--thisConvo.localVariables.lockeSpoke=true;
				-- if we integrate an ICS into the scene
				-- composer_play_show(ics name);
				--int_wraiths_goto=4;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Is there a problem here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will abort the entire conversation here
				return 13;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				print (thisConvo.volume);
				print (thisConvo.localVariables.speaker);
				print (volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker));
				return (volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker));
			end,
			
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: Grunt02
			text = "His orders don't make no sense!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03800.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
		
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: Elite02
			text = "Silence! In a flagrant display of tactile ignorance, this Grunt just racked a volatile cell!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06600.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
			
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: GRUNT02
			text = "See? What's he sayin'?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03900.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Don't put the batteries in if they feel hot.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01800.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
			
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: GRUNT02
			text = "OH! Okay!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04000.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Orders don't mean anything unless your subordinate can understand them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01900.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(thisConvo.volume, thisConvo.localVariables.speaker);
			end,
			
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: Elite02
			text = "I will take that into consideration. My appreciation, human.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				-- Defaults to 'lineNumber + 1' (next line)
				-- 'return 0' will make this the last line in the conversation to play
				return 0;
			end,
		},

	
	},

	OnFinish = function (thisConvo, queue) -- VOID
		--CreateThread(devcon_wraith_renew);
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {
	
		lockeSpoke=false,
		valeSpoke=false,
		tanakaSpoke=false,
		buckSpoke=false,
		
		speakerBank = CreateRandomizedBank ({1,2,3,4}),
		speaker = 0,
	},
};



global ruins_vo = {
	name = "W2Hub1stVisit_Ext_ruins",
	volume = VOLUMES.tv_back_ruins,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		thisConvo.localVariables.speaker = thisConvo.localVariables.speakerBank.GetNext();
		print(thisConvo.name, " narrative");
		print (thisConvo.volume);

	end,

	lines = {
---           IF VALE

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Look at all of this. Amazing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02000.sound'),
		},

---           IF BUCK

		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sangheili sure knew how to build rubble.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,						
		},
		[3] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "They didn't build rubble, Buck. This is thousands of years old. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01900.sound'),
		},
---           IF TANAKA

		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Rubble all over the place here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01800.sound'),
		},
---			IF LOCKE

		[5] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == 3);
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Collapsed structures ahead. Watch your footing, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01500.sound'),
		},

---           AFTER ALL OTHERS

		[6] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Humanity hadn't even begun its Stone Age when the Sangheili built these structures. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {
	
	lockeSpoke=false,
	valeSpoke=false,
	tanakaSpoke=false,
	buckSpoke=false,
	
	speakerBank = CreateRandomizedBank ({1,2,3,4}),
	speaker = 0,
	},
};

global W2Hub1stVisit_Cliffside_overlook = {
	name = "W2Hub1stVisit_Cliffside_overlook",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_view_of_canyons); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");

	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_view_of_canyons, SPARTANS.locke);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Long sightlines here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01200.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_view_of_canyons, SPARTANS.vale);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The canyons of Sanghelios are breathtaking.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01200.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_view_of_canyons, SPARTANS.buck);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Long way down. Pretty, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01200.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_view_of_canyons, SPARTANS.tanaka);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Not a bad view. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_01400.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
---  =============================================================================================================================
--  **Banks**
---  =============================================================================================================================




--- ===============================================================
-- GUARDS BUMP VO BANK:
--- ===============================================================

global guardbankData = {
    {	-- Sequence 1
		name = "guard seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				-- character = 0,
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_06300.sound'),
				text = "Watch yourself, Spartan",
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},

		{	-- Sequence 2
		name = "guard seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06300.sound'),
				text = "Tread carefully, human.",
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},

	    {	-- Sequence 3
		name = "guard seq 3",
		-- OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03700.sound'),
				text = "Move.",
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},

		    {	-- Sequence 4
		name = "guard seq 4",
		-- OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_01000.sound'),
				text = "Give me space.",
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},

		 {	-- Sequence 5
		name = "guard seq 5",
		-- OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_03900.sound'),
				text = "Yes little human?",
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},
};


--[===[
global bansheeMechanicBankData = {
	{-- Sequence 1
		name = "",
		-- OnStart = function() end,
		lines = {
			{-- S1 Line 1
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},
	{-- Sequence 2
		name = "",
		-- OnStart = function() end,
		lines = {
			{-- S2 Line 1
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
			{-- S2 Line 2
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},
	{-- Sequence 3
		name = "",
		-- OnStart = function() end,
		lines = {
			{-- S3 Line 1
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
			{-- S3 Line 2
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
			{-- S3 Line 3
				--OnStart = function() end,
				character = ,
				text = "",
				tag = TAG(''),
				--OnFinish = function() end,
			},
		},
		-- OnFinish = function() end,
	},
};

----]===]
---- =====================================================================================
---- Arbiter Advisors VO Bank
---- =====================================================================================

global ArbiterBankData = {
    {	-- Sequence 1
		name = "arbiter seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "Any troop movements?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07300.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
			{	-- Sequence 1, Line 2
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Not yet.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04200.sound'),
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "arbiter seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Did the supplies arrive?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07400.sound'),
			},
			{		-- Sequence 2, Line 2
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "This morning.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04300.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "arbiter seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Is the cliffside secure?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07500.sound'),
			},
			{		-- Sequence 3, Line 2
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "Yes, we posted patrols.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04400.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "arbiter seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Analyzing troop reports.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07600.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "arbiter seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "No new intel on the Covenant.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07700.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "arbiter seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "We will need more fuel rods soon.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07800.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "arbiter seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "The front is holding.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_07900.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "arbiter seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "The structure is being analyzed.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04500.sound'),
			},
		},
	},
	{	-- Sequence 9
		name = "arbiter seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 9, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "We have more Forerunner readings.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_04600.sound'),
			},
		},
	},
	{	-- Sequence 10
		name = "arbiter seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 10, Line 1
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "I rescheduled the supply drop.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_ELITE03_04700.sound'),
			},
		},

	},	--OnFinish = function() end,
};





---- =====================================================================================
---- Banshee Nest VO Bank
---- =====================================================================================

global BansheeBankData = {
    {	-- Sequence 1
		name = "banshee seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_banshee_fix.sp_fix_01,
				text = "Is your anti-grav charged?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_02700.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
			{	-- Sequence 1, Line 2
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "Yes, fully charged.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02400.sound'),
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "banshee seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "This is badly scratched.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02500.sound'),
			},
			{		-- Sequence 2, Line 2
				character = AI.sq_banshee_fix.sp_fix_01,
				text = "Buff it out, brother.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03400.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "banshee seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "This cursed thing.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02600.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "banshee seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "Fully stocked with plasma.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02700.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "banshee seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "We could use better tools.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02800.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "banshee seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_banshee_fix.sp_fix_01,
				text = "Still lots of work to do.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03500.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "banshee seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "These are the wrong bolts.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_02900.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "banshee seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "I would rather fix these than fly them.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03000.sound'),
			},
		},
	},
	{	-- Sequence 9
		name = "banshee seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 9, Line 1
				character = AI.sq_banshee_fix.sp_fix_02,
				text = "This wiring is a mess.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03100.sound'),
			},
		},
	},
	{	-- Sequence 10
		name = "banshee seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 10, Line 1
				character = AI.sq_banshee_fix.sp_fix_01,
				text = "Keep working, brothers.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03600.sound'),
			},
		},
	},
		--OnFinish = function() end,
};

global banshee_scripted_vo = {
	name = "banshee_scripted_vo",
		volume =  VOLUMES.tv_banshee_fix,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	CreateThread(nar_turn_off_interact);
		print(thisConvo.name, " narrative");
		print("banshee fix convo");
		print (thisConvo.localVariables.speaker);
			AIDialogManager.DisableAIDialog();
		--thisConvo.localVariables[thisConvo.localVariables.speaker] = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_banshee_scenes == 0 ;
			end,
			character = AI.sq_banshee_fix.sp_fix_01, -- GAMMA_CHARACTER: Elite02
			text = "The assault on Sunaion draws near.  Will your Banshee be prepared?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				return 4;
			end,
		},

		[2] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: EliTE03
						text = "The Banshee remains inoperative. I do not yet understand why.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00200.sound'),
			
		},
		[3] = {
			character = AI.sq_banshee_fix.sp_fix_01, -- GAMMA_CHARACTER: ELITE02
			text = "Figure it out. We need every Banshee in the air.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_00400.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				n_banshee_scenes = 1;
				--return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.locke and locke_banshee_scene == false and tanaka_banshee_scene == false;
				--return objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_banshee_fix.sp_fix_02)) < 10 and locke_banshee_scene == false and tanaka_banshee_scene == false;
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Did you check the anti-gravity drive?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_01100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				print ("locke failed");
				print (thisConvo.localVariables.speaker);
				return 6;
			end,
		},
		[5] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: Elite04
			text = "That is not the problem, human.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			--locke_banshee_scene = true;
				--return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale and vale_banshee_scene == false and tanaka_banshee_scene == false;
				--return objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_banshee_fix.sp_fix_02)) < 10 and vale_banshee_scene == false and tanaka_banshee_scene == false;
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Is there anything we can do to help?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_01100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				print ("vale failed");
				return 8;
			end,
		},
		[7] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: ELITE04
			text = "No. Go away.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			--vale_banshee_scene = true;
				--return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck and buck_banshee_scene == false and tanaka_banshee_scene == false;
				--return objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_banshee_fix.sp_fix_02)) < 10 and buck_banshee_scene == false and tanaka_banshee_scene == false;
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Have you hoisted your mizzenmast?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				print ("buck failed");
				return 10;
			end,
		},
		[9] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: ELITE04
			text = "That is not even a thing! Be gone.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00900.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				--buck_banshee_scene = true;
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka and tanaka_banshee_scene == false;
				--return objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_banshee_fix.sp_fix_02)) < 10 and tanaka_banshee_scene == false;
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "See that part right there? Quarter-turn right and lock it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_00100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				print ("tanaka failed");
				return 0;
			end,
		},
--           After fixing the Banshee.

		[11] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: ELITE04
			text = "How did you know that, human?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00300.sound'),
		},
		[12] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Had to disable a few Banshees in the past. Just did the opposite.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_00600.sound'),
		},
		[13] = {
			character = AI.sq_banshee_fix.sp_fix_02, -- GAMMA_CHARACTER: ELITE04
			text = "Ha!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite04_00400.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				--tanaka_banshee_scene = true;
				thisConvo.localVariables.complete = true;
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_on_interact);
		thisConvo.localVariables.speaker = nil;
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {
		complete = false,
--		DidIAlreadyPlayThisCharacter = function(thisConvo)
--			return thisConvo.localVariables.speaker and thisConvo.localVariables[thisConvo.localVariables.speaker];
--		end,		
	},
};




---- =====================================================================================
---- Medical Tent VO Bank
---- =====================================================================================

global MedicalBankData = {
    {	-- Sequence 1
		name = "medical seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "We require more supplies.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03800.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "medical seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "Remember. Patients, not fatalities.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03900.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "medical seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "Medicine is scarce.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04000.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "medical seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "These readings could be worse.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04100.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "medical seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "I usually work with an assistant.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04200.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "medical seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "This equipment is confusing.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03200.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "medical seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "I have prepared the beds.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03300.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "medical seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "Tell him to calm down.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03400.sound'),
			},
		},
	},
	{	-- Sequence 9
		name = "medical seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 9, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "Readings are in the green.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03500.sound'),
			},
		},
	},
	{	-- Sequence 10
		name = "medical seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 10, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "I have seen worse.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_03600.sound'),
			},
		},
	},
		--OnFinish = function() end,
}
global medical_tent_scripted_vo = {
	name = "medical_tent_scripted_vo",
			volume =  VOLUMES.tv_medicalbase,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "What is it? Why do you pause?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01100.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: Elite03
			text = "This wound is familiar.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_00100.sound'),
		},
--           Other medic turns to look at the other patient.

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "'Mdama keep.  Their plasma blades burn less intensely.  Harder to cut armor, but the injuries are more grievous and do not cauterize.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03200.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: ELITE03
			text = "So the blades leave Sangheili alive, but too wounded to fight. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_00800.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE02
			text = "Most choose suicide to preserve their honor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_03300.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: ELITE03
			text = "Making any wound a death blow. Barbaric. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite03_00900.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "Indeed. Had I ever met Jul 'Mdama, I would have gutted him with my bare claws.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01400.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: ELITE01
			text = "Do not touch me, you honorless filth! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_00700.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: Elite01
			text = "Had the Arbiter himself not ordered me here I-- [would never allow such a]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_03800.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE02
			text = "We can ill afford to lose warriors. Even those as inconsequential as yourself.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01500.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: Elite01
			text = "You spill blood outside of battle! I would rather take my own life than let you touch me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_00800.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "That life is not yours to take. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01600.sound'),
		},
		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "You belong to the Arbiter, and he believes you are worth repairing. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01700.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: Elite01
			text = "I refuse to be shamed by a--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_00900.sound'),
		},
--                          (it's a terrible word)
--                     --medic!

		[15] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE02
			text = "Then die, coward. Fail the Arbiter and have the shame of your dereliction follow your clan for generations! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01800.sound'),
		},
		[16] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: ELITE01
			text = "I ... rrrgh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01000.sound'),
		},
		[17] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "Good. Since you cannot be brave, at least be quiet. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_01900.sound'),
		},

		[18] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: Elite01
			text = "There is no honor in dying in a tent, medic.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01100.sound'),
		},
		[19] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: ELITE01
			text = "A Sangheili must fall in battle!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01200.sound'),
		},
		[20] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE02
			text = "There is no battlefield harsher than a medic tent.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_02000.sound'),
		},
		[21] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: ELITE01
			text = "Are you mad? You know nothing of combat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01300.sound'),
		},
		[22] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "You fool. When I draw my weapons, it is for combat with death herself. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_02100.sound'),
		},
		[23] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite02
			text = "I defend you with knife and needle. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_02200.sound'),
		},
		[24] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_patient_02, -- GAMMA_CHARACTER: Elite01
			text = "I fear no enemy! Not even Death!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01500.sound'),
		},
		[25] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE02
			text = "Yes. That is what they always say.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		if n_medic_scenes == 0 then
			n_medic_scenes = 1;
		elseif n_medic_scenes == 1 then
			n_medic_scenes = 2;
		elseif n_medic_scenes == 2 then
			n_medic_scenes = 3;
		end
	end,

	localVariables = {},
};


---- =====================================================================================
---- Phantom Base VO Bank
---- =====================================================================================
--
----global PhantomBankData = {
----    {	-- Sequence 1
----		name = "phantom seq 1",
----		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 1, Line 1
--				character = AI.sq_phantom.sp_elite05,
--				text = "Did you fix the vents?",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_00400.sound'),
--				--OnStart = function() end,
--				--OnFinish = function() end,
--			},
--			{	-- Sequence 1, Line 2
--				character = AI.sq_phantom.sp_elite01,
--				text = "Yes, checked and locked.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_00100.sound'),
--			},
--		},
--		--OnFinish = function() end,
--	},
--	{	-- Sequence 2
--		name = "phantom seq 2",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 2, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "The sights were drifting. Did you--",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_01400.sound'),
--			},
--			{		-- Sequence 2, Line 2
--				character = AI.sq_phantom.sp_elite05,
--				text = "I adjusted them.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_02600.sound'),
--			},
--		},
--	},
--	{	-- Sequence 3
--		name = "phantom seq 3",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 3, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "The plating looks solid.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02000.sound'),
--			},
--		},
--	},
--	{	-- Sequence 4
--		name = "phantom seq 4",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 4, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "Check the coolant system.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02100.sound'),
--			},
--		},
--	},
--	{	-- Sequence 5
--		name = "phantom seq 5",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 5, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "Make sure the locks are engaged.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_03200.sound'),
--			},
--		},
--	},
--	{	-- Sequence 6
--		name = "phantom seq 6",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 6, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "Go over the plasma turret again.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_03700.sound'),
--			},
--		},
--	},
--	{	-- Sequence 7
--		name = "phantom seq 7",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 7, Line 1
--				character = AI.sq_phantom.sp_elite01,
--				text = "Clear the plasma vents.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_03900.sound'),
--			},
--		},
--	},
--	{	-- Sequence 8
--		name = "phantom seq 8",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 8, Line 1
--				character = AI.sq_phantom.sp_elite05,
--				text = "The tail section could use reinforcement.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_02700.sound'),
--			},
--		},
--	},
--	{	-- Sequence 9
--		name = "phantom seq 9",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 9, Line 1
--				character = AI.sq_phantom.sp_elite05,
--				text = "The nav station is ready.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_02800.sound'),
--			},
--		},
--	},
--	{	-- Sequence 10
--		name = "phantom seq 10",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 10, Line 1
--				character = AI.sq_phantom.sp_elite05,
--				text = "I patched the plasma damage.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite05_02900.sound'),
--			},
--		},
--	},
--		--OnFinish = function() end,
--};


---- =====================================================================================
---- Wraith Base VO Bank
---- =====================================================================================

global WraithBankData = {
    {	-- Sequence 1
		name = "wraith seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_wraith.sp_mechanic_01,
				text = "Clean up the debris.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04400.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "wraith seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_wraith.sp_mechanic_01,
				text = "There are more Wraiths to fix.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04500.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "wraith seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_wraith.sp_mechanic_01,
				text = "Get back to work.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04600.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "wraith seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_wraith.sp_mechanic_01,
				text = "Be more careful next time.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04700.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "wraith seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_wraith.sp_mechanic_01,
				text = "I will file the incident report.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_04800.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "wraith seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_wraith.sp_grunt_01,
				text = "This can't be fixed.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_02900.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "wraith seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_wraith.sp_grunt_01,
				text = "I need more practice at fixing.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03000.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "wraith seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_wraith.sp_grunt_01,
				text = "It was pretty old anyway.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03100.sound'),
			},
		},
	},
	{	-- Sequence 9
		name = "wraith seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 9, Line 1
				character = AI.sq_wraith.sp_grunt_01,
				text = "I'm usually good at fixin' things.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03200.sound'),
			},
		},
	},
	{	-- Sequence 10
		name = "wraith seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 10, Line 1
				character = AI.sq_wraith.sp_grunt_01,
				text = "Gonna need more Wraiths.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_03300.sound'),
			},
		},
	},
		--OnFinish = function() end,
};

global W2Hub1stVisit_EXT__Sangheili_discussion = {
	name = "W2Hub1stVisit_EXT__Sangheili_discussion",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: ELITE01
			text = "[Short sentence in Sangheili: Obey me immediately!]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_06700.sound'),
		},
		[2] = {
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: Grunt02
			text = "Why you gotta talk like that? I got no idea what you're sayin'!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04100.sound'),
		},
		[3] = {
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: Elite01
			text = "[Short sentence in Sangheili: I will not ask again!]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_06800.sound'),
		},
		[4] = {
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: Grunt02
			text = "Quit talkin' in Sangheili! You gotta talk human!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04200.sound'),
		},
		[5] = {
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: Elite01
			text = "This crude human language dishonors my words! I will only speak in honorable Sangheili!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_06900.sound'),
		},
		[6] = {
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: Grunt02
			text = "Then we won't have too much to talk about. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {},
};

global W2Hub1stVisit_EXT__Sangheili_discussion2 = {
	name = "W2Hub1stVisit_EXT__Sangheili_discussion2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_wraith.sp_mechanic_01, -- GAMMA_CHARACTER: Elite01
			text = "[Short sentence in Sangheili: You are useless.]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_07000.sound'),
		},
		[2] = {
			character = AI.sq_wraith.sp_grunt_01, -- GAMMA_CHARACTER: Grunt02
			text = "All I hear is 'wort wort wort'!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_04400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {},
};


---- =====================================================================================
---- Door Bank VO Bank
---- =====================================================================================

--global DoorBankData = {
--    {	-- Sequence 1
--		name = "door seq 1",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 1, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "This structure is puzzling.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05400.sound'),
--				--OnStart = function() end,
--				--OnFinish = function() end,
--			},
--		},
--		--OnFinish = function() end,
--	},
--	{	-- Sequence 2
--		name = "door seq 2",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 2, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "How curious.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05500.sound'),
--			},
--		},
--	},
--	{	-- Sequence 3
--		name = "door seq 3",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 3, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "This is most troubling.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05600.sound'),
--			},
--		},
--	},
--	{	-- Sequence 4
--		name = "door seq 4",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 4, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "Why is this here?",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05700.sound'),
--			},
--		},
--	},
--	{	-- Sequence 5
--		name = "door seq 5",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 5, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "I do not understand.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05800.sound'),
--			},
--		},
--	},
--	{	-- Sequence 6
--		name = "door seq 6",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 6, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "What is beyond this wall?",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_05900.sound'),
--			},
--		},
--	},
--	{	-- Sequence 7
--		name = "door seq 7",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 7, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "I detect no openings here.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06000.sound'),
--			},
--		},
--	},
--	{	-- Sequence 8
--		name = "door seq 8",
--		--OnStart = function() end,
--		lines = {
--			{		-- Sequence 8, Line 1
--				character = AI.sq_receptacle.sp_door_elite,
--				text = "These structures are baffling.",
--				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite02_06100.sound'),
--			},
--		},
--	},
--		--OnFinish = function() end,
--};

global CliffGruntData = {
	{	-- Sequence 1
		name = "singing grunt 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_phantom.sp_cliff_grunt,
				text = "Where sun and moon and planets roll ... hmm.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00100b.sound'),
			},
		},
	},
};



---- =====================================================================================
---- Story Grunt VO Bank
---- =====================================================================================

global StoryGruntData = {
    {	-- Sequence 1
		name = "story grunt seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "One night I was sneaking around in the ship - I mean, I was walking, just regular walking, but this one Sangheili saw me and he got MAD and started yelling all about how there's no honor in being a secret sneaker. You know how they are with their honor. It's always honor this, honor that, have an honor, taking an honor, do a big honor... I forget what I was talking about.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00100.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
						{		-- Sequence 1, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Mm.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00600.sound'),
		},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
	name = "story grunt seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "Unggoy should get more honors. We do all the dangerous jobs even though you have to be really tough and not cry when you do them. Trust me. Because I heard ... from a friend ... that if you have active camouflage on and do a cries, it makes a big sizzle sound and everybody can see me hiding in the corner, and the mean Kig-Yar in charge of the recruits will get shouty and give me hard little bites on my legs! So, yeah, super dangerous! There's all KINDS of honor in danger stuff. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00200.sound'),
			},
			{		-- Sequence 2, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Hmmm.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00800.sound'),
		},
		},
	},
	{	-- Sequence 3
	name = "story grunt seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "So, here is a big question: do humans make eggs, true or the other one? I KNOW YOU GIVE UP so I'll tell you: I don't remember, actually, but it was a question we had to know! Another one was what kinds of things humans breathe? Not waters. You put 'em in waters and forget about it. Ha! They get real quiet after breathing waters.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00300.sound'),
			},
			{		-- Sequence 3, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Eh?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00300.sound'),
		},
		},
	},
	{	-- Sequence 4
		name = "story grunt seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "You wanna know what I was thinking about? I mean just now? Back when I was servin' the Covenant - and you're gonna say SERVIN' THEM WHAT and I'm gonna say BREAKFAST and booooy, are we gonna laugh! But back... back when I remembered what I was talking about? Back then was good times.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00400.sound'),
			},
			{		-- Sequence 4, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Huh?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00400.sound'),
		},
		},
	},
	{	-- Sequence 5
		name = "story grunt seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "So last night instead of sleepin', me and the other Unggoy was up at talking about battles. And my buddy Gripple was saying all about how he shot at a Spartan human once, and it was an AMAZING story. It was the kind of story that makes ya proud to do a war even though we don't do wars at humans no more because Arbiter said not to. It was so AMAZING, we forgot we'd been told to be asleep, like, eight times already. But everybody was yelling, so I started yelling too, and you know how it feels to yell real loud about something? It feels GREAT! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00500.sound'),
			},
			{		-- Sequence 5, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Muh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00700.sound'),
		},
		},
	},
	{	-- Sequence 6
		name = "story grunt seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "So how long you train for to join the Swords of Sangheilios? Because I did a LOT of training back in the Covenant for all kinds of combat! I done weeks of trainings with the best guns so I could be the strongest. You know how good Unggoy brains are for making a learn, right? It's because our symmo ... cinnamon ... SYNAPSES are super great, so we learn the best and fastest. That's very true because of biology! They say Unggoy training for a week is like Sangheili trains for a whole year, because of the power of Unggoy brains. We are weird smart... Weird smart.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00600.sound'),
			},
			{		-- Sequence 6, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "[negative snort]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01300.sound'),
		},
		},
	},
	{	-- Sequence 7
		name = "story grunt seq 7",
		--OnStart = function() end,
		lines = {
			{ -- Sequence 7, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "You ever serve on a spacetime ship all out in space? I was on one for years but can't never remember the name! Howcome we got such complicatin' shiptime names? Every time you make intel in a battle, the ship is probably blowed up before you finish, like, \"Sir, they're firing missiles at the CSS Pinnacle of Shadowy Gumption and OH TOO LATE it's explodered! Don't worry, here comes the Unyielding Double Caduceus and OH MAN never mind!\" Gotta give ships littler names, like Mirt or Fip or Bob!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00700.sound'),
			},
				{		-- Sequence 7, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Nngh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00900.sound'),
		},

		},
	},
	{	-- Sequence 8
		name = "story grunt seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
		character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "You don't talk much. Are you just doin' the Sangheili brain thing: \r\n\"Keep breathin', very honorable to be breathin' and tall and making yells at everybody.\"\r\nAre you thinking that or are you just being quiet?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00800.sound'),
			},
			{		-- Sequence 8, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Mm.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00600.sound'),
		},
		},
	},
	{	-- Sequence 9
		name = "story grunt seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 9, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Sometimes new learns push out the old stuff. You ever have that happen? Like I'm so good at chargin' plasma pistols' and throwin' grenades and also bein' friends! I used to be real good at quantum theories once but then I got way into throwin' grenades! I think it was a pretty smart decision since so much of doin' war is knowin' when to throw grenades at something. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00900.sound'),
		},
			{		-- Sequence 9, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Bruh?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01000.sound'),
		},
	},
},
	{	-- Sequence 10
		name = "story grunt seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 10, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I lotsa times think how your mouth is weird. Not YOUR mouth in particular, but Sangheli mouths. So I guess your mouth too. But no offense! Unggoy spend all day look'n up into those things and they're creepy - like four little toothy fingers just flappin' around. If you guys had tongues it'd be even creepier ... hang on. I just realized you don't have tongues! How do you make food noises?\r\nPhhbbbt. Phhbbbt. Phhbbbt.\r\nPhhhhhhhhhhhhhhhhhhbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbt. \r\nI bet you can't say that, can you?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01000.sound'),
			},
			{		-- Sequence 10, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Uh-huh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00100.sound'),
		},
		},
	},
	{	-- Sequence 11
		name = "story grunt seq 11",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 11, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "You gotta quit talkin' in Sangheili. You gotta talk human. I don't understand Sangheili. All I hear is wort wort wort.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01100.sound'),
		},
					{		-- Sequence 11, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Uh-huh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00100.sound'),
		},
	},
},		
	{	-- Sequence 12
		name = "story grunt seq 12",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Doisac. \r\nDoisac. \r\nDoiiiiisack. \r\nDoi. \r\nSac. \r\nPlanet of the Brutes, everybody.\r\nCoulda named it anything. \r\nThey named it Doisac.\r\nDoisac.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01200.sound'),
		},
							{		-- Sequence 11, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Guh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01100.sound'),
		},
	},
},		

	{	-- Sequence 13
		name = "story grunt seq 13",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I used to work for the Didact. It was okay, I guess. Worked for Jul 'Mdama mostly. He was a jerk. Almost got us all killed and then he didn't and that was okay too, I guess. I mean not dead's better than dead, right? Just ask my buddy Plorp. He's dead. He doesn't like it. At least he doesn't say he likes it. Anywho, whole time I knew Didact he said, like, three words! He said \"I can't be composed.\" I wonder if he wanted that for himself and was afraids. I hope he found a way to be that and also not afraids. I was afraids they'd find out I shooted Plorp, but I blamed it on the green demon guy. I blame a lot of things on him. You ever do that? That guy was the best. You could shoot him and shoot him and he never fell over! Not like Plorp. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01300.sound'),
		},
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Oh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00500.sound'),
		},
	},
},		

	{	-- Sequence 14
		name = "story grunt seq 14",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Hey, you wanna do secret telling? Because I got one that makes me very regretted each time I do memories. This once, I was in a very danger place, me and a bunch of other Unggoy, like maybe 20 or 50 of 'em, I forget. But a lot! And things were gettin' more and more dangers and there was maybe gonna be an exploding soon? So we had to escape in a ship before nighttime! But I remembered that the ship was real teeny smallest and could only do seats for one Unggoy! Only one! There wasn't enough room for nobody else, nope nope! And I told everybody, so along the way to the ship, everybody was all doing so much fighting because of not enough seats, and some Unggoys was killin' others or doin' cries or bein' bravers and making heroic sacrifices ... it was so very emotional! And then there was only me, the last Unggoy alive, and I finally got to the ship, and it was HUGE! You'd have to be crazies to think there was no seats! But anyway, that is my regretted memory. Did I say regretted? I meant PROUDEST! I b",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01400.sound'),
		},
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Nngh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00900.sound'),
		},
	},
},

	{	-- Sequence 15
		name = "story grunt seq 15",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "So, uh, howcome do you figure stuff looks different sometimes? I mean guns, or the Arbiter ... like, do you remember bein' more purpler? Because maybe it's just my eyes gettin' smarter, but I swears sometimes it's like there's a whole spaceship is different and nobody says anything! And was the Gravemind ALWAYS so much scary? I dunno. Maybe it's just me that notices stuff.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01500.sound'),
		},
			{		-- Sequence 8, Line 1
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Bruh?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01000.sound'),
		},
	},
},

	{	-- Sequence 16
		name = "story grunt seq 16",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 16, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "So there's this one thing I been thinking about for YEARS. Say you're a nice thing, right? And there was a mean thing that turned nice things into mean things, but you caught it! Would you kill the mean thing once and forevers, ORRRR, would you maybe take the mean thing and put it someplace safe so people in the future could find it and feed it to some dogs? I'm JUST SAYIN' that I might probably not do the second one.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01600.sound'),
		},
			{		-- Sequence 16, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Huh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_VO_SCR_W2Hub1stVisit_CV_StoryElite_00200.sound'),
		},
	},
},		
	{	-- Sequence 17
		name = "story grunt seq 17",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 17, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Humans are maybe way bravers than we think. They're doing all kinds of honors flying in those Pigeon, or Peregrine, or Percolator ships. Whatever ya call 'em. Like rocks with wings. Never seen one landing the side up you'd want, or even landing on purpose. But maybe all those crashies is a strategy? Maybe we're s'posedta think, wow, they treat their OWN ships so bad, just THINK how much they're gonna wreck ours! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01700.sound'),
		},
		{		-- Sequence 17, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "[negative snort]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01300.sound'),
		},
	},
},	

	{	-- Sequence 18
		name = "story grunt seq 18",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 18, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I tell ya something I learned the hardest way! Gotta be nice. To everybody! Not just the food nipple manager, but EVERYBODY. Cause you can call a guy an eggface one time, and it's VERY funny. But then probably, even if it's just three times, everybody asks why you're so mean all the time even though you only said the mean thing like maybe six times. Nine, tops.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_01800.sound'),
		},
		{		-- Sequence 18, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "[positive snort]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_01200.sound'),
		},
	},
},	
	{	-- Sequence 19
		name = "story grunt seq 19",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 19, Line 1
			character = AI.sq_banshee_fix.sp_grunt_07, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "So, here is a big question: do humans make eggs, true or the other one? I KNOW YOU GIVE UP so I'll tell you: I don't remember, actually, but it was a question we had to know! Another one was what kinds of things humans breathe? Not waters. You put 'em in waters and forget about it. Ha! They get real quiet after breathing waters.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storygrunt_00300.sound'),
		},
		{		-- Sequence 18, Line 2
			character = AI.sq_banshee_fix.sp_fix_06, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Eh?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_storyelite_00300.sound'),
		},
	},
},	
--OnFinish = function() end,
};



---- =====================================================================================
---- Elite Grunt VO Bank
---- =====================================================================================

global EliteGruntData = {
    {	-- Sequence 1
		name = "elitegrunt seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "Why don't you listen to me?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00900.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
	name = "elitegrunt seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "You can't keep ignoring this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_01000.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "elitegrunt seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: GRUNT04(Servilegrunt)
			text = "Well? Is that what you want?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_01100.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "elitegrunt seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "I'm saying this for the last time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_01200.sound'),

			},
		},
	},
	{	-- Sequence 5
		name = "elitegrunt seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "Just listen, for once.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_01300.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "elitegrunt seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "That's enough.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_05100.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "elitegrunt seq 7",
		--OnStart = function() end,
		lines = {
			{
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I tire of your blathering.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_05200.sound'),
			}

		},
	},
	{	-- Sequence 8
		name = "elitegrunt seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
		character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I heard you the first time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_05300.sound'),
			},
		},
	},
	{	-- Sequence 9
		name = "elitegrunt seq 9",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Enough, just stop.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_05400.sound'),
		},
	},
},
	{	-- Sequence 10
		name = "elitegrunt seq 10",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Stop yammering at me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_05500.sound'),
			},
		},
	},
		--OnFinish = function() end,
};

global elitegrunt_vo = {
	name = "elitegrunt_vo",
	volume = VOLUMES.tv_elite_grunt,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Oh, leave me alone.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02200.sound'),
		},
		[2] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "It's a simple question. Why can't you take better care of your gear? Look at this. Disgraceful.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00100.sound'),
		},
		[3] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "The only disgrace is the way you cook irukan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02300.sound'),
		},
		[4] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "All the irukan cakes in the world won't fill a belly full of plasma holes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00200.sound'),
		},
--           Chunk 2

		[5] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "You forget your place, Grunt.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02400.sound'),
		},
		[6] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "Not so! My place is at the feet of a lazy, negligent warrior who can't be bothered to fight with proper gear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00300.sound'),
		},
		[7] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "ENOUGH!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02500.sound'),
		},
--           The Grunt falls into a bitter silence.

		[8] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "I apologize. It was not honorable for me to silence you like that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02600.sound'),
		},
		[9] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "Hrmph.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00400.sound'),
		},
--           Chunk 3

		[10] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "You really need a new set of armor after this battle.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00500.sound'),
		},
		[11] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "My armor is fine. It was good enough for my father. It will serve me as well.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02700.sound'),
		},
		[12] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "What if the Covenant shoot right through its weak spot here and spill your insides all over the battlefield?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00600.sound'),
		},
--           The Servile Grunt bursts into tears.

		[13] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04
			text = "(crying)",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00700.sound'),
		},
		[14] = {
			character = AI.sq_complain.sp_elite_01, -- GAMMA_CHARACTER: Elite01(PompousElite)
			text = "Really? This again?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_elite01_02800.sound'),
		},
		[15] = {
			character = AI.sq_complain.sp_grunt_01, -- GAMMA_CHARACTER: Grunt04(Servilegrunt)
			text = "I'm sorry, master. I just don't want you to die a disgrace.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt04_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};


global W2Hub1stVisit_KUPKUP = {
	name = "W2Hub1st_KUPKUP",

	CanStart = function (thisConvo, queue)
		return false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = 0, -- GAMMA_CHARACTER: Grunt02(kupkup)
			text = "Fetch my armor, Kupkup! Clean this carbine, Kupkup! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00700.sound'),
		},
		[2] = {
			character = 0, -- GAMMA_CHARACTER: Grunt02 (kupkup)
			text = "On Balaho I was a doctor. You'd think that would be valuable around here. Nobody asks me if there's an alternative to atropine in case we run out. Of course there is, you fools!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_02700.sound'),
		},

	},
	OnFinish = function (thisConvo, queue)
		CreateThread(nar_kupkup2);
	end,

	localVariables = {},
};

function nar_kupkup2()
	NarrativeQueue.QueueConversation(W2Hub1stVisit_KUPKUP2);
end

global W2Hub1stVisit_KUPKUP2 = {
	name = "W2Hub1stVisit_KUPKUP2",

	CanStart = function (thisConvo, queue)
		return false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = 0, -- GAMMA_CHARACTER: Grunt02(kupkup)
			text = "Get out of the way Kupkup, and stop banging on about atropine. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_00800.sound'),
		},
		[2] = {
			character = 0, -- GAMMA_CHARACTER: Grunt02 (kupkup)
			text = "Go cook us dinner, Kupkup. You \r\nburned the colo steaks, Kupkup! ...I'll show you. One day, I'll show. You. All.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_cv_grunt02_02800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};

----[===[
---- HOW TO USE:
--
---- To CREATE A BANK object:
--
--	local yourBank = NarrativeLoopBank.Create( yourTable );
--
---- To PLAY the NEXT sequence:
--
--	NarrativeLoopBank.PlayNext( yourBank );
--
---- or if you need to define a specific character for universal lines:
--
--	NarrativeLoopBank.PlayNext( yourBank, specificCharacter );
--
----]===]
--
--
--
---- VO Bank Globals
---- USE
---- NarrativeLoopBank.PlayNext(nameVOBank);
---- and
---- NarrativeLoopBank.ForceSkipNext(nameVOBank);

-- Bank Tables
--global guardVOBank:table=NarrativeLoopBank.Create( guardbankData, CONVO_PRIORITY.MainCharacter, 0, 2);

global guardVOBank:table=CreateRandomizedBank(guardbankData);
global ArbiterVOBank:table=NarrativeLoopBank.Create( ArbiterBankData, CONVO_PRIORITY.MainCharacter, 0.9, 120);
global BansheeVOBank:table=NarrativeLoopBank.Create( BansheeBankData, CONVO_PRIORITY.MainCharacter, 0.9, 120);
global MedicalVOBank:table=NarrativeLoopBank.Create( MedicalBankData, CONVO_PRIORITY.MainCharacter, 0.9, 120);
--global PhantomVOBank:table=NarrativeLoopBank.Create( PhantomBankData, CONVO_PRIORITY.MainCharacter, .5, 2);
global WraithVOBank:table=NarrativeLoopBank.Create( WraithBankData, CONVO_PRIORITY.MainCharacter, 0.9, 120);
--global DoorVOBank:table=NarrativeLoopBank.Create( DoorBankData, CONVO_PRIORITY.MainCharacter, 0.8, 60);
global CliffGruntVOBank:table=NarrativeLoopBank.Create( CliffGruntData, CONVO_PRIORITY.MainCharacter, 0.9, 480);
global EliteGruntVOBank:table=NarrativeLoopBank.Create( EliteGruntData, CONVO_PRIORITY.MainCharacter, 0.9, 120);
global StoryGruntVOBank:table=NarrativeLoopBank.Create( StoryGruntData, CONVO_PRIORITY.MainCharacter, 4, 6);
-- Vignette tables

global StoryGruntVignetteVO:table = 
	{
		name = "story grunt vignette",
		
	--	convo = story_grunt_vo,
		vobank = StoryGruntVOBank,
		--show = "comp_cliff_grunt",
		--volume = story_grunt_vo.volume,
		--vip = CHARACTER_SPARTANS.buck,
	};


global CliffGruntVignetteVO:table =
	{
		name = "cliff grunt vignette",
		
		convo = cliff_grunt_vo,
		vobank = CliffGruntVOBank,
		show = "comp_cliff_grunt",
		volume = cliff_grunt_vo.volume,
		vip = CHARACTER_SPARTANS.buck,
		control = "dc_cliff_grunt",
	};

global BansheeVignetteVO:table =
	{
		name = "banshee vignette",
		
		convo = banshee_scripted_vo,
		vobank = BansheeVOBank,
		show = "co_banshee_fix",
		volume = VOLUMES.tv_banshee_fix,
		control = "dc_banshee",
		--vip = CHARACTER_SPARTANS.locke,
	};
	
global WraithVignetteVO:table =
	{
		name = "wraith vignette",
		--convo = wraith_interact_vo,
		vobank = WraithVOBank,
		show = "co_wraith_base",
		volume = wraith_interact_vo.volume,
		--vip = CHARACTER_SPARTANS.tanaka,
	};
	
global ArbiterVignetteVO:table =
	{
		name = "arbiter vignette",
		convo = ask_arbiter_vo,
		vobank = ArbiterVOBank,
		show = "comp_arbiter_1st",
		volume = ask_arbiter_vo.volume,
		--vip = CHARACTER_SPARTANS.locke,
	};
	
global MedicalVignetteVO:table =
	{
		name = "medical vignette",
		convo = medical_tent_scripted_vo,
		vobank = MedicalVOBank,
		show = "comp_medics_1st",
		volume = VOLUMES.tv_medicalbase,
		--vip = CHARACTER_SPARTANS.locke,
	};
	
global RuinsVignetteVO:table =
	{
		name = "ruins vignette",
		convo = ruins_vo,
		--vobank = MedicalVOBank
		volume = ruins_vo.volume,
		--show = "",
		vip = CHARACTER_SPARTANS.locke,
	};
	
--put the volume in the convo if necessary
--global DoorVignetteVO:table =
--	{
--		name = "doorvignette",
--		--convo = ask_arbiter_vo,
--		vobank = DoorVOBank,
--		show = "comp_big_door",
--		volume = VOLUMES.tv_door_elite,
--		--vip = CHARACTER_SPARTANS.locke,
--	};

	global EliteGruntVO:table =
	{
		name = "elitegruntvignette",
		convo = elitegrunt_vo,
		vobank = EliteGruntVOBank,
		--show = "comp_big_door",
		volume = VOLUMES.tv_elite_grunt,
		
	};
	
global ElitesSecretVO:table =
	{
		name = "Secret Elites",
		convo = secret_elite_vo,
		--vobank = DoorVOBank,
		show = "comp_elites_talk_secretively",
		volume = VOLUMES.tv_elites_secret,
		--vip = CHARACTER_SPARTANS.locke,
	};

function nar_turn_off_interact()
device_set_power (OBJECTS.dc_banshee, 0);
device_set_power (OBJECTS.dc_cliff_grunt, 0);
end

function nar_turn_on_interact()
	device_set_position_immediate ( OBJECTS.dc_banshee, 0 );
	device_set_power (OBJECTS.dc_banshee, 1);
	device_set_position_immediate ( OBJECTS.dc_cliff_grunt, 0 );
	device_set_power (OBJECTS.dc_cliff_grunt, 1);
end


---- ============================================================================================================
--  Chatter
---- ============================================================================================================


function nar_camp_turn_chatter_on()

	print("CHATTER ON");
		b_campsite_idle_chatter_on = true;
	sleep_rand_s(45,65);
			SleepUntil( [| b_collectible_used == false ], 1);
		print("CHECKING if i am in a chatter zone or if I am in a crit path convo")

		if b_campsite_idle_chatter_on == true then
		print("YAY CHATTER")
			if b_camp_chatter_4_played == true and b_camp_chatter_5_played == false and b_campsite_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W2Hub1stVisit_TEAM_CHATTER_05);
				b_camp_chatter_5_played = true;
			
			elseif b_camp_chatter_3_played == true and b_camp_chatter_4_played == false and b_campsite_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W2Hub1stVisit_TEAM_CHATTER_04);
				b_camp_chatter_4_played = true;
			
			elseif b_camp_chatter_2_played == true and b_camp_chatter_3_played == false and b_campsite_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W2Hub1stVisit_TEAM_CHATTER_03);
				b_camp_chatter_3_played = true;
			elseif b_camp_chatter_1_played == true and b_camp_chatter_2_played == false and b_campsite_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W2Hub1stVisit_TEAM_CHATTER_02);
				b_camp_chatter_2_played = true;
			elseif b_camp_chatter_1_played == false and b_campsite_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W2Hub1stVisit_TEAM_CHATTER_01);
				b_camp_chatter_1_played = true;
			end
		else 
		print("NO CHATTER, try next time again")
	end
	CreateThread(nar_camp_turn_chatter_on);

end

function nar_camp_turn_chatter_back_on()
	sleep_s(5);
	b_campsite_idle_chatter_on = false;
end

function nar_camp_no_chatter_zone()

	SleepUntil( [| volume_test_players(VOLUMES.tv_halsey) or volume_test_players(VOLUMES.tv_palmer) or volume_test_players(VOLUMES.tv_arbiter_base) or volume_test_players(VOLUMES.tv_story_grunt)],1);
	
		if volume_test_players(VOLUMES.tv_halsey) and b_halsey_scene_played == false then
		print("CHATTER OFF");
			b_campsite_idle_chatter_on = false;
		
			NarrativeQueue.InterruptConversation(W2Hub1stVisit_TEAM_CHATTER_01);
			NarrativeQueue.InterruptConversation(W2Hub1stVisit_TEAM_CHATTER_02);
			NarrativeQueue.InterruptConversation(W2Hub1stVisit_TEAM_CHATTER_03);
			NarrativeQueue.InterruptConversation(W2Hub1stVisit_TEAM_CHATTER_04);
			NarrativeQueue.InterruptConversation(W2Hub1stVisit_TEAM_CHATTER_05);
			
		elseif volume_test_players(VOLUMES.tv_palmer) then
		print("CHATTER OFF");
			b_campsite_idle_chatter_on = false;
		
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_01);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_02);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_03);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_04);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_05);
		elseif volume_test_players(VOLUMES.tv_arbiter_base) and b_arbiter_scene_played == false then
			b_campsite_idle_chatter_on = false;
		print("CHATTER OFF");
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_01);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_02);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_03);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_04);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_05);

		elseif volume_test_players(VOLUMES.tv_story_grunt) then
			b_campsite_idle_chatter_on = false;
		print("CHATTER OFF");
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_01);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_02);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_03);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_04);
			NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_05);

		end
			sleep_s(5);
			CreateThread(nar_camp_no_chatter_zone);

end

function nar_camp_chatter_off_vo()

		b_campsite_idle_chatter_on = false;
		
		NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_01);
		NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_02);
		NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_03);
		NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_04);
		NarrativeQueue.EndConversationEarly(W2Hub1stVisit_TEAM_CHATTER_05);
end



global W2Hub1stVisit_TEAM_CHATTER_01 = {
	name = "W2Hub1stVisit_TEAM_CHATTER_01",

	CanStart = function (thisConvo, queue)
		return b_collectible_used == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
CreateThread(nar_turn_off_interact);
	end,

	lines = {
		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "The Master Chief worked with Cortana for awhile, right?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02500.sound'),
		},
		[2] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Yes. Chief considered her a close friend. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02300.sound'),
		},
		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "It's unusual for anyone to anthropomorphize an AI so deeply as to consider them a friend.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02600.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Unusual, but not unheard of.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_turn_on_interact);
	end,

	localVariables = {},
};

global W2Hub1stVisit_TEAM_CHATTER_02 = {
	name = "W2Hub1stVisit_TEAM_CHATTER_02",

	CanStart = function (thisConvo, queue)
		return b_collectible_used == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_interact);
	end,

	lines = {
		[1] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
					sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Locke, I was reading the Blue Team file you assembled. I knew the rumors about the original Spartans... the kidnappings, the conscription. I never wanted to believe it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_03100.sound'),
		},
		[2] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
					sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Lesson I learned about history a long time ago. It's full of things you don't want to believe. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_02400.sound'),
		},
		[3] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
					sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "And getting fuller of 'em all the time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_tanaka_02200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
				CreateThread(nar_turn_on_interact);
	end,

	localVariables = {},
};

--[========================================================================[
          Grotto. idle chatter sanghelios
--]========================================================================]
global W2Hub1stVisit_TEAM_CHATTER_03 = {
	name = "W2Hub1stVisit_TEAM_CHATTER_03",
	CanStart = function (thisConvo, queue)
		return b_collectible_used == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_interact);
	end,

	lines = {
		[1] = {

			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I thought Sanghelios would be... different.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_01900.sound'),
		},
		[2] = {			
		If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You'd be surprised how much we have in common with the Sangheili!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02700.sound'),
		},
		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "For instance, they place huge importance on family and honor. What could be more human than that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_turn_on_interact);
	end,

	localVariables = {},
};



--[========================================================================[
          Tsunami. chatter. Halsey

          OSIRIS - DISCUSS HALSEY & BLUE TEAM
--]========================================================================]
global W2Hub1stVisit_TEAM_CHATTER_04 = {
	name = "W2Hub1stVisit_TEAM_CHATTER_04",

	CanStart = function (thisConvo, queue)
		return b_collectible_used == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_interact);
	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "After all Halsey did to the Master Chief and Blue Team, and when they were kids no less -- After all that, she still acts like she cares about them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_02000.sound'),
		},
		[2] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Psych eval says Halsey thinks of the Chief as her son. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02500.sound'),
		},
		[3] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "She has a motherly attitude towards all of her Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_locke_02600.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "I'm glad I haven't read that psych report. Not sure I'd ever feel clean again.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_turn_on_interact);
	end,

	localVariables = {},
};



--[========================================================================[
          Tsunami. chatter. Halsey

          OSIRIS - BUCK HISTORY
--]========================================================================]
global W2Hub1stVisit_TEAM_CHATTER_05 = {
	name = "W2Hub1stVisit_TEAM_CHATTER_05",

	CanStart = function (thisConvo, queue)
		return b_collectible_used == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_interact);
	end,

	lines = {
		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "I meant to ask, Buck. Did you get any word to Veronica before we left?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_02900.sound'),
		},
		[2] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Yep. But she's working, so I don't expect she'll hear my call for a few weeks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_02200.sound'),
		},
		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How does that work? Veronica in ONI, you're both always at opposite ends of the galaxy?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_vale_03000.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_campsite_idle_chatter_on == true and b_collectible_used ~= true;
			end,
			sleepBefore = 1,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "It works fine. The times we're in the same place make up for the times we're not.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub1stvisit\001_vo_scr_w2hub1stvisit_un_buck_02300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_turn_on_interact);
	end,

	localVariables = {},
};
