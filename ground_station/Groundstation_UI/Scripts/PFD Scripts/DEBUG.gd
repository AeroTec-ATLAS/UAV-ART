extends Node2D


var a: float = 0.0
func _ready():
	while a <= 1200.0:
		var t = Timer.new()
		t.set_wait_time(0.01)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		#x += 0.5
		#print(x)
