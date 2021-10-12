extends Control

func _ready():
	pass

func _on_OptionButton_pressed():
	MenuEvent.Options = true;

func _on_PlayButton_pressed():
  Game.emit_signal('ChangeScene', "res://entities/characters/nom_nom/nom_nom.tscn")
