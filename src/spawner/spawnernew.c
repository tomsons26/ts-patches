#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "TiberianSun.h"
#include <winsock2.h>


extern void __fastcall Call_Back();

bool Load_SPAWN_INI()
{
    FileClass file;

    FileClass__FileClass(&file, "SPAWN.INI");
    if ( !FileClass__Is_Available(&file, false) ) {
        return false;
    }

    INIClass__INIClass(INIClass_SPAWN);
    INIClass__Load(INIClass_SPAWN, file);
    return true;
}

int HouseCountriesArray[8];
int HouseColorsArray[8];
int SpawnLocationsArray[8];
int HouseHandicapsArray[8];
extern DynamicVectorClass_Houses HouseClassArray;
extern size_t HouseClassArray_Count;
extern size_t HumanPlayers;


extern void Load_House_Countries_Spawner()
{
    HouseCountriesArray[0] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi1", -1);
    HouseCountriesArray[1] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi2", -1);
    HouseCountriesArray[2] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi3", -1);
    HouseCountriesArray[3] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi4", -1);
    HouseCountriesArray[4] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi5", -1);
    HouseCountriesArray[5] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi6", -1);
    HouseCountriesArray[6] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi7", -1);
    HouseCountriesArray[7] = INIClass__GetInt(INIClass_SPAWN, "HouseCountries", "Multi8", -1);
}

extern void __thiscall Load_House_Colors_Spawner()
{
    HouseColorsArray[0] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi1", -1);
    HouseColorsArray[1] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi2", -1);
    HouseColorsArray[2] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi3", -1);
    HouseColorsArray[3] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi4", -1);
    HouseColorsArray[4] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi5", -1);
    HouseColorsArray[5] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi6", -1);
    HouseColorsArray[6] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi7", -1);
    HouseColorsArray[7] = INIClass__GetInt(INIClass_SPAWN, "HouseColors", "Multi8", -1);
}

extern void Load_Spawn_Locations_Spawner()
{
    SpawnLocationsArray[0] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi1", -1);
    SpawnLocationsArray[1] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi2", -1);
    SpawnLocationsArray[2] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi3", -1);
    SpawnLocationsArray[3] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi4", -1);
    SpawnLocationsArray[4] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi5", -1);
    SpawnLocationsArray[5] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi6", -1);
    SpawnLocationsArray[6] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi7", -1);
    SpawnLocationsArray[7] = INIClass__GetInt(INIClass_SPAWN, "SpawnLocations", "Multi8", -1);
}

extern void Load_House_Handicaps_Spawner()
{
    HouseHandicapsArray[0] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi1", -1);
    HouseHandicapsArray[1] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi2", -1);
    HouseHandicapsArray[2] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi3", -1);
    HouseHandicapsArray[3] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi4", -1);
    HouseHandicapsArray[4] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi5", -1);
    HouseHandicapsArray[5] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi6", -1);
    HouseHandicapsArray[6] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi7", -1);
    HouseHandicapsArray[7] = INIClass__GetInt(INIClass_SPAWN, "HouseHandicaps", "Multi8", -1);
}

extern void Load_Spectators_Spawner()
{
    IsSpectatorArray[0] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi1", -1);
    IsSpectatorArray[1] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi2", -1);
    IsSpectatorArray[2] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi3", -1);
    IsSpectatorArray[3] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi4", -1);
    IsSpectatorArray[4] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi5", -1);
    IsSpectatorArray[5] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi6", -1);
    IsSpectatorArray[6] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi7", -1);
    IsSpectatorArray[7] = INIClass__GetInt(INIClass_SPAWN, "IsSpectator", "Multi8", -1);
}

typedef WINSOCK_API_LINKAGE IN_ADDR (PASCAL *inet_addr_function)(const char *cp);
inet_addr_function inet_addr_;

int32_t IsSpawnArgPresent;

extern int32_t PortHack;
int32_t SpawnerCheck;
extern bool    GameActive;
extern int32_t UnitCount;
extern int32_t TechLevel;
extern int32_t AIPlayers;
extern int32_t AIDifficulty;
extern bool    BuildOffAlly;
extern bool    SuperWeapons;
extern bool    HarvesterTruce;
extern bool    BridgeDestroy;
extern bool    FogOfWar;
extern bool    Crates;
extern bool    ShortGame;
extern bool    Bases;
extern bool    MCVRedeploy;
extern int32_t Credits;
extern int32_t GameSpeed;
extern bool    MultiEngineer;
extern bool    AlliesAllowed;
extern char    UIMapName;
extern uint32_t TunnelIp;
extern uint16_t TunnelPort;
extern uint32_t TunnelId;
extern uint16_t ListenPort;
extern char     ScenarioName;
extern uint32_t Seed;
extern void *   GameMode;
extern int32_t  NameNodes_CurrentSize;
extern bool     SkipScoreScreen;
extern bool     InScenario1;
extern bool     InScenario2;
extern bool     InScenario2;
extern int32_t  Tournament;
bool AllyBySpawnLocation;
extern bool SharedControl;
extern bool AimableSams;
extern bool IntegrateMumbleSpawn;
extern bool AttackNeutralUnits;
extern bool ScrapMetal;
extern bool AutoDeployMCV;
extern bool SkipScoreScreen;
extern bool QuickMatch;
extern bool CoachMode;
extern bool SavesDisabled;
extern int AutoSaveGame;
extern int32_t AutoSaveGame;
extern int32_t NextAutoSave;
extern void *WinsockInterface_this;
extern int RequestedFPS;
extern int32_t LatencyFudge;
extern int32_t MaxMaxAhead;

