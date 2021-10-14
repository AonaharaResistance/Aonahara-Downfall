extends KinematicBody2D


func _on_HurtBox_area_entered(hitbox: Area2D):
	print(hitbox.damage)
