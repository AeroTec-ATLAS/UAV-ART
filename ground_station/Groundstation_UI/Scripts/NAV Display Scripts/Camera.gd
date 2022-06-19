extends Camera2D

class_name ZoomingCamera2D
export var min_zoom := 0.5
export var max_zoom := 4.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
export var zoom_factor := 0.1
# Duration of the zoom's tween animation.
export var zoom_duration := 0.2

# The camera's target zoom level.
#var _zoom_level := 1.0 setget _set_zoom_level
var zoom_min = Vector2(0.5,0.5)
var zoom_max = Vector2(2.2,2.2)
var zoom_speed = Vector2(.1,.1)
var des_zoom = zoom
# We store a reference to the scene's tween node.
onready var tween: Tween = $Tween
var mouse_start_pos
var screen_start_position
var dragging = false
var zoom_step = 1.1
"""func _set_zoom_level(value: float) -> void:
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		tween.EASE_OUT
	)
	tween.start()
	
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		_set_zoom_level(_zoom_level - zoom_factor)
	if event.is_action_pressed("zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor) """
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
