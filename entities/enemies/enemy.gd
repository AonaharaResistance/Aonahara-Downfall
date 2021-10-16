extends KinematicBody2D

export(int) var hp: int

onready var animation = $AnimationPlayer


func _ready():
	animation.play("fly")


func _on_HurtBox_area_entered(hitbox: Area2D):
	print("received: " + str(hitbox.damage) + " weapon damage")
	print("received: " + str(hitbox.character_damage) + " character damage")
	print("received: " + str(hitbox.total_damage) + " total damage")
	_take_damage(hitbox.total_damage)


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
