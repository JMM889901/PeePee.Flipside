global function OnWeaponPrimaryAttack_shifter_super
//global function InitPhaseShiftExecution

const SHIFTER_SUPER_WARMUP_TIME = 0.0
const SHIFTER_SUPER_WARMUP_TIME_FAST = 0.0
const SHIFTER_SUPER_DURATION = 999999
//<2745.16, 1774, 25.8693>  <2563.61, 2097.9, 268.031>
var function OnWeaponPrimaryAttack_shifter_super( entity weapon, WeaponPrimaryAttackParams attackParams )
{
    if(FlipsideEnabled()){
        float warmupTime = SHIFTER_SUPER_WARMUP_TIME
        if ( weapon.HasMod( "short_shift" ) )
        {
            warmupTime = SHIFTER_SUPER_WARMUP_TIME_FAST
        }
        if ( weapon.HasMod( "short_shift" ) )
        {
            warmupTime = SHIFTER_SUPER_WARMUP_TIME_FAST
        }
        #if SERVER
//-205, 130
        entity weaponOwner = weapon.GetWeaponOwner()
        int phaseResult = PhaseShift( weaponOwner, 0, 0.2 )
        if ( phaseResult )
        {
            PlayerUsedOffhand( weaponOwner, weapon )
            #if BATTLECHATTER_ENABLED && SERVER
                TryPlayWeaponBattleChatterLine( weaponOwner, weapon )
            #endif
            #if MP
            TeleportPlayer(weapon, weaponOwner)
            #endif
            return weapon.GetWeaponSettingInt( eWeaponVar.ammo_min_to_fire )
        }
        #endif
    
    }

    else{
    float warmupTime = SHIFTER_SUPER_WARMUP_TIME
    if ( weapon.HasMod( "short_shift" ) )
    {
        warmupTime = SHIFTER_SUPER_WARMUP_TIME_FAST
    }
	if ( weapon.HasMod( "short_shift" ) )
	{
		warmupTime = SHIFTER_SUPER_WARMUP_TIME_FAST
	}

	entity weaponOwner = weapon.GetWeaponOwner()

	if ( weaponOwner.IsPhaseShifted() )
	{
		#if SERVER
		CancelPhaseShift( weaponOwner )
		#endif //SERVER
		return weapon.GetWeaponSettingInt( eWeaponVar.ammo_min_to_fire )
	}

	//int phaseResult = PhaseShift( weaponOwner, warmupTime, weapon.GetWeaponSettingFloat( eWeaponVar.fire_duration ) )
	int phaseResult = PhaseShift( weaponOwner, warmupTime, SHIFTER_SUPER_DURATION )

	if ( phaseResult )
	{
		PlayerUsedOffhand( weaponOwner, weapon )
		#if BATTLECHATTER_ENABLED && SERVER
			TryPlayWeaponBattleChatterLine( weaponOwner, weapon )
		#endif

		return weapon.GetWeaponSettingInt( eWeaponVar.ammo_min_to_fire )
	}
}

	return 0
}

bool function PlayerPosInSolid( entity player, vector targetPos )
{
    int solidMask = TRACE_MASK_PLAYERSOLID
    vector mins
    vector maxs
    int collisionGroup = TRACE_COLLISION_GROUP_PLAYER
    array<entity> ignoreEnts = []
    ignoreEnts.append( player ) //in case we want to check player's current pos
    TraceResults result

    mins = player.GetPlayerMins()
    maxs = player.GetPlayerMaxs()
    result = TraceHull( targetPos, targetPos + Vector( 0, 0, 1), mins, maxs, ignoreEnts, solidMask, collisionGroup )
    if ( result.startSolid )
        return true

    return false

}
bool function FlipsideEnabled(){
    return GetCurrentPlaylistVarInt("Flipside", 0) == 1 || GetConVarInt("Flipside") == 1
}

//script GetPlayerArray()[0].SetOrigin(< -205 + (-205.0 - GetPlayerArray()[0].GetOrigin().x), 127 + (127 - GetPlayerArray()[0].GetOrigin().y) ,500>)
//script GetPlayerArray()[0].SetAngles(<0,(180-GetPlayerArray()[0].GetAngles().y),(180-GetPlayerArray()[0].GetAngles().z)>)
/*
void function InitPhaseShiftExecution()
{
	AddSyncedMeleeServerCallback( GetSyncedMeleeChooser( "human", "human" ), PhaseExecution )
}

void function PhaseExecution( SyncedMeleeChooser actions, SyncedMelee action, entity player, entity enemy )
{
	//Must check to see if executing player has super phase shift.
	PhaseShift( player, SHIFTER_SUPER_WARMUP_TIME, SHIFTER_SUPER_DURATION )
	PhaseShift( enemy, SHIFTER_SUPER_WARMUP_TIME, SHIFTER_SUPER_DURATION )
}
*/