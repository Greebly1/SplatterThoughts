extends Control

@export var canvas_manager : CanvasPool
@export var flowDistance : float = 10
@export var layerMaterial : Material
var layers : Array[TextureRect] = []
var last_splotch_position : Vector2 = Vector2(0,0)
var brushActive : bool = false
var currentCanvas : PaintingCanvas = null

func _ready():
	Engine.max_fps = 40
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
		else:
			# if we aren't starting to paint, and we aren't ending a paint
			if brushActive:
				while (mouse_position - last_splotch_position).length() >= flowDistance:
					paint(last_splotch_position + ((mouse_position - last_splotch_position).normalized() * flowDistance))
			else:
				pass

func paint(paint_position: Vector2):
	#each time we paint we need to
	#1 - place a dot on current canvas
	#2 - tell canvas to ink
	#3 - prepare next canvas
	
	currentCanvas.placePaint(paint_position)
	last_splotch_position = paint_position
	
	currentCanvas.beginInk()
	
	preparePainting()

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
	currentCanvas.layer = newLayer
	
	#set the new layer's texture to a viewport of the current canvas
	newLayer.texture = currentCanvas.get_viewport().get_texture()
	newLayer.canvas = currentCanvas
