extends Node2D

export var agent_path: NodePath
onready var agent = get_node(agent_path)
onready var agent_velocity = agent.velocity
onready var patrol_timer: Timer = $PatrolTimer
onready var patrol_duration: Timer = $PatrolDuration

var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO


func wander():
	randomize()
	patrol_duration.wait_time = rand_range(1.0, 2.2)
	patrol_timer.wait_time = rand_range(1.0, 4.2)
	var patrol_range = 100
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	patrol_location = Vector2(random_x, random_y) + origin
	patrol_duration.start()
	if (agent.global_position - agent.spawn_location).length() > Vector2(60, 60).length():
		agent_velocity = (agent.spawn_location - agent.global_position).clamped(30)
	else:
		agent_velocity = patrol_location.clamped(30)


func shoot():
	pass


func case():
	pass


func retreat():
	pass


func _on_PatrolTimer_timeout():
	wander()


func _on_PatrolDuration_timeout():
	patrol_timer.start()
