--## SERVER

global b_medic_nearby:boolean = false;
global b_medic_activated:boolean = false;
global b_medic_nearby2:boolean = false;
global n_medic_crit_path:number = 0;
global n_science_crit_path:number = 0;
global n_whub_gen_convo_marine_male_medic:number = nil;
global n_whub_gen_convo_marine_male_fore:number = nil;
global b_medic_ready_to_talk:boolean = false;
global b_fore_ready_to_talk:boolean = false;

global W1Station_citizen_reaction = {
	name = "W1Station_citizen_reaction",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
		
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_mhub_miner_patrol_female_01, -- GAMMA_CHARACTER: Minerfemale05
			text = "Not too excited about kissing the behinds of UNSC.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01500.sound'),
		},
		--[2] = {
		--	character = AI.sq_mhub_miner_patrol_female_02, -- GAMMA_CHARACTER: Minerfemale05
	--		text = "Come on, they saved our bacon. Least we can do is welcome them.",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01600.sound'),
	--	},

	},

	OnFinish = function (thisConvo, queue)
		
		AIDialogManager.EnableAIDialog();
	end,

	localVariables = {},
};

-- CRIT PATH VO

-- MEDIC CRIT PATH VO
global MedicNearby = {
	name = " Medical Nearby",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,
			sleepBefore = 1,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " Player Nearby Medical NPC");
		b_medic_nearby = true;
		Sleep (2);
		b_medic_nearby = false;
	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 0; 
			end,
			
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MinerFEmale04
			text = "What happened over at the comms tower, Ed?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00100.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 0;
			end,
			
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_object(AI.sq_medic_station_miner.sp_hurt_miner_1, true, ai_get_object(AI.sq_medic_station.sp_medic_1));
			end,
			
				sleepBefore = 1,
			character = AI.sq_medic_station_miner.sp_hurt_miner_1, -- GAMMA_CHARACTER: Minermale03
			text = "A station signal was coming through, distress call, but then the tower caught fire, and...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_01800.sound'),
			
		},
--           Chunk 2

		[3] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 0;
			end,
				sleepBefore = 0.5,		
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MinerFEmale04
			text = "Okay, Ed. Just relax. Your painkillers should kick in soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00200.sound'),
		},
		[4] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station_miner.sp_hurt_miner_1, -- GAMMA_CHARACTER: Minermale03
			text = "We heard yelling about things coming up out the caves, then screams, then ... nothing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_01900.sound'),
		},
--           Chunk 3

		[5] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Did you hear anything else? Any other transmissions?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01100.sound'),
		},
		[6] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station_miner.sp_hurt_miner_1, -- GAMMA_CHARACTER: Minermale03
			text = "There was nothing else. The signal went dead ... we couldn't signal back, there was smoke everywhere...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02000.sound'),
		},
		[7] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return n_medic_crit_path == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MinerfeMALE04
			text = "You're all right. Governor Sloan will take care of everything.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_object(AI.sq_medic_station_miner.sp_hurt_miner_1, false, ai_get_object(AI.sq_medic_station.sp_medic_1));
			end,			
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
hud_hide_radio_transmission_hud();
		if n_medic_crit_path == 0 then
			n_medic_crit_path = 1;
		elseif n_medic_crit_path == 1 then
			n_medic_crit_path = 2;
		elseif n_medic_crit_path == 2 then
			n_medic_crit_path = 3;
		end;
	end,

	--localVariables = {},
};

global MedicActivation = {
	name = "Medic Activation",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	CreateThread(nar_turn_off_all_interacts);
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, "medic activated ");
		TutorialStopAll();
		--tell the composition to continue
		--gmu -- I don't like this, I'd like to make this more foolproof
		b_medic_activated = true;
		CreateThread(nar_chatter_off_vo);

	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_medic_station.sp_medic_1)) < 3 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We might be able to help. Where was that transmission sent from?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02200.sound'),
					AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If VALE

		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_medic_station_miner.sp_hurt_miner_1)) < 3 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "MAybe we can help. Where did you say that distress signal came from?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01000.sound'),
					AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If TANAKA

		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_medic_station_miner.sp_hurt_miner_1)) < 3 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That distress signal. Where'd it come from?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01100.sound'),
					AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If BUCK

		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_medic_station_miner.sp_hurt_miner_1)) < 3 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Anything we can do to help? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00800.sound'),
		},
--           Response to all

		[5] = {

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_medic_ready_to_talk = true;
				--p_w1hub_gen_convo_marine_male_medic = ai_get_object(AI.sq_medic_station_miner);
				--n_whub_gen_convo_marine_male_medic = composer_play_show("ci_generic_male_marine_medic");
				--cs_look_player(AI.sq_medic_station_miner, true);
			end,
					
			sleepBefore = 0.5,
			character = AI.sq_medic_station_miner.sp_hurt_miner_1, -- GAMMA_CHARACTER: Minermale03
			text = "Can you believe this? UNSC swooping down to take our claim ... tell you what, our folks at Apogee are plenty strong. Don't think you vultures can pick the bones so fast.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02100.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_whub_gen_convo_marine_male_medic);
				b_medic_ready_to_talk = false;
			end,
						
		},
--           To all, in-helmet

		[6] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Wait, what'd he say? Apogee? Think that's our location.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00900.sound'),
			sleepAfter = 1,
		},

	},

	OnFinish = function (thisConvo, queue)
	CreateThread(nar_turn_on_all_interacts);
	hud_hide_radio_transmission_hud();
	AIDialogManager.EnableAIDialog();
	CreateThread(sloan_convo_complete);
		if b_first_clue_finished == true and b_second_clue_finished == false then
			b_second_clue_finished = true;
		elseif b_first_clue_finished == false and b_second_clue_finished == false then
			b_first_clue_finished = true;
		end
	end,
	
	--localVariables = {},
};


global MedicAfterActivation = {
	name = "Medic After Activation",
			sleepBefore = 4,
	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " Halsey After Activation");
		b_medic_nearby2 = true;
		Sleep (2);
		b_medic_nearby2 = false;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERMALE04
			text = "I've done what I can, but we can't offer much in the way of intensive care.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01400.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "Just get everyone stable. Treat the inhalation injuries first, then the glass burns.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00300.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MinerMALE01
			text = "Should we start a distress call? If it gets bad, we might have to contact--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01500.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "When it gets bad? It's already pretty damn bad. Tend to your patients and let Sloan handle the politics.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00400.sound'),
		},
--           Chunk 2

		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERmale04
			text = "How are we so low on supplies?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01600.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Liang-Dortmund said their milestones weren't being hit. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00500.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERMALE04
			text = "Oh, like hell.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01700.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Governor Sloan'll sort it. He always does.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00600.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MinerMALE04
			text = "Bean counter's endangering lives, man. All because we didn't chip off as many acres of glass as they think we should have?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01800.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "Work with what we've got. Let Sloan deal with L-D-C.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00700.sound'),
		},
