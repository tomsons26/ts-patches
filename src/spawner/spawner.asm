%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "ini.inc"

cglobal SpawnerActive
cglobal INIClass_SPAWN
cglobal SpawnLocationsArray
cglobal SpawnLocationsHouses

gbool SavesDisabled, true
gbool QuickMatch, false
gbool IsHost, true

cextern Initialize_Spawn
cextern Init_Game_Spawner
cextern PortHack
cextern BuildOffAlly
cextern TunnelIp
cextern TunnelPort
cextern TunnelId
cextern UsedSpawnsArray
cextern IsSpectatorArray
cextern RunAutoSS
cextern AimableSams
cextern IntegrateMumbleSpawn
cextern AttackNeutralUnits
cextern ScrapMetal
cextern AutoDeployMCV
cextern SharedControl
cextern SkipScoreScreen
cextern AutoSurrender
cextern IsSpawnArgPresent
cextern AllyBySpawnLocation

@LJMP 0x00609470, _Send_Statistics_Packet_Return_If_Skirmish
@LJMP 0x005E08E3, _Read_Scenario_INI_Assign_Houses_And_Spawner_House_Settings
@LJMP 0x004BDDB1, _HouseClass__Make_Ally_STFU_when_Allying_In_Loading_Screen_Spawner

; Inside HouseClass::Mplayer_Defeated skip some checks which makes game continue
; even if there are only allied AI players left, in skirmish
@LJMP 0x004BF7B6, 0x004BF7BF
@LJMP 0x004BF7F0, 0x004BF7F9

@LJMP 0x004C06EF, _HouseClass__AI_Attack_Stuff_Alliance_Check

@LJMP 0x005DE3D7, _Assign_Houses_AI_Countries

@LJMP 0x004C3630, _HouseClass__Computer_Paranoid_Disable_With_Spawner

@LJMP 0x005DDAF1, _Read_Scenario_INI_Dont_Create_Units_Earlier
@LJMP 0x005DDEDD, _Read_Scenario_INI_Dont_Create_Units_Earlier_Dont_Create_Twice
@LJMP 0x0065860D, _UnitClass__Read_INI_Jump_Out_When_Units_Section_Missing
@LJMP 0x005DD523, _Read_Scenario_INI_Fix_Spawner_DifficultyMode_Setting

;always write mp stats
@CLEAR 0x0046353C, 0x90, 0x00463542

section .bss
    SpawnerActive              RESD 1
    INIClass_SPAWN             RESB 256 ; FIXME: make this a local variable
    inet_addr                  RESD 1

    IsDoingAlliancesSpawner    RESB 1
    HouseColorsArray           RESD 8
    HouseCountriesArray        RESD 8
    HouseHandicapsArray        RESD 8
    SpawnLocationsArray        RESD 8
    SpawnLocationsHouses       RESD 8

    SaveGameNameBuf            RESB 60

    DoingAutoSS                RESD 1
    Anticheat1                 RESD 1
    AntiCheatArray             RESB (StripClass_Size * 2)

    SpectatorStuffInit         RESB 1
    OldUnitClassArrayCount     RESD 1

    CustomLoadScreen           RESB 256

    SaveGameLoadPathWide       RESB 512
    SaveGameLoadPath           RESB 256
    SpawnerTeamName            RESB 128

gstring MapHash, "", 256

