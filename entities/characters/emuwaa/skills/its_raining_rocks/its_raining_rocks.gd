extends Node2D

var rocks = preload("res://entities/characters/emuwaa/skills/its_raining_rocks/rock_droplet.tscn")
onready var sprite = $Sprite
onready var sort = $YSort


func _on_Timer_timeout():
	var rock = rocks.instance()
	sort.add_child(rock)
	rock.global_position = (
		sprite.global_position
		+ Vector2(rand_range(-50, 50), rand_range(-50, 50))
	)
