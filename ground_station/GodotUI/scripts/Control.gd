extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var client = null

# Called when the node enters the scene tree for the first time.
func _ready():
	client = StreamPeerTCP.new()
	client.connect_to_host("127.0.0.1",420)
	print(client.get_connected_host())
# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
