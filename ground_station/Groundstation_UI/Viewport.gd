extends Viewport

var mode = false
var id = 0

func _ready():
	var s = $TextureRect.get_texture().get_size()
	set_size(s)


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
				var pos = MousePos.position #get_mouse_position() 
				
				wp.set_position(pos)
				$wp.add_child(wp)
				print("id = ",id," position = ",pos)
				print("mouse position = ",get_mouse_position())
				id +=1


#func _on_Sprite_frame_changed():
	#pass # Replace with function body.
