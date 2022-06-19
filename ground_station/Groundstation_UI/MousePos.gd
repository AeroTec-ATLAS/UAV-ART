extends Sprite

var aux1
var aux2
var position_mouse_x
var position_mouse_y
var position_mouse

func _ready():
	position_mouse_x = get_global_mouse_position().x
	position_mouse_y = get_global_mouse_position().y
	position_mouse = get_global_mouse_position()
	
func _process(delta):
	position_mouse_x = get_global_mouse_position().x
	position_mouse_y = get_global_mouse_position().y
	position_mouse = get_global_mouse_position()
