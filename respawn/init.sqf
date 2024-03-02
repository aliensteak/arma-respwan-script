/*
	Author: AlienSteak

	Description:
		Initializes the respawn script

	Parameter(s):
		None

	Returns:
		None

	Example:
		N/A
*/

if !(hasInterface) exitWith { /* condition exits if client is not a player (like dedicated server or headless client) */ };

// anything done using "player" must be past this line for JIP compatibility
waitUntil {!(isNull player)};

// initialize the player
// call TOB_fnc_playerLoadInit;

_adminState = call BIS_fnc_admin != 0;
_isGodOrInGodGroup = !isNil "God" && { God isEqualTo player || { group player isEqualTo group God } };
if (_adminState || _isGodOrInGodGroup) then {
	// this adds a briefing menu that gives you a button that can be clicked to call a respawn wave.
	call TOB_fnc_respawnWaveEntries;
};

player addEventHandler ["Killed", {call TOB_fnc_makeSpectator}];
player addEventHandler ["Respawn", {call TOB_fnc_respawnPlayers}];
