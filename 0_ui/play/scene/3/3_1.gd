extends Control

var touched=false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left") and !touched:
		var rect:Rect2=%Button.get_rect()
		if rect.has_point(get_global_mouse_position()):
			if Global.can_touch:
				print("touched")
				get_tree().paused=true
				%TextureCover.show()
				%Timer.start()
				touched=true
				Global.is_touch=1

func _on_timer_timeout() -> void:
	get_tree().paused=false
	%TextureCover.hide()
