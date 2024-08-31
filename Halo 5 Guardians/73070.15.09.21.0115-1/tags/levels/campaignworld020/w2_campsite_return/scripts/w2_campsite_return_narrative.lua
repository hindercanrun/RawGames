--## SERVER

global b_halsey_wake:boolean = false;
global b_palmer_wake:boolean = false;

global b_palmer_first_interaction:boolean = false;
global b_halsey_explanation:boolean = false;
global b_phantom_chunks:number = 1;
global b_arbiter_chunks:number = 1;
global b_halsey_convos:boolean = false;

global b_halsey_pre_palmer_line:number = 0;
global b_halsey_pre_palmer_nudge_line:number = 1;
global b_players_talked_halsey:boolean = false;

global b_player_back_to_palmer:number = 1;

global n_medic_scenes_2nd:number = 0;

global b_palmer_is_speaking_obj_1:boolean = false;

global b_player_answered_to_halsey:boolean = false;

global b_constructor_sounds:boolean = false;


----------------------------		NEED TO DISABLE AI VO FROM ELITES		---------------------------------------
----------------------------		NEED TO DISABLE AI VO FROM ELITES		---------------------------------------
----------------------------		NEED TO DISABLE AI VO FROM ELITES		---------------------------------------





---- =====================================================================================
---- INTRO VO
---- =====================================================================================

--[========================================================================[
          Ext. LANDING PAD

          The Constructor flies off to toward HALSEY.
--]========================================================================]
global W2Hub2ndVisit_Ext__LANDING_PAD = {
	name = "W2Hub2ndVisit_Ext__LANDING_PAD",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepBefore = 1,

	lines = {
		[1] = {
			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,				

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There goes the Constructor. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_vale_01000.sound'),
		},
		[3] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "When it activates the Guardian, we hit Sunaion. Let's report in to Palmer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
		hud_hide_radio_transmission_hud();
		campsite_return_palmer_listener();
		PrintNarrative("QUEUE - W2Hub2ndVisit_palmer_first_interact");					
		NarrativeQueue.QueueConversation(W2Hub2ndVisit_palmer_first_interact);
		PrintNarrative("QUEUE - W2Hub2ndVisit_Ext__push_forward_for_palmer");
		NarrativeQueue.QueueConversation(W2Hub2ndVisit_Ext__push_forward_for_palmer);
		CreateMissionThread(PushForwardVO);
		PushForwardVOReset(30);
		CreateMissionThread(hub_return_constructor);

	end,
};





function hub_return_constructor()
repeat
	SleepUntil([| b_constructor_sounds and objects_distance_to_object( players(), ai_get_object(AI.sq_constructor.spawnpoint) ) < 12], 10);

	PrintNarrative("QUEUE - W2Hub2ndVisit_constructor_sounds");
	NarrativeQueue.QueueConversation(W2Hub2ndVisit_constructor_sounds);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W2Hub2ndVisit_constructor_sounds)], 10);

	sleep_s(random_range(5,20));

until not b_constructor_sounds

end



--[========================================================================[
          Ext. LANDING PAD

          The Constructor flies off to toward HALSEY.
--]========================================================================]
global W2Hub2ndVisit_constructor_sounds = {
	name = "W2Hub2ndVisit_constructor_sounds",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_line_play = random_range(1,6)
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 1;
			end,

			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_confirmed.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 2;
			end,
			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_lookatdevice.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 3;
			end,

			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_lookatguardian.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 4;
			end,

			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 5;
			end,

			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_travelstart.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 6;
			end,

			character = AI.sq_constructor.spawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_trysomething.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {
						s_line_play = nil,
						},
};



--[========================================================================[
          Ext. LANDING PAD

          The Constructor flies off to toward HALSEY.
--]========================================================================]
global W2Hub2ndVisit_Ext__push_forward_for_palmer = {
	name = "W2Hub2ndVisit_Ext__push_forward_for_palmer",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and b_push_forward_vo_counrdown_on >= 45 and device_get_position( Palmer2ndObjVO.dev ) == 0 and not volume_test_players( VOLUMES.tv_palmer ) and IsSpartanAbleToSpeak(SPARTANS.locke) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, let's go report to Palmer",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
		hud_hide_radio_transmission_hud();
	end,

	--localVariables = {},
};



---- =====================================================================================
---- Phantom Base VO Bank
---- =====================================================================================

global PhantomBankData = {

    {	-- Sequence 1
		name = "phantom seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_phantom_pad.sp_elite_02,
				text = "Everything is ready to go.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01300.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "phantom seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				character = AI.sq_phantom_pad.sp_elite_01,
				text = "Just waiting for the signal.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01400.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "phantom seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_phantom_pad.sp_elite_01,
				text = "The Arbiter will be pleased.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01500.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "phantom seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_phantom_pad.sp_elite_01,
				text = "Systems green.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01600.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "phantom seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_phantom_pad.sp_elite_02,
				text = "The troops seem inspired.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00100.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "phantom seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_phantom_pad.sp_elite_02,
				text = "The fleet is ready and waiting.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00200.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "phantom seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_phantom_pad.sp_elite_02,
				text = "Good work prepping the Phantom.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00300.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "phantom seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_phantom_pad.sp_elite_02,
				text = "The fleet is fully loaded.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00400.sound'),
			},
		},
	},
		--OnFinish = function() end,

};


