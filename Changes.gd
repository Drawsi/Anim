extends Node2D

@export var brush_color = Color(1,1,1)
@export var brush_size = 10
@onready var container = $Timeline/TabContainer
var frame = 0

func _physics_process(_delta):
	if (container.current_tab!=container.get_tab_count()-1):
		if Input.is_action_just_pressed("next"):
				container.current_tab = container.current_tab + 1
	if (container.current_tab!=0):
		if Input.is_action_just_pressed("previous"):
				container.current_tab = container.current_tab - 1
	if Input.is_action_just_pressed("play"):
		$Timer.wait_time = 1/$Timeline/FPS.value
		$Timer.start()

func _on_timer_timeout():
	if (container.current_tab!=container.get_tab_count()-1):
		container.current_tab = frame
		frame += 1
		$Timer.start()
	else:
		frame = 0
		$Timer.stop()
