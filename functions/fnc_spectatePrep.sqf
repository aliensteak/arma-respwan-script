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

    // retrieve player faction from player variable if not null, or get latest
    private _playerFaction = objNull;
    if (!isNil {player getVariable "PlayerFaction"}) then {
        _playerFaction = player getVariable "PlayerFaction";
    } else {
        _playerFaction = playerSide;
    };

    private _respawnName = toLower(format ["fw_%1_respawn", _playerFaction]);
    private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];

    // retrieve PlayerLoadout and set player loadout back to initial state
    if (!isNil {player getVariable "PlayerLoadout"}) then {
        player setUnitLoadout [player getVariable "PlayerLoadout", true];
    };

    if (!isNull(_respawnPoint)) then {
        _respawnPosition = getPosATL _respawnPoint;
        player setPosATL ([[[_respawnPosition, 10]]] call BIS_fnc_randomPos); //yes this needs all three square brackets on each side.
    };

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
