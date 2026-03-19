local _, addonTable = ...

if GetLocale() ~= "ruRU" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: Ваша роль для текущей специализации восстановлена на '%s'."
L["ROLE_TANK"] = "Танк"
L["ROLE_HEALER"] = "Лекарь"
L["ROLE_DAMAGER"] = "Боец"
L["locked"] = "AutoRoleSwap: Роли ЗАБЛОКИРОВАНЫ. Выбор в поиске подземелий больше не перезапишет ваши сохраненные роли."
L["unlocked"] = "AutoRoleSwap: Роли РАЗБЛОКИРОВАНЫ. Выбор в поиске подземелий будет применять роли на экранах загрузки."
L["help"] = "Команды AutoRoleSwap:\n  /ars lock - Включает или отключает перезапись ролей через поиск подземелий."
L["role_blocked"] = "AutoRoleSwap: Ваша роль восстановлена на '%s', так как она ЗАБЛОКИРОВАНА."
L["tooltip_click_toggle"] = "\nЛевый клик: |cffffffffЗаблокировать / Разблокировать|r"
L["tooltip_drag_move"] = "Левый клик и перетаскивание: |cffffffffПереместить значок|r"
L["status_locked"] = "Заблокировано"
L["status_unlocked"] = "Разблокировано"
