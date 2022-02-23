extends Node2D
class_name Buff

export var buff_name: String
export var buff_description: String
export var duration: float
onready var duration_timer: Timer = $Duration


func _ready():
	duration_timer.set_wait_time(duration)


func modify_stateless(host):
	pass


func modify_stateful(host):
	pass
