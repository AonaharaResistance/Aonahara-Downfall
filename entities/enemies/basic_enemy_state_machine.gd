extends StateMachine

onready var animation = parent.get_node("AnimationPlayer")


func _ready() -> void:
	_add_state("hover")
	_add_state("fly")
	set_state(states.hover)


func _state_logic(delta) -> void:
	parent.listen_knockback(delta)


func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.hover:
			animation.play("fly")
		states.fly:
			animation.play("fly")
