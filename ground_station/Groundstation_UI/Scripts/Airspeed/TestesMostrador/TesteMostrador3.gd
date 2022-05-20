extends RichTextLabel



func _ready():
	var dialog = str(15) 
	set_visible_characters(4)
	set_bbcode(dialog)
