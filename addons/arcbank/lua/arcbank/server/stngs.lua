--stngs.lua - default settings

-- This file is under copyright, and is bound to the agreement stated in the EULA.
-- Any 3rd party content has been used as either public domain or with permission.
-- © Copyright 2014-2017 Aritz Beobide-Cardinal All rights reserved.

ARCBank.Loaded = false
ARCBank.Settings = {}

--[[
 ____   ___    _   _  ___ _____   _____ ____ ___ _____   _____ _   _ _____   _    _   _   _      _____ ___ _     _____ _ 
|  _ \ / _ \  | \ | |/ _ \_   _| | ____|  _ \_ _|_   _| |_   _| | | | ____| | |  | | | | / \    |  ___|_ _| |   | ____| |
| | | | | | | |  \| | | | || |   |  _| | | | | |  | |     | | | |_| |  _|   | |  | | | |/ _ \   | |_   | || |   |  _| | |
| |_| | |_| | | |\  | |_| || |   | |___| |_| | |  | |     | | |  _  | |___  | |__| |_| / ___ \  |  _|  | || |___| |___|_|
|____/ \___/  |_| \_|\___/ |_|   |_____|____/___| |_|     |_| |_| |_|_____| |_____\___/_/   \_\ |_|   |___|_____|_____(_)

 ____   ___    _   _  ___ _____   _____ ____ ___ _____   _____ _   _ _____   _    _   _   _      _____ ___ _     _____ _ 
|  _ \ / _ \  | \ | |/ _ \_   _| | ____|  _ \_ _|_   _| |_   _| | | | ____| | |  | | | | / \    |  ___|_ _| |   | ____| |
| | | | | | | |  \| | | | || |   |  _| | | | | |  | |     | | | |_| |  _|   | |  | | | |/ _ \   | |_   | || |   |  _| | |
| |_| | |_| | | |\  | |_| || |   | |___| |_| | |  | |     | | |  _  | |___  | |__| |_| / ___ \  |  _|  | || |___| |___|_|
|____/ \___/  |_| \_|\___/ |_|   |_____|____/___| |_|     |_| |_| |_|_____| |_____\___/_/   \_\ |_|   |___|_____|_____(_)


 ____   ___    _   _  ___ _____   _____ ____ ___ _____   _____ _   _ _____   _    _   _   _      _____ ___ _     _____ _ 
|  _ \ / _ \  | \ | |/ _ \_   _| | ____|  _ \_ _|_   _| |_   _| | | | ____| | |  | | | | / \    |  ___|_ _| |   | ____| |
| | | | | | | |  \| | | | || |   |  _| | | | | |  | |     | | | |_| |  _|   | |  | | | |/ _ \   | |_   | || |   |  _| | |
| |_| | |_| | | |\  | |_| || |   | |___| |_| | |  | |     | | |  _  | |___  | |__| |_| / ___ \  |  _|  | || |___| |___|_|
|____/ \___/  |_| \_|\___/ |_|   |_____|____/___| |_|     |_| |_| |_|_____| |_____\___/_/   \_\ |_|   |___|_____|_____(_)
I have recieved too many questions regarding the "config file" or "The ATM is saying Contact an admin".

So, let me try to explain something to you...

DO NOT EDIT THIS FILE TO CHANGE THE CONFIG! READ THE README!
These are the default settings in order to prevent you from screwing it up!

RUN THESE COMMANDS IN CONSOLE!

arcbank admin_gui
^ That command does everything

--OR--

arcbank help
^ GIVES YOU A FULL AND DETAILED DESCRIPTION OF ALL COMMANDS

arcbank settings_help (setting)
^ GIVES YOU A FULL DESCRIPTION OF ALL SETTINGS (Leave blank to show a list of all settings.)

arcbank settings (setting) (value)
^ SETS THE SETTING YOU WANT TO THE SPECIFIED VALUE.
]]
function ARCBank.SettingsReset() --DO NOT EDIT THIS!!!!
	--ARCBank.Settings[""]
	ARCBank.Settings["name"] = "ARCBank" --DO NOT EDIT THIS!!!!
	ARCBank.Settings["name_long"] = "ARitz Cracker Bank" --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["account_interest_time_limit"] = 14 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["account_starting_cash"] = 500 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["account_debt_limit"] = 10000  --DO NOT EDIT THIS!!!!
	
	
	ARCBank.Settings["card_texture"] = "arc/atm_base/screen/card" --DO NOT EDIT THIS!!!!
	ARCBank.Settings["card_weapon_slot"] = 1 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["card_weapon_slotpos"] = 4 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["card_weapon_position_up"] = 0 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["card_weapon_position_left"] = 0 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["card_weapon"] = "weapon_arc_atmcard"
	ARCBank.Settings["card_texture_world"] = "arc/card/cardex"
	ARCBank.Settings["card_draw_vehicle"] = false
	
	ARCBank.Settings["atm_hack_max"] = 5000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_min"] = 25 --DO NOT EDIT THIS!!!!
	
	
	ARCBank.Settings["atm_hack_time_max"] = 666 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_time_min"] = 20 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["atm_hack_time_stealth_rate"] = 2.5 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["atm_hack_time_curve"] = 2.25 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["atm_hack_charge_rate"] = 1.5 --DO NOT EDIT THIS!!!!
	
	
	ARCBank.Settings["atm_hack_notify"] = {"TEAM_POLICE","TEAM_MAYOR","TEAM_CHIEF"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_min_player"] = 3 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_allowed_use"] = false --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_allowed"] = {"TEAM_GANG","TEAM_MOB","TEAM_POLICE","TEAM_MAYOR","TEAM_CHIEF"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_radar"] = true --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_holo"] = false --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_hack_noob_chat"] = true --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["language"] = "en_ca" --DO NOT EDIT THIS!!!!
	ARCBank.Settings["syslog_delete_time"] = 14 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["use_bank_for_payday"] = true --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_holo"] = true --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_holo_rotate"] = true --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_holo_text"] = "$$ ATM $$" --DO NOT EDIT THIS!!!!
	ARCBank.Settings["account_group_limit"] = 4 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["account_group_member_limit"] = 32 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["death_money_remove"] = 80 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["death_money_drop"] = 60 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["death_money_drop_model"] = "models/props/cs_assault/money.mdl" --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["autoban_time"] = 120 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["interest_time"] = 24 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_perpetual_debt"] = false --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_enable"] = true --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["interest_1_standard"] = 1 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_2_bronze"] = 2 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_3_silver"] = 4 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_4_gold"] = 8 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_6_group_standard"] = 2.5 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["interest_7_group_premium"] = 5 --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["money_max_1_standard"] = 1000000000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_max_2_bronze"] = 10000000000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_max_3_silver"] = 1000000000000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_max_4_gold"] = 99999999999999 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_max_6_group_standard"] = 1000000000000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_max_7_group_premium"] = 99999999999999 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_symbol"] = "$" --DO NOT EDIT THIS!!!!
	ARCBank.Settings["money_format"] = "$0" --DO NOT EDIT THIS!!!!
	
	
	
	ARCBank.Settings["usergroup_1_standard"] = {"user"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_2_bronze"] = {"vip"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_3_silver"] = {"donaor"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_4_gold"] = {"admin"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_6_group_standard"] = {"vip"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_7_group_premium"] = {"donator","admin"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["usergroup_all"] = {"operator","owner","superadmin","founder"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["admins"] = {"owner","superadmin","founder"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["moderators"] = {"admin"} --DO NOT EDIT THIS!!!!
	ARCBank.Settings["moderators_read_only"] = true
	
	ARCBank.Settings["atm_hack_min_hackerstoppers"] = 1 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_darkmode_default"] = false --DO NOT EDIT THIS!!!!
	
	ARCBank.Settings["atm_fast_amount_1"] = 200 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_fast_amount_2"] = 400 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_fast_amount_3"] = 600 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_fast_amount_4"] = 1000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_fast_amount_5"] = 2000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["atm_fast_amount_6"] = 4000 --DO NOT EDIT THIS!!!!
	ARCBank.Settings["_ester_eggs"] = true --DO NOT EDIT THIS!!!!
	
end

ARCBank.SettingsReset()