--           Chunk 3

		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Patients stabilized?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00800.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: Minermale01
			text = "We're actually pretty solid. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01900.sound'),
		},
		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "You're good at what you do. Supplies or not.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00900.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERMALE01
			text = "Well... thank you. But we could do more.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_02000.sound'),
		},
		[15] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "And we will. Enjoy the small victories.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
	
hud_hide_radio_transmission_hud();
		if n_medic_tent == 0 then
			n_medic_tent = 1;
		elseif n_medic_tent == 1 then
			n_medic_tent = 2;
		elseif n_medic_tent == 2 then
			n_medic_tent = 3;
		end;
	end,

	localVariables = {},
};

-- FORERUNNER ROOM/SCIENTIST CRIT PATH VO

global b_forerunner_nearby:boolean = false;
global b_forerunner_activated:boolean = false;
global b_forerunner_nearby2:boolean = false;

global ForerunnerNearby = {
	name = "Forerunner Nearby",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " Player Nearby Forerunner NPC");
		b_forerunner_nearby = true;
		Sleep (2);
		b_forerunner_nearby = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 0;
			end,
		
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Was anyone with you at the outpost?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00100.sound'),
		},
		[2] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room_miner.sp_fore_miner_01, -- GAMMA_CHARACTER: MINERMALE02
			text = "Just me. I heard we got hit here and hopped a Mongoose back. Right as I left that ship flew past in the other direction, real low.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00200.sound'),
			
		},
--           Chunk 2

		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 1;
			end,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "What was its bearing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01600.sound'),
		},
		[4] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room_miner.sp_fore_miner_01, -- GAMMA_CHARACTER: Minermale02
			text = "Going toward the station. And it was going FAST.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01600.sound'),
		},
--           Chunk 3

		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 2;
			end,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "What do you think they were heading over to do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01700.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room_miner.sp_fore_miner_01, -- GAMMA_CHARACTER: Minermale02
			text = "Nothin' good. I figured lettin' Sloan know was my best bet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01700.sound'),
		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return n_science_crit_path == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Relax, Carter. I'll talk to Governor Sloan and see what he wants to do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00200.sound'),
		},
		
	},


	OnFinish = function (thisConvo, queue)
	
hud_hide_radio_transmission_hud();
AIDialogManager.EnableAIDialog();
		if n_science_crit_path == 0 then
			n_science_crit_path = 1;
		elseif n_science_crit_path == 1 then
			n_science_crit_path = 2;
		elseif n_science_crit_path == 2 then
			n_science_crit_path = 3;
		end;
	end,

	--localVariables = {},
};

global ForerunnerActivation = {
	name = "Forerunner Activation",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	CreateThread(nar_turn_off_all_interacts);
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, "forerunner activated ");
		TutorialStopAll();
		--tell the composition to continue
		--gmu -- I don't like this, I'd like to make this more foolproof
		b_forerunner_activated = true;
		CreateThread(nar_chatter_off_vo);
	end,

	lines = {
--           If LOCKE

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_forerunner_room.sp_fore_scient_01)) < 3 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "You saw a ship? Any markings?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02300.sound'),
								AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If VALE

		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_forerunner_room.sp_fore_scient_01)) < 3 ;
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You saw a ship as you were leaving? Any markings?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01100.sound'),
								AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If TANAKA

		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_forerunner_room.sp_fore_scient_01)) < 3 ;
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Said a ship was headin' in? Recognize the make?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01200.sound'),
								AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           If BUCK

		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_forerunner_room.sp_fore_scient_01)) < 3 ;
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That other ship you saw. UNSC livery?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01000.sound'),
								AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
--           Response to all

		[5] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--p_w1hub_gen_convo_marine_male_fore = ai_get_object(AI.sq_forerunner_room_miner);
				--n_whub_gen_convo_marine_male_fore = composer_play_show("ci_generic_male_marine_fore");
				--cs_look_player(AI.sq_forerunner_room_miner, true);
				b_fore_ready_to_talk = true;
			end,	
					
			sleepBefore = 0.5,
			character = AI.sq_forerunner_room_miner.sp_fore_miner_01, -- GAMMA_CHARACTER: Minermale02
					
			text = "Pound glass, UNSC. Not my problem if your buddies didn't tell you where they parked. Oughta \"synchronize your dropzones\" better next time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01800.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_whub_gen_convo_marine_male_fore);
				b_fore_ready_to_talk = false;
			end,
			
		},
--           To all, in-helmet

		[6] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Catch that? Sounds like it was a UNSC ship.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01300.sound'),
			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
	CreateThread(nar_turn_on_all_interacts);
	AIDialogManager.EnableAIDialog();
	hud_hide_radio_transmission_hud();
	CreateThread(sloan_convo_complete);
		if b_first_clue_finished == true and b_second_clue_finished == false then
			b_second_clue_finished = true;
		elseif b_first_clue_finished == false and b_second_clue_finished == false then
			b_first_clue_finished = true;
		end
	end,
	--localVariables = {},
};

global ForerunnerAfterActivation = {
	name = "Forerunner After Activation",

			sleepBefore = 4,
	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " Forerunner After Activation");
		b_forerunner_nearby2 = true;
		Sleep (2);
		b_forerunner_nearby2 = false;
	end,

	lines = {

		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
			character = CHARACTER_OBJECTS.sloan_pa2, -- GAMMA_CHARACTER: SLOAN
			text = "I'm still trying to get somebody from Liang-Dortmund on the horn. Something's wrong with the uplink.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_02200.sound'),
		},
		[2] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Everything on our end looks right, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00500.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "Yeah, all the hardware checks out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00500.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
					sleepBefore = 0.5,
			character = CHARACTER_OBJECTS.sloan_pa2, -- GAMMA_CHARACTER: SLOAN
			text = "Sonuva... hmm... I'll poke about some more.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_02400.sound'),
		},
--           SLOAN flickers out.

		[5] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
					sleepBefore = 2,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "You thinking what I'm thinking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00600.sound'),
		},
		[6] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: MiNERMALE02
			text = "Trying not to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00600.sound'),
		},
--           
-- 
--           Chunk 2

		[7] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 1;
			end,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Okay. But if he is... breaking down...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00700.sound'),
		},
		[8] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "Sloan's good. He's keeping himself together.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00700.sound'),
		},
		[9] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "And how long can he do that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00800.sound'),
		},
		[10] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "I don't know. Long enough for us to figure out who should run this shop without him, I guess.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00800.sound'),
		},
--           Chunk 3

		[11] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "I remember being scared when I first heard an AI was running this colony.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_00900.sound'),
		},
		[12] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "Why? AI run lots of things.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_00900.sound'),
		},
		[13] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "This is different. I mean, we don't have a replacement for him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01000.sound'),
		},
		[14] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "Sloan's getting on in years, but he's got awhile before rampancy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01000.sound'),
		},
		[15] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Have you... You've heard his voice sometimes, haven't you?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01100.sound'),
		},
		[16] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_science_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_forerunner_room.sp_fore_scient_02, -- GAMMA_CHARACTER: Minermale02
			text = "Listen, if you're worried, file a report with Liang-Dortmund. The colony's a democracy, but they can step in if their investment is endangered.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01100.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
