extends Node2D

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation


func _process(_delta) -> void:
	if Input.is_action_pressed("attack"):
		animation.play("attack")
