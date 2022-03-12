extends CanvasLayer

onready var new_game_popup: PopupDialog = $CenterPopup/NewGamePopup


func _ready():
	Hud.set_visible(false)
	Hud.pause_mode = Node.PAUSE_MODE_STOP
	pass


func _on_OptionButton_pressed() -> void:
	pass


func _on_PlayButton_pressed() -> void:
	new_game_popup.popup()


func _on_No_pressed():
	new_game_popup.set_visible(false)


func _on_Yes_pressed():
	Game.change_scene(
		"res://scenes/opening/opening.tscn",
		{"show_texture": false, "show_tips": false, "show_progress_bar": false}
	)


func _on_test_pressed():
	Game.change_scene("res://levels/test_world/test_world.tscn", {})