-- PHANTOM ELITES VO LINES
global PhantomVO_convos_2nd = {
	name = "PhantomVO_convos_2nd",

	volume = VOLUMES.tv_phantom_pad,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		print("PhantomVO_convos_2nd");
		PushForwardVOReset();
	end,

	-- DIALOG
	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_phantom_chunks == 1;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "When will the Arbiter be departing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "Once he gives the signal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01700.sound'),
		},
		[3] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "I am watching for it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01800.sound'),
		},
		[4] = {
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "Tell me when you see it. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00600.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_phantom_chunks = 2;
				return 0;
			end,
		},
--           Chunk 2

		[5] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_phantom_chunks == 2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "He has not signaled for the Lich yet, has he?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 10;
			end,
		},
		[6] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "You will see it as soon as I do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_01900.sound'),
		},
		[7] = {
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "The coordinates are already set. The Lich will take him straight to Sunaion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00800.sound'),
		},
		[8] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "I am aware. I will tell you when he signals.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_02000.sound'),
		},
		[9] = {
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "Very good, very good.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_phantom_chunks = 3;
				return 0;
			end,
		},
--           Chunk 3

		[10] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_phantom_chunks == 3;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "There, did you see? He gestured for the Lich!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_01000.sound'),
		},
		[11] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "He did not. He is still at the table.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_02100.sound'),
		},
		[12] = {
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "Are you sure? Are you watching his hands? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_01100.sound'),
		},
		[13] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "I am sure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_02200.sound'),
		},
		[14] = {
			character = AI.sq_phantom_pad.sp_elite_01, -- GAMMA_CHARACTER: elite05
			text = "I think we missed it. We should deploy the Lich anyway!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite05_01200.sound'),
		},
		[15] = {
			character = AI.sq_phantom_pad.sp_elite_02, -- GAMMA_CHARACTER: elite05
			text = "Hmmm... no... wait and be sure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_02300.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_phantom_chunks = 1;
				return 0;
			end,
		},
	},

	localVariables = {	
					speaker = nil,
					},
};



global PhantomVOBank:table=NarrativeLoopBank.Create( PhantomBankData, CONVO_PRIORITY.MainCharacter, .5, 50);


-- phantom mechanics
-- VO TABLES
global PhantomVignetteVO:table =
	{
		name = "phantom vignette",
		convo = PhantomVO_convos_2nd,
		vobank = PhantomVOBank,
		show = "comp_phantom_pad_2",
		volume = VOLUMES.tv_phantom_pad,
		--vip = CHARACTER_SPARTANS.locke,
	};





---- =====================================================================================
---- Arbiter VO
---- =====================================================================================

global Arbiter2ndBankData = {

    {	-- Sequence 1
		name = "arbiter seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1			
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "I understand.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_00100.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
			
		},
		--OnFinish = function() end,
	},
	{	-- Sequence 2
		name = "arbiter seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "The plan is sound.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_00200.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "arbiter seq 3",
		--OnStart = function() end,
		lines = {
			{	-- Sequence 1, Line 2
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Now we wait for the signal.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_02000.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "arbiter seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Our vehicles are ready to move.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_02300.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "arbiter seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "We will move on your orders, Arbiter.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_00300.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "arbiter seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_01,
				text = "The attack plan is clear.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite01_00400.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "arbiter seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "Sunaion awaits.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_02100.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "arbiter seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
					return not b_palmer_is_speaking_obj_1;		--	Since Thse Elites are near palmer, I mute then with this boolean when Palmer is speaking to us.
				end,
				character = AI.sq_arbiter_crew.sp_advisor_02,
				text = "My tasks are completed, Arbiter.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_02200.sound'),
			},
		},
	},

		--OnFinish = function() end,
};



