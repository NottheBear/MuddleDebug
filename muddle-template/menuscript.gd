extends Control
var stuprid = 0 

var jiggle_physics_max = ["troble ", "fugle ", "puddle ", "cuddle ", "double ", "married couple "]

func lsblk() -> void:
	$Label.text = "muddle " + jiggle_physics_max.pick_random() + jiggle_physics_max.pick_random() + jiggle_physics_max.pick_random()

func _ready() -> void:
	lsblk()

func _on_bsutton_pressed() -> void:
	lsblk()

func stupid() -> void:
	$Label2.show()
	$Timer.start()

func _on_timer_timeout() -> void:
	$Label2.hide()
	$Sprite2D.hide()

func _on_button_pressed() -> void:
	stupid()

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_3_pressed() -> void:
	stuprid += 1
	if stuprid == 10:
		$Label2.text = "BEEH"
		$Sprite2D.show()
		$Label2.show()
		$Timer.start()
		$AudioStreamPlayer2.play()
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer3.play()