section .rdata
    str_NoWindowFrame db "NoWindowFrame",0
    str_kernel32dll db "Kernel32.dll",0
    str_SetProcessAffinityMask db "SetProcessAffinityMask",0
    str_SingleProcAffinity db "SingleProcAffinity",0
    str_GameID          db "GameID", 0
    str_gcanyonmap      db "blitz_test.map", 0
    str_debugplayer     db "debugplayer",0
    str_debugplayer2    db "debugplayer2",0
    str_wsock32_dll     db "wsock32.dll",0
    str_inet_addr       db "inet_addr",0
    str_localhost       db "127.0.0.1",0
    str_spawn_ini       db "SPAWN.INI",0
    str_Settings        db "Settings",0
    str_UnitCount       db "UnitCount",0
    str_Scenario        db "Scenario",0
    str_Empty           db "",0
    str_GameSpeed       db "GameSpeed",0
    str_Seed            db "Seed",0
    str_TechLevel       db "TechLevel",0
    str_AIPlayers       db "AIPlayers",0
    str_AIDifficulty    db "AIDifficulty",0
    str_HarvesterTruce  db "HarvesterTruce",0
    str_BridgeDestroy   db "BridgeDestroy",0
    str_FogOfWar        db "FogOfWar",0
    str_EasyShroud      db "EasyShroud",0
    str_Crates          db "Crates",0
    str_ShortGame       db "ShortGame",0
    str_Bases           db "Bases",0
    str_MCVRedeploy     db "MCVRedeploy",0
    str_Credits         db "Credits",0
    str_Name            db "Name",0
    str_Side            db "Side",0
    str_Color           db "Color",0
    str_OtherSectionFmt db "Other%d",0
    str_Port            db "Port",0
    str_Ip              db "Ip",0
    str_SpawnArg        db "-SPAWN",0
    str_MultiEngineer   db "MultiEngineer",0
    str_Firestorm       db "Firestorm",0
    str_HouseColors     db "HouseColors",0
    str_HouseCountries  db "HouseCountries",0
    str_HouseHandicaps  db "HouseHandicaps",0
    str_Tunnel          db "Tunnel",0
    str_SpawnLocations  db "SpawnLocations",0
    str_IsSinglePlayer  db "IsSinglePlayer",0
    str_LoadSaveGame    db "LoadSaveGame",0
    str_SaveGameName    db "SaveGameName",0
    str_MultipleFactory db "MultipleFactory",0
    str_AlliesAllowed   db "AlliesAllowed",0
    str_MapHash         db "MapHash",0
    str_SharedControl   db "SharedControl",0
    str_SidebarHack     db "SidebarHack",0
    str_BuildOffAlly    db "BuildOffAlly",0
    str_CustomLoadScreen db "CustomLoadScreen",0
    str_Host             db "Host",0
    str_FrameSendRate    db "FrameSendRate",0
    str_MaxAhead        db "MaxAhead",0
    str_PreCalcMaxAhead db "PreCalcMaxAhead",0
    str_PreCalcFrameRate db "PreCalcFrameRate",0
    str_Protocol        db "Protocol", 0
    str_RunAutoSS       db "RunAutoSS",0
    str_AutoSaveGame    db "AutoSaveGame", 0
    str_TeamName        db "TeamName",0
    str_AimableSams     db "AimableSams",0
    str_IntegrateMumble db "IntegrateMumble",0
    str_AttackNeutralUnits db "AttackNeutralUnits", 0
    str_ScrapMetal      db "ScrapMetal",0
    str_AutoDeployMCV   db "AutoDeployMCV",0
    str_SkipScoreScreen db "SkipScoreScreen",0
    str_QuickMatch      db "QuickMatch",0
    str_CoachMode       db "CoachMode",0
    str_AutoSurrender   db "AutoSurrender",0
    str_GameNameTitle   db "Tiberian Sun",0
    str_PleaseRunClient db "Please run the game client instead.",0

    str_DifficultyModeComputer db "DifficultyModeComputer",0
    str_DifficultyModeHuman db "DifficultyModeHuman",0

    str_Multi1          db "Multi1",0
    str_Multi2          db "Multi2",0
    str_Multi3          db "Multi3",0
    str_Multi4          db "Multi4",0
    str_Multi5          db "Multi5",0
    str_Multi6          db "Multi6",0
    str_Multi7          db "Multi7",0
    str_Multi8          db "Multi8",0

    str_HouseAllyOne 		db "HouseAllyOne",0
    str_HouseAllyTwo 		db "HouseAllyTwo",0
    str_HouseAllyThree 		db "HouseAllyThree",0
    str_HouseAllyFour 		db "HouseAllyFour",0
    str_HouseAllyFive 		db "HouseAllyFive",0
    str_HouseAllySix 		db "HouseAllySix",0
    str_HouseAllySeven	 	db "HouseAllySeven",0

    str_Multi1_Alliances db "Multi1_Alliances",0
    str_Multi2_Alliances db "Multi2_Alliances",0
    str_Multi3_Alliances db "Multi3_Alliances",0
    str_Multi4_Alliances db "Multi4_Alliances",0
    str_Multi5_Alliances db "Multi5_Alliances",0
    str_Multi6_Alliances db "Multi6_Alliances",0
    str_Multi7_Alliances db "Multi7_Alliances",0
    str_Multi8_Alliances db "Multi8_Alliances",0

    str_Spawn1              db "Spawn1",0
    str_Spawn2              db "Spawn2",0
    str_Spawn3              db "Spawn3",0
    str_Spawn4              db "Spawn4",0
    str_Spawn5              db "Spawn5",0
    str_Spawn6              db "Spawn6",0
    str_Spawn7              db "Spawn7",0
    str_Spawn8              db "Spawn8",0

    str_AllyBySpawnLocation db "AllyBySpawnLocation",0
    str_message_fmt db "%s: %s",0

    str_AutoSSFileNameFormat db"AUTOSS\\AutoSS-%d-%d_%d.PCX",0
    str_AutoSSDir db"./AutoSS",0

    str_UseGraphicsPatch: db "UseGraphicsPatch",0

    str_ForceLowestDetailLevel db"ForceLowestDetailLevel",0
    str_InvisibleSouthDisruptorWave db"InvisibleSouthDisruptorWave",0

    str_Video_Windowed: db"Video.Windowed",0
    str_Video_WindowedScreenHeight db"Video.WindowedScreenHeight",0
    str_Video_WindowedScreenWidth db"Video.WindowedScreenWidth",0

    str_InternetDisabled db"This version of Tiberian Sun only supports online play on CnCNet 5  (www.cncnet.org)",0

    str_NoCD db"NoCD",0

    str_SaveGameLoadFolder      db"Saved Games\%s",0,0,0,0,0,0,0,0
    str_SaveGameFolderFormat    db"Saved Games\*.%3s",0
    str_SaveGameFolderFormat2   db"Saved Games\SAVE%04lX.%3s",0
    str_SaveGamesFolder        db"Saved Games",0

    str_bue_li24_pcx      db"bue_li24.pcx",0
    str_bue_mi24_pcx      db"bue_mi24.pcx",0
    str_bue_ri24_pcx      db"bue_ri24.pcx",0

