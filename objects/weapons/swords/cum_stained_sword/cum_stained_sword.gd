extends Node2D

onready var animation: AnimationPlayer = $WeaponAnimation
onready var effect: AnimationPlayer = $EffectAnimation
onready var sound: AudioStreamPlayer2D = $SoundEffect


func _ready():
	print(str(get_node("../../").attack_speed))
	# ! a fucked up way of getting the player, might have to change
	animation.set_speed_scale(get_node("../../").attack_speed)


func _process(_delta) -> void:
	# ! posei wtf, please use the state machine
	if Input.is_action_pressed("attack"):
		animation.play("attack")
