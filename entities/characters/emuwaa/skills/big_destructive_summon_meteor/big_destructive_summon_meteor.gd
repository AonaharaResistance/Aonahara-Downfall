extends Skill

export var meteor: PackedScene
export var character_path: NodePath

onready var character: Character = get_node(character_path)
onready var spawning_circle: Sprite = $SpawningCircle
onready var particle: Particles2D = $SpawningCircle/SpawningParticle
onready var animation: AnimationPlayer = $AnimationPlayer
onready var cast_timer: Timer = $CastTimer
var casting: bool = false


func _unhandled_input(event):
	if casting:
		if event.is_action_pressed("cast_skill"):
			cast_skill()
		if event.is_action_pressed("cancel_skill"):
			cancel_cast()


func activate_skill() -> void:
	if cooldown_timer.is_stopped():
		casting = true
		spawning_circle.set_visible(true)
		Cursor.set_default_cursor(Cursor.target, Vector2(16, 16))


func _start_timers() -> void:
	cooldown_timer.start()
	cast_timer.start()


func cast_skill() -> void:
	casting = false
	particle.set_visible(true)
	_start_timers()
	Hud.start_channeling(cast_timer.get_wait_time() * 60)
	Cursor.set_default_cursor(Cursor.default, Vector2(16, 16))


func cancel_cast() -> void:
	casting = false
	spawning_circle.set_visible(false)
	Cursor.set_default_cursor(Cursor.default, Vector2(16, 16))


func _process(delta) -> void:
	_spin(delta)
	if !cooldown_timer.is_stopped():
		current_cooldown_indicator -= 60 * delta
	if casting:
		spawning_circle.global_position = get_global_mouse_position()


func _spin(delta: float) -> void:
	spawning_circle.rotate(0.50 * delta)


func _on_CastTimer_timeout():
	var active_meteor = meteor.instance()
	Game.get_active_scene().add_child(active_meteor)
	active_meteor.global_position = spawning_circle.global_position
	active_meteor.global_position += Vector2(307.173, -265.675)
	animation.play("fade")
