extends RichTextLabel

func _process(delta): 
	var dialog = str(InitialAlt.pinit * 10 + 40) 
	
	set_visible_characters(4)
	set_bbcode(dialog)
	
