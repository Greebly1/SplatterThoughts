extends TextureRect
class_name PaintLayer

#paint layer abstracts the process of saving a viewport texture and releasing a painting canvas

var layer_index : int = 0
var layer_texture : ImageTexture = null: #this eventually stores the finished canvas texture
	set(value):
		layer_texture = value
		texture = layer_texture
	get:
		return layer_texture
		

	
