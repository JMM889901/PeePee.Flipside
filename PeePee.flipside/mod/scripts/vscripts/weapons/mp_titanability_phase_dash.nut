global function OnWeaponPrimaryAttack_titanability_phase_dash

#if SERVER
global function OnWeaponNPCPrimaryAttack_titanability_phase_dash
global function SetPlayerVelocityFromInput
#endif

const PHASE_DASH_SPEED = 1000

var function OnWeaponPrimaryAttack_titanability_phase_dash( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	//PlayWeaponSound( "fire" )
	entity player = weapon.GetWeaponOwner()

	float shiftTime =  1.0

	if ( IsAlive( player ) )
	{
		if ( PhaseShift( player, 0, shiftTime ) )
		{
			if ( player.IsPlayer() )
			{
				PlayerUsedOffhand( player, weapon )
				if(FlipsideEnabled()){
				#if SERVER
					EmitSoundOnEntityExceptToPlayer( player, player, "Stryder.Dash" )
					thread PhaseDash( weapon, player )
					entity soul = player.GetTitanSoul()
					if ( soul == null )
						soul = player

					float fade = 0.5
					StatusEffect_AddTimed( soul, eStatusEffect.move_slow, 0.6, shiftTime + fade, fade )
				#elseif CLIENT
					float xAxis = InputGetAxis( ANALOG_LEFT_X )
					float yAxis = InputGetAxis( ANALOG_LEFT_Y ) * -1
					vector angles = player.EyeAngles()
					vector directionForward = GetDirectionFromInput( angles, xAxis, yAxis )
					if ( IsFirstTimePredicted() )
					{
						EmitSoundOnEntity( player, "Stryder.Dash" )
					}
				#endif
				}
				else{
					#if SERVER && MP
					TeleportPlayer(weapon, player)
					#endif
					return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
					}
				}

			}
		}
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

#if SERVER
var function OnWeaponNPCPrimaryAttack_titanability_phase_dash( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return OnWeaponPrimaryAttack_titanability_phase_dash( weapon, attackParams )
}

void function PhaseDash( entity weapon, entity player )
{
	float movestunEffect = 1.0 - StatusEffect_Get( player, eStatusEffect.dodge_speed_slow )
	float moveSpeed
	if ( weapon.HasMod( "fd_phase_distance" ) )
		moveSpeed = PHASE_DASH_SPEED * movestunEffect * 1.5
	else
		moveSpeed = PHASE_DASH_SPEED * movestunEffect
	SetPlayerVelocityFromInput( player, moveSpeed, <0,0,200> )
}

void function SetPlayerVelocityFromInput( entity player, float scale, vector baseVel = < 0,0,0 > )
{
	vector angles = player.EyeAngles()
	float xAxis = player.GetInputAxisRight()
	float yAxis = player.GetInputAxisForward()
	vector directionForward = GetDirectionFromInput( angles, xAxis, yAxis )

	player.SetVelocity( directionForward * scale + baseVel )
}
#endif

vector function GetDirectionFromInput( vector playerAngles, float xAxis, float yAxis )
{
	playerAngles.x = 0
	playerAngles.z = 0
	vector forward = AnglesToForward( playerAngles )
	vector right = AnglesToRight( playerAngles )

	vector directionVec = Vector(0,0,0)
	directionVec += right * xAxis
	directionVec += forward * yAxis

	vector directionAngles = VectorToAngles( directionVec )
	vector directionForward = AnglesToForward( directionAngles )

	return directionForward
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