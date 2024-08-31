-- DEBUG
--## SERVER

function startup.trials_cheats()
	print("cheats off");
	--cheat_infinite_ammo = true;
	--cheat_deathless_player = true;
	--cheat_omnipotent = true;
end

function startup.wait_for_cav_end()
	print("waiting for superchief");
	SleepUntil([|b_super_player], 1);
	print("superchief");
--	cheat_omnipotent = true;
--	cheat_deathless_player = true;
--	cheat_bottomless_clip = true;
--	cheat_infinite_ammo = true;
--	RunClientScript("CheatOnTheClient");
end

function startup.wait_for_cav_fight()

	print("waiting for cav fight!");
	
	SleepUntil([|b_cav_fight], 1);
	
	print("cav fight!");

-- cheat_deathless_player = true;

-- RunClientScript("DeathlessOnTheClient");

	SleepUntil([|not b_cav_fight], 1);
	
-- cheat_deathless_player = false;

	RunClientScript("NormalOnTheClient");

end

-- Only client/server stuff below here!!!!!!!!!!!!!!!!!!!

--## CLIENT
function remoteClient.CheatOnTheClient()
	cheat_infinite_ammo = true;
	cheat_bottomless_clip = true;
	cheat_omnipotent = true;
	cheat_deathless_player = true;
end


function remoteClient.DeathlessOnTheClient()

	cheat_deathless_player = true;
	
end

function remoteClient.NormalOnTheClient()

	cheat_infinite_ammo = false;
	cheat_bottomless_clip = false;
	cheat_omnipotent = false;
	cheat_deathless_player = false;
	
end
