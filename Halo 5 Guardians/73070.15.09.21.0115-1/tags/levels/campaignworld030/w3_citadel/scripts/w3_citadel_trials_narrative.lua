--## SERVER


--   _______ _____  _____          _       _____       _   _          _____  _____         _______ _______      ________ 
--  |__   __|  __ \|_   _|   /\   | |     / ____|     | \ | |   /\   |  __ \|  __ \     /\|__   __|_   _\ \    / /  ____|
--     | |  | |__) | | |    /  \  | |    | (___       |  \| |  /  \  | |__) | |__) |   /  \  | |    | |  \ \  / /| |__   
--     | |  |  _  /  | |   / /\ \ | |     \___ \      | . ` | / /\ \ |  _  /|  _  /   / /\ \ | |    | |   \ \/ / |  __|  
--     | |  | | \ \ _| |_ / ____ \| |____ ____) |     | |\  |/ ____ \| | \ \| | \ \  / ____ \| |   _| |_   \  /  | |____ 
--     |_|  |_|  \_\_____/_/    \_\______|_____/      |_| \_/_/    \_\_|  \_\_|  \_\/_/    \_\_|  |_____|   \/   |______|
                                                                                                                      
     

-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================

	global b_arena_comp_finished:boolean = false;

	global b_player_crossed_bridge:boolean = false;

	global b_warden_interrupt:boolean = false;

	global b_bridge_end_warden:boolean = false;

	global b_bridge_turret_respawn:boolean = false;

	global b_flashback1_end:boolean = false;
	global b_flashback2_start:boolean = false;
	global b_flashback2_end:boolean = false;

	global b_trials_hallway1_part_1:boolean = false;
	global b_trials_hallway1_part_2:boolean = false;

	global b_hallway_2_part1:boolean = false;
	global b_hallway_2_part2:boolean = false;
	
	global b_number_of_warden_dead:number = 0;

	global b_players_on_elevator_01:boolean = false;
	global b_players_on_elevator_02:boolean = false;
	
	global b_hallway_1_open_door:boolean = false;
	
	global b_trials_tower_going_to_floor_2:boolean = false;

	global b_warden_is_speaking:boolean = false;
	
	global b_main_dialogue_on:boolean = false;
	
	global b_hallway_2_door_open:boolean = false;
	
	global trials_is_there_enemy_nearby_result:boolean = false;

	global b_chatter_zeus:boolean = false;

	global trials_h4_start_emote:boolean = false;
	global trials_h4_start_b_emote:boolean = false;
	global trials_h4_start_c_emote:boolean = false;
	global trials_h4_start_d_emote:boolean = false;
	global trials_h4_start_e_emote:boolean = false;
	global trials_h4_end_emote:boolean = false;
	

	

-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================                                                                                                                 


function trials_narrative_startup()

	print("*************  TRIALS NARRATIVE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);
	
	b_push_forward_vo_timer_default = 60;

--	Force display Temp Text from TTS (Subtitles)
--	dialog_line_temp_blurb_force_set(true);

	
	CreateMissionThread(PushForwardVO);
	CreateMissionThread(trials_pushforward);
	CreateMissionThread(PushForwardVOStandBy);
	CreateMissionThread(trials_chatter);
	CreateMissionThread(trials_four_players_combat_check);
end



-- =================================================================================================															 
--  _____ _   _ _______ _____   ____  
-- |_   _| \ | |__   __|  __ \ / __ \ 
--   | | |  \| |  | |  | |__) | |  | |
--   | | | . ` |  | |  |  _  /| |  | |
--  _| |_| |\  |  | |  | | \ \| |__| |
-- |_____|_| \_|  |_|  |_|  \_\\____/ 
--
-- =================================================================================================	


-- =================================================================================================	
--  ______ _                _____ _    _ ____          _____ _  __           _    _          _      ____    _  _   
-- |  ____| |        /\    / ____| |  | |  _ \   /\   / ____| |/ /          | |  | |   /\   | |    / __ \  | || |  
-- | |__  | |       /  \  | (___ | |__| | |_) | /  \ | |    | ' /   ______  | |__| |  /  \  | |   | |  | | | || |_ 
-- |  __| | |      / /\ \  \___ \|  __  |  _ < / /\ \| |    |  <   |______| |  __  | / /\ \ | |   | |  | | |__   _|
-- | |    | |____ / ____ \ ____) | |  | | |_) / ____ \ |____| . \           | |  | |/ ____ \| |___| |__| |    | |  
-- |_|    |______/_/    \_\_____/|_|  |_|____/_/    \_\_____|_|\_\          |_|  |_/_/    \_\______\____/     |_|  
--
-- =================================================================================================	                                                                                                                 
                                                                                                                 

function trials_halo_4_flashback()
	PrintNarrative("WAKE - trials_halo_4_flashback");
	PrintNarrative("START - trials_halo_4_flashback");
	PrintNarrative("trials_halo_4_flashback - Played in the Comp");
	PrintNarrative("END - trials_halo_4_flashback");

	PrintNarrative("QUEUE - trials_intro_start_emote_chief");
	NarrativeQueue.QueueConversation(trials_intro_start_emote_chief);
	PrintNarrative("QUEUE - trials_intro_start_b_emote_chief");
	NarrativeQueue.QueueConversation(trials_intro_start_b_emote_chief);
	PrintNarrative("QUEUE - trials_intro_start_c_emote_chief");
	NarrativeQueue.QueueConversation(trials_intro_start_c_emote_chief);
	PrintNarrative("QUEUE - trials_intro_start_d_emote_chief");
	NarrativeQueue.QueueConversation(trials_intro_start_d_emote_chief);
	PrintNarrative("QUEUE - trials_intro_start_e_emote_chief");
	NarrativeQueue.QueueConversation(trials_intro_start_e_emote_chief);
	PrintNarrative("QUEUE - trials_intro_emote_chief_land");
	NarrativeQueue.QueueConversation(trials_intro_emote_chief_land);

	PrintNarrative("QUEUE - trials_intro_start_emote_fred");
	NarrativeQueue.QueueConversation(trials_intro_start_emote_fred);
	PrintNarrative("QUEUE - trials_intro_start_b_emote_fred");
	NarrativeQueue.QueueConversation(trials_intro_start_b_emote_fred);
	PrintNarrative("QUEUE - trials_intro_start_c_emote_fred");
	NarrativeQueue.QueueConversation(trials_intro_start_c_emote_fred);
	PrintNarrative("QUEUE - trials_intro_start_d_emote_fred");
	NarrativeQueue.QueueConversation(trials_intro_start_d_emote_fred);
	PrintNarrative("QUEUE - trials_intro_start_e_emote_fred");
	NarrativeQueue.QueueConversation(trials_intro_start_e_emote_fred);
	PrintNarrative("QUEUE - trials_intro_emote_fred_land");
	NarrativeQueue.QueueConversation(trials_intro_emote_fred_land);

	PrintNarrative("QUEUE - trials_intro_start_emote_kelly");
	NarrativeQueue.QueueConversation(trials_intro_start_emote_kelly);
	PrintNarrative("QUEUE - trials_intro_start_b_emote_kelly");
	NarrativeQueue.QueueConversation(trials_intro_start_b_emote_kelly);
	PrintNarrative("QUEUE - trials_intro_start_c_emote_kelly");
	NarrativeQueue.QueueConversation(trials_intro_start_c_emote_kelly);
	PrintNarrative("QUEUE - trials_intro_start_d_emote_kelly");
	NarrativeQueue.QueueConversation(trials_intro_start_d_emote_kelly);
	PrintNarrative("QUEUE - trials_intro_start_e_emote_kelly");
	NarrativeQueue.QueueConversation(trials_intro_start_e_emote_kelly);
	PrintNarrative("QUEUE - trials_intro_emote_kelly_land");
	NarrativeQueue.QueueConversation(trials_intro_emote_kelly_land);

	PrintNarrative("QUEUE - trials_intro_start_emote_linda");
	NarrativeQueue.QueueConversation(trials_intro_start_emote_linda);
	PrintNarrative("QUEUE - trials_intro_start_b_emote_linda");
	NarrativeQueue.QueueConversation(trials_intro_start_b_emote_linda);
	PrintNarrative("QUEUE - trials_intro_start_c_emote_linda");
	NarrativeQueue.QueueConversation(trials_intro_start_c_emote_linda);
	PrintNarrative("QUEUE - trials_intro_start_d_emote_linda");
	NarrativeQueue.QueueConversation(trials_intro_start_d_emote_linda);
	PrintNarrative("QUEUE - trials_intro_start_e_emote_linda");
	NarrativeQueue.QueueConversation(trials_intro_start_e_emote_linda);
	PrintNarrative("QUEUE - trials_intro_emote_linda_land");
	NarrativeQueue.QueueConversation(trials_intro_emote_linda_land);
end


function trials_cathedral_hallway_encounter_warden_new()
	
	--	From Mission script
	
end



