--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 01 NARRATIVE - evacuation 1 *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		
	global b_linger_elevator:boolean=false;
	global b_tanaka_triggered_elevator:boolean=false;
	global nar_evac_elevator_enter_combat:boolean=false;
	global b_not_inside_elevator:boolean=false;
	global b_combat_entered:boolean=false;
	global nar_door_open:boolean=false;
	global outpost_combat_complete:boolean=false;
	global nar_evac_outpost_reached:boolean=false;
	global elevator_base_combat_complete:boolean=false;
	global scaffold_top_reached:boolean=false;
	global elevator_combat_complete:boolean=false;
	global first_combat_start:boolean=false;
	global elevator_stop:number=1;
	global start_elevator_event:boolean=false;
	global scaffold_climb_complete:boolean=false;
	global b_exited_elevator:boolean=false;
	global b_elevator_entered:boolean=false;
	global elevator_button_used:boolean=false;
	global n_injured_miner_vo:number=0;
	global n_dead_miner_controller:number=0;
		global b_evacuation_chatter_1_played:boolean = false;
	global b_evacuation_chatter_2_played:boolean = false;
	global b_evacuation_chatter_3_played:boolean = false;
	global b_evacuation_chatter_4_played:boolean = false;
	global b_evacuation_idle_chatter_on:boolean = false;
	global b_first_combat_nudge:boolean = false;
	global b_pelican_elevator:boolean = false;
	global elevator_button_pinged:boolean = false;
	global b_cinematic_evac_start:boolean = false;

--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////




function nar_evac_warthog():void
 print("EVACUATION NARRATIVE START");
		print("nar_goal_evac_warthog");
	--	dialog_line_temp_blurb_force_set(true);
	--b_temp_line_display_blurb = true;
	--b_temp_line_display_blurb_force = true;
	CreateThread(nar_evac_level_start);
	
	CreateThread(nar_evac_fleeing_miners);
	--CreateThread(nar_evac_bamf_pad_look);
	
	NarrativeQueue.QueueConversation(nar_sloan_broadcast2);
		
	--	SET THE NARRATIVE DEBUG INFO ON
	g_display_narrative_debug_info = true;


	print("Narrative log display is:", g_display_narrative_debug_info);
end

	function nar_goal_evac_outpost():void
	
		print("nar_goal_evac_outpost");
	CreateThread(nar_evac_elevator_base);
	CreateThread(nar_evac_enter_outpost);
		
	end
	
	function nar_goal_evac_elevatorbase():void
	
		print("nar_goal_evac_elevatorbase");
		RegisterSpartanTrackingPingObjectEvent(nar_elevator_pinged, OBJECTS.dc_elevator_control)
		CreateThread(nar_evac_elevator_base_enter_combat);
	CreateThread(nar_evac_eleavtor_enter);

	end
	
	function nar_goal_evac_elevatorride():void
	
		print("nar_goal_evac_elevatorride");
		
	end
	
	function nar_goal_evac_scaffold():void
	--	print("TESTING TO SEE IF SCAFFOLD STARTS");
		print("nar_goal_evac_scaffold");
		--CreateThread(nar_keep_climbing);
		CreateThread(nar_pulse_three);
		CreateThread(audio_metal_rumble);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PULSE_THREE);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR_SCAFFOLD_REACHED);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR_PHAETONS);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PULSE_TWO);
		CreateThread(nar_enter_super_rung);
	end
	
	function nar_goal_evac_control():void
	--		print("TESTING TO SEE IF CONTROL STARTS");
		print("nar_goal_evac_control");
	--	CreateThread(nar_enter_ending);
	--	CreateThread(nar_enter_super_rung);
		NarrativeQueue.QueueConversation(W1Evacuation_nar_enter_ending);
	end
	
	




-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					WARTHOG RIDE
--
-- Covers content in the warthog ride.
--
-- =================================================================================================






function nar_evac_level_start()
	SleepUntil([| current_zone_set() == ZONE_SETS.drive01_miningtown], 10);
	NarrativeQueue.QueueConversation(W1Evacuation__EVACUATION_START);
end

global W1Evacuation__EVACUATION_START = {
	name = "W1Evacuation__W1Evacuation__EVACUATION_STARTEVACUATION_",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We're on the surface?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02500.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
							hud_hide_radio_transmission_hud();
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[2] = {

			character = CHARACTER_OBJECTS.sloan_loudspeaker, -- GAMMA_CHARACTER: Buck
			text = "People of Meridian...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00100.sound'),
		},
		[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Sloan's giving evac orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02300.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		  		sleepBefore = 0.25,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "He knows. Somehow--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01900.sound'),

				
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Knows what?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02600.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W1Evacuation__GUARDIAN_SEE = {
	name = "W1Evacuation__GUARDIAN_SEE",
		sleepBefore = 0.5,
		canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Look! The Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_00500.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
					
					
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Oh no...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_03000.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Where the hell is it going?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03500.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, Chief is on board that thing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02800.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
						character = CHARACTER_SPARTANS.locke,
			text = "We get airborne--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03700.sound'),
			

		},
	[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The other colonies Captain Lasky told us about... This is what happened to them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_00100.sound'),
		},
--           Vale gets serious. The overlapping dialog ceases.

		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.25,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, this colony is going to be a crater soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02000.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "We can't take anything that flies from these people.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_00100.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Our pelican is on the space elevator. We could use that. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03200.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			b_pelican_elevator = true;
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           (slight tweak in this timing)
-- 
--           Sometime after this, probably as we're driving:

		[10] = {
	sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The other colonies -- there are more Guardians--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01700.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[11] = {
	OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Really only concerned about the one in front of us right now, Vale. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02400.sound'),
		},
				[12] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "But why this one?! Why is the Chief on this Guardian? I think it's the first one Cortana activated on purpose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_04200.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		rumble_shake_medium(2);
		CreateThread(audio_guardian_roar);
		CreateThread(nar_drive_chatter_controller);
		CreateThread(nar_evac_robards_call);
		CreateThread(nar_evac_keep_moving);
	end,

	localVariables = {},
};

function nar_evac_level_start2()
--SleepUntil([| volume_test_players(VOLUMES.nar_guardian_see) ], 1);
	CreateThread(guardian_whalesong_beginning);
	sleep_s(5.5);
	NarrativeQueue.QueueConversation(W1Evacuation__GUARDIAN_SEE);
	
	
end

function nar_drive_chatter_controller()
	sleep_s(30);
	if volume_test_players(VOLUMES.nar_evac_guardian_rising2) then
SleepUntil( [| b_collectible_used == false ], 1);
		CreateThread(nar_evac_warthog_nudge);
	end

end

global W1Evacuation_chatter_line_01 = {
	name = "W1Evacuation_chatter_line_01",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Be appreciated if Sloan could shut down those sirens. Doing nothing but adding to the panic and there's more'n enough of that to go around.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03300.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};



function miner_radio_chatter()

sleep_s(90);
if b_elevator_entered == false then
SleepUntil( [| b_collectible_used == false ], 1);
	NarrativeQueue.QueueConversation(W1Evacuation__EVACUATION_RADIOPLAY1);
end
end

global W1Evacuation__EVACUATION_RADIOPLAY1 = {
	name = "W1Evacuation__EVACUATION_RADIOPLAY1",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale02_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Control, I got no idea if this bird's space worthy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale02_00300.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			hud_hide_radio_transmission_hud();
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,	
		},
		[2] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale02_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 3,
			
			text = "She's not gonna fly. Need another way to get these people off world.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale02_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};


function nar_evac_warthog_nudge()
	sleep_s(3);
	print("TESTING IF ANY PLAYER IS IN A VEHICLE");
--		TESTING IF ANY PLAYER IS IN A VEHICLE
			local in_vehicle:boolean = false;

		if IsPlayer(SPARTANS[1]) then
			in_vehicle = unit_in_vehicle(SPARTANS[1]);
			print("PLAYER 1 IN A VEHICLE");
		end

		if not in_vehicle and IsPlayer(SPARTANS[2]) then
			in_vehicle = unit_in_vehicle(SPARTANS[2]);
			print("PLAYER 2 IN A VEHICLE");
		end
		 
		if not in_vehicle and IsPlayer(SPARTANS[3]) then
			in_vehicle = unit_in_vehicle(SPARTANS[3]);
			print("PLAYER 3 IN A VEHICLE");
		end
       
		if not in_vehicle and IsPlayer(SPARTANS[4]) then
			in_vehicle = unit_in_vehicle(SPARTANS[4]);
			print("PLAYER 4 IN A VEHICLE");
		end
		if not in_vehicle and not unit_in_vehicle(nil) then
		print("get in a vehicle");
		NarrativeQueue.QueueConversation(W1Evacuation_LANDING_PAD__warthog_callout);

		else
		print("in a vehicle");
		NarrativeQueue.QueueConversation(W1Evacuation_LANDING_PAD__warthog_callout2);
	end
			

end

global W1Evacuation_LANDING_PAD__warthog_callout = {
	name = "W1Evacuation_LANDING_PAD__warthog_callout",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Grab those warthogs! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};
global W1Evacuation_LANDING_PAD__warthog_callout2 = {
	name = "W1Evacuation_LANDING_PAD__warthog_callout2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						character = CHARACTER_SPARTANS.locke,
			text = "Drive!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_00400.sound'),

		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};




function nar_evac_fleeing_miners()
	SleepUntil([| object_index_valid( AI.sq_warthog01.aisquadspawnpoint11 )], 1);
	--print("step1");
	SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.sq_warthog01.aisquadspawnpoint11)) < 5 ], 1);
	--story_blurb_add("domain", "miner VO.");
	NarrativeQueue.QueueConversation(W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_RISES);
