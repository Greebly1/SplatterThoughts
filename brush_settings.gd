extends Node

#notify the UI when something changes
#since this is a globally accessible singleton
#just use a single signal for simplicity, when a script needs a value
#in response to this event such as color, just call BrushSettings.color
signal brush_settings_changed

var size : float = 0.2:
	set(new_size):
		size = new_size
		emit_signal('brush_settings_changed')
var color : Color = Color.REBECCA_PURPLE:
	set(new_color):
		color = new_color
		emit_signal('brush_settings_changed')
var mask : Texture2D;

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func fuck():
	pass
