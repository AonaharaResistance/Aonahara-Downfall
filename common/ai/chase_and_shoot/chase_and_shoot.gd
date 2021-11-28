extends Node2D
class_name ChaseAndShoot

export var agent_path: NodePath
export var patrol_range: int
export var maximum_patrol_rest: float
export var maximum_patrol_duration: float

onready var agent: Enemy = get_node(agent_path)
onready var agent_velocity: Vector2 = agent.velocity
onready var patrol_timer: Timer = $PatrolTimer
onready var patrol_duration: Timer = $PatrolDuration

var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO


func _ready():
	randomize()


# * Wander on predefined limit
# * If the limit is reached
# * Agent will wander  back to its original pos
func wander():
	_randomize_timers()
	patrol_location = _randomize_patrol_range() + origin
	patrol_duration.start()
	if !patrol_duration.is_stopped():
		if (agent.global_position - agent.spawn_location).length() > Vector2(60, 60).length():
			agent_velocity = (agent.spawn_location - agent.global_position)
		else:
			agent_velocity = patrol_location
	agent.set_target(patrol_location)
	print(patrol_location)


# * Alerted if player is detected
# * Will alert the sorounding agent
func alert():
	pass


# * Follow player and closing distance
func chase():
	pass


# * Attack at player
func shoot():
	pass


# * Go back to spawn pos
func retreat():
	pass


func _randomize_timers() -> void:
	patrol_duration.wait_time = rand_range(1.0, maximum_patrol_duration)
	patrol_timer.wait_time = rand_range(3.0, maximum_patrol_rest)


func _randomize_patrol_range() -> Vector2:
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	return Vector2(random_x, random_y)


func _on_PatrolTimer_timeout():
	wander()


func _on_PatrolDuration_timeout():
	patrol_timer.start()
