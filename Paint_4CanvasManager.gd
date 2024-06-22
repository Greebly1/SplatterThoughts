extends Control
class_name CanvasPool

#the canvas manager / canvas pool abstracts the operation of choosing which canvas to operate on
#in some sense, it is like an object pool (even though since godot uses reference counting object pooling isn't that much of a performance boost)

@export var canvas_template : PackedScene
@export var all_canvases : Array[PaintingCanvas]

func get_empty_canvas() -> PaintingCanvas:
	for canvas in all_canvases:
		if (!canvas.isCaptured):
			print("empty canvas located: {name}".format({"name": canvas.name}))
			return canvas
	
	return create_new_canvas()

#makes a new canvas node, and adds it to the object pool
func create_new_canvas() -> PaintingCanvas:
	var new_canvas = canvas_template.instantiate()
	add_child(new_canvas)
	all_canvases.append(new_canvas)
	new_canvas.name = "Canvas{index}".format({"index": all_canvases.size()})
	return new_canvas
