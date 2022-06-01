extends Node2D


#onready var pos_cima = $Cima
#onready var pos_baixo = $Baixo
var contBarraM = 1
var contBarraN = -1
var estado = 1
var estadoNeg = 1
var neg1
var pos1
#var barra = preload("res://Scenes/Barra.tscn")


func _process(_delta):
	#print(Debug.x)
	#print(161.164 * contBarraM)
	#print(17.0 + (49.3597/10.0 * Debug.x))
	#27.0 + (49.3597/10.0 * Debug.x)
	#if (float(Debug.x1) >= (27.0 + (49.3597/10.0 * Debug.x))):
	#print(contBarraM)
	if(estado == 1):
		if (float(Debug.x) >= (160.5 * (contBarraM-1))): #161.164 #por ajuste da alt ini
			#print("criou1")
			var barra = preload("res://Scenes/Barra.tscn")
			var barraC = barra.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC)
			estado = 2
			contBarraM += 1
	elif(estado==2):    #272 é isso #||estado==8
		if (float(Debug.x) >= (136.0 * (contBarraM-1))): #137 #InitialAlt.pinit * 10 + 10 * (SpawnerNum.contM -3)
			#print("criou2")
			#print("criou2")
			#print(contBarraM)
			#if Input.is_action_just_pressed("ui_accept"):
			var barra1 = preload("res://Scenes/Barra2.tscn")
			var barraC1 = barra1.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC1)
			contBarraM += 1
			estado = 3
	elif(estado==3):
		if (float(Debug.x) >= (126.0 * (contBarraM-1))): #113.0
			print("3+")
			var barra2 = preload("res://Scenes/Barra3.tscn")
			var barraC2 = barra2.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC2)
			contBarraM += 1
	
