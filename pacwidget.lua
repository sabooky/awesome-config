require("awful")
require("naughty")
require("wicked")

-- config
notify_file = os.getenv("HOME") .. "/.config/awesome/scripts/pacawe-notify.conf"
breif_file = os.getenv("HOME") .. "/.config/awesome/scripts/pacawe-breif.conf"

-- create pacman widget
pacwidget = widget({
    type = 'textbox',
    name = 'pacwidget',
    align = "right"
})
-- function to populate widget text
function run_script()
    local filedescriptor = io.popen('pacawe.py ' .. breif_file)
    local value = filedescriptor:read()
    filedescriptor:close()
    return {value}
end
-- register widget with function, run every 60 seconds
wicked.register(pacwidget, run_script, "$1", 60)

-- notify show/hide functions
function show_packages()
    local out = awful.util.pread('pacawe.py ' .. notify_file)
    out = string.gsub(out, "^%s*$", "")
    pacman = naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace", out),
        timeout = 0, width = 400,
    })
end
function hide_packages()
    naughty.destroy(pacman)
end

-- events
-- uncomment to display on hover
--pacwidget.mouse_enter = show_packages
pacwidget.mouse_leave = hide_packages
-- display on mouse click
pacwidget:buttons(awful.util.table.join(
     awful.button({ }, 1, function () show_packages() end)
     )
)
