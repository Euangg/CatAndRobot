extends Control

var sat:int
var tech:int

@onready var art_cat: Character = $Cat
@onready var art_robot: Character = $Robot

const SFX_猫_尖叫 = preload("uid://csswfqpgtcxr4")
const SFX_猫_开心 = preload("uid://tf4d4x0dld8s")
const SFX_猫_担忧 = preload("uid://b4swsvowee26j")
const SFX_猫_满足 = preload("uid://byqs71mkvs8hd")
const SFX_选项 = preload("uid://bk3dmde12cgqj")
const SFX_关门 = preload("uid://ecs20h2eb2gp")
const SFX_开门 = preload("uid://dr0a43gv6l5vo")
const SFX_扫描 = preload("uid://cfar6hgwqx5yc")
const SFX_拧脖 = preload("uid://byam6rk2hgmv4")
const SFX_提示 = preload("uid://btqtq0fuwb3m1")
const SFX_警告 = preload("uid://owy7rs6ell5m")
const SFX_机关 = preload("uid://blv8n4q34y6cs")
const SFX_枪声 = preload("uid://j4jx5aatae67")
const SFX_晚星 = preload("uid://thapxtyskj2k")

var dict_scene={
	"黑屏幕":preload("uid://08mpfdx7m2ro"),
	"白屏幕":preload("uid://dv832rwp2uneh"),
	"场景1_1":preload("uid://blexl0gay5k0q"),
	"场景1_2":preload("uid://wj7no8vi0wru"),
	"场景1_3":preload("uid://vwbhbyb8qt5a"),
	"场景2_1":preload("uid://epdigjtk6bum"),
	"场景2_2":preload("uid://bo1w76iqsl66y"),
	"场景2_3":preload("uid://gf1domc3hphm"),
	"场景3_1":preload("uid://d3k8trol6pf0r"),
	"场景3_2":preload("uid://cy8tl0na3nwdh"),
	"场景4_1":preload("uid://cc4bf7ha1jge5"),
	"场景5_1":preload("uid://ul8b5cb6oqid"),
	"场景5_2":preload("uid://bu2fmx76uvarc"),
	"场景5_3":preload("uid://b3ykrcenxaihl"),
	"场景5_4":preload("uid://0uah44f1tq06"),
	"场景6_1":preload("uid://d0pk5cdhmb3fu"),
}
var str_current_scene="黑屏幕"
func switch_back_scene(str_scene:String):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(dict_scene[str_scene].instantiate())
	str_current_scene=str_scene

func hide_all_characters():
	art_cat.hide()
	art_robot.hide()

var dic_script={
	"test":preload("uid://cp3ptlodoo5b1"),
	"main":preload("uid://j73gbj874m7i"),
	"4_2":preload("uid://degu67hcd8ovc"),
	"4_3":preload("uid://joxu1f6d35kb"),
	"4_4":preload("uid://061d8hoa5a6v"),
	"4_5":preload("uid://bxsx27nhdgsqh"),
	"5_1":preload("uid://da2ri1lyb74yr"),
	"7_1":preload("uid://rpvwuo74h6y4"),
}
var str_current_script="main"
var current_script:Script=dic_script[str_current_script]
var order_curtain:int=0
func clear_dialogue_box():for d in %NodeDbox.get_children():d.queue_free()
func switch_script(str_script:String):
	str_current_script=str_script
	current_script=dic_script[str_current_script]
	order_curtain=-1
func load_current_curtain():line_to_curtain(current_script.content[order_curtain])
func load_next_curtain(offset:int=0):
	order_curtain+=1+offset
	if order_curtain>=current_script.content.size():return
	load_current_curtain()

const DBOX = preload("uid://b4078rvnvfsel")
const DBOX_ROBOT = preload("uid://bj8acmoepsenw")
const DBOX_ROBOT_2 = preload("uid://bt6qjkyprww4v")
const DBOX_ROBOT_3 = preload("uid://db38dw7neqawm")
const DBOX_CAT = preload("uid://c6u7ctk1e2gj0")
const SELECTION = preload("uid://bhg8si8mm6epe")
const RETRY = preload("uid://dq0x8wyjp1ner")
const SAVE = preload("uid://bay5sy7ierj7u")
const CHANGE = preload("uid://b6sfjus2ps84")
const CHANGE_VOID = preload("uid://bq1dx5uf16f4d")

