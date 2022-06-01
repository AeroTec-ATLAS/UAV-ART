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
var init
var pinit
signal Leitura(array2,pinit)

func _ready():
	load_file(file)

func load_file(file):

	f = File.new()
	f.open(file, File.READ)
	return

func _physics_process(_delta):
	if estado == 1:
		init = int(global.array2[9])
		estado +=1
	if estado == 2:
		estado += 1
		pinit = init / 10
	if not f.eof_reached():
		linha_aux = f.get_line()
		array2 = linha_aux.split(" ", true,0)
		emit_signal("Leitura",array2,pinit)
