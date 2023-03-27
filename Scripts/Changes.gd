extends Node2D

@onready var tlayer = $Animation/ScrollContainer/Anim_Layers/TLayer/Spread 
@export var brush_color = Color(1,1,1)
@export var brush_size = 10
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")
var last_frame
var this_frame


func _process(_delta):
	var ff = f.instantiate()
	var find = $DrawingArea/SubViewport.find_child(str(Global.current_frame),true,false)
	var verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_inviz()
	#	Create a frame if none is present
	if find==null and verify:
		ff.name = str(Global.current_frame)
		ff.visible = true
		ff.set_process_input(true)
		#print("Frame ",ff.name," added!")
		$DrawingArea/SubViewport.add_child(ff)
		#print($DrawingArea/SubViewport.get_children())
	#	Deletes the frame
	if find and !verify:
		find.queue_free()
func _inviz():
	for i in $DrawingArea/SubViewport.get_children():
		if i.name==str(Global.current_frame):
			i.visible = true
			i.set_process_input(true)
		else:
			i.visible = false
			i.set_process_input(false)
