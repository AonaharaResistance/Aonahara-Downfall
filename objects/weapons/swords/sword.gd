extends Node2D
class_name Sword

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation
onready var sound: AudioStreamPlayer2D = $SoundEffect

export var holdable_light: bool
export var holdabke_heavy: bool

var character: Character


func _ready():
	# ? Again is this even safe? seems reliable so far
	character = get_node("../../")


func light_attack():
	character.set_is_on_battle(true)
	character.battle_timer.start()
	animation.play("attack")


func light_attack_release():
	pass


func heavy_attack():
	character.set_is_on_battle(true)
	character.battle_timer.start()
	animation.play("spin")


func heavy_attack_release():
	pass
