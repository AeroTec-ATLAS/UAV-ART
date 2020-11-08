extends Spatial


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
var connection
var initTime
var ig

func _ready():
	connection = PacketPeerUDP.new()
	connection.listen(14501, '127.0.0.1')
	var packet = ''
	while packet == '':
		packet = connection.get_packet().get_string_from_utf8()
	var jsonData = JSON.parse(packet).result
	initTime = OS.get_ticks_msec()
	#Calibrate center
	var cal = getData(jsonData)
	time_indexes.insert(0,initTime)
	locs.insert(0,Vector3(-cal[7],cal[8],cal[6]))
	$Plane.calibrate(cal)
	
	#Set line
	ig = $line
	
	#Set up scene
	#RAW_LOG_LABEL
	rl = $GUI/rawLog/info
	
	#SET VISIBLE
	$GUI.set_visible(true)
	
	#Set Camera
	cams = [$Plane/P1st,$Plane/P3rd,$GroundCam]
	active = cams[0]
	active.set_current(true)
	cl = $GUI/PopupMenu/CameraButton/CamName
	cl.set_text(active.get_name())
	
func getData(json):
	var localdata = []
	localdata.resize(19)
	localdata[0]=json.theta
	localdata[1]=json.psi
	localdata[2]=json.phi
	localdata[3]=json.q
	localdata[4]=json.r
	localdata[5]=json.p
	localdata[6]=json.pn
	localdata[7]=json.pe
	localdata[8]=json.h
	localdata[9]=json.Vg * cos(json.chi) * cos(json.gamma)
	localdata[10]=json.Vg * sin(json.chi) * cos(json.gamma)
	localdata[11]=-json.Vg * sin(json.gamma)
	localdata[12]=json.Va
	localdata[13]=json.alpha
	localdata[14]=json.beta
	localdata[15]=json.aileron
	localdata[16]=json.elevator
	localdata[17]=json.throttle
	localdata[18]=json.rudder
	return localdata

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
		
# warning-ignore:unused_argument
func _process(delta):
	var packet = ''
	while packet == '':
		packet = connection.get_packet().get_string_from_utf8()
	var jsonData = JSON.parse(packet).result
	var convertedData=getData(jsonData)
	var t = OS.get_ticks_msec() - initTime
	time_indexes.insert(time_indexes.size(),t)
	locs.insert(locs.size(),Vector3(-convertedData[7],convertedData[8],convertedData[6]))
	$Plane.update_data(convertedData)
	$GUI.update_HUD(convertedData)
	draw_line()

func _on_CameraButton_pressed():
	active.set_current(false)
	var i = cams.bsearch(active) + 1
	active = cams[i%len(cams)]
	active.set_current(true)
	cl.set_text(active.get_name())
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

func draw_line():
	ig.clear()
	ig.begin(Mesh.PRIMITIVE_LINE_STRIP)
	for i in locs:
		ig.add_vertex(i)
	ig.end()

