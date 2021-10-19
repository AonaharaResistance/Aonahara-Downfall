extends Area2D

const whiten_duration = 0.15
export(ShaderMaterial) var whiten_material
onready var collision_shape = $CollisionShape2D

# TODO: implement i-frame correctly

# var is_invincible = false

# func start_invincibility(invincibility_duration):
# 	is_invincible = true
# 	collision_shape.set_deferred("disabled", true)
# 	yield(get_tree().create_timer(invincibility_duration), "timeout")
# 	collision_shape.set_deferred("disabled", false)
# 	is_invincible = false

# func _on_HurtBox_area_entered(_area: Area2D) -> void:
# 	print(whiten_material)
# 	print(whiten_material.get_shader_param("whiten"))
# 	material.set_shader_param("whiten", true)
# 	yield(get_tree().create_timer(whiten_duration), "timeout")
# 	material.set_shader_param("whiten", false)
