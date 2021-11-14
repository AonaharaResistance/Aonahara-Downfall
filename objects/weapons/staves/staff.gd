extends Node2D
class_name Staff

onready var animation: AnimationPlayer = $WeaponAnimation
var character: Character

var test_pro = preload("res://objects/projectiles/hot_ballz/hot_ballz.tscn")


func _ready():
	character = get_node("../../")


func light_attack():
	character.set_is_on_battle(true)
	character.battle_timer.start()
	animation.play("light_attack")


func light_attack_release():
	character.set_is_on_battle(true)
	character.battle_timer.start()
	animation.play("light_attack")


func heavy_attack():
	animation.play("charge_attack")
	character.set_is_on_battle(true)


func heavy_attack_release():
	animation.stop()
	$WeaponContainer/Particles2D.emitting = false
	animation.play("heavy_attack")
	var the_ballz = test_pro.instance()
	get_tree().get_current_scene().add_child(the_ballz)
	the_ballz.global_position = self.global_position
