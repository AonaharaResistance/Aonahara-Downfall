extends StateMachine

onready var animation_tree: AnimationTree = parent.get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")


func _ready() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("casting")
	_add_state("dash")
	set_state(states.idle)


func _state_logic(delta) -> void:
	animation_tree.set("parameters/idle/blend_position", parent.get_mouse_direction().x)
	animation_tree.set("parameters/walk/blend_position", parent.get_mouse_direction().x)

	if !state == states.casting:
		parent.move(delta)
		parent.sprite_control()
		parent.apply_dash()
		parent.listen_knockback(delta)

	if state != states.idle && parent.velocity.length() > 20 && parent.dash.can_dash:
		parent.activate_dash()


func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation_mode.travel("idle")
		states.move:
			animation_mode.travel("walk")
		states.casting:
			animation_mode.travel("casting")


func _get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > 10:
				return states.move
			if !parent.skill_two.cast_timer.is_stopped():
				return states.casting
		states.move:
			if parent.velocity.length() < 10:
				return states.idle
			if round(parent.velocity.length()) > parent.max_speed:
				return states.dash
			if !parent.skill_two.cast_timer.is_stopped():
				return states.casting
		states.dash:
			if !parent.dash.is_dashing():
				return states.move
		states.casting:
			if parent.skill_two.cast_timer.is_stopped():
				return states.idle

	return -1
