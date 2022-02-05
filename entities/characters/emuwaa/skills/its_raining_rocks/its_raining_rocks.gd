extends Skill

onready var aoe: Sprite = $AoE
onready var sort: YSort = $YSort
onready var timer: Timer = $Timer
onready var shadow: Sprite = $Shadow
onready var duration_timer: Timer = $DurationTimer
onready var spawning_circle: Sprite = $SpawningCircle
onready var animation: AnimationPlayer = $AnimationPlayer

var rocks = preload("res://entities/characters/emuwaa/skills/its_raining_rocks/rock_droplet.tscn")
var state: String

func _process(delta) -> void:
  _spin(delta)
  if !cooldown_timer.is_stopped():
    current_cooldown_indicator -= 60 * delta 
  if state == "Casting":
    aoe.global_position = get_global_mouse_position()
    if Input.is_action_just_pressed("cast_skill"):
      cast_skill()
    if Input.is_action_just_pressed("cancel_skill"):
      cancel_cast()


func _spin(delta: float) -> void:
  aoe.rotate(0.50 * delta)
  shadow.rotate(0.50 * delta)
  spawning_circle.rotate(0.50 * delta)

func _start_timers() -> void:
  timer.start()
  duration_timer.start()
  cooldown_timer.start()

func activate_skill() -> void:
  if cooldown_timer.is_stopped():
    state = "Casting"
    aoe.set_visible(true)
    Cursor.set_default_cursor(Cursor.target, Vector2(16, 16))


func cast_skill() -> void:
  state = "Not Casting"
  _start_timers()
  Cursor.set_default_cursor(Cursor.default, Vector2(16, 16))
  spawning_circle.global_position = get_global_mouse_position()
  shadow.global_position = spawning_circle.global_position - Vector2(0, -50)
  spawning_circle.set_rotation(aoe.get_rotation())
  shadow.set_rotation(aoe.get_rotation())
  spawning_circle.set_visible(true)
  shadow.set_visible(true)
  aoe.set_visible(false)


func cancel_cast() -> void:
  state = "Not Casting"
  aoe.set_visible(false)
  Cursor.set_default_cursor(Cursor.default, Vector2(16, 16))


func _on_Timer_timeout() -> void:
  var rock = rocks.instance()
  sort.add_child(rock)
  rock.global_position = (spawning_circle.global_position + Vector2(rand_range(-50, 50), rand_range(-50, 50)))


func _on_DurationTimer_timeout() -> void:
  timer.stop()  
  animation.play("end")


func _on_CooldownTimer_timeout() -> void:
  current_cooldown_indicator = cooldown_indicator
