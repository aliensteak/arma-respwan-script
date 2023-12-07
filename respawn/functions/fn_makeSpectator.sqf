/*
	Author: AlienSteak

	Description:
		Makes players spectators and displays a message to dead players

	Parameter(s):
		None

	Returns:
		None

	Example:
		N/A
*/

// Fade the screen to black and then fade it back in.
[0, "BLACK", 0, 1] spawn BIS_fnc_fadeEffect;
[{[1, "BLACK", 5, 1] spawn BIS_fnc_fadeEffect;}, [], 5] call CBA_fnc_waitAndExecute;

[(format ["<t color='#ffffff' size='0.5'><br/>You are dead<br/><br/>Please wait in spectator for next respawn wave"]), 0, 0.2, 5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;

// FIXME: this is not working for some reason
// sets sides visible in spectator, based on player side.
// ex: [[allowed sides],[disallowed sides]] call ace_spectator_fnc_updateSides;
switch (playerSide) do {
    case west: {
        [[west], [east,independent,civilian]] call ace_spectator_fnc_updateSides;
    };
    case east: {
        [[east], [west,independent,civilian]] call ace_spectator_fnc_updateSides;
    };
    case resistance: {
        [[independent], [west,east,civilian]] call ace_spectator_fnc_updateSides;
    };
    case civilian: {
        [[civilian], [west,east,independent]] call ace_spectator_fnc_updateSides;
    };
};