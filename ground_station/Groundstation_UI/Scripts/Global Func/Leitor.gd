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
var vel_vertical
var p15
var p16
var p17
var p18
var p19
var p20
var array2 = PoolRealArray([p1,ang1,ang2,ang3,p5,p6,p7,p8,p9,altitude,p11,p12,vel_vertical,velocidade,p15,p16,p17,p18,p19,p20])
var linha_aux   #em cima o array2 é usado para armazenar todos os dados dos logs
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

func _physics_process(_delta): #aqui é realizada a leitura do ficheiro dos logs e também é criado o valor da altitude inicial,usado para ajustar a valor da altitude(pinit)
	if not f.eof_reached():
		linha_aux = f.get_line()
		array2 = linha_aux.split(" ", true,0)
		if linha == 2:
			init = int(global.array2[9])
			pinit = init / 10 #pinit é o valor da altitude inicial para configurar as barras
			init = init%10 # retorna o último digito do primeiro valor lido, assim se 
	#o primeiro valor lido for diferente do escrito na barra, possa ser feita a correção
			estado +=1
			estado2 +=1
		linha +=1
		if(estado2==2):
			emit_signal("Leitura",array2,pinit,init)
