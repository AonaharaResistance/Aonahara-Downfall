extends KinematicBody2D

export(int) var hp: int

onready var animation = $AnimationPlayer

var receives_knockback: bool = true

var knockback = Vector2.ZERO


func _ready():
	animation.play("fly")


func _process(delta):
	listen_knockback(delta)


func listen_knockback(delta):
	if receives_knockback:
		knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
		knockback = move_and_slide(knockback)


func apply_knockback(direction, strength):
	knockback = (direction.direction_to(self.global_position) * strength)


func _on_HurtBox_area_entered(hitbox: Area2D):
	print("received: " + str(hitbox.damage) + " weapon damage")
	print("received: " + str(hitbox.character_damage) + " character damage")
	print("received: " + str(hitbox.total_damage) + " total damage")
	apply_knockback(hitbox.global_position, hitbox.knockback_strength)
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
