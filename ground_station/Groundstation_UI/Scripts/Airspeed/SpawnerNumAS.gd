extends Node2D

#Decide se é para spawnar novos números ou não
#esta função é extremamente semelhante ao script SpawnNewNumber, do altimetro que está melhor comentada

var contM1 = 9
var contN1 = 5


func _process(_delta):
	
	if (float(global.array2[13]) > ( 5 * (contM1 -3))): #5 * (contM1 -3) serve para que o número seja spawnado antes deste ser visto, dando a sensação de ser infinito
		contM1 += 1
	
	if (float(global.array2[13]) < (-5 * (contN1-3))):  
		contN1 +=1
	
func criar(): #cria números positivos
	var caixa3 = preload("res://Scenes/SpawnNumAS.tscn")
	var caixaC3 = caixa3.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC3)
	
func criarNeg(): #cria números negativos
	var caixa = preload("res://Scenes/SpawnNumASNeg.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)
	
func _on_Sprite_Leitura(array2, pinit, init):
	if (float(array2[13]) >= (5 * (contM1 -3))):
		contM1 += 1
		criar() 

	if (float(array2[13]) <= (-5 * (contN1-3))): 
		criarNeg()
		contN1 +=1
