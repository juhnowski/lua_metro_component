 local orbita_ip_cams = {}
local ip = require "orbita_ip"

--[[
 ip адреса подключаемых ip камер
 
 Компонент:
 
 Камера 1
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+

 Камера 2
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 3
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 4
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 5
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 6
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 7
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+

 Камера 8
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
 
 Камера 9
 +---+ +---+ +---+ +---+
 |aaa| |bbb| |ccc| |ddd|
 +---+ +---+ +---+ +---+
--]]

function orbita_ip_cams.init()
 box.schema.space.create('ip_cams')
 box.space.ip_cams:create_index('primary')
 box.space.ip_cams:create_index('ip',{unique=true,type='BITSET', parts={2,'unsigned'}})
 box.space.ip_cams:insert{1,ip.ip_to_number(192,168,1,1)}
 box.space.ip_cams:insert{2,ip.ip_to_number(192,168,1,2)}
 box.space.ip_cams:insert{3,ip.ip_to_number(192,168,1,3)}
 box.space.ip_cams:insert{4,ip.ip_to_number(192,168,1,4)}
 box.space.ip_cams:insert{5,ip.ip_to_number(192,168,1,5)}
 box.space.ip_cams:insert{6,ip.ip_to_number(192,168,1,6)}
 box.space.ip_cams:insert{7,ip.ip_to_number(192,168,1,7)}
 box.space.ip_cams:insert{8,ip.ip_to_number(192,168,1,8)}
 box.space.ip_cams:insert{9,ip.ip_to_number(192,168,1,9)}
end

function orbita_ip_cams.set(cam_num, aaa, bbb, ccc, ddd)
    box.space.ip_cams:update({cam_num}, {{'=', 2, ip.ip_to_number (aaa, bbb, ccc, ddd)}})

end

function orbita_ip_cams.get(cam_num)
    return ip.number_to_ip(box.space.ip_cams:select{cam_num})
end

return orbita_ip_cams