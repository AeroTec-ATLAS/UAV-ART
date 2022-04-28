extends Node2D

#Decide se é para spawnar novos números ou não


var contM = 9
var contN = 4
var array_nodes = [] #array onde vao ser guardados os nodes
var slots = 0

func _ready():
	pass


func _process(delta):
	get_input()
	if (float(global.array2[9]) > (0 + 10 * (contM -3))): #falta trocar o 0 pela altitude inicial
		criar()
		contM += 1
		print(array_nodes)
	
	
	if (float(global.array2[9]) < (0 + -10 * contN)): #falta trocar o 0 pela altitude inicial
		criar()
		contN +=1
		print(array_nodes)
		
	
	
func get_input(): #debugg
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		criar()


func criar():
	array_nodes.append([]) #necessário
	var caixa = load("res://Scenes/SpawnNum.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)
	print("criou")
	array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	slots += 1
	return caixaC



#func _on_Sprite_Leitura(array2):
	#Sempre que a altitude chega a 60, 70, 80 etc cria um novo numero 
	#if (float(array2[9]) > (0 + 10 * (contM -3))): #falta trocar o 0 pela altitude inicial
		#contM +=1
		#print(contM)
		#criar()
		#print(InitialAlt.pinit)
	#if (float(array2[9]) < (0 + -10 * contN)): #falta trocar o 0 pela altitude inicial
		#contN +=1
		#criar()
		#print(contN)
		#print(InitialAlt.pinit)


