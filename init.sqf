
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1

#define FUNC(var1) DOUBLES(Olsen_FW_FNC,var1)

#define PREP(fncName) FUNC(fncName) = compile preprocessFileLineNumbers QUOTE(functions\DOUBLES(fnc,fncName).sqf)

PREP(removeAllGear);
PREP(spectateCheck);
PREP(spectatePrep);

// this line of code is to disable debug messages from spotlight mod
missionNamespace setVariable ["FL_Spotlight_isDebug",false,true];

if (hasInterface) then { //This scope is for the players

    //Anything done using "player" must be past this line for JIP compatibility
    waitUntil {!(isNull player)};

    _adminState = call BIS_fnc_admin;
    _uid = getPlayerUID player;
    if (
        (_adminState != 0) || // this will let the admin call the respawn
        (!isNil "God" && {God isEqualTo player || {group player isEqualTo group God}}) // Zeus unit variable name God and will let the zeus or anyone in the same group call the respawn
    ) then {
        // this adds a briefing menu that gives you a button that can be clicked to call a respawn wave.
        player createDiaryRecord ["Diary", ["Respawn", "
            <br/><font color='#70db70' size='14'>Respawn Wave:</font>
            <br/>This is used to call a respawn wave on demand, it will give the players in spectator a single respawn with a 5 second timer.
            <br/>
            <br/>If the admin is dead and in spectator they can also trigger a respawn by typing the admin only chat command <font color='#FF8C00'>#respawnWave</font> in spectator chat.
            <br/>
            <execute expression=' \
                FW_RespawnTickets = 1; \
                [playerSide, ""HQ""] sideChat ""Respwan Wave Started""; \
                publicVariable ""FW_RespawnTickets""; \
                {setPlayerRespawnTime 5;} remoteExec [""call""]; \
                [ \
                    { \
                        FW_RespawnTickets = 0; \
                        [playerSide, ""HQ""] sideChat ""Respwan Wave Ended"";\
                        publicVariable ""FW_RespawnTickets""; \
                        10e10 remoteExec [""setPlayerRespawnTime""]; \
                    }, \
                    [], \
                    30 \
                ] call CBA_fnc_waitAndExecute; \
            '>Call Respawn Wave</execute>
        "]]
    };

    //Chat commands to allow the admin to call a respawn even when dead/spectating.
    ["respawnWave", {
        FW_RespawnTickets = 1;
        [playerSide, "HQ"] sideChat "Respwan Wave Started";
        publicVariable "FW_RespawnTickets";
        {
            setPlayerRespawnTime 5;
        } remoteExec ["call"];
        [
            {
                FW_RespawnTickets = 0;
                [playerSide, "HQ"] sideChat "Respwan Wave Ended";
                publicVariable "FW_RespawnTickets";
                10e10 remoteExec ["setPlayerRespawnTime"];
            },
            [],
            30
        ] call CBA_fnc_waitAndExecute;
    }, "admin"] call CBA_fnc_registerChatCommand;

    FW_RespawnTickets = 0; //Initialize respawn tickets to 0

    player setVariable ["FW_Dead", false, true]; //Tells the framework the player is alive

    // Makes the player go into spectator mode when dead or respawn if he has respawn tickets
    FW_KilledEh = player addEventHandler ["Killed", {_this call Olsen_FW_FNC_SpectateCheck;}];
    FW_RespawnEh = player addEventHandler ["Respawn", {_this call Olsen_FW_FNC_SpectatePrep;}];

    switch (playerSide) do { // Sets respawn tickets and sides visible in spectator, based on player side.
        case west: {
            FW_RespawnTickets = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_west_respawn
            FW_SpectatorSides = [[west], [east,independent,civilian]]; //[[allowed sides],[disallowed sides]] move a side to the other array to change it's visibility.  Example: [[west,independent], [east,civilian]]
        };
        case east: {
            FW_RespawnTickets = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_east_respawn
            FW_SpectatorSides = [[east], [west,independent,civilian]];
        };
        case resistance: {
            FW_RespawnTickets = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_guer_respawn
            FW_SpectatorSides = [[independent], [west,east,civilian]];
        };
        case civilian: {
            FW_RespawnTickets = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_civilian_respawn
            FW_SpectatorSides = [[civilian], [west,east,independent]];
        };
    };
};