-- ARIBTER & PALMER VO LINES
global arbiter2nd_vo = {
	name = "arbiter2nd_vo",

	volume = VOLUMES.tv_arbiter_base,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		print("arbiter2nd_vo");
		PushForwardVOReset();
	end,

	-- DIALOG
	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				print("Arbiter Palmer Chunk 1");
				return b_arbiter_chunks == 1;									
			end,
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "Everything is prepared. We will begin when the Constructor is ready.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01100.sound'),

			playDurationAdjustment = 0.95,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[2] = {
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "Doctor Halsey said the calibration could take days.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_00500.sound'),

			playDurationAdjustment = 0.95,
		},
		[3] = {
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "Then we will begin without it. I have waited too long to let this opportunity pass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01200.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_arbiter_chunks = 2;
				return 0;
			end,
		},
--           Chunk 2

		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				print("Arbiter Palmer Chunk 2");
				return b_arbiter_chunks == 2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "What did you think of our Sunaion attack heading alterations?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_00600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 8;
			end,
		},
		[5] = {
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "It is not the kind of plan I would expect from a human. You suggest flying low and close to structures. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01300.sound'),
		},
		[6] = {
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "Are you saying your pilots aren't up to the challenge?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_00700.sound'),
		},
		[7] = {
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "I am moments from a decisive victory for my home planet, Commander Palmer. Do not try to goad me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_arbiter_chunks = 3;
				return 0;
			end,
		},
--           Chunk 3

		[8] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				print("Arbiter Palmer Chunk 3");
				return b_arbiter_chunks == 3;														
			end,

			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "Today, the Covenant's spine will be broken. It is a glorJust waiting for the signalious day for the Sangheili. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01500.sound'),
		},
		[9] = {
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "You will have humanity's best beside you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_00800.sound'),
		},
		[10] = {
			character = AI.sq_arbiter.sp_arbiter_arbiter, -- GAMMA_CHARACTER: Arbiter
			text = "I will not. I pray your Spartans will suffice.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_arbiter_01600.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_arbiter_chunks = 1;
				return 0;
			end,
		},
	},

	localVariables = {	
					speaker = nil,
					},
};


-- BANKS
global Arbiter2ndVOBank:table=NarrativeLoopBank.Create( Arbiter2ndBankData, CONVO_PRIORITY.MainCharacter, 0.9, 120);

-- VO TABLES
global Arbiter2ndVignetteVO:table =
	{
		name = "arbiter vignette",
		convo = arbiter2nd_vo,
		vobank = Arbiter2ndVOBank,
		show = "comp_arbiter_2nd",
		volume = arbiter2nd_vo.volume,
		--vip = CHARACTER_SPARTANS.locke,
	};



---- =====================================================================================
---- HALSEY VO
---- =====================================================================================



function campsite_return_halsey_listener()
	
	sleep_s(1);
	--	Register interact for Halsey
	RegisterInteractEvent( campsite_return_halsey_launcher, OBJECTS.devcon_goto_halsey);
	print("Halsey interact Registered");

end


function campsite_return_halsey_launcher(dev:object, player_interacted:object)
	
	--	feed the player that interacted
	Halsey2ndObj.localVariables.speaker = player_interacted;
	CreateThread(audio_campsitereturn_constructorpowerup_start);

end

--[========================================================================[
          Ext. LANDING PAD

          The Constructor flies off to toward HALSEY.
--]========================================================================]
global W2Hub2ndVisit_Ext__push_forward_for_halsey = {
	name = "W2Hub2ndVisit_Ext__push_forward_for_halsey",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and b_push_forward_vo_counrdown_on >= 45 and device_get_position( Halsey2ndObjVO.dev ) == 0 and not volume_test_players( VOLUMES.tv_palmer ) and not volume_test_players( VOLUMES.tv_halsey ) and not volume_test_players( VOLUMES.tv_medicalbase ) and not volume_test_players( VOLUMES.tv_phantom_pad ) and IsSpartanAbleToSpeak(SPARTANS.locke) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, let's go check on Halsey and the Constructor",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

};



--------------------------------------------------------------


