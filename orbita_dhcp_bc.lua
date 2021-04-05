local orbita_dhcp_bc = {}
local orbita_ip = require "orbita_ip"
--[[
   настройки / включение dhcp бортового компьютера;

Компонент:

Сетевой интерфейс:
   +----+-+
   |eth0|v|
   +----+-+
   | lo |
   |eth0|
   |eth1|
   +----+

Подсеть:
+---+ +---+ +---+ +---+
|aaa| |bbb| |ccc| |ddd|
+---+ +---+ +---+ +---+

Маска сети:
+---+ +---+ +---+ +---+
|aaa| |bbb| |ccc| |ddd|
+---+ +---+ +---+ +---+

Начальный IP адрес:
+---+ +---+ +---+ +---+
|aaa| |bbb| |ccc| |ddd|
+---+ +---+ +---+ +---+

Конечный IP адрес:
+---+ +---+ +---+ +---+
|aaa| |bbb| |ccc| |ddd|
+---+ +---+ +---+ +---+

Широковещательный адрес:
+---+ +---+ +---+ +---+
|aaa| |bbb| |ccc| |ddd|
+---+ +---+ +---+ +---+

          +-+
Включить  |X|
          +-+
--]]
function orbita_dhcp_bc.init()
    orbita_dhcp_bc.init_space()
    orbita_dhcp_bc.init_values()
    orbita_dhcp_bc.on_change_eth()
end

function orbita_dhcp_bc.init_space()
    box.schema.space.create('dhcp_bc')
    box.space.dhcp_bc:create_index('primary')
end

function orbita_dhcp_bc.init_values()
    box.space.dhcp_bc:insert{1, ip.ip_to_number(192,168,0,1)}
    box.space.dhcp_bc:insert{2, ip.ip_to_number(255,255,255,0)}
    box.space.dhcp_bc:insert{3, ip.ip_to_number(192,168,0,2)}
    box.space.dhcp_bc:insert{4, ip.ip_to_number(1192,168,0,254)}
    box.space.dhcp_bc:insert{5, ip.ip_to_number(192,168,0,255)}
    box.space.dhcp_bc:insert{6, 0} --[ 0-выкл, 1-вкл --]
    box.space.dhcp_bc:insert{7, orbita_ip.Eth0 }
end

function orbita_dhcp_bc.get_subnet()
    return ip.number_to_ip(box.space.dhcp_bc:select{1})
end

function orbita_dhcp_bc.get_subnet_mask()
    return ip.number_to_ip(box.space.dhcp_bc:select{2})
end

function orbita_dhcp_bc.get_start_ip()
    return ip.number_to_ip(box.space.dhcp_bc:select{3})
end

function orbita_dhcp_bc.get_end_ip()
    return ip.number_to_ip(box.space.dhcp_bc:select{4})
end

function orbita_dhcp_bc.get_broadcast_ip()
    return ip.number_to_ip(box.space.dhcp_bc:select{5})
end

function orbita_dhcp_bc.get_eth()
    return ip.number_to_ip(box.space.dhcp_bc:select{7})
end

function orbita_dhcp_bc.get_eth_name()
    eth_index = box.space.dhcp_bc:select{7}
    eth,ip,mask = orbita_ip.get(eth_index)
    return eth
end

function orbita_dhcp_bc.get_dhcp_on()
    return box.space.dhcp_bc:select{6}
end

function orbita_dhcp_bc.set_subnet(aaa,bbb,ccc,ddd)
    box.space.dhcp_bc:update({1}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})
end

function orbita_dhcp_bc.set_subnet_mask(aaa,bbb,ccc,ddd)
    box.space.dhcp_bc:update({2}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})
end

function orbita_dhcp_bc.set_start_ip(aaa,bbb,ccc,ddd)
    box.space.dhcp_bc:update({3}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})
end

function orbita_dhcp_bc.set_end_ip(aaa,bbb,ccc,ddd)
    box.space.dhcp_bc:update({4}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})
end

function orbita_dhcp_bc.set_broadcast_ip(aaa,bbb,ccc,ddd)
    box.space.dhcp_bc:update({5}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})
end

function orbita_dhcp_bc.set_on(a)

    if a
        then box.space.dhcp_bc:update({6}, {{'=', 2, 1}})
        else box.space.dhcp_bc:update({6}, {{'=', 2, 0}})
    end

    
    eth_name = orbita_dhcp_bc.get_eth_name()
    local shell_script = '
        #!/bin/bash

        FILE="/etc/network/interfaces"

        /bin/cat <<EOM >$FILE

        auto '..eth_name..'
        iface '..eth_name..' inet dhcp
        EOM
    '
    if a
        os.execute('ifdown '..eth_name)
        os.execute(shell_script)
        os.execute('ifup '..eth_name)
    end
end

function orbita_dhcp_bc.set_eth(eth_index)
    box.space.dhcp_bc:update({7}, {{'=', 2, eth_index}})
end

function orbita_dhcp_bc.on_change_eth()
    orbita_dhcp_bc.set_on(orbita_dhcp_bc.get_dhcp_on())
end

box.space.ip:on_replace(orbita_dhcp_bc.on_change_eth)

return orbita_dhcp_bc