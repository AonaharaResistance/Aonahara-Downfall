extends Area2D

export(int) var damage: int
var total_damage: int
var character_damage: int


func _ready():
	if get_tree().get_nodes_in_group("current_character").front() != null:
		character_damage = get_tree().get_nodes_in_group("current_character").front().base_damage
		total_damage = damage + character_damage
