extends Node2D
class_name Staff

export var heavy_cooldown_time: float = 0
export var light_projectile: PackedScene
export var heavy_projectile: PackedScene
export var chargable_light: bool
export var chargable_heavy: bool
export var holdable_light: bool
export var holdabke_heavy: bool
export var heavy_charged: bool = false

onready var heavy_cooldown_timer: Timer = $HeavyCooldown
onready var light_cooldown_timer: Timer = $LightCooldown
onready var weapon_particle: Particles2D = $WeaponContainer/ChargeParticle
onready var animation: AnimationPlayer = $WeaponAnimation

var character: Character

enum { LIGHT, HEAVY }

# Upon creating an inherited scenes based on staff
# please create the following animations name:
# light_charge, light_attack, heavy_charge, heavy_attack
# these animations can't be made in the parent class
# because the engine will copy its child properties as the parent properties
# which is uuh?
# but yeah, even if the animation is empty it's fine


func _ready():
	# ! Very dangerous and unsage but i like it :HenryMatsuri:
	character = get_node("../../")
	heavy_cooldown_timer.set_wait_time(heavy_cooldown_time)


func light_attack():
	character.set_is_in_battle(true)
	if chargable_light and light_cooldown_timer.is_stopped():
		animation.play("light_charge")
	elif !chargable_light and light_cooldown_timer.is_stopped():
		animation.play("light_attack")
		light_cooldown_timer.start()


func light_attack_release():
	animation.stop()
	if chargable_light:
		character.set_is_in_battle(true)
		animation.play("light_attack")


func heavy_attack():
	character.set_is_in_battle(true)
	if chargable_heavy:
		animation.play("heavy_charge")
	else:
		animation.play("heavy_attack")


func heavy_attack_release():
	animation.play("RESET")
	if chargable_heavy && heavy_cooldown_timer.is_stopped() && heavy_charged:
		heavy_charged = false
		animation.play("heavy_attack")
		heavy_cooldown_timer.start()


# A convinient template if the weapon attacks is just spawning projectiles
func _spawn_projectile(projectile_type):
	var active_projectile
	if projectile_type == LIGHT:
		active_projectile = light_projectile.instance()
	if projectile_type == HEAVY:
		active_projectile = heavy_projectile.instance()
	Game.get_active_scene().add_child(active_projectile)
	active_projectile.direction = character.get_mouse_direction()
	active_projectile.global_position = self.global_position
	active_projectile.launch()
