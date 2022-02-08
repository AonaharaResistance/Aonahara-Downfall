extends KinematicBody2D
class_name Character

onready var animation: AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var animation_mode = animation_tree.get("paramaters/playback")
onready var sprite: Sprite = $Sprite
onready var weapon: Node2D = $Weapon
onready var dash := $Dash
onready var stamina_timer: Timer = $StaminaTimer
onready var camera: Camera2D = $Camera2D
onready var blinker: Blinker = $Blinker
onready var hurt_box: CollisionShape2D = $HurtBox/CollisionShape2D
onready var sprite_shader_material: ShaderMaterial = sprite.material
onready var battle_timer: Timer = $BattleTimer
onready var interaction_component: InteractionComponent = $InteractionComponent
onready var skills: Node = $Skills
onready var skill_one: Skill = $Skills.get_child(0)
onready var skill_two: Skill = $Skills.get_child(1)

export var character_name: String
export var character_icon: Resource
export var acceleration: int
export var max_speed: int
export var hp: int
export var max_hp: int
export var stamina: int setget set_stamina
export var max_stamina: int
export var base_damage: int
export var stamina_regen: float
export var stamina_regen_rate: float
export var dash_duration: float = 0.2
export var receives_knockback: bool = true
export var mirrored_sprite: bool = true

var velocity: Vector2 = Vector2.ZERO
var knockback: Vector2 = Vector2.ZERO
var friction: float = 0.20
var isOnControl: bool = true
var is_facing_left: bool = false setget set_is_facing_left, get_is_facing_left
var is_on_battle: bool = false setget set_is_on_battle, get_is_on_battle

signal battle_state_changed


func _ready() -> void:
	stamina_timer.wait_time = stamina_regen
	add_to_group("current_character")


func equiped_weapon():
	if !weapon.get_children().empty():
		return weapon.get_child(0)
	else:
		# TDOO: Handle if weapon is not equiped
		return null


func listen_to_attacks() -> void:
	if equiped_weapon().holdable_light:
		if Input.is_action_pressed("light_attack") && isOnControl:
			equiped_weapon().light_attack()
	else:
		if Input.is_action_just_pressed("light_attack") && isOnControl:
			equiped_weapon().light_attack()
	if Input.is_action_just_released("light_attack") && isOnControl:
		equiped_weapon().light_attack_release()
	if Input.is_action_just_pressed("heavy_attack") && isOnControl:
		equiped_weapon().heavy_attack()
	if Input.is_action_just_released("heavy_attack") && isOnControl:
		equiped_weapon().heavy_attack_release()


func listen_to_skills() -> void:
	if Input.is_action_just_pressed("first_skill") && isOnControl:
		skill_one.activate_skill()


func set_stamina(new_value) -> void:
	stamina += new_value


func move(delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()

	# * Using lerp or Linear Interpolation to simulate friction
	velocity = move_and_slide(velocity)
	velocity += acceleration * input_direction * delta * 60
	velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = velocity.clamped(max_speed)


func set_is_on_battle(new_state) -> void:
	if new_state == true:
		battle_timer.start()
	is_on_battle = new_state
	emit_signal("battle_state_changed")


func get_is_on_battle() -> bool:
	return is_on_battle


func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()


func regenerate_stamina() -> void:
	while stamina < max_stamina && stamina_timer.is_stopped():
		stamina += 1
		Hud.update_hud()
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


# warning-ignore:unsafe_method_access
# Why the fuck is the actual dash function is on character??
func apply_dash() -> void:
	if dash.is_dashing():
		velocity = (acceleration * 8) * get_input_direction()


# warning-ignore:unsafe_method_access
func activate_dash() -> void:
	if Input.is_action_just_pressed("dash") && isOnControl:
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
	if isOnControl:
		return input_direction
	else:
		return Vector2.ZERO


func get_is_facing_left() -> bool:
	return is_facing_left


func set_is_facing_left(new_value: bool) -> void:
	is_facing_left = new_value


func sprite_control() -> void:
	# ? Pretty sure there's a better way of doing this
	var mouse_direction: Vector2 = get_mouse_direction()

	# Interaction Component
	if mouse_direction.x < 0 and sign(interaction_component.scale.x) != sign(mouse_direction.x):
		interaction_component.scale.x *= -1
	elif mouse_direction.x > 0 and sign(interaction_component.scale.x) != sign(mouse_direction.x):
		interaction_component.scale.x *= -1

	# Character control
	if mirrored_sprite:
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
	Hud.update_hud()
	if hp < 0:
		hp = 0
	_die_check(hp)


func listen_knockback(delta) -> void:
	if receives_knockback:
		knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
		knockback = move_and_slide(knockback)


func apply_knockback(direction, strength) -> void:
	knockback = (direction.direction_to(self.global_position) * strength)


func _on_HurtBox_area_entered(hitbox: HitBox) -> void:
	set_is_on_battle(false)
	blinker.start_blinking(sprite, 1.0)
	_whiten_sprite(0.3)
	_take_damage(hitbox.damage)
	apply_knockback(hitbox.global_position, hitbox.knockback_strength)
	_enable_iframes(1.0)


func _enable_iframes(duration: float) -> void:
	hurt_box.set_deferred("disabled", true)
	yield(get_tree().create_timer(duration), "timeout")
	hurt_box.disabled = false


func _whiten_sprite(duration: float):
	sprite_shader_material.set_shader_param("whiten", true)
	yield(get_tree().create_timer(duration), "timeout")
	sprite_shader_material.set_shader_param("whiten", false)


func _die_check(current_hp: int) -> void:
	if current_hp <= 0:
		die()


func die() -> void:
	queue_free()


func _on_BattleTimer_timeout():
	set_is_on_battle(false)
