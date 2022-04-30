extends Node2D

#Decide se é para spawnar novos números ou não


var contM = 9
var contN = 5
var array_nodes = [] #array onde vao ser guardados os nodes
var slots = 0

func _ready():
	pass


func _process(delta):
	get_input()
	if (float(global.array2[9]) > (InitialAlt.pinit + 10 * (contM -3))): 
		criar()
		contM += 1
	
	if (float(global.array2[9]) < (InitialAlt.pinit + -10 * (contN-3))): 
		criar()
		contN +=1
		
func get_input(): #debugg
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		#criar()
		pass


func criar():
	#array_nodes.append([]) #necessário
	var caixa = load("res://Scenes/SpawnNum.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	#slots += 1
	#return caixaC
