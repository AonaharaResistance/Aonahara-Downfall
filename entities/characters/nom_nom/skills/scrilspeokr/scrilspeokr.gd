extends Node2D

export var n: PackedScene = null
export var o: PackedScene = null
export var m: PackedScene = null
export var parent: NodePath

onready var timer: Timer = $DurationTimer

var skill_name: String = "scrilspeokr" setget , get_skill_name
var skill_level: int = 1 setget set_skill_level, get_skill_level

signal on_scrilspeokr_activated


func set_skill_level(new_level) -> void:
	skill_level = new_level


func get_skill_level() -> int:
	return skill_level


func get_skill_name() -> String:
	return skill_name


func activate_skill() -> void:
	var level = get_skill_level()
	var illusions = []
	var character = get_node(parent)
	match level:
		1:
			illusions.append(n)
		2:
			illusions.append(n)
			illusions.append(o)
		3:
			illusions.append(n)
			illusions.append(o)
			illusions.append(m)
	for illusion in illusions:
		var illusion_instance = illusion.instance()
		get_tree().current_scene.add_child(illusion_instance)
		illusion_instance.global_position = (
			character.global_position
			+ Vector2(rand_range(5, 10), rand_range(10, 5))
		)
		illusion_instance.add_to_group("scrilspeokrs")
	timer.start()
	emit_signal("on_scrilspeokr_activated", illusions)


func take_pill():
	queue_free()


func _on_DurationTimer_timeout():
	print("aw")
	get_tree().call_group("scrilspeokrs", "queue_free")
