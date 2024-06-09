extends Control

@export
var mainView : TextureRect

@export
var paintBuffer : SubViewport

var imgCounter = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	paintBuffer.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# await(RenderingServer.frame_post_draw)
	
	var img = paintBuffer.get_viewport().get_texture().get_image()
	img.flip_y()
	img.save_png("res://precomputeImgs/img%d.png" % imgCounter)
	imgCounter = imgCounter + 1
	pass
