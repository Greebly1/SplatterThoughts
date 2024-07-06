extends SubViewport
class_name PaintingCanvas

@onready var inkEffectTimer : Timer = $Timer
@export var inkEffectData : InkEffectData
var canvasClearRect : PackedScene = preload("res://canvas_clear.tscn")

#painting canvases are similar to image buffers that we can paint on
var splotchPrefab = preload("res://dieInstantly.tscn")

#whether or not this canvas is currently painting (or applying an effect)
var isCaptured : bool = false
var layer : PaintLayer = null #the layer this canvas is currently casting to
var inkEffectActive : bool = false
var lastTimeInked : float = 0
var inkAccumulation : float = 0

func _ready():
	pass
	render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	get_viewport().size = DisplayServer.window_get_size()
	#TODO when subviewports are made they must set their size to be within the aspect ratio of the monitor

func placePaint(pos : Vector2):
	var instance : Splotch = splotchPrefab.instantiate() as Splotch
	instance.set_position(pos)
	instance.set_size(BrushSettings.size)
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
	inkEffectTimer.wait_time = inkEffectData.duration
	inkEffectTimer.start()
	inkEffectActive = true
	inkAccumulation = 0
	lastTimeInked = 0

func inkEnded():
	layer.ReleaseCanvas()
	clearCanvas()
	pass

#flashes a color rect to essentially clear the screen
func clearCanvas():
	var canvasClear = canvasClearRect.instantiate()
	add_child(canvasClear)
	pass

func _process(delta):
	if (inkEffectActive):
		#we are doing calculus now
		#we need to know the area under the ink effect curve, the integral
		#however, we only need to know how it accumulated since this frame
		#what we need is the area under the interval between the last frame and this frame (last frame + delta)
		var adjustedDelta : float = delta / inkEffectData.duration
		var thisFrameTime : float = lastTimeInked + adjustedDelta
		var inkLastFrame : float = inkEffectData.strengthCurve.sample(lastTimeInked/inkEffectData.duration)
		var inkThisFrame : float = inkEffectData.strengthCurve.sample(thisFrameTime/inkEffectData.duration)
		var changeAccumulated : float = adjustedDelta * ((inkLastFrame + inkThisFrame)/2) #<-- area under the trapezoidal reimann sum made with this frame's delta time
		inkAccumulation += changeAccumulated
		while inkAccumulation >= inkEffectData.strength:
			inkAccumulation -= inkEffectData.strength
			var newInkEffect = inkEffectData.effect.instantiate()
			add_child(newInkEffect)
		
		lastTimeInked = thisFrameTime
	pass
