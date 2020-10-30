extends Spatial

# Declare member variables here. Examples:
var PORT = 10000
var socket = PacketPeerUDP.new()
var stop = false

var cal = Vector3(0,0,0)
var xyz = cal
var b
var trans
# Called when the node enters the scene tree for the first time.

func _ready():
	socket.set_dest_address("127.0.0.1",PORT)
	socket.put_packet("Hi this is godot".to_ascii())
	print("Hi this is godot")
	trans = $Parent.get_transform()
	b = trans.basis
	
func toVector3(a):
	var x = a[0]
	var y = a[1]
	var z = a[2]
	return Vector3(x,y,z)
	
func setLocalRotate(xyz):
	var Ry = Basis(Vector3(0,1,0),-xyz[1])
	var Rz = Ry.rotated(Ry.z,xyz[2])
	var Rx = Rz.rotated(Rz.x,-xyz[0])
	return Transform(Rx,Vector3(0,0,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(socket.get_available_packet_count() > 0) and not stop:
		var data = socket.get_packet().get_string_from_ascii()
		socket.put_packet("0".to_ascii())
		xyz = toVector3(data.split_floats(' ')) - cal
		$Parent.set_transform(setLocalRotate(xyz))
	elif stop:
		socket.put_packet("close".to_ascii())
		socket.close()
		get_tree().quit()
		
func _on_Button_pressed():
	if not stop:
		stop = true
		$Button.set_text("Force Quit")
	else:
		get_tree().quit()

func _on_Button2_pressed():
	cal = xyz
	
