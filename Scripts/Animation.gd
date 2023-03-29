extends Control

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var Tslider = get_node("ScrollContainer/Anim_Layers/TSlider")
@onready var tlayer = get_node("ScrollContainer/Anim_Layers/TLayer/Spread")
@onready var subview = get_node("../DrawingArea/SubViewport")
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")

var find
var verify

func _process(_delta):
	#Initializing variables and values needed
	find = subview.find_child(str(Global.current_frame),true,false)
	verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var ff = f.instantiate()
	_inviz()
	#========================================
	#	Create a frame if it's present in timeline but not in viewport 
	if find==null and verify:
		ff.name = str(Global.current_frame)
		ff.visible = true
		ff.set_process_input(true)
		subview.add_child(ff)
	#	Deletes the frame
	if find and !verify:
		find.queue_free()

func _inviz():
	for i in subview.get_children():
		if i.name==str(Global.current_frame):
			i.visible = true
			i.set_process_input(true)
		else:
			i.visible = false
			i.set_process_input(false)

func _onion():
	pass
