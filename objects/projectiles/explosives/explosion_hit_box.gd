extends WeaponHitBox
class_name ExplosionHitBox

export var detonator_path: NodePath
onready var detonator = get_node(detonator_path)
onready var animation: AnimationPlayer = $AnimationPlayer


func _ready():
	detonator.connect("exploded", self, "_on_exploded")


func _on_exploded():
	animation.play("explode")