hud_hide_radio_transmission_hud();
		if n_science_tent == 0 then
			n_science_tent = 1;
		elseif n_science_tent == 1 then
			n_science_tent = 2;
		elseif n_science_tent == 2 then
			n_science_tent = 3;
		end;
	end,

	--localVariables = {},
};

global W1Station_teleport_pad = {
	name = "W1Station_teleport_pad",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 0;
			end,
			
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_bamf_pad.miner_2, true);
			end,
			
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: Minerfemale02
			text = "This material hasn't been catalogued yet, so hands off.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00500.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_bamf_pad.miner_2, false);
			end,
			
		},
	--	[2] = {
	--		If = function(thisLine, thisConvo, queue, lineNumber)
	--			return n_bamf_pad == 0;
	--		end,
	--		
	--		OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
	--			cs_look_player(AI.sq_bamf_pad.miner_1, true);
	--		end,
			
	--		sleepBefore = 1,
	--		character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: Minermale05
	--		text = "Move along, Spartans. ",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02500.sound'),
	--		
	--		OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
	--			cs_look_player(AI.sq_bamf_pad.miner_1, false);
	--		end,
						
	--	},

		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 0;
			end,
			sleepBefore = 2,
			character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: MINERMALE05
			text = "What is this stuff, anyway?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02600.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Some of that weird metal crap they've been pullin'.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00600.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: MinERMALE05
			text = "Should we keep it out in the open like this?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02700.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "It's not in the open. There's a tarp on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00700.sound'),
		},
--           Chunk 3

		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
					
			character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: MINERMALE05
			text = "Why do we have to guard this stuff? Not like anybody's gonna swipe it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERMALE05_02800.sound'),
		},
		[7] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "They said it lit up when they grabbed it, and it might still be active.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERMALE07_00800.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: MINERMALE05
			text = "Active how? What's it gonna do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERMALE05_02900.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Beats me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00900.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_1, -- GAMMA_CHARACTER: MINERMALE05
			text = "That ... doesn't make me feel real comfortable, you know?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_03000.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_bamf_pad == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_bamf_pad.miner_2, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Yeah, well. That's why I wasn't s'posed to tell you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
hud_hide_radio_transmission_hud();
	AIDialogManager.EnableAIDialog();
		if n_bamf_pad == 0 then
			n_bamf_pad = 1;
		elseif n_bamf_pad == 1 then
			n_bamf_pad = 2;
		elseif n_bamf_pad == 2 then
			n_bamf_pad = 3;
		end;
	end,

	localVariables = {},
};


global W1Station_Landing_pad__inventory_miners = {
	name = "W1Station_Landing_pad__inventory_miners",

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
				return n_inventory_miner == 0;
			end,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: Minermale06
			text = "What did you do with the biopack seed containers? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00700.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 0;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "Packed 'em way back in habitation. It's gonna be years before we're set up for seeding.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 0;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: Minermale06
			text = "You gotta pull 'em, we need the manifest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00800.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 0;
			end,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "Yeah, in nineteen years. I'll get on it in seventeen and still be ahead of schedule.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05200.sound'),
		},
--           Chunk 2

		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 1;
			end,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: MINERMALE06
			text = "Heard we had a container leak on the last shipment? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00900.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "Yeah, we had bags of oranges mixed in with the replacement air filters. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05300.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 1;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: Minermale06
			text = "Why the hell did they put perishables in with the air filters?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01000.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 1;
			end,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "Sloan probably needs to grease some palms at the loading dock.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05400.sound'),
		},
--           Chunk 3

		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 2;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "You thought any more about that export business I came up with?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05500.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 2;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: Minermale06
			text = "You were serious about that? C'mon, man. Paperweights?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01100.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 2;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.loader, -- GAMMA_CHARACTER: Minermale05
			text = "Own a piece of Meridian, only 4.99! I'm tellin' ya, we have the supply. Just gotta build some demand.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05600.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_inventory_miner == 2;
			end,
							sleepBefore = 0.5,
			character = AI.sq_mhub_lpad_miner_01.pad_guy, -- GAMMA_CHARACTER: Minermale06
			text = "LDC own that glass, McGill. No scams.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
hud_hide_radio_transmission_hud();
	AIDialogManager.EnableAIDialog();
		if n_inventory_miner == 0 then
			n_inventory_miner = 1;
		elseif n_inventory_miner == 1 then
			n_inventory_miner = 2;
		elseif n_inventory_miner == 2 then
			n_inventory_miner = 3;
		end;
	end,

	localVariables = {},
};


-- =================================================================================================                                                       
-- *** Guards Sentry scripting ***
-- =================================================================================================
function miningtown_guards_start()
	ai_place (AI.sq_town_sentries);
	local guys = ai_actors(AI.sq_town_sentries);
	--table.dprint (guys);
	for _,val in ipairs (guys) do
		--print (val);
		CreateThread (miningtown_guards, val, "comp_guards");
	end
end

