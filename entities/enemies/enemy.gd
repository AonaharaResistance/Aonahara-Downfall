extends KinematicBody2D

export(int) var hp: int

onready var animation = $AnimationPlayer


func _ready():
	animation.play("fly")


func _on_HurtBox_area_entered(hitbox: Area2D):
	_take_damage(hitbox.damage)


func _take_damage(damage: int):
	hp -= damage
	if hp < 0:
		hp = 0
	_die_check(hp)


func _die_check(current_hp: int):
	if current_hp <= 0:
		die()


func die():
	queue_free()
