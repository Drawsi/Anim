extends Control

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var Tslider = get_node("ScrollContainer/Anim_Layers/TSlider")

@onready var tlayer = $ScrollContainer/Anim_Layers/TLayer/Spread
@onready var subview = $"../DrawingArea/SubViewport"
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")
var last_frame
var this_frame
var frame = 0

var find
var verify
var csf = null#current shown frame

func _process(_delta):
	#Initializing variables and values needed
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var ff = f.instantiate()
	find = subview.find_child(str(Global.current_frame),true,false)
	verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_inviz()
	#========================================
	#	Create a frame if it's present in timeline but not in viewport 
	if find==null and verify:
		ff.name = str(Global.current_frame)
		ff.visible = true
		ff.set_process_input(true)
		subview.add_child(ff)
		csf = ff
	if find==null and !verify:
		pass
	#	Deletes the viewport frame if it doesn't match the timeline
	if find and !verify:
		find.queue_free()

func _inviz():
	find = subview.find_child(str(Global.current_frame),true,false)
	verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	#	Checks current frame and makes only IT visible
	#	But I do want last frame to be visible tho
	
	#	csf = Current Shown Frame
	if (find and verify):
		csf = find
		csf.visible = true
		csf.set_process_input(true)
	elif !find and !verify:
		
		csf.visible = true
		csf.set_process_input(true)
	else:
		csf.visible = false
		csf.set_process_input(false)
		
	#for i in subview.get_children():
	#	if i.name==str(Global.current_frame):
	#		i.visible = true
	#		i.set_process_input(true)
	#	else:
	#		i.visible = false
	#		i.set_process_input(false)
