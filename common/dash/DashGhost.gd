extends Sprite


func _ready():
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.5, 3, 1)
	$Tween.start()


# TODO: Figure out why this doesn't work
# i added a manual queue free on the dash instead lol, forgot this exist
# might be a cleaner implementation rather than creating a timer to set the ghost free :hanalul:
func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