func pick_cmd(arr_str:PackedStringArray,flag:String)->String:
	var order_start=arr_str[0].find("【")
	if order_start==-1:return ""
	var order_end=arr_str[0].find("】")
	if order_end==-1:return ""
	var length=order_end-order_start
	var cmd=arr_str[0].substr(order_start+1,length-1)
	arr_str[0]=arr_str[0].erase(order_start,length+1)
	arr_str[0]=arr_str[0].insert(order_start,flag)
	return cmd

func line_to_curtain(line:String):
	var cmd_text:PackedStringArray=line.split(":")
	var cmds:PackedStringArray=cmd_text[0].split(",")
	var text:String=cmd_text[1]
	
	#立绘
	for c in cmds:
		if c=="":continue
		var control_character:Character=null
		match c[0]:
			"R","序","虚":control_character=art_robot
			"青":control_character=art_cat
		if control_character and c.length()>1:
			control_character.show()
			#control_character.ap_entrance.seek(0,true)
			
			match c[1]:
				"左":control_character.ap_pos.play("l")
				"中":control_character.ap_pos.play("m")
				"右":control_character.ap_pos.play("r")
			control_character.ap_pos.seek(0,true)
			var face:PackedStringArray=c.split("-")
			if face.size()>1:
				var face_2:PackedStringArray=face[1].split("》")
				var decoration:PackedStringArray=face_2[0].split("+")
				control_character.ap_face.play(decoration[0])
				control_character.ap_face.seek(0,true)
				if decoration.size()>1:control_character.show_dec(decoration[1])
				#渐变
				if face_2.size()>1:
					var new_dec:PackedStringArray=face_2[1].split("+")
					if new_dec.size()>1:change_art_fade(c[0],new_dec[0],new_dec[1])
					else:change_art_fade(c[0],new_dec[0],"")
					#print(c[0],":",decoration[0],">>",new_dec[0])	

	#对话框
	var default_character=null
	var dia:DialogueBox=null
	var is_4_cha:bool=true
	var cmd_dia=cmds[0]
	if cmd_dia:
		match cmd_dia[0]:
			"R":
				dia=DBOX_ROBOT.instantiate()
				#default_character=art_lin
			"虚":dia=DBOX_ROBOT_2.instantiate()
			"序":dia=DBOX_ROBOT_3.instantiate()
			"青":
				dia=DBOX_CAT.instantiate()
				#default_character=art_cheng
			#"主":
				#dia=DIA_PLAYER.instantiate()
				#var player_face=characters[0].split("-")
				#dia.face=player_face[1]
				#is_4_cha=false
			#"旁":
				#dia=DIA_NARRATAGE.instantiate()
				#is_4_cha=false
			"回":
				var retry:Retry=RETRY.instantiate()
				var order=text.to_int()
				retry.select.connect(func():
					order_curtain=order
					load_next_curtain(-1)
					)
				%NodeDbox.add_child(retry)
			"选":
				var selection=SELECTION.instantiate()
				var content=text.split("^")
				var s1_full:PackedStringArray=[content[0]]
				var s2_full:PackedStringArray=[content[1]]
				
				while(1):
					var full_cmd=pick_cmd(s1_full,"")
					if full_cmd=="":break
					var cmd_parameter:PackedStringArray=full_cmd.split("-")
					var parameter_parameter:PackedStringArray=cmd_parameter[1].split(",")
					match cmd_parameter[0]:
						"参数":
							match parameter_parameter[0]:
								"sat":selection.select_1.connect(func():
									match parameter_parameter[1][0]:
										"=":sat=int(parameter_parameter[1].erase(0,1))
										_:sat+=int(parameter_parameter[1])
									print(sat)
								)
								"tech":selection.select_1.connect(func():
									tech+=int(parameter_parameter[1])
									match parameter_parameter[1][0]:
										"=":tech=int(parameter_parameter[1].erase(0,1))
										_:tech+=int(parameter_parameter[1])
									print("tech:",tech)
								)
								_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
						_:print("未知指令:",cmd_parameter[0])
				
				while(1):
					var full_cmd=pick_cmd(s2_full,"")
					if full_cmd=="":break
					var cmd_parameter:PackedStringArray=full_cmd.split("-")
					var parameter_parameter:PackedStringArray=cmd_parameter[1].split(",")
					match cmd_parameter[0]:
						"参数":
							match parameter_parameter[0]:
								"sat":selection.select_2.connect(func():
									match parameter_parameter[1][0]:
										"=":sat=int(parameter_parameter[1].erase(0,1))
										_:sat+=int(parameter_parameter[1])
									print("sat:",sat)
								)
								"tech":selection.select_2.connect(func():
									match parameter_parameter[1][0]:
										"=":tech=int(parameter_parameter[1].erase(0,1))
										_:tech+=int(parameter_parameter[1])
									print("tech:",tech)
								)
								_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
						_:print("未知指令:",cmd_parameter[0])
				
				var s1_offset=s1_full[0].split("+")
				var s2_offset=s2_full[0].split("+")
				
				selection.str_selection_1=s1_offset[0]
				selection.str_selection_2=s2_offset[0]
				
				var offset_1=0
				if s1_offset.size()>1:offset_1=s1_offset[1].to_int()
				selection.select_1.connect(func():
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain(offset_1)
					)
				var offset_2=0
				if s2_offset.size()>1:offset_2=s2_offset[1].to_int()
				selection.select_2.connect(func():
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain(offset_2)
					)				
				%NodeDbox.add_child(selection)
			
			"救":
				var s=SAVE.instantiate()
				s.save.connect(func():
					switch_script("4_5")
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain()
					)
				s.other.connect(func():
					switch_script("4_4")
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain()
					)
				%NodeDbox.add_child(s)
			"变":
				var c=CHANGE.instantiate()
				c.event.connect(func():
					shake(0.8)
					Global.play_sfx(SFX_关门)
					)
				c.end.connect(func():
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain()
				)
				%NodeDbox.add_child(c)
			"便":
				var b=CHANGE_VOID.instantiate()
				b.event.connect(func():
					shake(1,10)
					Global.play_sfx(SFX_关门))
				b.end.connect(func():
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain()
					)
				%NodeDbox.add_child(b)
			_:dia=DBOX.instantiate()
	else:
		dia=DBOX.instantiate()
		
	if dia:
		#if is_4_cha:dia.pos=characters[0][1]
		var text_offset:PackedStringArray=text.split("+")
		var offset=0
		if text_offset.size()>1:offset=text_offset[1].to_int()
		#text_offset[0]=text_offset[0].replace("【主角】",Global.name_player)
		#找指令
		while(1):
			var full_cmd=pick_cmd(text_offset,"^")
			if full_cmd=="":break
			var cmd_parameter:PackedStringArray=full_cmd.split("-")
			match cmd_parameter[0]:
				"场景":dia.process.push_back(func():switch_back_scene(cmd_parameter[1]))
				"音效":
					match cmd_parameter[1]:
						"猫_担忧":dia.process.push_back(func():Global.play_sfx(SFX_猫_担忧))
						"猫_开心":dia.process.push_back(func():Global.play_sfx(SFX_猫_开心))
						"猫_尖叫":dia.process.push_back(func():Global.play_sfx(SFX_猫_尖叫))
						"猫_满足":dia.process.push_back(func():Global.play_sfx(SFX_猫_满足))
						"警告":dia.process.push_back(func():Global.play_sfx(SFX_警告))
						"开门":dia.process.push_back(func():Global.play_sfx(SFX_开门))
						"关门":dia.process.push_back(func():Global.play_sfx(SFX_关门))
						"扫描":dia.process.push_back(func():Global.play_sfx(SFX_扫描))
						"机关":dia.process.push_back(func():Global.play_sfx(SFX_机关))
						"枪声":dia.process.push_back(func():Global.play_sfx(SFX_枪声))
						"拧脖":dia.process.push_back(func():Global.play_sfx(SFX_拧脖))
						"提示":dia.process.push_back(func():Global.play_sfx(SFX_提示))
						"晚星":dia.process.push_back(func():Global.play_sfx(SFX_晚星))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"判定":
					match cmd_parameter[1]:
						"1":
							dia.process.push_back(func():
								if tech==1:switch_back_scene("场景2_2")
								else:switch_back_scene("场景2_3")
								)
						"2":
							dia.process.push_back(func():
								if sat==1:switch_script("4_3")#sat=1时，跳转至剧本4_3，否则跳转至剧本4_2
								else:switch_script("4_2"))
						"3":
							dia.process.push_back(func():
								if Global.is_touch==1:%AnimationPlayerEvent.play("event_1")
								else:switch_script("4_4"))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"事件":
					match cmd_parameter[1]:
						"1":
							dia.process.push_back(func():
								Global.can_touch=true
								print("can_touch=true"))
						"2":
							dia.process.push_back(func():
								Global.can_touch=false
								print("can_touch=false"))
						"3":
							dia.process.push_back(func():
								switch_script("5_1"))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"关闭":
					print("关闭")
					OS.shell_show_in_file_manager(Global.exe_path)
					get_tree().quit()
				"STAFF":dia.process.push_back(func():
					Global.switch_scene(Global.UI_STAFF))
					
				_:print("未知指令:",cmd_parameter[0])
		
		dia.arr_text=text_offset[0].split("//")
		dia.end.connect(func():
			clear_dialogue_box()
			hide_all_characters()
			load_next_curtain(offset)
			)
		%NodeDbox.add_child(dia)

