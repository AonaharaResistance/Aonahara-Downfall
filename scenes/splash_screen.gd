extends Node2D

# * To anyone who have to work with this file in the future
# * I am terribly sorry
# * signed posei

onready var tween: Tween = $Tween
onready var rect: ColorRect = $ColorRect
onready var bg: Node2D = $bg

var ajig: bool = false


func _ready():
	$Aonares.gravity_scale = 0
	tween.pause_mode = Node.PAUSE_MODE_PROCESS

	bg.pause_mode = Node.PAUSE_MODE_PROCESS
	var _interpolate: bool = tween.interpolate_property(rect, "modulate:a", 1.0, 0.0, 2.0, 3, 1)

	var _tween_status: bool = tween.start()


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	print("bruh")
	$Aonares.gravity_scale = 10
	$Aonares.sleeping = false


func _on_VisibilityNotifier2D_screen_exited():
	for bgss in bg.get_children():
		$ModulateTween.interpolate_property(bgss, "modulate:g", 1.0, 0.0, 2.5, 3, 1)
		$ModulateTween.interpolate_property(bgss, "modulate:b", 1.0, 0.0, 2.5, 3, 1)
		$ModulateTween.start()
	var _interpolate: bool = tween.interpolate_property(rect, "modulate:a", 0.0, 1.0, 5.0, 3, 1)
	var _tween_status: bool = tween.start()


func _on_Aonares_body_entered(body):
	print(ajig)
	print("bruhaa:")
	$Aonares/Particles2D.set_emitting(true)
	if !ajig:
		$Aonares/boom.play()
		ajig = true


func _on_ModulateTween_tween_completed(object, key):
	Game.emit_signal("ChangeScene", "res://menus/main_menu/main_menu.tscn")