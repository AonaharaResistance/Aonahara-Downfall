extends Node2D

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation
onready var sound: AudioStreamPlayer2D = $SoundEffect


func _process(_delta) -> void:
	if Input.is_action_just_pressed("attack"):
		# effect.play("slash")
		sound.play()
		animation.play("attack")
