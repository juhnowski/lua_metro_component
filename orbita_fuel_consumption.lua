local orbita_fuel_consumption = {}

--[[
Слайд 1 Средний расход л/100 км
]]

function orbita_fuel_consumption.init()
	box.schema.space.create('fuel_cons')
	box.space.fuel_cons:create_index('primary')
end

function orbita_fuel_consumption.add(tm, m)
	box.space.fuel_cons:insert{tm, m}
end

return orbita_fuel_consumption