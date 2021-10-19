extends Node2D

# * This thing is purposely messy for testing

onready var player_container = get_node("Player")
onready var player = player_container.get_child(0)
onready var player_state = player.get_node("StateMachine")
onready var dash = player.get_node("Dash")


func _ready():
	var dialog = Dialogic.start("sexooooooo")
	add_child(dialog)

	# * Debug overlay settings
	var overlay = load("res://ui/debug_overlay.tscn").instance()
	overlay.add_stat("player speed", player, "velocity", false)
	overlay.add_stat("movement state", player_state, "_get_state_name", true)
	overlay.add_stat("can dash: ", dash, "can_dash", false)
	overlay.add_stat("dash cooldown: ", dash, "get_cooldown_timer", true)
	overlay.add_stat("stamina: ", player, "stamina", false)
	overlay.add_stat("stamina regen timer: ", player, "get_stamina_timer", true)
	overlay.add_stat("hp: ", player, "hp", false)

	add_child(overlay)