function miningtown_guards (guard:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {comp_guard = guard};
	composer_play_show(show, state);                                                                               
	
	object_set_function_variable(guard, "look_speed_scale", 0.1);
 	cs_run_command_script(object_get_ai(guard),"cs_guard_lookat");
 	
	repeat
		SleepUntil([| PlayersNearGuard(guard) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", guard);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		cs_run_command_script(object_get_ai(guard),"cs_guard_lookat");

		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearGuard(guard) ], 15);
		print ("not near guard ", guard);
	until false;
end

function PlayersNearGuard(guard:object):boolean
	if objects_distance_to_point(players(), guard) < 1 and objects_distance_to_point(players(), guard) > 0 then
		return true;
	end
end

function cs_guard_lookat()
	local local_x=math.random();
	cs_look_player(true);
	SleepUntil ([| false ], seconds_to_frames (10));
end

-- =================================================================================================                                                       
-- *** Patrol Male 1 Scripting ***
-- =================================================================================================
function f_mhub_miningtown_patrol_male_1_start():void
	local miner_male_patrol1 = ai_actors(AI.sq_mhub_miner_patrol_male_01);
	--table.dprint (guys_patrol);
	local p_m_num:number = 1;
	for _,val in ipairs (miner_male_patrol1) do
		--print (val);
		CreateThread (miningtown_guard_patrols_male1, val, "co_mhub_miner_patrol_male1_0"..p_m_num);
		p_m_num = p_m_num+1;
	end
end

function miningtown_guard_patrols_male1 (miner_male_patrol1:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {p_m1_patrol = miner_male_patrol1};
	composer_play_show(show, state);
	
	object_set_function_variable(miner_male_patrol1, "look_speed_scale", 0.1);
 	cs_run_command_script(object_get_ai(miner_male_patrol1),"cs_p_m1_patrol_lookat");
	
	repeat
		SleepUntil([| PlayersNearPatrolMale1(miner_male_patrol1) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", miner_male_patrol1);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolMale1(miner_male_patrol1) ], 15);
		print ("not near guard ", miner_male_patrol1);
	until false;
end

function PlayersNearPatrolMale1(miner_male_patrol1:object):boolean
	if objects_distance_to_point(players(), miner_male_patrol1) < 1 and objects_distance_to_point(players(), miner_male_patrol1) > 0 then
--		print ("player is this close to guard", objects_distance_to_point(players(), guard));
		return true;
	end
end

function cs_p_m1_patrol_lookat()
	local local_x=math.random();
	cs_look_player(true);
	SleepUntil ([| false ], seconds_to_frames (10));
end

-- =================================================================================================                                                       
-- *** Patrol Male 2 Scripting ***
-- =================================================================================================
function f_mhub_miningtown_patrol_male_2_start():void
	local miner_male_patrol2 = ai_actors(AI.sq_mhub_miner_patrol_male_02);
	--table.dprint (guys_patrol);
	local p_m_num:number = 1;
	for _,val in ipairs (miner_male_patrol2) do
		--print (val);
		CreateThread (miningtown_guard_patrols_male2, val, "co_mhub_miner_patrol_male2_0"..p_m_num);
		p_m_num = p_m_num+1;
	end
end

function miningtown_guard_patrols_male2 (miner_male_patrol2:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {p_m2_patrol = miner_male_patrol2};
	composer_play_show(show, state);
	
	object_set_function_variable(miner_male_patrol2, "look_speed_scale", 0.1);
 	cs_run_command_script(object_get_ai(miner_male_patrol2),"cs_p_m2_patrol_lookat");
	
	repeat
		SleepUntil([| PlayersNearPatrolMale2(miner_male_patrol2) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", miner_male_patrol2);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolMale2(miner_male_patrol2) ], 15);
		print ("not near guard ", miner_male_patrol2);
	until false;
end

function PlayersNearPatrolMale2(miner_male_patrol2:object):boolean
	if objects_distance_to_point(players(), miner_male_patrol2) < 1 and objects_distance_to_point(players(), miner_male_patrol2) > 0 then
--		print ("player is this close to guard", objects_distance_to_point(players(), guard));
		return true;
	end
end

function cs_p_m2_patrol_lookat()
	local local_x=math.random();
	cs_look_player(true);
	SleepUntil ([| false ], seconds_to_frames (10));
end

-- =================================================================================================                                                       
-- *** Patrol Female 1 Scripting ***
-- =================================================================================================
function f_mhub_miningtown_patrol_female_1_start():void
	local miner_female_patrol1 = ai_actors(AI.sq_mhub_miner_patrol_female_01);
	--table.dprint (guys_patrol);
	local p_f_num:number = 1;
	for _,val in ipairs (miner_female_patrol1) do
		--print (val);
		CreateThread (miningtown_guard_patrols_female_1, val, "co_mhub_miner_patrol_female1_0"..p_f_num);
		p_f_num = p_f_num+1;
	end
end

function miningtown_guard_patrols_female_1 (miner_female_patrol1:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( FemaleguardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {p_f1_patrol = miner_female_patrol1};
	composer_play_show(show, state);
	
	object_set_function_variable(miner_female_patrol1, "look_speed_scale", 0.1);
 	cs_run_command_script(object_get_ai(miner_female_patrol1),"cs_p_f1_patrol_lookat");

	repeat
		SleepUntil([| PlayersNearPatrolFemale1(miner_female_patrol1) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", miner_female_patrol1);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolFemale1(miner_female_patrol1) ], 15);
		print ("not near guard ", miner_female_patrol1);
	until false;
end

function PlayersNearPatrolFemale1(miner_female_patrol1:object):boolean
	if objects_distance_to_point(players(), miner_female_patrol1) < 1 and objects_distance_to_point(players(), miner_female_patrol1) > 0 then
		return true;
	end
end

function cs_p_f1_patrol_lookat()
	local local_x=math.random();
	cs_look_player(true);
	SleepUntil ([| false ], seconds_to_frames (10));
end

-- =================================================================================================                                                       
-- *** Patrol Female 2 Scripting ***
-- =================================================================================================
function f_mhub_miningtown_patrol_female_2_start():void
	local miner_female_patrol2 = ai_actors(AI.sq_mhub_miner_patrol_female_02);
	--table.dprint (guys_patrol);
	local p_f_num:number = 1;
	for _,val in ipairs (miner_female_patrol2) do
		--print (val);
		CreateThread (miningtown_guard_patrols_female_2, val, "co_mhub_miner_patrol_female2_0"..p_f_num);
		p_f_num = p_f_num+1;
	end
end

function miningtown_guard_patrols_female_2 (miner_female_patrol2:object, show:string)
		local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( FemaleguardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {p_f2_patrol = miner_female_patrol2};
	composer_play_show(show, state);

	object_set_function_variable(miner_female_patrol2, "look_speed_scale", 0.1);
 	cs_run_command_script(object_get_ai(miner_female_patrol2),"cs_p_f2_patrol_lookat");
 	
	repeat
		SleepUntil([| PlayersNearPatrolFemale2(miner_female_patrol2) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", miner_female_patrol2);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolFemale2(miner_female_patrol2) ], 15);
		print ("not near guard ", miner_female_patrol2);
	until false;
end

function PlayersNearPatrolFemale2(miner_female_patrol2:object):boolean
	if objects_distance_to_point(players(), miner_female_patrol2) < 1 and objects_distance_to_point(players(), miner_female_patrol2) > 0 then
		return true;
	end
end

function cs_p_f2_patrol_lookat()
	local local_x=math.random();
	cs_look_player(true);
	SleepUntil ([| false ], seconds_to_frames (10));
end


-- =================================================================================================                                                       
-- *** Scientist Female scripting ***
-- =================================================================================================
function f_mhub_miningtown_sci_female_start():void
	local sci_female_patrol = ai_actors(AI.sg_patrols_sci_female);
	--table.dprint (guys);
	local s_f_num:number = 1;
	for _,val in ipairs (sci_female_patrol) do
		--print (val);
		CreateThread (miningtown_sci_patrols_female, val, "co_mhub_sci_patrol_female_0"..s_f_num);
		s_f_num = s_f_num+1;
	end
end

function miningtown_sci_patrols_female (sci_female_patrol:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( FemaleguardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {s_f_patrol = sci_female_patrol};
	composer_play_show(show, state);
	
	repeat
		SleepUntil([| PlayersNearPatrolSciFemale(sci_female_patrol) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", sci_female_patrol);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolSciFemale(sci_female_patrol) ], 15);
		print ("not near guard ", sci_female_patrol);
	until false;
end

function PlayersNearPatrolSciFemale(sci_female_patrol:object):boolean
	if objects_distance_to_point(players(), sci_female_patrol) < 1 and objects_distance_to_point(players(), sci_female_patrol) > 0 then
--		print ("player is this close to guard", objects_distance_to_point(players(), guard));
		return true;
	end
end

-- =================================================================================================                                                       
-- *** Scientist Male scripting ***
-- =================================================================================================
function f_mhub_miningtown_sci_male_start():void
	local sci_male_patrol = ai_actors(AI.sg_patrols_sci_male);
	--table.dprint (guys);
	local s_m_num:number = 1;
	for _,val in ipairs (sci_male_patrol) do
		--print (val);
		CreateThread (miningtown_sci_patrols_female, val, "co_mhub_sci_patrol_male_0"..s_m_num);
		s_m_num = s_m_num+1;
	end
end

function miningtown_sci_patrols_male (sci_male_patrol:object, show:string)
		local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {s_m_patrol = sci_male_patrol};
	composer_play_show(show, state);
	
	repeat
		SleepUntil([| PlayersNearPatrolSciMale(sci_male_patrol) ], 15);
		
		--tell the vignette that the guard is bumped
		state.bumped = true;
		--put narrative here
		--NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		print("guard bumped ", sci_male_patrol);
		
		--tell vignette to reset to idle
		Sleep (2);
		state.bumped = false;
		
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearPatrolSciMale(sci_male_patrol) ], 15);
		print ("not near guard ", sci_male_patrol);
	until false;
end

function PlayersNearPatrolSciMale(sci_male_patrol:object):boolean
	if objects_distance_to_point(players(), sci_male_patrol) < 1 and objects_distance_to_point(players(), sci_male_patrol) > 0 then
--		print ("player is this close to guard", objects_distance_to_point(players(), guard));
		return true;
	end
end
-- =================================================================================================                                                       
-- *** Vignette scripting ***
-- =================================================================================================
function StartVignetteProximity (votable:table)
	local state:table = {near = false};
	if votable.show then
		composer_play_show(votable.show, state);
	end
	
	if votable.convo and votable.vobank then
		--play a random bank of audio until a player gets near, then play a conversation
		--when the conversation is done go back to playing random audio unless another player gets near or players leave volume and return
		print ("starting random vo bank and convo on random bank ", votable.name);
		local playersInVolumeAfterConvo = {};
		local playersInVolumeBeforeConvo = {};
		repeat
			--play random bank
			local DidPlay:boolean = NarrativeLoopBank.PlayNext(votable.vobank);
			--play convo if player close
			repeat
				playersInVolumeBeforeConvo = volume_return_players(votable.volume);

				--if nobody is around then reset playersInVolumeAfterConvo
				if #playersInVolumeBeforeConvo == 0 and #playersInVolumeAfterConvo ~= 0 then
				--print ("resetting playersInVolumeAfterConvo");
					playersInVolumeAfterConvo = {};
        end
							
				if table.compare(playersInVolumeBeforeConvo, playersInVolumeAfterConvo) then
				--	print ("players are still hanging around vignette");
				elseif #playersInVolumeBeforeConvo > 0 then
					print ("player near vignette");
					print (#playersInVolumeBeforeConvo);
					--kill vobank
					VignetteEndVOBank(votable);
					
					--play convo
					state.near = true;
					--get or pass in VIP here, perhaps passing into the function 
					VignettePlayConversationSecondary(votable);
						
					state.near = false;
					playersInVolumeAfterConvo = volume_return_players (votable.volume);
				end
				sleep_s (0.25);
			until not votable.vobank.currentlyPlaying;
			--SleepUntil([| not votable.vobank.currentlyPlaying ], seconds_to_frames (.25));
			
		until false;
		
	elseif votable.vobank then
		print ("starting VObank loop, no convo ", votable.name);
		repeat
			VignetteLoopVOBank(votable);
		until false;
	
	elseif votable.convo then
		print ("vo table convo with no random bank started on ", votable.name);
		repeat
			SleepUntil([| PlayersNearVignette(votable.volume) ], seconds_to_frames (.25));
			--play convo
			VignettePlayConversationSecondary(votable);
			sleep_s (0.5);
		until false;
	end
end

function VignetteLoopVOBank(votable:table)
	--print ("starting vig with convo ", votable.name);

	NarrativeLoopBank.PlayNext( votable.vobank);
	SleepUntil([| not votable.vobank.currentlyPlaying ], 15);
	sleep_s (0.5);
end

function VignettePlayConversationSecondary(votable:table)
	print ("playing the convo");
	--find the speaker

	--play the convo (pass in the VIP here)
	NarrativeQueue.QueueConversation(votable.convo);

	--sleeping to make sure the conversation is queued
	Sleep (2);
	
	--if speaker leaves kill the convo
	SleepUntil([| not PlayersNearVignette(votable.volume) or NarrativeQueue.HasConversationFinished(votable.convo) ], seconds_to_frames (0.25));
	print ("currently playing is ", NarrativeQueue.HasConversationFinished(votable.convo));

	--end the conversation if not players are around
	if not NarrativeQueue.HasConversationFinished(votable.convo) then
		print ("player left volume before convo finished");
		NarrativeQueue.EndConversationEarly(votable.convo);
	end

	SleepUntil([| NarrativeQueue.HasConversationFinished(votable.convo) ], 1);
	--a buffer before the conversation starts so the VO lines aren't back to back
	sleep_s (0.5);
end

function PlayersNearVignette(trigger:volume):boolean
	--if objects_distance_to_point(players(), guard) < 1 and objects_distance_to_point(players(), guard) > 0 then
	if volume_test_players(trigger) then
		--print ("a player is in volume ", trigger);
		return true;
	end
end

function VIPinVolume(vol:volume, vip:object):object
	local spartans = VolumeReturnSpartans (vol);
	for _,vip1 in ipairs (spartans) do
--		print (vip);
--		print (vip1);
		if vip1 == vip then
			print ("vip in volume");
			return vip1;
		end
	end
	print ("no vip in volume");
	return spartans[1];
end

-- =================================================================================================
-- *** VO Bank ***
-- =================================================================================================

global GarageBankData = {
  --  {	-- Sequence 1
--		name = "garage seq 1",
		--OnStart = function() end,
	--	lines = {
	--		{		-- Sequence 1, Line 1
			--	character = AI.sq_medic_station.sp_medic_2,
			--	text = "Old air filter's fixed.",
			--	tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02200.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
	--		},
	--	},
		--OnFinish = function() end,
--	},

    {	-- Sequence 2
		name = "garage seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 2
				character = AI.sq_garage.sp_mechanic_02,
				text = "Need another shipment of tires.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02300.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 3
		name = "garage seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 3
				character = AI.sq_garage.sp_mechanic_02,
				text = "Could use another set of tools.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02400.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 4
		name = "garage seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 4
				character = AI.sq_garage.sp_mechanic_02,
				text = "Can't fix a cracked engine block.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02500.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 5
		name = "garage seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 5
				character = AI.sq_garage.sp_mechanic_02,
				text = "Gotta scrap one of these for parts.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02600.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 6
		name = "garage seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 6
				character = AI.sq_garage.sp_mechanic_02,
				text = "I'll get to the heater next.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02700.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 7
		name = "garage seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 7
				character = AI.sq_garage.sp_mechanic_02,
				text = "Forearm's broke on the mining rig.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02800.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 8
		name = "garage seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 8
				character = AI.sq_garage.sp_mechanic_02,
				text = "Mining scoop buckled along its weld again.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_02900.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
}

global MedicalBankData = {
    {	-- Sequence 1
		name = "Medical seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_medic_station.sp_medic_2,
				text = "Watch the burns for infection.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01000.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},

    {	-- Sequence 2
		name = "Medical seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 2
				character = AI.sq_medic_station.sp_medic_1,
				text = "Just get the fevers under control.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01300.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 3
		name = "Medical seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 3
				character = AI.sq_medic_station.sp_medic_2,
				text = "Sloan has more supplies on backorder.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01100.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 4
		name = "Medical seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 4
				character = AI.sq_medic_station.sp_medic_1,
				text = "Schedule another saline drop.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01400.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 5
		name = "Medical seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 5
				character = AI.sq_medic_station.sp_medic_2,
				text = "Place isn't usually so full.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01200.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 6
		name = "Medical seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 6
				character = AI.sq_medic_station.sp_medic_1,
				text = "Still low on painkillers.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01500.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 7
		name = "Medical seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 7
				character = AI.sq_medic_station.sp_medic_2,
				text = "Monitor the patients.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale07_01300.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 8
		name = "Medical seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 8
				character = AI.sq_medic_station.sp_medic_1,
				text = "What I wouldn't give for an RN.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01600.sound'),
			--	OnStart = function() ShowTempTextNarrative("Improvised Medical Station", 1) end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
}

global ForerunnerBankData = {
    {	-- Sequence 1
		name = "Forerunner seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_forerunner_room.sp_fore_scient_01,
				text = "We'll get this figured out.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01800.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 2
		name = "Forerunner seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 5
				character = AI.sq_forerunner_room.sp_fore_scient_02,
				text = "Never seen anything like this.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01900.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 3
		name = "Forerunner seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 2
				character = AI.sq_forerunner_room.sp_fore_scient_01,
				text = "He's holding together well.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01900.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 4
		name = "Forerunner seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 6
				character = AI.sq_forerunner_room.sp_fore_scient_02,
				text = "No idea where this came from.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02000.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			}, 
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 5
		name = "Forerunner seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 3
				character = AI.sq_forerunner_room.sp_fore_scient_01,
				text = "Should work on the purifiers.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02000.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 6
		name = "Forerunner seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 8
				character = AI.sq_forerunner_room.sp_fore_scient_02,
				text = "They should have sent a metallurgist.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02200.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			}, 
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 7
		name = "Forerunner seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 4
				character = AI.sq_forerunner_room.sp_fore_scient_01,
				text = "We'll cross that bridge when we come to it.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02100.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 8
		name = "Forerunner seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 7
				character = AI.sq_forerunner_room.sp_fore_scient_02,
				text = "It's an unknown metal, that's all I know.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02100.sound'),
				--OnStart = function() ShowTempTextNarrative("Forerunner Science Room VO", 1); end,
				--OnFinish = function() end,
			}, 

		},
		--OnFinish = function() end,
	},
}

global BigDoorBankData = {
    {	-- Sequence 1
		name = "Big Door seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_big_door.sp_bigdoor_02,
				text = "It's locked up tight.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_01900.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 2
		name = "Big Door seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 2
				character = AI.sq_big_door.sp_bigdoor_01,
				text = "We're still on lockdown.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00600.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 3
		name = "Big Door seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 3
				character = AI.sq_big_door.sp_bigdoor_02,
				text = "See anything?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02000.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 4
		name = "Big Door seq 4",
		--OnStart = function() end,
		lines = {
				{		-- Sequence 4, Line 4
				character = AI.sq_big_door.sp_bigdoor_01,
				text = "Just sit tight for now.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00700.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 5
		name = "Big Door seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 5
				character = AI.sq_big_door.sp_bigdoor_02,
				text = "I'm on watch.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02100.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 6
		name = "Big Door seq 6",
		--OnStart = function() end,
		lines = {
				{		-- Sequence 6, Line 6
				character = AI.sq_big_door.sp_bigdoor_01,
				text = "Nothing to report from here.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00800.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 7
		name = "Big Door seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 7
				character = AI.sq_big_door.sp_bigdoor_02,
				text = "All gates look secure.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02200.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 8
		name = "Big Door seq 8",
		--OnStart = function() end,
		lines = {
				{		-- Sequence 8, Line 8
				character = AI.sq_big_door.sp_bigdoor_01,
				text = "Keep the shutter sealed.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00900.sound'),
				--OnStart = function() ShowTempTextNarrative("Big Door VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
}

global RightGateBankData = {
    {	-- Sequence 1
		name = "Right Gate seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_guard_01,
				text = "Keep it moving.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00100.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 2
		name = "Right Gate seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_civ_01,
				text = "Boy, look at it go.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02200.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	   {	-- Sequence 3
		name = "Right Gate seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_guard_01,
				text = "Please disperse.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00200.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 4
		name = "Right Gate seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_civ_01,
				text = "This is gonna set us back.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02300.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	   {	-- Sequence 5
		name = "Right Gate seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_guard_01,
				text = "Don't get too close.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00300.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	--   {	-- Sequence 6
	--	name = "Right Gate seq 6",
		--OnStart = function() end,
	--	lines = {
			--{		-- Sequence 1, Line 1
			--	character = AI.sq_right_gate.sp_right_civ_01,
	--			text = "Nothing we can do about it now.",
	--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02400.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
	--		},
	--		},
		--OnFinish = function() end,
	--},
	--   {	-- Sequence 6
	--	name = "Right Gate seq 6",
		--OnStart = function() end,
	--	lines = {
	--		{		-- Sequence 1, Line 1
	--			character = AI.sq_right_gate.sp_right_guard_01,
	--			text = "Everything's under control.",
	--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_03300.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
	--		},
	--		},
		--OnFinish = function() end,
--	},
	   {	-- Sequence 6
		name = "Right Gate seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_right_gate.sp_right_civ_01,
				text = "Let me get a closer look..",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02500.sound'),
				--OnStart = function() ShowTempTextNarrative("Left Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
}

global LeftGateBankData = {
    {	-- Sequence 1
		name = "Left Gate seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_guard_02,
				text = "Please maintain a safe distance.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02300.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 2
		name = "Left Gate seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_civ_01,
				text = "One hell of a setback.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00100.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	    {	-- Sequence 3
		name = "Left Gate seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_guard_02,
				text = "The fire is contained.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02400.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 4
		name = "Left Gate seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_civ_01,
				text = "Gonna take a while to fix this.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00200.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 5
		name = "Left Gate seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_guard_02,
				text = "Just stay back and let it burn out.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02500.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	    {	-- Sequence 6
		name = "Left Gate seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_civ_01,
				text = "All our work up in smoke.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00300.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	    {	-- Sequence 7
		name = "Left Gate seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_guard_02,
				text = "Can't let you through. Sloan's orders.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_02600.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
			},
		--OnFinish = function() end,
	},
	    {	-- Sequence 8
		name = "Left Gate seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_left_gate.left_civ_01,
				text = "It's a shame, a real shame.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00400.sound'),
				--OnStart = function() ShowTempTextNarrative("Right Gate VO", 1); end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
}

global BamfPadBankData = {
    {	-- Sequence 1
		name = "Bamf Pad seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_1,
				text = "Love to get a chair out here.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02100.sound'),

			},
		},
	},
	    {	-- Sequence 2
		name = "Bamf Pad seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_2,
				text = "Tough keepin' track of all this stuff.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00100.sound'),
	
			},
		},
	},
	    {	-- Sequence 3
		name = "Bamf Pad seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_1,
				text = "Nothing much to see around here.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02200.sound'),
			
			},
		},
	},
	    {	-- Sequence 4
		name = "Bamf Pad seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_2,
				text = "Don't know what's in half these crates.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00200.sound'),
	
			},
		},
	},
	    {	-- Sequence 5
		name = "Bamf Pad seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_1,
				text = "Stuff's still here.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02300.sound'),
			
			},
		},
	},
	    {	-- Sequence 6
		name = "Bamf Pad seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_2,
				text = "Break time yet?",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00300.sound'),
	
			},
		},
	},
	    {	-- Sequence 7
		name = "Bamf Pad seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_1,
				text = "We should work this in shifts.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_02400.sound'),
			
			},
		},
	},
	    {	-- Sequence 8
		name = "Bamf Pad seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_bamf_pad.miner_2,
				text = "Sloan said to hold our posts.\r\n",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale07_00400.sound'),
	
			},
		},
		--OnFinish = function() end,
	},
}


global SweepBankData = {
    {	-- Sequence 1
		name = "Sweeper seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "New system, new planet, new station ... brand new broom.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01200.sound'),

			},
		},
	},
	    {	-- Sequence 2
		name = "Sweeper seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
				text = "Never trusted that upkeep AI we had. Never swept quiiiite the right way.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01300.sound'),
	
			},
		},
	},
	    {	-- Sequence 3
		name = "Sweeper seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
			character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Can always judge an outpost by its floors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01400.sound'),
			
			},
		},
	},
	    {	-- Sequence 4
		name = "Sweeper seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Mosta this planet's glass. Seas are dry, atmo's barely hangin' on ... but damned if I'm gonna let it get dusty.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01500.sound'),
	
			},
		},
	},
	    {	-- Sequence 5
		name = "Sweeper seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Who's the greatest sweeper on Meridian? ... Well, not me. Not yet. But a man can dream.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01600.sound'),
			
			},
		},
	},
	    {	-- Sequence 6
		name = "Sweeper seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Alien attack's no reason to stop keepin' tidy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01700.sound'),
	
			},
		},
	},
	    {	-- Sequence 7
		name = "Sweeper seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Mine's no place for a guy like me. I like my skies open and my floors clean.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01800.sound'),
			
			},
		},
	},
	    {	-- Sequence 8
		name = "Sweeper seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_miner_sweep_01.sweeper,
			text = "Been savin' up for one of them laser brooms. Couple more years and she'll be mine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_01900.sound'),
	
			},
		},
		--OnFinish = function() end,
	},
}

