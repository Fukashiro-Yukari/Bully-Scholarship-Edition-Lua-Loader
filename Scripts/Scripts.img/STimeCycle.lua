ImportScript('qtglib.lua')

QMLR = {}
QMLR.__mods = {}
QMLR.__missions = {}

function QMLR.ErrorCall(t,s)
    local en = t.Name or 'id: '..t.__id

    TextPrintString('['..en..'] Error: '..s,5,2)
end

modobj = {}

function modobj:Create()
    local t = {}

    setmetatable(t,self)
    self.__index = self

    t.IsMission = false

    return t
end

function modobj:Init() end
function modobj:Think() end
function modobj:OffMod() end
function modobj:MissionSetup() end
function modobj:MissionSucceed() end
function modobj:MissionCleanup() end

function modobj:Print(s,args)
    local name = self.Name or 'id: '..self.__id

    TextPrintString('['..name..'] '..s,4,2)
end

local oldmeta = getmetatable(_G) or {}
local meta = table.copy(oldmeta)
local old = meta.__newindex or function() end

local movet = {
    ['MissionSetup'] = true,
    ['MissionCleanup'] = true,
}

for i = 1,100 do
    MOD = modobj:Create()
    MOD.__id = i

    function meta.__newindex(t,k,v)
        if movet[k] then
            local key = k

            if movet[k] ~= true then
                key = movet[k]
            end

            rawset(MOD,key,v)

            return
        end

        rawset(t,k,v)
    end

    setmetatable(_G,meta)

    local b,e = pcall(ImportScript,'mod'..i..'.lua')

    if not b then
        MOD.Name = 'Error MOD'
        MOD.ErrorInfo = e
    end

    if MOD.IsMission then
        QMLR.__missions[i] = MOD
    else
        QMLR.__mods[i] = MOD
    end
    
    MOD = nil
end

setmetatable(_G,oldmeta)

modobj = nil

function QMLR:KeyDown()
    -- if IsButtonBeingReleased(1,0) then
    --     ShopStart()
    -- end
end

function main()
    Wait(500)

    for k,v in pairs(QMLR.__mods) do
        xpcall(function()
            v:Init()
        end,
        function(s)
            QMLR.ErrorCall(v,s)
        end,v)
    end

    repeat
        Wait(0)

        QMLR:KeyDown()

        for k,v in pairs(QMLR.__mods) do
            xpcall(function()
                v:Think()
            end,
            function(s)
                QMLR.ErrorCall(v,s)
            end,v)
        end
    until not Alive
end

function F_AttendedClass()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        return
    end

    SetSkippedClass(false)
    PlayerSetPunishmentPoints(0)
end
 
function F_MissedClass()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        return
    end

    SetSkippedClass(true)
    StatAddToInt(166)
end
 
function F_AttendedCurfew()
    if not PedInConversation(gPlayer) and not MissionActive() then
        TextPrintString('You got home in time for curfew', 4)
    end
end
 
function F_MissedCurfew()
    if not PedInConversation(gPlayer) and not MissionActive() then
        TextPrint('TM_TIRED5', 4, 2)
    end
end
 
function F_StartClass()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        return
    end

    F_RingSchoolBell()

    local l_6_0 = PlayerGetPunishmentPoints() + GetSkippingPunishment()
end
 
function F_EndClass()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        return
    end

    F_RingSchoolBell()
end
 
F_StartMorning = F_UpdateTimeCycle
F_EndMorning = F_UpdateTimeCycle
 
function F_StartLunch()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        F_UpdateTimeCycle()

        return
    end

    F_UpdateTimeCycle()
end
 
F_EndLunch = F_UpdateTimeCycle
F_StartAfternoon = F_UpdateTimeCycle
F_EndAfternoon = F_UpdateTimeCycle
F_StartEvening = F_UpdateTimeCycle
F_EndEvening = F_UpdateTimeCycle
F_StartCurfew_SlightlyTired = F_UpdateTimeCycle
F_StartCurfew_Tired = F_UpdateTimeCycle
F_StartCurfew_MoreTired = F_UpdateTimeCycle
F_StartCurfew_TooTired = F_UpdateTimeCycle
F_EndCurfew_TooTired = F_UpdateTimeCycle
F_EndTired = F_UpdateTimeCycle
F_Nothing = function() end
 
F_ClassWarning = function()
    if IsMissionCompleated('3_08') and not IsMissionCompleated('3_08_PostDummy') then
        return
    end

    local l_23_0 = math.random(1,2)
end
 
F_UpdateTimeCycle = function()
    if not IsMissionCompleated('1_B') then
        local l_24_0 = GetCurrentDay(false)
        if l_24_0 < 0 or l_24_0 > 2 then
            SetCurrentDay(0)
        end
    end

    F_UpdateCurfew()
end
 
F_UpdateCurfew = function()
    local l_25_0 = shared.gCurfewRules
    if not l_25_0 then
        l_25_0 = F_CurfewDefaultRules
    end

    l_25_0()
end
 
F_CurfewDefaultRules = function()
    local l_26_0 = ClockGet()

    if l_26_0 >= 23 or l_26_0 < 7 then
        shared.gCurfew = true
    else
        shared.gCurfew = false
    end
end