section .text

_Read_Scenario_INI_Fix_Spawner_DifficultyMode_Setting:
    cmp dword [IsSpawnArgPresent], 0
    jz  .Ret

    cmp dword [SessionType], 0
    jnz .Ret

    pushad

    SpawnINI_Get_Bool str_Settings, str_IsSinglePlayer, 0
    cmp al, 0
    jz .out
    SpawnINI_Get_Int str_Settings, str_DifficultyModeComputer, 1
    push eax

    SpawnINI_Get_Int str_Settings, str_DifficultyModeHuman, 1

    pop edx
    mov ebx, [ScenarioStuff]

    mov dword [ebx+0x60C], edx ; DifficultyModeComputer
    mov dword [ebx+0x608], eax ; DifficultyModeHuman
    mov dword [SelectedDifficulty], eax

.out:
    popad

.Ret:
    ; The 2 commented-out lines below cause the difficulty level to change to
    ; Normal after completing a mission from a loaded campaign save
    ;mov eax, dword [SelectedDifficulty]
    ;mov dword [0x7a2f0c], eax
    mov eax, [ScenarioStuff]
    jmp 0x005DD528

_UnitClass__Read_INI_Jump_Out_When_Units_Section_Missing:
    cmp eax, ebx
    jle .Jump_Out

    jmp 0x00658613

