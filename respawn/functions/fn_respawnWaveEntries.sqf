callRespawnWaveFucntion = {
	systemChat "Respawn Wave Started";
	5 remoteExec ["setPlayerRespawnTime"];
	[
		{
			systemChat "Respawn Wave Ended";
			10e10 remoteExec ["setPlayerRespawnTime"];
		},
		[],
		30
	] call CBA_fnc_waitAndExecute;
};

// this adds a briefing menu that gives you a button that can be clicked to call a respawn wave.
player createDiaryRecord ["Diary", ["Respawn", "
	<br/><font color='#70db70' size='14'>Respawn Wave:</font>
	<br/>This is used to call a respawn wave on demand, it will give the players in spectator a single respawn with a 5 second timer.
	<br/>
	<br/>If the admin is dead and in spectator they can also trigger a respawn by typing the admin only chat command <font color='#FF8C00'>#respawnWave</font> in spectator chat.
	<br/>
	<execute expression='call callRespawnWaveFucntion'>Call Respawn Wave</execute>
"]];

// chat commands to allow the admin to call a respawn even when dead/spectating.
["respawnWave", { call callRespawnWaveFucntion }, "admin"] call CBA_fnc_registerChatCommand;
