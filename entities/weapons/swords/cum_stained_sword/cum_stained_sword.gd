extends Node2D

onready var sprite: Sprite = $Sprite
onready var animation: AnimationPlayer = $AnimationPlayer


func _process(_delta):
	if Input.is_action_pressed("attack"):
		animation.play("attack")
