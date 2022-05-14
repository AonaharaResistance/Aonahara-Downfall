extends InteractableItem

var rocks = preload("res://entities/enemies/chaser/fromb/fromb.tscn")


func interaction_interact(_interactionComponentParent: Node) -> void:
	var rock = rocks.instance()
	get_tree().current_scene.add_child(rock)
	rock.global_position = get_node("spawn_point").global_position
