extends HSplitContainer

var label = Label.new()
var last = 60
var pos = 0
var stop = false

func _ready():
	for i in range(14):
		var inst = Label.new()
		inst.text = str(pos + 50)
		inst.position.x = last + 800
		
		pos = pos + 50
		last = last + 800
		self.add_child(inst)

func _process(_delta):
	$Slider.value = Global.current_frame 

func _input(_event):
	var _next  = Input.is_action_just_pressed("next")
	var _fnext  = Input.is_action_pressed("next")
	var _previous  = Input.is_action_just_pressed("previous")
	var _fprevious = Input.is_action_pressed("previous")
	var _play  = Input.is_action_pressed("play")
	
			#Moving thru frames
	if _next or _fnext:
		$Slider.value = $Slider.value + 1
	if _previous or _fprevious:
		$Slider.value = $Slider.value - 1
	if _play:
		stop = !stop
		$Play.wait_time = 1.0/Global.set_fps
		$Play.start()
	
func _on_play_timeout():
	if $Slider.value < 750-$Slider.value and stop:
		$Slider.value = $Slider.value + 1
		$Play.start()
	else:
		$Play.stop()

func _on_slider_value_changed(value):
	Global.current_frame = value
