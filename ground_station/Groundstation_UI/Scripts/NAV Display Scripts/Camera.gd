extends Camera2D

class_name ZoomingCamera2D

var zoom_min = Vector2(0.1,0.1) #0.5
var zoom_max = Vector2(2.4,2.4)
var zoom_speed = Vector2(.1,.1)
var des_zoom = zoom
var mouse_start_pos
var screen_start_position
var dragging = false

func _process(delta):
	zoom = lerp(zoom,des_zoom,.2)
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			
			if event.button_index == BUTTON_WHEEL_UP:
				if des_zoom > zoom_min:
					des_zoom -= zoom_speed
			if event.button_index == BUTTON_WHEEL_DOWN:
				if des_zoom < zoom_max:
					des_zoom +=zoom_speed
			
			
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = zoom * (mouse_start_pos - event.position) + screen_start_position
