class CfgPatches
{
    class B52_Random_Vehicles
    {
        name      = "Badca52's Random Vehicles";
        author    = "Badca52";
        authorUrl = "https://github.com/Badca52";

        version         = "0.22";
        requiredVersion = 0.22;
        requiredAddons[] = {"cba_main"};
    };
};

class CfgFunctions
{
    #include "CfgFunctions.hpp"
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class B52: NO_CATEGORY
    {
        displayName = "B52";
    };
};

#include "CfgVehicles.hpp"