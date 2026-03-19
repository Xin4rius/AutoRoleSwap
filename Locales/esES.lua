local _, addonTable = ...

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: Se ha restaurado tu función a '%s' para la especialización actual."
L["ROLE_TANK"] = "Tanque"
L["ROLE_HEALER"] = "Sanador"
L["ROLE_DAMAGER"] = "Infligir daño"
L["locked"] = "AutoRoleSwap: Funciones BLOQUEADAS. El buscador de grupo ya no anulará tu función guardada."
L["unlocked"] = "AutoRoleSwap: Funciones DESBLOQUEADAS. Tus selecciones del buscador de grupo se aplicarán en las pantallas de carga."
L["help"] = "Comandos de AutoRoleSwap:\n  /ars lock - Activa o desactiva la protección de anulación de funciones del LFG."
L["role_blocked"] = "AutoRoleSwap: Se ha restaurado tu función a '%s' porque está BLOQUEADA."
L["tooltip_click_toggle"] = "\nClic izquierdo: |cffffffffBloquear / Desbloquear|r"
L["tooltip_drag_move"] = "Mantener clic izquierdo: |cffffffffMover icono|r"
L["status_locked"] = "Bloqueado"
L["status_unlocked"] = "Desbloqueado"
