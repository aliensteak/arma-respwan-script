/*
 * Author: Olsen
 *
 * Locally displays the appropriate message when the player dies.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

params ["_unit", "_killer", "_instigator", "_useEffects"];


// Fade the screen to black and then fade it back in.
[0,"BLACK",0,1] spawn BIS_fnc_fadeEffect;
[{[1,"BLACK",5,1] spawn BIS_fnc_fadeEffect;}, [], 5] call CBA_fnc_waitAndExecute;

// Check if tickets remain and play appropriate dead message
if (FW_RespawnTickets > 0) then {
    [(format ["<t color='#ffffff' size='1'><br/>You are dead<br/><br/>Please wait in spectator for next respawn wave"]), 0, 0.2, 5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
} else {
    setPlayerRespawnTime 10e10;
    [(format ["<t color='#ffffff' size='1'><br/>You are dead<br/><br/>Please wait in spectator for next respawn wave"]), 0, 0.2, 5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
    player setVariable ["FW_Dead", true, true];
};

// force into ACE Spectator and update visible sides based on mission setting
[true] call ace_spectator_fnc_setSpectator; //This enables the ACE_Spectator


switch (playerSide) do { // Sets respawn tickets and sides visible in spectator, based on player side.
    case west: {
        FW_SpectatorSides call ace_spectator_fnc_updateSides;
    };
    case east: {
        FW_SpectatorSides call ace_spectator_fnc_updateSides;
    };
    case resistance: {
        FW_SpectatorSides call ace_spectator_fnc_updateSides;
    };
    case civilian: {
        FW_SpectatorSides call ace_spectator_fnc_updateSides;
    };
};
