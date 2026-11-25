extends CharacterBody2D

@export var splotch: Sprite2D

const SPEED = 200.0
const GRAVITY = 400.0
const TERMINALVELOCITY := 400.0

var picked_up: bool = false

func _process(_delta: float) -> void:
	if splotch:
		splotch.global_position = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("ui_up"):
		velocity.y = move_toward(velocity.y, -TERMINALVELOCITY, SPEED * delta)
	elif not is_on_floor():
		velocity.y = move_toward(velocity.y, TERMINALVELOCITY, GRAVITY * delta)
	if is_on_floor():
		velocity.x = 0 # no ground movement
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var crust = %Crust
		var tile_pos = crust.local_to_map(crust.to_local(get_global_mouse_position()))
		var current_source = crust.get_cell_source_id(tile_pos)
		var drone_pos = crust.local_to_map(crust.to_local(global_position))
		var distance = max(abs(drone_pos.x - tile_pos.x), abs(drone_pos.y - tile_pos.y))
		if distance == 1:
			if not picked_up:
				if current_source == crust.mud_source:
					crust.set_cells_terrain_connect([tile_pos], 0, 0)
					picked_up = true
					splotch.visible=true
			else:
				if current_source == crust.dugmud_source:
					crust.set_cell(tile_pos, crust.mud_source, crust.null_atlas)
					picked_up = false
					splotch.visible=false
