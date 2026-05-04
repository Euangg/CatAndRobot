extends Control

const SCENE_BLACK = preload("uid://08mpfdx7m2ro")
const SCENE_1_1 = preload("uid://blexl0gay5k0q")
const SCENE_1_2 = preload("uid://wj7no8vi0wru")
const SCENE_1_3 = preload("uid://vwbhbyb8qt5a")
func switch_back_scene(new_scene:PackedScene):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(new_scene.instantiate())

@onready var cat: Control = $Cat
@onready var robot: Control = $Robot
func hide_all_characters():
	cat.hide()
	robot.hide()

var test:Array=[
"R右-站立:【场景-黑屏幕】正在重启自检系统",
"R右-站立:[滋滋滋…]",
"R右-站立:重启成功",
"R右-站立:[警告！运动系统损坏度64%.../扫描组件不可使用.../通讯模块无响应…]",
"R右-站立:[滋滋滋.../无法激活武器系统…]",
"R右-站立:[当前安全程度：低]",

"R右-站立:【场景-场景1_1】[视觉系统已连接]",
"R右-站立:青芽。",
"R右-站立:[检测到目标生物前肢软组织损伤，活动关节未受影响，启动伤口处理预案]",
"R右-站立:[警告！任务优先级被改动，正在查找原因]",
"R右-站立:[检测到空气含氧量为4.7%，目标生物预计存活时间为4分32秒]",
"R右-站立:[启动应急补氧预案]",
"R右-站立:[查找中断，记录此次未知变量]",
"R右-站立:[目标生物生理状态已恢复82%]",
"青左-站立,R右-站立:喵~",
"R右-站立,青左-站立:[目标生物耳朵压低，尾部静止，处于负面生理状态。/执行环境探索任务]",
"R右-站立,青左-站立:[未发现异常，未发现可用材料]",
"R右-站立,青左-站立:[目标：向外探索]",
"选:-向左探索+0-向右探索+11",
"R右-站立,青左-站立:青芽，跟随。",
"青左-站立,R右-站立:喵~",
"R中-站立,青右-站立:[目标生物步幅频率增加13%，尾部摆动频率增加…/停止分析]",
"R中-站立,青右-站立:[正在分析环境结构，当前深度-23485米]",
"R中-站立,青右-站立:[前方无可通行路线，未发现可用材料，即将返回路线]",
"R中-站立,青右-站立:[当前线程被占用。痛觉信号增加7.2%]",
"R中-站立,青右-站立:青芽，上来。",
"青右-站立,R中-站立:喵~",
"R右-肩托青芽:[路线返回。目标生物尾部持续摆动，呼吸频率高于任务基线19%，该状态未影响任务执行]",
"R右-肩托青芽:[正在检查日志：任务执行期间检测到目标生物处于危险状态，默认程序中断，启动目标生物应急保护预案]",
"R右-肩托青芽:[未检测到环境异常，单元失衡，调取单元自保预案失败…]",
"R右-肩托青芽:[自检结束，未找到未知变量]",

"R右-肩托青芽》站立,青中-站立:[前方无可通行路线，发现精炼材料，正在修复扫描组件]",
"R右-站立,青中-站立:[修复进度24%，材料不足，进程终止]",
"R中-扫描,青右-站立:[扫描系统已连接，正在扫描]",
"R中-扫描》站立,青右-站立:[发现可疑地点，常规透视无效，正在前往]",
"R中-站立,青右-站立:青芽，跟随。",
"青右-站立,R中-站立:喵~",

"R右-扫描,青左-站立:【场景-场景1_2】[发现人工建筑，表面浮雕匹配,“腾云教会”,标识，匹配度97.9%]",
"R右-扫描,青左-站立:[建筑顶部探测到隐藏触发装置，需生物电信号激活]",
"R右-扫描》站立,青左-站立:[利用猫咪攀爬至顶部为唯一解，正在模拟路线，预计痛觉信号增加27%]",
"R右-站立,青左-站立:青芽。",
"青左-站立,R右-站立:喵~",
"R右-站立,青左-站立:听我指令爬到建筑顶部。",
"青左-站立,R右-站立:喵~",
"R右-站立,青左-攀岩1:…在此处退至岩石边缘，全力向前跑动起跳…",
"R右-站立,青左-攀岩2:按住平台不松。",

"R右-站立,青左-攀岩2:【场景-场景1_3】[暂无危险，内部信息未知，携带目标生物可提升生存概率]",
"R右-站立,青左-攀岩2:青芽，下来",
"R右-站立,青左-攀岩2:喵~",
"R右-肩托青芽:前进。",
"青左,R右-肩托青芽:喵~",
"R右-肩托青芽:[内部日志：腾云邪教，信条是“文明即原罪，存在即痛苦”，信徒极度癫狂]",
"R右-肩托青芽:[当前安全程度：极低]",
"R右-肩托青芽:[…未向目标生物播报信息，该信息对任务执行不产生优化效果]",
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

func line_to_curtain(line:String):
	var cmd_text:PackedStringArray=line.split(":")
	var cmds:PackedStringArray=cmd_text[0].split(",")
	var text:String=cmd_text[1]
	
	#立绘
	for c in cmds:
		var control_character:Character=null
		match c[0]:
			"R":control_character=robot
			"青":control_character=cat
		if control_character:
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
	match cmds[0][0]:
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
			var content=text.split("-")
			content.erase("")
			var s1:PackedStringArray=content[0].split("+")
			var s2:PackedStringArray=content[1].split("+")
			selection.str_selection_1=s1[0]
			selection.str_selection_2=s2[0]
			var offset_1=0
			if s1.size()>1:offset_1=s1[1].to_int()
			selection.select_1.connect(func():
				clear_dialogue_box()
				hide_all_characters()
				load_next_curtain(offset_1)
				)
			var offset_2=0
			if s2.size()>1:offset_2=s2[1].to_int()
			selection.select_2.connect(func():
				clear_dialogue_box()
				hide_all_characters()
				load_next_curtain(offset_2)
				)				
			%NodeDbox.add_child(selection)
		_:dia=DBOX.instantiate()

	if dia:
		#if is_4_cha:dia.pos=characters[0][1]
		var text_offset:PackedStringArray=text.split("+")
		var offset=0
		if text_offset.size()>1:offset=text_offset[1].to_int()
		#text_offset[0]=text_offset[0].replace("【主角】",Global.name_player)
		#找指令
		while (text_offset[0].find("【")!=-1):
			var order_start=text_offset[0].find("【")
			if order_start==-1:pass
			else:
				var order_end=text_offset[0].find("】")
				if order_end==-1:pass
				else:
					var length=order_end-order_start
					var code=text_offset[0].substr(order_start+1,length-1)
					var cmd_parameter:PackedStringArray=code.split("-")
					match cmd_parameter[0]:
						"场景":
							match cmd_parameter[1]:
								"黑屏幕":dia.process.push_back(func():switch_back_scene(SCENE_BLACK))
								"场景1_1":dia.process.push_back(func():switch_back_scene(SCENE_1_1))
								"场景1_2":dia.process.push_back(func():switch_back_scene(SCENE_1_2))
								"场景1_3":dia.process.push_back(func():switch_back_scene(SCENE_1_3))
								_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
						#"【问号感叹号】":dia.process.push_back(func():
							#default_character.dec问号感叹符号.emerge()
							#)
						#"【抖动上下】":dia.process.push_back(func():
							#default_character.ap_shake.play("v")
							#)
						#"【抖动左右】":dia.process.push_back(func():
							#default_character.ap_shake.play("h")
							#)
						#"【bgm_Routine2】":dia.process.push_back(func():
							#Global.fmod_switch_bgm("Routine2")
							#)
						_:print("未知指令:",cmd_parameter[0])
					text_offset[0]=text_offset[0].erase(order_start,length+1)
					text_offset[0]=text_offset[0].insert(order_start,"】")

		dia.arr_text=text_offset[0].split("//")
		dia.end.connect(func():
			clear_dialogue_box()
			hide_all_characters()
			load_next_curtain(offset)
			)
		%NodeDbox.add_child(dia)

func _ready() -> void:
	load_current_curtain()
