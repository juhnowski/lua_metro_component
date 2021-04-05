local orbita_path = {}

--[[
Слайд 1 Маршрут
]]

function orbita_path.init()
	box.schema.space.create('path')
	box.space.path:create_index('primary')	
	orbita_path.add_msk_813()
end

--[[
 forward - последовательность остановок туда
 back - последовательность остановок обратно
 --]]
function orbita_path.add(path_number, forward, back)
	box.space.path:insert{path_number, forward, back }
end

function orbita_path.add_msk_813()
	orbita_path.add(
		813,
		{
			'Старобитцевская улица',
			'Бульвар Дмитрия Донского',
			'Улица Грина',
			'Куликовская улица'
		},
		{
			'Куликовская улица',
			'Знаменские Садки',
			'Бульвар Дмитрия Донского',
			'Старобитцевская улица'
		}

	)
end

return orbita_path