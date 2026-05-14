extends TextureButton


func disable():
	disabled=true
	modulate.a=150/255.

func activate():
	disabled=false
	modulate.a=1


func _on_mouse_entered() -> void:
	%Label.add_theme_font_size_override("font_size",72)


func _on_mouse_exited() -> void:
	%Label.add_theme_font_size_override("font_size",60)

const SFX = preload("uid://bk3dmde12cgqj")

func _on_pressed() -> void:
	Global.play_sfx(SFX)
