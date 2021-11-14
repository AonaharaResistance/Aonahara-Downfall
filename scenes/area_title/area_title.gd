extends CanvasLayer

onready var tween: Tween = $Tween


# * Essentially just fading out and freeing
func _ready() -> void:
	var _interpolate: bool = tween.interpolate_property(
		$CenterContainer, "modulate:a", 1.0, 0.0, 2, 3, 1
	)
	yield(get_tree().create_timer(3.0), "timeout")
	var _tween_status: bool = tween.start()


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
