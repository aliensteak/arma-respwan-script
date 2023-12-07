/*
	Author: AlienSteak

	Description:
		Initializes the player by setting initial loadout and player position.

		Has to be executed after the "player" not nil for JIP compatibility

	Parameter(s):
		None

	Returns:
		None

	Example:
		N/A
*/

_init_player = {
	player setVariable ['playerLoadout', (getUnitLoadout player)];
	player setVariable ['playerInitialPosition', (getPosATL player)];
};

_init_player remoteExec ["call", player];
