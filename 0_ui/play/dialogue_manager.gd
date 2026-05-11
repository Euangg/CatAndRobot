extends Control

var sat:int
var tech:int

@onready var art_cat: Character = $Cat
@onready var art_robot: Character = $Robot

const SFX_猫_尖叫 = preload("uid://csswfqpgtcxr4")
const SFX_猫_开心 = preload("uid://tf4d4x0dld8s")
const SFX_猫_担忧 = preload("uid://b4swsvowee26j")
const SFX_猫_满足 = preload("uid://byqs71mkvs8hd")
const SFX_开门 = preload("uid://k7vgbmppgaix")
const SFX_关门 = preload("uid://88s55bi8uhfk")
const SFX_扫描 = preload("uid://bq0ch7tjexdr6")
const SFX_警告 = preload("uid://uvdet07f53t0")
const SFX_机关 = preload("uid://b32d7v3ajbofo")
const SFX_枪声 = preload("uid://3eplp0slljbh")
const SFX_拧脖 = preload("uid://bcrxiq7umawlh")
const SFX_提示 = preload("uid://c2hl7i0hay3eh")

const SCENE_BLACK = preload("uid://08mpfdx7m2ro")
const SCENE_WHITE = preload("uid://dv832rwp2uneh")
const SCENE_1_1 = preload("uid://blexl0gay5k0q")
const SCENE_1_2 = preload("uid://wj7no8vi0wru")
const SCENE_1_3 = preload("uid://vwbhbyb8qt5a")
const SCENE_2_1 = preload("uid://epdigjtk6bum")
const SCENE_2_2 = preload("uid://bo1w76iqsl66y")
const SCENE_2_3 = preload("uid://gf1domc3hphm")
const SCENE_3_1 = preload("uid://d3k8trol6pf0r")
const SCENE_3_2 = preload("uid://cy8tl0na3nwdh")

const SCENE_4_1 = preload("uid://cc4bf7ha1jge5")
const SCENE_5_1 = preload("uid://ul8b5cb6oqid")
const SCENE_5_2 = preload("uid://bu2fmx76uvarc")
const SCENE_5_3 = preload("uid://b3ykrcenxaihl")
const SCENE_5_4 = preload("uid://0uah44f1tq06")
func switch_back_scene(new_scene:PackedScene):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(new_scene.instantiate())

func hide_all_characters():
	art_cat.hide()
	art_robot.hide()

const Script_1 = preload("uid://j73gbj874m7i")
const Script_Test = preload("uid://cp3ptlodoo5b1")
const Script_4_2 = preload("uid://degu67hcd8ovc")
const Script_4_3 = preload("uid://joxu1f6d35kb")
const Script_4_4 = preload("uid://061d8hoa5a6v")
const Script_4_5 = preload("uid://bxsx27nhdgsqh")

var current_script:Script=Script_1
var order_curtain:int=0
func clear_dialogue_box():for d in %NodeDbox.get_children():d.queue_free()
func switch_script(script:Script):
	current_script=script
	order_curtain=-1
func load_current_curtain():line_to_curtain(current_script.content[order_curtain])
func load_next_curtain(offset:int=0):
	order_curtain+=1+offset
	if order_curtain>=current_script.content.size():return
	load_current_curtain()

const DBOX = preload("uid://b4078rvnvfsel")
const DBOX_ROBOT = preload("uid://bj8acmoepsenw")
const DBOX_ROBOT_3 = preload("uid://db38dw7neqawm")
const DBOX_CAT = preload("uid://c6u7ctk1e2gj0")
const SELECTION = preload("uid://bhg8si8mm6epe")
const RETRY = preload("uid://dq0x8wyjp1ner")
const SAVE = preload("uid://bay5sy7ierj7u")
const CHANGE = preload("uid://b6sfjus2ps84")

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
			"R","序":control_character=art_robot
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
					switch_script(Script_4_5)
					clear_dialogue_box()
					hide_all_characters()
					load_next_curtain()
					)
				s.other.connect(func():
					switch_script(Script_4_4)
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
				"场景":
					match cmd_parameter[1]:
						"黑屏幕":dia.process.push_back(func():switch_back_scene(SCENE_BLACK))
						"白屏幕":dia.process.push_back(func():switch_back_scene(SCENE_WHITE))
						"场景1_1":dia.process.push_back(func():switch_back_scene(SCENE_1_1))
						"场景1_2":dia.process.push_back(func():switch_back_scene(SCENE_1_2))
						"场景1_3":dia.process.push_back(func():switch_back_scene(SCENE_1_3))
						"场景2_1":dia.process.push_back(func():switch_back_scene(SCENE_2_1))
						"场景2_2":dia.process.push_back(func():switch_back_scene(SCENE_2_2))
						"场景2_3":dia.process.push_back(func():switch_back_scene(SCENE_2_3))
						"场景3_1":dia.process.push_back(func():switch_back_scene(SCENE_3_1))
						"场景3_2":dia.process.push_back(func():switch_back_scene(SCENE_3_2))
						"场景4_1":dia.process.push_back(func():switch_back_scene(SCENE_4_1))
						"场景5_1":dia.process.push_back(func():switch_back_scene(SCENE_5_1))
						"场景5_2":dia.process.push_back(func():switch_back_scene(SCENE_5_2))
						"场景5_3":dia.process.push_back(func():switch_back_scene(SCENE_5_3))
						"场景5_4":dia.process.push_back(func():switch_back_scene(SCENE_5_4))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
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
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"判定":
					match cmd_parameter[1]:
						"1":
							dia.process.push_back(func():
								if tech==1:switch_back_scene(SCENE_2_2)
								else:switch_back_scene(SCENE_2_3)
								)
						"2":
							dia.process.push_back(func():
								if sat==1:switch_script(Script_4_3)#sat=1时，跳转至剧本4_3，否则跳转至剧本4_2
								else:switch_script(Script_4_2))
						"3":
							dia.process.push_back(func():
								if Global.is_touch==1:%AnimationPlayerEvent.play("event_1")
								else:switch_script(Script_4_4))
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
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
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
		"R":
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
			"R":art_robot=new_c
			"青":art_cat=new_c
		)
	old_c.add_sibling(new_c)
	
	var t=create_tween()
	t.tween_property(old_c,"modulate:a",0.4,0.4)
	t.parallel().tween_property(new_c,"modulate:a",1,0.4)
	t.tween_callback(func():
		old_c.queue_free())

func _ready() -> void:
	load_current_curtain()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_right"):
		sat=1
		Global.is_touch=1
	
	if is_shake:
		position=Vector2(
			randf_range(-intensity_shake,intensity_shake),
			randf_range(-intensity_shake,intensity_shake)
		)
	else:position=Vector2.ZERO

var intensity_shake:float=5
var is_shake:bool=false
func shake(time:float):
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
