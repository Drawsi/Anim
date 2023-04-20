extends Control

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var Tslider = get_node("ScrollContainer/Anim_Layers/TSlider")

@onready var tlayer = $ScrollContainer/Anim_Layers/TLayer/Spread
@onready var subview = $"../DrawingArea/SubViewport"
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")

var is_frame_node
var is_frame
var le_onion = false

func _ready():
	_sort_frames()

func _process(_delta):
	#Initializing variables and values needed
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var f_inst = f.instantiate()
	
	is_frame_node = subview.find_child(str(Global.current_frame),true,false)
	is_frame = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_onionskin_pp()
	#========================================
	#	Create a frame if it's present in timeline but not in viewport 
	if is_frame_node==null and is_frame:
		f_inst.name = str(Global.current_frame)
		subview.add_child(f_inst)
		#_onion()
		_sort_frames()
	#	Deletes the viewport frame if it doesn't match the timeline
	if is_frame_node and !is_frame:
		is_frame_node.queue_free()

func _sort_frames():
	#Code provided by Joel Gomes da Silva
	"""https://godotengine.org/qa/150583/how-can-i-sort-the-children-of-a-node?state=comment-150588&show=150588#c150588"""
	var sorted_nodes := subview.get_children()
	sorted_nodes.sort_custom(func(a: Node, b: Node): return a.name.naturalnocasecmp_to(b.name) < 0)

	for node in subview.get_children():
		subview.remove_child(node)
	for node in sorted_nodes:
		subview.add_child(node)
	#subview.print_tree_pretty()

func _on_onion_skin_toggled(_button_pressed):
	le_onion = !le_onion

func _onionskin_pp():
	var prev = subview.get_child(0)
	"""Checks all the possible frames to find a previous"""
	for k in range(1,Global.current_frame):
		var before = subview.find_child(str(Global.current_frame-k),true,false)
		if before:
			prev = before
			print(prev)
			break
		
	for i in subview.get_children():
		if i.name==str(Global.current_frame):
			prev.visible = true
			prev.set_modulate(Color('626fff'))
			i.visible = true
			i.set_process_input(true)
			i.set_modulate(Color('ffffff'))
		else:
			i.visible = false
			i.set_process_input(false)