global InventoryMinerBankData = {
    {	-- Sequence 1
		name = "Inventory Miner seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.loader,
			text = "Next shipment's already scheduled.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04700.sound'),

			},
		},
	},
	    {	-- Sequence 2
		name = "Inventory Miner seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.pad_guy,
			text = "We're a little behind schedule.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00300.sound'),
	
			},
		},
	},
	    {	-- Sequence 3
		name = "Inventory Miner seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.loader,
			text = "We'll have to find more storage.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04800.sound'),
			
			},
		},
	},
	    {	-- Sequence 4
		name = "Inventory Miner seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.pad_guy,
			text = "Crates are piling up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00400.sound'),
	
			},
		},
	},
	    {	-- Sequence 5
		name = "Inventory Miner seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.loader,
			text = "Wish the gravity was lighter here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04900.sound'),
			
			},
		},
	},
	    {	-- Sequence 6
		name = "Inventory Miner seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.pad_guy,
			text = "Still have space at Bay Three.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00500.sound'),
	
			},
		},
	},
	    {	-- Sequence 7
		name = "Inventory Miner seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_mhub_lpad_miner_01.pad_guy,
			text = "Port shift rotates soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00600.sound'),
	
			},
		},
		--OnFinish = function() end,
	},
}

global WeldingBankData = {
    {	-- Sequence 1
		name = "Welding Miners seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner,
		--	text = "It's not so bad. Nothing we can't patch up.",
		--	tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04300.sound'),

			},
		},
	},
	    {	-- Sequence 2
		name = "Welding Miners seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner2,
			text = "This is our home. We defend it when we can and fix it if we can't. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01700.sound'),
	
			},
		},
	},
	    {	-- Sequence 3
		name = "Welding Miners seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner,
			text = "It'll take more than some aliens to run us off Meridian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04400.sound'),
			
			},
		},
	},
	    {	-- Sequence 4
		name = "Welding Miners seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner2,
			text = "Doc Cale's fixin' up our people. I can handle the walls.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01800.sound'),
	
			},
		},
	},
	    {	-- Sequence 5
		name = "Welding Miners seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner,
			text = "Few more minutes and this'll be right as rain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04500.sound'),
			
			},
		},
	},
	    {	-- Sequence 6
		name = "Welding Miners seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
--				character = AI.welding_miner2,
			text = "Quick patch job here and we'll be set. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01900.sound'),
	
			},
		},
	},
}

