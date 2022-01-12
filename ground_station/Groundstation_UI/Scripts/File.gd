extends Node2D

onready var file = 'res://as.txt'

signal Texto(line)

func _ready():
	load_file(file)

func load_file(file):

	var f = File.new()
	f.open(file, File.READ)
	var index = 1
	while not f.eof_reached(): 
		var line = f.get_line()
		#line += " "
		print(line) #+ str(index))
		emit_signal("Texto", line)
		#self.rotation_degrees = (int(float(line)))
		print("passou")
		#index += 1
	f.close()
	return
