extends Node2D

onready var camera2D: Camera2D = $Camera2D


func _process(_delta):
    if Party.current_character() != null:
        camera2D.current = true
        global_position = Party.current_character().global_position


func get_camera():
    return camera2D
