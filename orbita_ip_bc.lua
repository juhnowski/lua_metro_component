local orbita_ip_bc = {}
local orbita_ip = require "orbita_ip"

--[[]
 ip адреса бортового компьютера/ включение dhcp;

Компонент:

Настройки БК:

Доступные сетевые интерфейсы:
   +----+-+
   | lo |v|
   +----+-+
   | lo |
   |eth0|
   |eth1|
   +----+

IP Адрес:
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+

Маска подсети
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+

Ошибки:
 +----------------------+
 |                      |
 +----------------------+
--]]
function orbita_ip_bc.init()
        box.schema.space.create('ip_bc')
        box.space.ip_bc:create_index('primary')
        box.space.ip_bc:create_index('ip',{unique=true,type='BITSET', parts={2,'unsigned'}})
        box.space.ip_bc:insert{1, orbita_ip.Eth0 }
end

function orbita_ip_bc.get()
    current_eth_table=box.space.ip_bc:select{1}
end

function orbita_ip_bc.set(eth_index)
    box.space.ip_bc:update({1}, {{'=', 2, eth_index}})
end

return orbita_ip_bc