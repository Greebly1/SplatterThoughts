extends Control
class_name GameInstance

signal beginPaint()

@export var painter : Painter

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 45
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if painter.Canvas_Viewport.get_global_rect().has_point(get_global_mouse_position()):
			emit_signal("beginPaint")
	if Input.is_action_just_pressed("toggletool"):
		painter.useMaskingCanvas = not painter.useMaskingCanvas
	if Input.is_action_just_pressed("erase"):
		painter.eraseActive = true 
	if Input.is_action_just_released("erase"):
		painter.eraseActive = false
	pass

func onWindowResize():
	pass
