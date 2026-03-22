local _, addonTable = ...

if GetLocale() ~= "zhTW" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: 已將您目前的專精角色恢復為 '%s'。"
L["ROLE_TANK"] = "坦克"
L["ROLE_HEALER"] = "治療者"
L["ROLE_DAMAGER"] = "傷害輸出"
L["locked"] = "AutoRoleSwap: 角色現已鎖定。尋求組隊的選擇不再覆蓋您儲存的角色。"
L["unlocked"] = "AutoRoleSwap: 角色現已解鎖。讀取畫面時將套用尋求組隊的角色選擇。"
L["help"] = "AutoRoleSwap 指令：\n  /ars lock - 開啟或關閉防止尋求組隊覆蓋儲存的角色。"
L["role_blocked"] = "AutoRoleSwap: 已將角色恢復為 '%s'，因為該專精已鎖定。"
L["tooltip_click_toggle"] = "\n左鍵點擊：|cffffffff鎖定 / 解鎖|r"
L["tooltip_drag_move"] = "按住左鍵拖曳：|cffffffff移動圖示|r"
L["status_locked"] = "已鎖定"
L["status_unlocked"] = "已解鎖"
L["talents_button_tooltip"] = "左鍵點擊：\n|cffffffff選擇角色 / 鎖定|r"
