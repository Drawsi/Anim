extends MenuButton

var popup
var colors =   ["001219", "005f73",
				"0a9396", "94d2bd",
				"e9d8a6", "ee9b00",
				"ca6702", "bb3e03",
				"ae2012", "9b2226",
				"ffffff", "000000"]

#@onready var container = $"../../Timeline/TabContainer"

func _ready():
	popup = get_popup()
	popup.connect("id_pressed",Callable(self,"_on_item_pressed"))
	for n in colors:
		$"../BrushColor".add_preset(n)

#func _delete_children():
#	#			It goes inside child * 4 and deleted all the drawn lines
#	for n in container.get_children():
#		var many = n.get_child(0).get_child(0).get_child(0)
#		if many.get_child_count()!=0:
#			for y in range(many.get_child_count()):
#				many.get_child(y).queue_free()

#func _on_item_pressed(ID):
#	match ID:
#		0:
#			_delete_children()
#				#print(n.get_child(0))
#				#container.remove_child(n.get_child(2,true))
#				#n.remove_child(n.get_child(1))
#				#n.queue_free()
#		1:
#			$FileDialog.popup_centered()

func _on_file_dialog_confirmed():
	var img = $"../../Frames/Frame/SubViewport".get_texture().get_data()
	img.save_png($FileDialog.current_path)
