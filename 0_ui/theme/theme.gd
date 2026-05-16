extends Control

func _ready() -> void:
	%Label.text=ProjectSettings.get_setting("application/config/version","vx.xx")
	if FileAccess.file_exists("user://data_2.sav"):pass
	else:
		%ButtonLoad.disabled=true
		%ButtonLoad.mouse_filter=MouseFilter.MOUSE_FILTER_IGNORE
		%TextLoad.modulate.a=150/255.

func _on_button_start_pressed() -> void:
	Global.is_load=false
	Global.switch_scene(Global.UI_PLAY)

func _on_button_load_pressed() -> void:
	Global.is_load=true
	Global.switch_scene(Global.UI_PLAY)

func _on_button_quit_pressed() -> void:get_tree().quit()

func _on_button_start_mouse_entered() -> void:%TextStart.scale=Vector2(1.2,1.2)
func _on_button_start_mouse_exited() -> void:%TextStart.scale=Vector2(1,1)

func _on_button_load_mouse_entered() -> void:%TextLoad.scale=Vector2(1.2,1.2)
func _on_button_load_mouse_exited() -> void:%TextLoad.scale=Vector2(1,1)

func _on_button_quit_mouse_entered() -> void:%TextQuit.scale=Vector2(1.2,1.2)
func _on_button_quit_mouse_exited() -> void:%TextQuit.scale=Vector2(1,1)
