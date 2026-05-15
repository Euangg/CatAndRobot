class_name DialogueBox
extends Control

const SFX_WORD_1 = preload("uid://4gwbpy6npgio")
const SFX_WORD_2 = preload("uid://bj88pau5ptlmr")
const SFX_WORD_3 = preload("uid://dya8qidxpvgox")
const SFX_WORD_4 = preload("uid://c86mi3h63pkgu")
var sfx_words=[SFX_WORD_1,SFX_WORD_2,SFX_WORD_3,SFX_WORD_4]

signal end
var process:Array[Callable]
var order_call=-1

var arr_text:PackedStringArray=["adf","adsfad"]

var order_text=0
var num_characters_per_second=20
var order_char=0
var amount_characters_should_shown:float=0
var is_stopped=false

func _ready() -> void:
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	reinit()

func load_text():
	order_char=0
	%Label.text=""
	amount_characters_should_shown=0

func reinit():
	order_text=0
	load_text()

func _unhandled_input(event: InputEvent) -> void:
	if Global.is_stopped:return
	if event.is_action_pressed("mouse_left"):
		if order_char <arr_text[order_text].length():
			if is_stopped:is_stopped=false
			else:amount_characters_should_shown=arr_text[order_text].length()
		else:try_load_next_line()

func _physics_process(delta: float) -> void:
	if Global.is_stopped:return
	if order_char <arr_text[order_text].length():#播放中
		if Global.auto_play or Global.acc:is_stopped=false
		if is_stopped:return
		
		
		if Global.auto_play:amount_characters_should_shown+=Global.speed_auto_play*delta
		else:amount_characters_should_shown+=num_characters_per_second*delta
		if Global.acc:amount_characters_should_shown=arr_text[order_text].length()
		var diff:int=amount_characters_should_shown-order_char
		if diff>0:Global.play_sfx(sfx_words.pick_random())
		
		while (diff>0):
			if order_char>=arr_text[order_text].length():break
			var read_char=arr_text[order_text][order_char]
			match read_char:
				"/":
					is_stopped=true
					amount_characters_should_shown=%Label.text.length()
					diff=0
				"^":
					order_call+=1
					if order_call<process.size():process[order_call].call()
					else:print("call越界",",size:",process.size(),",order:",order_call)
				_:
					%Label.text+=read_char
					diff-=1
			order_char+=1
		
		if order_char >=arr_text[order_text].length():#播放完瞬间
			on_one_line_end()
	else:#本段播放完毕
		if Global.auto_play and (!Global.auto_play_temp_pause):try_load_next_line()
		if Global.acc:try_load_next_line()

func try_load_next_line():
	if order_text<arr_text.size()-1:
		order_text+=1
		load_text()
		on_load_next_line()
	else:
		end.emit()
		print("end")
func on_one_line_end():if Global.auto_play:Global.set_auto_play_temp_pause()
func on_load_next_line():pass