.Jump_Out:
    jmp 0x00658A10

_Read_Scenario_INI_Dont_Create_Units_Earlier:
    call 0x0058C980

    push    eax
    push    ebp
    call    _read_tut_from_map
    pop     eax

    cmp dword [SessionType], 0
    jz  .Ret

    push    0
    push    0x0070CAA8 ; offset aOfficial ; "Official"
    push    0x007020A8 ; offset aBasic   ; "Basic"
    mov     ecx, ebp
    call    INIClass__GetBool
    mov     cl, al
    call    0x005DD290 ; Create_Units(int)

    push    ebp
    call    _ally_by_spawn_location

    call    initMumble

.Ret:
    jmp 0x005DDAF6


_Read_Scenario_INI_Dont_Create_Units_Earlier_Dont_Create_Twice:
    jmp 0x005DDEF8

_HouseClass__Computer_Paranoid_Disable_With_Spawner:
    cmp dword [IsSpawnArgPresent], 1
    jz  .Ret

.Normal_Code:
    mov ecx, [HouseClassArray_Count]
    jmp 0x004C3636

.Ret:
    jmp 0x004C3700 ; jump to RETN instruction

_Assign_Houses_AI_Countries:
    mov ebp, [HouseClassArray_Count]
    cmp dword [HouseCountriesArray+ebp*4], -1
    jz  .Ret

    mov ecx, [HouseCountriesArray+ebp*4]
    mov ecx,[edx+ecx*4]

.Ret:
    push ecx
    mov ecx, eax
    call 0x004BA0B0 ; HouseClass::HouseClass(HousesType)
    jmp 0x005DE3DF

_HouseClass__AI_Attack_Stuff_Alliance_Check:
    cmp esi, edi
    jz 0x004C0777

    push esi
    mov ecx, edi
    call 0x004BDA20 ; HouseClass::Is_Ally
    cmp al, 1
    jz 0x004C0777

.Ret:
    jmp 0x004C06F7

_HouseClass__Make_Ally_STFU_when_Allying_In_Loading_Screen_Spawner:
    cmp byte [IsDoingAlliancesSpawner], 1
    jz 0x004BDE68
    test al, al          ; hooked by patch
    jz 0x4BDE68
    jmp 0x004BDDB9

_SessionClass__Free_Scenario_Descriptions_RETN_Patch:
    retn

_Send_Statistics_Packet_Return_If_Skirmish:
    cmp dword [SessionType], 5
    jz .ret

    ; Sending statistics causes loaded multiplayer games to crash when the game ends
    pushad
    SpawnINI_Get_Bool str_Settings, str_LoadSaveGame, 0
    cmp al, 0
    popad
    jnz  .ret

    sub esp, 374h
    jmp 0x00609476

.ret:
    jmp 0x0060A80A ; jump to retn statement

; args <House number>, <ColorType>
%macro Set_House_Color 3
    mov eax, %2
    cmp eax, -1
    jz .Dont_Set_Color_%3
    mov edi, [HouseClassArray_Vector] ; HouseClassArray
    mov edi, [edi+%1*4]

;    mov dword [edi+0x10DFC], eax
    mov esi, [edi+0x24]
    mov dword [esi+0x6C], eax
    mov dword [edi+10DFCh], eax

    push eax
    call Get_MP_Color

    mov dword [edi+0x10DFC], eax

    mov ecx, edi
    call 0x004CBAA0

.Dont_Set_Color_%3:
%endmacro

; args <House number>, <HouseType>
%macro Set_House_Country 3
    mov eax, %2
    cmp eax, -1
    jz .Dont_Set_Country_%3
    mov edi, [HouseClassArray_Vector]
    mov edi, [edi+%1*4]

    mov ecx, [HouseTypesArray]
    mov eax, [ecx+eax*4]

    mov dword [edi+24h], eax

.Dont_Set_Country_%3:
%endmacro


