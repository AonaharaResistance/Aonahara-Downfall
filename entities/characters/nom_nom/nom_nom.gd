extends "res://entities/character.gd"

# TODO: Attack Mechanic

onready var weapon_container: Node2D = $Weapon
var cum_stained_sword = preload("res://entities/weapons/swords/cum_stained_sword/cum_stained_sword.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		weapon.add_child(cum_stained_sword.instance())
