extends KinematicBody2D
class_name Character

export (int) var speed:int
export (int) var hp:int
var velocity:Vector2 = Vector2.ZERO

func move() -> void:
	velocity = move_and_slide(velocity)

func _physics_process(_delta):
	move()

func _on_Hurtbox_entered():
  emit_signal("_on_hp_changed")

func die():
  queue_free()