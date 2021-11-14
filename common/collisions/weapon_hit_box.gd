extends Area2D
class_name WeaponHitBox

# * The difference between normal hitbox is that
# * Weapon hitbox require character damage

export(int) var damage: int
export(int) var knockback_strength: float
var total_damage: int
var character_damage: int


func do_damage():
	pass


func _ready() -> void:
	character_damage = Party.current_character().base_damage
	total_damage = damage + character_damage
