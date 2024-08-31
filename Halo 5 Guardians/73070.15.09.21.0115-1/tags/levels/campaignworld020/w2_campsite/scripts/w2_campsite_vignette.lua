--## SERVER


-- *** World 2 Hub Vignette ***
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                               
-- *** GLOBALS ***
-- =================================================================================================

global b_medic_tent_wake:boolean=false;
global b_arbiter_base_wake:boolean=false;  -- this one should be delete-able during clean-up after removing old compositions
global b_arbiter_interrupt_start:boolean=false;
global b_arbiter_interrupt_end:boolean=false;
global b_arbiter_volume:boolean=true;
global b_phantom_base_wake:boolean=false;
global b_grunt_sit_wake:boolean=false;
global b_halsey_wake:boolean=false;
--global b_bigdoor_wake:boolean=false;
-- global b_wraiths_wake:boolean=false;
global b_livingfallen_wake:boolean=false;

global b_patrols_a_active:boolean=false;
global b_vale_joke_wake:boolean=false;
global b_palmer_wake:boolean=false;
global b_patrol_grunt_01_active:boolean=false;
global b_banshee_mechanic_wake:boolean=false;


global b_patrols_b_active:boolean=false;
global b_medics_sync:boolean=false;
global b_phone_volume:boolean=false;

-- Globals for Tanaka Banshee fix
global dc_tanaka_bool:boolean=false;
global g_ics_player:object = nil;
global comp_covhub_tanaka_banshee = nil;

global int_phone_moving:number=1;  -- 1 = at Start (Head Mechanic), 2 = Moving, 3 = at End (Banshee Mechanic)
global int_patrols_a:number=nil;
global int_phantom_goto:number=1;

global int_arbiter_goto:number=1;
global int_wraiths_goto:number=1;
--global int_arbiter_scene:number=1;
global int_medics_goto:number=1;

-- HUB/SPOKE COURIER GLOBALS
global b_cour_hub_talk:boolean=false;
global int_cour_wraith:number=0;
global int_cour_lf:number=0;

global nar_camp_chatter_off_vo:boolean=false;
global b_camp_chatter_1_played:boolean=false;
global b_camp_chatter_2_played:boolean=false;
global b_camp_chatter_3_played:boolean=false;
global b_camp_chatter_4_played:boolean=false;
global n_halsey_approach_before:number=0;
global n_halsey_approach_after:number=0;
global b_campsite_idle_chatter_on:boolean=false;
global b_camp_chatter_5_played:boolean=false;
global b_halsey_scene_played:boolean=false;
global b_arbiter_scene_played:boolean=false;

global n_secretive_elites:number=0;

function test_couriers_queue()
	-- test for courier implementation

	-- start Courier show
	composer_play_show("comp_couriers");

	-- Initial Narrative Queues
	NarrativeQueue.Initialize();
	StartAllCourierRoutes();

	-- Initialize VO Banks
	--guardVOBank = NarrativeLoopBank.Create( guardbankData );

	-- turn off Temp Text
	NarrativeQueue.instance.showBlurbs = false;
end



