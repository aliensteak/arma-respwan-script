/*
	Author: AlienSteak

	Description:
		Sets player's loadout back to its original state and respawns them at their original location

	Parameter(s):
		None

	Returns:
		None

	Example:
		N/A
*/

ace_nametags_showPlayerNames = 0;
[{
    ace_nametags_showPlayerNames = 1;
}, [], 5] call CBA_fnc_waitAndExecute;

_playerLoadout = player getVariable "playerLoadout";
_playerInitialPosition = player getVariable "playerInitialPosition";

if !(isNil "_playerLoadout") then {
    player setUnitLoadout [_playerLoadout, true];
};

if !(isNil "_playerInitialPosition") then {
    player setPosATL _playerInitialPosition;
} else {
    systemChat "Something went wrong with the script. RIP";
};

// systemChat "Press 0 twice to fix audio bug. Sorry for the inconvenience :(";

