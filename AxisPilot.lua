--------------------------------------------------------------------------
-- [[ AxisPilot | Created by Ehsan Malik ]]
-- Licensed under the MIT License
-- For Study and Educational Purposes Only.
--------------------------------------------------------------------------

-- Localize global APIs
local move      = MoveMouseRelative
local isPressed = IsMouseButtonPressed
local sleep     = Sleep
local lockOn    = IsKeyLockOn
local mod       = IsModifierPressed
local log       = OutputLogMessage
local random    = math.random

-- Ensures the 'Human Factor' jitter is unique every time the script is loaded
math.randomseed(GetRunningTime())

-- 1. Core Settings
local SETTINGS = {
    HOTKEY       = "capslock",  -- Main toggle switch
    TRIGGER      = 3,           -- Trigger button (3 = Right Mouse Button)
    ADV_MOD      = "lalt",      -- Modifier key for Advanced Profiles
    OFF_BUTTON   = nil,         
    HUMAN_FACTOR = 1,           -- Simulation entropy (1 = +/-1px jitter)
}

-- 2. Profile
-- Format: [Button_ID] = { x_offset, y_offset, sleep_ms, "Display_Name", is_humanized }
-- [is_humanized] : Set to TRUE to enable pseudo-random movement offsets.
-- [NOTICE] Interval must be >= 1, I recommend 1 :)
local PROFILES = {
    ["standard"] = {
        [4] = {1, 1, 1, "Standard 1", true},
        [5] = {2, 2, 1, "Standard 2", false},
    },
    ["advanced"] = {
        [4] = {3, 3, 1, "Advanced 1", true},
        [5] = {4, 4, 1, "Advanced 2", false},
    }
}

-- 3. Runtime Variables
local cur_x, cur_y, cur_int = 0, 0, 1
local cur_human = false
local is_active = false

--------------------------------------------------------------------------
-- [[ G-HUB Event ]]
--------------------------------------------------------------------------

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    
    -- A. Dynamic Profile Mapping
    -- [MODIFIED] Now this section runs regardless of CapsLock state
    if event == "MOUSE_BUTTON_PRESSED" then
        
        -- Safe Abort: Manually disable the system via customized buttons
        if arg == SETTINGS.OFF_BUTTON then
            is_active = false
            cur_x, cur_y = 0, 0
            log("\n[AxisPilot] System Disabled")
            return
        end

        -- Complexity Switch: Map input to profile via nested hash tables
        local mode = mod(SETTINGS.ADV_MOD) and "advanced" or "standard"
        local config = PROFILES[mode][arg]

        if config then
            -- State update: cache values into runtime variables
            cur_x, cur_y, cur_int, cur_human = config[1], config[2], config[3], config[5]
            is_active = true
            -- Even if CapsLock is OFF, you will see this confirmation
            log("\n[AxisPilot] Mode: " .. config[4] .. (cur_human and " (Humanized)" or "") .. " Loaded")
        end
    end

    -- C. High-Polling Rate Handler
    if event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
        -- [MODIFIED] Added lockOn(SETTINGS.HOTKEY) check here to gate execution only
        if is_active and lockOn(SETTINGS.HOTKEY) and isPressed(SETTINGS.TRIGGER) then
            
            -- Promote runtime variables to stack-relative locals 
            local x, y, interval = cur_x, cur_y, cur_int
            local h_factor = SETTINGS.HUMAN_FACTOR

            -- Decision is made BEFORE entering the loop
            if cur_human then
                -- Humanized Path
                repeat
                    move(x + random(-h_factor, h_factor), y + random(-h_factor, h_factor))
                    sleep(interval)
                until not isPressed(1)
            else
                -- Pure Linear Path
                repeat
                    move(x, y)
                    sleep(interval)
                until not isPressed(1)
            end
        end
    end
end
