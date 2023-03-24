extends HSplitContainer

@onready var layer_name = $Layer_Name
@export var self_name = "Layer"
var empty = load("res://Frame_Icons/empty.png")
var new = load("res://Frame_Icons/new.png")
var reuse = load("res://Frame_Icons/reuse.png")

func _ready():
	layer_name.text = self_name

func _input(_event):
	if Input.is_action_just_pressed("new_frame"):
		$Spread.get_child(Global.current_frame-1).set_texture_normal(new)
	if Input.is_action_just_pressed("delete_frame"):
		$Spread.get_child(Global.current_frame-1).set_texture_normal(empty)
