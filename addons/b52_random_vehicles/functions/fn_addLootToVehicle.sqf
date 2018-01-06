private ["_vehicle","_type","_amount","_spawnWeapons","_spawnItems","_spawnClothes","_spawnBackpacksVests","_lootTypes",
"_lootTypeCount","_rndNum","_item","_weaponType","_weapon","_magazines","_magazineClass","_rndMagazineNum"];
_vehicle    = _this select 0;
_clearCargo = _this select 1;

// Loot Types
_spawnWeapons        = _this select 2;
_spawnItems          = _this select 3;
_spawnClothes        = _this select 4;
_spawnBackpacksVests = _this select 5;

_lootTypes = [];

if (_spawnItems)
then {
    _lootTypes pushBack "item";
};

if (_spawnClothes)
then {
    _lootTypes pushBack "clothing";
};

if (_spawnBackpacksVests)
then {
    _lootTypes pushBack "vest";
    _lootTypes pushBack "backpack";
};

if (_spawnWeapons)
then {
    _lootTypes pushBack "weapon";
};

if (!(isNil "_clearCargo") && _clearCargo)
then {
    clearItemCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
};
_amount = random 5;

for "_i" from 1 to _amount
do {
    _lootTypeCount = count _lootTypes;
    _rndNum        = floor random _lootTypeCount;
    _type          = _lootTypes select _rndNum;
    
    if (_type == "item")
    then {
        _item = B52_Items call bis_fnc_selectRandom;
        _vehicle addItemCargoGlobal [_item, 1];
    };
    
    if (_type == "clothing")
    then {
        _item = B52_Clothes call bis_fnc_selectRandom;
        _vehicle addItemCargoGlobal [_item, 1];
    };
    
    if (_type == "vest")
    then {
        _item = B52_Vests call bis_fnc_selectRandom;
        _vehicle addItemCargoGlobal [_item, 1];
    };
    
    if (_type == "backpack")
    then {
        _item = B52_Backpacks call bis_fnc_selectRandom;
        _vehicle addBackpackCargoGlobal [_item, 1];
    };
    
    if (_type == "weapon")
    then {
        _weaponType = B52_WeaponTypes call bis_fnc_selectRandom;
        _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
        
        switch (_weaponType) do {
            case "AssaultRifle": { 
                _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
            };
            case "Handgun": { 
                _weapon = B52_Handguns call bis_fnc_selectRandom;
            };
            case "MachineGun": { 
                _weapon = B52_MachineGuns call bis_fnc_selectRandom;
            };
            case "MissileLauncher": { 
                _weapon = B52_MissleLaunchers call bis_fnc_selectRandom;
            };
            case "RocketLauncher": { 
                _weapon = B52_RocketLaunchers call bis_fnc_selectRandom;
            };
            case "Rifle": { 
                _weapon = B52_AssaultRiflesG call bis_fnc_selectRandom;
            };
            case "SubmachineGun": { 
                _weapon = B52_SubmachineGuns call bis_fnc_selectRandom;
            };
            case "SniperRifle": { 
                _weapon = B52_SniperRifles call bis_fnc_selectRandom;
            };
            default { 
                _weapon = B52_AssaultRifles call bis_fnc_selectRandom;
            };
        };
        
        _magazines     = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
        _magazineClass = _magazines call bis_fnc_selectRandom;
        
        _rndMagazineNum = ceil (random 2);
        _vehicle addWeaponCargoGlobal [_weapon, 1];
        _vehicle addMagazineCargoGlobal [_magazineClass, _rndMagazineNum];
    };
    
};