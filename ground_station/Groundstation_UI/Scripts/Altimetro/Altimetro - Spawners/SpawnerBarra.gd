"""extends Node2D

#SCRIPT DO SPAWN DAS BARRAS PRO ALTIMETRO
#onready var pos_cima = $Cima
#onready var pos_baixo = $Baixo
var contBarraM = 1
var contBarraN = -1
var estado = 1
var estadoNeg = 1
var neg1
var pos1



func _process(_delta):
	if(estado == 1):
		if (float(Debug.x) >= (160.5 * (contBarraM-1))): 
			print("criou1")
			var barra = preload("res://Scenes/Barra.tscn")
			var barraC = barra.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC)
			estado = 2
			contBarraM += 1
	elif(estado==2):    
		if (float(Debug.x) >= (136.0 * (contBarraM-1))):
			var barra1 = preload("res://Scenes/Barra2.tscn")
			var barraC1 = barra1.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC1)
			contBarraM += 1
			estado = 3
	elif(estado==3):
		if (float(Debug.x) >= (126.0 * (contBarraM-1))): 
			print("3+")
			var barra2 = preload("res://Scenes/Barra3.tscn")
			var barraC2 = barra2.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC2)
			contBarraM += 1
"""
