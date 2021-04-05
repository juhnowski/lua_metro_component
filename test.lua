#!/usr/bin/tarantool
local settings = require "orbita_settings"
local auth = require "orbita_auth"
local orbita_can = require "orbita_can"
local msgpack = require('msgpack')
local orbita_table_util = require('orbita_table_util')
local orbita_askp = require('orbita_askp')
local orbita_askp_errors = require('orbita_askp_errors')
local orbita_bk = require('orbita_bk')
local orbita_bk_errors = require('orbita_bk_errors')
local orbita_camera = require('orbita_camera')
local orbita_camera_errors = require('orbita_camera_errors')
local orbita_date_time = require('orbita_date_time')

box.cfg{}
--[[
settings.init()
]]


local is_first_start = false

local ok = 0
local wrong = 0


print("orbita_auth.lua ***************************************")

username1 = ''..os.date("User%d%H%M%S")
auth.create_user(username1, username1)
if  auth.auth(username1, username1) 	then
	print("[OK] orbita_auth.create_user")
	ok = ok + 1
else
	wrong = wrong + 1
	print("[ERROR] orbita_auth.create_user")
end

auth.delete_user(username1)
if  auth.auth(username1, username1) 	then
	print("[ERROR] orbita_auth.delete_user")
	wrong = wrong + 1

else
	ok = ok + 1
	print("[OK] orbita_auth.delete_user")	
end

print("orbita_can.lua ***************************************") 

if is_first_start then
--	orbita_can.init_space()
	orbita_can.init_values()
end

can_list_table = box.space.can_list:select{}
-- can.get_can_list()
local can_list_table_cnt = 0
	for k,v in pairs(can_list_table) do
		print(k,v)
		can_list_table_cnt = can_list_table_cnt + 1
	end

if can_list_table_cnt>0 then
	ok = ok + 1
	print("[OK] orbita_can.get_can_list")	
else
	print("[ERROR] orbita_can.get_can_list")
	wrong = wrong + 1
end

local current_can = 0
current_can_table = orbita_can.get_can()
	for k,v in pairs(current_can_table) do
		print(k,v)
		current_can = v[1]
		print("current_can =" .. current_can)
	end

if current_can == 1 then
	ok = ok + 1
	print("[OK] orbita_can.get_can")	
else
	print("[ERROR] orbita_can.get_can")
	orbita_table_util.print_r(current_can)
	wrong = wrong + 1
end

print("orbita_askp.lua ***************************************") 
if is_first_start then
	--orbita_askp.init()
	orbita_askp.init_values()
end

for door = 1,3,1 do
	orbita_askp.set_ok(door)

	res = orbita_askp.get(door)

	if res == orbita_askp.OK then
		ok = ok + 1
		print("[OK] orbita_askp.set_ok(".. door..")")	
	else
		print("[ERROR] orbita_askp.set_ok("..door..")")
		wrong = wrong + 1	
	end
end


for door = 1,3,1 do
	orbita_askp.set_err(door, door+1)

	res = orbita_askp.get(door)

	if res == door+1 then
		ok = ok + 1
		print("[OK] orbita_askp.set_err(".. door..")")	
	else
		print("[ERROR] orbita_askp.set_err("..door..")")
		wrong = wrong + 1	
	end
end

print("orbita_askp_errors.lua ***************************************") 
if is_first_start then
	orbita_askp_errors.init_space()
	orbita_askp_errors.init_values()
end

for err_code = 1,3,1 do
	orbita_askp_errors_table = orbita_askp_errors.get(err_code)
	for k,v in pairs(orbita_askp_errors_table) do
		print(k,v)
		if v[1] == err_code then
			ok = ok + 1
			print("[OK] orbita_askp_errors.get(".. err_code..")")	
		else
			print("[ERROR] orbita_askp_errors.get("..err_code ..")")
			wrong = wrong + 1	
		end
	end
end

print("orbita_bk.lua ***************************************") 
if is_first_start then
	orbita_bk.init()
	orbita_bk.init_values()
end

orbita_bk.set_ok()

res = orbita_bk.get()

if res == orbita_bk.OK then
	ok = ok + 1
	print("[OK] orbita_bk.set_ok()")	
else
	print("[ERROR] orbita_bk.set_ok()")
	wrong = wrong + 1	
end


orbita_bk.set_err(orbita_bk.ERROR_UNKNOWN)

res = orbita_bk.get()

if res == orbita_bk.ERROR_UNKNOWN then
	ok = ok + 1
	print("[OK] orbita_bk.set_err(orbita_bk.ERROR_UNKNOWN)")	
else
	print("[ERROR] orbita_bk.set_err(orbita_bk.ERROR_UNKNOWN)")
	wrong = wrong + 1	
end



