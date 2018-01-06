private ["_name", "_sizeX", "_sizeY", "_pos","_showTownMarkers","_showVehMarkers","_dbVehicles","_vehicleDB","_vehicleName","_vehicleNameArr","_vehicleModel","_vehicleCount","_xPos","_yPos",
"_zPos","_damage","_fuel","_fuelCargo","_veh", "_vehmark", "_vehicleModifier","_whiteListMkrs","_blackListTowns", "_addLoot",
"_maxDamage", "_damageEnabled", "_hitpointsData", "_hitpoints", "_damageChance", "_dmg", "_randomFuelEnabled","_maxFuel", "_fuelAmount",
"_spawnWeapons","_spawnItems","_spawnClothes","_spawnBackpacksVests"];

#define def_VEHICLE_MODIFIER 2
#define def_SHOW_VEHICLE_MARKERS false
#define def_ADD_LOOT true
#define def_MAX_DAMAGE 75
#define def_DAMAGE_ENABLED true
#define def_DAMAGE_CHANCE 75
#define def_MAX_FUEL 75
#define def_RANDOM_FUEL_ENABLED true
#define def_SPAWN_WEAPONS true
#define def_SPAWN_ITEMS true
#define def_SPAWN_CLOTHES true
#define def_SPAWN_BACKPACKS_VESTS true

params [
    ["_logic", objNull],
    "",
    ["_activated", true]
];

// Get module attributes
_vehicleModifier   = _logic getVariable ["VehicleModifier", def_VEHICLE_MODIFIER];
_showVehMarkers    = _logic getVariable ["ShowMarkers", def_SHOW_VEHICLE_MARKERS];
_addLoot           = _logic getVariable ["AddLoot", def_ADD_LOOT];
_maxDamage         = _logic getVariable ["MaxDamage", def_MAX_DAMAGE];
_damageEnabled     = _logic getVariable ["DamageEnabled", def_DAMAGE_ENABLED];
_damageChance      = _logic getVariable ["DamageChance", def_DAMAGE_CHANCE];
_randomFuelEnabled = _logic getVariable ["RandomFuelEnabled", def_RANDOM_FUEL_ENABLED];
_maxFuel           = _logic getVariable ["MaxFuel", def_MAX_FUEL];

// Loot Types
_spawnWeapons        = _logic getVariable ["SpawnWeapons", def_SPAWN_WEAPONS];
_spawnItems          = _logic getVariable ["SpawnItems", def_SPAWN_ITEMS];
_spawnClothes        = _logic getVariable ["SpawnClothes", def_SPAWN_CLOTHES];
_spawnBackpacksVests = _logic getVariable ["SpawnBackpacksVests", def_SPAWN_BACKPACKS_VESTS];

_blackListTowns  = [];
_whiteListMkrs   = ["comms_alpha","comms_bravo"];// Add Custom Markers for COS to populate 
_showTownMarkers = false;
cosMkrArray      = [];

{
    // Organise towns and markers
    if (_x in _whiteListMkrs)
    then {
        _sizeX = getMarkerSize _x select 0;
        _sizeY = getMarkerSize _x select 1;
        _pos   = markerpos _x;
        _name  = markerText _x;// Get the markers description
        
        if (_name == "")
        then {
            _name = _x;
        };// If description is empty then use marker name
        
        deletemarker _x;// Delete user placed marker
    }
    else{
        _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusA");
        _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (text _x) >> "radiusB");
        _pos   = getpos _x;
        _name  = text _x; // Get name
    };
    
    if !(({_name == _x} count _blackListTowns) > 0 OR (_name == "")) 
    then
    {
        // Create marker over town
        _markerID = format ["COSmkrID%1",_name];
        _foo      = createmarker [_markerID, _pos];
        _foo setMarkerSize [_sizeX, _sizeY];
        _foo setMarkerShape "ELLIPSE";
        _foo setMarkerBrush "SOLID";
        _foo setMarkerColor "ColorGreen";
        _foo setMarkerText _name;
        cosMkrArray pushBack _foo;
        
        if (!_showTownMarkers) 
        then {
            _foo setmarkerAlpha 0;
        }
        else{
            _foo setmarkerAlpha 0.5;
        };// Show or hide marker
        
        // Get positions until we have enough for the population
        _roadlist = _pos nearRoads 750;
        
        _vehiclesToSpawn = random _vehicleModifier;
        
        
        
        if (count _roadlist > 0)
        then {
            for "_n" from 0 to _vehiclesToSpawn do
            {
                _tempRoad    = _roadlist call bis_fnc_selectRandom;
                _tempPos     = getPos _tempRoad;
                _tempTarRoad = _roadlist call bis_fnc_selectRandom;
                _tempTarPos  = getPos _tempTarRoad;
                _vehicleName = B52_CivCars call bis_fnc_selectRandom;
                _direction   = [_tempPos, _tempTarPos] call BIS_fnc_DirTo;
                _veh         = createVehicle [_vehicleName, _tempPos, [], 0, "NONE"];
                _veh setdir _direction;
                _veh setPos [(getPos _veh select 0)-6, getPos _veh select 1, getPos _veh select 2];
                
                // Damage vehicle if enabled
                if (_damageEnabled)
                then {
                    _hitpointsData = getAllHitPointsDamage _veh;
                    if !(_hitpointsData isEqualTo []) then 
                    {
                        _hitpoints = _hitpointsData select 0;
                        {
                            if ((random 100) < _damageChance) then
                            {
                                _dmg = (random _maxDamage) / 100;
                                _veh setHitPointDamage [_x, _dmg];
                            };
                        }
                        forEach _hitpoints;
                    };
                };
                
                if (_randomFuelEnabled)
                then {
                    _fuelAmount = (random _maxFuel) / 100;
                    _veh setFuel _fuelAmount;
                };
                
                _vehMarkerName = format["%1%2%3%4%5", _vehicleName, "|", _forEachIndex, _n, random 1000];
                _veh setVariable ["VehicleName", _vehMarkerName, true];
                
                if (_showVehMarkers)
                then {
                    _vehmark = createMarker [_vehMarkerName, _tempPos];
                    _vehmark setMarkerText _vehMarkerName;
                    _vehmark setMarkerShape "ICON";
                    _vehmark setMarkerType "hd_dot";
                    _vehmark setMarkerColor "ColorBlue";
                };
                if (_addLoot)
                then {
                    [_veh, true, _spawnWeapons, _spawnItems, _spawnClothes, _spawnBackpacksVests] call B52_Random_Vehicles_Module_fnc_addLootToVehicle;
                };
            };
        };
        
        
    };
}foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter","NameLocal"], 35000]) + _whiteListMkrs;
