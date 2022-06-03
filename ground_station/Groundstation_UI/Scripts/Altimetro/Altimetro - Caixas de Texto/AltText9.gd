extends RichTextLabel



func _process(delta): 
	var dialog = str(InitialAlt.pinit * 10 + 90) 
	#print(dialog)
	set_visible_characters(5)
	set_bbcode(dialog)
	
