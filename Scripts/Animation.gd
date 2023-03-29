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




func _process(_delta):
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var ff = f.instantiate()
	var find = subview.find_child(str(Global.current_frame),true,false)
	var verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_inviz()
	#	Create a frame if none is present
	if find==null and verify:
		ff.name = str(Global.current_frame)
		ff.visible = true
		ff.set_process_input(true)
		#print("Frame ",ff.name," added!")
		subview.add_child(ff)
		#print($DrawingArea/SubViewport.get_children())
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
