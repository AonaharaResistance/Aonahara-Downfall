extends KinematicBody2D
class_name Character

onready var animation = $AnimationPlayer
onready var sprite = $Sprite

export(int) var acceleration: int
export(int) var max_speed: int
export(int) var hp: int

var velocity: Vector2 = Vector2.ZERO
var friction: float = 0.20


func move() -> void:
	var input_direction: Vector2 = get_input_direction()
	velocity += acceleration * input_direction
	velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = velocity.clamped(max_speed)
	velocity = move_and_slide(velocity)


func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Vector2.ZERO
	input_direction.x = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	input_direction.y = (
		Input.get_action_strength("move_down")
		- Input.get_action_strength("move_up")
	)

	# To not make diagonal movement faster
	input_direction = input_direction.normalized()

	return input_direction


func _on_Hurtbox_entered():
	emit_signal("_on_hp_changed")


func die():
	queue_free()


func flip_control():
	var mouse_direction: Vector2 = get_mouse_direction()
	if mouse_direction.x < 0 and sign(sprite.scale.x) != sign(mouse_direction.x):
		sprite.scale.x *= -1
	elif mouse_direction.x > 0 and sign(sprite.scale.x) != sign(mouse_direction.x):
		sprite.scale.x *= -1
