extends Control


func _on_Button_pressed():
	Game.emit_signal("ChangeScene", "res://menus/main_menu/main_menu.tscn")
