extends Node

var current_frame := 1 : set=set_cf
var set_fps = 24
var state_IDLE = true
func set_cf(new_value):
	current_frame=new_value
