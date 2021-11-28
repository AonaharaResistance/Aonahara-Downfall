extends Area2D
class_name Explosive

signal exploded
onready var sprite: Sprite = $Sprite
onready var collision: CollisionShape2D = $CollisionShape2D


func disable():
	sprite.set_visible(false)
	collision.free()


func _on_Explosive_body_entered(_body: Node):
	disable()
	emit_signal("exploded")


func _on_Explosive_area_entered(_area: Area2D):
	disable()
	emit_signal("exploded")


func _on_LifeTime_timeout():
	disable()
	emit_signal("exploded")
