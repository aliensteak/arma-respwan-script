/*
    Initializes the player by setting initial loadout and player position.
*/

player setVariable ['playerLoadout', (getUnitLoadout player)];
player setVariable ['playerInitialPosition', (getPosATL player)];