extends Area2D
class_name HitBox

# * Hitbox for things that output damage and knockback
# ? There's definitely a better way to make uniform hitbox that can output various effect but idk :mitodead:
# * To someone who might join the project deep after i integrate thing
# * You should considering selling your soul and make the current hitbox system more modular tq :LuluPray:
export(int) var damage: int
export(int) var knockback_strength: float
