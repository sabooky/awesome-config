require("awful")
require("naughty")
require("wicked")


pacwidget = widget({
    type = 'textbox',
    name = 'pacwidget',
    align = "right"
})

function run_script()
    local filedescriptor = io.popen('conkypac3b.py')
    local value = filedescriptor:read()
    filedescriptor:close()
    return {value}
end

wicked.register(pacwidget, run_script, "$1", 60)

pacman = nil
function show_packages()
    local out = awful.util.pread('conkypac3.py')
    io.output('/tmp/test'):write(out)
    out = string.gsub(out, "^%s*$", "")
    pacman = naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace", out),
        timeout = 0, width = 400,
    })
end
function hide_packages()
    if pacman ~= nil then
        naughty.destroy(pacman)
        pacman = nil
    end
end

-- uncomment to display on hover
--pacwidget.mouse_enter = show_packages
pacwidget.mouse_leave = hide_packages
pacwidget:buttons(awful.util.table.join(
     awful.button({ }, 1, function () show_packages() end)
     )
)
