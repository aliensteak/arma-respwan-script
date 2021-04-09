/*
 * Author: Olsen
 *
 * Checks and handles if the player should respawn or begin spectating.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

[false] call ace_spectator_fnc_setSpectator;
// systemChat "ACE Spec UnSet";

ace_nametags_showPlayerNames = 0;

[{
    ace_nametags_showPlayerNames = 1;
}, [], 5] call CBA_fnc_waitAndExecute;

if (FW_RespawnTickets > 0) then {
    private _respawnName = "fw_respawn";
    private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];

    // retrieve PlayerLoadout and set player loadout back to initial state
    if (!isNil {player getVariable "PlayerLoadout"}) then {
        player setUnitLoadout [player getVariable "PlayerLoadout", true];
    };

    if (!isNull(_respawnPoint)) then {
        _respawnPosition = getPosATL _respawnPoint;
        player setPosATL ([[[_respawnPosition, 10]]] call BIS_fnc_randomPos); //yes this needs all three square brackets on each side.
    };

    player sideChat "Press 0 twice to fix audio bug. Sorry for the inconvenience :(";

    FW_RespawnTickets = FW_RespawnTickets - 1;
} else {
    player setCaptive true;
    player allowdamage false;
    player call Olsen_FW_FNC_RemoveAllGear;
    player addWeapon "itemMap";
    player setPos [0, 0, 0];
    [player] join grpNull;
    hideObjectGlobal player;
    [true] call ace_spectator_fnc_setSpectator;
};
