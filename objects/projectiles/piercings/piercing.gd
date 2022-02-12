extends Area2D
class_name Piercing

export var speed: int = 200
var direction = Vector2.ZERO
onready var sprite: Sprite = $Sprite
onready var collision: CollisionShape2D = $CollisionShape2D


func _process(delta):
	global_position += speed * direction * delta


func disable():
	sprite.set_visible(false)
	collision.free()


func launch():
	var angle_to_mouse = ((get_global_mouse_position() - Party.current_character().global_position).normalized()).angle()
	sprite.rotate(angle_to_mouse)


func _on_LifeTime_timeout():
	disable()


func _on_Lifetime_timeout():
	queue_free()
