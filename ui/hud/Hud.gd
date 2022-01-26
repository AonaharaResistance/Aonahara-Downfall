extends Node

onready var gui: Control = $CanvasLayer/GUI
onready var health_container = $CanvasLayer/GUI/MarginContainer/Top/Health
onready var empty_health_container = $CanvasLayer/GUI/MarginContainer/TopBackground/HealthEmpty
onready var stamina_fill = $CanvasLayer/GUI/MarginContainer/Top/Stamina
onready var stamina_container = $CanvasLayer/GUI/MarginContainer/TopBackground/StaminaFill
var visible := false setget set_visible
var health_full = preload("res://ui/hud/health_full.tscn")
var health_empty = preload("res://ui/hud/health_empty.tscn")
var stamina_start = preload("res://ui/hud/stamina_start.tscn")
var stamina_bar = preload("res://ui/hud/stamina_bar.tscn")
var stamina_bar_empty = preload("res://ui/hud/stamina_bar_empty.tscn")
var stamina_bar_filled = preload("res://ui/hud/stamina_bar_filled.tscn")
var stamina_point = preload("res://ui/hud/stamina_fill.tscn")
var stamina_end = preload("res://ui/hud/stamina_end.tscn")


func _ready():
	gui.visible = visible
	if !Party.is_party_empty():
		update_hud()


func update_hud():
	if !Party.is_party_empty():
		for i in health_container.get_children():
			health_container.remove_child(i)
		for i in empty_health_container.get_children():
			empty_health_container.remove_child(i)
		for i in Party.current_character().hp:
			health_container.add_child(health_full.instance())
		for i in Party.current_character().max_hp:
			empty_health_container.add_child(health_empty.instance())
	  
		for i in stamina_container.get_children():
			stamina_container.remove_child(i)
		for i in stamina_fill.get_children():
			stamina_fill.remove_child(i)
		stamina_container.add_child(stamina_start.instance())

		for i in range(Party.current_character().stamina):
			stamina_fill.add_child(stamina_bar_filled.instance())
		for i in range(Party.current_character().max_stamina):
			stamina_container.add_child(stamina_bar_empty.instance())
		stamina_container.add_child(stamina_end.instance())
		stamina_fill.add_child(stamina_end.instance())
func set_visible(value: bool) -> void:
	visible = value
	gui.visible = value
