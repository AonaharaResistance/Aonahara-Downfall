extends CanvasLayer


func _ready():
	PauseMenu.can_show = false


func _on_OptionButton_pressed() -> void:
	MenuEvent.Options = true


func _on_PlayButton_pressed() -> void:
	Game.emit_signal("ChangeScene", "res://levels/TestWorld.tscn")
