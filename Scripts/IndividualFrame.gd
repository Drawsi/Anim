extends TextureButton

func _on_pressed():
	Global.current_frame = int(str(self.name))
