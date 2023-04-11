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
var prev

func _ready():
	_sort_frames()
	prev = subview.get_child(0)

func _process(_delta):
	#Initializing variables and values needed
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var f_inst = f.instantiate()
	
	is_frame_node = subview.find_child(str(Global.current_frame),true,false)
	is_frame = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_inviz()
	#========================================
	#	Create a frame if it's present in timeline but not in viewport 
	if is_frame_node==null and is_frame:
		f_inst.name = str(Global.current_frame)
		subview.add_child(f_inst)
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
	
func _onion():
	#	Onion-Skin
	var children_nr = subview.get_child_count()
	var _frame_between =  Global.current_frame<int(str(subview.get_child(children_nr-1).name))

	for i in range(Global.current_frame):
		var is_last = subview.find_child(str(Global.current_frame-i),true,false)
		if is_last:
			prev = is_last
			is_last.visible = true
			is_last.set_modulate(Color('626fff'))
			break

func _inviz():
	for i in subview.get_children():
		i.set_modulate(Color('ffffff'))
		if i.name==str(Global.current_frame):
			i.visible = true
			i.set_process_input(true)
		elif i.name==prev.name:
			prev.visible = true
			prev.set_modulate(Color('626fff'))
		else:
			i.visible = false
			i.set_process_input(false)

func _on_onion_skin_toggled(_button_pressed):
	le_onion = !le_onion