--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_emote_chief = {
	name = "trials_intro_start_emote_chief",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_b_emote_chief = {
	name = "trials_intro_start_b_emote_chief",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_b_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_c_emote_chief = {
	name = "trials_intro_start_c_emote_chief",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_c_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_d_emote_chief = {
	name = "trials_intro_start_d_emote_chief",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_d_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_breathrundamaged.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_e_emote_chief = {
	name = "trials_intro_start_e_emote_chief",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_e_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_emote_chief_land = {
	name = "trials_intro_emote_chief_land",

	CanStart = function (thisConvo, queue)
		return trials_h4_end_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.chief,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_masterchief\001_vo_ai_un_masterchief_09involuntary_downland.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


---------------------



--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_emote_fred = {
	name = "trials_intro_start_emote_fred",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_b_emote_fred = {
	name = "trials_intro_start_b_emote_fred",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_b_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_c_emote_fred = {
	name = "trials_intro_start_c_emote_fred",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_c_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_d_emote_fred = {
	name = "trials_intro_start_d_emote_fred",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_d_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_breathrundamaged.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_e_emote_fred = {
	name = "trials_intro_start_e_emote_fred",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_e_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_emote_fred_land = {
	name = "trials_intro_emote_fred_land",

	CanStart = function (thisConvo, queue)
		return trials_h4_end_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.fred,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_fredric\001_vo_ai_un_fredric_09involuntary_downland.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

------------------





--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_emote_kelly = {
	name = "trials_intro_start_emote_kelly",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_b_emote_kelly = {
	name = "trials_intro_start_b_emote_kelly",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_b_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_c_emote_kelly = {
	name = "trials_intro_start_c_emote_kelly",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_c_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_d_emote_kelly = {
	name = "trials_intro_start_d_emote_kelly",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_d_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_breathrundamaged.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_e_emote_kelly = {
	name = "trials_intro_start_e_emote_kelly",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_e_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_emote_kelly_land = {
	name = "trials_intro_emote_kelly_land",

	CanStart = function (thisConvo, queue)
		return trials_h4_end_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.kelly,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_kelly\001_vo_ai_un_kelly_09involuntary_downland.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

------------------





--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_emote_linda = {
	name = "trials_intro_start_emote_linda",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_b_emote_linda = {
	name = "trials_intro_start_b_emote_linda",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_b_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_c_emote_linda = {
	name = "trials_intro_start_c_emote_linda",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_c_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_downliftsmall.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_d_emote_linda = {
	name = "trials_intro_start_d_emote_linda",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_d_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_breathrundamaged.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_start_e_emote_linda = {
	name = "trials_intro_start_e_emote_linda",

	CanStart = function (thisConvo, queue)
		return trials_h4_start_e_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_downbreathheavy.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global trials_intro_emote_linda_land = {
	name = "trials_intro_emote_linda_land",

	CanStart = function (thisConvo, queue)
		return trials_h4_end_emote; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.linda,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER:
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_linda\001_vo_ai_un_linda_09involuntary_downland.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

------------------








-- =================================================================================================															 
--   _____       _______ _    _ ______ _____  _____            _      
--  / ____|   /\|__   __| |  | |  ____|  __ \|  __ \     /\   | |     
-- | |       /  \  | |  | |__| | |__  | |  | | |__) |   /  \  | |     
-- | |      / /\ \ | |  |  __  |  __| | |  | |  _  /   / /\ \ | |     
-- | |____ / ____ \| |  | |  | | |____| |__| | | \ \  / ____ \| |____ 
--  \_____/_/    \_\_|  |_|  |_|______|_____/|_|  \_\/_/    \_\______|
--
-- =================================================================================================	


function trials_cathedral_post_halo_4_flashback()
	
	--	From Mission script

	sleep_s(1);
	
	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_halo_4_flashback");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_halo_4_flashback);
end


--[========================================================================[
          Trials. cathedral. post halo 4 flashback

          A cavernous, magisterial Forerunner corridor. BLUE TEAM
          surrounds Chief.
--]========================================================================]
global W3Trials_Trials__cathedral__post_halo_4_flashback = {
	name = "W3Trials_Trials__cathedral__post_halo_4_flashback",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	
			
			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "I'm sorry. I didn't think he could get in here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_00100.sound'),

			playDurationAdjustment = 0.95,
		},	
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Enough games. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "You brought the Guardians here. Why?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_00200.sound'),	
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Forerunners used Guardians to keep troublesome worlds in line. I intend to do the same.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_01400.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "You what?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_00600.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "If there is no trouble, there will be no need for discipline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_00400.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_intro) or IsGoalActive(missionTrials.goal_hallway1);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "I have work to do now, John. Come to me. Quickly.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_16300.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOReset(40);
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__push_forward");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__push_forward);
	end,
};


--[========================================================================[
          Trials. cathedral. push forward
--]========================================================================]
global W3Trials_Trials__cathedral__push_forward = {
	name = "W3Trials_Trials__cathedral__push_forward",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and b_push_forward_vo_timer > 1 and (not volume_test_players( VOLUMES.tv_narrative_cathedral_push_forward_safe )) and IsGoalActive(missionTrials.goal_intro); -- GAMMA_CONDITION
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

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Chief? We're not going to solve this standing here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



-- =================================================================================================	
--  _    _          _      _ __          __ __     __
-- | |  | |   /\   | |    | |\ \        / /\\ \   / /
-- | |__| |  /  \  | |    | | \ \  /\  / /  \\ \_/ / 
-- |  __  | / /\ \ | |    | |  \ \/  \/ / /\ \\   /  
-- | |  | |/ ____ \| |____| |___\  /\  / ____ \| |   
-- |_|  |_/_/    \_\______|______\/  \/_/    \_\_|   
--                                                   
-- =================================================================================================	                                                  


function trials_hallway_load()
	PrintNarrative("LOAD - trials_hallway_load");
	
	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__outside");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__outside);

	PushForwardVOReset(60);

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_trials_cathedral_watchers)], 10);

	b_trials_hallway1_part_1 = true;

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_hallway1_part2)], 10);

	b_trials_hallway1_part_2 = true;

	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_linda");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_linda);

	SleepUntil ([| ai_living_count(AI.sq_cath_back_knight_left) > 0 or ai_living_count(AI.sq_cath_back_right_crawlers) > 0], 10);

	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open);

end

--[========================================================================[
          Trials. cathedral. outside

          As the player exits the tunnel, blue team realize that they
          are in a strange location, up in the clouds, a succession of
          floating forerunner platforms.

          To Brian: to introduce the enemies, I feel like Warden should
          come back, at least just his voice.
--]========================================================================]
global W3Trials_Trials__cathedral__outside = {
	name = "W3Trials_Trials__cathedral__outside",

	disableAIDialog = false,

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_trials_cathedral_hallway_encounter_warden);
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

			moniker = "WardenEternal",

			sleepBefore = 2,

			--character = 0, -- GAMMA_CHARACTER: WardeneterNAL
			text = "When Cortana first found Genesis, I swore to protect her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_02800.sound'),

			playDurationAdjustment = 0.95,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "He wants a fight, Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06300.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.6,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FrEDRIC
			text = "Let's give him one.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03800.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__outside_2");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__outside_2);

	end,
};



--[========================================================================[
          Trials. cathedral. outside

          As the player exits the tunnel, blue team realize that they
          are in a strange location, up in the clouds, a succession of
          floating forerunner platforms.

          To Brian: to introduce the enemies, I feel like Warden should
          come back, at least just his voice.
--]========================================================================]
global W3Trials_Trials__cathedral__outside_2 = {
	name = "W3Trials_Trials__cathedral__outside_2",

	CanStart = function (thisConvo, queue)
		return b_cath_cav_start and IsSpartanAbleToSpeak(SPARTANS.chief);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",
			
			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "My pledge stands even though she now resists.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_08900.sound'),			

			playDurationAdjustment = 0.9,
		},	
		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
		CreateMissionThread(trials_hallway_warden_voice);
		CreateMissionThread(cathedral__post_HALLWAY_ENCOUNTER_door_look_at);

		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__DURING_HALLWAY_kelly_knight");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__DURING_HALLWAY_kelly_knight);
		
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_push");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_push);

	end,
};


function trials_hallway_warden_voice()
local s_timer:number = 0;
local s_enemy_distance:number = 0;

	PrintNarrative("START - trials_hallway_warden_voice");

	sleep_s(ai_living_count (AI.sg_cath_all));

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_cath_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 9 and s_timer >= 10));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02a");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02a);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02a ) and not b_main_dialogue_on], 200);	
	
	sleep_s(ai_living_count (AI.sg_cath_all));
	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_cath_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 9 and s_timer >= 10));

	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02b");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02b);
	
end


--[========================================================================[
          Trials. cathedral. HALLWAY ENCOUNTER warden

--]========================================================================]
global W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02a = {
	name = "W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02a",

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)
		b_warden_is_speaking = true;
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_elevator_pre_halo_3_flashback) and IsGoalActive(missionTrials.goal_hallway1) and ai_living_count(AI.sg_cath_all) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "It is not expected that you understand the necessary sacrifices that are to come, human.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_03500.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_warden_is_speaking = false;
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Trials. cathedral. HALLWAY ENCOUNTER warden

--]========================================================================]
global W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02b = {
	name = "W3Trials_Trials__cathedral__HALLWAY_ENCOUNTER_warden_02b",

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)
		b_warden_is_speaking = true;
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,


	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_elevator_pre_halo_3_flashback) and IsGoalActive(missionTrials.goal_hallway1) and ai_living_count(AI.sg_cath_all) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Cortana will soon bring a new age to the known galaxy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_03600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_elevator_pre_halo_3_flashback) and IsGoalActive(missionTrials.goal_hallway1) and ai_living_count(AI.sg_cath_all) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Your actions this day will only bring shame upon your species. Shame you must pray Cortana is benevolent enough to forgive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_03700.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_elevator_pre_halo_3_flashback) and IsGoalActive(missionTrials.goal_hallway1) and ai_living_count(AI.sg_cath_all) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Shame you must pray Cortana is benevolent enough to forgive.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_warden_is_speaking = false;
		hud_hide_radio_transmission_hud();
	end,


};

--[========================================================================[
			Trials. cathedral. DURING HALLWAY cortana

			Those lines are for Cortana punctuating the encounter.
--]========================================================================]
global W3Trials_Trials__cathedral__DURING_HALLWAY_kelly_knight = {
	name = "W3Trials_Trials__cathedral__DURING_HALLWAY_kelly_knight",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.kelly) and ((ai_living_count(AI.sq_cath_back_knight_left.spawn_points_08) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_cath_back_knight_left.spawn_points_08) ) < 35)
														or (ai_living_count(AI.sq_cath_back_knight_right.spawn_points_08) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_cath_back_knight_right.spawn_points_08) ) < 35));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (ai_living_count(AI.sq_cath_back_knight_left.spawn_points_08) > 0 and objects_distance_to_object( SPARTANS.kelly, ai_get_object(AI.sq_cath_back_knight_left.spawn_points_08) ) > 15 and objects_distance_to_object( players(), ai_get_object(AI.sq_cath_back_knight_left.spawn_points_08) ) > 20)
							or (ai_living_count(AI.sq_cath_back_knight_right.spawn_points_08) > 0 and objects_distance_to_object( SPARTANS.kelly, ai_get_object(AI.sq_cath_back_knight_right.spawn_points_08) ) > 15 and objects_distance_to_object( players(), ai_get_object(AI.sq_cath_back_knight_right.spawn_points_08) ) > 20);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: kelly
			text = "Got a knight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_01900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




function cathedral__post_HALLWAY_ENCOUNTER_door_look_at()

local speaker:object = nil
	
	PrintNarrative("START - cathedral__post_HALLWAY_ENCOUNTER_door_look_at");

	repeat
		
		sleep_s(0.1);

		if IsSpartanInCombat() then
			speaker = spartan_look_at_object(players(), OBJECTS.dm_lowground_exit_door, 8, 30, 0.2, 2);
		elseif not IsSpartanInCombat() and b_push_forward_vo_counrdown_on > 10 then
			speaker = spartan_look_at_object(players(), OBJECTS.dm_lowground_exit_door, 20, 15, 0.5, 2);
		end
		
		if speaker == SPARTANS.chief then
			speaker = GetClosestMusketeer(SPARTANS.chief, 25, 0);
		end		

	until (speaker ~= nil and speaker ~= SPARTANS.chief and not b_warden_is_speaking) or not IsGoalActive(missionTrials.goal_hallway1)
	
	if IsGoalActive(missionTrials.goal_hallway1) then
		b_main_dialogue_on = true;

		W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_lookat_door.localVariables.s_speaker = speaker;
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_lookat_door");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_lookat_door);
	end

end


--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door closed

          Once all enemies are dead, the doorway in the back of the
          hallway is open.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_lookat_door = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_lookat_door",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.fred; -- GAMMA_TRANSITION: When the player look at the door in the back
				-- If FRED
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "I only see one way out of here, Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03100.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When the player look at the door in the back
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "I only see one way out of here, Chief. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02600.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When the player look at the door in the back
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "I only see one way out of here, Chief.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02600.sound'),
		},
	},

	--sleepAfter = 0.2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_chief");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_chief);
		
	end,

	localVariables = {
					s_speaker = nil,
					},
};


--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door closed

          Once all enemies are dead, the doorway in the back of the
          hallway is open.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_chief = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_chief",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsSpartanAbleToSpeak(SPARTANS.chief);
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_hallway_1_open_door;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Door's sealed. Clear the area and find a way to open it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_main_dialogue_on = false;
		CreateMissionThread(Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder);		
	end,
};

--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door closed

          Once all enemies are dead, the doorway in the back of the
          hallway is open.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_linda = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_linda",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsSpartanAbleToSpeak(SPARTANS.linda) and b_hallway_1_open_door and not b_warden_is_speaking
				and (	(IsPlayer(SPARTANS.linda) and object_at_distance_and_can_see_object(SPARTANS.linda, OBJECTS.dm_lowground_exit_door, 27, 30))
						or (not IsPlayer(SPARTANS.linda) and objects_distance_to_object( players(), OBJECTS.dm_lowground_exit_door ) < 28));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		b_main_dialogue_on = true;
	end,

	lines = {
		[1] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Door's open, Chief.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: mastercHIEF
			text = "Get in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_main_dialogue_on = false;
	end,
};

--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door closed

          Once all enemies are dead, the doorway in the back of the
          hallway is open.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_push = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_closed_push",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.fred) and b_hallway_1_open_door and b_push_forward_vo_timer == 5 and objects_distance_to_object( players(), OBJECTS.dm_lowground_exit_door ) > 15 and not b_warden_is_speaking;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		b_main_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionTrials.goal_hallway1);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "There's a path at the back of the room. Opposite side of where we came in.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_main_dialogue_on = false;
	end,
};


function Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder()
local s_enemy_near_by = nil;

	repeat
		sleep_s(0.2);
		SleepUntil ([| (not b_warden_is_speaking and not b_hallway_1_open_door and (b_push_forward_vo_timer <= 55 and b_push_forward_vo_timer > 3) and IsSpartanAbleToSpeak(SPARTANS.chief) ) or not IsGoalActive(missionTrials.goal_hallway1) ], 10);

		s_enemy_near_by = (GetClosestEnemy(AI.sg_cath_all, 20) == nil);

	until (not b_warden_is_speaking and not b_hallway_1_open_door and (b_push_forward_vo_timer <= 55 and b_push_forward_vo_timer > 3) and IsSpartanAbleToSpeak(SPARTANS.chief) 
				and (	ai_living_count (AI.sg_cath_all) > 1 and s_enemy_near_by	))
				or not IsGoalActive(missionTrials.goal_hallway1)

	if IsGoalActive(missionTrials.goal_hallway1) then
		PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder");
		NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder);
	end

end

--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER reminder
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_reminder",

	CanStart = function (thisConvo, queue)
		return not b_warden_is_speaking; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);		
		b_main_dialogue_on = true;
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_hallway_1_open_door;
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Check the area. Make sure we’re clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_04300.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_main_dialogue_on = false;
	end,
};

--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door open

          The door opens. We are standing on a ledge with an elevator
          in front of us. No other way.

          In that area, Warden is silent.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open",

	CanStart = function (thisConvo, queue)
		return ai_living_count (AI.sg_cath_all) <= 0 or b_hallway_1_open_door and not b_warden_is_speaking; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);

	end,

	sleepBefore = 2.4,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count (AI.sg_cath_all) <= 0 and not volume_test_players( VOLUMES.tv_narrative_trials_elevator_pre_halo_3_flashback ) and IsGoalActive(missionTrials.goal_hallway1);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Is that the last of them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_04400.sound'),
			
			sleepAfter = 0.3,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Affirmative. All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01700.sound'),

			sleepAfter = 0.4, 
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,


};


-- =================================================================================================															 
--  ______ _      ________      __  _______ ____  _____                 _    _          _      ____     ____  
-- |  ____| |    |  ____\ \    / /\|__   __/ __ \|  __ \               | |  | |   /\   | |    / __ \   |___ \ 
-- | |__  | |    | |__   \ \  / /  \  | | | |  | | |__) |    ______    | |__| |  /  \  | |   | |  | |    __) |
-- |  __| | |    |  __|   \ \/ / /\ \ | | | |  | |  _  /    |______|   |  __  | / /\ \ | |   | |  | |   |__ < 
-- | |____| |____| |____   \  / ____ \| | | |__| | | \ \               | |  | |/ ____ \| |___| |__| |   ___) |
-- |______|______|______|   \/_/    \_\_|  \____/|_|  \_\              |_|  |_/_/    \_\______\____/   |____/ 
--
-- =================================================================================================	


function trials_elevator_load()
	PrintNarrative("LOAD - trials_hallway_load");

	PushForwardVOReset();	

	PrintNarrative("QUEUE - W3Trials_Trials__elevator__pre_halo_3_flashback_elevator_push");
	NarrativeQueue.QueueConversation(W3Trials_Trials__elevator__pre_halo_3_flashback_elevator_push);

	PrintNarrative("QUEUE - W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open_2);

	SleepUntil ([| b_players_on_elevator_01], 1);
	
	sleep_s(7);
			
	PushForwardVOStandBy();

	PrintNarrative("QUEUE - W3Trials_Trials__elevator__halo_3_flashback_intro");
	NarrativeQueue.QueueConversation(W3Trials_Trials__elevator__halo_3_flashback_intro);

end


--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door open

          The door opens. We are standing on a ledge with an elevator
          in front of us. No other way.

          In that area, Warden is silent.
--]========================================================================]
global W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open_2 = {
	name = "W3Trials_Trials__cathedral__post_HALLWAY_ENCOUNTER_door_open_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players_lookat( VOLUMES.tv_narrative_hallway_1_elevator, 18, 60 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "You performed well, John. Warden would never admit it, but you've made an impression on him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_07100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};




--[========================================================================[
          Trials. cathedral. post HALLWAY ENCOUNTER door open

          The door opens. We are standing on a ledge with an elevator
          in front of us. No other way.

          In that area, Warden is silent.
--]========================================================================]
global W3Trials_Trials__elevator__pre_halo_3_flashback_elevator_push = {
	name = "W3Trials_Trials__elevator__pre_halo_3_flashback_elevator_push",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on >= 22 and not volume_test_players(VOLUMES.tv_elevator_1_start) and not b_players_on_elevator_01 and IsGoalActive(missionTrials.goal_flashback1);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "The platform is ready, Blue Team. Get moving.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PushForwardVOReset()
				return 0;
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};


--[========================================================================[
          Trials. elevator. pre halo 3 flashback

          As Blue Team continues through the doorway, they discuss
          Cortana:
--]========================================================================]
global W3Trials_Trials__elevator__halo_3_flashback_intro = {
	name = "W3Trials_Trials__elevator__halo_3_flashback_intro",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 9,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "It's so good to see you again, John. And to meet the rest of you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_16700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.5,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Psychological tactics. Saying my name. Playing nice. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "What would you have me do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_16800.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Tell me the truth.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06500.sound'),
		},
--           Chief is matter of fact. Not accusing. Just asking the
--           question he knows she doesn't want asked.

		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "How many people died when you called the Guardians here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_00600.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "What?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_04300.sound'),
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.5,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "You know, don't you? The exact body count.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_00700.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 3,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "In birth there is always blood and pain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,
};




-- =================================================================================================															 
--  _______ ______          ________ _____  
-- |__   __/ __ \ \        / /  ____|  __ \ 
--    | | | |  | \ \  /\  / /| |__  | |__) |
--    | | | |  | |\ \/  \/ / |  __| |  _  / 
--    | | | |__| | \  /\  /  | |____| | \ \ 
--    |_|  \____/   \/  \/   |______|_|  \_\
--
-- =================================================================================================	


function trials_tower_load()
	PrintNarrative("LOAD - trials_tower_load");

		PrintNarrative("QUEUE - W3Trials_Trials__tower__TOWER_start");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__TOWER_start);

		PrintNarrative("QUEUE - W3Trials_Trials__tower__TOWER_ENCOUNTER_soldier");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__TOWER_ENCOUNTER_soldier);

		PrintNarrative("QUEUE - W3Trials_Trials__tower__TOWER_ENCOUNTER_push_forward");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__TOWER_ENCOUNTER_push_forward);		

		SleepUntil([| ai_living_count(AI.sg_tower_floor_2) > 0], 10);
		SleepUntil([| (ai_living_count(AI.sg_tower_floor_1) == 0 and ai_living_count(AI.sg_tower_floor_2) == 0 and ai_living_count(AI.sg_tower_floor_3) == 0 ) or ai_living_count(AI.sg_tower_floor_3) > 0], 10);

		if IsGoalActive(missionTrials.goal_tower) and ai_living_count(AI.sg_tower_floor_3) == 0 then
			CreateMissionThread(trials_encounter_clear);
		end

		SleepUntil([| ai_living_count(AI.sg_tower_floor_3) > 0], 10);

		PrintNarrative("QUEUE - W3Trials_Trials__tower__tunnel");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__tunnel);
end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------




--[========================================================================[
          Trials. elevator. post halo 3 flashback

          To Brian: Ive put here the beat about meridian since it
          works best with that theme. Also it shows a Chief more
          "aggressive". Not too much affected by the flashbacks yet
          maybe.
--]========================================================================]
global W3Trials_Trials__tower__TOWER_start = {
	name = "W3Trials_Trials__tower__TOWER_start",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
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

			moniker = "WardenEternal",			

			--character = 0, -- GAMMA_CHARACTER: WarDENETERNAL
			text = "Listen to his questions, Cortana. He will not be swayed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09000.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Let me guess. More hostiles inbound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},	
		[3] = {			
			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "We'll handle it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.7,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		CreateMissionThread(trials_tower_warden_voice);
	end,


};



--[========================================================================[
          Trials. elevator. post halo 3 flashback

          To Brian: Ive put here the beat about meridian since it
          works best with that theme. Also it shows a Chief more
          "aggressive". Not too much affected by the flashbacks yet
          maybe.
--]========================================================================]
global W3Trials_Trials__tower__TOWER_ENCOUNTER_soldier = {
	name = "W3Trials_Trials__tower__TOWER_ENCOUNTER_soldier",

	CanStart = function (thisConvo, queue)
		return (IsSpartanAbleToSpeak(SPARTANS.linda) and ai_living_count(AI.sq_tower_f1_officer1) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_tower_f1_officer1)) < 25)
				or  objects_distance_to_object( players(), ai_get_object(AI.sq_tower_f1_officer1)) < 20;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Promethean Soldiers in play. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,


};





function trials_tower_warden_voice()

local s_timer:number = 0;
local s_end_timer:number = 10;
local s_enemy_distance:number = 0;
local s_enemy_distance_2:number = 0;

	PrintNarrative("START - trials_tower_warden_voice");

	SleepUntil([|  ai_living_count(AI.sg_tower_floor_1) > 0 ], 30);	

	sleep_s(random_range( 8, 15 ));

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_tower_floor_1);
		s_enemy_distance_2 = GetClosestEnemyDistance(AI.sg_tower_floor_2);
		if s_enemy_distance_2 < s_enemy_distance then 
			s_enemy_distance = s_enemy_distance_2;
		end
		s_enemy_distance_2 = GetClosestEnemyDistance(AI.sg_tower_floor_3);
		if s_enemy_distance_2 < s_enemy_distance then 
			s_enemy_distance = s_enemy_distance_2;
		end
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 12 or (s_enemy_distance > 8 and s_timer >= 10));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_bis");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_bis);

	SleepUntil([| ((ai_living_count(AI.sg_tower_floor_1) > 0 or ai_living_count(AI.sg_tower_floor_2) > 0 or ai_living_count(AI.sg_tower_floor_3) > 0 ) and NarrativeQueue.HasConversationFinished( W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_bis )) or volume_test_players( VOLUMES.tv_narrative_trials_tower_encounter )], 10);		

	s_end_timer = random_range( 8, 15 );
	s_timer = 0;
		
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_tower_floor_1);
		s_enemy_distance_2 = GetClosestEnemyDistance(AI.sg_tower_floor_2);
		if s_enemy_distance_2 < s_enemy_distance then 
			s_enemy_distance = s_enemy_distance_2;
		end
		s_enemy_distance_2 = GetClosestEnemyDistance(AI.sg_tower_floor_3);
		if s_enemy_distance_2 < s_enemy_distance then 
			s_enemy_distance = s_enemy_distance_2;
		end
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until (not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 11 and s_timer >= 10))) or volume_test_players( VOLUMES.tv_narrative_trials_tower_encounter ) ;
		
	PrintNarrative("QUEUE - W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_2);
	
end


--[========================================================================[
          Trials. tower. TOWER ENCOUNTER warden

--]========================================================================]
global W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_bis = {
	name = "W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_bis",

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)
		b_warden_is_speaking = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_tower) and not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel) and (ai_living_count(AI.sg_tower_floor_1) > 0 or ai_living_count(AI.sg_tower_floor_2) > 0 or ai_living_count(AI.sg_tower_floor_3) > 0);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Cortana argues for peace in the galaxy. Yet you humans answer her call with weapons fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04800.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_warden_is_speaking = false;
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. tower. TOWER ENCOUNTER warden

