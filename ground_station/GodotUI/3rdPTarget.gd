extends Position3D

# warning-ignore:unused_argument
func _process(delta):
	var t = get_parent().get_translation()
	t.y += 2
	look_at(t,Vector3(0,1,0))
