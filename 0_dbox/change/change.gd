extends Control

signal event
signal end

func out_event():event.emit()
func out_end():end.emit()


func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("mouse_left"):%AnimationPlayer.play("change")
	pass