end


global W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_RISES = {
	name = "W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_RISES",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_warthog01.aisquadspawnpoint11, -- GAMMA_CHARACTER: MINERmale01
			text = "Get to the space elevator!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00200.sound'),
		},
		[2] = {
			character = AI.sq_warthog01.aisquadspawnpoint09, -- GAMMA_CHARACTER: Minerfemale01
			text = "These damn things won't let us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00200.sound'),
		},
--                                                   CUT TO:
-- 
--           
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};



function nar_evac_guardian_rising()
		SleepUntil([|volume_test_players(VOLUMES.nar_evac_guardian_rising)], 1);
	CreateThread(guardian_whalesong_close);

			sleep_s(8);
			ai_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
	l_dialog_id = dialog_start_foreground("halsey_level_start", l_dialog_id, true, def_dialog_style_queue(), false, "", 1.0);
		
		--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_00500.sound'), false, nil, 0.0, "", "Vale : Chief's on that thing? What the hell are he and Cortana doing?", true );
			l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_dialogue_enable(true);
end

function nar_evac_keep_moving()
sleep_s(240);
	if nar_evac_outpost_reached == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1Evacuation_Flight_to_elevator__Move_nudge);
	end

end

global W1Evacuation_Flight_to_elevator__Move_nudge = {
	name = "W1Evacuation_Flight_to_elevator__Move_nudge",
	sleepBefore = 0.5,
	CanStart = function (thisConvo, queue)
		return (unit_get_health( SPARTANS.tanaka) > 0); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Pelican's at the top of the elevator. Let's move.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_Tanaka_01900.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_evac_keep_moving2);

	end,

	localVariables = {},
};

function nar_evac_keep_moving2()
sleep_s(60);
	if nar_evac_outpost_reached == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1Evacuation_Flight_to_elevator__Move_nudge2);
	end

end

global W1Evacuation_Flight_to_elevator__Move_nudge2 = {
	name = "W1Evacuation_Flight_to_elevator__Move_nudge2",
	sleepBefore = 0.5,
		CanStart = function (thisConvo, queue)
		return (unit_get_health( SPARTANS.buck) > 0); -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Never going to get to the pelican if we keep messing around down here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02200.sound'),


		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_evac_robards_call()
SleepUntil([| volume_test_players(VOLUMES.tv_ship_fall) ], 1);

	CreateThread(guardian_whalesong_chase);
	
		sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_whalesong_distant.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	sleep_s(2.5);
		NarrativeQueue.QueueConversation(W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_REMINDER);
end
global W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_REMINDER = {
	name = "W1Evacuation_FLIGHT_TO_ELEVATOR__GUARDIAN_REMINDER",
		canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Guardian's got a hell of a singing voice.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_00800.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Can we do autopilot retrieval? Bring the Pelican down to us?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
				return 3; -- GAMMA_NEXT_LINE_NUMBER
			end,
				

		},
				[3] = {
		
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			
			text = "Mayday! Mayday! We're taking fire! We're hit!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00500.sound'),
		},

		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Not with those ships shooting everything out of the sky.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1Evacuation_Flight_to_elevator__sloan_broadcast = {
	name = "W1Evacuation_Flight_to_elevator__sloan_broadcast",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_evac_fleeing_miners); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "This is Governor Sloan broadcasting on all frequencies. People, if you are still planetside, make your way to the space elevator right now. Final shuttles are departing soon with or without you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_01100.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global nar_sloan_broadcast2 = {
	name = "nar_sloan_broadcast2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_evac_fleeing_miners);
	end,
		canStartOnce = true,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnPlay = function (thisConvo, queue) -- VOID
		print("nar_sloan_broadcast narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,

			--character = CHARACTER_SPARTANS.buck,
			text = "Sloan : This is Governor Sloan broadcasting on all frequencies. People, if you are still planetside, make your way to the space elevator right now. Final shuttles are departing soon with or without you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_01100.sound'),
			sleepAfter = 1,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			hud_hide_radio_transmission_hud();
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			
			text = "Governor Sloan, shuttle Bravo-Three prepped for take off. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00600.sound'),
			sleepAfter = 2,
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			hud_hide_radio_transmission_hud();
				return 3; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			
			text = "Watch it! They're on your tail!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00700.sound'),
			
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
		
	end,
};


-- =================================================================================================
--
--					ELEVATOR BASE
--
-- Covers content in the elevator base.
--
-- =================================================================================================
function nar_evac_enter_outpost()
SleepUntil([| volume_test_players(VOLUMES.nar_evac_enter_outpost) ], 1);
	
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02100.sound'), OBJECTS.outpost_pa_r);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02100b.sound'), OBJECTS.outpost_pa_l);

	nar_evac_outpost_reached = true;
	sleep_s(6);
			NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__WON_T_OPEN_DOOR);
			
	
