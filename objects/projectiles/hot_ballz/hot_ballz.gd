extends Area2D

export(int) var SPEED: int = 200

export(int) var damage: int
export(int) var knockback_strength: float
var total_damage: int
var character_damage: int


func _ready() -> void:
	character_damage = Party.current_character().base_damage
	total_damage = damage + character_damage


func stop():
	SPEED = 0


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta


func _on_HotBallz_body_entered(body: Node):
	$AudioStreamPlayer2D.play()
	$Area2D/AnimationPlayer.play("explode")
	Shake.shake(10, 0.1)
	pass


func _on_Area2D_body_entered(body: Node):
	pass  # Replace with function body.


func _on_HotBallz_area_entered(area: Area2D):
	$AudioStreamPlayer2D.play()
	$Area2D/AnimationPlayer.play("explode")
	Shake.shake(10, 0.1)
	print("collide with enemy")


func _on_AudioStreamPlayer2D_finished():
	queue_free()
