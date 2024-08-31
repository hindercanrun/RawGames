--## SERVER

--[[
████████╗███████╗██╗   ██╗███╗   ██╗ █████╗ ███╗   ███╗██╗    ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗ 
╚══██╔══╝██╔════╝██║   ██║████╗  ██║██╔══██╗████╗ ████║██║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║ 
   ██║   ███████╗██║   ██║██╔██╗ ██║███████║██╔████╔██║██║    ███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║ 
   ██║   ╚════██║██║   ██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║    ╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║ 
   ██║   ███████║╚██████╔╝██║ ╚████║██║  ██║██║ ╚═╝ ██║██║    ███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║ 
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ 
                                                                                                                       
███╗   ██╗ █████╗ ██████╗ ██████╗  █████╗ ████████╗██╗██╗   ██╗███████╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
████╗  ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║██║   ██║██╔════╝    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
██╔██╗ ██║███████║██████╔╝██████╔╝███████║   ██║   ██║██║   ██║█████╗      ███████╗██║     ██████╔╝██║██████╔╝   ██║   
██║╚██╗██║██╔══██║██╔══██╗██╔══██╗██╔══██║   ██║   ██║╚██╗ ██╔╝██╔══╝      ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
██║ ╚████║██║  ██║██║  ██║██║  ██║██║  ██║   ██║   ██║ ╚████╔╝ ███████╗    ███████║╚██████╗██║  ██║██║██║        ██║   
╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   
Tsunami Station Narrative Script
------------------------------------------------------------------------------------
--]]


--[[
 ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗     ███████╗
██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║     ██╔════╝
██║  ███╗██║     ██║   ██║██████╔╝███████║██║     ███████╗
██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║     ╚════██║
╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗███████║
 ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
Globals
------------------------------------------------------------------------------------
--]]


global tsu_narrative_is_on:boolean=false;
global tsu_titles_are_on:boolean=false;


--[[
███╗   ██╗ █████╗ ██████╗ ██████╗  █████╗ ████████╗██╗██╗   ██╗███████╗    ████████╗███████╗██╗  ██╗████████╗
████╗  ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║██║   ██║██╔════╝    ╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
██╔██╗ ██║███████║██████╔╝██████╔╝███████║   ██║   ██║██║   ██║█████╗         ██║   █████╗   ╚███╔╝    ██║   
██║╚██╗██║██╔══██║██╔══██╗██╔══██╗██╔══██║   ██║   ██║╚██╗ ██╔╝██╔══╝         ██║   ██╔══╝   ██╔██╗    ██║   
██║ ╚████║██║  ██║██║  ██║██║  ██║██║  ██║   ██║   ██║ ╚████╔╝ ███████╗       ██║   ███████╗██╔╝ ██╗   ██║   
╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝       ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   
Narrative Text
------------------------------------------------------------------------------------
--]]

function title_narr_arbiterturret0()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	dprint ("ARBITER: These Turrets are tearing us apart!");
	f_chapter_title (TITLES.nar_arb01);
	
	dprint ("ARBITER: [cont'd] Let's split up and take them out.");
	f_chapter_title (TITLES.nar_arb02);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end


--[[
 █████╗ ███╗   ███╗██████╗ ██╗███████╗███╗   ██╗████████╗    ████████╗███████╗██╗  ██╗████████╗
██╔══██╗████╗ ████║██╔══██╗██║██╔════╝████╗  ██║╚══██╔══╝    ╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
███████║██╔████╔██║██████╔╝██║█████╗  ██╔██╗ ██║   ██║          ██║   █████╗   ╚███╔╝    ██║   
██╔══██║██║╚██╔╝██║██╔══██╗██║██╔══╝  ██║╚██╗██║   ██║          ██║   ██╔══╝   ██╔██╗    ██║   
██║  ██║██║ ╚═╝ ██║██████╔╝██║███████╗██║ ╚████║   ██║          ██║   ███████╗██╔╝ ██╗   ██║   
╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝          ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   
Ambient Text
------------------------------------------------------------------------------------
--]]

function title_ambient_powersource0()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("[ARBITER BLOWS UP THE TURRET POWER SOURCE]");
	f_chapter_title (TITLES.ch_ps0);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_ambient_elevatorteleport()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("!TELEPORTING PLAYERS TO ELEVATOR IN 5 SECONDS!");
	f_chapter_title (TITLES.ch_elevatorteleport);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_ambient_destructionteleport()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("!WARNING: Players falling behind may be teleported!");
	f_chapter_title (TITLES.ch_destructionteleport);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_ambient_titanattsunaion()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("The Titan At Tsunami");
	f_chapter_title (TITLES.ct_missionstart);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_ambient_throughthewoods()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("... And Through The Woods...");
	f_chapter_title (TITLES.ct_underbelly);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_ambient_partycrashers()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
		
	dprint ("Party Crashers");
	f_chapter_title (TITLES.ct_arcade);
				
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end