-- BANKS
global guardVOBank:table=CreateRandomizedBank(guardbankData);
global FemaleguardVOBank:table=CreateRandomizedBank(guardFemalebankData);
global GarageVOBank:table=NarrativeLoopBank.Create( GarageBankData, CONVO_PRIORITY.NPC, 60, 80);
global MedicalVOBank:table=NarrativeLoopBank.Create( MedicalBankData, CONVO_PRIORITY.NPC, 6, 8);
global ForerunnerVOBank:table=NarrativeLoopBank.Create( ForerunnerBankData, CONVO_PRIORITY.NPC, 6, 8);
global BigDoorVOBank:table=NarrativeLoopBank.Create( BigDoorBankData, CONVO_PRIORITY.NPC, 60, 80);
global LeftGateVOBank:table=NarrativeLoopBank.Create( LeftGateBankData, CONVO_PRIORITY.NPC, 60, 80);
global RightGateVOBank:table=NarrativeLoopBank.Create( RightGateBankData, CONVO_PRIORITY.NPC, 60, 80);
global BamfPadVOBank:table=NarrativeLoopBank.Create( BamfPadBankData, CONVO_PRIORITY.NPC, 60, 80);
global SweepVoBank:table=NarrativeLoopBank.Create( SweepBankData, CONVO_PRIORITY.NPC, 60, 80);
global InventoryMinerBank:table=NarrativeLoopBank.Create( InventoryMinerBankData, CONVO_PRIORITY.NPC, 60, 80);

