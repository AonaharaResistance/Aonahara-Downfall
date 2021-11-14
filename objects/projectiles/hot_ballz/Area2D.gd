extends Area2D

export(int) var damage: int
export(int) var knockback_strength: float
var total_damage: int
var character_damage: int


func _ready() -> void:
	character_damage = Party.current_character().base_damage
	total_damage = damage + character_damage


func do_damage():
	pass
