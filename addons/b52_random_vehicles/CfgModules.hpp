#define true 1
#define false 0

class Logic;
class Module_F : Logic
{
    class AttributesBase
    {
        class Default;
        class Edit;
        class Combo;
    };
};

class B52_Random_Vehicles_Module : Module_F
{
    scope              = 2;
    author             = "Badca52";
    displayName        = "B52 Random Vehicles";
    category           = "B52";
    function           = "B52_Random_Vehicles_Module_fnc_init";
    icon               = "\b52_random_vehicles\52.paa";
    functionPriority   = 2;
    isGlobal           = 0;
    isTriggerActivated = 0;
    
    class Attributes : AttributesBase
    {
        class VehicleModifier : Edit
        {
            property     = "VehicleModifier";
            displayName  = "# per Town";
            description  = "Number of Vehicles per Town. Setting this value too high can drastically effect performance.";
            typeName     = "NUMBER";
            defaultValue = "2";
        };
        
        class ShowMarkers : Combo
        {
            property     = "ShowMarkers";
            displayName  = "Show Markers";
            description  = "Shows location of vehicles spawned on map";
            typeName     = "BOOL";
            defaultValue = "false";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        
        class AddLoot : Combo
        {
            property     = "AddLoot";
            displayName  = "Add Loot";
            description  = "Spawns vehicles with random loot";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        
        class MaxDamage : Edit
        {
            property     = "MaxDamage";
            displayName  = "Max Damage";
            description  = "Maxiumum amount of damage that can be applied to a vehicle";
            typeName     = "NUMBER";
            defaultValue = "75";
        };
        
        class DamageEnabled : Combo
        {
            property     = "DamageEnabled";
            displayName  = "Damage";
            description  = "Determines if vehicles will spawn with a chance of damage";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        
        class DamageChance : Edit
        {
            property     = "DamageChance";
            displayName  = "Damage Chance";
            description  = "Percent chance of a vehicle being damaged";
            typeName     = "NUMBER";
            defaultValue = "75";
        };
        
        class RandomFuelEnabled : Combo
        {
            property     = "RandomFuelEnabled";
            displayName  = "Random Fuel";
            description  = "Determines if vehicles will spawn a random amount of fuel";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        
        class MaxFuel : Edit
        {
            property     = "MaxFuel";
            displayName  = "Max Fuel";
            description  = "Maximum amount of fuel a vehicle can be spawned with";
            typeName     = "NUMBER";
            defaultValue = "75";
        };
        
        
        class SpawnWeapons : Combo
        {
            property     = "SpawnWeapons";
            displayName  = "Spawn Weapons";
            description  = "If true vehicles will have a chance to spawn with weapons";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        class SpawnItems : Combo
        {
            property     = "SpawnItems";
            displayName  = "Spawn Items";
            description  = "If true vehicles will have a chance to spawn with items";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        class SpawnClothes : Combo
        {
            property     = "SpawnClothes";
            displayName  = "Spawn Clothes";
            description  = "If true vehicles will have a chance to spawn with clothes";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
        class SpawnBackpacksVests : Combo
        {
            property     = "SpawnBackpacksVests";
            displayName  = "Spawn Backpacks and Vests";
            description  = "If true vehicles will have a chance to spawn with backpacks and vests";
            typeName     = "BOOL";
            defaultValue = "true";
            
            class Values
            {
                class Enable
                {
                    name  = "Enabled";
                    value = true;
                };
                class Disable
                {
                    name = "Disabled";
                    value = false;
                };
            };
        };
    };
};
