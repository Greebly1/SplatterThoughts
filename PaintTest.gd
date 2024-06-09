extends Control

@export
var mainView : TextureRect

@export
var paintBuffer : SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	paintBuffer.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