end

global W1Evacuation_SPACE_ELEVATOR__WON_T_OPEN_DOOR = {
	name = "W1Evacuation_SPACE_ELEVATOR__WON_T_OPEN_DOOR",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.locke) > 0 ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						character = CHARACTER_SPARTANS.locke, 
			text = "Governor Sloan. We need access to the space elevator--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03600.sound'),

		},
		[2] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			
			text = "Can't do that, Spartans. Got too many people taking refuge inside. They'd be slaughtered.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00800.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
						character = CHARACTER_SPARTANS.locke, 
			text = "Understood, Governor. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03900.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
						character = CHARACTER_SPARTANS.locke, 
			text = "Osiris. Clear the area so they can open those doors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_00700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_outpost_combat_nudge);
	CreateThread(nar_evac_looping_pa_outpost);
	CreateThread(miner_radio_chatter);
	end,

	localVariables = {},
};


function nar_evac_base_combat_complete()
	print("deprecated");
end

function nar_evac_elevator_base()
SleepUntil([| object_index_valid( AI.miner_squad_04.miner_takedown )], 1);
	--print("step1");
	SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.miner_squad_04.miner_takedown)) < 5 ], 1);
	NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__BASE);
end

global W1Evacuation_SPACE_ELEVATOR__BASE = {
	name = "W1Evacuation_SPACE_ELEVATOR__BASE",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miner_squad_04.miner_takedown, -- GAMMA_CHARACTER: Minerfemale01
			text = "Let's go! Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00300.sound'),
		},
--           Just as Osiris arrives, Prometheans arrive as well, attacking
--           Osiris.
-- 
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_evac_elevator_doors_closing()

			print("deprecated");

end

function nar_evac_looping_pa_outpost()
sleep_s(45);
	if outpost_combat_complete == false then
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02100.sound'), OBJECTS.outpost_pa_r);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02100b.sound'), OBJECTS.outpost_pa_l);
		CreateThread(nar_evac_looping_pa_outpost);
	end
end

function nar_outpost_combat_nudge()
	sleep_s(120);
	if outpost_combat_complete == false then
	SleepUntil( [| b_collectible_used == false ], 1);

			NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__BASE_COMBAT_NUDGE);
	end

end

global W1Evacuation_SPACE_ELEVATOR__BASE_COMBAT_NUDGE = {
	name = "W1Evacuation_SPACE_ELEVATOR__BASE_COMBAT_NUDGE",

	sleepBefore = 0.5,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "What's taking so long, Spartans? Your propaganda's overselling your skills. I ain't opening these doors until the base is clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_01200.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We get to stop being polite with him real soon here, right?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_evac_base_doors_opening()
outpost_combat_complete = true;

		sleep_s(3);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02200.sound'), OBJECTS.outpost_pa_l);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02200b.sound'), OBJECTS.outpost_pa_r);
		sleep_s(3);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__DOOR_OPENING);
		
		
end

global W1Evacuation_SPACE_ELEVATOR__DOOR_OPENING = {
	name = "W1Evacuation_SPACE_ELEVATOR__DOOR_OPENING",

			CanStart = function (thisConvo, queue)
		return volume_test_players_lookat(VOLUMES.elevator_open_door, 30, 30); -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {


		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
			return volume_test_player_lookat(VOLUMES.elevator_open_door, SPARTANS.locke, 30, 30); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke,
			text = "Elevator door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
--           IF BUCK

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.elevator_open_door, SPARTANS.buck, 30, 30); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Elevator door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			 AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
--           IF VALE

		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
			return volume_test_player_lookat(VOLUMES.elevator_open_door, SPARTANS.vale, 30, 30); -- GAMMA_TRANSITION: If vale WITNESSES
			end,

				
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Elevator door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
--           IF TANAKA

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
			return volume_test_player_lookat(VOLUMES.elevator_open_door, SPARTANS.tanaka, 30, 30); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Elevator door's opening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03200.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};


function nar_outpost_chatter_controller()	
	--eateThread(nar_outpost_chatter_stop);
	--sleep_s(30);
	--if b_elevator_entered == false then
	--	NarrativeQueue.QueueConversation(W1Evacuation_Chatter_line_02);
--	end

end
global W1Evacuation_Chatter_line_02 = {
	name = "W1Evacuation_Chatter_line_02",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_elevator_entered == false;
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Everyone wears masks here. I thought the air was breathable?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02600.sound'),
		},
		[2] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_elevator_entered == false;
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Is. Also full of glass particulate. Scratches at the lungs. Slow, ugly way to die.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03400.sound'),
		},
		[3] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_elevator_entered == false;
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "So keep the helmet on. Check.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02700.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_outpost_chatter_stop()
	SleepUntil([| volume_test_players(VOLUMES.nar_outpost_chatter_stop) ], 1);
	NarrativeQueue.EndConversationEarly(W1Evacuation_Chatter_line_02);

end

function nar_evac_eleavtor_enter()
	SleepUntil([| volume_test_players(VOLUMES.nar_evac_eleavtor_enter) ], 1);
	b_elevator_entered = true;
	
	NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__ON_ENTRY);
end



global W1Evacuation_Space_elevator__ON_ENTRY = {
	name = "W1Evacuation_Space_elevator__ON_ENTRY",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.vale) > 0 ; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Spartans. Your tenacity outstrips even my own.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00200.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "When did Cortana tell you about the Guardian?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02300.sound'),
		},
		[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "I-- [chuckle].",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00400.sound'),
					OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
--                          (beat)
--                     You're good.

		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "She gave me fair warning, true enough. I was allowed to help my people survive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00500.sound'),
					OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "A change is gonna come. For all of us. Human and Created alike.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00900.sound'),
						OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
--           To Locke and crew (if possible).

		[6] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
				
			text = "She's bringing a new dawn and I intend to be part of it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				CreateThread(nar_door_open_start);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00400.sound'), OBJECTS.lobby_pa_l);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00400b.sound'), OBJECTS.lobby_pa_r);
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
				
		},

		[7] = {
			sleepBefore = 3,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Ah. I see my time is up. Good luck to you, everyone. And goodbye.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_sloan_00700.sound'),
		},
},
	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__MINER_WITH_GUN);
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__ON_ENTRY2);
		CreateThread(nar_evac_elevator_base_nudge);
		CreateThread(nar_injured_miner_controller);
		CreateThread(nar_dead_miner_controller);
		
	end,

	localVariables = {},
};

global W1Evacuation_Space_elevator__ON_ENTRY2 = {
	name = "W1Evacuation_Space_elevator__ON_ENTRY2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
	return volume_test_players(VOLUMES.nar_lookat_elevator) ;
	
	end,
	sleepBefore = 0.5,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "They're between us and the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
									character = CHARACTER_SPARTANS.locke, 
			text = "Weapons free. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_01500.sound'),
		},

		[3] = {
		sleepBefore = 0.5,
			character = AI.elevator_lobby_guards.door_guard_left, -- GAMMA_CHARACTER: Minerfemale02
			text = "Come on! The Spartans are putting their asses on the line for us. Give 'em a hand.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale02_00700.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();

		
		
	end,

	localVariables = {},
};





