extends Area2D
class_name WeaponHitBox

# * The difference between normal hitbox is that
# * Weapon hitbox require character damage

export var damage: int
export var knockback_strength: float
var total_damage: int
var character_damage: int


func sum_damage() -> void:
    character_damage = Party.current_character().base_damage
    total_damage = damage + character_damage


func _ready() -> void:
    sum_damage()
