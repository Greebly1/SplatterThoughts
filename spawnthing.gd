extends SubViewport

var splotch = preload("res://dieInstantly.tscn")

var fuckthis

# Called when the node enters the scene tree for the first time.
func _ready():
	fuckthis = splotch.instantiate()
	add_child(fuckthis)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
