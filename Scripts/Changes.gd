extends Node2D

@onready var tlayer = $Animation/ScrollContainer/Anim_Layers/TLayer/Spread 
@export var brush_color = Color(1,1,1)
@export var brush_size = 10
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")


func _process(_delta):
	var ff = f.instantiate()
	var find = $DrawingArea/SubViewport.find_child(str(Global.current_frame),true,false)
	var verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	if find==null and verify:
		ff.name = str(Global.current_frame)
		ff.visible = false
		#print("Frame ",ff.name," added!")
		$DrawingArea/SubViewport.add_child(ff)
	print($DrawingArea/SubViewport.get_children())
