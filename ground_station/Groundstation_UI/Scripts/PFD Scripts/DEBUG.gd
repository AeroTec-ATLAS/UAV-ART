extends Node2D


var x: float = 1000
var x1: float = 0
func _ready():
	while x <= 12000.0:
		var t = Timer.new()
		t.set_wait_time(0.01)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		x -= 0.5
		#print(x)
	while x1 <= 1300.0:
		var t1 = Timer.new()
		t1.set_wait_time(0.01)
		t1.set_one_shot(true)
		self.add_child(t1)
		t1.start()
		yield(t1, "timeout")
		x1 += 0.5
		#print(x1)
