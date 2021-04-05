local orbita_ip = {}

orbita_ip.ERROR_UNKNOWN = 0
orbita_ip.ERROR_ETH_NOT_REGISTERED = 1
orbita_ip.ERROR_NUM_TO_IP_ERROR = 2
orbita_ip.ERROR_NETMASK_ERROR = 3

orbita_ip.lo = 1
orbita_ip.Eth0 = 2
orbita_ip.Eth1 = 3

function orbita_ip.init()
	orbita_ip.init_space()
	orbita_ip.init_values()	
	orbita_ip.set_eth()
end

function orbita_ip.init_space()
	box.schema.space.create('ip')
	box.space.ip:create_index('primary')

	box.schema.space.create('eth')
	box.space.eth:create_index('primary')
end

function orbita_ip.init_values()
	box.space.ip:insert{orbita_ip.lo, 'lo', orbita_ip.ip_to_number(127, 0, 0, 1), orbita_ip.ip_to_number(255, 255, 255, 0)}
	box.space.ip:insert{orbita_ip.Eth0, 'Eth0', orbita_ip.ip_to_number(192, 168, 0, 2), orbita_ip.ip_to_number(255, 255, 255, 0)}
	box.space.ip:insert{orbita_ip.Eth1, 'Eth1', orbita_ip.ip_to_number(192, 168, 1, 2), orbita_ip.ip_to_number(255, 255, 255, 0)}
end


function orbita_ip.ip_to_number (aaa, bbb, ccc, ddd)
 local number = 0
 number = (aaa*16777216) + (bbb*65536) + (ccc*256) + ddd
 return number
end

function orbita_ip.number_to_ip(number)
 ddd = number % 256
 number  =  number/256
 ccc= number % 256
 number  =  number/256
 bbb = number % 256
 number  =  number/256
 aaa =  number
 return aaa, bbb, ccc, ddd
end

function orbita_ip.set(eth_number, eth_name, ip_number, netmask_number)
	box.space.ip:update({eth_number}, {{'=', 2, eth_name, ip_number, netmask_number}})
end

function orbita_ip.get(eth_number)
	ip_table = box.space.ip:select{eth_number}
	--orbita_table_util.print_r(ip_table)
	local current_ip = -1
	local current_mask = -1
	local current_eth = ''
	
	for k,v in pairs(ip_table) do
		current_ip = v[2]
		current_mask = v[3]
		current_eth = v[4]
	end

	if current_ip == -1 then
		return orbita_ip.ERROR_ETH_NOT_REGISTERED, orbita_ip.ERROR_UNKNOWN
	end

	if current_mask == -1 then
		return orbita_ip.ERROR_NETMASK_ERROR, orbita_ip.ERROR_UNKNOWN
	end

	return current_eth, ip.number_to_ip(current_ip), ip.number_to_ip(current_mask) 
end

function orbita_ip.set_eth()
	ip_table = box.space.ip:select{eth_number}
	for k,v in pairs(ip_table) do
		os.execute('ifconfig '..v[2]..' '..v[3]..' netmask '..v[4])
	end
end

box.space.ip:on_replace(orbita_ip.set_eth)

return orbita_ip