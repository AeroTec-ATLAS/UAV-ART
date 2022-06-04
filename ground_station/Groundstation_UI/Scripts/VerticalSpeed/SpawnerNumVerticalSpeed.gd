extends Node2D

#Decide se é para spawnar novos números ou não
#esta função é extremamente semelhante ao script SpawnNewNumber, do altimetro que está melhor comentada

var contM1 = 9
var contN1 = 5

func _process(_delta):

	if (float(global.array2[12]) > ( 2 * (contM1 -4))):
		contM1 += 1

	if (float(global.array2[12]) < (-2 * (contN1-4))): 
		contN1 +=1

func criarPos():
	var caixa3 = preload("res://Scenes/SpawnNumVerticalSpeed.tscn")
	var caixaC3 = caixa3.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC3)

func criarNeg():
	var caixa = preload("res://Scenes/SpawnNumVerticalSpeedNeg.tscn")
	var caixaC = caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaC)
	
func _on_Sprite_Leitura(array2, pinit, init):
	if (float(array2[12]) >= (2 * (contM1 -4))):
		contM1 += 1
		criarPos() 

	if (float(array2[12]) <= (-2 * (contN1-4))):
		contN1 +=1
		criarNeg()
		
