extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var cal = Vector3() #home location [lat(deg) lon(deg) alt(m)]

func setLocalRotate(rot,loc):
	var Ry = Basis(Vector3(0,1,0),-rot[1])
	var Rx = Ry.rotated(Ry.x, -rot[0])
	var Rz = Rx.rotated(Rx.z,rot[2])
	var cLoc = get_diference_from_home(loc)
	return Transform(Rz,Vector3(-cLoc[1],cLoc[2],cLoc[0]))

func update_data(data):
	var att = Vector3(data[0],data[1],data[2])
	var loc = Vector3(data[6],data[7],data[8])
	set_transform(setLocalRotate(att,loc))
	$uav/eang/elevator.set_rotation(Vector3(-1,0,0)*data[16])
	$uav/rang/rudder.set_rotation(Vector3(0,0,1)*data[18])
	$uav/alang/aileronL.set_rotation(Vector3(-1,0,0)*data[15])
	$uav/arang/aileronR.set_rotation(Vector3(1,0,0)*data[15])

func calibrate(data):
	cal = Vector3(data[6],data[7],data[8])
	print("home location: " + str(cal))

func get_diference_from_home(coords):
	var R = 6378.137; # Radius of earth in KM
	var dlat = (coords[0] - cal[0])
	var dlon = (coords[1] - cal[1])
	var malt = (coords[2] - cal[2]) 
# warning-ignore:unused_variable
	var mlat = R*sin(dlat * PI/180 )*1000
# warning-ignore:unused_variable
	var mlon = R*sin(dlon * PI/180 )*1000
	#return Vector3(mlat,mlon,malt)
	return Vector3(dlat,dlon,malt)
