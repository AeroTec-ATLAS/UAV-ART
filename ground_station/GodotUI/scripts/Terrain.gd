extends Spatial

const chunk_size = 256
const chunk_amount = 45

var chunks = {}
var unready_chunks = {}
var thread

func _ready():
	thread = Thread.new()

func add_chunk(x,z):
	var key = str(x)+","+str(z)
	if chunks.has(key) or unready_chunks.has(key):
		return
	if not thread.is_active():
		#print("start thread")
		thread.start(self, "load_chunk", [thread,x,z])
		unready_chunks[key] = 1

func load_chunk(arr):
	#print("chunks loading")
	var thread = arr[0]
	var x = arr[1]
	var z = arr[2]
	
	var chunk = Chunk.new(x*chunk_size,z*chunk_size,chunk_size)
	chunk.translation = Vector3(x*chunk_size,0,z*chunk_size)
	
	call_deferred("load_done",chunk,thread)
	
func load_done(chunk, thread):
	#print("chunk loaded")
	add_child(chunk)
	var key = str(chunk.x/chunk_size)+","+str(chunk.z/chunk_size)
	chunks[key] = chunk
	unready_chunks.erase(key)
	thread.wait_to_finish()

func get_chunk(x,z):
	var key = str(x)+","+str(z)
	if chunks.has(key):
		return chunks.get(key)
	return null

# warning-ignore:unused_argument
func _process(delta):
	update_chunks()
	clean_up_chunks()
	reset_chunks()

func update_chunks():
	# ASSURE PLANE IS FIRST CHILD IN PARENT SCENE
	var player = get_parent().get_child(0)
	var player_translation = player.translation
	var p_x = int(player_translation.x)/chunk_size
	var p_z = int(player_translation.z)/chunk_size

	for x in range(p_x-chunk_amount*0.5,p_x+chunk_amount*0.5):
		for z in range(p_z-chunk_amount*0.5,p_z+chunk_amount*0.5):
			add_chunk(x,z)
			var chunk = get_chunk(x,z)
			if chunk != null:
				chunk.should_remove = false

func clean_up_chunks():
	for key in chunks:
		var chunk = chunks[key]
		if chunk.should_remove:
			chunk.queue_free()
			chunks.erase(key)
			
func reset_chunks():
	for key in chunks:
		chunks[key].should_remove = true
	
