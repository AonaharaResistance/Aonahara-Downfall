extends Explosive

export var speed: int = 200
var direction = Vector2.ZERO
onready var animation: AnimationPlayer = $ExplosionHitBox/AnimationPlayer
onready var explosion_collision: CollisionShape2D = $ExplosionHitBox/CollisionShape2D


func disable():
	.disable()
	speed = 0
	yield(get_tree().create_timer(0.1), "timeout")
	explosion_collision.free()


func _ready():
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x < 0:
		sprite.scale.y *= -1


func _process(delta):
	global_position += speed * direction * delta


func _on_Audio_finished():
	queue_free()