-- Halsey VO tables
global Halsey2ndPre = {
	name = "Halsey Pre Palmer",

	CanStart = function (thisConvo, queue)			
				return objects_distance_to_object( players(), AI.sq_receptacle.sp_halsey ) < 5
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,	

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Halsey Pre Palmer");
		CreateThread(HalseyWave);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_players_talked_halsey and (objects_distance_to_object( players(), AI.sq_receptacle.sp_halsey ) < 5) and (objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) > 7);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					print("Distance: ", objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ));
			end,

			moniker = "Halsey",

			--	Only plays when player talk to Halsey before palmer and once and if Constructor is not arrived yet. (it takes some time)
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Hi Spartans, Constructor is coming this way. Check back with me later after the he had some time to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01600.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
				
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_players_talked_halsey = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_players_talked_halsey and objects_distance_to_object( players(), AI.sq_receptacle.sp_halsey ) < 5 and objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) <= 7;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			--	Only plays when player talk to Halsey before palmer and once and if Constructor has arrived.
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Good work Spartans, I'll be watching the constructor working here. You should go report to Palmer",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_players_talked_halsey = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_line == 1 and not thisConvo.localVariables.line_1_played and b_players_talked_halsey and objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) < 7;
			end,

			sleepBefore = 2,

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "The link is working perfectly...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_1_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_line == 2 and not thisConvo.localVariables.line_2_played and b_players_talked_halsey and objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) < 7;
			end,

			sleepBefore = 2,

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "The Guardian network is responding to the Constructor...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_2_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_line == 3 and not thisConvo.localVariables.line_3_played and b_players_talked_halsey and objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) < 7;
			end,

			sleepBefore = 2,

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "So much data is being transferred here...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_3_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_line == 4 and not thisConvo.localVariables.line_4_played and b_players_talked_halsey and objects_distance_to_object( ai_get_object(AI.sq_constructor.spawnpoint), OBJECTS.constructor_receptacle ) < 7;
			end,

			sleepBefore = 2,

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "It seems to be working...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_4_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},	
	},

	OnFinish = function (thisConvo, queue)
		print(thisConvo.name, "END - Player Nearby Halsey Pre Palmer");
		b_halsey_pre_palmer_line = b_halsey_pre_palmer_line + 1;
		print(thisConvo.localVariables.line_1_played);
		print(thisConvo.localVariables.line_2_played);
		print(thisConvo.localVariables.line_3_played);
		print(thisConvo.localVariables.line_4_played);
		if thisConvo.localVariables.line_1_played and thisConvo.localVariables.line_2_played and thisConvo.localVariables.line_3_played and thisConvo.localVariables.line_4_played then
			thisConvo.localVariables.line_1_played = false;
			thisConvo.localVariables.line_2_played = false;
			thisConvo.localVariables.line_3_played = false;
			thisConvo.localVariables.line_4_played = false;
			b_halsey_pre_palmer_line = 1;
		end
		PrintNarrative("QUEUE - Halsey2nd_convos");
		
	if NarrativeQueue.HasConversationFinished(Halsey2nd_convos) then
		sleep_s(.1);
		NarrativeQueue.QueueConversation(Halsey2nd_convos);
	end
		if not NarrativeQueue.IsConversationQueued(Halsey2ndPre_nudge) then
			PrintNarrative("QUEUE - Halsey2ndPre_nudge");
			NarrativeQueue.QueueConversation(Halsey2ndPre_nudge);
		end
		b_constructor_sounds = true;
	end,

	localVariables = {
						line_1_played = nil,
						line_2_played = nil,
						line_3_played = nil,
						line_4_played = nil,
						},
};




-- Halsey VO tables
global Halsey2ndPre_nudge = {
	name = "Halsey2ndPre_nudge",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Halsey Pre Palmer nudge");
		CreateThread(HalseyWave);
	end,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_nudge_line == 1 and not thisConvo.localVariables.line_1_played and b_players_talked_halsey and objects_distance_to_object( players(), ai_get_object(AI.sq_receptacle.sp_halsey)) < 7;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Report in to Palmer, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_1_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_nudge_line == 2 and not thisConvo.localVariables.line_2_played and b_players_talked_halsey and objects_distance_to_object( players(), ai_get_object(AI.sq_receptacle.sp_halsey)) < 7;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "The Constructor appears to be working.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_02100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_2_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_nudge_line == 3 and not thisConvo.localVariables.line_3_played and b_players_talked_halsey and objects_distance_to_object( players(), ai_get_object(AI.sq_receptacle.sp_halsey)) < 7;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "I'm sure that trigger-happy valkyrie is waiting to debrief you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_3_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_halsey_pre_palmer_nudge_line == 4 and not thisConvo.localVariables.line_4_played and b_players_talked_halsey and objects_distance_to_object( players(), ai_get_object(AI.sq_receptacle.sp_halsey)) < 7;
			end,
			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Palmer will want to see you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.line_4_played = true;
				return 0;
			end,

			sleepAfter = 2,
		},		
	},

	OnFinish = function (thisConvo, queue)
		b_halsey_pre_palmer_nudge_line = b_halsey_pre_palmer_nudge_line + 1;
		if (thisConvo.localVariables.line_1_played and thisConvo.localVariables.line_2_played and thisConvo.localVariables.line_3_played and thisConvo.localVariables.line_4_played) or b_halsey_pre_palmer_nudge_line > 4 then
			thisConvo.localVariables.line_1_played = false;
			thisConvo.localVariables.line_2_played = false;
			thisConvo.localVariables.line_3_played = false;
			thisConvo.localVariables.line_4_played = false;
			b_halsey_pre_palmer_nudge_line = random_range(1,4);
		end
		print(thisConvo.name, " END - Player Nearby Halsey Pre Palmer");		
	end,

	localVariables = {
						line_1_played = nil,
						line_2_played = nil,
						line_3_played = nil,
						line_4_played = nil,
						},
};
function HalseyWave()
	b_halsey_wave = true;
	Sleep (2);
	b_halsey_wave = false;
end
--------------------------------------------------------


