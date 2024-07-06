extends CanvasLayer
class_name Splotch

@export var splotches : Array[Node2D]

func set_position(pos : Vector2):
	for splotch : Node in splotches:
		splotch.position = pos

func set_size(diameter : float):
	for splotch : Node2D in splotches:
		splotch.scale = Vector2(diameter, diameter)
	pass