; args <House number>, <identifier>
%macro Set_Spectator 2

    cmp dword [IsSpectatorArray+4*%1], 0
    jz .No_Spectator_%2

    mov edi, [HouseClassArray_Vector]
    mov edi, [edi+%1*4]

    xor eax, eax
    cmp dword [IsSpectatorArray+4*%1], 1
    sete al

    mov byte [edi+0x0CB], 1

.No_Spectator_%2:
%endmacro

; args <House number>, <DifficultyType>
%macro Set_House_Handicap 3
    mov eax, %2
    cmp eax, -1
    jz .Dont_Set_Handicap_%3
    mov edi, [HouseClassArray_Vector]
    mov edi, [edi+%1*4]

    push eax
    mov ecx, edi
    call HouseClass__Assign_Handicap ; DiffType HouseClass::Assign_Handicap(DiffType)

.Dont_Set_Handicap_%3:
%endmacro

; args <House number>, <House number to ally>
%macro House_Make_Ally 3
    mov eax, %2
    cmp eax, -1
    jz .Dont_Make_Ally_%3
    mov esi, [HouseClassArray_Vector] ; HouseClassArray
    mov edi, [esi+4*%1]

    push eax
    mov ecx, edi
    call HouseClass__Make_Ally

;    mov eax, [esi+4*eax]


;    mov esi, [edi+0x578]
;    mov ecx, [eax+0x20]

;    mov eax, 1
;    shl eax, cl
;    or  esi, eax
;    mov [edi+0x578], esi


.Dont_Make_Ally_%3:
%endmacro

; args <string of section to load from>, <House number which will ally>
%macro  House_Make_Allies_Spawner 3
    SpawnINI_Get_Int %1, str_HouseAllyOne, -1
    cmp al, -1
    jz .Dont_Ally_Multi1_%3
    House_Make_Ally %2, eax, a%3

.Dont_Ally_Multi1_%3:

    SpawnINI_Get_Int %1, str_HouseAllyTwo, -1
    cmp al, -1
    jz .Dont_Ally_Multi2_%3
    House_Make_Ally %2, eax, b%3

.Dont_Ally_Multi2_%3:

    SpawnINI_Get_Int %1, str_HouseAllyThree, -1
    cmp al, -1
    jz .Dont_Ally_Multi3_%3
    House_Make_Ally %2, eax, c%3

.Dont_Ally_Multi3_%3:

    SpawnINI_Get_Int %1, str_HouseAllyFour, -1
    cmp al, -1
    jz .Dont_Ally_Multi4_%3
    House_Make_Ally %2, eax, d%3

.Dont_Ally_Multi4_%3:

    SpawnINI_Get_Int %1, str_HouseAllyFive, -1
    cmp al, -1
    jz .Dont_Ally_Multi5_%3
    House_Make_Ally %2, eax, e%3

.Dont_Ally_Multi5_%3:

    SpawnINI_Get_Int %1, str_HouseAllySix, -1
    cmp al, -1
    jz .Dont_Ally_Multi6_%3
    House_Make_Ally %2, eax, f%3

.Dont_Ally_Multi6_%3:

    SpawnINI_Get_Int %1, str_HouseAllySeven, -1
    cmp al, -1
    jz .Dont_Ally_Multi7_%3
    House_Make_Ally %2, eax, g%3

.Dont_Ally_Multi7_%3:
%endmacro

_Read_Scenario_INI_Assign_Houses_And_Spawner_House_Settings:
    pushad
    call Assign_Houses

    cmp dword [SpawnerActive], 0
    jz  .Ret

