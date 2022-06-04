extends RichTextLabel


func _on_Sprite_Leitura(array2, pinit, init): #mostra a velocidade atual
	var dialog = array2[13]
	set_visible_characters(4)
	set_bbcode(dialog)

