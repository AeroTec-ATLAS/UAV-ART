extends Sprite

onready var file = 'res://data_log.txt'
var f
var velocidade 
var ang1 #pitch
var ang2 #yaw
var ang3 #roll
var p1
var p5
var p6
var p7
var p8
var p9
var altitude
var p11
var p12
var p13
var p15
var p16
var p17
var p18
var p19
var p20
var array2 = PoolRealArray([p1,ang1,ang2,ang3,p5,p6,p7,p8,p9,altitude,p11,p12,p13,velocidade,p15,p16,p17,p18,p19,p20])
var linha_aux
var estado = 1
var estado2 = 1
var init
var pinit
var pinit2
var init2
var linha = 1
signal Leitura(array2,pinit,init)

func _ready():
	load_file(file)

func load_file(file):

	f = File.new()
	f.open(file, File.READ)
	return

func _physics_process(_delta):
	#if estado == 1:
	#	init = int(global.array2[9])
	#	pinit = init / 10
	#	#print(pinit)
	#	estado +=1
	#if estado ==2:
	#	init2 = int(global.array2[9])
	#	pinit2 = init2 / 10
	#	print(pinit2)
	#	estado +=1
	if not f.eof_reached():
		linha_aux = f.get_line()
		array2 = linha_aux.split(" ", true,0)
		if linha == 2:
			init = int(Debug.x)#global.array2[9]
			#print(init/10)
			pinit = init / 10
			#if(init%100 < 1000):
			init = init%10 # retorna o último digito do primeiro valor lido, assim se 
	#o primeiro valor lido for diferente do escrito na barra, possa ser feita a correção
			#print(init%10)
			#print(pinit)
			estado +=1
			estado2 +=1
		linha +=1
		if(estado2==2):
			emit_signal("Leitura",array2,pinit,init)
