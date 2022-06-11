extends KinematicBody2D


#export (int) var speed := 250

#func _physics_process(delta:float)->void:
	#var vel := speed * dir() *delta
	#vel = move_and_slide(vel)
	#print(vel)
	
#func dir()-> Vector2:
	#var dir : Vector2
	#dir = (get_global_mouse_position() - global_position).floor()
	#return dir
# Player movement speed

# Player dragging flag
# Player movement speed
export var speed = 750

# Player dragging flag
var drag_enabled = true

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	# Calculate movement
	var movement = speed * direction * delta
	
	# If dragging is enabled, use mouse position to calculate movement
	if drag_enabled:
		var new_position = get_global_mouse_position()
		movement = new_position - position;
		if movement.length() > (speed * delta):
			movement = speed * delta * movement.normalized()
	
	# Apply movement
	move_and_collide(movement)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drag_enabled = event.pressed

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			drag_enabled = false
