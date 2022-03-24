local awful = require("awful")
local beautiful = require("beautiful")
local create_button = require("widgets.control_center.buttons.create-button")

local redshift = {}

redshift.path = "/bin/redshift"
redshift.pkill = "/bin/pkill"
redshift.config = ""                    -- config file, passed to init()
redshift.state = 1                      -- 1 = running, 0 = not running

redshift.start = function()
    if redshift.state == 0
    then
        awful.util.spawn(redshift.path .. " -c " .. redshift.config)
        redshift.state = 1
    end
end

redshift.stop = function()
    if redshift.state == 1
    then
        awful.util.spawn(redshift.pkill .. " redshift ")
        redshift.state = 0
    end
end

redshift.toggle = function()
    if redshift.state == 0
    then
        redshift.start()
    else
        redshift.stop()
    end
end

local initial_action = function(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  if redshift.state == 1 then
    background:set_bg(beautiful.cc_button_redshift_active)
    label:set_text("On")
  else
    background:set_bg(beautiful.cc_button_redshift_inactive)
    label:set_text("Off")
  end
end

local onclick_action = function ()
  redshift.toggle()
end


local redshift_button = create_button.circle_big(beautiful.cc_redshift_icon_path)

redshift_button:connect_signal("button::press", function (self, _, _, button)
  if button == 1 then
    onclick_action()
    initial_action(self)
  end
end)

initial_action(redshift_button)

return redshift_button

