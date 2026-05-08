extends Control

var sat:int

const SFX_猫咪呼噜 = preload("uid://dlnh0v4v2b1jv")
const SFX_猫尖叫 = preload("uid://bem128p7krnt2")
const SFX_猫开心 = preload("uid://cwhudyv0pisu7")
const SFX_猫担忧 = preload("uid://b5u85pq8kcylc")


const SCENE_BLACK = preload("uid://08mpfdx7m2ro")
const SCENE_1_1 = preload("uid://blexl0gay5k0q")
const SCENE_1_2 = preload("uid://wj7no8vi0wru")
const SCENE_1_3 = preload("uid://vwbhbyb8qt5a")
const SCENE_2_1 = preload("uid://epdigjtk6bum")
const SCENE_2_2 = preload("uid://bo1w76iqsl66y")
const SCENE_3_1 = preload("uid://d3k8trol6pf0r")
const SCENE_4_1 = preload("uid://cc4bf7ha1jge5")
const SCENE_5_1 = preload("uid://ul8b5cb6oqid")
const SCENE_5_2 = preload("uid://bu2fmx76uvarc")
const SCENE_5_3 = preload("uid://b3ykrcenxaihl")
const SCENE_5_4 = preload("uid://0uah44f1tq06")
func switch_back_scene(new_scene:PackedScene):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(new_scene.instantiate())

@onready var cat: Control = $Cat
@onready var robot: Control = $Robot
func hide_all_characters():
	cat.hide()
	robot.hide()

var test:Array=[
	":【场景-场景1_1】",
	":【场景-黑屏幕】",
	
	"R右-站立:正在重启自检系统",
	"R:重启成功",
	"R右-站立:【场景-场景1_1】[视觉系统已连接]",
	"青,R右-站立:喵~",
	"R,青左-站立:青芽。",
	
	"选:向左探索【参数-sat,+1】+0^向右探索+1",
	"R右-站立,青左-站立:向左探索+1",
	"R右-站立,青左-站立:向右探索",
	"青,R右-站立:喵~",
	
	":【判定】",
	"青,R右-站立:【音效-猫_担忧】喵~",
	"青左-站立,R右-站立:【音效-猫_开心】喵~",
]

var order_curtain:int=0
func clear_dialogue_box():for d in %NodeDbox.get_children():d.queue_free()
func load_current_curtain():line_to_curtain(test[order_curtain])
func load_next_curtain(offset:int=0):
	order_curtain+=1+offset
	if order_curtain>=test.size():return
	load_current_curtain()

const DBOX = preload("uid://b4078rvnvfsel")
const DBOX_ROBOT = preload("uid://bj8acmoepsenw")
const DBOX_CAT = preload("uid://c6u7ctk1e2gj0")
const SELECTION = preload("uid://bhg8si8mm6epe")


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
			"R":control_character=robot
			"青":control_character=cat
		if control_character and c.length()>1:
			control_character.show()
			#control_character.ap_entrance.seek(0,true)
			
			match c[1]:
				"左":control_character.ap_pos.play("l")
				"中":control_character.ap_pos.play("m")
				"右":control_character.ap_pos.play("r")
			control_character.ap_pos.seek(0,true)
			#var face:PackedStringArray=c.split("-")
			#if face.size()>1:
				#var face_2:PackedStringArray=face[1].split("》")
				#var decoration:PackedStringArray=face_2[0].split("+")
				#control_character.ap_face.play(decoration[0])
				#control_character.ap_face.seek(0,true)
				#if decoration.size()>1:control_character.show_dec(decoration[1])
					#
				##渐变
				#if face_2.size()>1:
					#var new_dec:PackedStringArray=face_2[1].split("+")
					#if new_dec.size()>1:change_art_fade(c[0],new_dec[0],new_dec[1])
					#else:change_art_fade(c[0],new_dec[0],"")
					#print(c[0],":",decoration[0],">>",new_dec[0])	

	#对话框
	var default_character=null
	var dia:DialogueBox=null
	var is_4_cha:bool=true
	var selection:Selection=null
	var cmd_dia=cmds[0]
	if cmd_dia:
		match cmd_dia[0]:
			"R":
				dia=DBOX_ROBOT.instantiate()
				#default_character=art_lin
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
			"选":
				selection=SELECTION.instantiate()
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
									sat+=int(parameter_parameter[1])
									print(sat)
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
									sat+=int(parameter_parameter[1])
									print(sat)
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
						"场景1_1":dia.process.push_back(func():switch_back_scene(SCENE_1_1))
						"场景1_2":dia.process.push_back(func():switch_back_scene(SCENE_1_2))
						"场景1_3":dia.process.push_back(func():switch_back_scene(SCENE_1_3))
						"场景2_1":dia.process.push_back(func():switch_back_scene(SCENE_2_1))
						"场景2_2":dia.process.push_back(func():switch_back_scene(SCENE_2_2))
						"场景3_1":dia.process.push_back(func():switch_back_scene(SCENE_3_1))
						"场景4_1":dia.process.push_back(func():switch_back_scene(SCENE_4_1))
						"场景5_1":dia.process.push_back(func():switch_back_scene(SCENE_5_1))
						"场景5_2":dia.process.push_back(func():switch_back_scene(SCENE_5_2))
						"场景5_3":dia.process.push_back(func():switch_back_scene(SCENE_5_3))
						"场景5_4":dia.process.push_back(func():switch_back_scene(SCENE_5_4))
						_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
				"音效":
					match cmd_parameter[1]:
						"猫_担忧":dia.process.push_back(func():Global.play_sfx(SFX_猫担忧))
						"猫_开心":dia.process.push_back(func():Global.play_sfx(SFX_猫开心))
				"判定":
					dia.process.push_back(func():
						if sat==1:switch_back_scene(SCENE_2_1)
						else:switch_back_scene(SCENE_2_2)
						)
				_:print("未知指令:",cmd_parameter[0])

		dia.arr_text=text_offset[0].split("//")
		dia.end.connect(func():
			clear_dialogue_box()
			hide_all_characters()
			load_next_curtain(offset)
			)
		%NodeDbox.add_child(dia)

func _ready() -> void:
	load_current_curtain()