global Halsey2ndNearby = {
	name = "HalseyNearby 2nd",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Halsey after talking to Palmer");
		CreateThread (HalseyWave2);
		PushForwardVOReset();
	end,

	--------------------------------		PLAY ONLY ONCE		----------------------------------------------------------------
	lines = {
		[1] = {
			sleepBefore = 1,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			
			text = "Osiris!  Come look at this!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00200.sound'),
		},
		[2] = {
			sleepBefore = 0.5,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			
			text = "I'm using this structure to upload the recording from Meridian into the Constructor. Make sure you're ready to go when I give the signal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01300.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)		
		hud_hide_radio_transmission_hud();
	end,
};

function HalseyWave2()
	b_halsey_wave2 = true;
	Sleep (2);
	b_halsey_wave2 = false;
end


--[========================================================================[
          ExT. Halsey AT THE receptacle

          Player approaches Halsey after taking to Palmer
--]========================================================================]
global W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle_once = {
	name = "W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle_once",

	CanStart = function (thisConvo, queue)
		return false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.3,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_halsey_explanation;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "I'm using this structure to upload the recording from Meridian into the Constructor. Make sure you're ready to go when I give the signal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_halsey_explanation = true;
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)		
		hud_hide_radio_transmission_hud();
	end,
};


-----------------



global Halsey2ndObj = {
	name = "Halsey objective",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Halsey Objective");
		b_halsey_wake = true;
		PushForwardVOReset();
	end,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,							

			character = CHARACTER_SPARTANS.locke,
			text = "Standing by, Doctor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_01000.sound'),

			playDurationAdjustment = 0.7,
		},		
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "vale",

			character = CHARACTER_SPARTANS.vale,
			text = "We're ready, Doctor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_vale_01200.sound'),
			
			playDurationAdjustment = 0.7,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			character = CHARACTER_SPARTANS.tanaka,
			text = "Ready and willin'.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_tanaka_00700.sound'),
			
			playDurationAdjustment = 0.7,
		},		
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,				

			character = CHARACTER_SPARTANS.buck,
			text = "Ready any time, Doctor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_buck_01100.sound'),

			playDurationAdjustment = 0.7,
		},
		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		NarrativeQueue.InterruptConversation(Halsey2ndPre);
	end,

	sleepAfter = 0.4,

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
		W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle.localVariables.speaker = thisConvo.localVariables.speaker;
		PrintNarrative("QUEUE - W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle");
		NarrativeQueue.QueueConversation(W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle);
		
	end,

	localVariables = {
					speaker = nil,
					},
};


--[========================================================================[
          ExT. Halsey AT THE receptacle

          Player approaches Halsey after taking to Palmer
--]========================================================================]
global W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle = {
	name = "W2Hub2ndVisit_ExT__Halsey_AT_THE_receptacle",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		b_constructor_sounds = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Get comfortable. It could be hours before--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01400.sound'),

			playDurationAdjustment = 0.2,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();			
			end,
		},
		[2] = {
			--character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_lookatguardian.sound'),

			--playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				-- PLAYER LOOK AT
			end,
		},
		[3] = {
			character = AI.sq_constructor.spawnpoint,
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),

			playDurationAdjustment = 0,
		},
		[4] = {
			character = AI.sq_constructor.spawnpoint,
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),					
		},
		[5] = {
			character = AI.sq_constructor.spawnpoint,
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_confirmed.sound'),			

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID			
				cs_run_command_script (AI.sq_constructor.spawnpoint, "cs_contructor_end");
			end,
		},
		[6] = {
			character = AI.sq_constructor.spawnpoint,
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_travelstart.sound'),

			playDurationAdjustment = 0,
		},
		[7] = {
			character = AI.sq_constructor.spawnpoint,
			text = "[The Constructor makes an SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_travelstart.sound'),

			playDurationAdjustment = 0.5,

			sleepAfter = 1,
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "I take it back! It's headed for Sunaion! It's moving towards the Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01500.sound'),

			playDurationAdjustment = 0.95,
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.locke);
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter! It's time!  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_01100.sound'),

			playDurationAdjustment = 0.45,
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "vale",

			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The time has come, Kaidon! To Sunaion!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_vale_01300.sound'),

			playDurationAdjustment = 0.45,
		},
		[11] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Arbiter, the Constructor's on the move! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_tanaka_00800.sound'),

			playDurationAdjustment = 0.45,
		},
		[12] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "It's time, Arbiter! The Constructor just took off!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_buck_01200.sound'),

			playDurationAdjustment = 0.45,
		},
	},

	OnFinish = function (thisConvo, queue)
		-- FADE OUT
		hud_hide_radio_transmission_hud();
		b_TalkedToHalsey = true;
	end,

	localVariables = {
						speaker = nil,
						},
};




