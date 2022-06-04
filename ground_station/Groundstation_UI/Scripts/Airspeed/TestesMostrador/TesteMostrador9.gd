extends RichTextLabel

func _ready():
	var dialog = str(45) 
	set_visible_characters(4)
	set_bbcode(dialog)