extern bool InScenario1;
extern bool InScenario2;

char CustomLoadScreen[256];
char MapHash[256];

extern int TiberianSunMode;
extern int FirestormMode;

void Add_Human_Player();
void Add_Human_Opponents();
void Init_Random();
void * __thiscall UDPInterfaceClass__UDPInterfaceClass(void *this);
void __thiscall WinsockInterfaceClass__Init(void *this);
void __thiscall UDPInterfaceClass__Open_Socket(void *this);
void __thiscall WinsockInterfaceClass__Discard_In_Buffers(void *this);
void __thiscall WinsockInterfaceClass__Discard_Out_Buffers(void *this);
void __thiscall WinsockInterfaceClass__Start_Listening(void *this);

void __thiscall IPXManagerClass__Set_Timing(void *this, int32_t a1, int32_t a2, int32_t a3, int32_t a4);
bool __fastcall Load_Game(char*);
void __thiscall SessionClass__Read_Scenario_Descriptions(void *this);
int __thiscall SidebarClass__Activate(void *this, int);

int Initialize_Spawn()
{
    if ( !IsSpawnArgPresent ) {
        return -1;
    }

    if (SpawnerActive) {
        return 0;
    }
    
    SpawnerActive = 1;
    PortHack = 1;

    if (!Load_SPAWN_INI()) {
        return -1;
    }

    HMODULE wsock = LoadLibraryA("wsock32.dll");
    //inet_addr_ = (inet_addr_function)GetProcAddress(wsock, "inet_addr");

    Load_House_Colors_Spawner();
    Load_House_Countries_Spawner();
    Load_House_Handicaps_Spawner();
    Load_Spawn_Locations_Spawner();
    Load_Spectators_Spawner();
    
    GameActive = 1;
    SessionType = 5;

    WOLGameID =             INIClass__GetInt(INIClass_SPAWN, "Settings", "GameID", 0);
    UnitCount =             INIClass__GetInt(INIClass_SPAWN, "Settings", "UnitCount", 1);
    TechLevel =             INIClass__GetInt(INIClass_SPAWN, "Settings", "TechLevel", 10);
    AIPlayers =             INIClass__GetInt(INIClass_SPAWN, "Settings", "AIPlayers", 0);
    AIDifficulty =          INIClass__GetInt(INIClass_SPAWN, "Settings", "AIDifficulty", 1);
    HarvesterTruce =        INIClass__GetBool(INIClass_SPAWN, "Settings", "HarvesterTruce", 0);
    BridgeDestroy =         INIClass__GetBool(INIClass_SPAWN, "Settings", "BridgeDestroy", 1);
    FogOfWar =              INIClass__GetBool(INIClass_SPAWN, "Settings", "FogOfWar", 0);
    BuildOffAlly =          INIClass__GetBool(INIClass_SPAWN, "Settings", "BuildOffAlly", 0);
    Crates =                INIClass__GetBool(INIClass_SPAWN, "Settings", "Crates", 0);
    ShortGame =             INIClass__GetBool(INIClass_SPAWN, "Settings", "ShortGame", 0);
    Bases =                 INIClass__GetBool(INIClass_SPAWN, "Settings", "Bases", 1);
    AlliesAllowed =         INIClass__GetBool(INIClass_SPAWN, "Settings", "AlliesAllowed", 1);
    SharedControl =         INIClass__GetBool(INIClass_SPAWN, "Settings", "SharedControl", 0);
    MCVRedeploy =           INIClass__GetBool(INIClass_SPAWN, "Settings", "MCVRedeploy", 1);
    Credits =               INIClass__GetInt(INIClass_SPAWN, "Settings", "Credits", 10000);
    GameSpeed =             INIClass__GetInt(INIClass_SPAWN, "Settings", "GameSpeed", 0);
    MultiEngineer =         INIClass__GetBool(INIClass_SPAWN, "Settings", "MultiEngineer", 0);
    IsHost =                INIClass__GetBool(INIClass_SPAWN, "Settings", "Host", 0);
    AllyBySpawnLocation =   INIClass__GetBool(INIClass_SPAWN, "Settings", "AllyBySpawnLocation", 0);
    RunAutoSS =             INIClass__GetBool(INIClass_SPAWN, "Settings", "RunAutoSS", 0);
    AutoSaveGame =          INIClass__GetInt(INIClass_SPAWN, "Settings", "AutoSaveGame", -1);

    AimableSams =           INIClass__GetBool(INIClass_SPAWN, "Settings", "AimableSams", 0);
    IntegrateMumbleSpawn =  INIClass__GetBool(INIClass_SPAWN, "Settings", "IntegrateMumble", 0);
    AttackNeutralUnits =    INIClass__GetBool(INIClass_SPAWN, "Settings", "AttackNeutralUnits", 0);
    ScrapMetal =            INIClass__GetBool(INIClass_SPAWN, "Settings", "ScrapMetal", 0);
    AutoDeployMCV =         INIClass__GetBool(INIClass_SPAWN, "Settings", "AutoDeployMCV", 0);
    SkipScoreScreen =       INIClass__GetBool(INIClass_SPAWN, "Settings", "SkipScoreScreen", SkipScoreScreen);
    QuickMatch =            INIClass__GetBool(INIClass_SPAWN, "Settings", "QuickMatch", 0);
    CoachMode =             INIClass__GetBool(INIClass_SPAWN, "Settings", "CoachMode", 0);

    INIClass__GetString(INIClass_SPAWN, "Settings", "MapHash", "", MapHash, 256);
    INIClass__GetString(INIClass_SPAWN, "Settings", "CustomLoadScreen", "", CustomLoadScreen, 255);

    NextAutoSave = AutoSaveGame;
    SavesDisabled = 0;
    
    char ip_string[32];
    INIClass__GetString(INIClass_SPAWN, "Tunnel", "Ip", "0.0.0.0", ip_string, sizeof(ip_string));
    
    //undefined reference to `_imp__inet_addr@4'
    //TunnelIp = (uint32_t)inet_addr(ip_string);
    int32_t p = INIClass__GetInt(INIClass_SPAWN, "Tunnel", "Port", 0);
    TunnelPort = htons(p);

    p = INIClass__GetInt(INIClass_SPAWN, "Settings", "Port", 0);
    TunnelId = htons(p);

    if ( TunnelPort ) {
        ListenPort = 0;
    } else {
        ListenPort = INIClass__GetInt(INIClass_SPAWN, "Settings", "Port", 1234);
    }

    if ( INIClass__GetBool(INIClass_SPAWN, "Settings", "Firestorm", 0) ) {
        TiberianSunMode = 1 | 2;
        FirestormMode = 1 | 2;
    }
    
    SessionClass__Read_Scenario_Descriptions(&SessionClass_this);

    INIClass__GetString(INIClass_SPAWN, "Settings", "Scenario", "", &ScenarioName, 0x20);
    
    //////Add_Human_Player();
    ////Add_Human_Opponents();

    if ( INIClass__GetBool(INIClass_SPAWN, "Settings", "IsSinglePlayer", 0) ) {
        SessionType = 0;
    }

    Seed = INIClass__GetInt(INIClass_SPAWN, "Settings", "Seed", 0);
    Init_Random();
    
    WinsockInterface_this = UDPInterfaceClass__UDPInterfaceClass(new(0x35088));
    WinsockInterfaceClass__Init(WinsockInterface_this);
    UDPInterfaceClass__Open_Socket(WinsockInterface_this);
    WinsockInterfaceClass__Start_Listening(WinsockInterface_this);
    WinsockInterfaceClass__Discard_In_Buffers(WinsockInterface_this);
    WinsockInterfaceClass__Discard_Out_Buffers(WinsockInterface_this);
    IPXManagerClass__Set_Timing(&IPXManagerClass_this, 60, -1, 600, 1);

    ProtocolVersion = INIClass__GetInt(INIClass_SPAWN, "Settings", "Protocol", 2);
    RequestedFPS = 60;
    
    if ( ProtocolVersion ) {
        FrameSendRate = INIClass__GetInt(INIClass_SPAWN, "Settings", "FrameSendRate", 5);
        MaxAhead = FrameSendRate * FrameSendRate;
        MaxAhead = INIClass__GetInt(INIClass_SPAWN, "Settings", "MaxAhead", FrameSendRate * FrameSendRate);
    } else {
        ProtocolVersion = 2;
        UseProtocolZero = 1;
        FrameSendRate = 1;
        MaxAhead = INIClass__GetInt(INIClass_SPAWN, "Settings", "MaxAhead", 40);
        PreCalcMaxAhead = INIClass__GetInt(INIClass_SPAWN, "Settings", "PreCalcMaxAhead", 0);
        if ( PreCalcMaxAhead )
        {
            PreCalcFrameRate = INIClass__GetInt(INIClass_SPAWN, "Settings", "PreCalcFrameRate", RequestedFPS);
        }
    }

    MaxMaxAhead = 0;
    LatencyFudge = 0;

    Init_Network();
    
    HumanPlayers = NameNodes_CurrentSize;

    if ( INIClass__GetBool(INIClass_SPAWN, "Settings", "LoadSaveGame", 0) ) {
        char SaveGameNameBuf[60];
        INIClass__GetString(INIClass_SPAWN, "Settings", "SaveGameName", "", SaveGameNameBuf, sizeof(SaveGameNameBuf));
        InScenario1 = 0;
        InScenario2 = 0;
        //Start_Scenario(&ScenarioName, 0, -1); not actaully needed seems, doesn't work anyway
        Load_Game(SaveGameNameBuf);
    } else {
        if ( SessionType )
        {
            Start_Scenario(&ScenarioName, 0, -1);// correct
        }
        else
        {
            Start_Scenario(&ScenarioName, 1, 0);
        }
        
        //wtf
        //v4 = v74C488;
        //v10 = *(v74C488 + 0x2B4);
        //v9 = *(v74C488 + 0x2B0);
        //v8 = "MultipleFactory";
        //v7 = "Settings";
        //*(v4 + 0x2B0) = INIClass__GetFixed(INIClass_SPAWN);
    }
    
    if ( SessionType == 4 )
    {
        SessionType = 3;
    }

    SessionClass__Create_Connections(&SessionClass_this);
    IPXManagerClass__Set_Timing(&IPXManagerClass_this, 60, -1, 600, 1);
    /*
    (*(*WWMouseClas_Mouse + 0xC))();
    (*(*HiddenSurface + 0x18))(0);

    GScreenClass__Do_Blit(1, DSurface_Hidden, 0);
    (*(*WWMouseClas_Mouse + 0x10))(0);
    
    TempSurface = HiddenSurface;
    
    MouseClass_Override_Mouse_Shape(&MouseClass_Map, 19, 0); //wat
    MouseClass__Revert_Mouse_Shape(&MouseClass_Map);
    */
    SidebarClass__Activate(&MouseClass_Map, 1);
    GScreenClass__Flag_To_Redraw(&MouseClass_Map, 0);
    Call_Back();
    

    return true;
}

