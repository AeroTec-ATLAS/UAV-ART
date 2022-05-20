extends RichTextLabel

func _ready():
	var dialog = str(45) 
	set_visible_characters(4)
	set_bbcode(dialog)


#func _on_Airspeed_AirIni(as_init):
	#	var dialog = str(AirspeedIni.as_init*10 + 45) 
	#	set_visible_characters(4)
	#	set_bbcode(dialog)
