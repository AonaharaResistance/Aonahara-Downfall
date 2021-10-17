extends Node2D

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation
onready var sound: AudioStreamPlayer2D = $SoundEffect


func _ready():
	print(str(get_node("../../").attack_speed))
	animation.set_speed_scale(get_node("../../").attack_speed)


func _process(_delta) -> void:
	if Input.is_action_pressed("attack"):
		animation.play("attack")
