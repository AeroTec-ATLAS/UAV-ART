extends RichTextLabel




func _on_Airspeed_AirIni(as_init):
		var dialog = str(as_init*10 + 30) 
		set_visible_characters(4)
		set_bbcode(dialog)
