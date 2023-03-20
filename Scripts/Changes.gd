extends Node2D

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
var frame = 0

func _physics_process(_delta):
	#			Moving thru frames faster
	var _fast_n  = Input.is_key_pressed(KEY_CTRL) and Input.is_action_pressed("next")
	var _fast_p  = Input.is_key_pressed(KEY_CTRL) and Input.is_action_pressed("previous")
	$Animation/Control/Current/SpinBox.value = Global.current_frame
##if (container.current_tab!=container.get_tab_count()-1):
##	if Input.is_action_just_pressed("next") or fast_n:
##			$Timeline/HSlider.value = $Timeline/HSlider.value + 10
#if (container.current_tab!=0):
#	if Input.is_action_just_pressed("previous") or fast_p:
#			container.current_tab = container.current_tab - 1
#			$Timeline/HSlider.value = $Timeline/HSlider.value - 10
#if Input.is_action_just_pressed("play"):
#	$Timer.wait_time = 1/$Timeline/FPS.value
#	$Timer.start()
#frame = $Timeline/HSlider.value

#func _on_timer_timeout():
#	if (container.current_tab!=container.get_tab_count()-1):
#		container.current_tab = frame
#		frame += 1
#		$Timer.start()
#	else:
#		frame = 0
#		$Timer.stop()
