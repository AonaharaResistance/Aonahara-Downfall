extends Node

onready var gui: Control = $CanvasLayer/GUI
onready var health_container: HBoxContainer = $CanvasLayer/GUI/MarginContainer/Top/Health
onready var empty_health_container: HBoxContainer = $CanvasLayer/GUI/MarginContainer/TopBackground/HealthEmpty
onready var stamina_fill: HBoxContainer = $CanvasLayer/GUI/MarginContainer/Top/Stamina
onready var stamina_container: HBoxContainer = $CanvasLayer/GUI/MarginContainer/TopBackground/StaminaFill
onready var skill: SkillHud = $CanvasLayer/GUI/MarginContainer/Bottom/SkillsHud/

var health_full = preload("res://ui/hud/health/health_full.tscn")
var health_empty = preload("res://ui/hud/health/health_empty.tscn")
var stamina_start = preload("res://ui/hud/stamina/stamina_start.tscn")
var stamina_bar = preload("res://ui/hud/stamina/stamina_bar.tscn")
var stamina_bar_empty = preload("res://ui/hud/stamina/stamina_bar_empty.tscn")
var stamina_bar_filled = preload("res://ui/hud/stamina/stamina_bar_filled.tscn")
var stamina_point = preload("res://ui/hud/stamina/stamina_fill.tscn")
var stamina_end = preload("res://ui/hud/stamina/stamina_end.tscn")

var visible := false setget set_visible


func _ready() -> void:
  gui.visible = visible
  update_hud()


func update_hud() -> void:
  if !Party.is_party_empty():
    _update_health()
    _update_stamina()
    skill.update_skill()

func _update_health() -> void:
  for i in health_container.get_children():
    health_container.remove_child(i)
  for i in empty_health_container.get_children():
    empty_health_container.remove_child(i)
  for i in Party.current_character().hp:
    health_container.add_child(health_full.instance())
  for i in Party.current_character().max_hp:
    empty_health_container.add_child(health_empty.instance())

func _update_stamina() -> void:
  for i in stamina_container.get_children():
    stamina_container.remove_child(i)
  for i in stamina_fill.get_children():
    stamina_fill.remove_child(i)
  stamina_container.add_child(stamina_start.instance())

  for i in Party.current_character().stamina:
    stamina_fill.add_child(stamina_bar_filled.instance())
  for i in Party.current_character().max_stamina:
    stamina_container.add_child(stamina_bar_empty.instance())
  stamina_container.add_child(stamina_end.instance())
  stamina_fill.add_child(stamina_end.instance())

func set_visible(value: bool) -> void:
  visible = value
  gui.visible = value
