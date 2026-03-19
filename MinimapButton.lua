local addonName, addonTable = ...
local L = addonTable.L

local ldb = LibStub and LibStub("LibDataBroker-1.1", true)
local icon = LibStub and LibStub("LibDBIcon-1.0", true)

if not (ldb and icon) then return end -- Failsafe if libraries fail to load

local function GetCurrentIcon()
    if not addonTable.GetCurrentSpecID then return "Interface\\Icons\\Spell_Nature_MoonKey" end
    local specID = addonTable.GetCurrentSpecID()
    if type(AutoRoleSwapDB) == "table" and AutoRoleSwapDB[specID .. "_locked"] then
        return "Interface\\LFGFrame\\UI-LFG-ICON-LOCK" -- Native LFG lock symbol
    else
        return "Interface\\Icons\\Spell_Nature_MoonKey" -- Key symbol (Unlocked)
    end
end

local AutoRoleSwapLDB = ldb:NewDataObject("AutoRoleSwap", {
    type = "launcher",
    text = "AutoRoleSwap",
    icon = GetCurrentIcon(),
    OnClick = function(self, button)
        if button == "LeftButton" and SlashCmdList["AUTOROLESWAP"] then
            SlashCmdList["AUTOROLESWAP"]("lock")
        end
    end,
    OnTooltipShow = function(tooltip)
        tooltip:AddLine(addonName)
        
        local clickToggle = L["tooltip_click_toggle"]
        local dragMove = L["tooltip_drag_move"]
        if clickToggle then tooltip:AddLine(clickToggle, 1, 0.8, 0) end
        if dragMove then tooltip:AddLine(dragMove, 1, 0.8, 0) end
    end,
})

function addonTable.UpdateMinimapButton()
    AutoRoleSwapLDB.icon = GetCurrentIcon()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if type(AutoRoleSwapDB) ~= "table" then
        AutoRoleSwapDB = {}
    end
    
    if type(AutoRoleSwapDB.minimap) ~= "table" then
        AutoRoleSwapDB.minimap = { hide = false, minimapPos = 225 }
        
        -- Migration from old custom minimap button save schema (even for Swap)
        if AutoRoleSwapDB.minimapAngle then
            AutoRoleSwapDB.minimap.minimapPos = AutoRoleSwapDB.minimapAngle
            AutoRoleSwapDB.minimapAngle = nil
        end
    end
    
    icon:Register("AutoRoleSwap", AutoRoleSwapLDB, AutoRoleSwapDB.minimap)
    addonTable.UpdateMinimapButton()
end)
