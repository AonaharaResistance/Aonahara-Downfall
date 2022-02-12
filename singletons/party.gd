extends Node

signal current_active_changed

var party_members: Array = []
const PARTY_MAX: int = 4
var selected_member: int = 0 setget set_selected_member, get_selected_member_index


func current_scene() -> Node:
	return get_tree().get_current_scene()


func is_party_empty() -> bool:
	if party_members.size() - 1 != -1:
		return false
	else:
		return true


func set_selected_member(index: int) -> void:
	selected_member = index


func get_selected_member_index() -> int:
	return selected_member


func spawn_party(target_node) -> void:
	for member in party_members:
		target_node.add_child(member)
	tactical_character_showing(current_character())


func add_party_member(member) -> void:
	if party_members.size() < PARTY_MAX:
		party_members.append(member)
	else:
		# TODO: pop up notice party max
		pass


func remove_party_member(index: int) -> void:
	party_members.remove(index)


# TODO: Swap party member


func current_character():
	if !is_party_empty():
		return party_members[get_selected_member_index()]
	else:
		# TODO: Handle if part is empty
		return null


func change_party_member(index):
	var pos = current_character().global_position
	tactical_character_hiding(current_character())
	var k_up = current_character().k_up
	var k_down = current_character().k_down
	var k_left = current_character().k_left
	var k_right = current_character().k_right
	set_selected_member(index)
	current_character().k_up = k_up
	current_character().k_down = k_down
	current_character().k_left = k_left
	current_character().k_right = k_right
	current_character().global_position = pos
	tactical_character_showing(current_character())
	emit_signal("current_active_changed")
	Hud.update_hud()


func tactical_character_hiding(character):
	# ! Will break if the characters scene nodes renamed
	var sprites = [
		character.get_node("Sprite"),
		character.get_node("ShadowSprite"),
		character.get_node("Weapon")
	]
	character.get_node("HurtBox/CollisionShape2D").set_disabled(true)
	character.is_on_control = false
	for sprite in sprites:
		sprite.set_visible(false)


func tactical_character_showing(character):
	# ! Will break if the characters scene nodes renamed
	var sprites = [
		character.get_node("Sprite"),
		character.get_node("ShadowSprite"),
		character.get_node("Weapon")
	]
	character.get_node("HurtBox/CollisionShape2D").set_disabled(false)
	character.is_on_control = true
	for sprite in sprites:
		sprite.set_visible(true)