bool __fastcall Select_Game(int val);

CALL(0X004629D1, _Select_Game_Init_Spawner);
CALL(0X00462B8B, _Select_Game_Init_Spawner);


int UsedSpawnsArray[8];

void Init_Game_Spawner()
{
    memset(&UsedSpawnsArray, -1, sizeof(UsedSpawnsArray));
}

bool Select_Game_Init_Spawner(int val)
{    
    // eh? the originla function dealt with bools........
    int result = Initialize_Spawn();
    if ( result != -1 )
    {
        return result;
    }
    return Select_Game(val);
}

CALL(0x004E3460, _Parse_Spawn_Command_Line);

bool __fastcall Parse_Command_Line(int, char **);
//This overwrites the call to the Parse_Command_Line in WinMain
//the bool it returns is the decider for the game whether to to continue or not
bool __fastcall Parse_Spawn_Command_Line(int a1, char** args)
{
	//If the spawn string exists set the spawner bools and call the real Parse_Command_Line.
    if (strstr(GetCommandLineA(), "-SPAWN") != NULL)
    {
        IsSpawnArgPresent = 1;
        SpawnerCheck = 1;
        //Calls the real command line checking function
        return Parse_Command_Line(a1, args);
    }
    else
    {
    	//If spawner CMD isnt there then show this message and tell the game to bail
        char* message = "This version of Tiberian Sun only supports online play using CnCNet 5 (www.cncnet.org)\n";
        MessageBox(NULL, message, "Tiberian Sun", MB_OK | MB_ICONEXCLAMATION);
        return 0;
    }
}



CALL(0x005ED477, _Read_Scenario_Descriptions);

//replaces a Read_Scenario_Descriptions call
void __thiscall Read_Scenario_Descriptions(void *this)
{
    if (!IsSpawnArgPresent){
        SessionClass__Read_Scenario_Descriptions(this);
    }
    
}

extern void __thiscall Progress_5AD9A0(void *this, char *progshape, char *bg, char *str, int pos1, int pos2);
CALL(0x005DBD33, _Progress_5AD9A0_Wrapper);
//custom loadscreen
void __thiscall Progress_5AD9A0_Wrapper(void *this, char *bar, char *bg, char *str, int pos1, int pos2)
{
    if (CustomLoadScreen[0] != 0) {
        bg = CustomLoadScreen;
    }
    Progress_5AD9A0(this, bar, bg, str, pos1, pos2);
}