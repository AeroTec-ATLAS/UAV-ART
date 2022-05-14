extends Node2D

#Decide se é para spawnar novos números ou não


var contM1 = 9
var contN1 = 5
var array_nodes = [] #array onde vao ser guardados os nodes
var slots = 0
#var aux = 9
func _ready():
	#if (float(global.array2[9]) >= (int(InitialAlt.pinit) * 10 + 10 * (contM -3))):
	#	contM +=1
	#aux = contM
	pass

#global.array2[9]
func _process(delta):
	#print(Debug.x)
	#aux = _on_Sprite_Leitura(delta)
	#print(aux)
	if (float(global.array2[13]) > (InitialAlt.pinit * 10 + 10 * (contM1 -3))): 
		#print("criou")
		
		#criar()
		contM1 += 1
		
		#print("dps de criar")
		#contM += 1
		#print(contM)
	
	if (float(global.array2[13]) < (InitialAlt.pinit * 10 + -10 * (contN1-3))): 
		contN1 +=1
	#	criar()
		
		
func criar1():
	#array_nodes.append([]) #necessário
	var caixa1 = preload("res://Scenes/SpawnNumAS.tscn")
	var caixaC1 = caixa1.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC1)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	#slots += 1
	#return caixaC
func _on_Sprite_Leitura(array2):
	#print(Debug.x)
	#print(array2[13])
	#print(0 * 10 + 10 * (contM -3))
	if (float(array2[13]) > (0 * 10 + 10 * (contM1 -3))): #trocar valor inicial
		print("aaaaaaa")
		contM1 += 1
		criar1() #array2[9]
		print("criou")
	
	if (float(array2[13]) < (0 * 10 + -10 * (contN1-3))): #trocar valor inicial
		criar1()
		contN1 +=1