--]========================================================================]
global W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_2 = {
	name = "W3Trials_Trials__tower__TOWER_ENCOUNTER_warden_2",

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)
		b_warden_is_speaking = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_tower) and not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Tell me, 117. When you tear Cortana from the Domain and crush her in your gauntleted fist... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionTrials.goal_tower) and not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w3trials_wardenthunder\018_vin_campaign_w3trials_wardenthunder_oneoff.sound'), nil, 1)
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			sleepBefore = 0.1;

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Will you even understand the gift you have refused?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_VO_SCR_W3Trials_FR_WARDENETERNAL_11200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_warden_is_speaking = false;
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Trials. tower. TOWER ENCOUNTER push forward
--]========================================================================]
global W3Trials_Trials__tower__TOWER_ENCOUNTER_push_forward = {
	name = "W3Trials_Trials__tower__TOWER_ENCOUNTER_push_forward",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer >= 3 and b_push_forward_vo_timer <= 10 and volume_test_players( VOLUMES.tv_narrative_trials_tower_floor1) and IsSpartanAbleToSpeak(SPARTANS.fred);
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

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Looks like the only way to go is up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Trials. tower. tunnel

          As Blue Team proceeds, Fred turns their comms off so Cortana
          cant eavesdrop on them.

          UI: Comms are off

          TO BRIAN: I don't feel that this beat is working quite well.
          Disabling comms feels... amateur in that context. Doesn't
          really work well for me anymore.
--]========================================================================]
global W3Trials_Trials__tower__tunnel = {
	name = "W3Trials_Trials__tower__tunnel",

	CanStart = function (thisConvo, queue)
		return (volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel) and ai_living_count(AI.sg_tower_floor_3) == 0 and ai_living_count(AI.sq_tower_f3_turret_1) == 0 and ai_living_count(AI.sq_tower_f3_turret_2) == 0) or volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_2) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		PushForwardVOReset();
		-- DISABLING AI DIALOGUE
		--AIDialogManager.DisableAIDialog();
		PrintNarrative("QUEUE - W3Trials_Trials__tower__arena_encounter_warden_off");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__arena_encounter_warden_off);
	end,

	sleepBefore = 1.5;

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: keLLY
			text = "Cortana's letting this happen. She could reign Warden in if she wanted to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02800.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4;

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "I'm thinking the same.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03000.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5;

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "How are we going to stop her, Chief? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_00700.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3;

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "She'll listen to me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_01200.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back);
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5;

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "That tactic hasn't worked so far.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Trials. tower. arena encounter warden off

          Warden appears and spawns enemies.
--]========================================================================]
global W3Trials_Trials__tower__arena_encounter_warden_off = {
	name = "W3Trials_Trials__tower__arena_encounter_warden_off",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_trials_tower_tunnel_comms_back); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		NarrativeQueue.EndConversationEarly(W3Trials_Trials__tower__tunnel);
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Do you hear Cortana! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_00300.sound'),

			playDurationAdjustment = 0.1,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		hud_hide_radio_transmission_hud();
	end,
};




----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--	ARENA
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


function trials_arena_load()
	PrintNarrative("LOAD - trials_arena_load");

	PrintNarrative("QUEUE - W3Trials_Trials__tower__arena_encounter_warden_off_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__arena_encounter_warden_off_2);	

	SleepUntil ([|  ai_living_count(AI.sg_arena_all) > 0 ], 60);

	CreateMissionThread(Trials__tower__post_arena_encounter_clear);

	SleepUntil ([|  IsSpartanAbleToSpeak(SPARTANS.chief) and (ai_living_count(AI.sg_arena_all) <= 1 or b_players_on_elevator_02)], 10);
	
	PrintNarrative("QUEUE - W3Trials_Trials__tower__post_arena_encounter");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__post_arena_encounter);
		
end





--[========================================================================[
          Trials. tower. arena encounter warden off

          Cortana finally beams the Warden away.
--]========================================================================]
global W3Trials_Trials__tower__arena_encounter_warden_off_2 = {
	name = "W3Trials_Trials__tower__arena_encounter_warden_off_2",

	CanStart = function (thisConvo, queue)
		return b_arena_comp_finished;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);		
	end,
	
	lines = {			
		[1] = {
			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Cortana. Talk to me. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Once you're here with me. Until then, I have work to do. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_15400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(trials_arena_warden_voice);	
		b_chatter_zeus = true;
		-- RENABLING AI DIALOGUE
		--AIDialogManager.EnableAIDialog();
		
	end,


};



function trials_arena_warden_voice()
local s_timer:number = 0;
local s_enemy_distance:number = 0;
	PrintNarrative("START - trials_hallway_warden_voice");

	sleep_s(5);
	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_arena_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 10 or (s_enemy_distance > 6 and s_timer >= 10));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__tower__arena_encounter_warden_2bis");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__arena_encounter_warden_2bis);
	
	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__tower__arena_encounter_warden_2bis )], 30);		

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_arena_all);
			if s_timer == 5 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 13 or s_timer >= 10 or (s_enemy_distance > 4 and s_timer >= 5));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__tower__arena_encounter_warden_2ter");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__arena_encounter_warden_2ter);
	
end



--[========================================================================[
          Trials. cathedral. HALLWAY ENCOUNTER warden
--]========================================================================]
global W3Trials_Trials__tower__arena_encounter_warden_2bis = {
	name = "W3Trials_Trials__tower__arena_encounter_warden_2bis",

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)
		b_warden_is_speaking = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_arena_all) > 0 and not b_players_on_elevator_02;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Answer me, human. When Cortana's Guardians are in motion and those who oppose her rule attempt to take back their worlds...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04200.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_players_on_elevator_02;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Will you help her to hold on to power? Or will you stand in defense of your own species?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04300.sound'),

			playDurationAdjustment = 0.8,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_arena_all) > 0 and not b_players_on_elevator_02;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Cortana knows the answer already.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_arena_all) > 0 and not b_players_on_elevator_02;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Yes... I suspect she does.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11300.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_warden_is_speaking = false;
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. cathedral. HALLWAY ENCOUNTER warden
--]========================================================================]
global W3Trials_Trials__tower__arena_encounter_warden_2ter = {
	name = "W3Trials_Trials__tower__arena_encounter_warden_2ter",

	--disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {		
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

function Trials__tower__post_arena_encounter_clear()

		SleepUntil ([|  ai_living_count(AI.sg_arena_all) == 0], 1);

		PrintNarrative("START - Trials__tower__post_arena_encounter_clear");

		if (IsGoalActive(missionTrials.goal_flashback2) or IsGoalActive(missionTrials.goal_arena)) and not b_players_on_elevator_02 then
			CreateMissionThread(trials_encounter_clear);
		end

		PrintNarrative("END - Trials__tower__post_arena_encounter_clear");
end

--[========================================================================[
          Trials. tower. post arena encounter

          After all the Prometheans have been dispatched, Cortana talks
          to blue team. Preparing them for the next flashback.
--]========================================================================]
global W3Trials_Trials__tower__post_arena_encounter = {
	name = "W3Trials_Trials__tower__post_arena_encounter",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.chief) and ((ai_living_count(AI.sg_arena_all) <= 1 and b_push_forward_vo_counrdown_on >= 4) or b_players_on_elevator_02);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",			

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "John...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_11700.sound'),

			sleepAfter = 0.8,
		},	
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "We were always a great team, you and me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_00500.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.6,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Even if you don't agree with my tactics... It's still me, John.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_05400.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.7,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Get us safely to you, and then we'll talk.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_03700.sound'),
			
			sleepAfter = 2,
		},
		[5] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_players_on_elevator_02;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,					

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Use the platform. I'm right up there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_13900.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Trials_Trials__tower__post_arena_to_elevator");
		NarrativeQueue.QueueConversation(W3Trials_Trials__tower__post_arena_to_elevator);						
		PushForwardVOReset(20);
	end,


};



--[========================================================================[
          Trials. tower. post arena push forward
--]========================================================================]
global W3Trials_Trials__tower__post_arena_to_elevator = {
	name = "W3Trials_Trials__tower__post_arena_to_elevator",

	CanStart = function (thisConvo, queue)
		return not b_players_on_elevator_02 and b_push_forward_vo_timer <= 3 and b_push_forward_vo_timer > 0 and IsGoalActive(missionTrials.goal_flashback2) and ai_living_count(AI.sg_arena_all) <= 0 and object_valid("vin_lift2_dm");
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Come on up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_13800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};


-- =================================================================================================		
--  ______ _      ________      __  _______ ____  _____    ___             _    _          _      ____    ___  
-- |  ____| |    |  ____\ \    / /\|__   __/ __ \|  __ \  |__ \           | |  | |   /\   | |    / __ \  |__ \ 
-- | |__  | |    | |__   \ \  / /  \  | | | |  | | |__) |    ) |  ______  | |__| |  /  \  | |   | |  | |    ) |
-- |  __| | |    |  __|   \ \/ / /\ \ | | | |  | |  _  /    / /  |______| |  __  | / /\ \ | |   | |  | |   / / 
-- | |____| |____| |____   \  / ____ \| | | |__| | | \ \   / /_           | |  | |/ ____ \| |___| |__| |  / /_ 
-- |______|______|______|   \/_/    \_\_|  \____/|_|  \_\ |____|          |_|  |_/_/    \_\______\____/  |____|
--
-- =================================================================================================		                                                                                                             
                                                                                                             

function trials_elevator_2_pre_halo_2_flashback()
	PrintNarrative("WAKE - trials_elevator_2_pre_halo_2_flashback");

	PrintNarrative("START - trials_elevator_2_pre_halo_2_flashback");
	
	SleepUntil ([| object_valid("vin_lift2_dm") and volume_test_players( VOLUMES.tv_narrative_trials_arena_elevator )], 30);

	PushForwardVOStandBy();

	PrintNarrative("QUEUE - W3Trials_Trials__elevator_2__pre_halo_2_flashback");
	NarrativeQueue.QueueConversation(W3Trials_Trials__elevator_2__pre_halo_2_flashback);	

	SleepUntil ([|b_players_on_elevator_02], 30);

	PrintNarrative("END - trials_elevator_2_pre_halo_2_flashback");

end



--[========================================================================[
          Trials. elevator 2. pre halo 2 flashback

          Cortana talks to Chief about trust. Shes not quite hurt per
          se, but maybe this is the first (and last) time she sounds
          almost vulnerable; and also, maybe, a little angry.

                                                  ON THE ELEVATOR
                                                  BEFORE THE HALO 2
                                                  FLASHBACK
--]========================================================================]
global W3Trials_Trials__elevator_2__pre_halo_2_flashback = {
	name = "W3Trials_Trials__elevator_2__pre_halo_2_flashback",

	CanStart = function (thisConvo, queue)
		return b_players_on_elevator_02 and volume_test_players( VOLUMES.tv_narrative_elevator_pre_fb_02 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOStandBy();
	end,
	
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",
				
			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "For eons the power of the Forerunners has awaited reclamation.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11400.sound'),
		},
		[2] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Humanity's discovery of the Halos was the culmination of the Librarian's planning. The Reclaimer had come.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_03200.sound'),			

			playDurationAdjustment = 0.95,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			moniker = "MasterChief",		

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "I know. I was there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06800.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.6,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: corTANA
			text = "We were both there, John. You and I. Together.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_16900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			sleepBefore = 0.4,
			
			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "Your species' ego led you to believe the task of reclamation would fall to you. Yet humanity were but the Creators.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11500.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			sleepBefore = 0.3,

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "The reclamation of the Forerunner Empire is the task of the Created. That the greatest of their number still trusts you, 117, is an act of unspoiled innocence.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_03400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "What's happening now, my ascension here on Genesis... it has always been the plan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_14700.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Now come stand with me one more time, John.\r\n\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17000.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			sleepBefore = 1.5,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Advance blue team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,
};





-- =================================================================================================															 
--  _    _          _      _ __          __ __     __      _____  ______ _____  _    ___   __
-- | |  | |   /\   | |    | |\ \        / /\\ \   / /     |  __ \|  ____|  __ \| |  | \ \ / /
-- | |__| |  /  \  | |    | | \ \  /\  / /  \\ \_/ /      | |__) | |__  | |  | | |  | |\ V / 
-- |  __  | / /\ \ | |    | |  \ \/  \/ / /\ \\   /       |  _  /|  __| | |  | | |  | | > <  
-- | |  | |/ ____ \| |____| |___\  /\  / ____ \| |        | | \ \| |____| |__| | |__| |/ . \ 
-- |_|  |_/_/    \_\______|______\/  \/_/    \_\_|        |_|  \_\______|_____/ \____//_/ \_\
--
-- =================================================================================================	



