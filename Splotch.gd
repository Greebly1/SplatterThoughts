extends Control

@export
var time_to_live : float = 4.0
var time_alive : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_alive += delta
	if time_alive >= time_to_live:
		print("destroyed splotch")
		self.queue_free()
