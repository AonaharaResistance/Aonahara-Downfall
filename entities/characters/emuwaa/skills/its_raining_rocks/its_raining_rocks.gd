extends Node2D

var rocks = preload("res://entities/characters/emuwaa/skills/its_raining_rocks/rock_droplet.tscn")

onready var timer: Timer = $Timer
onready var duration_timer: Timer = $DurationTimer
onready var sprite: Sprite = $Sprite
onready var aoe: Sprite = $AoE
onready var sort: YSort = $YSort

var state: String

func _process(_delta):
  if state == "Casting":
    aoe.global_position = get_global_mouse_position()
    Cursor.set_default_cursor(Cursor.target, Vector2(16, 16))
    if Input.is_action_just_pressed("light_attack"):
      cast_skill()

func activate_skill():
  aoe.visible = true
  state = "Casting"
  



func cast_skill():
  aoe.visible = false
  sprite.visible = true
  sprite.global_position = get_global_mouse_position()
  timer.start()
  duration_timer.start()
  Cursor.set_default_cursor(Cursor.default, Vector2(16, 16))
  state = "Not Casting"

func _on_Timer_timeout():
	var rock = rocks.instance()
	sort.add_child(rock)
	rock.global_position = (
		sprite.global_position
		+ Vector2(rand_range(-50, 50), rand_range(-50, 50))
	)


func _on_DurationTimer_timeout():
  timer.stop()
  sprite.visible = false
