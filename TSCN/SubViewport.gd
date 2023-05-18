extends SubViewportContainer

var zoom_min_max = 1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_min_max=clamp(zoom_min_max+0.1, 0.1, 5.0)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_min_max=clamp(zoom_min_max-0.1, 0.1, 5.0)
		self.scale = Vector2(zoom_min_max,zoom_min_max)
