extends SubViewport

var splotchPrefab = preload("res://splotch.tscn")

func placePaint(pos : Vector2):
	var instance = splotchPrefab.instantiate()
	instance.position = pos
	add_child(instance)
