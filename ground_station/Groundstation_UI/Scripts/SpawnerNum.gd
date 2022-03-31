extends Node2D

var contM = 9


func _ready():
	pass # Replace with function body.


func _process(delta):
	get_input()
	
	
	
func get_input():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		criar()

func criar():
	var caixa = load("res://SpawnNum.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)


func _on_Sprite_Leitura(array2):
	if (float(array2[9]) >  90):
		contM +=1
		criar()
