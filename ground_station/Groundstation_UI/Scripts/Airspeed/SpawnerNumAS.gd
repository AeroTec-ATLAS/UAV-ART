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
	if (float(Debug.x) > ( 5 * (contM1 -3))): #global.array2[13]
		#print("criou")
		
		#criar()
		contM1 += 1
		
		#print("dps de criar")
		#contM += 1
		#print(contM)
	
	if (float(Debug.x) < (-5 * (contN1-3))): 
		contN1 +=1
	#	criar()
		
		
func criar1():
	#array_nodes.append([]) #necessário
	var caixa3 = preload("res://Scenes/SpawnNumAS.tscn")
	var caixaC3 = caixa3.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC3)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	#slots += 1
	#return caixaC
func _on_Sprite_Leitura(array2):
	#print(Debug.x)
	#print(5 * (contM1 -3))
	if (float(Debug.x) >= (5 * (contM1 -3))): #trocar valor inicial #array2[13]
		#print("aaaaaaa")
		contM1 += 1
		criar1() #array2[9]
		#print("criou")
	
	if (float(Debug.x) <= (-5 * (contN1-3))): #trocar valor inicial
		criar1()
		contN1 +=1
