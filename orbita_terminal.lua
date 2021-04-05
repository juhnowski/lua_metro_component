local orbita_terminal = {}

--[[
 Терминал
--]]
orbita_terminal.INIT = -1
orbita_terminal.OK = 0
orbita_terminal.ERROR_UNKNOWN = 1
orbita_terminal.ERROR_SERIAL = 2
orbita_terminal.ERROR_DEVICE_NOT_FOUND = 3
orbita_terminal.ERROR_READ_RFID = 4
orbita_terminal.ERROR_READ_COORD = 5
orbita_terminal.ERROR_READ_DUT = 6

orbita_terminal.prefix = "/dev/ttyUSB"
orbita_terminal.cnt = 0
orbita_terminal.max_cnt = 10
orbita_terminal.tty_name = ""

orbita_terminal.MAX_READ_RFID_ERROR = 10
orbita_terminal.MAX_READ_COORD_ERROR = 10
orbita_terminal.MAX_READ_DUT_ERROR = 10

orbita_terminal.cnt_RFID_ERROR = 0
orbita_terminal.cnt_READ_COORD_ERROR = 0
orbita_terminal.cnt_READ_DUT_ERROR = 0

orbita_terminal.STATE_INIT = 0
orbita_terminal.STATE_RUN = 1
orbita_terminal.STATE_STOPED = 2

orbita_terminal.state = orbita_terminal.STATE_INIT

function orbita_terminal.init()
	orbita_terminal.init_space()
	orbita_terminal.init_values()
end

function orbita_terminal.init_space()
	box.schema.space.create('rfid')
	box.space.rfid:create_index('primary')

    box.schema.space.create('coord')
	box.space.coord:create_index('primary')

    box.schema.space.create('dut')
	box.space.dut:create_index('primary')

    box.schema.space.create('terminal')
	box.space.terminal:create_index('primary')
end

function orbita_camera.init_values()
	box.space.camera:insert{1, orbita_terminal.INIT}
end

function orbita_terminal.connect()
    orbita_terminal.tty_name = orbita_terminal.prefix .. orbita_terminal.cnt
    os.execute("stty -F ".. orbita_terminal.tty_name.." speed 115200 cs8 -cstopb -parenb && echo -n CMDON > " .. orbita_terminal.tty_name)
    resp = os.execute("cat " .. tty_name)
    if resp == nil or resp ~= '\r\n' then
        if cnt > orbita_terminal.max_cnt then
            err = orbita_terminal.ERROR_DEVICE_NOT_FOUND
        else
            err = orbita_terminal.ERROR_SERIAL
        end
    else
        err = orbita_terminal.OK
    end

    box.space.terminal:insert{cnt, os.clock(), err}
end

function orbita_terminal.set_err(err)
	box.space.terminal:insert{cnt, os.clock(), err}
end

function orbita_terminal.set_ok()
	box.space.terminal:insert{cnt, os.clock(), orbita_terminal.OK}
end

function orbita_terminal.read()
    return os.execute("cat " .. orbita_terminal.tty_name)
end

function orbita_terminal.read_rfid()
    os.execute("echo -n $M GET RFID > " .. orbita_terminal.tty_name)
    resp = orbita_terminal.read()
    if resp ~=nil or resp ~= "" then
       box.space.terminal:insert("rfid", datetime.datetime.now().toordinal(), resp)
    else
        orbita_terminal.set_err(orbita_terminal.ERROR_READ_RFID)
    end
end

function orbita_terminal.read_coord()
    os.execute("echo -n $M GET COORD > " .. orbita_terminal.tty_name)
    resp = orbita_terminal.read()
    if resp ~=nil or resp ~= "" then
       box.space.terminal:insert("coord", datetime.datetime.now().toordinal(), resp)
    else
        orbita_terminal.set_err(orbita_terminal.ERROR_READ_COORD)
    end
end

function orbita_terminal.read_dut()
    os.execute("echo -n $M GET DUT > " .. orbita_terminal.tty_name)
    resp = orbita_terminal.read()
    if resp ~=nil or resp ~= "" then
       box.space.terminal:insert("dut", datetime.datetime.now().toordinal(), resp)
    else
        orbita_terminal.set_err(orbita_terminal.ERROR_READ_DUT)
    end
end

function orbita_terminal.loop()
    while(orbita_terminal.state == orbita_terminal.STATE_RUN) do
        orbita_terminal.read_rfid()
        orbita_terminal.read_coord()
        orbita_terminal.read_dut()
    end
end

function orbita_terminal.clean_read_errors()
    orbita_terminal.cnt_RFID_ERROR = 0
    orbita_terminal.cnt_READ_COORD_ERROR = 0
    orbita_terminal.cnt_READ_DUT_ERROR = 0
end

function orbita_terminal.is_alive()
    if orbita_terminal.cnt_RFID_ERROR > orbita_terminal.MAX_READ_RFID_ERROR and
            orbita_terminal.cnt_COORD_ERROR > orbita_terminal.MAX_READ_COORD_ERROR and
            orbita_terminal.cnt_COORD_ERROR > orbita_terminal.MAX_READ_COORD_ERROR then
        orbita_terminal.clean_read_errors()
        orbita_terminal.set_err(orbita_terminal.ERROR_SERIAL)
    end
end

function orbita_ip.on_change_terminal()
	terminal_table = box.space.ip:select{cnt}
	for k,v in pairs(ip_table) do
        print('Соединение с терминалом: '..v[2]..' '..v[3])
        if v[3] == orbita_terminal.ERROR_SERIAL then
            orbita_terminal.state = orbita_terminal.STATE_STOP
            cnt = cnt + 1
            orbita_terminal.connect()
        elseif v[3] == orbita_terminal.INIT then
            cnt = 0
            orbita_terminal.connect()
            print("Соединение с терминалом: старт")
            orbita_terminal.state = orbita_terminal.STATE_INIT
        elseif v[3] == orbita_terminal.OK then
            line = orbita_terminal.read()
            print('Соединение с терминалом: Вошли в командный режим')
            orbita_terminal.state = orbita_terminal.STATE_RUN
            orbita_terminal.loop()
        elseif v[3] ==  orbita_terminal.ERROR_READ_RFID then
            orbita_terminal.cnt_RFID_ERROR = orbita_terminal.cnt_RFID_ERROR + 1
            orbita_terminal.is_alive()
        elseif v[3] ==  orbita_terminal.ERROR_COORD_RFID then
            orbita_terminal.cnt_COORD_ERROR = orbita_terminal.cnt_COORD_ERROR + 1
            orbita_terminal.is_alive()
        elseif v[3] ==  orbita_terminal.ERROR_COORD_DUT then
            orbita_terminal.cnt_DUT_ERROR = orbita_terminal.cnt_DUT_ERROR + 1
            orbita_terminal.is_alive()
        elseif v[3] ==  orbita_terminal.ERROR_DEVICE_NOT_FOUND then
            orbita_terminal.state = orbita_terminal.STATE_STOP
        else
            orbita_terminal.state = orbita_terminal.STATE_STOP
            orbita_terminal.set_err(orbita_terminal.ERROR_UNKNOWN)
	end
    end
end

box.space.rfid:on_replace(orbita_terminal.on_change_rfid)
box.space.coord:on_replace(orbita_terminal.on_change_coord)
box.space.dut:on_replace(orbita_terminal.on_change_dut)
box.space.terminal:on_replace(orbita_terminal.on_change_terminal)


return orbita_terminal