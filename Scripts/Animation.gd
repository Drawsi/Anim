extends Control

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var Tslider = get_node("ScrollContainer/Anim_Layers/TSlider")

var frame = 0

func _physics_process(_delta):
	$TimelineSettings/Current_Fps/SpinBox.value = Global.current_frame
	Global.set_fps = $TimelineSettings/Fps_Counter/Run_FPS.value
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
