# TOB Respawn Script

## How to
1. Entry point - `init.sqf` - adds diary entry for admin and zeus to call in respawn and allows admin to call respawn wave via respawn command (`respawnWave`). Also adds 2 event listeners when player is killed to put them in spectator mode and run respawn logic when respawn wave is called.
2. Save Loadout - `initPlayerLocal.sqf` - saves the starting player loadout which is then used to apply the loadout when player respawns.
3. Remove all gear - `fnc_remoteAllGear.sqf` - removes all the gear a player has.
4. Force player into spectator screen - `fnc_spectateCheck.sqf`
5. Run respawn logic - `fnc_spectatePrep.sqf` - retrieves respawn point based on player side and respawns player with the kit saved from when the player joined at the respawn point