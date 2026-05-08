extends Control


func _on_button_pressed() -> void:
	print("pressed")
	get_tree().paused=true
	%Timer.start()
	%Button.queue_free()

func _on_timer_timeout() -> void:
	get_tree().paused=false
