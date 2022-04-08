extends Node2D

var contM = 9
var contN = 4

func _ready():
	pass


func _process(delta):
	get_input()
	
	
	
func get_input():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		criar()

func criar():
	var caixa = load("res://SpawnNum.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)
	print("criou")
	return caixaC

func _on_Sprite_Leitura(array2):
	if (float(array2[9]) > (0 + 10 * (contM -3))): #falta trocar o 0 pela altitude inicial
		contM +=1
		#print(contM)
		criar()
		#print(InitialAlt.pinit)
	if (float(array2[9]) < (0 + -10 * contN)): #falta trocar o 0 pela altitude inicial
		contN +=1
		criar()
		#print(contN)
		#print(InitialAlt.pinit)


