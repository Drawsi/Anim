extends HSplitContainer

var label = Label.new()
var last = 60
var pos = 0
var all_frames = 750

func _ready():
	# Creating the labels
	for i in range(14):
		var inst = Label.new()
		inst.text = str(pos + 50)
		inst.position.x = last + 800
		
		pos = pos + 50
		last = last + 800
		self.add_child(inst)

func _input(_event):
	$Slider.value = Global.current_frame 
	var _next  = Input.is_action_just_pressed("next")
	var _fnext  = Input.is_action_pressed("next")
	var _previous  = Input.is_action_just_pressed("previous")
	var _fprevious = Input.is_action_pressed("previous")
	var _play  = Input.is_action_just_pressed("play")
			#Moving thru frames
	if _next or _fnext:
		$Slider.value = $Slider.value + 1
	if _previous or _fprevious:
		$Slider.value = $Slider.value - 1
	if _play:
		print(Global.set_fps) 
		Global.state_playing = !Global.state_playing
		$Play.wait_time = 1.0/Global.set_fps
		$Play.start()

func _on_play_timeout():
	if Global.current_frame < all_frames and Global.state_playing:
		Global.set_cf(Global.current_frame + 1)
		$Play.start()
	else:
		$Play.stop()

func _on_slider_value_changed(value):
	Global.set_cf(value)
