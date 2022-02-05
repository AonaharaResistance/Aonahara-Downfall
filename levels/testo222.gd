extends InteractableItem


var time

func _ready():
  var parent = get_parent()
  time = parent.get_node("CanvasModulate")

func interaction_interact(_interactionComponentParent: Node) -> void:
  time.set_color("5c7898")

