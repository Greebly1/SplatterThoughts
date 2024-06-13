extends Sprite2D

var frame1 : bool = true

#this script just kills this node after it has been rendered once
#it lives for 1 frame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frame1:
		frame1 = false
	else:
		queue_free()
