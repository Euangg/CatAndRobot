extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		DirAccess.remove_absolute("user://data_1.sav")
		DirAccess.remove_absolute("user://data_2.sav")
		Global.switch_scene(Global.UI_THEME)
