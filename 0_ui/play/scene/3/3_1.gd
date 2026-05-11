extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		if Global.can_touch:
			var rect:Rect2=%ColorRect.get_rect()
			if rect.has_point(get_global_mouse_position()):
				print("touched")
				get_tree().paused=true
				%TextureCover.show()
				%Timer.start()
				Global.can_touch=false
				Global.is_touch=1

func _physics_process(delta: float) -> void:pass

func _on_timer_timeout() -> void:
	get_tree().paused=false
	%TextureCover.hide()