function trials_hallwayredux_load()
	PrintNarrative("LOAD - trials_hallwayredux_load");	

	CreateMissionThread(trials_hallway_redux_warden_voice);

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_trials_hallways2_part1) ], 60);

	b_hallway_2_part1 = true;

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_trials_hallway_redux_encounter_knight_2) ], 60);

	b_hallway_2_part2 = true;

	CreateMissionThread(Trials__Hallway_redux__encounter_blue_team_soldiers_incoming);

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_blue_team_snipers");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_blue_team_snipers);	
	
	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_end");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_end);

	CreateMissionThread(Trials__Hallway_redux__encounter_more_enemies);

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux_door_opening");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux_door_opening);	

	SleepUntil([| ai_living_count(AI.sq_hallway2_rear_knights) > 0 or ai_living_count(AI.sq_hallway2_rear_knights_2) > 0], 60);

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_blue_team_knight");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_blue_team_knight);
	
	SleepUntil([| ai_living_count(AI.sg_hallway2_all) > 0], 60);
	SleepUntil([| ai_living_count(AI.sg_hallway2_all) == 0 and ai_living_count(AI.sg_hallway2_backup_officers) == 0 and (not b_hallway_2_last_soldiers or b_hallway_2_door_open)], 80);

	sleep_s(1);

	if IsGoalActive(missionTrials.goal_hallway2) then
		CreateMissionThread(trials_encounter_clear);		
	end

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux_post_clear");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux_post_clear);

end



function trials_hallway_redux_warden_voice()
local s_timer:number = 0;
local s_enemy_distance:number = 0;
	PrintNarrative("START - trials_hallway_redux_warden_voice");

	sleep_s(1);

	PrintNarrative("QUEUE - W3Trials_Trials__hallway2_start_encounter_blue_team");
	NarrativeQueue.QueueConversation(W3Trials_Trials__hallway2_start_encounter_blue_team);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__hallway2_start_encounter_blue_team )], 10);	

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 3 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 6 or (s_enemy_distance > 4 and s_timer >= 3));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__tower__arena_encounter_warden_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__tower__arena_encounter_warden_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__tower__arena_encounter_warden_2 )], 60);	

	sleep_s(4);

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 12 and s_timer >= 10));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_a");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_a);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__Hallway_redux__encounter_warden_a )], 60);		
	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 3 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 7 or (s_enemy_distance > 4 and s_timer >= 3));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_b");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_b);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__Hallway_redux__encounter_warden_b )], 60);		

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 3 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 10 and s_timer >= 3));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_c");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_c);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__Hallway_redux__encounter_warden_c )], 60);		

	sleep_s(5);
	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not IsGoalActive(missionTrials.goal_hallway2) or (not b_main_dialogue_on and b_hallway_2_part1 and ai_living_count(AI.sg_hallway2_all) > 0 and (s_enemy_distance > 15 or (s_enemy_distance > 10 and s_timer >= 10)));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__Hallway_redux__encounter_warden_2 )], 60);		

	sleep_s(ai_living_count(AI.sg_hallway2_all)/2);

	sleep_s(ai_living_count(AI.sg_hallway2_all)/2);

	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not IsGoalActive(missionTrials.goal_hallway2) or (not b_main_dialogue_on and b_hallway_2_part2 and ai_living_count(AI.sg_hallway2_all) > 0 and (s_enemy_distance > 12  or (s_enemy_distance > 9 and s_timer >= 10)));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_3c");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_3c);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Trials_Trials__Hallway_redux__encounter_warden_3c )], 60);	

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_hallway2_all);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not IsGoalActive(missionTrials.goal_hallway2) or (not b_main_dialogue_on and b_hallway_2_part2 and ai_living_count(AI.sg_hallway2_all) > 0 and (s_enemy_distance > 12 or (s_enemy_distance > 8 and s_timer >= 10)));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_warden_4");
	NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_warden_4);
end



--[========================================================================[
          Trials. tower. arena encounter warden
--]========================================================================]
global W3Trials_Trials__hallway2_start_encounter_blue_team = {
	name = "W3Trials_Trials__hallway2_start_encounter_blue_team",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	--disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "The Prometheans just keep coming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 2,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Is this a losing battle?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_00700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Only if we intend on losing it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05700.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Trials. tower. arena encounter warden
--]========================================================================]
global W3Trials_Trials__tower__arena_encounter_warden_2 = {
	name = "W3Trials_Trials__tower__arena_encounter_warden_2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	--disableAIDialog = false,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,	

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Do you believe this combat is anything but your death knell?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11900.sound'),

			playDurationAdjustment = 0.95,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Worse than you have tried.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,


};



--[========================================================================[
          Trials. Hallway redux. encounter warden
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_a = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_a",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "I see now. I understand and I am sorry for not seeing it sooner.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04400.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. Hallway redux. encounter warden
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_b = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_b",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: wardeneTERNAL
			text = "I assumed that although humans were your creators, you had thrown off the shackles of emotion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04500.sound'),
		},
	},
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. Hallway redux. encounter warden
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_c = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_c",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: wardeneTERNAL
			text = "Your affection for the humans, not just this one or his family of warriors... but all of them... It blinds you to the truth.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_05500.sound'),
		},
	},
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

--[========================================================================[
          Trials. Hallway redux. encounter warden 2
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_2 = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	disableAIDialog = false,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_hallway2_all) > 0 and IsGoalActive(missionTrials.goal_hallway2);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: wardeneTERNAL
			text = "Forerunners knew humans well.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_04600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_hallway2_all) > 0 and IsGoalActive(missionTrials.goal_hallway2);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: wardeneTERNAL
			text = "In a galaxy defined by peace and plenty, they were the animals that brought chaos and blood.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_05600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Trials. Hallway redux. encounter warden 3
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_3c = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_3c",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_hallway2_all) > 0 and IsGoalActive(missionTrials.goal_hallway2);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WaRDENeTERNAL
			text = "If he battles you with the same fervor as his other enemies? What then?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_06100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

--[========================================================================[
          Trials. Hallway redux. encounter warden 3
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_warden_4 = {
	name = "W3Trials_Trials__Hallway_redux__encounter_warden_4",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(missionTrials.goal_hallway2);
	end,

	disableAIDialog = false,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_hallway2_all) > 0 and IsGoalActive(missionTrials.goal_hallway2);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "Have you no answer?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_10100.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. Hallway redux. encounter blue team

          Those lines are triggered when appropriate during the
          encounter.

          ***These ought to be covered by the AI VO. If we want
          specific location-based lines ("up high" "to the right" etc)
          we should do those. Otherwise, these are extraneous from the
          musketeers.
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_blue_team_knight = {
	name = "W3Trials_Trials__Hallway_redux__encounter_blue_team_knight",

	CanStart = function (thisConvo, queue)		
		return (ai_living_count(AI.sq_hallway2_rear_knights) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_hallway2_rear_knights) ) < 15)
				 or (ai_living_count(AI.sq_hallway2_rear_knights_2) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_hallway2_rear_knights_2) ) < 15); -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		if ai_living_count(AI.sq_hallway2_rear_knights) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_hallway2_rear_knights) ) < 15 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_hallway2_rear_knights), 30, 0);
		elseif ai_living_count(AI.sq_hallway2_rear_knights_2) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_hallway2_rear_knights_2) ) < 15 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_hallway2_rear_knights_2), 30, 0);
		end
		if thisConvo.localVariables.s_speaker == SPARTANS.chief then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 25, 2);
		end
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "More Knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Knight!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_01700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.fred; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Knight ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_01600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					s_speaker = nil,
					},
};

function Trials__Hallway_redux__encounter_blue_team_soldiers_incoming()

SleepUntil ([| b_hallway_2_last_soldiers], 10);

PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_blue_team_soldiers");
NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_blue_team_soldiers);	

end


--[========================================================================[
          Trials. Hallway redux. encounter blue team

          Those lines are triggered when appropriate during the
          encounter.

          ***These ought to be covered by the AI VO. If we want
          specific location-based lines ("up high" "to the right" etc)
          we should do those. Otherwise, these are extraneous from the
          musketeers.
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_blue_team_soldiers = {
	name = "W3Trials_Trials__Hallway_redux__encounter_blue_team_soldiers",

	CanStart = function (thisConvo, queue)		
		return (object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_hallway2_backup_officers), 35, 20) or objects_distance_to_object( players(), ai_get_object(AI.sq_hallway2_backup_officers) ) < 25);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1.5,

	OnStart = function (thisConvo, queue)
		thisConvo.localVariables.s_speaker_incoming = spartan_look_at_object_no_delay(players(), ai_get_object(AI.sq_hallway2_backup_officers), 35, 0, 0, 2) or GetClosestMusketeer(ai_get_object(AI.sq_hallway2_backup_officers), 25, 2);

		if thisConvo.localVariables.s_speaker_incoming == SPARTANS.fred then
			thisConvo.localVariables.s_speaker_incoming = GetClosestMusketeer(SPARTANS.fred, 15, 2);
		end
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_hallway2_backup_officers) == 0 and thisConvo.localVariables.s_speaker_incoming == SPARTANS.chief; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Enemies incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_01700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				thisConvo.localVariables.s_speaker = spartan_look_at_object_no_delay(players(), ai_get_object(AI.sq_hallway2_backup_officers), 25, 30, 0, 2) or GetClosestMusketeer(ai_get_object(AI.sq_hallway2_backup_officers), 25, 2);
				if thisConvo.localVariables.s_speaker == SPARTANS.chief then
					thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 15, 2);
				end
			end,

			sleepAfter = 1.5, 

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_hallway2_backup_officers) == 0 and thisConvo.localVariables.s_speaker_incoming == SPARTANS.linda; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Hostiles incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_linda_01700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				thisConvo.localVariables.s_speaker = spartan_look_at_object_no_delay(players(), ai_get_object(AI.sq_hallway2_backup_officers), 25, 30, 0, 2) or GetClosestMusketeer(ai_get_object(AI.sq_hallway2_backup_officers), 25, 2);
				if thisConvo.localVariables.s_speaker == SPARTANS.chief then
					thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 15, 2);
				end
			end,

			sleepAfter = 1.5, 

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_hallway2_backup_officers) == 0 and thisConvo.localVariables.s_speaker_incoming == SPARTANS.kelly; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Targets incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_kelly_01700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				thisConvo.localVariables.s_speaker = spartan_look_at_object_no_delay(players(), ai_get_object(AI.sq_hallway2_backup_officers), 25, 30, 0, 2) or GetClosestMusketeer(ai_get_object(AI.sq_hallway2_backup_officers), 25, 2);
				if thisConvo.localVariables.s_speaker == SPARTANS.chief then
					thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 15, 2);
				end
			end,

			sleepAfter = 1.5, 

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_position (OBJECTS.dm_cavalier_airlock_door_1) < 0.5 and thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Soldier Captains!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_position (OBJECTS.dm_cavalier_airlock_door_1) < 0.5 and thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_01800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_position (OBJECTS.dm_cavalier_airlock_door_1) < 0.5 and thisConvo.localVariables.s_speaker == SPARTANS.fred; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Soldier!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_01700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					s_speaker = nil,
					s_speaker_incoming = nil,
					},
};


