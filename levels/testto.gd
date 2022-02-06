extends InteractableItem

var rocks = preload("res://entities/enemies/basic_enemy.tscn")


func interaction_interact(_interactionComponentParent: Node) -> void:
	var rock = rocks.instance()
	add_child(rock)
