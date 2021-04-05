 local orbita_settings = {}

local cams = require "orbita_ip_cams"
local ip = require "orbita_ip_bc"
local dhcp  = require "orbita_dhcp_bc"
local gosnumber = require "orbita_gosnumber"
local dt = require "orbita_date_time"
local hdd  = require "orbita_hdd"
local rs485 = require "orbita_rs485"
local rs232 = require "orbita_rs232"
local can = require "orbita_can"
local auth = require "orbita_auth"

function orbita_settings.init(ver)
	auth.init()
	can.init()
	rs232.init()
	rs485.init()
	hdd.init()
	gosnumber.init()
	dhcp.init()
	ip.init()
end

function orbita_settings.initiated(ver)
	box.schema.space.create('settings')
    box.space.settings:create_index('primary')
    box.space.settings:insert{ver, ver}
end

return orbita_settings
