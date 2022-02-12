extends Area2D

onready var explosion_animation: AnimationPlayer = $ExplosionHitBox/AnimationPlayer
onready var animation: AnimationPlayer = $AnimationPlayer
onready var explosion_collision: CollisionShape2D = $ExplosionHitBox/CollisionShape2D
onready var fire_collision: CollisionShape2D = $FireHitBox/CollisionShape2D
onready var duration_timer: Timer = $Duration
onready var fire_interval: Timer = $FireDoT
signal exploded


func explode() -> void:
	emit_signal("exploded")
	yield(get_tree().create_timer(0.1), "timeout")
	explosion_collision.free()
	duration_timer.start()
	fire_interval.start()


func _on_FireDoT_timeout():
	#fire_collision.set_deferred("disabled", false)
	fire_collision.set_disabled(false)
	yield(get_tree().create_timer(0.1), "timeout")
	fire_collision.set_disabled(true)
	#fire_collision.set_deferred("disabled", true)


func _on_Duration_timeout():
	animation.play("fade")