func change_art_fade(str_name:String,str_face:String,str_dec:String):
	var new_c:Character=null
	var old_c:Character=null
	match str_name:
		"R","虚","序":
			new_c=art_robot.duplicate()
			old_c=art_robot
		"青":
			new_c=art_cat.duplicate()
			old_c=art_cat

	new_c.modulate.a=0.4
	new_c.ready.connect(func():
		new_c.ap_face.play(str_face)
		if str_dec:new_c.show_dec(str_dec)
		match str_name:
			"R","虚","序":art_robot=new_c
			"青":art_cat=new_c
		)
	old_c.add_sibling(new_c)
	
	var t=create_tween()
	t.tween_property(old_c,"modulate:a",0.4,0.4)
	t.parallel().tween_property(new_c,"modulate:a",1,0.4)
	t.tween_callback(func():
		old_c.queue_free())

func _ready() -> void:
	if Global.is_load:load_data_2()
	else:
		sat=0
		tech=0
		Global.is_touch=0
		switch_script("main")
	
	if Global.is_limit_exist:
		if Global.is_touch==2:
			Global.is_touch=0
			switch_script("5_1")
		else:pass
	else:
		if Global.is_touch==2:
			Global.is_touch=0
			switch_script("7_1")
			OS.create_process(Global.exe_path.path_join("MessageBox2.exe"),[])
			copy_png()
			get_tree().quit()
		else:
			OS.create_process(Global.exe_path.path_join("MessageBox.exe"),[])
			get_tree().quit()
	
	load_next_curtain()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_scene(Global.UI_THEME)
	
	if Input.is_action_just_pressed("mouse_right"):
		sat=1
		Global.is_touch=1
	
	if is_shake:
		position=Vector2(
			randf_range(-intensity_shake,intensity_shake),
			randf_range(-intensity_shake,intensity_shake)
		)
	else:position=Vector2.ZERO

