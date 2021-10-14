extends Node
class_name StateMachine

var previous_state = null
var states: Dictionary = {}
var state: int = -1 setget set_state

onready var parent = get_parent()


func _physics_process(delta) -> void:
	if state != -1:
		_state_logic(delta)
		var transition: int = _get_transition()
		if transition != -1:
			set_state(transition)


func _state_logic(_delta) -> void:
	pass


func _get_transition() -> int:
	return -1


func _add_state(new_state: String) -> void:
	states[new_state] = states.size()


func set_state(new_state: int) -> void:
	_exit_state(state)
	previous_state = state
	state = new_state
	_enter_state(previous_state, state)


func _enter_state(_previous_state: int, _new_state: int) -> void:
	pass


func _exit_state(_state_exited: int) -> void:
	pass


func _get_state_name():
	return states.keys()[state]
