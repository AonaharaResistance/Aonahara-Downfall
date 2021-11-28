extends StateMachine


func _ready() -> void:
	parent = get_parent()
	_add_state("wander")
	_add_state("chase")
	_add_state("shoot")
	set_state(states.wander)


func _state_logic(_delta) -> void:
	if state == states.wander:
		pass
		# parent.agent.move_and_slide(parent.agent_velocity)


func _enter_state(_previous_state: int, _new_state: int) -> void:
	pass
	# for animation
	# match new_state:
	# 	states.idle:
	# 		animation.play("idle")
	# 	states.move:
	# 		animation.play("move")


func _get_transition() -> int:
	return -1
	# The condition to transition
	# match state:
	# 	states.wander:
	# 		if parent.velocity.length() > 10:
	# 			return states.move
	# 	states.move:
	# 		if parent.velocity.length() < 10:
	# 			return states.idle
	# 		if round(parent.velocity.length()) > parent.max_speed:
	# 			return states.dash
	# 	states.dash:
	# 		if parent.dash.is_dashing() != true:
	# 			return states.move

	# return -1
