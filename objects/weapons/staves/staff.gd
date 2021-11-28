extends Node2D
class_name Staff

export var heavy_cooldown_time: float = 0
export var light_projectile: PackedScene
export var heavy_projectile: PackedScene
export var chargable_light: bool
export var chargable_heavy: bool
export var charged: bool = false

onready var heavy_cooldown_timer: Timer = $HeavyCooldown
onready var animation: AnimationPlayer = $WeaponAnimation
onready var weapon_particle: Particles2D = $WeaponContainer/ChargeParticle

var character: Character

enum { LIGHT, HEAVY }


func _ready():
	# ! Very dangerous and unsage but i like it :HenryMatsuri:
	character = get_node("../../")
	heavy_cooldown_timer.set_wait_time(heavy_cooldown_time)


func light_attack():
	character.set_is_on_battle(true)
	if chargable_light:
		animation.play("light_charge")
	else:
		animation.play("light_attack")


func light_attack_release():
	animation.stop()
	if chargable_light:
		character.set_is_on_battle(true)
		animation.play("light_attack")


func heavy_attack():
	character.set_is_on_battle(true)
	if chargable_heavy:
		animation.play("heavy_charge")
	else:
		animation.play("heavy_attack")


func heavy_attack_release():
	animation.play("RESET")
	if chargable_heavy && heavy_cooldown_timer.is_stopped() && charged:
		charged = false
		animation.play("heavy_attack")


func _spawn_projectile(projectile_type):
	if projectile_type == LIGHT:
		var active_projectile = light_projectile.instance()
		get_tree().get_current_scene().add_child(active_projectile)
		active_projectile.direction = character.get_mouse_direction()
		active_projectile.global_position = self.global_position
	if projectile_type == HEAVY:
		var active_projectile = heavy_projectile.instance()
		get_tree().get_current_scene().add_child(active_projectile)
		active_projectile.direction = character.get_mouse_direction()
		active_projectile.global_position = self.global_position
