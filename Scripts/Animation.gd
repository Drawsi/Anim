extends Control

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var Tslider = get_node("ScrollContainer/Anim_Layers/TSlider")

@onready var tlayer = $ScrollContainer/Anim_Layers/TLayer/Spread
@onready var subview = $"../DrawingArea/SubViewport"
var f = preload("res://FrameView.tscn")
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")

var find
var verify
var le_onion = false

func _process(_delta):
	#Initializing variables and values needed
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
	var f_inst=f.instantiate()
	find = subview.find_child(str(Global.current_frame),true,false)
	verify = tlayer.get_child(Global.current_frame-1).get_texture_normal()==new
	_inviz()
	#========================================
	#	Create a frame if it's present in timeline but not in viewport 
	if find==null and verify:
		f_inst.name = str(Global.current_frame)
		subview.add_child(f_inst)
		_sort_frames()
		
	#	Deletes the viewport frame if it doesn't match the timeline
	if find and !verify:
		find.queue_free()
	
func _sort_frames():
	var all = subview.get_children()
	#var found
	#for this in subview.get_children():
	#	var current = int(str(this.name))
	#	if int(str(this.name))>subview.get_child_count():
	#		while !found and current>0:
	#			found = get_node_or_null(str(current))
	#			current = current-1
	#		subview.move_child(this,subview.get_child_count()-current)
	#	else:
	#		subview.move_child(this,int(str(this.name)))
	for i in range(all.size()-1, -1, -1):
		for j in range(1,i+1,1):
			if all[j-1].name > all[j].name:
				var aux = all[j-1]
				#all[j-1] = all[j]
				#all[j] = aux
				move_child(all[j-1],all[j].get_index())
				move_child(all[j],aux.get_index())
	#for child in all:
	#	subview.add_child(child)
	print(all)
	#subview.print_tree_pretty()

func _onion():
	#	Onion-Skin
	if subview.get_child_count()>1 and verify:
		#all = bubble_sort(subview.get_children())
		var _found = null
		var _n = 2
		subview.get_children()
		subview.get_children().clear()
		#subview.get_children().append_array(bubble_sort(subview.get_children()))
		#print(subview.get_children())
		#while !found:
		#	#if all[Global.current_frame-n]!=get_node_or_null():
		#	if get_node_or_null(str(Global.current_frame-n)):
		#		found = all[Global.current_frame-n]
		#		n = 2
		#	else:
		#		n = n+1
		#found.visible = true
		#found.set_modulate(Color('626fff'))#ffffff

func _inviz():
	for i in subview.get_children():
		if i.name==str(Global.current_frame):
			i.visible = true
			i.set_process_input(true)
		else:
			i.visible = false
			i.set_process_input(false)

func _on_onion_skin_toggled(_button_pressed):
	le_onion = true
