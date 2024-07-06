extends Control
class_name Painter



@export var canvas_manager : CanvasManager
@export var flowDistance : float = 3
@export var layerMaterial : ShaderMaterial
@export var brush_noise : Noise #used for changing brush settings from the cpu using the brush position
@export var Canvas_Viewport : Canvas_view
var paint_count : int = 0
var last_splotch_position : Vector2 = Vector2(0,0)
var brushActive : bool = false
var currentCanvas : PaintingCanvas = null

const ASPECT_RATIO : Vector2i = Vector2i(3, 2)
const RESOLUTION : int = 200
@onready var canvas_size : Vector2i = ASPECT_RATIO * RESOLUTION

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_manager.set_canvas_size(canvas_size)
	preparePainting()
	
func updateViewportSize(MaxViewportBounds : Vector2i):
	pass

func _process(delta):
	if brushActive:
		var mouse_position : Vector2 = Canvas_Viewport.get_local_mouse_position()
	
		if Input.is_action_just_released("click"):
			brushActive = false # painting ended this frame
			currentCanvas.beginInk()
			#TODO before preparing the next layer, tell the canvas that the paint stroke is over
			preparePainting() #prepare the painting for the next paint stroke
		else:
			while (mouse_position - last_splotch_position).length() >= flowDistance:
				paintSplotchAtPosition(last_splotch_position + ((mouse_position - last_splotch_position).normalized() * flowDistance))
				
	pass

func onBeginPaint():
	paintSplotchAtCursor()
	brushActive = true;

func preparePainting():
	#make a new layer
	var newLayer = Canvas_Viewport.CreateLayer()
	
	#get a handle to an empty canvas
	currentCanvas = canvas_manager.get_empty_canvas()
	currentCanvas.isCaptured = true
	currentCanvas.layer = newLayer
	
	#set the new layer's texture to a viewport of the current canvas
	newLayer.texture = currentCanvas.get_viewport().get_texture()

#assumes the mouse global position is inside the viewport rect
func paintSplotchAtCursor():
	paintSplotchAtPosition(Canvas_Viewport.get_local_mouse_position())

func paintSplotchAtPosition(position : Vector2):
	var ViewportSize = Canvas_Viewport.get_rect().size
	var ViewportAspectRatio = ViewportSize.x/ViewportSize.y
	var CanvasSize = currentCanvas.size
	var CanvasAspectRatio : float = CanvasSize.x as float/CanvasSize.y as float
	
	var normalizePosition = position/ViewportSize
	var positionOnCanvas = normalizePosition * (CanvasSize as Vector2)
	
	currentCanvas.placePaint(positionOnCanvas)
	paint_count = paint_count + 1
	last_splotch_position = position
	
	#print("pos ", position, " | NP ", normalizePosition, "| AP ", positionOnCanvas, " | VPS ", ViewportSize, " | VPAR ", ViewportAspectRatio, " | CS ", CanvasSize, " | CSAR ", CanvasAspectRatio)
	
