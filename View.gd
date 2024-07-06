extends Control
class_name Canvas_view

@onready var layer_container : Node = $LayerContainer
@export var layerMaterial : ShaderMaterial

var layers : Array[TextureRect] :
	get:
		var layerArr : Array[TextureRect]
		for node : Node in layer_container.get_children():
			if node.get_class() == "TextureRect":
				layerArr.append(node)
		return layerArr


func CreateLayer() -> PaintLayer:
	var newLayer = PaintLayer.new()
	var newLayerName : String = "layer{num}".format({"num": layers.size() + 1})
	layer_container.add_child(newLayer)
	newLayer.name = newLayerName
	newLayer.set_anchors_preset(Control.PRESET_FULL_RECT)
	newLayer.size = self.size #set new layer to full size of viewport
	layerMaterial.set_shader_parameter('Albedo', BrushSettings.color)
	newLayer.material = layerMaterial
	layers.append(newLayer)
	return newLayer
