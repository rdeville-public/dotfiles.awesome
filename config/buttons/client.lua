local awful = require("awful")
local gears = require("gears")

local modkey = require("config.keys.mod").modkey

return gears.table.join(
  awful.button(
    {},
    1, -- Left Click
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end
  ),
  awful.button(
    { modkey },
    1, -- Left Click
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
    end
  ),
  awful.button(
    { modkey },
    3, -- Left Click
    function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
    end
  )
)
