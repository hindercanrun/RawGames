--## SERVER

----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
----  _    _            _     _   _____   _   _       _      ______ _       _                        
---- | |  | |          | |   | | / __  \ | | | |     | |     |  _  (_)     | |                       
---- | |  | | ___  _ __| | __| | `' / /' | |_| |_   _| |__   | | | |_  __ _| | ___   __ _ _   _  ___ 
---- | |/\| |/ _ \| '__| |/ _` |   / /   |  _  | | | | '_ \  | | | | |/ _` | |/ _ \ / _` | | | |/ _ \
---- \  /\  / (_) | |  | | (_| | ./ /___ | | | | |_| | |_) | | |/ /| | (_| | | (_) | (_| | |_| |  __/
----  \/  \/ \___/|_|  |_|\__,_| \_____/ \_| |_/\__,_|_.__/  |___/ |_|\__,_|_|\___/ \__, |\__,_|\___|
----                                                                                 __/ |           
----                                                                                |___/           
---- *** World 2 Hub Dialogue ***
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


-- =================================================================================================================================================       
---.___  ___.      ___       __  .__   __.     ___   .__   __.  _______     ____    ____  __       _______. __  .___________.
---|   \/   |     /   \     |  | |  \ |  |    |__ \  |  \ |  | |       \    \   \  /   / |  |     /       ||  | |           |
---|  \  /  |    /  ^  \    |  | |   \|  |       ) | |   \|  | |  .--.  |    \   \/   /  |  |    |   (----`|  | `---|  |----`
---|  |\/|  |   /  /_\  \   |  | |  . `  |      / /  |  . `  | |  |  |  |     \      /   |  |     \   \    |  |     |  |     
---|  |  |  |  /  _____  \  |  | |  |\   |     / /_  |  |\   | |  '--'  |      \    /    |  | .----)   |   |  |     |  |     
---|__|  |__| /__/     \__\ |__| |__| \__|    |____| |__| \__| |_______/        \__/     |__| |_______/    |__|     |__|     
                                                                                                                                                                                                                                                                           
                                                               
-- *** MAIN SECOND VISIT***
-- =================================================================================================================================================



function w2hub_weapon_stow()
	-- stow Grunt weapons during Pathing
	cs_stow(true);
end

function w2_hub_guns_down_2()
	
	sleep_s (1.5);
	-- Sets "Guns Down" mode
	print("w2_hub_guns_down");
	PlayersSetWeaponRelaxed(true);
	
--	for _,spartan in ipairs (musketeers()) do
--		SleepUntil ([| player_valid (spartan)], 1);
--		print ("unit relaxed ", spartan);
--		unit_set_weapon_style (spartan, "relaxed", 1);
--	end
end



--HALSEY
function w2hub_halsey_2nd()
	composer_play_show("comp_halsey_2nd");
end



function w2hub_assault_landingpad()
	-- Squad of Elites preparing for assault
	--composer_play_show("comp_assault_landingpad");

	-- another squad of Elites walking to where Arbiter is
	composer_play_show("comp_runfrom_landingpad", {});
	ai_place (AI.sq_elites_banshees);
end

function w2hub_lich()
	composer_play_show("vin_w2_campsite_lich_hover");
end

--EXAMPLE VO TABLE
--global WraithVignetteVO:table =
--	{
--		convo = wraith_interact_vo,
--		vobank = WraithVOBank
--	};

--GLOBAL PROXIMITY SCRIPTING


--function StartVignetteProximity (votable:table)
--	print ("starting vo proximity on ", votable.name);
--	local trigger = votable.volume;
--	local state:table = {near = false};
--	if votable.show then
--		composer_play_show(votable.show, state);
--	end
--	
--	repeat
--		--far off VO here
--		if votable.vobank then
--			if not PlayersNearVignette(trigger) then
--				state.involume = false;
--			end
--			NarrativeLoopBank.PlayNext( votable.vobank);
--		end
--
--		-- if we are close enough then
--		if not state.involume and votable.convo then
--			repeat
--				if (PlayersNearVignette(trigger)) then
--					print ("playing convo");
--
--					if votable.vip then
--						votable.convo.localVariables.speaker = VIPinVolume(trigger, votable.vip);
--					end
--					
--					if votable.vobank and votable.vobank.currentlyPlaying then
--						NarrativeQueue.EndConversationEarly(votable.vobank.conversation);
--						SleepUntil([| not NarrativeQueue.HasConversationFinished(votable.vobank.conversation) ], 1);
--						--a buffer before the conversation starts so the VO lines aren't back to back
--						sleep_s (1);
--					end
--					
--					--playing the conversation
--					NarrativeQueue.QueueConversation(votable.convo);
--					state.near = true;
--					
--					--sleeping to make sure the conversation is queued
--					Sleep (2);
--					
--					-- Check to see if we even run convo
--					if (not votable.convo.localVariables.DidIAlreadyPlayThisCharacter(votable.convo)) then
--						-- play it!
--					else
--						-- do the banks
--					end
--					
--					SleepUntil([| not PlayersNearVignette(trigger) or NarrativeQueue.HasConversationFinished(votable.convo) ], seconds_to_frames (0.25));
--					print ("currently playing is ", NarrativeQueue.HasConversationFinished(votable.convo));
--					if not PlayersNearVignette(trigger) then
--						state.involume = false;
----						if not NarrativeQueue.HasConversationFinished(votable.convo) then
----							NarrativeQueue.EndConversationEarly(votable.convo);
----						end
--					else
--						state.involume = true;
--					end
--					SleepUntil([| NarrativeQueue.HasConversationFinished(votable.convo) ], 1);
--					print ("convo has finished");
--					state.near = false;
--				--else
--					--print ("not near volume ", trigger);
--					state.temp = true;
--				end
--				sleep_s (0.5);
--			until not votable.vobank.currentlyPlaying and not state.temp;
--		else
--			--print ("no conversation bank for ", votable.name);
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
				--print ("checking player near vignette");
				playersInVolumeBeforeConvo = volume_return_players(votable.volume);
				
				--if nobody is around then reset playersInVolumeAfterConvo
				if #playersInVolumeBeforeConvo == 0 and #playersInVolumeAfterConvo ~= 0 then
					print ("resetting playersInVolumeAfterConvo");
					playersInVolumeAfterConvo = {};
				end

				if table.compare(playersInVolumeBeforeConvo, playersInVolumeAfterConvo) then
					--print ("players are still hanging around vignette");
				elseif #playersInVolumeBeforeConvo > 0 then
					print ("player near vignette");
					--kill vobank
					VignetteEndVOBank(votable);
					
					--play convo
					state.near = true;
					--get or pass in VIP here, perhaps passing into the function 
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
			--play convo
			VignettePlayConversation(votable);
			sleep_s (0.5);
		until false;
	end
end

function VignetteLoopVOBank(votable:table)
	--print ("playing vo bank ", votable.name);
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

function VignettePlayConversation(votable:table)
	--find the speaker

		--play the convo
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
function PlayersNearVignette(trigger:volume, playerList):boolean
	--if objects_distance_to_point(players(), guard) < 1 and objects_distance_to_point(players(), guard) > 0 then
	if trigger then
		if volume_test_players(trigger) then
			--print ("a player is in volume ", trigger);
			return true;
		end
	end
	--print ("returning false");
	return false
--	if trigger then
--		local playersInVolume = volume_return_players(trigger);
--		if playerList ~= playersInVolume then
--			
--			return true;
--		end
--	end
--	return false;
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


function w2_hub_datapad_colors()
	-- sets initial colors of datapads
	print ("not setting datapad colors");
end



-- =================================================================================================                                                       
-- *** Guards scripting ***
-- =================================================================================================


function w2hub_guards_spawn()
	
	ai_place (AI.sq_walkfrom_pad);
	local guys = ai_actors(AI.sq_walkfrom_pad);
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
	
	object_set_function_variable(guard, "look_speed_scale", 0.1);
	cs_run_command_script(object_get_ai(guard),"cs_guard_lookat");
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
	if objects_distance_to_point(players(), guard) < 1.5 and objects_distance_to_point(players(), guard) > 0 then
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

function w2hub_running_guards (state:table, guard:object)
	local bank = NarrativeLoopBank.CreateSharedBank( guardVOBank, CONVO_PRIORITY.MainCharacter, 0, 2);
		
	--object_set_function_variable(guard, "look_speed_scale", 0.1);
	repeat
		SleepUntil([| PlayersNearGuard(guard) ], 15);
		print ("near guard ", guard);
		state[guard].bumped = true;
		NarrativeLoopBank.PlayNext( bank, guard);
		--cs_run_command_script(object_get_ai(guard),"cs_guard_lookat");
		
		sleep_s (0.1);
		state[guard].bumped = false;
		--sleep for a few seconds so that it doesn't play again immediately
		sleep_s (3);
		SleepUntil([| not PlayersNearGuard(guard) ], 15);
		print ("not near guard ", guard);
	until false;
end

-- =================================================================================================                                                       
-- *** ambient vignette scripting ***
-- =================================================================================================

--function w2_hub_door_elite()
--	-- Elite studying the door from Plateau
--	VignetteStartProximity (DoorVignetteVO);
--end


function w2_hub_arbiter()
	-- Arbiter's 

	VignetteStartProximity (Arbiter2ndVignetteVO);

end


function w2_hub_medical_base()
	-- Medics working on injured Elites

	VignetteStartProximity (MedicalVignetteVO2nd);

end


function w2_phantom_pad_2()
	VignetteStartProximity (PhantomVignetteVO);
end



-- =================================================================================================                                                       
-- *** helper scripting ***
-- =================================================================================================


-- Flocks --


function w2hub_vig_banshees_loop()
	-- Banshees flying low over the camp
	repeat
	flock_vig_bansh_v1_01();
	sleep_s(75);
	flock_vig_bansh_v1_02();
	sleep_s(75);
	until false;
end




function Beetles_SpawnEvent_01()
	flock_start("fly_beetles_01");
	print("fly_beetles_01 started");
	sleep_s(10);
	flock_stop("fly_beetles_01");
	print("fly_beetles_01 stopped");
end


function Birds_SpawnEvent_01()
	flock_start("fly_birds_01");
	print("flock birds 01 started");
	sleep_s(10);
	flock_stop("fly_birds_01");
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
