local _, addonTable = ...

if GetLocale() ~= "zhCN" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: 已将您的当前专精职责恢复为 '%s'。"
L["ROLE_TANK"] = "坦克"
L["ROLE_HEALER"] = "治疗者"
L["ROLE_DAMAGER"] = "伤害输出"
L["locked"] = "AutoRoleSwap: 职责现已锁定。队伍查找器的选择不再覆盖您的保存职责。"
L["unlocked"] = "AutoRoleSwap: 已解锁。加载界面时将应用队伍查找器的职责选择。"
L["help"] = "AutoRoleSwap 命令：\n  /ars lock - 开启或关闭防止队伍查找器覆盖保存的职责。"
L["role_blocked"] = "AutoRoleSwap: 已将职责恢复为 '%s'，因为该专精已锁定。"
L["tooltip_click_toggle"] = "\n左键点击：|cffffffff锁定 / 解锁|r"
L["tooltip_drag_move"] = "按住左键拖动：|cffffffff移动图标|r"
L["status_locked"] = "已锁定"
L["status_unlocked"] = "已解锁"
