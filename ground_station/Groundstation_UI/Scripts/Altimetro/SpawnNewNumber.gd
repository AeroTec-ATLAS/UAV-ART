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
	if (float(Debug.x) > (InitialAlt.pinit * 10 + 10 * (contM -7))): #(global.array2[9])
		#print("criou")
		#criar()
		contM += 1
		
		#print("dps de criar")
		#contM += 1
		#print(contM)
	
	if (float(Debug.x) < (InitialAlt.pinit * 10 + -10 * (contN-7))): 
		#print("bbbbb")
		contN +=1
	#	criar()
		
		
func criarPos():
	#array_nodes.append([]) #necessário
	var Caixa = preload("res://Scenes/SpawnNum.tscn")
	var caixaCC = Caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaCC)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
	#slots += 1
	#return caixaC
func criarNeg():
	#array_nodes.append([]) #necessário
	var Caixa1 = preload("res://Scenes/SpawnNumNeg.tscn")
	var caixaCC1 = Caixa1.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaCC1)
	#array_nodes[slots].append(caixaC) #guarda os nodes criados num array
func _on_Sprite_Leitura(array2,pinit):
	#print(pinit * 10 + -10 * (contN - 3))
	if (float(Debug.x) >= (pinit * 10 + 10 * (contM -7))): #trocar valor inicial #array2[9]
		
		contM += 1
		criarPos()
		
	
	if (float(Debug.x) <= (pinit * 10 + -10 * (contN - 7))): #trocar valor inicial
		print("aaaaaaa")
		contN +=1
		criarNeg()
		



