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
				var pos = get_mouse_position()
				wp.set_position(pos)
				$wp.add_child(wp)
				id +=1
