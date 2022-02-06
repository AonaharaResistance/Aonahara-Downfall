extends KinematicBody2D
class_name Enemy

export var hp: int setget set_hp, get_hp
export var effect_hit: PackedScene = null
export var effect_died: PackedScene = null
export var indicator_damage: PackedScene = preload("res://ui/damage_indicator.tscn")
export var projectile: PackedScene = preload("res://objects/projectiles/PlayerDagger.tscn")
export var receives_knockback: bool = true
export var max_speed: int = 100
var max_steering: float = 2.5
var avoid_force: int = 100000

onready var animation: AnimationPlayer = $AnimationPlayer
onready var attack_timer: Timer = $AttackTimer
onready var spawn_location: Vector2 = global_position
onready var ai = $Ai

var velocity: Vector2 = Vector2.ZERO
var knockback: Vector2 = Vector2.ZERO

var arrival_zone_radius: int = 20
var vector_to_target: Vector2 = Vector2.ZERO setget set_target

onready var raycasts: Node2D = get_node("Rays")


func set_target(new_target):
	vector_to_target = new_target - position


func _process(_delta):
	pass


#var steering: Vector2 = Vector2.ZERO
#
#if vector_to_target.length() > arrival_zone_radius:
#    steering += seek_steering()
#else:
#    steering += arrival_steering()
#steering += avoid_obstacles_steering()
#steering = steering.clamped(max_steering)
#
#velocity += steering * delta * 100
#velocity = velocity.clamped(max_speed)
#
#velocity = move_and_slide(
#    velocity * int(ai.get_children().front().patrol_duration.is_stopped())
#)


func seek_steering() -> void:
	pass


#var desired_velocity: Vector2 = vector_to_target.normalized() * max_speed
#return desired_velocity - velocity


func arrival_steering() -> void:
	pass


#var speed: float = (vector_to_target.length() / arrival_zone_radius) * max_speed
#var desired_velocity: Vector2 = vector_to_target.normalized() * speed
#return desired_velocity - velocity


func avoid_obstacles_steering() -> void:
	pass


#raycasts.rotation = velocity.angle()
##Something is wrong here
#for raycast in raycasts.get_children():
#    raycast.cast_to.x = velocity.length()
#    if raycast.is_colliding():
#        var obstacle = raycast.get_collider()
#        return (position + velocity - obstacle.position).normalized() * avoid_force
#
#return Vector2.ZERO


func get_hp() -> int:
	return hp


func set_hp(new_hp) -> void:
	if new_hp < 0:
		hp = 0
	else:
		hp = new_hp


func listen_knockback(delta) -> void:
	if receives_knockback:
		knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
		knockback = move_and_slide(knockback)


func apply_knockback(direction, strength) -> void:
	knockback = (direction.direction_to(self.global_position) * strength)


func _on_HurtBox_area_entered(hitbox) -> void:
	if hitbox is WeaponHitBox:
		var final_damage = _randomize_damage(hitbox.total_damage)
		apply_knockback(hitbox.global_position, hitbox.knockback_strength)
		Shake.shake(1.0, 0.2, 1)
		spawn_hit_effect()
		_take_damage(final_damage)
		spawn_damage_indicator(final_damage)


func _randomize_damage(damage: int) -> int:
	return int(round(rand_range(damage * 0.9, damage * 1.2)))


func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position) -> PackedScene:
	var effect = EFFECT.instance()
	get_tree().current_scene.add_child(effect)
	effect.global_position = effect_position
	return effect


func spawn_death_effect() -> void:
	var _hit_effect = spawn_effect(effect_died)


func spawn_hit_effect() -> void:
	var _hit_effect = spawn_effect(effect_hit)


func spawn_damage_indicator(damage: int) -> void:
	var indicator = spawn_effect(indicator_damage)
	if indicator:
		indicator.label.text = str(damage)


func _take_damage(damage: int) -> void:
	set_hp(hp - damage)
	_die_check(hp)


func _die_check(current_hp: int) -> void:
	if current_hp <= 0:
		spawn_death_effect()
		die()


func die() -> void:
	queue_free()


func shoot():
	var projectile_direction = self.global_position.direction_to(
		Party.current_character().global_position
	)
	throw_projectile(projectile_direction)


func throw_projectile(projectile_direction: Vector2):
	if projectile:
		var _projectile = projectile.instance()
		get_tree().current_scene.add_child(_projectile)
		_projectile.global_position = self.global_position

		var projectile_rotation = projectile_direction.angle()
		_projectile.rotation = projectile_rotation