global Halsey2nd_convos = {
	name = "Halsey2nd_convos",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object( players(), ai_get_object(AI.sq_receptacle.sp_halsey) ) < 6;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		print("Halsey convos");
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	-- DIALOG
	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_halsey_convos and volume_test_players( VOLUMES.tv_halsey );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_receptacle.sp_halsey), 2, 40, 0, 2);
					if thisConvo.localVariables.speaker == nil then
						thisConvo.localVariables.speaker = volume_return_players( VOLUMES.tv_halsey )[1];
					end
					b_halsey_convos = true;
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "The Constructor is behaving exactly as I thought it would. I am uploading the Guardian song you recorded on Meridian. Once that is done, you should be able to activate the Guardian here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			
			--	If nobody is in the Volume near Halsey I skipped the rest of the convos. Player can come back and have it.
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER			
				if not volume_test_players( VOLUMES.tv_halsey ) then
					return 0;
				else
					return 2;
				end
			end,
		},
		[2] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "I am uploading the Guardian song you recorded on Meridian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01700.sound'),
		},
		[3] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "Once that is done, you should be able to activate the Guardian here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_01800.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.speaker == SPARTANS.locke and volume_test_object( VOLUMES.tv_halsey, SPARTANS.locke ) and not b_player_answered_to_halsey;																								--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We have a lot riding on this. Are you sure it will work?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 8;
			end,
		},
--           IF VALE

		[5] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.speaker == SPARTANS.vale and volume_test_object( VOLUMES.tv_halsey, SPARTANS.vale ) and not b_player_answered_to_halsey;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "vale",

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The Forerunner tech is thousands of years old. Are you certain it will work?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_vale_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 8;
			end,
		},
--           IF BUCK

		[6] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.speaker == SPARTANS.buck and volume_test_object( VOLUMES.tv_halsey, SPARTANS.buck ) and not b_player_answered_to_halsey;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "You really think we can ride the Guardian straight to Master Chief?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_buck_00200.sound'),

			playDurationAdjustment = 0.95,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 8;
			end,
		},
--           IF TANAKA

		[7] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.speaker == SPARTANS.tanaka and volume_test_object( VOLUMES.tv_halsey, SPARTANS.tanaka ) and not b_player_answered_to_halsey;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Got a lot of questions about this plan. Sure this is gonna work?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_tanaka_00200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 8;
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_answered_to_halsey;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Halsey",

			character = AI.sq_receptacle.sp_halsey, -- GAMMA_CHARACTER: Halsey
			text = "You believe I would mount this expedition--come to this world where most of its citizens would enjoy beheading me--you think I would do this if I were unsure?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_halsey_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER			
					b_player_answered_to_halsey = true;
				return 0;
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	localVariables = {	
					speaker = nil,
					},
};




global Halsey2ndObjVO:table =
	{
		name = "Halsey 2nd obj VO",
		VOPre = Halsey2ndPre,
		VONearby = Halsey2ndNearby,
		VOObj = Halsey2ndObj,
		--VOAfterObj = Halsey2ndAfterObj,
		--ending = b_TalkedToHalsey,
		--show = "comp_halsey",
		volume = VOLUMES.tv_halsey,
		dev = OBJECT_NAMES.devcon_goto_halsey,
		trackedObj = [|ai_get_object (AI.sq_receptacle.sp_halsey)],
	};



---- =====================================================================================
---- PALMER VO
---- =====================================================================================


function campsite_return_palmer_listener()

	RegisterInteractEvent(campsite_return_palmer_launcher, OBJECTS.devcon_goto_palmer);
	print("Palmer Register Interact!");

end


function campsite_return_palmer_launcher(dev:object, player_interacted:object)

	print("Interrupt conversation: arbiter2nd_vo");
	NarrativeQueue.EndConversationEarly(arbiter2nd_vo);

	CreateMissionThread(campsite_return_palmer_launcher_2, dev, player_interacted)

end



function campsite_return_palmer_launcher_2(dev:object, player_interacted:object)
	
	Palmer2ndObj.localVariables.speaker = player_interacted;
	
	PushForwardVOReset(50);
	PrintNarrative("QUEUE - W2Hub2ndVisit_Ext__push_forward_for_halsey");
	NarrativeQueue.QueueConversation(W2Hub2ndVisit_Ext__push_forward_for_halsey);

end


---------------------------------------

global Palmer2ndNearby = {
	name = "Palmer Nearby",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter ; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Palmer");
		CreateThread (PalmerWave);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			sleepBefore = 0.5,

			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "Over Here Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_01100.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
		
	end,

	--localVariables = {},
};

function PalmerWave()
	b_palmer_wave = true;
	Sleep (2);
	b_palmer_wave = false;
end

--[========================================================================[
          


          EXT. ARBITER camp

          As the player approaches, PALMER is speaking with the
          Arbiter.
--]========================================================================]
global W2Hub2ndVisit_palmer_first_interact = {
	name = "W2Hub2ndVisit_palmer_first_interact",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), ai_get_object(AI.sq_palmer.sp_palmer) ) < 14; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_palmer_first_interaction;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer
			text = "Let us take care of the guns. Just make sure you come through with that air support.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
		b_palmer_first_interaction = true;
	end,
};




