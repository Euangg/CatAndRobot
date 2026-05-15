class_name Selection
extends Control

signal select_1
signal select_2

var str_selection_1:String=""
var str_selection_2:String=""

func _ready() -> void:
	%Label.text=(str_selection_1)
	%Label2.text=(str_selection_2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		print("get lllllll")


func _on_button_pressed() -> void:select_1.emit()
func _on_button_2_pressed() -> void:select_2.emit()
