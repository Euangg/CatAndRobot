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
const SFX_扫描 = preload("uid://bq0ch7tjexdr6")
const SFX_警告 = preload("uid://uvdet07f53t0")
const SFX_机关 = preload("uid://b32d7v3ajbofo")
const SFX_枪声 = preload("uid://3eplp0slljbh")

const SCENE_BLACK = preload("uid://08mpfdx7m2ro")
const SCENE_1_1 = preload("uid://blexl0gay5k0q")
const SCENE_1_2 = preload("uid://wj7no8vi0wru")
const SCENE_1_3 = preload("uid://vwbhbyb8qt5a")
const SCENE_2_1 = preload("uid://epdigjtk6bum")
const SCENE_2_2 = preload("uid://bo1w76iqsl66y")
const SCENE_2_3 = preload("uid://gf1domc3hphm")
const SCENE_3_1 = preload("uid://d3k8trol6pf0r")
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

var test:Array=[
	"R:【场景-黑屏幕】正在重启自检系统",
	"R:[滋滋滋…]",
	"R:重启成功",
	"R:【音效-警告】[警告！运动系统损坏度64%.../扫描组件不可使用.../通讯模块无响应…]",
	"R:[滋滋滋.../无法激活武器系统…]",
	"R:[当前安全程度：低]",

	"R中-站立1_1:【场景-场景1_1】[视觉系统已连接]",
	"R中-站立1_1:青芽。",
	"R中-站立1_1:[检测到目标生物前肢软组织损伤，活动关节未受影响，启动伤口处理预案]",
	"R中-站立1_1:【音效-警告】[警告！任务优先级被改动，正在查找原因]",
	"R中-站立1_1:[检测到空气含氧量为4.7%，目标生物预计存活时间为4分32秒]",
	"R中-站立1_1:[启动应急补氧预案]",
	"R中-站立1_1:[查找中断，记录此次未知变量]",
	"R中-站立1_1:[目标生物生理状态已恢复82%]",
	"青中-站立3,R中-站立1_1:【音效-猫_担忧】喵~",
	"R中-站立1_1,青中-站立3:[目标生物耳朵压低，尾部静止，处于负面生理状态.../执行环境探索任务]",
	"R中-站立1_1,青中-站立3:[未发现异常，未发现可用材料]",
	"R中-站立1_1,青中-站立3:[目标：向外探索]",

	"选:向左探索+0^向右探索+12",
	"R中-站立1_1,青中-站立3:青芽，跟随。",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_2,青中-开心2_2:[目标生物步幅频率增加13%，尾部摆动频率增加…/停止分析]",
	"R中-站立1_2,青中-开心2_2:[正在分析环境结构，当前深度-23485米]",
	"R中-站立1_2,青中-开心2_2:[前方无可通行路线，未发现可用材料，即将返回路线]",
	"R中-站立1_2,青中-开心2_2:[当前线程被占用。痛觉信号增加7.2%]",
	"R中-站立1_2,青中-开心2_2:青芽，上来。",
	"青中-开心2_2,R中-站立1_2:【音效-猫_开心】喵~",
	"R中-怀抱青芽2:[路线返回。目标生物尾部持续摆动，呼吸频率高于任务基线19%，该状态未影响任务执行]",
	"R中-怀抱青芽2:[正在检查日志：任务执行期间检测到目标生物处于危险状态，默认程序中断，启动目标生物应急保护预案]",
	"R中-怀抱青芽2:[未检测到环境异常，单元失衡，调取单元自保预案失败…]",
	"R中-怀抱青芽2:[自检结束，未找到未知变量]",

	"R中-站立1_1,青中-开心1_2:[前方无可通行路线，发现精炼材料，正在修复扫描组件]",
	"R中-站立1_1,青中-开心1_2:[修复进度24%，材料不足，进程终止]",
	"R中-扫描1_2,青中-开心2_2:【音效-扫描】[扫描系统已连接，正在扫描]",
	"R中-扫描1_2》站立1_2,青中-开心2_2:[发现可疑地点，常规透视无效，正在前往]",
	"R中-站立1_2,青中-开心2_2:青芽，跟随。",
	"青中-开心2_2,R中-站立1_2:【音效-猫_开心】喵~",

	":【场景-场景1_2】",
	"R中-扫描1_1,青中-开心1_1:【音效-扫描】[发现人工建筑，表面浮雕匹配,“腾云教会”标识，匹配度97.9%]",
	"R中-扫描1_1,青中-开心1_1:[建筑顶部探测到隐藏触发装置，需生物电信号激活]",
	"R中-扫描1_1》站立1_1,青中-开心1_1:[利用猫咪攀爬至顶部为唯一解，正在模拟路线，预计痛觉信号增加27%]",
	"R中-站立1_1,青中-开心1_1:青芽。",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_1,青中-开心1_1:听我指令爬到建筑顶部。",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_1:…在此处退至岩石边缘，全力向前跑动起跳…",
	"R中-站立1_1:按住平台不松。",

	"R中-站立1_1:【场景-场景1_3】【音效-开门】",
	"R中-站立1_1:[暂无危险，内部信息未知，携带目标生物可提升生存概率]",
	"R中-站立1_1:青芽，下来",
	"青,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-怀抱青芽1:前进。",
	"R中-怀抱青芽1:【音效-猫_开心】喵~",
	"R中-怀抱青芽1:[内部日志：腾云邪教，信条是“文明即原罪，存在即痛苦”，信徒极度癫狂]",
	"R中-怀抱青芽1:[当前安全程度：极低]",
	"R中-怀抱青芽1:[…未向目标生物播报信息，该信息对任务执行不产生优化效果]",
	
	":【场景-场景2_1】",
	"R中-站立1_1:[扫描组件耐久剩余8.2%，视觉判断已达最大深度]",
	"R中-站立1_1:[无法获得建筑全貌信息]",
	"R中-站立1_1:[检测到目标生物超出安全距离]",
	"R中-站立1_1:青芽，回来。",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_1,青中-开心1_1:[观测到正面墙壁修复痕迹，修复区域边缘未保持整齐，陷阱存在概率：高]",
	"R中-站立1_1,青中-开心1_1:[启用扫描功能]",

	"选:先开启红外扫描功能和反探查功能（低能耗）【参数-tech,=1】+0^先开启深度探查功能（高能耗）+4",##第66行
	"R中-站立1_1》扫描1_1,青中-开心1_1:【音效-扫描】[启动多频扫描]",
	"R中-扫描1_1,青中-开心1_1:[发现路线尽头左侧遮挡区存在陷阱，路线前方存在隐藏陷阱，具体范围未知]",
	"R中-扫描1_1,青中-开心1_1:【音效-扫描】[未发现其他陷阱存在可能，开启深度探查功能]",
	"R中-扫描1_1》站立1_1,青中-开心1_1:[具体范围明确，扫描组件过载报废]+3",

	"R中-站立1_1》扫描1_1,青中-开心1_1:【音效-扫描】[开启深度探查功能]",
	"R中-扫描1_1,青中-开心1_1:[发现路线前方存在隐藏陷阱，已获取具体信息]",
	"R中-扫描1_1》站立1_1,青中-开心1_1:[扫描组件过载报废，未探测其他陷阱存在]",

	"R中-站立1_1,青中-开心1_1:[陷阱分布模型已建立，经计算，只有目标生物可以通过危险区域]",
	"R中-站立1_1,青中-开心1_1:[再次计算，无其他解]",
	"R中-站立1_1,青中-开心1_1:青芽，听指令。【判定】",##当tech==1时，场景切换至场景2_2，否则切换至场景2_3
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",

	"选:贴着右侧墙边行进+0^从正中间前进+4",
	"R中-站立1_1,青中-开心1_1:右侧贴墙压低身体，快速通过",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_1:[目标生物通过第一段陷阱]",
	"R中-站立1_1:中转，冲刺。+3",

	"R中-站立1_1,青中-开心1_1:从正中间贴地前行，快速通过",
	"青中-开心1_1,R中-站立1_1:【音效-猫_开心】喵~",
	":【场景-黑屏幕】【音效-枪声】",
	"回:64",

	"选:向前跳跃+0^趴下前进+3",
	"R中-站立1_1:跳跃。",
	"青,R中-站立1_1:【音效-猫_开心】喵~",
	"R中-站立1_1:[目标生物通过第二段陷阱]+3",

	"R中-站立1_1:压低身体",
	"青,R中-站立1_1:【音效-猫_开心】喵~",
	":【场景-黑屏幕】【音效-枪声】",
	"回:64",

	"R中-站立1_1:右上方有拉环，起跳拉下它。",
	"青,R中-站立1_1:【音效-猫_开心】喵~",
	",R中-站立1_1:【音效-机关】",
	"R中-站立1_1:【场景-场景2_1】[陷阱威胁消除，路线安全，正在通过]",
	"青,R中-站立1_1:【音效-猫_开心】喵~",
	"青,R中-怀抱撸猫:【音效-猫_满足】咕噜~",
	"R中-怀抱撸猫:[警告！任务优先级被改动，未定位到未知变量]",
	"R中-怀抱撸猫:[内部日志调用：目标生物完成任务后需要抚摸]",

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
const RETRY = preload("uid://dq0x8wyjp1ner")

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
			"R":control_character=art_robot
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
								"tech":selection.select_2.connect(func():
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
									sat+=int(parameter_parameter[1])
									print("sat:",sat)
								)
								"tech":selection.select_2.connect(func():
									tech+=int(parameter_parameter[1])
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
						"场景2_3":dia.process.push_back(func():switch_back_scene(SCENE_2_3))
						"场景3_1":dia.process.push_back(func():switch_back_scene(SCENE_3_1))
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
						"警告":dia.process.push_back(func():Global.play_sfx(SFX_警告))
						"开门":dia.process.push_back(func():Global.play_sfx(SFX_开门))
						"扫描":dia.process.push_back(func():Global.play_sfx(SFX_扫描))
						"机关":dia.process.push_back(func():Global.play_sfx(SFX_机关))
						"枪声":dia.process.push_back(func():Global.play_sfx(SFX_枪声))
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