func _exit_tree() -> void:
	Global.save_data_1()
	save_data_2()

var intensity_shake:float=5
var is_shake:bool=false
func shake(time:float,i:float=5):
	intensity_shake=i
	is_shake=true
	%TimerShake.start(time)
func _on_timer_shake_timeout() -> void:is_shake=false
func start_event_1():
	shake(0.5)
	Global.is_stopped=true
func end_event_1():
	Global.is_stopped=false
func auto_next():
	clear_dialogue_box()
	hide_all_characters()
	load_next_curtain()
	print("自动播放:",current_script.content[order_curtain])
func sfx_close_door():
	Global.play_sfx(SFX_关门)

func copy_png():
	var src:CompressedTexture2D=load("uid://cgkx7qje8o6wt")
	if src:
		var target=Global.exe_path.path_join("破虚与青芽.png")
		src.get_image().save_png(target)

func save_data_2():
	var data={
		"str_current_scene":str_current_scene,
		"str_current_script":str_current_script,
		"order_curtain":order_curtain,
		"sat":sat,
		"tech":tech,
	}
	var json=JSON.stringify(data)
	var file:FileAccess=FileAccess.open("user://data_2.sav",FileAccess.WRITE)
	file.store_string(json)
	file.close()

func load_data_2():
	var file=FileAccess.open("user://data_2.sav",FileAccess.READ)
	if file:
		var string=file.get_as_text()
		var data=JSON.parse_string(string)
		str_current_scene=data["str_current_scene"]
		str_current_script=data["str_current_script"]
		switch_back_scene(str_current_scene)
		switch_script(str_current_script)
		order_curtain=data["order_curtain"]-1
		
		sat=data["sat"]
		tech=data["tech"]
		
func _on_button_menu_pressed() -> void:
	Global.switch_scene(Global.UI_THEME)
	Global.play_sfx(SFX_选项)
func _on_button_acc_pressed() -> void:
	Global.acc=!Global.acc
	Global.play_sfx(SFX_选项)
func _on_button_auto_pressed() -> void:
	Global.auto_play=!Global.auto_play
	Global.play_sfx(SFX_选项)