;    Set_House_Country 0, dword [HouseCountriesArray+0], a
;    Set_House_Country 1, dword [HouseCountriesArray+4], b
;    Set_House_Country 2, dword [HouseCountriesArray+8], c
;    Set_House_Country 3, dword [HouseCountriesArray+12], d
;    Set_House_Country 4, dword [HouseCountriesArray+16], e
;    Set_House_Country 5, dword [HouseCountriesArray+20], f
;    Set_House_Country 6, dword [HouseCountriesArray+24], g
;    Set_House_Country 7, dword [HouseCountriesArray+28], h

    Set_House_Color 0, dword [HouseColorsArray+0], a
    Set_House_Color 1, dword [HouseColorsArray+4], b
    Set_House_Color 2, dword [HouseColorsArray+8], c
    Set_House_Color 3, dword [HouseColorsArray+12], d
    Set_House_Color 4, dword [HouseColorsArray+16], e
    Set_House_Color 5, dword [HouseColorsArray+20], f
    Set_House_Color 6, dword [HouseColorsArray+24], g
    Set_House_Color 7, dword [HouseColorsArray+28], h

    mov byte [IsDoingAlliancesSpawner], 1

    House_Make_Allies_Spawner str_Multi1_Alliances, 0, a
    House_Make_Allies_Spawner str_Multi2_Alliances, 1, b
    House_Make_Allies_Spawner str_Multi3_Alliances, 2, c
    House_Make_Allies_Spawner str_Multi4_Alliances, 3, d
    House_Make_Allies_Spawner str_Multi5_Alliances, 4, e
    House_Make_Allies_Spawner str_Multi6_Alliances, 5, f
    House_Make_Allies_Spawner str_Multi7_Alliances, 6, g
    House_Make_Allies_Spawner str_Multi8_Alliances, 7, h

    lea eax, [SpawnerTeamName]
    SpawnINI_Get_String str_Settings, str_TeamName, 0, eax, 128

    cmp byte[SpawnerTeamName], 0
    je  .dont_set_name

    push SpawnerTeamName
    call set_team_name

.dont_set_name:
    mov byte [IsDoingAlliancesSpawner], 0

    Set_House_Handicap 0, dword [HouseHandicapsArray+0], a
    Set_House_Handicap 1, dword [HouseHandicapsArray+4], b
    Set_House_Handicap 2, dword [HouseHandicapsArray+8], c
    Set_House_Handicap 3, dword [HouseHandicapsArray+12], d
    Set_House_Handicap 4, dword [HouseHandicapsArray+16], e
    Set_House_Handicap 5, dword [HouseHandicapsArray+20], f
    Set_House_Handicap 6, dword [HouseHandicapsArray+24], g
    Set_House_Handicap 7, dword [HouseHandicapsArray+28], h

    Set_Spectator 0, a
    Set_Spectator 1, b
    Set_Spectator 2, c
    Set_Spectator 3, d
    Set_Spectator 4, e
    Set_Spectator 5, f
    Set_Spectator 6, g
    Set_Spectator 7, h

.Ret:
    popad
    jmp 0x005E08E8

Add_Human_Player:
%push
    push ebp
    mov ebp,esp
    sub esp,4

%define TempPtr ebp-4

    push 0x4D
    call new

    add esp, 4

    mov esi, eax

    lea ecx, [esi+14h]
    call IPXAddressClass__IPXAddressClass

    lea eax, [esi]
    SpawnINI_Get_String str_Settings, str_Name, str_Empty, eax, 0x14

;    lea ecx,
;    push str_debugplayer
;    push ecx
;    call 0x006BE630 ; strcpy
;    add esp, 8

    ; Player side
    SpawnINI_Get_Int str_Settings, str_Side, 0
    mov dword [esi+0x35], eax ; side
    push eax

    ; Sidebar hack for mods which add new sides and new sidebars for them
    ; this will not fuck invert al which is needed for normal TS sidebar loading
    ; as GDI needs 1 and Nod 0 for sidebar (which is the opposite of their side index)
    SpawnINI_Get_Bool str_Settings, str_SidebarHack, 0
    cmp al, 1
    pop eax
    jz  .Sidebar_Hack

    ; Invert AL to set byte related to what sidebar and speech graphics to load
    cmp al, 1
    jz .Set_AL_To_Zero

    mov al, 1
    jmp .Past_AL_Invert

