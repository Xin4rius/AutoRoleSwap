local _, addonTable = ...

-- Base language (English)
local L = {}
addonTable.L = L

L["role_restored"] = "AutoRoleSwap: Restored your role to '%s' for the current specialization."
L["ROLE_TANK"] = "Tank"
L["ROLE_HEALER"] = "Healer"
L["ROLE_DAMAGER"] = "Damager"
L["locked"] = "AutoRoleSwap: Roles are now LOCKED. LFG selections will no longer overwrite your saved roles."
L["unlocked"] = "AutoRoleSwap: Roles are UNLOCKED. LFG selections will overwrite your saved roles during loading screens."
L["help"] = "AutoRoleSwap commands:\n  /ars lock - Toggles locking your roles from being overwritten by LFG checkboxes."
L["role_blocked"] = "AutoRoleSwap: Restored your role to '%s' because the current specialization is LOCKED."
L["tooltip_click_toggle"] = "\nLeft Click: |cffffffffLock / Unlock|r"
L["tooltip_drag_move"] = "Left Click & Drag: |cffffffffMove Icon|r"
L["status_locked"] = "Locked"
L["status_unlocked"] = "Unlocked"