global Palmer2ndObj = {
	name = "Palmer objective",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.2,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Palmer Objective");
		b_palmer_wake = true;		
		b_arbiter_chunks = b_arbiter_chunks + 1
		if b_arbiter_chunks == 4 then b_arbiter_chunks = 1 end
		PushForwardVOReset(50);
		b_palmer_is_speaking_obj_1 = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,							

			character = CHARACTER_SPARTANS.locke,
			text = "Commander? Mission complete. Doctor Halsey has the Constructor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_locke_00900.sound'),

			playDurationAdjustment = 0.9,
		},
		
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "vale",

			character = CHARACTER_SPARTANS.vale,
			text = "Commander? We acquired a Constructor for Doctor Halsey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_vale_01100.sound'),
			
			playDurationAdjustment = 0.9,
		},		
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,				

			character = CHARACTER_SPARTANS.tanaka,
			text = "Mission complete, Commander. What's next?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_tanaka_00600.sound'),
			
			playDurationAdjustment = 0.9,
		},		
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return (thisConvo.localVariables.speaker == SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			character = CHARACTER_SPARTANS.buck,
			text = "Reporting in, Commander. Halsey's got her Constructor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_buck_01000.sound'),

			playDurationAdjustment = 0.9,
		},		
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
		hud_hide_radio_transmission_hud();
		
		CreateMissionThread(campsite_return_halsey_listener);
		PrintNarrative("QUEUE - Palmer2ndObj_2");
		NarrativeQueue.QueueConversation(Palmer2ndObj_2);
	end,

	localVariables = {
					speaker = nil,
					},
};



global Palmer2ndObj_2 = {
	name = "Palmer objective 2",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Palmer Objective");	
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "SarahPalmer",

			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer			
			text = "Good work, Osiris. Once Halsey has the Constructor sorted, Arbiter's people can move on Sunaion and I'll get her off world.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_01000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				b_palmer_is_speaking_obj_1 = false;
				b_TalkedToPalmer = true;
			end,

			sleepAfter = 2,
		},		
	},

	OnFinish = function (thisConvo, queue)
		CreateMissionThread(Palmer2ndAfterObj_on_lookat_delay);		
	end,
};

global Palmer2ndAfterObj = {
	name = "Palmer2ndAfterObj",

	--CanStart = function (thisConvo, queue)
		--return false; -- GAMMA_CONDITION
	--end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Palmer after talking to her");
		--CreateThread (PalmerWave2);
		PushForwardVOReset();
	end,

	--sleepBefore = 1.5,

	lines = {
		[1] = {
			--	Plays when the players comes back to Palmer after having talked to her but not yet to Halsey. added some randomness so that it doesn't play every time.
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false; -- b_player_back_to_palmer == 10 and random_range(1,2) == 1;
			end,
			
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer			
			text = "Have you check with Halsey, Spartan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				--b_player_back_to_palmer =  2;
				return 0;
			end,

			--sleepAfter = 2,
		},
		
	},

	OnFinish = function (thisConvo, queue)		
	end,
};

function PalmerWave2()
	b_palmer_wave2 = true;
	Sleep (2);
	b_palmer_wave2 = false;
end



global Palmer2ndAfterObj_on_lookat = {
	name = "Palmer2ndAfterObj_on_lookat",

	CanStart = function (thisConvo, queue)
		return NarrativeQueue.HasConversationFinished(arbiter2nd_vo) and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_palmer.sp_palmer), 4, 20); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " Player Nearby Palmer after talking to her - and looking at Palmer when convos with Arbiter is done.");
		--b_palmer_wave2 = true;
		--Sleep (2);
		--b_palmer_wave2 = false;
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			--	Plays when the players comes back to Palmer after having talked to her but not yet to Halsey. added some randomness so that it doesn't play every time.
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_player_back_to_palmer == 1;
			end,
			
			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer			
			text = "Have you check with Halsey, Spartan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_player_back_to_palmer =  2;
				return 0;
			end,
		},
		[2] = {
			--	Plays when the players comes back to Palmer after having talked to her but not yet to Halsey. added some randomness so that it doesn't play every time.
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_player_back_to_palmer == 2 ;
			end,

			character = AI.sq_palmer.sp_palmer, -- GAMMA_CHARACTER: Palmer			
			text = "Why is it taking so long. Have you talked to Halsey Spartan?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_un_palmer_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_player_back_to_palmer =  1;
				return 0;
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)		
		CreateMissionThread(Palmer2ndAfterObj_on_lookat_delay);		
	end,
};

function Palmer2ndAfterObj_on_lookat_delay()

	sleep_s(15);

	SleepUntil([| not volume_test_players( VOLUMES.tv_palmer)], 10);

	--	sleep_s(5);

	PushForwardVOReset(50);
	
	PrintNarrative("QUEUE - Palmer2ndAfterObj_on_lookat");
	NarrativeQueue.QueueConversation(Palmer2ndAfterObj_on_lookat);

