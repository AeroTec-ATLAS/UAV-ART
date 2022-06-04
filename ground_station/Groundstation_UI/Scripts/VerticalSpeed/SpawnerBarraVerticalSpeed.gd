extends Node2D #ANTIGO SPAWNER DE BARRAS DA VELOCIDADE VERTICAL


#onready var pos_cima = $Cima
#onready var pos_baixo = $Baixo
var contBarraM_AS = 1
var contBarraN_AS = 1
var estado = 1
var estadoNeg = 1
var neg1
var pos1
var x1: float = 0
#var barra = preload("res://Scenes/Barra.tscn")


func _process(_delta):
	#print(Debug.x)
	#print(161.164 * contBarraM)
	#print(17.0 + (49.3597/10.0 * Debug.x))
	#27.0 + (49.3597/10.0 * Debug.x)
	#if (float(Debug.x1) >= (27.0 + (49.3597/10.0 * Debug.x))):
	#print(contBarraM)
	if(estado == 1):
		if (float(global.array2[12]) >= (160.5/2 * (contBarraM_AS-1))): #161.164 #por ajuste da alt ini
			#print("criou1")
			var barra = preload("res://Scenes/Barra_AS.tscn")
			var barraC = barra.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC)
			estado = 2
			contBarraM_AS += 1
		#if (float(Debug.x) <= (170.5 * (contBarraN))): #161.164 #por ajuste da alt ini
		#	print("NEGATIVO1")
		#	var neg1 = 1
		#	var barra = preload("res://Scenes/Barra.tscn")
	#		var barraC = barra.instance()
	#		add_child_below_node(get_tree().get_root().get_node("PFD"), barraC)
	#		neg1 = 0
	#		estado = 8
	#		contBarraN -= 1
	elif(estado==2):    #272 é isso #||estado==8
		if (float(global.array2[12]) >= (136.0/2 * (contBarraM_AS-1))): #137 #InitialAlt.pinit * 10 + 10 * (SpawnerNum.contM -3)
			#print("criou2")
			#print("criou2")
			#print(contBarraM)
			#if Input.is_action_just_pressed("ui_accept"):
			var barra1 = preload("res://Scenes/Barra2_AS.tscn")
			var barraC1 = barra1.instance()
			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC1)
			contBarraM_AS += 1
			#estado = 3
	#elif(estado==3):
	#if(estadoNeg == 1):
	#	if(float(Debug.x) < -65 * contBarraN_AS):
	#		#print("entrou")
			
	#		var barra3 = preload("res://Scenes/Barra_AS.tscn")
	#		var barraC3 = barra3.instance()
	#		add_child_below_node(get_tree().get_root().get_node("PFD"), barraC3)
	#		contBarraN_AS += 1
	#		estadoNeg =2
	#elif(estadoNeg==2): 
		#print(Debug.x)
		#print(-85*(contBarraN_AS))
	#	if(float(Debug.x) < (-1 -85*(contBarraN_AS))):
			#print("entrou2")
	#		var barra3 = preload("res://Scenes/Barra_AS.tscn")
	#		var barraC3 = barra3.instance()
	#		add_child_below_node(get_tree().get_root().get_node("PFD"), barraC3)
	#		contBarraN_AS += 1
		#if (float(Debug.x) >= (126.0/2 * (contBarraM_AS))): #113.0
		#	print("3+")
		#	var barra2 = preload("res://Scenes/Barra3.tscn")
		#	var barraC2 = barra2.instance()
		#	add_child_below_node(get_tree().get_root().get_node("PFD"), barraC2)
		#	contBarraM_AS += 1
		#	if(estado ==3):
		#		if (float(Debug.x) >= (137 * (contBarraM-1))):
		#			var barra2 = preload("res://Scenes/Barra2.tscn")
		#			var barraC2 = barra1.instance()
		#			add_child_below_node(get_tree().get_root().get_node("PFD"), barraC2)
		#			contBarraM += 1
	#else:
		#if (float(Debug.x) >= ( 137 * (contBarraM-1))): #137
		#	estado = 4
			#print("criou3")
			#print("criou2")
			#print(contBarraM)
			#if Input.is_action_just_pressed("ui_accept"):
		#	var barra2 = preload("res://Scenes/Barra3.tscn")
			#var barraC2 = barra2.instance()
			#add_child_below_node(get_tree().get_root().get_node("PFD"), barraC2)
			#contBarraM += 1
#func spawn(spawn_type, spawn_position):
	#var new_spawn = spawn_type.instance()
	#add_child(new_spawn)
	#new_spawn.global_position = spawn_position.global_position


func _on_Sprite_Leitura():
	pass # Replace with function body.
