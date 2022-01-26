extends Node

signal current_active_changed

var party_members: Array = []
const PARTY_MAX: int = 4
var selected_member: int = 0 setget set_selected_member, get_selected_member_index


func _process(_delta):
	swap_control()


func swap_control() -> void:
	# TODO: Handle else
	if Input.is_action_just_pressed("party1") && party_members.size() >= 1:
		change_party_member(0)
	if Input.is_action_just_pressed("party2") && party_members.size() >= 2:
		change_party_member(1)
	if Input.is_action_just_pressed("party3") && party_members.size() >= 3:
		change_party_member(2)
	if Input.is_action_just_pressed("party4") && party_members.size() >= 4:
		change_party_member(3)


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
  set_selected_member(index)
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
	character.isOnControl = false
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
	character.isOnControl = true
	for sprite in sprites:
		sprite.set_visible(true)
