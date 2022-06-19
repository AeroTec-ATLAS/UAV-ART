extends Viewport

var mode = false
var id = 0
var coord_x
var coord_y
var aux_y = 39.204460
var aux_x = -8.059761
#onready var t = $Sprite
func _ready():
	var s = $TextureRect.get_texture().get_size()
	set_size(s)
	#$Sprite.connect()


func _on_TextureRect_mouse_entered():
	mode = true

func _on_TextureRect_modal_closed():
	mode = false
	
func _input(event): 
	if event is InputEventKey and mode:
		if event.is_pressed():
			if event.is_action_pressed("Space_bar"):
				var wp = preload("res://Scenes/Navigation Display/Waypoint.tscn").instance()
				wp.set_name(str(id))
				wp.get_child(2).set_text(str(id))
				#var anc = Vector2(get_mouse_position().x/get_size().x,get_mouse_position().y/get_size().y)
				#wp.set_anchor(MARGIN_LEFT,anc.x)
				#wp.set_anchor(MARGIN_TOP,anc.y)
				#var vector_from_mouse_to_global_position = self.global_position - get_global_mouse_position()
				var pos_x = (MousePos.position_mouse_x) 
				var pos_y = MousePos.position_mouse_y
				var pos = MousePos.position_mouse
				wp.set_position(pos)
				$wp.add_child(wp)
				id +=1
				converter(pos_x,pos_y)

func converter(pos_x,pos_y):
	#print(pos_x," ", pos_y)
	coord_y =  aux_y + 0.00002817110266 * (1872.997437 - pos_y)
	coord_x = aux_x -0.00003561506 * (2286.000977 - pos_x)
	#print("aux_y = ",aux_y)
	#print(pos_y)
	print(coord_y," ",coord_x)
	#coord_x = pos.Position2D.x
