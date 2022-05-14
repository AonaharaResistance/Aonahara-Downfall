extends InteractableItem

var rocks = preload("res://entities/enemies/basic_enemy.tscn")


func interaction_interact(_interactionComponentParent: Node) -> void:
	var rock = rocks.instance()
	get_tree().current_scene.add_child(rock)
