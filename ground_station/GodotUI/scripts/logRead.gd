extends Spatial

var path = "user://voltas_coordenadas.log"

var data
var time_indexes = []
var locs = []
var delta_t
var labels

var l
var rl
var slider
var timer

var active
var cams
var cl

var ig

func logLoad(p):
	path = p

func _ready():
	#Open file
	var file = File.new()
	file.open(path, File.READ)
	
	#Read file
	data = file.get_as_text().split('\n')
	
	#Close file
	file.close()
	
	#Remove labels
	labels = data[0].split(' ')
	data.remove(0)
	data.remove(data.size()-1)
	
	#Calibrate center
	var cal = data[0].split_floats(' ')
	cal.remove(0)
	$Plane.calibrate(cal)
	
	#Set line
	ig = $line
	
	#Process data
	for i in range(data.size()):
		var d = data[i].split_floats(' ')
		var t = d[0]
		time_indexes.insert(i,t)
		locs.insert(i,Vector3(-d[8],d[9],d[7]))
	delta_t = time_indexes[-1] - time_indexes[0]
	
	#End Line
	
	#Set up scene
	#SLIDER
	slider = $GUI/Panel/HSlider
	slider.set_min(0)
	slider.set_max(data.size()-1)
	slider.set_step(1)
	
	#TIME_LABEL
	l = $GUI/Panel/Time
	
	#RAW_LOG_LABEL
	rl = $GUI/rawLog/info
	
	#TIMER
	timer = $GUI/Panel/playing/Timer
	timer.start(delta_t)
	timer.set_paused(true)
	
	#SET VISIBLE
	$GUI.set_visible(true)
	
	#Set Camera
	cams = [$Plane/P1st,$Plane/P3rd,$GroundCam]
	active = cams[0]
	active.set_current(true)
	cl = $GUI/PopupMenu/CameraButton/CamName
	cl.set_text(active.get_name())
	

func _on_HSlider_value_changed(value):
	var line = get_line(int(value))
	disp_log(value)
	l.set_text("time (s): %6.2f" % line[0])
	draw_line(int(value))
	if slider.is_editable():
		timer.start(time_indexes[-1]-line[0])
		line.remove(0)
		$Plane.update_data(line)
		$GUI.update_HUD(line)

func get_time_index(t):
	var max_t = time_indexes[-1]
	var time = max_t-t
	var index = int((time/max_t)*(time_indexes.size()-1))
	var factor
	if time_indexes[index] == max_t:
		factor = 0.0
	else:
		factor = (time - time_indexes[index] )/ (time_indexes[index+1] - time_indexes[index])
	return {"i":index,"f":factor}
	
func _on_playing_toggled(button_pressed):
	slider.set_editable(not button_pressed)
	timer.set_paused(not button_pressed)
		
# warning-ignore:unused_argument
func _process(delta):
	if $GUI/Panel/playing.is_pressed():
		var r = get_time_index(timer.get_time_left())
		var line = interpolate(r)
		slider.set_value(r["i"])
		$Plane.update_data(line)
		$GUI.update_HUD(line)


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$GUI.set_visible(false)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$GUI.set_visible(true)

func _on_Timer_timeout():
	timer.start(delta_t)

func _on_CameraButton_pressed():
	active.set_current(false)
	var i = cams.bsearch(active) + 1
	active = cams[i%len(cams)]
	active.set_current(true)
	cl.set_text(active.get_name())
	var line = get_line(slider.get_value())
	line.remove(0)
	$GUI.update_HUD(line)
	$GUI/PopupMenu/mcam.set_disabled(true)
	if active.get_name() == "P1st":
		$GUI/PopupMenu/HUDButton.set_disabled(false) 
		$GUI/PopupMenu/HUDButton.set_pressed(true)
		$GUI/PopupMenu/drawnline.set_disabled(true) 
	else:
		if active.get_name() == "GroundCam":
			$GUI/PopupMenu/mcam.set_disabled(false)
		$GUI/PopupMenu/HUDButton.set_disabled(true) 
		$GUI/PopupMenu/HUDButton.set_pressed(false)
		$GUI/PopupMenu/drawnline.set_disabled(false) 

func interpolate(r):
	var line1 = get_line(r["i"])
	var line2 = get_line(r["i"]+1)
	var f = r["f"]
	var res = []
	for i in range(line1.size()):
		res.insert(i,(1-f)*line1[i] + f*line2[i])
	res.remove(0)
	return res

func get_line(i):
	var line = data[i].split_floats(' ')
	return line

func disp_log(i):
	var line = get_line(i)
	var t = ""
	for i in range(labels.size()):
		t = t + labels[i] + ": %010f \n" % line[i]
	rl.set_text(t)

func _on_drawnline_toggled(button_pressed):
	ig.set_visible(button_pressed)

func _on_spslider_value_changed(value):
	Engine.set_time_scale(pow(10,value))

func draw_line(index):
	ig.clear()
	ig.begin(Mesh.PRIMITIVE_LINE_STRIP)
	for i in range(index):
		ig.add_vertex(locs[i])
	ig.end()
