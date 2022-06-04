extends Sprite

onready var file = 'res://as.txt'
var f
var graus
var knot
var line = 0

func _ready():
	load_file(file)

func load_file(file):

	f = File.new()
	f.open(file, File.READ)
	return

func _physics_process(_delta):
	if not f.eof_reached():
		line = f.get_line()
		print(line)
		self.rotation_degrees= (float(line) * 39.5 / 5)
