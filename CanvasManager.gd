extends Control
class_name CanvasManager

#the canvas manager abstracts the operation of choosing which canvas to operate on
#in some sense, it is like an object pool

@export var all_canvases : Array[PaintingCanvas]

func get_empty_canvas():
	for canvas in all_canvases:
		if (!canvas.isCaptured):
			print("empty canvas located: {name}".format({"name": canvas.name}))
			return canvas
	
	return null #there are no canvases that can be used right now
	#TODO create a new canvas if we are out, similar to a dynamic object pool

func set_canvas_size(new_size : Vector2i):
	for canvas : PaintingCanvas in all_canvases:
		canvas.set_image_size(new_size)