function nar_door_open_start()
	sleep_s(1);
	nar_door_open = true;
end

function nar_dead_miner_controller()
	SleepUntil([| n_dead_miner_controller == 0], 10);		
	sleep_s(5);
	NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__THE_FALLEN);

	SleepUntil([| n_dead_miner_controller == 1], 10);		
	sleep_s(10);
	NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__THE_FALLEN2);
		
	SleepUntil([| n_dead_miner_controller == 2], 10);		
	sleep_s(10);
	
		--NarrativeQueue.QueueConversation(W1Evacuation_Elevator_base__MINER_GUN_HANDOFF);
		NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__DAZED_MINER);

end

global W1Evacuation_ELEVATOR_BASE__THE_FALLEN = {
	name = "W1Evacuation_ELEVATOR_BASE__THE_FALLEN",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.kneeling_mourn)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = AI.elevator_lobby.kneeling_mourn, -- GAMMA_CHARACTER: Minermale03
			text = "I--damn it--there's no words. Rest in peace, my friend.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale03_00300.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
		n_dead_miner_controller = 1;
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1Evacuation_ELEVATOR_BASE__THE_FALLEN2 = {
	name = "W1Evacuation_ELEVATOR_BASE__THE_FALLEN2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.kneeling_mourn)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.kneeling_mourn, -- GAMMA_CHARACTER: Minermale04
			text = "You always said you were sick of this place. Well, you're somewhere better now. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale04_00100.sound'),
		},
--                          (CHOKED UP)

		[2] = {
			character = AI.elevator_lobby.kneeling_mourn, -- GAMMA_CHARACTER: Minermale04
			text = "I'll make sure you rest somewhere nice.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale04_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		n_dead_miner_controller = 2;
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1Evacuation_ELEVATOR_BASE__MINER_WITH_GUN = {
	name = "W1Evacuation_ELEVATOR_BASE__MINER_WITH_GUN",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.lobby_guard)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.lobby_guard, -- GAMMA_CHARACTER: MINERFEMALE03
			text = "Someone handed me this gun. But I've never shot a gun before. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_MinerFemale03_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1Evacuation_ELEVATOR_BASE__MINER_ON_RAILING = {
	name = "W1Evacuation_ELEVATOR_BASE__MINER_ON_RAILING",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.seated_inj)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.seated_inj, -- GAMMA_CHARACTER: Minerfemale04
			text = "He's dead. He's dead and he's not coming back. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale04_00100.sound'),
		},
--                          (BEAT)

		[2] = {
			character = AI.elevator_lobby.seated_inj, -- GAMMA_CHARACTER: Minerfemale04
			text = "I couldn't stop them. [SOB]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale04_00200.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_injured_miner_controller()
	SleepUntil([| n_injured_miner_vo == 0], 10);		
	
	NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__INJURED_MINER_01);

	SleepUntil([| n_injured_miner_vo == 1], 10);		
	sleep_s(10);
	NarrativeQueue.QueueConversation(W1Evacuation_Elevator_base__injured_miners_02);
		
	SleepUntil([| n_injured_miner_vo == 2], 10);		
	sleep_s(10);
	
	NarrativeQueue.QueueConversation(W1Evacuation_ELEVATOR_BASE__MINER_ON_RAILING);	
	


end

global W1Evacuation_ELEVATOR_BASE__INJURED_MINER_01 = {
	name = "W1Evacuation_ELEVATOR_BASE__INJURED_MINER_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.inj_right)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.inj_right, -- GAMMA_CHARACTER: MINERMALE06
			text = "I'm not dead yet?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale06_00100.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.elevator_lobby.comforting_inj, -- GAMMA_CHARACTER: MinerFEmale05
			text = "Nope, still here. You don't get off that easy, Hodstetter. I owe you my life. So, you gotta give me time to repay the debt. OK?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale08_00200.sound'),
		},
		[3] = {
		sleepBefore = 0.5,
			character = AI.elevator_lobby.inj_right, -- GAMMA_CHARACTER: Minermale06
			text = "Do my best.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale06_00200.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		n_injured_miner_vo = 1;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};
global W1Evacuation_Elevator_base__injured_miners_02 = {
	name = "W1Evacuation_Elevator_base__injured_miners_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.inj_examined)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.medic_exam, -- GAMMA_CHARACTER: MinerFEmale06
			text = "Follow my finger with your eyes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale06_00100.sound'),
		},
		[2] = {
			character =  AI.elevator_lobby.inj_examined, -- GAMMA_CHARACTER: Minermale05
			text = "Why? What're you going to do if I have a concussion? We're stuck here. We're all going to die.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale05_00100.sound'),
		},
		[3] = {
			character = AI.elevator_lobby.medic_exam, -- GAMMA_CHARACTER: Minerfemale06
			text = "Just shut up and do like I tell you. Sloan'll get us help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale06_00200.sound'),
		},
		[4] = {
			character = AI.elevator_lobby.inj_examined, -- GAMMA_CHARACTER: Minermale05
			text = "Right...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale05_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		n_injured_miner_vo = 2;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1Evacuation_Elevator_base__injured_miners_03 = {
	name = "W1Evacuation_Elevator_base__injured_miners_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.injured_recline)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = AI.elevator_lobby.injured_recline, -- GAMMA_CHARACTER: Minerfemale07
			text = "Moan of pain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale07_00300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1Evacuation_ELEVATOR_BASE__DAZED_MINER = {
	name = "W1Evacuation_ELEVATOR_BASE__DAZED_MINER",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.standing_mourn)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby.standing_mourn, -- GAMMA_CHARACTER: MINERFEMALE07
			text = "Why did this happen? What did we do? I don't understand!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale07_00200.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1Evacuation_Elevator_base__MINER_GUN_HANDOFF = {
	name = "W1Evacuation_Elevator_base__MINER_GUN_HANDOFF",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.elevator_lobby) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.elevator_lobby.standing_mourn)) < 4 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.elevator_lobby_guards.handing_off_gun, -- GAMMA_CHARACTER: Minermale07
			text = "You know what to do with one of these?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale07_00100.sound'),
		},
		[2] = {
			character = AI.elevator_lobby_guards.gun_recieve, -- GAMMA_CHARACTER: Minermale02
			text = "Point the barrel toward the bad guys and pull the trigger?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale02_00700.sound'),
		},
		[3] = {
			character = AI.elevator_lobby_guards.handing_off_gun, -- GAMMA_CHARACTER: Minermale07
			text = "Good enough.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale07_00200.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1Evacuation_SPACE_ELEVATOR__NUDGE = {
	name = "W1Evacuation_SPACE_ELEVATOR__NUDGE",

	sleepBefore = 0.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Pelican's up top. Our elevator's waiting. Let's move.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_evac_elevator_base_nudge()
	sleep_s(60);
	if nar_evac_elevator_enter_combat == false then 
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__NUDGE);
	end
