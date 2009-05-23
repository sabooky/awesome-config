require("awful")
require("naughty")
require("wicked")


-- {{ My Date Widget/calendar definitions
calwidget = widget({
    type = 'textbox',
    name = 'calwidget',
    align = "right"
})

wicked.register(calwidget, wicked.widgets.date,
  '<span color="red">%a %b %d</span>, <span color="green">%I:%M %p</span>')


-- calendar for date widget
local calendar = nil
local offset = 0

function remove_calendar()
    if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
    end
end

function add_calendar(inc_offset)
    local save_offset = offset
    remove_calendar()
    offset = save_offset + inc_offset
    local datespec = os.date("*t")
    datespec = datespec.year * 12 + datespec.month - 1 + offset
    datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
    local cal = awful.util.pread("cal " .. datespec)
    cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
    calendar = naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace", cal),
        timeout = 0, hover_timeout = 0.5,
        width = 165,
    })
end


calwidget.mouse_leave = remove_calendar
-- uncomment to display on hover
-- calwidget.mouse_enter = function() add_calendar(0) end

calwidget:buttons(awful.util.table.join(
     awful.button({ }, 1, function () add_calendar(0) end),
     awful.button({ }, 4, function () add_calendar(-1) end),
     awful.button({ }, 5, function () add_calendar(1) end)
     )
)