-- =================================================================================================
-- *** VO TABLES ***
-- =================================================================================================
global MedicalVO:table =
	{
		name = "Medical Tent Vignette",
		
		--convo = W1Station_MEDIC_TENT,
		vobank = MedicalVOBank,
		show = "co_medic_station",
		volume = VOLUMES.tv_medic_station,
		--vip = CHARACTER_SPARTANS.buck,
	};
	
global MongooseGarageVO:table =
	{
		name = "Mongoose Garage Vignette",
		
		convo = W1Station_Ext__Garage,
		vobank = GarageVOBank,
		show = "co_minetown_garage",
		volume = VOLUMES.tv_mongoose_garage,
		--vip = CHARACTER_SPARTANS.buck,
	};
	
global ForerunnerVO:table =
	{
		name = "Forerunner Vignette",
		
		--convo = nil,
		vobank = ForerunnerVOBank,
		show = "co_forerunner_room",
		volume = VOLUMES.tv_forerunner_room,
		--vip = CHARACTER_SPARTANS.buck,
	};
	
global BigDoorVO:table =
	{
		name = "Big Door Vignette",
		
		convo = W1Station_Main_back_gate,
		vobank = BigDoorVOBank,
		show = "co_big_door",
		volume = VOLUMES.tv_big_door,
		--vip = CHARACTER_SPARTANS.buck,
	};

