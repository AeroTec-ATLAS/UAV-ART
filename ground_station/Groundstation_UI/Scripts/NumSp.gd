extends RichTextLabel


func _ready():
	pass 


func _process(delta):
	
	SpawnerNum.contM = SpawnerNum.contM + 0
	var dialog = str(InitialAlt.pinit * 10 +((SpawnerNum.contM) + 1) * 10) 
	#print(SpawnerNum.contM)
	set_visible_characters(4)
	set_bbcode(dialog)

