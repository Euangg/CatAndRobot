extends Control

signal save
signal other


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		other.emit()
		print("other")

func _on_button_pressed() -> void:
	save.emit()
	print("save")
