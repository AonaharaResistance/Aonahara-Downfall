extends "res://Entity/EntityBase.gd"

# TODO: Make Attcack Mechanic

onready var animation = $AnimationPlayer
onready var sprite = $Sprite

func _physics_process(_delta):
  var input_direction:Vector2 = get_input_direction()
  animation_control(input_direction)
  velocity = speed * input_direction

# Deciding which animation to play based on input
func animation_control(input_direction:Vector2):
    if input_direction!= Vector2.ZERO:
      animation.play("moving_right")
    else:
      animation.play("idle")
    if input_direction.x != 0 and sign(sprite.scale.x) != sign(input_direction.x):
      sprite.scale.x *= -1

func get_input_direction()-> Vector2:
  var input_direction:Vector2 = Vector2.ZERO
  
  input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  input_direction = input_direction.normalized()

  return input_direction
