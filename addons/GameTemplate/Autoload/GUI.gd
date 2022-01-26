extends Control


onready var health_container = $MarginContainer/Top/Health
var health_point = preload("res://ui/hud/health_point.tscn")
var health_amount = 2

func _ready():
  if !Party.is_party_empty():
	  update_hud()
  
func update_hud():
	health_container.add_child(health_point.instance())
extends Node

onready var hp: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/HP
onready var score: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/Score
onready var gui: = $CanvasLayer/GUI

var visible: = false setget set_visible

func _ready()->void:
	gui.visible = visible

func set_visible(value: bool)->void:
	visible = value
	gui.visible = value
