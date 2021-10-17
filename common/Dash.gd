extends Node2D

signal dash_ended

const dash_delay: float = 1.5

onready var duration_timer: Timer = $DurationTimer
onready var ghost_timer: Timer = $GhostTimer
onready var cooldown_timer: Timer = $CooldownTimer
onready var dust_trail: Particles2D = $DustTrail
onready var dust_burst: Particles2D = $DustBurst
onready var character: Character = get_parent()

var ghost_scene: PackedScene = preload("res://common/DashGhost.tscn")
var can_dash: bool setget set_can_dash, get_can_dash
var dash_sprite: Sprite


func _ready():
	cooldown_timer.wait_time = dash_delay


func set_can_dash(new_value: bool):
	can_dash = new_value


func get_can_dash() -> bool:
	if character.stamina <= 0:
		return false
	return cooldown_timer.is_stopped()


func start_dash(character_sprite: Sprite, duration: float, direction: Vector2) -> void:
	set_can_dash(false)
	character.hurt_box.disabled = true
	cooldown_timer.start()
	duration_timer.wait_time = duration
	duration_timer.start()

	dash_sprite = character_sprite
	dash_sprite.material.set_shader_param("mix_weight", 0.7)
	dash_sprite.material.set_shader_param("whiten", true)

	ghost_timer.start()
	instance_ghost()

	dust_trail.restart()
	dust_trail.emitting = true

	dust_burst.rotation = (direction * -1).angle()
	dust_burst.restart()
	dust_burst.emitting = true


func instance_ghost() -> void:
	var ghost: Sprite = ghost_scene.instance()
	ghost.add_to_group("dash_ghosts")
	get_node("../..").add_child(ghost)

	ghost.global_position = global_position
	ghost.texture = dash_sprite.texture
	ghost.vframes = dash_sprite.vframes
	ghost.hframes = dash_sprite.hframes
	ghost.frame = dash_sprite.frame
	ghost.flip_h = dash_sprite.flip_h


func is_dashing() -> bool:
	return !duration_timer.is_stopped()


func end_dash() -> void:
	emit_signal("dash_ended")
	character.hurt_box.disabled = false
	dash_sprite.material.set_shader_param("whiten", false)
	ghost_timer.stop()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().call_group("dash_ghosts", "queue_free")


func _on_DurationTimer_timeout() -> void:
	end_dash()


func _on_GhostTimer_timeout() -> void:
	instance_ghost()


func _on_CooldownTimer_timeout() -> void:
	can_dash = true


func get_cooldown_timer() -> float:
	return cooldown_timer.time_left
