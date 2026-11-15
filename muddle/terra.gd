extends TileMapLayer

@export var drone = CharacterBody2D
@export var map_width: int = 200
@export var map_height: int = 50
@export var cave_threshold: float = 0.2 #higher for small caves

var noise = FastNoiseLite.new()

var mud_source: int = 0
var box_source: int = 3
var box_bottom_source: int = 4
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
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.2
	noise.seed = randi()
	var cave_cells: Array[Vector2i] = []
	clear()
	for x in range(map_width):
		for y in range(5, map_height-5):
			set_cell(Vector2i(x,y), mud_source, null_atlas)
			var pos = Vector2i(x,y)
			var val = noise.get_noise_2d(x,y)
			if val > cave_threshold:
				cave_cells.append(pos)
	set_cells_terrain_connect(cave_cells, 0, 0)
	for x in range(map_width):
		for y in range(0, 5):
			if (x + y) % 2 == 0:
				set_cell(Vector2i(x,y), water_source, null_atlas)
			else:
				set_cell(Vector2i(x,y), water_source, water_atlas)
		for y in range(map_height-5, map_height):
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
	set_cell(Vector2i(randomx - 1, 5), dugmud_source, Vector2i(2,0))
	set_cell(Vector2i(randomx + 1, 5), dugmud_source, Vector2i(0,2))
	set_cell(Vector2i(randomx - 2, 5), mud_source, null_atlas)
	set_cell(Vector2i(randomx + 2, 5), mud_source, null_atlas)
	set_cell(Vector2i(randomx - 1, 6), mud_source, null_atlas)
	set_cell(Vector2i(randomx + 1, 6), mud_source, null_atlas)
	set_cell(Vector2i(randomx, 6), box_bottom_source, null_atlas)
	var tile_size = 32
	drone.global_position = Vector2((randomx * tile_size)+16, (5 * tile_size)+16)
