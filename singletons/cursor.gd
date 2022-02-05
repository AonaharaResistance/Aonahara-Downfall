extends Node

var default: Resource = preload("res://assets/cursors/default32.png") 
var target: Resource = preload("res://assets/cursors/target32.png")


func _ready():
  Input.set_custom_mouse_cursor(default, Input.CURSOR_ARROW, Vector2(16,16))

func set_default_cursor(new_cursor: Resource, position: Vector2):
  Input.set_custom_mouse_cursor(new_cursor, Input.CURSOR_ARROW, position)
