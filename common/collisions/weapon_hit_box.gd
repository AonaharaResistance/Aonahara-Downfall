extends Area2D
class_name WeaponHitBox

# The difference between normal hitbox is that
# Weapon hitbox require character damage

var damage: int
var knockback_strength: float
var total_damage: int


func sum_damage() -> void:
	total_damage = damage + Party.current_character().get_attribute("base_damage")


func _ready() -> void:
	sum_damage()
