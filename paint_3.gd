extends Control

@export var canvas_manager : CanvasManager
@export var flowDistance : float = 20
@export var layerMaterial : Material
var layers : Array[TextureRect] = []
var last_splotch_position : Vector2 = Vector2(0,0)
var brushActive : bool = false
var currentCanvas : PaintingCanvas = null

func _ready():
	preparePainting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position : Vector2 = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		brushActive = true # painting begins this frame
		paint(mouse_position)
	else: 
		# did painting end this frame?
		if Input.is_action_just_released("click"):
			brushActive = false # painting ended this frame
			#TODO before preparing the next layer, tell the canvas that the paint stroke is over
			preparePainting() #prepare the painting for the next paint stroke
		else:
			# if we aren't starting to paint, and we aren't ending a paint
			if brushActive:
				while (mouse_position - last_splotch_position).length() >= flowDistance:
					paint(last_splotch_position + ((mouse_position - last_splotch_position).normalized() * flowDistance))
			else:
				pass

func paint(paint_position: Vector2):
	currentCanvas.placePaint(paint_position)
	last_splotch_position = paint_position

func preparePainting():
	#make a new layer
	var newLayer = PaintLayer.new()
	var newLayerName : String = "layer{num}".format({"num": layers.size() + 1})
	newLayer.name = newLayerName
	$LayerContainer.add_child(newLayer)
	newLayer.set_anchors_preset(Control.PRESET_FULL_RECT)
	newLayer.size = $LayerContainer.size #set new layer to full size of screen
	newLayer.material = layerMaterial
	layers.append(newLayer)
	
	#get a painting canvas handle
	currentCanvas = canvas_manager.get_empty_canvas()
	currentCanvas.isCaptured = true
	
	#set the new layer's texture to a viewport of the current canvas
	newLayer.texture = currentCanvas.get_viewport().get_texture()
	newLayer.canvas = currentCanvas