global LeftGateVO:table =
	{
		name = "Left Gate",
		
		convo = W1Station_tower_gate,
		vobank =LeftGateVOBank,
		show = "co_left_gate",
		volume = VOLUMES.tv_left_gate,
		--vip = CHARACTER_SPARTANS.buck,
	};
	
global RightGateVO:table =
	{
		name = "Right Gate",
		
		convo = W1Station_Gate_1,
		vobank = RightGateVOBank,
		show = "co_right_gate",
		volume = VOLUMES.tv_right_gate,
		--vip = CHARACTER_SPARTANS.buck,
	};

global TeleportPadVO:table =
	{
		name = "Teleport Pad",
		
		convo = W1Station_teleport_pad,
		vobank = BamfPadVOBank,
		show = "comp_bamf_pad",
		volume = VOLUMES.tv_bamf_pad,
		--vip = CHARACTER_SPARTANS.buck,
	};


global SweepVO:table =
	{
		name = "Sweeper",
		
		vobank = SweepVoBank,
	--	show = "comp_bamf_pad",
		volume = VOLUMES.tv_sweeper_miner,
		--vip = CHARACTER_SPARTANS.buck,
	};

global InventoryMinerVO:table =
	{
		name = "Inventory Miner",

		convo = W1Station_Landing_pad__inventory_miners,
		vobank = InventoryMinerBank,
	--	show = "comp_bamf_pad",
		volume = VOLUMES.tv_inventory_miner,
		--vip = CHARACTER_SPARTANS.buck,
	};


-- Critical path VO tables
-- //these are here because the script won't compile with modules unless they are below their references -- gmu
global clue_01ObjVO:table =
	{
		name = "clue 01 obj VO",
		vobank = MedicalVOBank,
		VONearby = MedicNearby,
		VOObj = MedicActivation,
		VOAfterObj = MedicAfterActivation,
		volume = VOLUMES.tv_medic_station,
		dev = OBJECT_NAMES.devcon_clue_01,
		trackedObj = [|ai_get_object (AI.sq_medic_station_miner.sp_hurt_miner_1)],
	};
	
global clue_02ObjVO:table =
	{
		name = "Palmer 2nd obj VO",
		
		vobank = ForerunnerVOBank,
		VONearby = ForerunnerNearby,
		VOObj = ForerunnerActivation,
		VOAfterObj = ForerunnerAfterActivation,
		--show = "comp_palmer",
		volume = VOLUMES.tv_forerunner_room,
		dev = OBJECT_NAMES.devcon_clue_02,
		trackedObj = [|ai_get_object (AI.sq_forerunner_room_miner.sp_fore_miner_01)],
	};
	
	global clue_03ObjVO:table =
	{
		volume = VOLUMES.tv_mhub_breadcrumb_console,
		dev = OBJECT_NAMES.devcon_clue_03,
		trackedObj = [|OBJECTS.devcon_clue_03],
	};

function Clue01Init()
	HubVignetteDeviceControl(clue_01ObjVO);
end

function Clue02Init()
	HubVignetteDeviceControl(clue_02ObjVO);
end

function Clue03Init()
	print("__________________ clue 3 triggered 1");
	HubVignetteDeviceControl(clue_03ObjVO);
end

--### DC Terminal Controls ###############################

function f_activator_get_mhub_terminal(trigger:object, p_player:object)
	local pl:player = unit_get_player (p_player);
	local show:number = composer_play_show ("collectible", {scanner = pl});
end

--### DC Terminal Controls End ###############################

--### DC interact controls ###############################
global gb_mhub_comp_terminal_int:number = -1;

function f_activator_get_mhub_interacts(control:object, activator:object)
	local this_activator:object = activator or PLAYERS.player0 ;
	if control == OBJECTS.w1_station_interactive_console1 then
		gb_mhub_comp_terminal_int = composer_play_show("ci_console_interact_01", { ics_player = this_activator});
	end
	if control == OBJECTS.w1_station_interactive_console2 then
		gb_mhub_comp_terminal_int = composer_play_show("ci_console_interact_02", { ics_player = this_activator});
	end
	if control == OBJECTS.w1_station_interactive_console3 then
		gb_mhub_comp_terminal_int = composer_play_show("ci_console_interact_03", { ics_player = this_activator});
	end
	if control == OBJECTS.w1_station_interactive_console4 then
		gb_mhub_comp_terminal_int = composer_play_show("ci_console_interact_04", { ics_player = this_activator});
	end
	if control == OBJECTS.w1_station_interactive_console5 then
		gb_mhub_comp_terminal_int = composer_play_show("ci_console_interact_05", { ics_player = this_activator});
	end				
end
--### DC interact controls End ###############################
