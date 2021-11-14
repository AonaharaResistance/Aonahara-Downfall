extends KinematicBody2D

export(int) var hp: int setget set_hp, get_hp
export(PackedScene) var effect_hit: PackedScene = null
export(PackedScene) var effect_died: PackedScene = null
export(PackedScene) var indicator_damage: PackedScene = preload("res://ui/damage_indicator.tscn")

export(PackedScene) var DAGGER: PackedScene = preload("res://objects/projectiles/PlayerDagger.tscn")

onready var animation = $AnimationPlayer
onready var attack_timer = $AttackTimer
onready var ai = $Ai
onready var spawn_location = global_position

var receives_knockback: bool = true
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var speed = 100


func _process(delta):
	shoot()


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


func _on_HurtBox_area_entered(hitbox):
	if hitbox.has_method("do_damage"):
		$Hurt.play()
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
	var dagger_direction = self.global_position.direction_to(
		Party.current_character().global_position
	)
	throw_dagger(dagger_direction)


func throw_dagger(dagger_direction: Vector2):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position

		var dagger_rotation = dagger_direction.angle()
		dagger.rotation = dagger_rotation