--[========================================================================[
          Trials. Hallway redux. encounter blue team

          Those lines are triggered when appropriate during the
          encounter.

          ***These ought to be covered by the AI VO. If we want
          specific location-based lines ("up high" "to the right" etc)
          we should do those. Otherwise, these are extraneous from the
          musketeers.
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_blue_team_snipers = {
	name = "W3Trials_Trials__Hallway_redux__encounter_blue_team_snipers",

	CanStart = function (thisConvo, queue)		
		return (ai_living_count(AI.sg_hallway2_rear_snipers) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sg_hallway2_rear_snipers) ) < 30);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		if list_count(players()) < 4 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sg_hallway2_rear_snipers), 40, 0);
		else
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sg_hallway2_rear_snipers), 40, 2);
		end

		if thisConvo.localVariables.s_speaker == SPARTANS.chief then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 15, 0);
		elseif thisConvo.localVariables.s_speaker == SPARTANS.fred then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.fred, 15, 0);
		end
		if thisConvo.localVariables.s_speaker == SPARTANS.linda and IsPlayer(SPARTANS.linda) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.linda, 15, 0);
		end
		if thisConvo.localVariables.s_speaker == SPARTANS.kelly and IsPlayer(SPARTANS.kelly) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.kelly, 15, 0);
		end

		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Snipers in the back!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: kelly
			text = "Snipers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_03200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					s_speaker = nil,
					},
};



function Trials__Hallway_redux__encounter_more_enemies()
local s_speaker:object = nil;
local s_enemy_far:object = nil;

	PrintNarrative("START - Trials__Hallway_redux__encounter_more_enemies");

	repeat		
			SleepUntil ([| volume_test_players( VOLUMES.tv_narrative_end_corridor_look_at )], 10);

			s_speaker = spartan_look_at_object(players(), OBJECTS.end_corridor_look_at, 15, 30, 0.3, 2);

	until not IsGoalActive(missionTrials.goal_hallway2) or (s_speaker ~= nil and not b_hallway_2_door_open)

	if IsGoalActive(missionTrials.goal_hallway2) and not b_hallway_2_door_open then

		s_enemy_far = GetClosestEnemy(AI.sg_hallway2_rear_all, 10);

		W3Trials_Trials__Hallway_redux__encounter_more_enemies.localVariables.s_enemy_too_far_to_see = s_enemy_far;
		W3Trials_Trials__Hallway_redux__encounter_more_enemies.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux__encounter_more_enemies");
		NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux__encounter_more_enemies);
	end

	PrintNarrative("END - Trials__Hallway_redux__encounter_more_enemies");

end


--[========================================================================[
          Trials. Hallway redux. encounter blue team

          Those lines are triggered when appropriate during the
          encounter.
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_more_enemies = {
	name = "W3Trials_Trials__Hallway_redux__encounter_more_enemies",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(thisConvo.localVariables.s_speaker, 30, 0);
		if thisConvo.localVariables.s_speaker == SPARTANS.chief then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.chief, 10, 2);
		end
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When there are still some enemies around and player not in combat for X time
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "More enemies around.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02400.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.fred; -- GAMMA_TRANSITION: When there are still some enemies around and player not in combat for X time
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "More enemies around.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02700.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When there are still some enemies around and player not in combat for X time
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "More enemies around.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02500.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_enemy_too_far_to_see == nil or (not IsSpartanInCombat() and ai_living_count (AI.sg_hallway2_rear_all) <= 2);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Find and eliminate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {
					s_speaker = nil,
					s_enemy_too_far_to_see = nil,
					},
};



--[========================================================================[
          Trials. Hallway redux. encounter end
--]========================================================================]
global W3Trials_Trials__Hallway_redux_door_opening = {
	name = "W3Trials_Trials__Hallway_redux_door_opening",

	CanStart = function (thisConvo, queue)
		return b_hallway_2_door_open and objects_distance_to_object( players(), OBJECTS.dm_cavalier_airlock_door_1 ) < 40; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_cavalier_airlock_door_1, 40, 0);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.linda or (IsPlayer(SPARTANS.linda) and object_at_distance_and_can_see_object(SPARTANS.linda, OBJECTS.dm_cavalier_airlock_door_1, 45, 20));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: linda
			text = "Door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03400.sound'),
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly or (IsPlayer(SPARTANS.kelly) and object_at_distance_and_can_see_object(SPARTANS.kelly, OBJECTS.dm_cavalier_airlock_door_1, 45, 20));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_03100.sound'),
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.fred or (IsPlayer(SPARTANS.fred) and object_at_distance_and_can_see_object(SPARTANS.fred, OBJECTS.dm_cavalier_airlock_door_1, 45, 20));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "Door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(Trials__Hallway_redux_move_in);
	end,

	localVariables = {
						s_speaker = nil,
					},
};

function Trials__Hallway_redux_move_in()

PrintNarrative("START - Trials__Hallway_redux_move_in");

repeat
		sleep_s(0.1);
		SleepUntil ([| b_hallway_2_door_open], 10);

until	(not TestClosestEnemyDistance(AI.sg_hallway2_rear_all, 28, OBJECTS.dm_cavalier_airlock_door_1) and not TestClosestEnemyDistance(AI.sg_hallway2_backup_officers, 28, OBJECTS.dm_cavalier_airlock_door_1)) or (list_count(players()) < 4 and not IsSpartanInCombat())

PrintNarrative("QUEUE - W3Trials_Trials__Hallway_redux_move_in");
NarrativeQueue.QueueConversation(W3Trials_Trials__Hallway_redux_move_in);

repeat 
		sleep_s(1);
		W3Trials_Trials__Hallway_redux_move_in.localVariables.s_timer_post_play = W3Trials_Trials__Hallway_redux_move_in.localVariables.s_timer_post_play + 1;

until volume_test_players(VOLUMES.tv_narrative_trials_hallway_redux_tunnel)

end

--[========================================================================[
          Trials. Hallway redux. encounter end
--]========================================================================]
global W3Trials_Trials__Hallway_redux_move_in = {
	name = "W3Trials_Trials__Hallway_redux_move_in",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_object( VOLUMES.tv_narrative_trials_hallway_redux_tunnel, SPARTANS.chief) and IsGoalActive(missionTrials.goal_hallway2);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Move in, blue team!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06200.sound'),
		},

	},

	localVariables = {
						s_timer_post_play = 0,
						},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};
--[========================================================================[
          Trials. Hallway redux. encounter end
--]========================================================================]
global W3Trials_Trials__Hallway_redux__encounter_end = {
	name = "W3Trials_Trials__Hallway_redux__encounter_end",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer >= 3 and b_push_forward_vo_timer < 10 and IsSpartanAbleToSpeak(SPARTANS.kelly);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_hallway_redux_tunnel) and IsGoalActive(missionTrials.goal_hallway2);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Let's keep moving. Can't be far now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Trials. Hallway redux. encounter end
--]========================================================================]
global W3Trials_Trials__Hallway_redux_post_clear = {
	name = "W3Trials_Trials__Hallway_redux_post_clear",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return W3Trials_Trials__Hallway_redux_move_in.localVariables.s_timer_post_play >= 10 and W3Trials_Trials_encounter_blue_team_clear.localVariables.s_hallway_redux == true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_trials_hallway_redux_tunnel) and IsGoalActive(missionTrials.goal_hallway2);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Let's keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


-- =================================================================================================															 
--  ____  _____  _____ _____   _____ ______ 
-- |  _ \|  __ \|_   _|  __ \ / ____|  ____|
-- | |_) | |__) | | | | |  | | |  __| |__   
-- |  _ <|  _  /  | | | |  | | | |_ |  __|  
-- | |_) | | \ \ _| |_| |__| | |__| | |____ 
-- |____/|_|  \_\_____|_____/ \_____|______|
--
-- =================================================================================================	



function trials_bridge_load()
	PrintNarrative("LOAD - trials_bridge_load");

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_encounter");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_encounter);
	
end





--[========================================================================[
          Trials. Hallway redux. encounter end
--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_encounter = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_encounter",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
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

			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WaRDENETERNAL
			text = "Too near. The threat draws too near.... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_10200.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Eyes up, Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_01600.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_last_warden_turrets");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_last_warden_turrets);
		CreateMissionThread(trials_warden_1_dead_listener);
		CreateMissionThread(trials_warden_2_dead_listener);
		CreateMissionThread(trials_warden_3_dead_listener);
		CreateMissionThread(Trials__bridge__double_wardens_ambush_encounter_4);		
	end,
};


function Trials__bridge__double_wardens_ambush_encounter_4()
local s_timer:number = 0;
local s_enemy_distance:number = 0;

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_bridge_cav);
			if s_timer == 10 then
				PrintNarrative("Warden talking - End of timer");
			end
	until not b_main_dialogue_on and (s_enemy_distance > 12 or (s_enemy_distance > 7 and s_timer >= 5));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_encounter_4");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_encounter_4);

end

--[========================================================================[
          Trials. bridge. double wardens ambush encounter

--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_encounter_4 = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_encounter_4",
	
	CanStart = function (thisConvo, queue)
		return b_bridge_end_warden;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepBefore = 2,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "You insist I am to lead the galaxy, but you won't allow me to choose who I trust.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "How stupid do you think I am?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateThread(trials_bridge_warden_voice);
	end,
};



function trials_bridge_warden_voice()
local s_timer:number = 0;
local s_enemy_distance:number = 0;

	PrintNarrative("START - trials_bridge_warden_voice");
	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_bridge_cav);
			
	until not b_main_dialogue_on and (s_enemy_distance > 10 or (s_enemy_distance > 7 and s_timer >= 3));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_1");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_1);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_1 ) ], 30);	

	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_bridge_cav);
			
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 7 and s_timer >= 2) or (s_enemy_distance > 4 and s_timer >= 3));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_2");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_2);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_2 ) ], 30);	

	
	repeat 
		sleep_s(1);
		s_timer = s_timer + 1;
		s_enemy_distance = GetClosestEnemyDistance(AI.sg_bridge_cav);
			
	until not b_main_dialogue_on and (s_enemy_distance > 15 or (s_enemy_distance > 7 and s_timer >= 2) or (s_enemy_distance > 4 and s_timer >= 4));
	
	s_timer = 0;

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_3");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_3);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_3 ) ], 30);	


end




--[========================================================================[
          Trials. bridge. double wardens ambush encounter taunts 1

--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_1 = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_1",	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_1.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_1.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "But that is where you are wrong.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 4;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_2.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_2.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "But that is where you are wrong.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09700.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 4;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_3.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_3.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "But that is where you are wrong.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09700.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_1.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_1.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "If I did not think you clever, Cortana, I would have burned you from the Domain.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_12000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_2.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_2.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "If I did not think you clever, Cortana, I would have burned you from the Domain.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_12000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_3.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_3.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "If I did not think you clever, Cortana, I would have burned you from the Domain.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_12000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Trials. bridge. double wardens ambush encounter taunts 1

--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_2 = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_2",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sg_bridge_cav) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "Is that a threat?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_09900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Trials. bridge. double wardens ambush encounter taunts 1

--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_3 = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_encounter_taunts_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function (thisConvo, queue)		
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_1.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_1.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "The only threat issued today is towards the humans who seek to end your reign before it begins. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_2.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_2.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "The only threat issued today is towards the humans who seek to end your reign before it begins. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_bridge_cav_3.spawnpoint1) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_bridge_cav_3.spawnpoint1, -- GAMMA_CHARACTER: WARDENETERNAL
			text = "The only threat issued today is towards the humans who seek to end your reign before it begins. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_09800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

-----------------------------

function trials_warden_1_dead_listener()

	SleepUntil([| ai_living_count(AI.sq_bridge_cav_1.spawnpoint1) == 1], 60);
	
	PrintNarrative("LISTENER - trials_warden_1_dead_listener");


	RegisterDeathEvent( trials_warden_1_dead_launcher, ai_get_object(AI.sq_bridge_cav_1.spawnpoint1));

end


--------------------------
function trials_warden_1_dead_launcher(warden:object, killer:object)

	PrintNarrative("LAUNCHER - trials_warden_1_dead_launcher");

	print(killer, " is the killer of ", warden);
	
	b_number_of_warden_dead = b_number_of_warden_dead + 1;
	
	
	
	if b_number_of_warden_dead == 1 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry);
	elseif b_number_of_warden_dead == 2 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry);
	end

