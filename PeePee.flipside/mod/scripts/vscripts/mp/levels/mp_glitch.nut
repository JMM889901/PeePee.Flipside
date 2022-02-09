global function CodeCallback_MapInit

void function CodeCallback_MapInit() {
	if(GetCurrentPlaylistVarInt("Flipside", 0) == 1){
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1439.91, 31.0773 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -912.019, -0.331504 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -320.363, -16.0882 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 303.538, -48.299 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 991.336, -0.162637 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 1711.47, 15.7621 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1343.79, 543.278 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1263.34, 448.071 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -512.027, 495.775 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 31.8425, 431.902 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 703.551, 463.647 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 1391.97, 527.592 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 1823.92, 527.494 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 2495.88, 639.798 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 2368.08, 575.845 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1872, 543.786 >, < 0, -90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1824.06, 1055.66 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -1056.04, 991.609 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, -352.013, 959.659 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 111.981, 975.661 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 576.039, 975.667 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 1848.35, 975.667 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 3120.66, 975.667 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 1200.04, 991.79 >, < 0, 90, 0 >, true, 6000)
	AddMapProp( $"models/vehicle/widow/widow.mdl",  < -210, 2544.28, 1151.78 >, < 0, 90, 0 >, true, 6000)
	}
}

void function AddMapProp( asset a, vector pos, vector ang, bool mantle, int fade)
{
    entity e = CreatePropDynamicLightweight(a, pos, ang, SOLID_VPHYSICS, 6000.0)
    
    if(mantle) e.AllowMantle()
    e.SetScriptName( "editor_placed_prop" )
}