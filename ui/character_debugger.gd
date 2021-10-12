extends Control

onready var h_velocity = $Properties/HVelocity
onready var v_velocity = $Properties/VVelocity
onready var state = $Properties/State

onready var parent = get_parent()


func _process(_delta):
	_set_velocity()


func _set_velocity():
	h_velocity.set_text(var2str(round(parent.velocity.x)))
	v_velocity.set_text(var2str(round(parent.velocity.y)))
