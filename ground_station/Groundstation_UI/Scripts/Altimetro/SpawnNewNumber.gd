extends Node2D

#Decide se é para spawnar novos números ou não
#quando um número é dito positivo este é positivo em relação ao zero do referencial(altitude inicial)
#o mesmo vale para os números negativos

var contM = 9 #número de números que começam spawnadas para cima
var contN = 5 #número de números que começam spawnadas para baixo

var aux #variaveis para auxiliar com a posição/número de spawns, etc
var aux2
var aux3

func _process(_delta): #é preciso de dois ciclos que aumentam as variaveis que contam os números spawnados,
#pois na cena do spawner, não é possível pegar o valor de uma variável dentro de um ciclo
#que envolva um signal(função _on_Sprite_Leitura)
#e utilizar o spawn por variáveis globais causa um imenso lag.
	
	if (float(global.array2[9]) > (global.pinit * 10 + 10 * (contM -4))):
		contM += 1
	
	if (float(global.array2[9]) < (global.pinit * 10 + -10 * (contN-4))): 
		contN +=1

func criarPos(): #cria os números positivos,
#pois se uma função faz os dois impossibilita o programa de funcionar para 
#variações positivas e negativas dos parâmetros
	
	var Caixa = preload("res://Scenes/SpawnNum.tscn")
	var caixaCC = Caixa.instance()
	add_child_below_node(get_tree().get_root().get_node("PFD"), caixaCC)
	
func criarNeg(): #cria os números negativos
	var Caixa1 = preload("res://Scenes/SpawnNumNeg.tscn")
	var caixaCC1 = Caixa1.instance()
	aux3 = add_child_below_node(get_tree().get_root().get_node("PFD"), caixaCC1)


func _on_Sprite_Leitura(array2, pinit, init): #conforme dito acima são necessários dois ciclos que fazem o mesmo, mas apenas este faz o spawn
	if (float(array2[9]) >= (pinit * 10 + 10 * (contM -4))): #array2[9]
		contM += 1
		criarPos()
		
	if (float(array2[9]) <= (pinit * 10 + -10 * (contN -4))): 
		contN +=1
		criarNeg()

