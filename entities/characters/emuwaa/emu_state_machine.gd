extends StateMachine

onready var animation = parent.get_node("AnimationPlayer")


func _ready() -> void:
  _add_state("idle")
  _add_state("move")
  _add_state("idle_left")
  _add_state("move_left")
  _add_state("dash")
  set_state(states.idle)


func _state_logic(delta) -> void:
  parent.move(delta)
  parent.apply_dash()
  parent.listen_knockback(delta)
  parent.listen_to_skills()
  parent.listen_to_attacks()
  parent.sprite_control()

  if state != states.idle && parent.velocity.length() > 20 && parent.dash.can_dash:
    parent.activate_dash()


func _enter_state(_previous_state: int, new_state: int) -> void:
  match new_state:
    states.idle:
      animation.play("idle")
    states.move:
      animation.play("move")
    states.idle_left:
      animation.play("idle_left")
    states.move_left:
      animation.play("move_left")


func _get_transition() -> int:
  match state:
    states.idle:
      if parent.velocity.length() > 10:
        return states.move
      elif parent.velocity.length() > 10 and parent.get_mouse_direction().x < 0:
        return states.move_left
      elif parent.velocity.length() < 10 and parent.get_mouse_direction().x < 0:
        return states.idle_left
    states.idle_left:
      if parent.velocity.length() > 10:
        return states.move
      elif parent.velocity.length() > 10 and parent.get_mouse_direction().x < 0:
        return states.move_left
      elif parent.velocity.length() < 10 and parent.get_mouse_direction().x > 0:
        return states.idle
    states.move:
      if parent.velocity.length() < 10:
        return states.idle
      elif parent.velocity.length() > 10 and parent.get_mouse_direction().x < 0:
        return states.move_left
      elif parent.velocity.length() < 10 and parent.get_mouse_direction().x < 0:
        return states.idle_left
      elif round(parent.velocity.length()) > parent.max_speed:
        return states.dash
    states.move_left:
      if parent.velocity.length() < 10:
        return states.idle
      elif parent.velocity.length() > 10 and parent.get_mouse_direction().x > 0: 
        return states.move
      elif parent.velocity.length() < 10 and parent.get_mouse_direction().x < 0:
        return states.idle_left
      elif round(parent.velocity.length()) > parent.max_speed:
        return states.dash
    states.dash:
      if !parent.dash.is_dashing():
        return states.move
      elif !parent.dash.is_dashing() and parent.get_mouse_direction().x < 0:
        return states.move_left

  return -1
