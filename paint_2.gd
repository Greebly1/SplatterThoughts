extends Control

signal paint(position: Vector2)

@export var paintBuffer : SubViewport
@export var flowDistance : float = 20
var brushActive : bool = false
var last_splotch_position : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 150
	paintBuffer.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position : Vector2 = get_global_mouse_position()
	
	if Input.is_action_just_pressed("click"):
		brushActive = true
		paintHere(mouse_position)
	else: 
		if Input.is_action_just_released("click"):
			brushActive = false
			paintHere(mouse_position)
		else:
			if brushActive:
				while (mouse_position - last_splotch_position).length() >= flowDistance:
					paintHere(last_splotch_position + ((mouse_position - last_splotch_position).normalized() * flowDistance))


func paintHere(paint_position: Vector2):
	$SubViewportContainer/SubViewport.placePaint(paint_position)
	last_splotch_position = paint_position
	print("painted")