end

function nar_evac_elevator_base_enter_combat()
SleepUntil([| volume_test_players(VOLUMES.nar_evac_elevator_enter_combat) ], 1);
nar_evac_elevator_enter_combat = true;
	
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300b.sound'), OBJECTS.elevator_pa_r);
		sleep_s(5);
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator_COMBAT__CAN_T_START_ELEVATOR);
	
	
end

global W1Evacuation_Space_elevator_COMBAT__CAN_T_START_ELEVATOR = {
	name = "W1Evacuation_Space_elevator_COMBAT__CAN_T_START_ELEVATOR",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						character = CHARACTER_SPARTANS.locke, 
			text = "Tanaka. Override the security system.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04100.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Love to. Delicate work to do while getting shot at though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02900.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Let's clear the lady some work space, shall we?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03400.sound'),
		},

--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_evac_elevator_base_combat_nudge);
	end,

	localVariables = {},
};



function nar_evac_elevator_base_combat_nudge()
	sleep_s(90);
	if elevator_base_combat_complete == false and b_first_combat_nudge == false then 
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR_BOTTOM__CLEAR_ALL);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300b.sound'), OBJECTS.elevator_pa_r);
		b_first_combat_nudge = true;
	elseif elevator_base_combat_complete == false then 
		
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ELEVATORPA_00300b.sound'), OBJECTS.elevator_pa_r);
		
		CreateThread(nar_evac_elevator_base_combat_nudge);
	end
end

function dormant.evacuation_guardian_view_2()
	print("deprecated");
end

global W1Evacuation_SPACE_ELEVATOR_BOTTOM__CLEAR_ALL = {
	name = "W1Evacuation_SPACE_ELEVATOR_BOTTOM__CLEAR_ALL",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_base_combat_complete == false; -- GAMMA_TRANSITION: IF TANAKA
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Lockdown won't end until we clear the last of these prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_base_combat_complete == false; -- GAMMA_TRANSITION: IF TANAKA
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Lockdown won't end until we clear the last of these prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_base_combat_complete == false; -- GAMMA_TRANSITION: IF TANAKA
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vaLE
			text = "Lockdown won't end until we clear the last of these prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_03300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_base_combat_complete == false; -- GAMMA_TRANSITION: IF TANAKA
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Lockdown won't end until we clear the last of these prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};


function nar_evac_elevator_base_combat_complete()
	elevator_base_combat_complete = true;
	NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator_base__TANAKA_STARTS_ELEVATOR);
end
global W1Evacuation_Space_elevator_base__TANAKA_STARTS_ELEVATOR = {
	name = "W1Evacuation_Space_elevator_base__TANAKA_STARTS_ELEVATOR",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00800.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00800b.sound'), OBJECTS.elevator_pa_r);
	end,

	lines = {
		[1] = {
		sleepBefore = 1,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "Area's clear. Tanaka, how do we get the elevator moving?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03400.sound'),


		},
		[2] = {

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Find the control panel. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_00200.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
			[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_button_used == false; -- GAMMA_TRANSITION: If locke
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It must be here somewhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--CreateThread(nar_elevator_base_use_nudge);
	end,

	localVariables = {},
};

function nar_elevator_pinged()
	elevator_button_pinged = true;
end

function nar_elevator_base_use_nudge()
	sleep_s(30);
	if elevator_button_used == false and elevator_button_pinged == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator_base_start_the_elevator);
	end

end

global W1Evacuation_Space_elevator_base_start_the_elevator = {
	name = "W1Evacuation_Space_elevator_base_start_the_elevator",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_button_pinged == false and  b_collectible_used == false; -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Might be worth a scan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03900.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_elevator_start()
	elevator_button_used = true;
	NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator_base_elevator_used);
		NarrativeQueue.EndConversationEarly(W1Evacuation_Space_elevator_base_start_the_elevator);

end

global W1Evacuation_Space_elevator_base_elevator_used = {
	name = "W1Evacuation_Space_elevator_base_elevator_used",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_elevator_start, SPARTANS.locke); -- GAMMA_TRANSITION: If locke
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
							character = CHARACTER_SPARTANS.locke, 
			text = "Got it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03500.sound'),

			sleepAfter = 2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   IF VALE

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_elevator_start, SPARTANS.vale); -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Got it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01600.sound'),

			sleepAfter = 2,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_elevator_start, SPARTANS.buck); -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Got it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02300.sound'),

				sleepAfter = 2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_elevator_start, SPARTANS.tanaka); -- GAMMA_TRANSITION: If locke
			end,
		
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Got it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01200.sound'),

				sleepAfter = 2,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00200.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00200b.sound'), OBJECTS.elevator_pa_r);
		CreateThread(firstfloor_alarm_stop);
		NarrativeQueue.QueueConversation(W1Evacuation_Space_start_elevator_post);
	end,

	localVariables = {},
};


global W1Evacuation_Space_start_elevator_post = {
	name = "W1Evacuation_Space_start_elevator_post",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 4,
	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sloan said a change is coming. We know Cortana contacted him. Is she on the Guardian too? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04000.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,

		},
		[2] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Master Chief seemed to think so.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02600.sound'),
		},
		[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "So if she's there, then where are they going?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02800.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
									character = CHARACTER_SPARTANS.locke, 
			text = "We'll find out once we're to the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04400.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

		[5] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 2,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It makes sense that the Master Chief would disobey orders to find Cortana, but why the rest of Blue Team?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_04000.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The members of Blue Team grew up together in the Spartan-2 program. They've registered more operations than any other fireteam in the UNSC.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_05600.sound'),
		},
		[7] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "They're family. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_05200.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Exactly.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_05700.sound'),
		},
--           
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	NarrativeQueue.QueueConversation(W1Evacuation_Space_start_elevator_post_prom);
					--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_00900.sound'), OBJECTS.elevator_pa_l);
				--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_00900.sound'), OBJECTS.elevator_pa_r);

	end,

	localVariables = {},
};

global W1Evacuation_Space_start_elevator_post_prom = {
	name = "W1Evacuation_Space_start_elevator_post_prom",
		CanStart = function (thisConvo, queue)
		return ai_living_count (AI.sg_fore_wave_01) >= 1; -- GAMMA_CONDITION
	end,
	sleepBefore = 2,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	
	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
				[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Incoming Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03700.sound'),	
		
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
					--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_00900.sound'), OBJECTS.elevator_pa_l);
				--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_00900.sound'), OBJECTS.elevator_pa_r);
		CreateThread(w1_evac_elevator_stop);
	end,

	localVariables = {},
};


-- =================================================================================================
--
--					ELEVATOR RIDE
--
-- Covers content in the elevator ride.
--
-- =================================================================================================




function w1_evac_elevator_stop()
SleepUntil([|elevator_combat == true], 1);
	if elevator_stop == 3 then
		
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01200.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01200b.sound'), OBJECTS.elevator_pa_r);
		CreateThread(kill_all_nudge_ride);
		elevator_stop = 4;
		sleep_s(3);
	elseif elevator_stop == 2 then
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01100.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01100b.sound'), OBJECTS.elevator_pa_r);
		CreateThread(kill_all_nudge_ride);
		elevator_stop = 3;
		sleep_s(3);
	elseif elevator_stop == 1 then
		--NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_1);
		sleep_s(2);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01000.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_ElevatorPA_01000b.sound'), OBJECTS.elevator_pa_r);
		CreateThread(kill_all_nudge_ride);
		elevator_stop = 2;
		sleep_s(3);
	end
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00600.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00600b.sound'), OBJECTS.elevator_pa_r);
	CreateThread(w1_evac_elevator_start);
	if first_combat_start == false then
		CreateThread(w1_evac_elevator_combat_nudge);
		first_combat_start = true;
	end
