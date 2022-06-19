extends Sprite

var aux1
var aux2
var position_mouse

func _ready():
	position_mouse = get_global_mouse_position()
	
func _process(delta):
	position_mouse = get_global_mouse_position()
	print(position_mouse)
