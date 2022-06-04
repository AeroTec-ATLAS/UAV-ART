extends RichTextLabel

func _on_Sprite_Leitura(array2, pinit, init): #pega a altitude inicial, soma-o com um valor e exibe na caixa de texto 
	var dialog = str(pinit * 10 + 90) 
	set_visible_characters(4)
	set_bbcode(dialog)
