local _, addonTable = ...

if GetLocale() ~= "koKR" then return end

local L = addonTable.L
L["role_restored"] = "AutoRoleSwap: 현재 전문화에 맞춰 '%s' 역할로 복구되었습니다."
L["ROLE_TANK"] = "방어 담당"
L["ROLE_HEALER"] = "치유 담당"
L["ROLE_DAMAGER"] = "공격 담당"
L["locked"] = "AutoRoleSwap: 역할이 잠금 처리되었습니다. 파티 찾기 설정이 저장된 역할을 덮어쓰지 않습니다."
L["unlocked"] = "AutoRoleSwap: 역할 잠금이 해제되었습니다. 로딩 화면에서 파티 찾기 설정이 저장된 역할을 덮어씁니다."
L["help"] = "AutoRoleSwap 명령어:\n  /ars lock - 파티 찾기 체크박스가 역할을 덮어쓰는 것을 켜거나 끕니다."
L["role_blocked"] = "AutoRoleSwap: 역할이 잠금 상태이므로 '%s' 역할로 복구되었습니다."
L["tooltip_click_toggle"] = "\n좌클릭: |cffffffff잠금 / 잠금 해제|r"
L["tooltip_drag_move"] = "마우스 왼쪽 버튼으로 드래그: |cffffffff아이콘 이동|r"
L["status_locked"] = "잠금"
L["status_unlocked"] = "잠금 해제"
L["talents_button_tooltip"] = "좌클릭: \n|cffffffff역할 선택 / 잠금|r"
