extends HSplitContainer

@onready var layer_name = $Layer_Name
@export var self_name = "Layer"

func _ready():
	layer_name.text = self_name
func _input(event):
	pass