-- =================================================================================================================================================       
--.___  ___.      ___       __  .__   __.     _______  __  .______          _______.___________.   ____    ____  __       _______. __  .___________.
--|   \/   |     /   \     |  | |  \ |  |    |   ____||  | |   _  \        /       |           |   \   \  /   / |  |     /       ||  | |           |
--|  \  /  |    /  ^  \    |  | |   \|  |    |  |__   |  | |  |_)  |      |   (----`---|  |----`    \   \/   /  |  |    |   (----`|  | `---|  |----`
--|  |\/|  |   /  /_\  \   |  | |  . `  |    |   __|  |  | |      /        \   \       |  |          \      /   |  |     \   \    |  |     |  |     
--|  |  |  |  /  _____  \  |  | |  |\   |    |  |     |  | |  |\  \----.----)   |      |  |           \    /    |  | .----)   |   |  |     |  |     
--|__|  |__| /__/     \__\ |__| |__| \__|    |__|     |__| | _| `._____|_______/       |__|            \__/     |__| |_______/    |__|     |__|     
                                                                                                                                                  
                                                               
-- *** MAIN FIRST VISIT***

function testvo()
	print ("testing vo");
--	local guy = AI.sq_wraith.sp_mechanic_01;
--	ai_place (guy);
	VignetteStartProximity (WraithVignetteVO);
end

--EXAMPLE VO TABLE
--global WraithVignetteVO:table =
--	{
--		convo = wraith_interact_vo,
--		vobank = WraithVOBank
--	};

--GLOBAL PROXIMITY SCRIPTING

--function StartVignetteProximity (guard:object, loopBank:table, convo:table, show:string)
--function StartVignetteProximity (guard:object, votable, show:string)
--function StartVignetteProximity (votable)
--	print ("starting vo proximity on ", votable.name);
--	local trigger = votable.volume;
--	local state:table = {near = false};
--	if votable.show then
--		composer_play_show(votable.show, state);
--	end
--	--votable.convo.localVariables.buttonpusher=SPARTANS.locke
--	--print (guard);
--
--	repeat
--		--far off VO here
--		--print ("playing far off VO");
--		--NarrativeLoopBank.PlayNext( votable.vobank ,guard);
--		if votable.vobank then
--			NarrativeLoopBank.PlayNext( votable.vobank);
--				--SleepUntil([| not votable.vobank.currentlyPlaying ], 15);
--		else
--			print ("no vo bank for ", votable.name);
--		end
--		-- if above is done
--		--print ("done with random vo");
--		-- if we are close enough then
--		if votable.convo then
--			repeat
--				if (PlayersNearVignette(trigger)) then
--					print ("playing convo");
--					print ("vip is ", votable.vip);
--					--local vip = votable.vip();
--					votable.convo.localVariables.myState = state;
--					if votable.vip then
--						votable.convo.localVariables.speaker = VIPinVolume(trigger, votable.vip);
--					end
--					
--					if votable.vobank then
--						NarrativeQueue.EndConversationEarly(votable.vobank.conversation);
--						SleepUntil([| not NarrativeQueue.HasConversationFinished(votable.vobank.conversation) ], 1);
--						--a buffer before the conversation starts so the VO lines aren't back to back
--						sleep_s (1);
--					end
--					
--					NarrativeQueue.QueueConversation(votable.convo);
--					state.near = true;
--					
--					--sleeping to make sure the conversation is queued
--					Sleep (2);
--					
--					SleepUntil([| not PlayersNearVignette(trigger) or NarrativeQueue.HasConversationFinished(votable.convo) ], seconds_to_frames (0.25));
--					print ("currently playing is ", NarrativeQueue.HasConversationFinished(votable.convo));
--					if not PlayersNearVignette(trigger) then
--						
--						if not NarrativeQueue.HasConversationFinished(votable.convo) then
--							NarrativeQueue.EndConversationEarly(votable.convo);
--						end
--					end
--					SleepUntil([| not NarrativeQueue.HasConversationFinished(votable.convo) ], 1);
--					state.near = false;
--				else
--					print ("not near volume ", trigger);
--					
--					--sleep_s(random_range(2,5));
--				end
--				sleep_s (0.5);
--			until not votable.vobank.currentlyPlaying;
--		else
--			print ("no conversation bank for ", votable.name);
--			SleepUntil([| not votable.vobank.currentlyPlaying ], 15);
--			sleep_s (0.5);
--		end
--	until false;
--end

function VignetteStartProximity(votable:table)
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
					--kill vobank
					VignetteEndVOBank(votable);
					
					--change state of the vignette composition
					state.near = true;
					--get or pass in VIP here, perhaps passing into the function 
					
					--play convo
					VignettePlayConversation(votable);
						
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
			
			--change state of the vignette composition
			state.near = true;
			
			--play convo
			VignettePlayConversation(votable);
			state.near = false;
			sleep_s (0.5);
		until false;
	end
end


--this plays a vignette and starts a vobank, interrupts the vobank when the device control is activated and plays the convo
--then restarts playing the vo bank.  Repeats
function VignetteStartActivation (votable:table)
	local state:table = {near = false};
	local control = OBJECTS[votable.control];
	--turn on the control
	device_set_power (control, 1);
	--returns the activator and makes that the speaker in the convo
	RegisterInteractEvent(VignetteSetSpeaker, control, votable);
	
	if votable.show then
		composer_play_show(votable.show, state);
	end
	repeat
		--play the random vobank	
		NarrativeLoopBank.PlayNext(votable.vobank);
	
		SleepUntil([| device_get_power(control) == 0 or not votable.vobank.currentlyPlaying ], 1);
		--print ("player talked to NPC or random VO was played");
			--print (device_get_position(control));
		if device_get_power(control) == 0 then
			print ("player talked to NPC");
			--reset the control
			--device_set_power (control, 0);
			device_set_position_immediate (control, 0);
			
			--interrupt vobank
			VignetteKillVOBank(votable);
						
			--change state of the vignette composition
			state.near = true;
		
			--wait until there is a speaker set from the device control
			SleepUntil([| votable.convo.localVariables.speaker ~= nil ], 1);
			--play convo
			VignettePlayConversation(votable);
			
			state.near = false;
			--print (votable.convo.localVariables.complete);
			
			--I have to check here instead of doing this at the beginning of the loop because you could press the activate during the randomVO or the sleep
			if votable.convo.localVariables.complete ~= true then
				--turn on the control
				device_set_power (control, 1);
			end
		else
			sleep_s (0.1);
		end
	until votable.convo.localVariables.complete == true;
	print ("convo done");
end

--this plays a random selection from the VO bank endlessly
function VignetteLoopVOBank(votable:table)
	--print ("starting vig with convo ", votable.name);
	--repeat
		NarrativeLoopBank.PlayNext( votable.vobank);
		SleepUntil([| not votable.vobank.currentlyPlaying ], 15);
		sleep_s (0.5);
	--until false;
end

function VignetteEndVOBank(votable:table)
	if votable.vobank.currentlyPlaying then
		NarrativeQueue.EndConversationEarly(votable.vobank.conversation);
		SleepUntil([| NarrativeQueue.HasConversationFinished(votable.vobank.conversation) ], 1);
		--a buffer before the conversation starts so the VO lines aren't back to back
		sleep_s (0.5);
	end
end

function VignetteKillVOBank(votable:table)
	if votable.vobank.currentlyPlaying then
		NarrativeQueue.KillConversation(votable.vobank.conversation);
		--SleepUntil([| NarrativeQueue.HasConversationFinished(votable.vobank.conversation) ], 1);
		--a buffer before the conversation starts so the VO lines aren't back to back
		--sleep_s (0.5);
	end
end
	
function VignettePlayConversation(votable:table)
	--find the speaker

		--play the convo (pass in the VIP here)
		NarrativeQueue.QueueConversation(votable.convo);
	
		--sleeping to make sure the conversation is queued
		Sleep (2);
		
		--if speaker leaves kill the convo
		SleepUntil([| not PlayersNearVignette(votable.volume) or NarrativeQueue.HasConversationFinished(votable.convo) ], seconds_to_frames (0.25));
		--print ("currently playing is ", NarrativeQueue.HasConversationFinished(votable.convo));
	
		--end the conversation if not players are around
		if not NarrativeQueue.HasConversationFinished(votable.convo) then
			print ("player left volume before convo finished");
			NarrativeQueue.EndConversationEarly(votable.convo);
		end
	
		SleepUntil([| NarrativeQueue.HasConversationFinished(votable.convo) ], 1);
		--a buffer before the conversation starts so the VO lines aren't back to back
		sleep_s (0.5);
end

--change this to volume??
function PlayersNearVignette(trigger:volume):boolean
	--if objects_distance_to_point(players(), guard) < 1 and objects_distance_to_point(players(), guard) > 0 then
	if volume_test_players(trigger) then
		--print ("a player is in volume ", trigger);
		return true;
	end
end

--set the speaker from who talks to the NPC (activates the device control)
function VignetteSetSpeaker(device:object, activator:object, votable:table)
	print ("player activate speaker device control");
	--table.dprint (votable);
	votable.convo.localVariables.speaker = activator;
	print (device);
	device_set_power (device, 0);
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

--------EXAMPLE CONVO
--[======[
global bansheeMechanicConvo = {
	name = "bansheeMechanicConvo",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,
	
	OnStart = function (thisConvo, queue) -- VOID
		thisConvo.localVariables.timesPlayed = thisConvo.localVariables.timesPlayed + 1;
		thisConvo.localVariables.myState.near = true;
	end,

	-- DIALOG
	lines = {
		-- First exchange
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.timesPlayed == 1;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]TAG(''),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				return 6;
			end,	
		},
		[2] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]TAG(''),
		},
		[3] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
		[4] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
		[5] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
		-- Second exchange v v v
		[6] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.timesPlayed == 2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				return 9;
			end,	
		},
		[7] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
		[8] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
		-- Third exchange v v v
		[9] = {
			Else = true,

			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				return 0;
			end,	
		},
		[10] = {
			character = --[[]]0,
			text = --[[]]"",	
			tag = --[[]]0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		thisConvo.localVariables.myState.near = false;
	end,

	-- DATA
	localVariables = {
		timesPlayed = 0,
	},
};

--]======]


--INITIALIZED FUNCTIONS

function w2_hub_silence_squads()
	-- silences chatter for AIs
	ai_dialogue_enable(false);
end


function w2_hub_guns_down()
	-- Sets "Guns Down" mode
	print("w2_hub_guns_down...");
	--PlayersSetWeaponRelaxed(false);
	SleepUntil ([| PlayersAreAlive()], 1);
	
	--sleep_s (2);
	PlayersSetWeaponRelaxed(true);
	print ("players alive");
--	for _,spartan in ipairs (musketeers()) do
--		SleepUntil ([| player_valid (spartan)], 1);
--		print ("unit relaxed ", spartan);
--		unit_set_weapon_style (spartan, "relaxed", 1);
--	end
end


function w2_hub1st_datapad_colors()
	-- sets initial colors of datapads
	print ("not setting datapad colors");
end



-- ***VO TABLES***


global HalseyObjVO:table =
	{
		name = "Halsey obj VO",
		--VOPre = Halsey2ndPre,
		VONearby = HalseyNearby,
		VOObj = HalseyReportConversation,
		VOAfterObj = HalseyAfterConversation,
		--ending = b_TalkedToHalsey,
		--show = "comp_halsey",
		volume = VOLUMES.tv_halsey,
		dev = OBJECT_NAMES.devcon_ask_halsey,
		trackedObj = [|ai_get_object (AI.sq_receptacle.sp_halsey)],
	};



global PalmerObjVO:table =
	{
		name = "Palmer obj VO",
		VOPre = PalmerNotReadyVo,
		VONearby = PalmerReadyVo,
		VOObj = PalmerPelicanStart,
		--VOAfterObj = Palmer2ndAfterObj,
		--show = "comp_palmer",
		volume = VOLUMES.tv_palmer,
		dev = OBJECT_NAMES.devcon_goto_plateau,
		trackedObj = [|ai_get_object (AI.sq_palmer.sp_palmer)],
		--ending = b_TalkedToPalmer,
	};




-- =================================================================================================                                                       
-- *** Guards scripting ***
-- =================================================================================================


function w2hub_guards_spawn()
	
	ai_place (AI.sg_guards);
	local guys = ai_actors(AI.sg_guards);
	--table.dprint (guys);
	for _,val in ipairs (guys) do
		--print (val);
		CreateThread (w2hub_guards, val, "comp_guards");
	end
	
end

function w2hub_guards (guard:object, show:string)
	local narrativeGuardVOBank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
	local state:table = {comp_guard = guard};
	composer_play_show(show, state);
	--print (guard);
	
	--object_set_function_variable(guard, "look_speed_scale", 0.1);
	--cs_run_command_script(object_get_ai(guard),"cs_guard_lookat");
	repeat
		SleepUntil([| PlayersNearGuard(guard) ], 15);
		print ("near guard ", guard);
		state.bumped = true;
		NarrativeLoopBank.PlayNext( narrativeGuardVOBank, guard);
		
		print("guard bumped ", guard);
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearGuard(guard) ], 15);
		print ("not near guard ", guard);
	until false;
end


function PlayersNearGuard(guard:object):boolean
	if objects_distance_to_point(players(), guard) < 1 and objects_distance_to_point(players(), guard) > 0 then
--		print ("player is this close to guard", objects_distance_to_point(players(), guard));
		return true;
	end
end


function cs_guard_lookat()
	local local_x=math.random();
	--print ("look at script");

	cs_look_player(true);
	print("set look at for guard ");
	-- tricky math to get linear deviation
	--sleep_s(5 * local_x + 7 * (1 - local_x));
	SleepUntil ([| false ], seconds_to_frames (10));
	print("guard look at off");
end


-- AMBIENT
function w2_hub_elites_talk_secretively()
	VignetteStartProximity (ElitesSecretVO);
end


--function w2_hub_door_elite()
--	-- Elite studying the door from Plateau
--	--composer_play_show("comp_big_door");
--	VignetteStartProximity (DoorVignetteVO);
--end


function w2_elitegrunt()
	VignetteStartProximity (EliteGruntVO);
end

function w2_hub_arbiter()
	-- Arbiter's advisors discuss their suspicion that a traitor is in camp
	--composer_play_show("comp_arbiter_1st");

	VignetteStartProximity (ArbiterVignetteVO);
end

function w2_hub_courier()
	-- grunts patrolling
	StartAllCourierRoutes();
	int_patrols_a =composer_play_show("comp_couriers");
	
end


function w2_hub_medical_base()
	-- Medics working on injured Elites
	--composer_play_show("comp_medics_1st");

	VignetteStartProximity (MedicalVignetteVO);
end

function w2_story_grunt()
	-- Grunt and elite sitting at side of cliff
	VignetteStartProximity (StoryGruntVignetteVO);
end

function w2_hub_banshee_fix()
	-- Elites working on a broken banshee. Tanaka can help them
	--composer_play_show("co_banshee_fix");
--	VignetteStartProximity (BansheeVignetteVO);
	VignetteStartActivation (BansheeVignetteVO);
end


function w2hub_cliff_grunt()
	-- Grunt sitting up by Phantom
	--VignetteStartProximity (CliffGruntVignetteVO);
	VignetteStartActivation (CliffGruntVignetteVO);
end


function w2hub_weapon_stow()
	-- stow Grunt weapons during Pathing
	cs_stow(true);
end


function w2_hub_wraith_base()
	--damage_object (OBJECTS.ve_wraith_01, "default", 400);
	
	--removing the "bouncing" that happens after the phantom gets damaged
	vehicle_hover (OBJECTS.ve_wraith_01, true);
	RunClientScript ("WraithHover");
	
	VignetteStartProximity (WraithVignetteVO);
end


function w2_hub_back_ruins()
	-- Something about ancient Sangheili ruins
	--print("initializing Ruins convo test");
	VignetteStartProximity (RuinsVignetteVO);

end

-- helper

function w2hub_vig_banshees_loop()
	-- Banshees flying low over the camp
	repeat
	flock_vig_bansh_v1_01();
	sleep_s(75);
	flock_vig_bansh_v1_02();
	sleep_s(75);
	until false;
end


function test_w2hub_patrol_swap()
	-- switches out patrol a for patrol b
	b_patrols_b_active=true;
	composer_stop_show(int_patrols_a);
	print("Stopped Patrols A");
	sleep_s(0.5);
	composer_play_show("comp_patrols_b");
	print("Started Patrols B");
end


function Beetles_SpawnEvent_01()
	flock_start("fly_beetles_01");
	print("fly_beetles_01 started");
	sleep_s(10);
	flock_stop("fly_beetles_01");
	print("fly_beetles_01 stopped");
end


function Birds_SpawnEvent_01()
	--flock_start("fly_birds_01");
	print("flock birds 01 started");
	sleep_s(10);
	--flock_stop("fly_birds_01");
	print("flock birds 01 stopped");
end


function flock_vig_bansh_v1_01()
	flock_start("vig_bansh_v1_01");
	print("vig_bansh_v1_01 started");
	sleep_s(10);
	flock_stop("vig_bansh_v1_01");
	print("vig_bansh_v1_01 stopped");
end


function flock_vig_bansh_v1_02()
	flock_start("vig_bansh_v1_02");
	print("vig_bansh_v1_02 started");
	sleep_s(10);
	flock_stop("vig_bansh_v1_02");
	print("vig_bansh_v1_02 stopped");
end

--## CLIENT

--removing the "bouncing" that happens after the phantom gets damaged
function remoteClient.WraithHover()
	vehicle_hover (OBJECTS.ve_wraith_01, true);
end