end


function w1_evac_elevator_combat_nudge()
SleepUntil([|elevator_combat == true], 1);
	sleep_s(60);
	if elevator_combat_complete == false and elevator_combat == true then
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00700.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00700b.sound'), OBJECTS.elevator_pa_r);
		
		CreateThread(w1_evac_elevator_combat_nudge);
	elseif elevator_combat_complete == false and elevator_combat == false then
		CreateThread(w1_evac_elevator_combat_nudge);
	end

end

function w1_evac_elevator_start()
SleepUntil([|elevator_combat == false], 1);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00800.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_00800b.sound'), OBJECTS.elevator_pa_r);
	CreateThread(w1_evac_elevator_stop);
	KillScript(kill_all_nudge_ride);
	if elevator_stop == 1 then
	sleep_s(7);
				NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_3);
				KillScript(kill_all_nudge_ride);
	elseif elevator_stop == 2 then
	sleep_s(2);
	NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_4);
	KillScript(kill_all_nudge_ride);
	elseif elevator_stop == 3 then
	sleep_s(5);
	NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2);		
	KillScript(kill_all_nudge_ride);
		
	end
end
global W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_3 = {
	name = "W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_3",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			text = "We're in orbit. Safe and away.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00400.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 3,
			
			text = "Hang on everyone. Gonna make a run for it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00500.sound'),
		},
		[3] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
		sleepBefore = 3,
			
			text = "Control, we're out numbered! \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00600.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function kill_all_nudge_ride()
	sleep_s(120);
	if elevator_combat  == true then
	SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W1Evacuation_clear_all_wave);
	end
end

global W1Evacuation_clear_all_wave = {
	name = "W1Evacuation_clear_all_wave",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_combat == true and b_collectible_used == false and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Eliminate the last of the Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_LOCKE_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   IF VALE

		[2] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_combat == true and b_collectible_used == false and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Eliminate the last of the Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_03900.sound'),
					AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_combat == true and b_collectible_used == false and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Eliminate the last of the Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return elevator_combat == true and b_collectible_used == false and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "\r\nEliminate the last of the Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_4 = {
	name = "W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_4",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 6,
	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "New Alexandria all over again. We Claw our way out here, scratch a life out of the dirt... for what? So we can run? Leave it all behind? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "There's a difference between running and living to fight another day.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03900.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Tanaka's right. And besides, humanity's at our best when we're making something out of nothing. We're better at hardship than prosperity. When times are too good, we get anxious, like rats in a cage.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_05300.sound'),
		},
				[4] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're tenacious. We'll rebuild as many times as we have to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_05400.sound'),
		},
	
			
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_1);
	end,

	localVariables = {},
};

global W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_1 = {
	name = "W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_1",

		CanStart = function (thisConvo, queue) -- BOOLEAN
	return elevator_combat == true;
	
	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 4,
	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "More Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2 = {
	name = "W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
							
			
			text = "Hello? Can anyone hear me? I'm at Meridian Station. Everyone's dead. Governor Sloan isn't here-- I-- I--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minerfemale01_00800.sound'),
						OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Sloan just up and abandoned his people... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_03800.sound'),
		},
		[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If Cortana's really behind that Guardian moving, she did more damage here than him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04300.sound'),
		},
--           Prometheans begin to appear.
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We'll find the truth about what happened here. And we'll make certain that those who should answer for it do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04900.sound'),
		},
--                                                   CUT TO:

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2b);
	end,

	localVariables = {},
};
global W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2b = {
	name = "W1Evacuation_SPACE_ELEVATOR__PROMETHEAN_ATTACK_2b",

			CanStart = function (thisConvo, queue) -- BOOLEAN
	return elevator_combat == true;
	
	end,

	sleepBefore = 2,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Watch out! More Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_03200.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};
function nar_robards_call()
	elevator_combat_complete = true;
	
	CreateThread(guardian_whalesong_elevator);	
	sleep_s(4);
	NarrativeQueue.QueueConversation(Evacuation_Distress_call);
	sleep_s(13.75)
	NarrativeQueue.QueueConversation(Evacuation_Distress_call2);
end

global Evacuation_Distress_call = {
	name = "Evacuation_Distress_call",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's that Guardian song again!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_00600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[2] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "But it's different, right? I'm not imagining that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER

				return 4;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Yeah. Definitely different.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_01600.sound'), OBJECTS.elevator_pa_l);	
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_01600b.sound'), OBJECTS.elevator_pa_r);		
	hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global Evacuation_Distress_call2 = {
	name = "Evacuation_Distress_call2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,		
			text = "Transport three to group. Heads up. That thing's starting to move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			hud_hide_radio_transmission_hud();
			SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w1evacuation_spaceelevator_guardiansweetener\018_vin_campaign_w1evacuation_spaceelevator_guardiansweetener.sound'), nil, 1)
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,	
				
		},
		[2] = {
				sleepBefore = 4,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			
			text = "I don't know what's going on-- Wait, it just stopped. OH HELL! GET OUT OF --",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_minermale01_00400.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_00700.sound'),
		
				
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		start_elevator_event = true;
	end,

	localVariables = {},
};


function dormant.evacuation_guardian_emp()
--	NarrativeQueue.QueueConversation(Evacuation_take_cover);
	
end

global Evacuation_take_cover = {
	name = "Evacuation_take_cover",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_00700.sound'),
		
				
		},
--           Ships get knocked from the air like toys. The pulse hits the
--           space elevator, causing it to fall. We flash white.
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function dormant.evacuation_osiris_come_to()
		
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02000.sound'), OBJECTS.elevator_pa_l);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_elevatorpa_02000b.sound'), OBJECTS.elevator_pa_r);
	sleep_s(5);
	NarrativeQueue.QueueConversation(W1Evacuation_MERIDIAN__SPACE_ELEVATOR_WRECKAGE__POST_EMP);

end

global W1Evacuation_MERIDIAN__SPACE_ELEVATOR_WRECKAGE__POST_EMP = {
	name = "W1Evacuation_MERIDIAN__SPACE_ELEVATOR_WRECKAGE__POST_EMP",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "Everyone all right?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_01200.sound'),

		
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "What happened?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_00700.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Elevator e-brake stopped a total collapse. But she won't hold out long. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_00900.sound'),
		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Do you figure the structure is still secure enough to climb?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_02900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "If it's gonna fall, won't be because Spartans are using it as a jungle gym.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01000.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  b_exited_elevator == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
									character = CHARACTER_SPARTANS.locke, 
			text = "Run a scan. Find an exit.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_03200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_elevator_top_nudge);
		--adding this so that it plays at the end of the lines gmu -- osr-149591
		TutorialShowAll("training_ping", 7);
	end,

	localVariables = {},
};