print("orbita_bk_errors.lua ***************************************") 
if is_first_start then
	orbita_bk_errors.init_space()
	orbita_bk_errors.init_values()
end

for err_code = 1,6,1 do
	orbita_bk_errors_table = orbita_bk_errors.get(err_code)
	for k,v in pairs(orbita_bk_errors_table) do
		print(k,v)
		if v[1] == err_code then
			ok = ok + 1
			print("[OK] orbita_bk_errors.get(".. err_code..")")	
		else
			print("[ERROR] orbita_bk_errors.get("..err_code ..")")
			wrong = wrong + 1	
		end
	end
end

print("orbita_camera.lua ***************************************") 
if is_first_start then
	orbita_camera.init_space()
	orbita_camera.init_values()
end

orbita_camera.set_ok()

res = orbita_camera.get()

if res == orbita_camera.OK then
	ok = ok + 1
	print("[OK] orbita_camera.set_ok()")	
else
	print("[ERROR] orbita_camera.set_ok()")
	wrong = wrong + 1	
end


orbita_camera.set_err(orbita_camera.ERROR_UNKNOWN)

res = orbita_camera.get()

if res == orbita_camera.ERROR_UNKNOWN then
	ok = ok + 1
	print("[OK] orbita_camera.set_err(orbita_camera.ERROR_UNKNOWN)")	
else
	print("[ERROR] orbita_camera.set_err(orbita_camera.ERROR_UNKNOWN)")
	wrong = wrong + 1	
end

print("orbita_camera_errors.lua ***************************************") 
if is_first_start then
	orbita_camera_errors.init_space()
	orbita_camera_errors.init_values()
end

for err_code = 1,10,1 do
	orbita_camera_errors_table = orbita_camera_errors.get(err_code)
	for k,v in pairs(orbita_camera_errors_table) do
		print(k,v)
		if v[1] == err_code then
			ok = ok + 1
			print("[OK] orbita_camera_errors.get(".. err_code..")")	
		else
			print("[ERROR] orbita_camera_errors.get("..err_code ..")")
			wrong = wrong + 1	
		end
	end
end

print("orbita_date_time.lua *******************************************")
--if is_first_start then
	--orbita_date_time.init_space()
	--orbita_date_time.init_values()
--end

day = orbita_date_time.get_day()

if day then
	ok = ok + 1
	print("[OK] orbita_date_time.get_day() day="..day)	
else
	print("[ERROR] orbita_date_time.get_day()")
	wrong = wrong + 1	
end

month = orbita_date_time.get_month()
if month then
	ok = ok + 1
	print("[OK] orbita_date_time.get_month() month="..month)	
else
	print("[ERROR] orbita_date_time.get_month()")
	wrong = wrong + 1	
end

year = orbita_date_time.get_year()
if year then
	ok = ok + 1
	print("[OK] orbita_date_time.get_year() year="..year)	
else
	print("[ERROR] orbita_date_time.get_year()")
	wrong = wrong + 1	
end

hours = orbita_date_time.get_hours()
if hours then
	ok = ok + 1
	print("[OK] orbita_date_time.get_hours() hours="..hours)	
else
	print("[ERROR] orbita_date_time.get_hours()")
	wrong = wrong + 1	
end

minutes = orbita_date_time.get_minutes()
if minutes then
	ok = ok + 1
	print("[OK] orbita_date_time.get_minutes() minutes="..minutes)	
else
	print("[ERROR] orbita_date_time.get_minutes()")
	wrong = wrong + 1	
end

secundes = orbita_date_time.get_secundes()
if secundes then
	ok = ok + 1
	print("[OK] orbita_date_time.get_secundes() secundes="..secundes)	
else
	print("[ERROR] orbita_date_time.get_secundes()")
	wrong = wrong + 1	
end


new_day = "01"
new_month = "01"
new_year = "2020"
new_h = "01"
new_m = "02"
new_s = "03"

orbita_date_time.set_date(new_day,new_month,new_year)
orbita_date_time.set_time(new_h, new_m, new_s)
print(os.date("%Y-%m-%d %H:%M:S"))

add_list_table = orbita_date_time.get_add_list()
add_list_cnt = 0

for k,v in pairs(add_list_table) do
	print(k,v)
	add_list_cnt = add_list_cnt + 1
end

if add_list_cnt == 3 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_add_list()")	
else
	print("[ERROR] orbita_date_time.get_add_list()")
	wrong = wrong + 1	
end

mode_list_table = orbita_date_time.get_mode_list()
mode_list_cnt = 0

for k,v in pairs(mode_list_table) do
	print(k,v)
	mode_list_cnt = mode_list_cnt + 1
end

if mode_list_cnt == 3 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_mode_list()")	
else
	print("[ERROR] orbita_date_time.get_mode_list()")
	wrong = wrong + 1	
end



month_list_table = orbita_date_time.get_month_list()
month_list_cnt = 0

