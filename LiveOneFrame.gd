extends Node

var frame1 : bool = true
@export var nodeToDestroy : Node

#this script just kills this node after it has been rendered once
#it lives for 1 frame
#works like a component

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frame1:
		frame1 = false
	else:
		
		get_node("..").queue_free()
