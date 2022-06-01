extends Node2D

#Decide se é para spawnar novos números ou não


var contM = 9
var contN = 5
var array_nodes = [] #array onde vao ser guardados os nodes
var slots = 0
var aux
var aux2
#var aux = 9
func _ready():
	#if (float(global.array2[9]) >= (int(InitialAlt.pinit) * 10 + 10 * (contM -3))):
	#	contM +=1
	#aux = contM
	connect("AltIni",self,"_on_Alt_Ini")
	pass
func _process(_delta):
	#aux = _on_Sprite_Leitura(delta)
	#print(InitialAlt.pinit * 10 + 10 * (contM -3))
	if (float(global.array2[9]) > (InitialAlt.pinit * 10 + 10 * (contM -3))): #(global.array2[9])
		#print("criou")
		aux2 = InitialAlt.pinit
		#criar()
		contM += 1
		
		#print("dps de criar")
		#contM += 1
		#print(contM)
	
	if (float(global.array2[9]) < (InitialAlt.pinit * 10 + -10 * (contN-3))): 
		contN +=1
	#	criar()
		
		
func criar():
	#array_nodes.append([]) #necessário
	var Caixa = preload("res://Scenes/SpawnNum.tscn")
	var caixaCC = Caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaCC)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	#slots += 1
	#return caixaC
func _on_Sprite_Leitura(array2,pinit):
	if (float(array2[9]) >= (pinit * 10 + 10 * (contM -3))): #trocar valor inicial #array2[9]
		#print(pinit)
		contM += 1
		criar()
		
	
	if (float(array2[9]) <= (pinit * 10 + -10 * (contN - 3))): #trocar valor inicial
		contN +=1
		criar()
		