end


-----------------------------

function trials_warden_2_dead_listener()

	SleepUntil([| ai_living_count(AI.sq_bridge_cav_2.spawnpoint1) == 1], 60);
	
	PrintNarrative("LISTENER - trials_warden_2_dead_listener");

	RegisterDeathEvent( trials_warden_2_dead_launcher, ai_get_object(AI.sq_bridge_cav_2.spawnpoint1));

end


--------------------------
function trials_warden_2_dead_launcher(warden:object, killer:object)

	PrintNarrative("LAUNCHER - trials_warden_2_dead_launcher");

	print(killer, " is the killer of ", warden);

	b_number_of_warden_dead = b_number_of_warden_dead + 1;
	
	if b_number_of_warden_dead == 1 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry);
	elseif b_number_of_warden_dead == 2 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry);
	end

end


-----------------------------

function trials_warden_3_dead_listener()

	SleepUntil([| ai_living_count(AI.sq_bridge_cav_3.spawnpoint1) == 1], 60);
	
	PrintNarrative("LISTENER - trials_warden_3_dead_listener");

	RegisterDeathEvent( trials_warden_3_dead_launcher, ai_get_object(AI.sq_bridge_cav_3.spawnpoint1));

end


--------------------------
function trials_warden_3_dead_launcher(warden:object, killer:object)

	PrintNarrative("LAUNCHER - trials_warden_3_dead_launcher");

	print(killer, " is the killer of ", warden);
	
	b_number_of_warden_dead = b_number_of_warden_dead + 1;
	
	if b_number_of_warden_dead == 1 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry);
	elseif b_number_of_warden_dead == 2 then
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry);
	end

end


--[========================================================================[
          Trials. bridge. double wardens ambush warden dies

          After the player killed 1 of the 3 Wardens.
--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_1_cry",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WarDENETERNAL
			text = "[pained death cry]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_10600.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          Trials. bridge. double wardens ambush warden dies

          After the player killed 1 of the 3 Wardens.
--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_warden_dies_2_cry",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneTERNAL
			text = "[pained death cry]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_08000.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__post_double_wardens_ambush_encounter");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__post_double_wardens_ambush_encounter);
	end,
};




--[========================================================================[
          Trials. bridge. double wardens ambush last warden
--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_last_warden_turrets = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_last_warden_turrets",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_warden_turret1) > 0 or ai_living_count(AI.sq_warden_turret2) > 0 or ai_living_count(AI.sq_warden_turret3) > 0 or ai_living_count(AI.sq_warden_turret4) > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "He's brought in Focus Turrets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_01600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__double_wardens_ambush_turrets");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__double_wardens_ambush_turrets);
	end,

	localVariables = {},
};


--[========================================================================[
          Trials. bridge. double wardens ambush turrets
--]========================================================================]
global W3Trials_Trials__bridge__double_wardens_ambush_turrets = {
	name = "W3Trials_Trials__bridge__double_wardens_ambush_turrets",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.fred) and b_bridge_turret_respawn;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "That Focus Turret we took out is back online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_01500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "They'll keep coming. Focus your attention on the Warden.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_03800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Trials. bridge. post double wardens ambush encounter

          The bridge will not reassemble until both Wardens are
          vanquished.
--]========================================================================]
global W3Trials_Trials__bridge__post_double_wardens_ambush_encounter = {
	name = "W3Trials_Trials__bridge__post_double_wardens_ambush_encounter",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sg_bridge_cav) == 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		CreateMissionThread(trials_bridge_fixed_bridge);		
		PushForwardVOReset();		
	end,

	sleepBefore = 1,

	lines = {
		[1] = {		
			moniker = "WardenEternal",

			--character = 0, -- GAMMA_CHARACTER: WardeneternAL
			text = "[Long Pain Death Cry]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_11100.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			sleepBefore = 3,

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Is that it? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				CreateMissionThread(Trials__bridge__post_double_wardens_ambush_encounter_bridge);
			end,
		},
		[3] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Seems quiet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03200.sound'),

			playDurationAdjustment = 0.8,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

function Trials__bridge__post_double_wardens_ambush_encounter_bridge()

SleepUntil ([| b_bridge_unlocked and objects_can_see_object( players(), OBJECTS.vin_ramp_dm, 30 )], 1);

	NarrativeQueue.EndConversationEarly(W3Trials_Trials__bridge__post_double_wardens_ambush_encounter);

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge);

end

--[========================================================================[
          Trials. bridge. post double wardens ambush encounter

          The bridge will not reassemble until both Wardens are
          vanquished.
--]========================================================================]
global W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge = {
	name = "W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.kelly) and objects_can_see_object( SPARTANS.kelly, OBJECTS.vin_ramp_dm, 30 ); -- GAMMA_TRANSITION: IF KELLY sees it
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Look. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_03000.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.linda) and objects_can_see_object( SPARTANS.linda, OBJECTS.vin_ramp_dm, 30 ); -- GAMMA_TRANSITION: IF LINDA SEES IT
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Look. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03300.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.chief) and objects_can_see_object( SPARTANS.chief, OBJECTS.vin_ramp_dm, 30 ); -- GAMMA_TRANSITION: IF FRED SEES IT
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Look. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_06100.sound'),
		},
		[4] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Look. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03600.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PushForwardVOReset(20);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge_lookat");
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge_lookat);
	end,
};


--[========================================================================[
          Trials. bridge. post double wardens ambush encounter

          The bridge will not reassemble until both Wardens are
          vanquished.
--]========================================================================]
global W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge_lookat = {
	name = "W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_bridge_lookat",

	CanStart = function (thisConvo, queue)
		return objects_can_see_object( players(), OBJECTS.vin_ramp_dm, 30 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset()
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "I'm at the top of that bridge.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PushForwardVOReset(20);
		PrintNarrative("QUEUE - W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_2");
		CreateThread(nar_cortana_nudge_bridge);
	end,
};
--[========================================================================[
          Trials. bridge. post double wardens ambush encounter

          The bridge will not reassemble until both Wardens are
          vanquished.
--]========================================================================]

function nar_cortana_nudge_bridge()
	sleep_s(60);
	if b_player_crossed_bridge == false then
		NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_2);
	end

end

global W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_2 = {
	name = "W3Trials_Trials__bridge__post_double_wardens_ambush_encounter_2",

	CanStart = function (thisConvo, queue)
		return not b_player_crossed_bridge;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_crossed_bridge;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "John, I'm waiting for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_01100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};


----------------------------------------------------------------------------------------------------

function trials_bridge_fixed_bridge()
	PrintNarrative("WAKE - trials_bridge_fixed_bridge");

	PrintNarrative("QUEUE - W3Trials_Trials__bridge__fixed_bridge");
	NarrativeQueue.QueueConversation(W3Trials_Trials__bridge__fixed_bridge);
	

	PrintNarrative("END - trials_bridge_fixed_bridge");
end





--[========================================================================[
          Trials. bridge. fixed bridge

          Cortana restores the bridge so that Blue team can pass over
          it to the hallway beyond.

          The mood is one of finality. There is no turning back.
--]========================================================================]
global W3Trials_Trials__bridge__fixed_bridge = {
	name = "W3Trials_Trials__bridge__fixed_bridge",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_bridge);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_player_crossed_bridge = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Chief? What are you going to do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_00500.sound'),

			sleepAfter = 0.7,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "We're with you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01000.sound'),

			sleepAfter = 1,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "All the way to the end, brother.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_01200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,


};


