extends Sprite

onready var file = 'res://abc.txt'
var f
var velocidade 
var ang1 
var ang2
var ang3
var index
var c
var i = 0
var line = 0
#var array = [velocidade , ang1, ang2, ang3]
#var array1 = PoolStringArray([velocidade, ang1,ang2,ang3])
var array2 = PoolRealArray([velocidade,ang1,ang2,ang3])
var linha_aux
signal Leitura
var copia

func _ready():
	load_file(file)

func load_file(file):

	f = File.new()
	f.open(file, File.READ)
	return

func _physics_process(_delta):
	if not f.eof_reached():
		linha_aux = f.get_line()
		#print(linha_aux)
		#emit_signal(linha_aux)
		array2 = linha_aux.split("#", true,0)
#		print(global.num)
		#print(array2[0]) #a leitura está correta
		#copia = array2[0]
		emit_signal("Leitura",array2)#mas não consigo mandar o sinal
		
		
		
		#print(array2[0])
		#onready index = array.find(velocidade,0) # possibilidade pra testar
		#print(array)
		#var filledArray[0]
		#while(array[i] != ' '):
		#	print("continua")
		#	array.back()
		#	#arrayfinal.insert(i,array[i])
		#	
		#	print(array)
		#	i += 1
		
