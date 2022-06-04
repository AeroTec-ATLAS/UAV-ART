extends RichTextLabel


func _on_Sprite_Leitura(array2, pinit, init): #exibe o valor a ser mostrado
	var dialog = array2[9]
	set_visible_characters(4)
	set_bbcode(dialog)