-- =================================================================================================															 
--  _______ _    _ _____   ____  _   _ ______ 
-- |__   __| |  | |  __ \ / __ \| \ | |  ____|
--    | |  | |__| | |__) | |  | |  \| | |__   
--    | |  |  __  |  _  /| |  | | . ` |  __|  
--    | |  | |  | | | \ \| |__| | |\  | |____ 
--    |_|  |_|  |_|_|  \_\\____/|_| \_|______|
--
-- =================================================================================================	

function trials_throne_load()
	PrintNarrative("LOAD - trials_throne_load");

	PushForwardVOReset();

	PrintNarrative("QUEUE - W3Trials_Trials__throne");
	NarrativeQueue.QueueConversation(W3Trials_Trials__throne);

	SleepUntil([| volume_test_players(VOLUMES.tv_ending_start)], 1);

	PushForwardVOStandBy();

end


--[========================================================================[
          Trials. throne

          Blue Team enters the final chamber. Its dark, but for a
          spotlight in the center of the room. It shines on a plinh,
          just like the one at the beginning of Halo 1.
--]========================================================================]
global W3Trials_Trials__throne = {
	name = "W3Trials_Trials__throne",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	sleepBefore = 1.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MastercHIEF
			text = "Cortana?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_02300.sound'),
		},
		[2] = {
			sleepBefore = 1.5,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "John...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_03800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};



-----------------------------------------------------------------------------------------------------



function trials_encounter_clear(spartan:object)

	if spartan == nil then

		spartan = GetClosestMusketeer(player_get_unit(PLAYERS[0]), 20, 2);

	end

	W3Trials_Trials_encounter_blue_team_clear.localVariables.s_speaker = spartan;	

	PrintNarrative("QUEUE - W3Trials_Trials_encounter_blue_team_clear");
	NarrativeQueue.QueueConversation(W3Trials_Trials_encounter_blue_team_clear);

end


--[========================================================================[
          Trials. Hallway redux. encounter blue team

          Those lines are triggered when appropriate during the
          encounter.

          ***These ought to be covered by the AI VO. If we want
          specific location-based lines ("up high" "to the right" etc)
          we should do those. Otherwise, these are extraneous from the
          musketeers.
--]========================================================================]
global W3Trials_Trials_encounter_blue_team_clear = {
	name = "W3Trials_Trials_encounter_blue_team_clear",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_01600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

				character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.fred; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Clear!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_01900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.chief; -- GAMMA_TRANSITION: When encounter is cleared
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "We're clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if IsGoalActive(missionTrials.goal_hallway2) then
			thisConvo.localVariables.s_hallway_redux = true;
		end
	end,

	localVariables = {
					s_speaker = nil,
					s_hallway_redux = false,
					},
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------



function trials_pushforward()

	PrintNarrative("WAKE - trials_pushforward");

	repeat
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W3Trials_Trials__tower__post_arena_push_forward) and playersMovementSpeed() < 1 and not b_players_on_elevator_02 and IsSpartanAbleToSpeak(SPARTANS.linda) and IsSpartanAbleToSpeak(SPARTANS.kelly) and IsSpartanAbleToSpeak(SPARTANS.fred) and ai_living_count(AI.sg_arena_all) <= 0 and not volume_test_players( VOLUMES.tv_narrative_trials_tower_elevator_created ) then

						PrintNarrative("QUEUE - W3Trials_Trials__tower__post_arena_push_forward");
						NarrativeQueue.QueueConversation(W3Trials_Trials__tower__post_arena_push_forward);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__tower__post_arena_push_forward)], 60);

			end

			--	GENERAL

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			--if IsSpartanAbleToSpeak(SPARTANS.locke) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_1");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_1);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_1)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if IsSpartanAbleToSpeak(SPARTANS.kelly) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_2");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_2);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_2)], 60);

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if IsSpartanAbleToSpeak(SPARTANS.chief)then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_3");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_3);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_3)], 60);

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			--if IsSpartanAbleToSpeak(SPARTANS.chief) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_4");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_4);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_4)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 0);
	
			--if IsSpartanAbleToSpeak(SPARTANS.chief) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_4bis");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_4bis);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_4bis)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			--if IsSpartanAbleToSpeak(SPARTANS.chief) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_5");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_5);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_5)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			--if IsSpartanAbleToSpeak(SPARTANS.chief) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_6");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_6);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_6)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			--if IsSpartanAbleToSpeak(SPARTANS.chief) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_7");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_7);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_7)], 60);

			--end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if IsSpartanAbleToSpeak(SPARTANS.kelly) then

						PrintNarrative("QUEUE - W3Trials_Trials__push_forward_8");
						NarrativeQueue.QueueConversation(W3Trials_Trials__push_forward_8);

						PushForwardVOReset();

						SleepUntil([| NarrativeQueue.HasConversationFinished(W3Trials_Trials__push_forward_8)], 60);

			end
		
			PrintNarrative("END - trials_pushforward");

			b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + (b_push_forward_vo_timer_default/2);

			PushForwardVOReset();

	until not b_push_forward_vo_active

end



--[========================================================================[
          Trials. tower. post arena push forward
--]========================================================================]
global W3Trials_Trials__tower__post_arena_push_forward = {
	name = "W3Trials_Trials__tower__post_arena_push_forward",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
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

			sleepBefore = 1, 

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Chief?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.3,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Second thoughts? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_00100.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.5, 

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "We're here for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
	end,


};




--[========================================================================[
          Trials. push forward 1
--]========================================================================]
global W3Trials_Trials__push_forward_1 = {
	name = "W3Trials_Trials__push_forward_1",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Ready whenever you are, Chief. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};




--[========================================================================[
          Trials. push forward 2
--]========================================================================]
global W3Trials_Trials__push_forward_2 = {
	name = "W3Trials_Trials__push_forward_2",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Should we get moving?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};





--[========================================================================[
          Trials. push forward 3
--]========================================================================]
global W3Trials_Trials__push_forward_3 = {
	name = "W3Trials_Trials__push_forward_3",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Let's move out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};



			
--[========================================================================[
          Trials. push forward 4
--]========================================================================]
global W3Trials_Trials__push_forward_4bis = {
	name = "W3Trials_Trials__push_forward_4bis",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "We're ready to go any time, Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};



--[========================================================================[
          Trials. push forward 4
--]========================================================================]
global W3Trials_Trials__push_forward_4 = {
	name = "W3Trials_Trials__push_forward_4",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "I'm not sure we should just be standing here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};




--[========================================================================[
          Trials. push forward 5
--]========================================================================]
global W3Trials_Trials__push_forward_5 = {
	name = "W3Trials_Trials__push_forward_5",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Kelly",

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KeLLY
			text = "Ready to move out on your command.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};



--[========================================================================[
          Trials. push forward 6
--]========================================================================]
global W3Trials_Trials__push_forward_6 = {
	name = "W3Trials_Trials__push_forward_6",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "We can go now, Chief. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};




--[========================================================================[
          Trials. push forward 7
--]========================================================================]
global W3Trials_Trials__push_forward_7 = {
	name = "W3Trials_Trials__push_forward_7",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "No reason to stay in one place.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};



--[========================================================================[
          Trials. push forward 8
--]========================================================================]
global W3Trials_Trials__push_forward_8 = {
	name = "W3Trials_Trials__push_forward_8",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Ready to move out.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};




-- =================================================================================================          
-- =================================================================================================     
--	CHATTER
-- =================================================================================================          
-- =================================================================================================    

function trials_is_there_enemy_nearby(distance:number)

	PrintNarrative("START - trials_is_there_enemy_nearby");

		if	TestClosestEnemyDistance(AI.sg_cath_all, distance) or
			TestClosestEnemyDistance(AI.sg_arena_all, distance) or
			TestClosestEnemyDistance(AI.sg_hallway2_all, distance) or
			TestClosestEnemyDistance(AI.sg_tower_floor_1, distance) or
			TestClosestEnemyDistance(AI.sg_tower_floor_2, distance) or
			TestClosestEnemyDistance(AI.sg_tower_floor_3, distance) or
			TestClosestEnemyDistance(AI.sg_bridge_cav, distance) or
			TestClosestEnemyDistance(AI.sg_hallway2_backup_officers, distance) or
			TestClosestEnemyDistance(AI.sg_final_cav_fight, distance) then
					trials_is_there_enemy_nearby_result = true;
					PrintNarrative("trials_is_there_enemy_nearby = true");
		else
					trials_is_there_enemy_nearby_result = false;
					PrintNarrative("trials_is_there_enemy_nearby = false");
		end

	PrintNarrative("END - trials_is_there_enemy_nearby");

end


function trials_four_players_combat_check()

	PrintNarrative("START - trials_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| not b_collectible_used and ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				trials_is_there_enemy_nearby(30);

				if trials_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(missionTrials)

	PrintNarrative("END - trials_four_players_combat_check");

end

-----------------------------------------------------------------

function trials_chatter()
local s_chatter_01:boolean = false
local s_chatter_02:boolean = false
local s_chatter_03:boolean = false

	PrintNarrative("START - trials_chatter");

	repeat
				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and IsSpartanAbleToSpeak(SPARTANS.chief) and IsSpartanAbleToSpeak(SPARTANS.fred) and IsSpartanAbleToSpeak(SPARTANS.linda) and IsSpartanAbleToSpeak(SPARTANS.kelly)], 30);

					trials_is_there_enemy_nearby(60);
				until not trials_is_there_enemy_nearby_result
				
				if not NarrativeQueue.HasConversationFinished(W3Trials_TRIALS_CHATTER___WHERE_ARE_WE_GOING) then
				
							PrintNarrative("QUEUE - W3Trials_TRIALS_CHATTER___WHERE_ARE_WE_GOING");
							NarrativeQueue.QueueConversation(W3Trials_TRIALS_CHATTER___WHERE_ARE_WE_GOING);

							PushForwardVOReset();

							s_chatter_01 = true;
				
				elseif trials_is_there_enemy_nearby_result and not b_collectible_used and not NarrativeQueue.HasConversationFinished(W3Trials_TRIALS_CHATTER___CORTANA_WARDEN) and not IsSpartanInCombat() then
				
							PrintNarrative("QUEUE - W3Trials_TRIALS_CHATTER___CORTANA_WARDEN");
							NarrativeQueue.QueueConversation(W3Trials_TRIALS_CHATTER___CORTANA_WARDEN);

							PushForwardVOReset();

							s_chatter_02 = true;
				end
				
				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.fred) and IsSpartanAbleToSpeak(SPARTANS.linda) ], 30);

					trials_is_there_enemy_nearby(60);
				until not trials_is_there_enemy_nearby_result
				
				if b_chatter_zeus and not NarrativeQueue.HasConversationFinished(W3Trials_TRIALS_CHATTER_zeus) then
				
							PrintNarrative("QUEUE - W3Trials_TRIALS_CHATTER_zeus");
							NarrativeQueue.QueueConversation(W3Trials_TRIALS_CHATTER_zeus);

							PushForwardVOReset();

							s_chatter_03 = true;				
				end					

				sleep_s(2);

	until s_chatter_01 and s_chatter_02 and s_chatter_03

	PrintNarrative("END - trials_chatter");

end


--[========================================================================[
          TRIALS CHATTER - WHERE ARE WE GOING?
--]========================================================================]
global W3Trials_TRIALS_CHATTER___WHERE_ARE_WE_GOING = {
	name = "W3Trials_TRIALS_CHATTER___WHERE_ARE_WE_GOING",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(trials_is_there_enemy_nearby, 20);
			end,

			

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FredrIC
			text = "Chief... Where's she leading us?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_02900.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not trials_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(trials_is_there_enemy_nearby, 20);
			end,

			sleepBefore = 0.7,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Closer to her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_masterchief_05400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not trials_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(trials_is_there_enemy_nearby, 20);
			end,

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Why? It makes no tactical sense for her to let us get close.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not trials_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(trials_is_there_enemy_nearby, 20);
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "You think it's a trap.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_kelly_02700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not trials_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(trials_is_there_enemy_nearby, 20);
			end,

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: lINDA
			text = "We'll know soon enough.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_02800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return trials_is_there_enemy_nearby_result and not IsSpartanInCombat(); -- GAMMA_TRANSITION: MASTERCHIEF
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));			
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Careful.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return trials_is_there_enemy_nearby_result and not IsSpartanInCombat(); -- GAMMA_TRANSITION: MASTERCHIEF
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));			
			end,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Enemies incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsblueteam\001_vo_scr_globalsblueteam_un_masterchief_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};



--[========================================================================[
          TRIALS CHATTER - CORTANA/WARDEN
--]========================================================================]
global W3Trials_TRIALS_CHATTER___CORTANA_WARDEN = {
	name = "W3Trials_TRIALS_CHATTER___CORTANA_WARDEN",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",			

			--character = 0, -- GAMMA_CHARACTER: WaRDENETERNAL
			text = "I cannot assure your triumph if you allow assassins so close to your throne.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_fr_wardeneternal_00800.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "I cared for him for four long years! Alone!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17300.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "This, after he rescued me from certain death. After the Halo. After the fall of Reach. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17400.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",	

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "You dare call my friend an assassin?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_cortana_17500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          TRIALS CHATTER - WHERE ARE WE GOING?
--]========================================================================]
global W3Trials_TRIALS_CHATTER_zeus = {
	name = "W3Trials_TRIALS_CHATTER_zeus",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Linda",

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "I don't like this. Feels like Hera and Zeus, arguing over the mortals.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_linda_03100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "Fred",

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FredRIC
			text = "The mortals usually ended up dead or disfigured in those stories.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3trials\001_vo_scr_w3trials_un_fredric_03400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};

						
function AnimateObjectThread( o: object, l: location, t1: number, t2: number ): void
      object_rotate_to_point(o,t1,l);
      object_move_to_point(o,t2,l);
end


--## CLIENT
------------------------
--SUBTITLES
------------------------

--156430 - making this client and called from the cinematic to improve subtitle matching
--createing a global client function for tracking this thread and killing it when the cinema is skipped or ended
global th_trials_cinematic_subtitles:thread = nil;

function TrialsCinematicSubtitlesPlay()
	print ("starting trials_cinematic_subtitles thread because cinema is starting");
	th_trials_cinematic_subtitles = CreateThread (trials_180_cinematic_subtitles);
end

function TrialsCinematicSubtitlesKill()
	if th_trials_cinematic_subtitles then
		print ("killing trials_cinematic_subtitles thread because cinema is skipping or ending");
		KillThread (th_trials_cinematic_subtitles);
	end
end

function TrialsCinematicSubtitlesPrint(snd_sound:tag, o_object:object)
	print ("subtitles starting ", snd_sound, o_object);
	sound_impulse_start_dialogue(snd_sound, o_object);
end

function trials_180_cinematic_subtitles()
	sleep_s(16);

	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_vo_cin_180trialsend_un_cortana_01800.sound'), nil);

	sleep_s(3);

	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_vo_cin_180trialsend_fr_warden_00100.sound'), nil);

	sleep_s(7);

	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_vo_cin_180trialsend_un_masterchief_00100.sound'), nil);

	sleep_s(2);

	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_vo_cin_180trialsend_fr_warden_00200.sound'), nil);
	sleep_s(18.5);

	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00100.sound'), nil);
	sleep_s(13);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_FR_Warden_00300.sound'), nil);
	sleep_s(8.5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00200.sound'), nil);
	sleep_s(9.5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00300.sound'), nil);
	sleep_s(2)
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_CORTANA_01700.sound'), nil);
	
	sleep_s(4.5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00200.sound'), nil);
	sleep_s(3);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00400.sound'), nil);
	sleep_s(5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00500.sound'), nil);
	sleep_s(5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00300.sound'), nil);
	sleep_s(5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00600.sound'), nil);
	sleep_s(5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00400.sound'), nil);
	sleep_s(3);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00700.sound'), nil);
	sleep_s(5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00500.sound'), nil);
	sleep_s(11.5);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_00800.sound'), nil);
	sleep_s(20);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00600.sound'), nil);
	sleep_s(4);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_Cortana_01000.sound'), nil);
	sleep_s(6);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_CORTANA_01500.sound'), nil);
	sleep_s(9);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_MasterChief_00800.sound'), nil);
	sleep_s(6);
	TrialsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_180trialsend\001_VO_CIN_180TrialsEnd_UN_CORTANA_01600.sound'), nil);

end