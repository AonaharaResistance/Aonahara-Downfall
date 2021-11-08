extends Node
class_name Blinker

# * Instance into something to make them blink blink :KoroneEye:

onready var blink_timer: Timer = $BlinkTimer
onready var duration_timer: Timer = $DurationTimer
var blink_object: Node2D


func start_blinking(object, duration) -> void:
	blink_object = object
	duration_timer.wait_time = duration
	duration_timer.start()
	blink_timer.start()


func _on_BlinkTimer_timeout() -> void:
	blink_object.visible = !blink_object.visible


func _on_DurationTimer_timeout() -> void:
	blink_timer.stop()
	blink_object.visible = true
