{
Copyright 2011 The Krit
Copyright 2006 Carsten Hjorthøj (Lilac Soul)

The Script Generator is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

The Script Generator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{
The Krit created this unit to collect a bunch of string data from the Script
Generator into a central location -- sometimes to reduce redundancy, sometimes
for ease of editing. It also includes some string-handling routines, and a
function for loading string data into widgets (mostly for TComboBox, but could
be used for anything with a TStrings).
}


{$MODE Delphi}
{$LONGSTRINGS OFF}
{$WRITEABLECONST OFF}


unit constants;


interface

uses
  Classes, StdCtrls;

type
    // Used by the longer lists that have pairs (or triples) of strings.
    StringPair = array[0..1] of pchar;
    StringTriple = array[0..2] of pchar;

    // Enumerates used when convenient.
    // These currently cover only the playable classes and races, but could
    // be extended (without side-effects, I think) if the others are needed.
    // Just make sure they correspond to a contiguous block in the arrays
    // defining the NWScript constants.
    TClassEnum = ( E_Barbarian=0, E_Bard, E_Cleric, E_Druid, E_Fighter, E_Monk,
                   E_Paladin, E_Ranger, E_Rogue, E_Sorcerer, E_Wizard,
                   E_Archer, E_Assassin, E_Blackguard, E_Champion, E_Defender,
                   E_Harper, E_PaleMaster, E_PurpleDragon, E_DragonDisciple,
                   E_Shadowdancer, E_Shifter, E_WeaponMaster );
    TRaceEnum = ( E_Dwarf=0, E_Elf, E_Gnome, E_Halfling, E_HalfElf, E_HalfOrc, E_Human );

    // The standard options for selecting an object in the game.
    // Keep in sync with ObjectVar() and ObjectDesc() (both defined later).
    // (Comparing these will be more efficient than comparing strings.)
    TObjectEnum = ( E_CHOOSE_Owner,     E_CHOOSE_Self,      E_CHOOSE_PC,
                    E_CHOOSE_Activator, E_CHOOSE_ActTarget, E_CHOOSE_Tagged,
                    E_CHOOSE_Actor,     E_CHOOSE_Spawn,     E_CHOOSE_Other );
    TObjectList = array[TObjectEnum] of boolean;


// -----------------------------------------------------------------------------
// Some handy utilities.
procedure LoadConstants(Destination: TStrings; const Source: array of pchar);        overload;
procedure LoadConstants(Destination: TStrings; const Source: array of StringPair);   overload;
procedure LoadConstants(Destination: TStrings; const Source: array of StringTriple); overload;

function SymConst(const List: array of pchar;        Index: integer): shortstring; overload;
function SymConst(const List: array of StringPair;   Index: integer): shortstring; overload;
function SymConst(const List: array of StringTriple; Index: integer): shortstring; overload;
//function SymbolToIndex(const sSymbol: shortstring; const List: array of pchar): integer; // Not needed yet.
function SymbolToIndex(const sSymbol: shortstring; const List: array of StringPair): integer;
//function SymbolToIndex(const sSymbol: shortstring; const List: array of StringTriple): integer; // Not needed yet.

function ConstDisplay(const List: array of StringPair;   Index: integer): shortstring; overload; inline;
function ConstDisplay(const List: array of StringTriple; Index: integer): shortstring; overload; inline;
function ConstInfo(const List: array of StringTriple; Index: integer): pchar; inline;

function NameToConstant(const sPrefix: pchar; const sName: shortstring): shortstring;
function NameToCommand(const sPrefix: pchar; const sName: shortstring): shortstring;

function GetChosenObject(RadioOwner, RadioPC, RadioActivator, RadioTargeted,
                         RadioTagged, RadioActor, RadioSpawn: TRadioButton;
                         bAllowMacro: boolean=TRUE) : TObjectEnum;
function ObjectDesc(eWhich: TObjectEnum; const sTagText: shortstring;
                    bReflexive: boolean=false; const sAlt: shortstring='') : shortstring;
function ObjectVar(eWhich: TObjectEnum; const sAlt: shortstring=''; bLocation: boolean=FALSE) : shortstring;

// Some generic functions that I did not feel like creating a unit for.
function BoolToStr(B: boolean; const TrueS, FalseS: shortstring): shortstring; overload; inline;
function ChopBoth(const sString: shortstring; nLeft, nRight: integer): shortstring; inline;
//function ChopLeft(const sString: shortstring; nCount: integer): shortstring; inline;  // Not needed yet.
//function ChopRight(const sString: shortstring; nCount: integer): shortstring; inline; // Not needed yet.
function LastChar(const sString: shortstring): char; inline;
function QuoteSwap(const InString: shortstring): shortstring;
function Spaces(how_long: integer): shortstring;    // Returns a string of spaces.
function StartsWith(const sString, sPrefix: shortstring; nStart: integer=1): boolean; inline;


// -----------------------------------------------------------------------------
// Some commonly used strings, defined once here to (possibly) conserve space.
const
    // Misc.
    s_TRUE           = 'TRUE';
    s_FALSE          = 'FALSE';
    s_comma_TRUE     = ', TRUE';
    s_comma_FALSE    = ', FALSE';
    s_Return         = '    return;';
    s_ReturnFalse    = '    return FALSE;';

    // Variables
    s_bCurState      = 'bCurState';
    s_eDamage        = 'eDamage';
    s_eEffect        = 'eEffect';
    s_eVFX           = 'eVFX';
    s_fValue         = 'fValue';
    s_ipAdd          = 'ipAdd';
    s_lActTarget     = 'lActTarget';
    s_lTarget        = 'lTarget';
    s_nCount         = 'nCount';
    s_nHench         = 'nHench';
    s_nType          = 'nType';
    s_nValue         = 'nValue';
    s_OBJECT_INVALID = 'OBJECT_INVALID';
    s_OBJECT_SELF    = 'OBJECT_SELF';
    s_oActivator     = 'oActivator';
    s_oActor         = 'oActor';
    s_oActTarget     = 'oActTarget';
    s_oArea          = 'oArea';
    s_oDelay         = 'oDelayer';
    s_oEventItem     = 'oEventItem';
    s_oHench         = 'oHench';
    s_oItem          = 'oItem';
    s_oMaster        = 'oMaster';
    s_oParty         = 'oParty';
    s_oPC            = 'oPC';
    s_oSelf          = 'oSelf';
    s_oSpawn         = 'oSpawn';
    s_oTarget        = 'oTarget';
    s_oTrap          = 'oTrap';
    s_sValue         = 'sValue';

    // Functions
    s_AssignCommand  = 'AssignCommand(';//oActionSubject, aActionToAssign) // Sometimes just as convenient as Script.AssignCommand().
    s_EffectVisual   = 'EffectVisualEffect(';//nVFX)
    s_GetAreaPC      = 'GetArea('+s_oPC+')';
    s_GetLocation    = 'GetLocation(';//object)
    s_GetModule      = 'GetModule()';
    s_GetNearest     = 'GetNearestObjectByTag("';//tag"[, object, nth])
    s_GetObject      = 'GetObjectByTag("';//tag"[, nth])
    s_GetWaypoint    = 'GetWaypointByTag("';//tag")


    // Flags a value other than a variable name or symbolic constant.
    // Must be different from the beginning of all variable/constant names in use.
    TAG_FLAG = 'Tag: ';


// -----------------------------------------------------------------------------
// The NWScript constants
const
    // Note that most of these constants will be in alphabetical order by common
    // name, rather than strict alphabetical order or  numerical order of their
    // values in NWScript. This should allow for more intuitive widgets for the
    // end user.
    // The last entry in each array will be some information about how to
    // construct the symbolic constants. The symbol is usually the last entry
    // followed by the desired entry, converted via NameToConstant(). However,
    // if the last entry is nil, no conversion takes place.

    // For several lists, I will use an array of arrays, with the inner array
    // consisting of two or three entries -- the common name, the abbreviated
    // NWScript constant, and possibly some information about how these can be

// =============================================================================
// Symbol table data is now in constants_generated.inc for clean regeneration.
    {$I constants_generated.inc}
// =============================================================================


// -----------------------------------------------------------------------------
implementation

uses
    nwn; // Very limited usage (WillBeAssigned()), but used nonetheless.

const
    // The positions of data in StringPair and StringTriple.
    CONSTANT_DISPLAY = 0;
    CONSTANT_SCRIPT  = 1;
    CONSTANT_INFO    = 2;


// Replaces the contents of Destination with the contents of Source.
// This will do nothing (so the current selection is maintained) if the
// Destination already contains Source. (Well, if the first item matches up,
// which should be good enough in practice.)
procedure LoadConstants(Destination: TStrings; const Source: array of pchar);
var
    index: integer;
begin
    // Abort if already loaded.
    if Destination.Count > 0 then
        if Destination[0] = Source[0] then
            exit;

    // Allow these changes to be batched up.
    Destination.BeginUpdate();
    try
        // Empty the old contents.
        Destination.Clear();
        // Ensure space has been allocated.
        if Destination.Capacity < High(Source) then
            Destination.Capacity := High(Source);
        // Load the new contents.
        for index := 0 to High(Source)-1 do
            Destination.Append(Source[index]);
    finally
        // End the batched changes.
        Destination.EndUpdate();
    end;
end;


// Replaces the contents of Destination with the "pretty names" from Source.
// This will do nothing (so the current selection is maintained) if the
// Destination already contains Source. (Well, if the first item matches up,
// which should be good enough in practice.)
procedure LoadConstants(Destination: TStrings; const Source: array of StringPair);
var
    index: integer;
begin
    // Abort if already loaded.
    if Destination.Count > 0 then
        if Destination[0] = Source[0][CONSTANT_DISPLAY] then
            exit;

    // Allow these changes to be batched up.
    Destination.BeginUpdate();
    try
        // Empty the old contents.
        Destination.Clear();
        // Ensure space has been allocated.
        if Destination.Capacity < High(Source) then
            Destination.Capacity := High(Source);
        // Load the new contents, skipping the extra row at the end.
        for index := 0 to High(Source)-1 do
            Destination.Append(Source[index][CONSTANT_DISPLAY]);
    finally
        // End the batched changes.
        Destination.EndUpdate();
    end;
end;


// Replaces the contents of Destination with the "pretty names" from Source.
// This will do nothing (so the current selection is maintained) if the
// Destination already contains Source. (Well, if the first item matches up,
// which should be good enough in practice.)
procedure LoadConstants(Destination: TStrings; const Source: array of StringTriple);
var
    index: integer;
begin
    // Abort if already loaded.
    if Destination.Count > 0 then
        if Destination[0] = Source[0][CONSTANT_DISPLAY] then
            exit;

    // Allow these changes to be batched up.
    Destination.BeginUpdate();
    try
        // Empty the old contents.
        Destination.Clear();
        // Ensure space has been allocated.
        if Destination.Capacity < High(Source) then
            Destination.Capacity := High(Source);
        // Load the new contents, skipping the extra row at the end.
        for index := 0 to High(Source)-1 do
            Destination.Append(Source[index][CONSTANT_DISPLAY]);
    finally
        // End the batched changes.
        Destination.EndUpdate();
    end;
end;


// Returns the NWScript symbolic constant for the entry in List with index Index.
function SymConst(const List: array of pchar; Index: integer): shortstring;
begin
    if Index < 0 then
        result := '-1'
    else if List[High(List)] = nil then
        result := List[index]
    else
        result := NameToConstant(List[High(List)], List[Index]);
end;


// Returns the NWScript symbolic constant for the entry in List with index Index.
function SymConst(const List: array of StringPair; Index: integer): shortstring;
var
    sPrefix, sSymbol: pchar;
begin
    if Index < 0 then begin
        result := '-1';
        exit;
    end;

    sSymbol := List[Index][CONSTANT_SCRIPT];
    sPrefix := List[High(List)][CONSTANT_SCRIPT];

    // Generate the symbol?
    if sSymbol = nil then
        result := NameToConstant(sPrefix, List[Index][CONSTANT_DISPLAY])
    // Abbreviated symbol?
    else if sSymbol = '_' then
        result := shortstring(sPrefix)
    else if sSymbol[0] = '_' then
        result := shortstring(sPrefix) + shortstring(sSymbol)
    // Take the symbol literally.
    else
        result := shortstring(sSymbol);
end;


// Returns the NWScript symbolic constant for the entry in List with index Index.
function SymConst(const List: array of StringTriple; Index: integer): shortstring;
var
    sPrefix, sSymbol: pchar;
begin
    if Index < 0 then begin
        result := '-1';
        exit;
    end;

    sSymbol := List[Index][CONSTANT_SCRIPT];
    sPrefix := List[High(List)][CONSTANT_SCRIPT];

    // Generate the symbol?
    if sSymbol = nil then
        result := NameToConstant(sPrefix, List[Index][CONSTANT_DISPLAY])
    // Abbreviated symbol?
    else if sSymbol = '_' then
        result := shortstring(sPrefix)
    else if sSymbol[0] = '_' then
        result := shortstring(sPrefix) + shortstring(sSymbol)
    // Take the symbol literally.
    else
        result := shortstring(sSymbol);
end;


// Converts a NWScript symbolic constant (presumably read from an existing script)
// to an index into the Generator's list of constants.
// Returns -1 on no match.
function SymbolToIndex(const sSymbol: shortstring; const List: array of StringPair): integer;
begin
    // Scan the constants for a match.
    result := High(List) - 1; // Skip the trailing info row.
    while (result > 0)  and  (sSymbol <> SymConst(List, result)) do
        Dec(result);

    // If no match, return -1.
    if sSymbol <> SymConst(List, result) then
        result := -1;
end;


// Returns the text to be displayed as the name of the indicated symbolic constant.
// (So other units do not have to know the array structure.)
function ConstDisplay(const List: array of StringPair;   Index: integer): shortstring; inline;
begin
    result := List[Index][CONSTANT_DISPLAY];
end;

// Returns the text to be displayed as the name of the indicated symbolic constant.
// (So other units do not have to know the array structure.)
function ConstDisplay(const List: array of StringTriple; Index: integer): shortstring; inline;
begin
    result := List[Index][CONSTANT_DISPLAY];
end;


// Returns the extra info assoicated with the indicated symbolic constant.
// (So other units do not have to know the array structure.)
function ConstInfo(const List: array of StringTriple; Index: integer): pchar; inline;
begin
    result := List[Index][CONSTANT_INFO];
end;


// Converts a "pretty name" to a NWScript symbolic constant.
// Specifically:
//  The following is done to sName before prepending it with sPrefix + '_':
//  spaces become underscores,
//  letters become uppercase,
//  digits are preserved,
//  plus sign becomes 'PLUS_',
//  minus sign becomes 'MINUS_',
//  percent sign becomes '_PERCENT', and
//  other characters are ignored.
function NameToConstant(const sPrefix: pchar; const sName: shortstring): shortstring;
var
    i, iPlus: integer;
    sConverted: shortstring;
begin
    // Convert the name part.
    SetLength(sConverted, Length(sName));
    iPlus := 0; // Tracks extra characters added.
    for i := 1 to Length(sName) do
        case sName[i] of
            ' ':      sConverted[i+iPlus] := '_';
            'a'..'z': sConverted[i+iPlus] := char(ord(sName[i]) + ord('A')-ord('a'));
            'A'..'Z': sConverted[i+iPlus] := sName[i];
            '0'..'9': sConverted[i+iPlus] := sName[i];

            '+': begin
                      SetLength(sConverted, Length(sConverted)+4);
                      sConverted[i+iPlus+0] := 'P';
                      sConverted[i+iPlus+1] := 'L';
                      sConverted[i+iPlus+2] := 'U';
                      sConverted[i+iPlus+3] := 'S';
                      sConverted[i+iPlus+4] := '_';
                      iPlus += 4;
                  end;
            '-': begin
                      SetLength(sConverted, Length(sConverted)+5);
                      sConverted[i+iPlus+0] := 'M';
                      sConverted[i+iPlus+1] := 'I';
                      sConverted[i+iPlus+2] := 'N';
                      sConverted[i+iPlus+3] := 'U';
                      sConverted[i+iPlus+4] := 'S';
                      sConverted[i+iPlus+5] := '_';
                      iPlus += 5;
                  end;

            '%': begin
                      SetLength(sConverted, Length(sConverted)+7);
                      sConverted[i+iPlus+0] := '_';
                      sConverted[i+iPlus+1] := 'P';
                      sConverted[i+iPlus+2] := 'E';
                      sConverted[i+iPlus+3] := 'R';
                      sConverted[i+iPlus+4] := 'C';
                      sConverted[i+iPlus+5] := 'E';
                      sConverted[i+iPlus+6] := 'N';
                      sConverted[i+iPlus+7] := 'T';
                      iPlus += 7;
                  end;

            else // Skipped
                  begin
                      SetLength(sConverted, Length(sConverted)-1);
                      iPlus -= 1;
                  end;
        end;//case

    result := sPrefix + '_' + sConverted;
end;


// Converts a "pretty name" to a NWScript command.
// Specifically: removes everything but letters and digits, then prepends sPrefix.
function NameToCommand(const sPrefix: pchar; const sName: shortstring): shortstring;
var
    iName, iConv: integer;
    sConverted:   shortstring;
begin
    // Initial (over-)estimate of length.
    SetLength(sConverted, Length(sName));

    // Remove unwanted characters.
    iConv := 0;
    for iName := 1 to Length(sName) do
        if ( ('a' <= sName[iName]) and (sName[iName] <= 'z') ) or
           ( ('A' <= sName[iName]) and (sName[iName] <= 'Z') ) or
           ( ('0' <= sName[iName]) and (sName[iName] <= '9') ) then
        begin
            Inc(iConv);
            sConverted[iConv] := sName[iName];
        end;
    // Correct the length.
    SetLength(sConverted, iConv);

    result := sPrefix + sConverted;
end;


// -------------------------------------
// Handling the PC/actor/spawn/tagged/etc. selections:


// Returns an enumerate indicating which radio button was selected.
// nil can be passed as a parameter, and the result if no supplied buttons
// are selected is E_CHOOSE_Other.
// bAllowMacro controls whether or not OBJECT_SELF is allowed instead of oSelf.
function GetChosenObject(RadioOwner, RadioPC, RadioActivator, RadioTargeted,
                         RadioTagged, RadioActor, RadioSpawn: TRadioButton;
                         bAllowMacro: boolean=TRUE) : TObjectEnum;
begin
         if (RadioPC <> nil)        and RadioPC.Checked        then result := E_CHOOSE_PC
    else if (RadioActivator <> nil) and RadioActivator.Checked then result := E_CHOOSE_Activator
    else if (RadioTargeted <> nil)  and RadioTargeted.Checked  then result := E_CHOOSE_ActTarget
    else if (RadioTagged <> nil)    and RadioTagged.Checked    then result := E_CHOOSE_Tagged
    else if (RadioActor <> nil)     and RadioActor.Checked     then result := E_CHOOSE_Actor
    else if (RadioSpawn <> nil)     and RadioSpawn.Checked     then result := E_CHOOSE_Spawn
    else if (RadioOwner <> nil)     and RadioOwner.Checked then
    begin
        if not bAllowMacro or Tlilac.WillBeAssigned()          then result := E_CHOOSE_Self
                                                               else result := E_CHOOSE_Owner;
    end
    else
        result := E_CHOOSE_Other;
end;


// Returns text (for use in comments) describing the object indicated by eWhich.
// TagText is used if a tagged object is indicated.
// If bReflexive is true, then 'ourself' is used instead of 'us'.
function ObjectDesc(eWhich: TObjectEnum; const sTagText: shortstring;
                    bReflexive: boolean=false; const sAlt: shortstring='') : shortstring;
begin
    case eWhich of
        E_CHOOSE_PC:        result := 'the PC';
        E_CHOOSE_Activator: result := 'the item activator';
        E_CHOOSE_ActTarget: result := 'the activation target';
        E_CHOOSE_Tagged:    result := '"'+sTagText+'"';
        E_CHOOSE_Actor:     result := '"'+Tlilac.last_actor+'"';
        E_CHOOSE_Spawn:     result := 'the spawn';
        E_CHOOSE_Owner,
        E_CHOOSE_Self:      result := BoolToStr(bReflexive, 'ourself', 'us');
        else                result := sAlt;
    end;
end;


// Returns the variable name corresponding to eWhich, possibly converted to a
// location.
// sAlt is the variable name for E_CHOOSE_Other.
// I have not yet used the case of E_CHOOSE_Other and a location, so the behavior
// in that case is officially undefined until I see what would be most convenient.
// (Meaning it can be changed without hurting anything yet.)
function ObjectVar(eWhich: TObjectEnum; const sAlt: shortstring=''; bLocation: boolean=FALSE) : shortstring;
const
    var_list: array[TObjectEnum] of pchar =
          ( s_OBJECT_SELF,  // E_CHOOSE_Owner
            s_oSelf,        // E_CHOOSE_Self
            s_oPC,          // E_CHOOSE_PC
            s_oActivator,   // E_CHOOSE_Activator
            s_oActTarget,   // E_CHOOSE_ActTarget
            s_oTarget,      // E_CHOOSE_Tagged
            s_oActor,       // E_CHOOSE_Actor
            s_oSpawn,       // E_CHOOSE_Spawn
            nil             // E_CHOOSE_Other (unused)
          );
begin
    if eWhich = E_CHOOSE_Other then
        result := sAlt
    else
        result := shortstring(var_list[eWhich]);

    if bLocation then begin
        // The activation target does not really require an object.
        if eWhich = E_CHOOSE_ActTarget then
            result := s_lActTarget
        else
            result := s_GetLocation + result+')';
    end;
end;


// -------------------------------------
// More generic-ish utilities:


// Overload to avoid converting to ansistring.
function BoolToStr(B: boolean; const TrueS, FalseS: shortstring): shortstring; inline;
begin
    if B then
        Result := TrueS
    else
        BoolToStr := FalseS;
end;


// Chops nLeft characters off the left of the string and nRight characters off
// the right, then returns the result.
function ChopBoth(const sString: shortstring; nLeft, nRight: integer): shortstring; inline;
begin
    result := Copy(sString, 1 + nLeft, Length(sString) - nLeft - nRight);
end;


// Not needed yet:
//// Chops nCount characters off the left of the string and returns the result.
//function ChopLeft(const sString: shortstring; nCount: integer): shortstring; inline;
//begin
//    result := Copy(sString, 1 + nCount, Length(sString) - nCount);
//end;


// Not needed yet:
//// Chops nCount characters off the right of the string and returns the result.
//function ChopRight(const sString: shortstring; nCount: integer): shortstring; inline;
//begin
//    result := Copy(sString, 1, Length(sString) - nCount);
//end;


// Returns the last character in a string.
// Optimized under the assumption that sString is not ''.
// This is for those times when the string has a long name, making writing this
// out explicitly somewhat of a pain.
function LastChar(const sString: shortstring): char; inline;
begin
    result := sString[Length(sString)];
end;


// Converts double quotes in the provided string to single quotes (so the
// string can be quoted in NWScript).
function QuoteSwap(const InString: shortstring): shortstring;
var
    index: integer;
begin
    // Could use the following, but a direct implementation may be more efficient.
    //result := StringReplace(InString, '"', '''', [rfReplaceAll]);

    SetLength(result, Length(InString));
    for index := 1 to Length(InString) do
        if InString[index] = '"' then
            result[index] := ''''
        else
            result[index] := InString[index];
end;


// Returns a string of spaces of the specified length.
function Spaces(how_long: integer): shortstring;
var
    i: integer;
begin
    SetLength(result, how_long);
    for i := 1 to how_long do
        result[i] := ' ';
end;


// Returns TRUE if sPrefix is the beginning of sString.
// nStart can be used to specify a later starting position.
// (e.g. StartsWith('wxyz', 'xy', 2) returns true.
function StartsWith(const sString, sPrefix: shortstring; nStart: integer=1): boolean; inline;
begin
    result :=  sPrefix = copy(sString, nStart, Length(sPrefix));
end;


end.

