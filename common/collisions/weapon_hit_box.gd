extends Area2D
class_name WeaponHitBox

# * The difference between normal hitbox is that
# * Weapon hitbox require character damage

export(int) var damage: int
export(int) var knockback_strength: float
var total_damage: int
var character_damage: int


func _ready():
	if !get_tree().get_nodes_in_group("current_character").empty():
		character_damage = get_tree().get_nodes_in_group("current_character").front().base_damage
		total_damage = damage + character_damage
