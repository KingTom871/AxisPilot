# AxisPilot

**AxisPilot** is a lightweight, input coordination tool designed for the Logitech G-Hub environment.

---

## ✨ Key Features
* **Jitter Algorithm**: Add jitter algorithm that adds coordinate noise to break up straight lines. You can choose to turn this on or off for each profile.
* **Dual-Layer Setup**: Toggle between "Standard" and "Advanced" modes 
* **Quiet**: Only kicks in when you need it and stays totally silent the rest of the time.

---

## 🛠️ Quick Start

1.  Open **Logitech G-HUB**.
2.  Pick your game profile and click **Scripting**.
3.  Paste the `AxisPilot.lua` code into the editor.
4.  Hit **Save and Run**.

---

## ⚙️ Configuration

You can tweak everything in the `SETTINGS` and `PROFILES` sections at the top of the script:

```lua
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
        [4] = {0, 9, 1, "Standard 1", true},
        [3] = {0, 4, 1, "Standard 2", true},
    },
    ["advanced"] = {
        [4] = {0, 7, 1, "Advanced 1", true},
        [3] = {0, 2, 1, "Advanced 2", true},
    }
}
```

## 🖱️ Mouse Button Reference
To customize your `PROFILES`, use the following button IDs:

| ID | Button Name 
| :---  | :--- 
| **1** | Left Mouse Button
| **2** | Middle Mouse Button
| **3** | Right Mouse Button
| **4** | Forward Side Button
| **5** | Backward Side Button

> **Note**: Button IDs may vary slightly depending on your specific Logitech mouse model. Use the G-HUB dashboard to verify your button assignments.

---

## ⚠️ Head's Up

* **For Study Only**: This project is strictly for learning Lua scripting and automation techniques.
* **Play Fair**: Using automation in certain online environments might go against their rules. Check before you use it!
* **Your Call**: You are responsible for how you use this tool. The author isn't liable for any bans or issues.

---

## 📄 License

Licensed under the **MIT License**. Feel free to mix, fix, and share!