function nar_elevator_top_nudge()	
	
	sleep_s(30);
	if b_exited_elevator == false then
	SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W1Evacuation_chatter_04);
	end
		sleep_s(60);
	if b_exited_elevator == false then
	SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W1Evacuation_track_wreckage_nudge);
	end
end
global W1Evacuation_chatter_04= {
	name = "W1Evacuation_chatter_04",
	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0  and b_collectible_used ~= true; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Where do you think that Guardian's going?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_04000.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "What makes you think it's going anywhere?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_04400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gearing up for takeoff, by the look of it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_04100.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Wherever it's going, the Master Chief is going with it, which means we need to get to him before that happens.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04600.sound'),
		},
--           
-- 
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1Evacuation_track_wreckage_nudge = {
	name = "W1Evacuation_track_wreckage_nudge",

	sleepBefore = 0.5,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "See those red lights? Pretty sure they're hatches to the maintenance scaffolding.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01100.sound'),
		},
		[2] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
									character = CHARACTER_SPARTANS.locke, 
			text = "Let's have a look.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_01400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_tracking_exit()
	b_exited_elevator = true;
	--NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR_WRECKAGE__TRACKING);
	
	NarrativeQueue.InterruptConversation(W1Evacuation_chatter_04);
	
end

global W1Evacuation_SPACE_ELEVATOR_WRECKAGE__TRACKING = {
	name = "W1Evacuation_SPACE_ELEVATOR_WRECKAGE__TRACKING",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_objective_elevator_exit, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "I found an exit.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_objective_elevator_exit, SPARTANS.tanaka); -- GAMMA_TRANSITION: IF LOCKE
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found an exit.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_objective_elevator_exit, SPARTANS.buck); -- GAMMA_TRANSITION: IF LOCKE
			end,

			OOnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Think there's an exit here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_objective_elevator_exit, SPARTANS.vale); -- GAMMA_TRANSITION: IF LOCKE
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I've found a way out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};



-- =================================================================================================
--
--					SCAFFOLD
--
-- Covers content in the scaffold.
--
-- =================================================================================================
global W1Evacuation_SPACE_ELEVATOR_SCAFFOLD_REACHED = {
	name = "W1Evacuation_SPACE_ELEVATOR_SCAFFOLD_REACHED",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_evac_scaffold) or volume_test_players(VOLUMES.nar_evac_scaffold2); -- GAMMA_CONDITION
	end,
			canStartOnce = true,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_evac_scaffold, SPARTANS.buck) == true or volume_test_object(VOLUMES.nar_evac_scaffold2, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If buck sees first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "There's the Guardian. How much further to the pelican?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_evac_scaffold, SPARTANS.locke) == true or volume_test_object(VOLUMES.nar_evac_scaffold2, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If locke sees first
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "There's the Guardian. Keep moving towards the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_evac_scaffold, SPARTANS.tanaka) == true or volume_test_object(VOLUMES.nar_evac_scaffold2, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If tanaka
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Guardian. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_evac_scaffold, SPARTANS.vale) == true or volume_test_object(VOLUMES.nar_evac_scaffold2, SPARTANS.vale) == true; -- GAMMA_TRANSITION: If vale sees first
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's the Guardian. Just have to get to the pelican now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           After:

		[5] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Pelican's another super rung up from here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01300.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "How far is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_00900.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "More than you want it to be. Not as far as it could be. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
			CreateThread(nar_evac_scaffold_nudge);
	CreateThread(nar_guardian_climb_chatter);
	end,

	localVariables = {},
};



global W1Evacuation_SPACE_ELEVATOR_PHAETONS = {
	name = "W1Evacuation_SPACE_ELEVATOR_PHAETONS",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.evacuation_aircraft_return); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.evacuation_aircraft_return, SPARTANS.locke); -- GAMMA_TRANSITION: If locke
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "Phaetons targeting our position. Stay mobile!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.evacuation_aircraft_return, SPARTANS.buck); -- GAMMA_TRANSITION: If buck
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Phaetons off the port bow! Watch your heads!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.evacuation_aircraft_return, SPARTANS.vale); -- GAMMA_TRANSITION: If vale
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Phaetons have us sighted! Be ready to dodge their fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.evacuation_aircraft_return, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Watch those Phaetons! Be ready to evade!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};




global W1Evacuation_SPACE_ELEVATOR__PULSE_TWO = {
	name = "W1Evacuation_SPACE_ELEVATOR__PULSE_TWO",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_guardian_small_pulse); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
			--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_beamblastlight_2d.sound'), nil, 1);
		
	end,

	lines = {
		[1] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Not sure this scaffold can take any more shock waves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03300.sound'),
			
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},
	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	CreateThread(audio_scaffolding_sweetener);
		--[[]]
	end,

	localVariables = {},
};

function nar_evac_scaffold_nudge()

	sleep_s(120);
	if scaffold_top_reached == false then
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__Nudge_1);
	end
	sleep_s(120);
	if scaffold_top_reached == false then
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__Nudge_2);
	end
	sleep_s(120);

	if scaffold_top_reached == false then
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__Nudge_3);
		
	end
	sleep_s(120);

	if scaffold_top_reached == false then
		NarrativeQueue.QueueConversation(W1Evacuation_Space_elevator__Nudge_4);
		
	end

end
global W1Evacuation_Space_elevator__Nudge_1 = {
	name = "W1Evacuation_Space_elevator__Nudge_1",
	sleepBefore = 0.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return scaffold_top_reached == false; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The pelican's still above us. Keep climbing. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1Evacuation_Space_elevator__Nudge_2 = {
	name = "W1Evacuation_Space_elevator__Nudge_2",

	sleepBefore = 0.5,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return scaffold_top_reached == false; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gotta keep movin up. Guardian ain't waiting for us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02700.sound'),

		},
	
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1Evacuation_Space_elevator__Nudge_3 = {
	name = "W1Evacuation_Space_elevator__Nudge_3",

	sleepBefore = 0.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return scaffold_top_reached == false; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We need to keep moving to that Guardian. Don't fancy this thing falling out from under us.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_03100.sound'),

	
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1Evacuation_Space_elevator__Nudge_4 = {
	name = "W1Evacuation_Space_elevator__Nudge_4",

	sleepBefore = 0.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return scaffold_top_reached == false; -- GAMMA_TRANSITION: If vale
			end,
		
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "Keep climbing, Osiris. We don't want to be caught here when that Guardian releases another shockwave.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_04000.sound'),

		},
	
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_pulse_three()

	SleepUntil( [| volume_test_players(VOLUMES.nar_guardian_pulse) ],1);
	CreateThread(guardian_whalesong_scaffold);
	
	RunClientScript ("GuardianPulseEffect");
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_blast_scaffoldingtop.sound'), nil, 1)
	sleep_s (2.25);
	rumble_shake_medium(2);
	CreateThread(audio_metal_rumble);
