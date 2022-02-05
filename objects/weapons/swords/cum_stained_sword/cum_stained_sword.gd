extends Node2D

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation
onready var sound: AudioStreamPlayer2D = $SoundEffect
var character: Character


func _ready():
    character = get_node("../../")
    # ! a fucked up way of getting the player, might have to change
    animation.set_speed_scale(character.attack_speed)


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
