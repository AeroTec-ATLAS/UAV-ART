extends RichTextLabel

func _on_Sprite_Leitura(array2, pinit, init): #exibe a velocidade vertical a ser exibida
	var dialog = array2[12]
	set_visible_characters(4)
	set_bbcode(dialog)
