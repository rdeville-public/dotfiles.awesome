local naughty = require("naughty")
local beautiful = require("beautiful")
local create_button = require("widgets.control_center.buttons.create-button")

local initial_action = function(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  if naughty.suspended then
    background:set_bg(beautiful.cc_button_do_not_disturb_inactive)
    label:set_text("Off")
  else
    background:set_bg(beautiful.cc_button_do_not_disturb_active)
    label:set_text("On")
  end
end

local onclick_action = function()
  naughty.suspended = not naughty.suspended
end

local dnd_button =
  create_button.circle_big(beautiful.cc_do_not_disturb_icon_path)

dnd_button:connect_signal("button::press", function(self, _, _, button)
  if button == 1 then
    onclick_action()
    initial_action(self)
  end
end)

initial_action(dnd_button)

return dnd_button