end

global W1Evacuation_SPACE_ELEVATOR__PULSE_THREE = {
	name = "W1Evacuation_SPACE_ELEVATOR__PULSE_THREE",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_guardian_pulse); -- GAMMA_CONDITION
	end,
			canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_beamblastintense_2d.sound'), nil, 1);
		
		scaffold_climb_complete = true;
	end,

	lines = {
		[1] = {
			sleepBefore = 1.5,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Think this thing might fall after all.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02000.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
									character = CHARACTER_SPARTANS.locke, 
			text = "To hell with it, we're risking auto-pilot. Calling in the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(auto_pilot_transmission);
	end,

	localVariables = {},
};


function auto_pilot_transmission()

				hud_show_radio_transmission_hud("pelican_transmission_name1");
				hud_set_radio_transmission_team_string_id("unscteam_transmission_name");
				hud_set_radio_transmission_portrait_index(12);
				sleep_s(3);
				hud_show_radio_transmission_hud("pelican_transmission_name2");
				hud_set_radio_transmission_team_string_id("unscteam_transmission_name");
				hud_set_radio_transmission_portrait_index(12);
				sleep_s(3);
				hud_hide_radio_transmission_hud();
end

function nar_guardian_climb_chatter()
sleep_s(600);
if scaffold_climb_complete == false then
SleepUntil( [| b_collectible_used == false and scaffold_top_reached == false], 1);
	NarrativeQueue.QueueConversation(W1Evacuation_SPACE_ELEVATOR_buck_chatter);
end
end

global W1Evacuation_SPACE_ELEVATOR_buck_chatter = {
	name = "W1Evacuation_SPACE_ELEVATOR_buck_chatter",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false and scaffold_top_reached == false; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "This might be hard to believe, seeing as how I'm a model of stoicism and courage today, but when I was a kid, I was afraid of heights.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

-- =================================================================================================
--
--					CONTROL
--
-- Covers content in the control section.
--
-- =================================================================================================

global W1Evacuation_nar_enter_super_rung = {
	name = "W1Evacuation_nar_enter_super_rung",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_enter_super_rung); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_enter_super_rung, SPARTANS.vale); -- GAMMA_TRANSITION: If chief
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's the pelican! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			CreateThread(start_guardian_song);
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_enter_super_rung, SPARTANS.locke); -- GAMMA_TRANSITION: If chief
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "The pelican's just outside!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			CreateThread(start_guardian_song);
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_enter_super_rung, SPARTANS.tanaka); -- GAMMA_TRANSITION: If chief
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Pelican's waiting for us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_tanaka_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			CreateThread(start_guardian_song);
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_enter_super_rung, SPARTANS.buck); -- GAMMA_TRANSITION: If chief
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Pelican's just outside!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			CreateThread(start_guardian_song);
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[5] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
									character = CHARACTER_SPARTANS.locke, 
			text = "Move it, people!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02800.sound'),
		},

		[6] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 2,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Shock waves are getting closer together.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_VO_SCR_W1Evacuation_UN_Tanaka_01600.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Almost like a countdown.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_vale_02400.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
							If = function (thisLine, thisConvo, queue, lineNumber)
				return b_cinematic_evac_start == false; -- GAMMA_TRANSITION: If chief
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "What happens when it gets to zero?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_buck_01600.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[9] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_cinematic_evac_start == false; -- GAMMA_TRANSITION: If chief
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.25,
									character = CHARACTER_SPARTANS.locke, 
			text = "I don't want to find out! Get to the pelican!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_enter_super_rung()
	SleepUntil([| volume_test_players(VOLUMES.nar_enter_super_rung) ], 1);
	CreateThread(guardian_whalesong_scaffold2);
	scaffold_top_reached = true;
	NarrativeQueue.QueueConversation(W1Evacuation_nar_enter_super_rung);
end
function start_guardian_song()
	CreateThread(guardian_whalesong_pelicanend);
	
end


function dormant.evacuation_guardian_launch_start()
print("deprecated");
end



global W1Evacuation_nar_enter_ending = {
	name = "W1Evacuation_nar_enter_ending",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_enter_ending); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							If = function (thisLine, thisConvo, queue, lineNumber)
				return b_cinematic_evac_start == false; -- GAMMA_TRANSITION: If chief
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
									character = CHARACTER_SPARTANS.locke, 
			text = "Everyone on board! Now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1evacuation\001_vo_scr_w1evacuation_un_locke_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};




-- =================================================================================================
--
--					CHATTER
--
-- Team secondary chatter.
--
-- =================================================================================================


-- =================================================================================================

function test_guardian_song()
	RunClientScript("guardian_test");
end

function test_guardian_song2()
	RunClientScript("guardian_test2");
end

function guardian_whalesong_beginning():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_start.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_chase():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_preelevator.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_elevator():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_elevator.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_scaffold():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_scaffolding.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_scaffold2():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_scaffoldingshort.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_pelicanend():void
--	Play Whale song
	print("Play Whale song");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_evacuation_end.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_close():void
--	Play Whale song
	print("Play Whale song close A - Server");
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a_tail.sound'), nil, 1);
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_a_left.sound'), OBJECTS.guardian_bird, "audio_left", 1);
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_a_right.sound'), OBJECTS.guardian_bird, "audio_right", 1);
	
end



function guardian_whalesong_distant():void
--	Play Whale song
	print("Play Whale song distant A - Server");
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a_distant.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	
end

function guardian_whalesong_close_b():void
--	Play Whale song
	print("Play Whale song close B - Server");
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_b.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
	--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_b.sound'), nil, 1);
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_b_left.sound'), OBJECTS.guardian_bird, "audio_left", 1);
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_b_right.sound'), OBJECTS.guardian_bird, "audio_right", 1);
end

function guardian_whalesong_distant_b():void
--	Play Whale song
	print("Play Whale song distant B - Server");
	--sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_distant_b.sound'), OBJECTS.guardian_bird, "fx_head_front", 1);
end

-------------------


function sound_impulse_start_marker_server(soundTag:tag, theObject:object, theMarker:string, theScale:number):void
print('PASS 3');
	RunClientScript("sound_impulse_start_marker_client", soundTag, theObject, theMarker, theScale);

end


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT


function remoteClient.sound_impulse_start_marker_client(soundTag:tag, theObject:object, theMarker:string, theScale:number)

--	print("Play Whale song - Client");
	sound_impulse_start_marker(soundTag, theObject, theMarker, theScale);
end


function sound_impulse_start_client_narr(soundTag:tag, theObject:object, theScale:number)
print('PASS 5');

	sound_impulse_start(soundTag, theObject, theScale);
end

function remoteClient.guardian_test()
				--sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a_distant.sound'), OBJECTS.guardian_bird, 1)

end

function remoteClient.guardian_test2()
	--sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a.sound'), OBJECTS.guardian_bird, 1);
	--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesong_a_tail.sound'), nil, 1);
	--sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_a_left.sound'), OBJECTS.guardian_bird,  1);
	--sound_impulse_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_guardian_whalesongtail_a_right.sound'), OBJECTS.guardian_bird, 1);
	
end