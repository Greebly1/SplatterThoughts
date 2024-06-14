extends TextureRect
class_name PaintLayer

#paint layer abstracts the process of saving a viewport texture and releasing a painting canvas

var layer_index : int = 0
var canvas : PaintingCanvas #the canvas this layer is using
var layer_texture : ImageTexture = null: #this eventually stores the finished canvas texture
	set(value):
		layer_texture = value
		texture = layer_texture
	get:
		return layer_texture
		
#this function saves the canvas' texture and releases it
#it should be called when the canvas has finished its inkblot effect, likely will dynamically connected with a signal
func ReleaseCanvas():
	#first save the canvas' texture to a file
	var img = canvas.get_viewport().get_texture().get_image() #canvases are subviewports, 
	#viewports have viewport textures -> texture2D -> images are the image data
	
	layer_texture = ImageTexture.create_from_image(img)
	
	#release the canvas
	canvas.isCaptured = false #we dont need that ish no mo
	canvas = null

	
