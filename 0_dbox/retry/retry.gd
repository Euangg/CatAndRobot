class_name Retry
extends Control

signal select

func _on_button_pressed() -> void:
	select.emit()
	queue_free()
