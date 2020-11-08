extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_log_pressed():
	$log.set_disabled(true)
	$FileDialog.popup()
	
func _on_realtime_pressed():
	var lv = load("res://Control.tscn").instance()
	get_parent().add_child(lv)
	queue_free()

func _on_FileDialog_file_selected(path):
	var lv = load("res://logRead.tscn").instance()
	lv.logLoad(path)
	get_parent().add_child(lv)
	queue_free()


func _on_FileDialog_popup_hide():
	$log.set_disabled(false)
