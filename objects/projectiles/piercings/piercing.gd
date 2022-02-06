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


func _on_LifeTime_timeout():
	disable()
