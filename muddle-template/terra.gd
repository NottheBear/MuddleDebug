extends TileMapLayer

@export var map_width: int = 200
@export var map_height: int = 50

var mud_source: int = 0
var box_source: int = 3
var null_atlas: Vector2i = Vector2i(0,0)

var dugmud_source: int = 1

var water_source: int = 2
var water_atlas: Vector2i = Vector2i(1,0)

var water_swap: bool = false

func _ready():
	maketerrain()
	water_timer()
	drone_box()
func maketerrain():
	clear()
	for x in range(map_width):
		for y in range(map_height):
			set_cell(Vector2i(x,y), mud_source, null_atlas)
			if y < 5 or y >= map_height - 5:
				if (x + y) % 2 == 0:
					set_cell(Vector2i(x,y), water_source, null_atlas)
				else:
					set_cell(Vector2i(x,y), water_source, water_atlas)
func water_timer():
	var watertime = $Timer
	watertime.timeout.connect(func():
		water_swap = not water_swap
		for coords in get_used_cells_by_id(2):
			var is_even = (coords.x + coords.y) % 2 == 0
			var active_atlas = water_atlas if (is_even == water_swap) else null_atlas
			set_cell(coords, water_source, active_atlas)
	)
func drone_box():
	var randomx = randi_range(1, map_width - 1)
	var centerofbox = Vector2i(randomx, 5)
	set_cell(centerofbox, box_source, null_atlas)
	set_cell(Vector2i(randomx - 1, 5), dugmud_source, null_atlas)
	set_cell(Vector2i(randomx + 1, 5), dugmud_source, null_atlas)