--[[
 ██████╗ ██████╗      ██╗███████╗ ██████╗████████╗██╗██╗   ██╗███████╗    ████████╗███████╗██╗  ██╗████████╗
██╔═══██╗██╔══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██║██║   ██║██╔════╝    ╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
██║   ██║██████╔╝     ██║█████╗  ██║        ██║   ██║██║   ██║█████╗         ██║   █████╗   ╚███╔╝    ██║   
██║   ██║██╔══██╗██   ██║██╔══╝  ██║        ██║   ██║╚██╗ ██╔╝██╔══╝         ██║   ██╔══╝   ██╔██╗    ██║   
╚██████╔╝██████╔╝╚█████╔╝███████╗╚██████╗   ██║   ██║ ╚████╔╝ ███████╗       ██║   ███████╗██╔╝ ██╗   ██║   
 ╚═════╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝       ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   
Objective Text
------------------------------------------------------------------------------------
--]]

function title_objective_defense()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	ObjectiveShow (TITLES.obj_defense );
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end


function title_objective_board()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	dprint ("OBJECTIVE: Board Guardian Before It Departs");
	ObjectiveShow (TITLES.obj_board);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_objective_disable()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	dprint ("OBJECTIVE: Disable Anti-Air Turrets");
	ObjectiveShow (TITLES.obj_disable);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_objective_clear()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	dprint ("OBJECTIVE: Clear a Landing Zone");
	ObjectiveShow (TITLES.obj_clear);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_objective_proceed()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	dprint ("OBJECTIVE: Proceed to Guardian");
	ObjectiveShow (TITLES.obj_proceed);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

function title_objective_warden()
	SleepUntil ([|	tsu_titles_are_on == false], 1);
	tsu_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	CreateThread(audio_newobjective_beep);
	dprint ("OBJECTIVE: Defeat the Warden");
	CreateThread(audio_tsunami_warden_fight);
	ObjectiveShow (TITLES.obj_warden);
			
	print ("Narrative/Ambient text has ended");	
	tsu_titles_are_on = false;
end

--function title_objective_continue()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Continue Through Tsunaion");
	--ObjectiveShow (TITLES.obj_continue);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_disable1()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Disable the Shrike Turrets");
	--ObjectiveShow (TITLES.obj_disable1);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_disable()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Disable the Shrike Turrets");
	--ObjectiveShow (TITLES.obj_disable);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_clear()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Clear a Landing Zone");
	--ObjectiveShow (TITLES.obj_clear);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_ub2()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Find a Way Up To the Surface");
	--ObjectiveShow (TITLES.obj_ub2);
	--
		--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_rendezvous()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Rendezvous With Arbiter's Team");
	--ObjectiveShow (TITLES.obj_rendezvous);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_wreckage()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Continue Through the Wreckage");
	--ObjectiveShow (TITLES.obj_wreckage);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_regroup()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Regroup with Arbiter");
	--ObjectiveShow (TITLES.obj_regroup);
--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_objective_escape()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
--
	--CreateThread(audio_newobjective_beep);
	--dprint ("OBJECTIVE: Escape Tsunaion");
	--ObjectiveShow (TITLES.obj_escape);
			--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end
--
--function title_turret_count()
	--SleepUntil ([|	tsu_titles_are_on == false], 1);
	--tsu_titles_are_on = true;
	--print ("Narrative/Ambient/Objective text playing");
	--
	--if	(v_shrike_tally == 1)	then
		--CreateThread(audio_newobjective_beep);
		--dprint ("1 of 5 Turrets Disabled!");
		--ObjectiveShow (TITLES.turrcount_turr1);
	--elseif	(v_shrike_tally == 2)	then
		--CreateThread(audio_newobjective_beep);
		--dprint ("2 of 5 Turrets Disabled!");
		--ObjectiveShow (TITLES.turrcount_turr2);
	--elseif	(v_shrike_tally == 3)	then
		--CreateThread(audio_newobjective_beep);
		--dprint ("3 of 5 Turrets Disabled!");
		--ObjectiveShow (TITLES.turrcount_turr3);
	--elseif	(v_shrike_tally == 4)	then
		--CreateThread(audio_newobjective_beep);
		--dprint ("4 of 5 Turrets Disabled!");
		--ObjectiveShow (TITLES.turrcount_turr4);
	--elseif	(v_shrike_tally == 5)	then
		--CreateThread(audio_newobjective_beep);
		--dprint ("5 of 5 Turrets Disabled!");
		--ObjectiveShow (TITLES.turrcount_turr5);
	--end
	--
	--print ("Narrative/Ambient text has ended");	
	--tsu_titles_are_on = false;
--end

--]]
--[[
███╗   ███╗██╗███████╗ ██████╗       ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
████╗ ████║██║██╔════╝██╔════╝       ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
██╔████╔██║██║███████╗██║            ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
██║╚██╔╝██║██║╚════██║██║            ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
██║ ╚═╝ ██║██║███████║╚██████╗██╗    ███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
Misc Scripts
------------------------------------------------------------------------------------
--]]


function faux_mission_objective_text (text:string):void
	local x:number = 0;

	if (text ~= nil) then
--			set_text_defaults();

		set_text_defaults();
		set_text_color(1, 0.9764706, 0.9764706, 0.9764706);
		set_text_lifespan(360);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.top);
		set_text_scale(1);
		set_text_margins(0, 0.25, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);
		show_text(text);
	end
		set_text_lifespan(300);
--		Sleep(300);
--		clear_all_text();
end