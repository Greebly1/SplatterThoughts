extends CanvasLayer
class_name Splotch

@export var splotches : Array[Node]

func set_position(pos : Vector2):
	for splotch : Node in splotches:
		splotch.position = pos