for k,v in pairs(month_list_table) do
	print(k,v)
	month_list_cnt = month_list_cnt + 1
end

if month_list_cnt == 12 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_month_list()")	
else
	print("[ERROR] orbita_date_time.get_month_list()")
	wrong = wrong + 1	
end


week_list_table = orbita_date_time.get_week_list()
week_list_cnt = 0

for k,v in pairs(week_list_table) do
	print(k,v)
	week_list_cnt = week_list_cnt + 1
end

if week_list_cnt == 5 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_week_list()")	
else
	print("[ERROR] orbita_date_time.get_week_list()")
	wrong = wrong + 1	
end

dweek_list_table = orbita_date_time.get_dweek_list()
dweek_list_cnt = 0

for k,v in pairs(dweek_list_table) do
	print(k,v)
	dweek_list_cnt = dweek_list_cnt + 1
end

if dweek_list_cnt == 7 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_dweek_list()")	
else
	print("[ERROR] orbita_date_time.get_dweek_list()")
	wrong = wrong + 1	
end



format_date_list_table = orbita_date_time.get_format_date_list()
format_date_list_cnt = 0

for k,v in pairs(format_date_list_table) do
	print(k,v)
	format_date_list_cnt = format_date_list_cnt + 1
end

if format_date_list_cnt == 7 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_format_date_list()")	
else
	print("[ERROR] orbita_date_time.get_format_date_list()")
	wrong = wrong + 1	
end

zone_list_table = orbita_date_time.get_zone_list()
zone_list_cnt = 0

for k,v in pairs(zone_list_table) do
	print(k,v)
	zone_list_cnt = zone_list_cnt + 1
end

if zone_list_cnt == 7 then
	ok = ok + 1
	print("[OK] orbita_date_time.get_zone_list()")	
else
	print("[ERROR] orbita_date_time.get_zone_list()")
	wrong = wrong + 1	
end

orbita_date_time.set_gnss(true)
gnss_res = orbita_date_time.get_gnss()

if gnss_res then
	ok = ok + 1
	print("[OK] orbita_date_time.set_gnss(true)")	
else
	print("[ERROR] orbita_date_time.set_gnss(true)")
	wrong = wrong + 1	
end

orbita_date_time.set_videoserver(true)
videoserver_res = orbita_date_time.get_videoserver()

if videoserver_res then
	ok = ok + 1
	print("[OK] orbita_date_time.set_videoserver(true)")	
else
	print("[ERROR] orbita_date_time.set_videoserver(true)")
	wrong = wrong + 1	
end

orbita_date_time.set_sync(true)
sync_res = orbita_date_time.get_sync()

if sync_res then
	ok = ok + 1
	print("[OK] orbita_date_time.set_sync(true)")	
else
	print("[ERROR] orbita_date_time.set_sync(true)")
	wrong = wrong + 1	
end

orbita_date_time.set_activ(true)
activ_res = orbita_date_time.get_activ()

if activ_res then
	ok = ok + 1
	print("[OK] orbita_date_time.set_activ(true)")	
else
	print("[ERROR] orbita_date_time.set_activ(true)")
	wrong = wrong + 1	
end

for format_date_index = 1,3,1 do
	orbita_date_time.set_format_date(format_date_index)	
	format_date_table = orbita_date_time.get_format_date()
	for k,v in pairs(format_date_table) do
		print(k,v)
		if v[1] == format_date_index then
			ok = ok + 1
			print("[OK] orbita_date_time.get_format_date(".. format_date_index..")")	
		else
			print("[ERROR] orbita_date_time.get_format_date("..format_date_index..")")
			wrong = wrong + 1	
		end
	end
end

for format_time_index = 1,2,1 do
	orbita_time_time.set_format_time(format_time_index)	
	format_time_table = orbita_date_time.get_format_time()
	for k,v in pairs(format_time_table) do
		print(k,v)
		if v[1] == format_time_index then
			ok = ok + 1
			print("[OK] orbita_date_time.get_format_time(".. format_time_index..")")	
		else
			print("[ERROR] orbita_date_time.get_format_time("..format_time_index..")")
			wrong = wrong + 1	
		end
	end
end

for zone_index = 1,26,1 do
	orbita_time_time.set_zone(zone_index)	
	zone_table = orbita_date_time.get_zone()
	for k,v in pairs(zone_table) do
		print(k,v)
		if v[1] == zone_index then
			ok = ok + 1
			print("[OK] orbita_date_time.get_zone(".. zone_index..")")	
		else
			print("[ERROR] orbita_date_time.get_zone("..zone_index..")")
			wrong = wrong + 1	
		end
	end
end

print("------------------")
print("Ok: ", ok)
print("Wrong: ", wrong)
print("TOTAL: ", ok + wrong)
print("------------------")