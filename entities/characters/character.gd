extends KinematicBody2D
class_name Character

onready var animation = $AnimationPlayer
onready var sprite = $Sprite
onready var weapon = $Weapon
onready var dash = $Dash
onready var stamina_timer = $StaminaTimer
onready var camera = $Camera2D
onready var hurt_box = $HurtBox/CollisionShape2D

export(int) var acceleration: int
export(int) var max_speed: int
export(int) var hp: int
export(int) var max_hp: int
export(int) var stamina: int
export(int) var max_stamina: int
export(int) var base_damage: int
export(float) var attack_speed: float
export(float) var stamina_regen: float
export(float) var stamina_regen_rate: float
export(float) var dash_duration: float = 0.2

var velocity: Vector2 = Vector2.ZERO
var knockback: Vector2 = Vector2.ZERO
var friction: float = 0.20
var receives_knockback: bool = true


func _ready() -> void:
	stamina_timer.wait_time = stamina_regen
	camera.add_to_group("current_camera")
	add_to_group("current_character")

	print(get_tree().current_scene.get_node("Player").get_child(0).name)


func move() -> void:
	var input_direction: Vector2 = get_input_direction()

	# * Using lerp or Linear Interpolation to simulate friction
	velocity = move_and_slide(velocity)
	velocity += acceleration * input_direction
	velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = velocity.clamped(max_speed)


func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func regenerate_stamina() -> void:
	while stamina < max_stamina && stamina_timer.is_stopped():
		stamina += 1
		yield(get_tree().create_timer(stamina_regen_rate), "timeout")


func get_stamina_timer() -> float:
	return stamina_timer.time_left


func _on_StaminaTimer_timeout() -> void:
	regenerate_stamina()


func set_stamina_regen_timer(current_stamina) -> void:
	if current_stamina == 0:
		stamina_timer.wait_time = stamina_regen * 2
	else:
		stamina_timer.wait_time = stamina_regen


func apply_dash() -> void:
	if dash.is_dashing():
		velocity = (acceleration * 8) * get_input_direction()


func activate_dash() -> void:
	if Input.is_action_just_pressed("dash"):
		stamina -= 1
		set_stamina_regen_timer(stamina)
		stamina_timer.start()
		dash.start_dash(sprite, dash_duration, get_input_direction())


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
	input_direction = input_direction.normalized()
	return input_direction


func sprite_control() -> void:
	# ? Pretty sure there's a better way of doing this
	var mouse_direction: Vector2 = get_mouse_direction()

	# Character control
	if mouse_direction.x < 0 and sign(sprite.scale.x) != sign(mouse_direction.x):
		sprite.scale.x *= -1
	elif mouse_direction.x > 0 and sign(sprite.scale.x) != sign(mouse_direction.x):
		sprite.scale.x *= -1

	# Weapon control
	weapon.rotation = mouse_direction.angle()
	if mouse_direction.x < 0 and sign(weapon.scale.y) != sign(mouse_direction.x):
		weapon.scale.y *= -1
	elif mouse_direction.x > 0 and sign(weapon.scale.y) != sign(mouse_direction.x):
		weapon.scale.y *= -1
	if mouse_direction.y < 0 and sign(weapon.z_index) != sign(mouse_direction.y):
		weapon.z_index *= -1
	elif mouse_direction.y > 0 and sign(weapon.z_index) != sign(mouse_direction.y):
		weapon.z_index *= -1


func _take_damage(damage: int) -> void:
	hp -= damage
	if hp < 0:
		hp = 0
	_die_check(hp)


func listen_knockback(delta):
	if receives_knockback:
		knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
		knockback = move_and_slide(knockback)


func apply_knockback(direction, strength):
	knockback = (direction.direction_to(self.global_position) * strength)


func _on_HurtBox_area_entered(hitbox: HitBox) -> void:
	_take_damage(hitbox.damage)
	apply_knockback(hitbox.global_position, hitbox.knockback_strength)


func _die_check(current_hp: int) -> void:
	if current_hp <= 0:
		die()


func die() -> void:
	queue_free()
