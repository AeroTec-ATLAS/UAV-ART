extends Camera

var p
var m
var sens

func _ready():
	p = get_parent().get_child(0)
	m = false
	sens = 0.003

# warning-ignore:unused_argument
func _process(delta):
	sens = 0.003*(get_fov())/55
	if not m:
		look_at(p.get_translation(),Vector3(0,1,0))
		correct_fov(p.get_translation())

func correct_fov(loc):
	var dist = get_translation().distance_to(loc)
	var nfov = 100 - log(dist)*15
	if nfov > 5: 
		set_fov(nfov)
	else:
		set_fov(5)


func _on_mcam_toggled(button_pressed):
	m = button_pressed

var mouse_buttons = [0, 0, 0]
var mouse_pos_temp = Vector2()

func _input(event):
	mouse_buttons[2] = 0
	if event is InputEventMouseButton and m:
		if event.is_pressed():
			if event.get_button_index() == 2:
				mouse_buttons[1] = 1
				mouse_pos_temp = get_viewport().get_mouse_position()
			if event.get_button_index() == BUTTON_WHEEL_UP:
				mouse_buttons[2] = 1
			if event.get_button_index() == BUTTON_WHEEL_DOWN:
				mouse_buttons[2] = 2
		else:
			mouse_buttons[1] = 0
 
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED or mouse_buttons[1] == 1) and m:
		var mouse_delta = Vector2(mouse_pos_temp[0]-get_viewport().get_mouse_position()[0],
		mouse_pos_temp[1]-get_viewport().get_mouse_position()[1])
	   
		# Rotations: currently active target horizontal
		var target_rot = get_rotation()
		target_rot.y += sens*mouse_delta.x
		set_rotation(target_rot)
	   
		# Rotations: vertical camera_pivot rotation
		var pivot_rot = get_rotation()
		pivot_rot.x += sens*mouse_delta.y
	   
		if pivot_rot.x > 1.4:
			pivot_rot.x = 1.4
		elif pivot_rot.x < -1.4:
			pivot_rot.x = -1.4
		set_rotation(pivot_rot)
	   
		get_viewport().warp_mouse(mouse_pos_temp)
		
	if m:
		var nfov
		if mouse_buttons[2] == 2:
			nfov = get_fov() + 1
			if nfov < 60:
				set_fov(nfov)
		elif mouse_buttons[2] == 1:
			nfov = get_fov() - 1
			if nfov > 1:
				set_fov(nfov)
