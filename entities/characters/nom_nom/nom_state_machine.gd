extends StateMachine

onready var animation = parent.get_node("AnimationPlayer")


func _ready() -> void:
	_add_state("idle")
	_add_state("move")
	set_state(states.idle)


func _state_logic(_delta) -> void:
	parent.move()
	parent.sprite_control()


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
	return -1
