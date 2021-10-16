extends StateMachine

onready var animation = parent.get_node("AnimationPlayer")


func _ready() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("dash")
	set_state(states.idle)


func _state_logic(_delta) -> void:
	parent.move()
	parent.sprite_control()

	if state != states.idle && parent.velocity.length() > 20 && parent.dash.can_dash:
		parent.activate_dash()


func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation.play("idle")
		states.move:
			animation.play("move")


func _get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > 10:
				return states.move
		states.move:
			if parent.velocity.length() < 10:
				return states.idle
			if round(parent.velocity.length()) > parent.max_speed:
				return states.dash
		states.dash:
			if parent.dash.is_dashing() != true:
				return states.move

	return -1
