extends Node2D
onready var white_cursor = preload("res://assets/place_holder/nitsub.png")
onready var black_cursor = preload("res://assets/place_holder/Nitsu test.png")
onready var Icon = self.get_node("Icon")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	self.position = self.get_global_mouse_position()

	if self.position.x > 100:
		self.Icon.texture = black_cursor
	else:
		self.Icon.texture = white_cursor
