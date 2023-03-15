extends Node2D

#	Distance between points
var distance = 1

var line = Line2D.new()
var _pressed = false
var on_canvas = false
var size = 15

var undo = []
var undo_size = 30
var redo = []
var redo_size = 15

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		line = Line2D.new()
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
		line.default_color = $Control/ColorPicker.color
		line.antialiased = true
		$Lines.add_child(line)
		
		#			Checking the event type
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			_pressed = true
			undo.push_back(line)
			
		else:
			_pressed = false
	
	if (event is InputEventMouseMotion):
		#				Adding intermediate points if the mouse moves
		if _pressed:#		Get's the distance between mouse and last point
			line.add_point(event.position,0)
			var d = get_global_mouse_position().distance_to(line.get_point_position(line.get_point_count()-1))
			if d >= distance:
				line.width = (event.get_pressure() + 0.1) * size
				line.add_point(get_global_mouse_position(),line.get_point_count()+1)
			
			#Deletes too many lines from the lifo system
			if undo.size()>undo_size:
				undo.pop_front()
			#line.width = (event.get_pressure() + 0.1) * size
			
		#			Individual pressure

func _lifo():
	#		Deleting lines
	if Input.is_action_just_pressed("undo") and undo.size()>0:
		undo[undo.size()-1].queue_free()
		undo.pop_back()
		

func _physics_process(_delta):
	_lifo()
	#$Label.text = str(undo)
	size = $Control/HSlider.value
