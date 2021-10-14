extends Node2D

onready var player_container = get_node("Player")
onready var player = player_container.get_child(0)
onready var player_state = player.get_node("StateMachine")


func _ready():
	var overlay = load("res://ui/debug_overlay.tscn").instance()
	overlay.add_stat("player speed", player, "velocity", false)
	overlay.add_stat("movement state", player_state, "_get_state_name", true)
	add_child(overlay)
