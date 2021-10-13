extends KinematicBody2D


func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
