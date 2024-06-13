extends SubViewport
class_name PaintingCanvas

@onready var inkEffectTimer : Timer = $Timer

#painting canvases are similar to image buffers that we can paint on
var splotchPrefab = preload("res://dieInstantly.tscn")

#whether or not this canvas is currently painting (or applying an effect)
var isCaptured : bool = false
var layer : PaintLayer = null #the layer this canvas is currently casting to

func _ready():
	pass
	render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	get_viewport().size = DisplayServer.window_get_size()
	#TODO when subviewports are made they must set their size to be within the aspect ratio of the monitor

func placePaint(pos : Vector2):
	var instance = splotchPrefab.instantiate()
	instance.position = pos
	add_child(instance)
	
func releaseLayer():
	if (isCaptured && layer != null) :
		var img = get_viewport().get_texture().get_image()
		img.flip_y()
		layer.layer_texture = ImageTexture.create_from_image(img)

#unlinks the layer, and clears the render texture
#call this to make a canvas stop doing work and re enter the available canvas pool
func reset():
	layer.ReleaseCanvas()
	layer = null
	pass
	
func beginInk():
	inkEffectTimer.start()

func inkEnded():
	layer.ReleaseCanvas()
	pass
