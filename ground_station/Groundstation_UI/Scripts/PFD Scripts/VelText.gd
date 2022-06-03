extends RichTextLabel


func _ready():
	pass # Replace with function body.


func _on_Sprite_Leitura(array2,pinit):
	var dialog = array2[9]
	set_visible_characters(4)
	set_bbcode(dialog)
	#print(Debug.x)
	
