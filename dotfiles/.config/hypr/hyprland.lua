-- Hyprland config (Lua, for 0.55+)
-- Refer to the wiki: https://wiki.hypr.land/Configuring/
-- And the upstream example: https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua

-- You can split this configuration into multiple files via require():
-- local colors = require("colors")
-- Each require() runs in its own scope, so errors in one file don't kill the rest.


------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- CHINESE ENV ----
---------------------
hl.env("GTK_IM_MODULE",  "fcitx")
hl.env("QT_IM_MODULE",   "fcitx")
hl.env("XMODIFIERS",     "@im=fcitx")
hl.env("SDL_IM_MODULE",  "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")  -- for kitty etc.


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local browser     = "firefox"


-------------------
---- AUTOSTART ----
-------------------
-- exec-once is now an event handler on hyprland.start
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)
    hl.exec_cmd(browser)
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("fcitx5 -d")

    -- The [workspace N silent] dispatcher prefix still works inside exec strings
    hl.exec_cmd("[workspace 3 silent] steam")
    hl.exec_cmd([[[workspace 2 silent] kitty --title "notes" nvim ~/Documents/notes.md]])
   -- hl.exec_cmd("[workspace 2 silent] spotify")
    hl.exec_cmd("[workspace 2 silent] obsidian")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE",   "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in     = 2,
        gaps_out    = 5,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding        = 5,
        rounding_power  = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,  -- rgba(1a1a1aee) as ARGB hex
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default animations
hl.animation({ leaf = "global",         enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",         enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",        enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",         enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",           enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",         enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",     enabled = true, speed = 7,    bezier = "quick" })

-- Smart gaps / no gaps when only (uncomment to enable)
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]"   }, border_size = 0, rounding = 0 })

hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    -- Scrolling layout options (your old commented-out block; uncomment to use)
    -- scrolling = {
    --     column_width             = 0.5,
    --     follow_focus             = true,
    --     direction                = "right",
    --     fullscreen_on_one_column = true,
    -- },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout   = "us",
        kb_variant  = "",
        kb_model    = "",
        kb_options  = "",
        kb_rules    = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Apps & basics
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd("pkill wofi || wofi --show drun"))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + O",      hl.dsp.exec_cmd("obsidian"))

-- Dated note in nvim (needs sh -c for the date substitution)
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(
    [[sh -c 'kitty -e nvim ~/Documents/notes/$(date +%Y-%m-%d-%H%M).md']]
))

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd([[sh -c 'grim -g "$(slurp)" - | swappy -f -']]))

-- Move focus (arrows)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down"  }))

-- Move focus (vim)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- Workspaces: SUPER + [0-9] to focus, SUPER + ALT + [1-8] to move silently,
-- SUPER + SHIFT + 9/0 to move (non-silent), per your existing setup.
for i = 1, 10 do
    local key = i % 10  -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

for i = 1, 8 do
    hl.bind(mainMod .. " + ALT + " .. i,
        hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9  }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scrolling-layout hotkeys (layoutmsg passthrough)
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + comma",  hl.dsp.layout("swapcol l"))

-- Resize active window (repeating)
-- hl.bind(mainMod .. " + semicolon",  hl.dsp.window.resize_active({ dx = -80, dy = 0 }), { repeating = true })
-- hl.bind(mainMod .. " + apostrophe", hl.dsp.window.resize_active({ dx =  80, dy = 0 }), { repeating = true })

-- Mouse drag/resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Match props go inside `match = {}`, effects go at the top level.
-- Rules evaluate top-to-bottom; order matters.

hl.window_rule({
    name      = "steam-to-ws3",
    match     = { class = "^(steam)$" },
    workspace = "3",
})

--hl.window_rule({
--    name      = "spotify-to-ws2",
--    match     = { initial_class = "^(spotify)$" },
--    workspace = "2",
--})

hl.window_rule({
    name   = "btop-windowrule",
    match  = { initial_class = "(floating-btop)" },
    float  = true,
    center = true,
    size   = { "monitor_w*0.7", "monitor_h*0.7" },
})

hl.window_rule({
    name   = "nmtui-windowrule",
    match  = { initial_class = "(floating-nmtui)" },
    float  = true,
    center = true,
    size   = { "monitor_w*0.5", "monitor_h*0.5" },
})

hl.window_rule({
    name           = "wow-control",
    match          = { initial_title = "World of Warcraft" },
    suppress_event = "maximize",
    immediate      = true,
    float          = true,
    workspace      = "6",
})

hl.window_rule({
    name      = "notes-on-start",
    match     = { initial_class = "(kitty)", initial_title = "notes" },
    workspace = "2",
    size      = { "25%", "100%" },
    move      = { 0, 0 },
})

hl.window_rule({
    name      = "obsidian-on-start",
    match     = { initial_title = "obsidian" },
    workspace = "2",
})

-- Assign Spotify to its special workspace
hl.window_rule({
  match = { class = "Spotify" },
  workspace = "special:spotify silent",
  opacity = "0.85 override 0.80 override",
  float = true,
  size = {"monitor_w*0.75", "monitor_h*0.75"},
  center = true,
  border_color = "rgb(1ED760) rgb(0D6E30)",  -- Spotify green
})

-- Optional: float and size it like a panel
-- hl.window_rule({ match = { class = "Spotify" }, float = true })
-- hl.window_rule({ match = { class = "Spotify" }, size = { 1400, 900 } })
-- hl.window_rule({ match = { class = "Spotify" }, center = true })

-- Toggle the special workspace
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("spotify"))

hl.workspace_rule({
  workspace = "special:spotify",
  on_created_empty = "spotify",
})