.Set_AL_To_Zero:
    mov al, 0

.Past_AL_Invert:
.Sidebar_Hack:
    mov byte [0x7E2500], al ; For side specific mix files loading and stuff, without sidebar and speech hack
    mov ebx, [ScenarioStuff]
    mov byte [ebx+1D91h], al

    SpawnINI_Get_Int str_Settings, str_Color, 0
    mov dword [esi+0x39], eax  ; color
    mov dword [PlayerColor], eax

    mov dword [esi+0x41], -1

    mov [TempPtr], esi
    lea eax, [TempPtr]
    push eax
    mov ecx, NameNodeVector
    call NameNodeVector_Add

    mov esp,ebp
    pop ebp
    retn
%pop

Add_Human_Opponents:
%push
    push ebp
    mov ebp,esp
    sub esp,128+128+4+4

%define TempBuf         ebp-128
%define OtherSection    ebp-128-128
%define TempPtr         ebp-128-128-4
%define CurrentOpponent ebp-128-128-4-4

    ; copy opponents
    xor ecx,ecx
    mov dword [CurrentOpponent], ecx

.next_opp:
    mov ecx, [CurrentOpponent]
    add ecx,1
    mov dword [CurrentOpponent], ecx

    push ecx
    push str_OtherSectionFmt ; Other%d
    lea eax, [OtherSection]
    push eax
    call _sprintf
    add esp, 0x0C

    push 0x4D
    call new
    add esp, 4

    mov esi, eax
    lea ecx, [esi+14h]
    call IPXAddressClass__IPXAddressClass

    lea eax, [esi]
    lea ecx, [OtherSection]
    SpawnINI_Get_String ecx, str_Name, str_Empty, eax, 0x14

    lea eax, [esi]
    mov eax, [eax]
    test eax, eax
    ; if no name present for this section, this is the last
    je .Exit

    lea ecx, [OtherSection]
    SpawnINI_Get_Int ecx, str_Side, -1
    mov dword [esi+0x35], eax ; side

    cmp eax,-1
    je .next_opp

    lea ecx, [OtherSection]
    SpawnINI_Get_Int ecx, str_Color, -1
    mov dword [esi+0x39], eax ; color

    cmp eax,-1
    je .next_opp

    mov eax, 1
    mov dword [SessionType], 4 ; HACK: SessonType set to WOL, will be set to LAN later

    ; set addresses to indexes for send/receive hack
    mov [esi + 0x14 + SpawnAddress.pad1], word 0
    mov ecx, dword [CurrentOpponent]
    mov [esi + 0x14 + SpawnAddress.id], ecx
    mov [esi + 0x14 + SpawnAddress.pad2], word 0

    lea eax, [TempBuf]
    lea ecx, [OtherSection]
    SpawnINI_Get_String ecx, str_Ip, str_Empty, eax, 32

    lea eax, [TempBuf]
    push eax
    call [inet_addr]

    mov ecx, dword [CurrentOpponent]
    dec ecx
    mov [ecx * ListAddress_size + AddressList + ListAddress.ip], eax

    lea ecx, [OtherSection]
    SpawnINI_Get_Int ecx, str_Port, 0
    and eax, 0xffff

    push eax
    call htons

    ; disable PortHack if different port than own
    cmp ax, [ListenPort]
    je .samePort
    mov dword [PortHack], 0
.samePort:

    mov ecx, dword [CurrentOpponent]
    dec ecx
    mov [ecx * ListAddress_size + AddressList + ListAddress.port], ax

    mov dword [esi+0x41], -1

    mov byte [esi+0x1E], 1

    mov [TempPtr], esi
    lea eax, [TempPtr]
    push eax
    mov ecx, NameNodeVector ; FIXME: name this
    call NameNodeVector_Add ; FIXME: name this

    jmp .next_opp
.Exit:
    mov esp,ebp
    pop ebp
    retn
%pop
