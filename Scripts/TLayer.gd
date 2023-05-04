extends HSplitContainer

@onready var layer_name = $Layer_Name
@export var self_name = "Layer"
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")
var reuse = load("res://Frame_Icons/reuse.png")
var frame = load("res://TSCN/Timeline_frame.tscn")

func _ready():
	layer_name.text = self_name
	for i in range(750):
		var f = frame.instantiate()
		$Spread.add_child(f)
		pass

func _input(_event):
	var new = Input.is_action_just_pressed("new_frame")
	var empty = Input.is_action_just_pressed("delete_frame")
	if new:
		$Spread.get_child(Global.current_frame-1).set_texture_normal(new)
	if empty:
		$Spread.get_child(Global.current_frame-1).set_texture_normal(empty)