end


global Palmer2ndObjVO:table =
	{
		name = "Palmer 2nd obj VO",
		VONearby = Palmer2ndNearby,
		VOObj = Palmer2ndObj,
		VOAfterObj = Palmer2ndAfterObj,
		--show = "comp_palmer",
		volume = VOLUMES.tv_palmer,
		dev = OBJECT_NAMES.devcon_goto_palmer,
		trackedObj = [| ai_get_object (AI.sq_palmer.sp_palmer)],
		--ending = b_TalkedToPalmer,
	};




---- =====================================================================================
---- Medical Tent VO Bank
---- =====================================================================================

global MedicalBankData2nd = {
    {	-- Sequence 1
		name = "medical seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "Stabilize the existing patients.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02200.sound'),
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
				character = AI.sq_medical.sp_medics_03,
				text = "Get the equipment ready to move.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02300.sound'),
			},
		},
	},
	{	-- Sequence 3
		name = "medical seq 3",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 3, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "I have reserve disinfectant.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02400.sound'),
			},
		},
	},
	{	-- Sequence 4
		name = "medical seq 4",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 4, Line 1
				character = AI.sq_medical.sp_medics_03,
				text = "We are only prepared for one or two transfusions. ",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02500.sound'),
			},
		},
	},
	{	-- Sequence 5
		name = "medical seq 5",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 5, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "Get the scanners updated.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_00800.sound'),
			},
		},
	},
	{	-- Sequence 6
		name = "medical seq 6",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 6, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "The Swords of Sangheilios depend on us.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_00900.sound'),
			},
		},
	},
	{	-- Sequence 7
		name = "medical seq 7",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 7, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "Discharge the lightly wounded.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01000.sound'),
			},
		},
	},
	{	-- Sequence 8
		name = "medical seq 8",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 8, Line 1
				character = AI.sq_medical.sp_medics_01,
				text = "Clear some beds for the wounded.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01100.sound'),
			},
		},
	},
		--OnFinish = function() end,
}



global medical_tent_scripted_vo_2nd = {
	name = "medical_tent_scripted_vo_2nd",
			volume =  VOLUMES.tv_medicalbase,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 0;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: Elite02
			text = "The Arbiter anticipates heavy resistance from Sunaion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite03
			text = "We will be prepared. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01200.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 0;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: Elite02
			text = "When we have multiple patients, who do we treat first?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02700.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 0;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE03
			text = "Begin with whoever holds the highest rank. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01300.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 1;
			end,
			character = AI.sq_medical.sp_medics_03,
			text = "Brother, if we treat by rank, lives will be needlessly lost.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_02900.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite01
			text = "Listen well. I once witnessed a surgeon treating a grunt's punctured lung when a Commander arrived with a broken leg.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01500.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 1;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: ELITE02
			text = "And he demanded treatment before the grunt?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_03000.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 1;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: Elite01
			text = "The Commander waited for a moment, then limped to the operating table and snapped the surgeon's neck. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01600.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 2;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: Elite01
			text = "By killing the surgeon, the Commander endangered his troops. With no medical staff--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_03200.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE01
			text = "By returning Commanders to the front lines, we avoid further casualties.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01800.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 2;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: ELITE02
			text = "Namely our own.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_03300.sound'),
		},
		[12] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 2;
			end,
			character = AI.sq_medical.sp_medics_01, -- GAMMA_CHARACTER: ELITE01
			text = "Call it cowardice if you will. But if we are dead, brother, who would care for the wounded?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite03_01900.sound'),
		},
		[13] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_scenes_2nd == 2;
			end,
			character = AI.sq_medical.sp_medics_03, -- GAMMA_CHARACTER: Elite02
			text = "We have traded my honor in battle for a chance to save lives. Cowardice is far from either of us, brother.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hub2ndvisit\001_vo_scr_w2hub2ndvisit_cv_elite02_03400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		if n_medic_scenes_2nd == 0 then
			n_medic_scenes_2nd = 1;
		elseif n_medic_scenes_2nd == 1 then
			n_medic_scenes_2nd = 2;
		elseif n_medic_scenes_2nd == 2 then
			n_medic_scenes_2nd = 3;
		end
	end,

	localVariables = {},
};


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




global MedicalVOBank2nd:table=NarrativeLoopBank.Create( MedicalBankData2nd, CONVO_PRIORITY.MainCharacter, 0.9, 120);
global guardVOBank:table=CreateRandomizedBank(guardbankData);



global MedicalVignetteVO2nd:table =
	{
		name = "medical 2nd vignette",
		convo = medical_tent_scripted_vo_2nd,
		vobank = MedicalVOBank2nd,
		show = "co_medic_base",
		volume = VOLUMES.tv_medicalbase,
		--vip = CHARACTER_SPARTANS.locke,
	};
