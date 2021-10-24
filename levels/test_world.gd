tool
extends Node2D

# * This thing is purposely messy for testing
export var player_path: NodePath

onready var player = get_tree().get_nodes_in_group("current_character").front()
onready var player_state = player.get_node("StateMachine")
onready var dash = player.get_node("Dash")


func _ready():
	var dialog = Dialogic.start("sexooooooo")
	add_child(dialog)

	# * Debug overlay settings
	# warning-ignore:unsafe_method_access
	var overlay = load("res://ui/debug_overlay.tscn").instance()
	overlay.add_stat("player speed", player, "velocity", false)
	overlay.add_stat("movement state", player_state, "_get_state_name", true)
	overlay.add_stat("is on battle: ", player, "get_is_on_battle", true)
	overlay.add_stat("can dash: ", dash, "can_dash", false)
	overlay.add_stat("dash cooldown: ", dash, "get_cooldown_timer", true)
	overlay.add_stat("stamina: ", player, "stamina", false)
	overlay.add_stat("stamina regen timer: ", player, "get_stamina_timer", true)
	overlay.add_stat("hp: ", player, "hp", false)

	add_child(overlay)
