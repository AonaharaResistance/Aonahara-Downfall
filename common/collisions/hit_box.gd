extends Area2D
class_name HitBox

# * Hitbox for things that output damage and knockback
# * I think that this is going to be attached to body(s) that inflict damage to the player
# * eg: enemy's body, enviromental hazard etc
# ? There's definitely a better way to make uniform hitbox that can output various effect but idk :mitodead:
export(int) var damage: int
export(int) var knockback_strength: float
