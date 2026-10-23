extends TileMapLayer

@export var map_width: int = 210
@export var map_height: int = 50

var mud_source: int = 0
var null_atlas: Vector2i = Vector2i(0,0)

var water_source: int = 2

func _ready():
	maketerrain()
func maketerrain():
	clear()
	for x in range(map_width):
		for y in range(map_height):
			set_cell(Vector2i(x,y), mud_source, null_atlas)
			if y < 5 or y >= map_height - 5:
				set_cell(Vector2i(x,y), water_source, null_atlas)
