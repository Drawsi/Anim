extends Node2D

#	Distance between points
var distance = 1

var line = Line2D.new()
var _pressed = false

var undo = []
var undo_size = 30
var redo = []
var redo_size = 15
@onready var tab_container = $"../../../.."
@onready var brush_settings = $"../../../Brush_Settings"

func _input(event):
	_lifo()
	var brush_color = brush_settings.get_node("BrushColor").color
	var brush_size = brush_settings.get_node("BrushSize").value
	var _ssize
	
	if event is InputEventMouseButton:
		line = Line2D.new()
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
		line.default_color = brush_color
		line.antialiased = true
		line.width = brush_size
		
		#line.width_curve = Curve.new()
		self.add_child(line)
		
		#			Checking the event type
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			_pressed = true
			#line.width_curve.add_point(Vector2(0,1))
			undo.push_back(line)
			
		else:
			_pressed = false
			#line.width_curve.bake()
	if (event is InputEventMouseMotion):
		#				Adding intermediate points if the mouse moves
		if _pressed:#		Get's the distance between mouse and last point
			line.add_point(event.position,0)
			var points_nr = line.get_point_count()
			var d = get_global_mouse_position().distance_to(line.get_point_position(points_nr-1))
			if d >= distance:
				#line.width 
				_ssize = (event.get_pressure() + 0.01) * brush_size
				#print(event.get_pressure())
				line.add_point(get_global_mouse_position(),line.get_point_count()+1)
				#line.width_curve.add_point(Vector2(1,ssize))
				#line.width_curve.set_point_value(1,ssize)
				#print(line.width_curve.get_point_count())
				
			#Deletes too many lines from the lifo system
			if undo.size()>undo_size:
				undo.pop_front()
			
		#			Individual pressure

func _lifo():
	#		Deleting lines
	#if str(tab_container.current_tab)==$"../../..".name:
	if self == self:#Supposed to change self to current frame in animation
		if Input.is_action_just_pressed("undo") and undo.size()>0 :
			undo[undo.size()-1].queue_free()
			undo.pop_back()
