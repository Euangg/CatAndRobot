extends Node

var exe_path:String
var is_limit_exist:bool=true
func _ready() -> void:
	print("global load")
	var path_has_exe=OS.get_executable_path()
	exe_path=path_has_exe.get_base_dir()
	load_data_1()
	#
	var file_name=exe_path.path_join("Limitation.exe")
	is_limit_exist=FileAccess.file_exists(file_name)
	print(file_name,",",is_limit_exist)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("k"):OS.shell_show_in_file_manager(Global.exe_path)

func play_bgm(path_bgm:String):
	%Bgm.stream=load(path_bgm)
	%Bgm.play()
func stop_bgm():%Bgm.stop()
func _on_bgm_finished() -> void:%Bgm.play()

const SFX = preload("uid://dymjeykxtkdun")
func play_sfx(stream:AudioStream):
	var sfx:AudioStreamPlayer=SFX.instantiate()
	sfx.stream=stream
	%Sfx.add_child(sfx)

var is_stopped:bool=false
var auto_play:bool=false
var speed_auto_play=11
var auto_play_temp_pause:bool=false
func set_auto_play_temp_pause():
	auto_play_temp_pause=true
	%TimerTempPause.start()
func _on_timer_temp_pause_timeout() -> void:auto_play_temp_pause=false

########################
var can_touch=true
var is_touch=0

func save_data_1():
	var data={
		"is_touch":is_touch,
	}
	var json=JSON.stringify(data)
	var file:FileAccess=FileAccess.open("user://data_1.sav",FileAccess.WRITE)
	file.store_string(json)
	file.close()
	
func load_data_1():
	var file=FileAccess.open("user://data_1.sav",FileAccess.READ)
	if file:
		var string=file.get_as_text()
		var data=JSON.parse_string(string)
		is_touch=data["is_touch"]
