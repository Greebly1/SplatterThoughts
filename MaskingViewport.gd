extends SubViewport
class_name maskerCanvas

var canvasClearRect : PackedScene = preload("res://canvas_clear.tscn")

#painting canvases are similar to image buffers that we can paint on
var splotchPrefab = preload("res://dieInstantly2.tscn")
var Eraser = preload("res://erasersplotch.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	pass # Replace with function body.

func placePaint(pos : Vector2):
	var instance : Splotch = splotchPrefab.instantiate() as Splotch
	instance.set_position(pos)
	instance.set_size(BrushSettings.size)
	add_child(instance)

func eraseHere(pos: Vector2):
	var instance : Splotch = Eraser.instantiate() as Splotch
	instance.set_position(pos)
	instance.set_size(BrushSettings.size)
	add_child(instance)
	pass

#flashes a color rect to essentially clear the screen
func clearCanvas():
	var canvasClear = canvasClearRect.instantiate()
	add_child(canvasClear)
	
func set_image_size(new_size : Vector2i):
	get_viewport().size = new_size
