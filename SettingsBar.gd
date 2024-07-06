extends ColorRect

@export var sizeEdit : LineEdit

func onBrushSettingsChange():
	LineEdit.text = str(BrushSettings.size)
	pass

func onSizeChanged(new_text : String ):
	if new_text.is_valid_int():
		BrushSettings.size = new_text.to_int() as float /100.0
