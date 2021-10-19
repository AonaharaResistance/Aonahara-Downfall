extends KinematicBody2D

export(int) var hp: int
export(PackedScene) var EFFECT_HIT: PackedScene = null
export(PackedScene) var EFFECT_DIED: PackedScene = null

onready var animation = $AnimationPlayer
onready var attack_timer = $AttackTimer

var receives_knockback: bool = true
var linear_velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var speed = 10
export(PackedScene) var DAGGER: PackedScene = preload("res://objects/projectiles/PlayerDagger.tscn")
const INDICATOR_DAMAGE = preload("res://ui/damage_indicator.tscn")

onready var player = get_node("../Player").get_child(0)


func _ready():
	animation.play("fly")


# ! Experimental Ai, should think a better way of implementing it
# func _process(delta):
# linear_velocity = position.direction_to(player.position) * speed
# $Rays.rotation += delta * 11 * PI
# linear_velocity = move_and_slide(linear_velocity).clamped(100)
# var distance_to_player = global_position.distance_to(player.global_position)
# var vector_to_player = (player.global_position - global_position).normalized()
# if distance_to_player > 100:
# 	linear_velocity += position.direction_to(player.position) * 5
# elif distance_to_player < 100 && attack_timer.is_stopped():
# 	attack_timer.start()
# 	shoot()
# 	pass
# linear_velocity += -position.direction_to(player.position) * 2


func listen_knockback(delta):
	if receives_knockback:
		knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
		knockback = move_and_slide(knockback)


func shoot():
	var dagger_direction = self.global_position.direction_to(player.global_position)

	throw_dagger(dagger_direction)


func throw_dagger(dagger_direction: Vector2):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position

		var dagger_rotation = dagger_direction.angle()
		dagger.rotation = dagger_rotation

		attack_timer.start()


func apply_knockback(direction, strength):
	knockback = (direction.direction_to(self.global_position) * strength)


# ? Should i adjust the hurtbox individually or set it on the hurtbox itself
# func _on_HurtBox_area_entered(hitbox: Area2D):
# 	pass
# print("received: " + str(hitbox.damage) + " weapon damage")
# print("received: " + str(hitbox.character_damage) + " character damage")
# print("received: " + str(hitbox.total_damage) + " total damage")

# var final_damage = _randomize_damage(hitbox.total_damage)
# print(final_damage)
# apply_knockback(hitbox.global_position, hitbox.knockback_strength)
# Shake.shake(1.0, 0.2, 1)
# _take_damage(_randomize_damage(final_damage))
# spawn_effect(EFFECT_HIT)
# spawn_dmgIndicator(final_damage)


func _randomize_damage(damage: int):
	return int(round(rand_range(damage * 0.9, damage * 1.2)))


func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instance()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect


func spawn_dmgIndicator(damage: int):
	var indicator = spawn_effect(INDICATOR_DAMAGE)
	if indicator:
		indicator.label.text = str(damage)


func _take_damage(damage: int):
	hp -= damage
	if hp < 0:
		hp = 0
	_die_check(hp)


func _die_check(current_hp: int):
	if current_hp <= 0:
		spawn_effect(EFFECT_DIED)
		die()


func die():
	queue_free()
