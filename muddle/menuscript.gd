extends Control
var stupid = 0 

func _on_timer_timeout() -> void:
	$Label2.hide()
	$Sprite2D.hide()
func _on_button_2_pressed() -> void:
	get_tree().quit()
func _on_button_3_pressed() -> void:
	stupid += 1
	if stupid == 10:
		$Label2.text = "BEEH"
		$Sprite2D.show()
		$Label2.show()
		$Timer.start()
		$AudioStreamPlayer2.play()
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer3.play()
