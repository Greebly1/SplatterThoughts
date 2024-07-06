extends Control
class_name GameInstance

signal beginPaint()

@export var painter : Painter

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 15
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if painter.Canvas_Viewport.get_global_rect().has_point(get_global_mouse_position()):
			emit_signal("beginPaint")
		pass
	pass

func onWindowResize():
	pass
