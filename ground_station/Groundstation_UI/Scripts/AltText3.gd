extends RichTextLabel

func _on_Altitude_AltIni(pinit): 
	var dialog = str(pinit * 10 + 30) 
	set_visible_characters(4)
	set_bbcode(dialog)
	
