extends Buff

export var extra_hp: int
export var extra_damage: int
export var extra_acceleration: int
export var extra_max_speed: int


func _on_Duration_timeout():
	call_deferred("queue_free")


func modify_stateless(res):
	res["acceleration"] += extra_acceleration
	res["max_speed"] += extra_max_speed

	return res


func modify_stateful(_res):
	pass
