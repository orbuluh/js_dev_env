-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = wezterm.config_builder()
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- Default config settings
-- These are the default config settins needed to use Wezterm
-- Just add this and return config and that's all the basics you need

-- Color scheme, Wezterm has 100s of them you can see here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Oceanic Next (Gogh)'
config.font = wezterm.font('Hack Nerd Font')
config.font_size = 11
config.launch_menu = launch_menu
config.audible_bell = 'Disabled'

-- makes my cursor blink
config.default_cursor_style = 'BlinkingBar'

config.disable_default_key_bindings = false

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 1000
}

-- this adds the ability to use ctrl+v to paste the system clipboard
config.keys = {{
    key = 'V',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard'
}, {
    -- testing of LEADER:  ctrl+a --> r, sending woot!
    key = 'R',
    mods = 'LEADER',
    action = act.SendString 'woot'
}}

-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click.
mouse_bindings = { -- Change the default click behavior so that it only selects
-- text and doesn't open hyperlinks
{
    event = {
        Up = {
            streak = 1,
            button = "Left"
        }
    },
    mods = "NONE",
    action = act.CompleteSelection "PrimarySelection"
}, -- select to copy(not wezterm copy mode), and paste if don't select anything
{
    event = {
        Down = {
            streak = 1,
            button = 'Right'
        }
    },
    mods = 'NONE',
    action = act.PasteFrom "Clipboard"
}, -- CTRL-Click open hyperlinks
{
    event = {
        Up = {
            streak = 1,
            button = "Left"
        }
    },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor
}, -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
-- https://wezfurlong.org/wezterm/config/mouse.html?highlight=Ctrl-click#gotcha-on-binding-an-up-event-only
{
    event = {
        Down = {
            streak = 1,
            button = "Left"
        }
    },
    mods = "CTRL",
    action = act.Nop
}, -- Grap the semantic zone when triple click
{
    event = {
        Down = {
            streak = 3,
            button = "Left"
        }
    },
    mode = "NONE",
    action = act.SelectTextAtMouseCursor("SemanticZone")
}}

config.mouse_bindings = mouse_bindings

-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.2,
    brightness = 1.5
}

-- IMPORTANT: Sets WSL2 UBUNTU-22.04 as the defualt when opening Wezterm
config.default_domain = 'WSL:Ubuntu'

-- Or, specify with NixOS
-- config.default_domain = 'WSL:NixOS'

return config
