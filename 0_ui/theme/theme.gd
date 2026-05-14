extends Control

func _ready() -> void:
	if FileAccess.file_exists("user://data_2.sav"):pass
	else:%Button2.disable()

func _on_button_pressed() -> void:
	Global.is_load=false
	Global.switch_scene(Global.UI_PLAY)

func _on_button_2_pressed() -> void:
	Global.is_load=true
	Global.switch_scene(Global.UI_PLAY)

func _on_button_3_pressed() -> void:get_tree().quit()
