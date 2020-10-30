extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func update_HUD(data):
	#updates HUD elements
	
	#Pitch and roll
	$HUD/horizon.set_rotation(data[2])

	var pitch_deg = data[0]*180/PI
	if abs(pitch_deg) < 20:
		$HUD/horizon/pitch.set_position(Vector2(0,pitch_deg)*10)
		$HUD/horizon/pitch.set_visible(true)
	else:
		$HUD/horizon/pitch.set_visible(false)
	
	#Altitude and airspeed
	$HUD/horizon/alt/altLabel.set_text("alt(m)\n%07.2f" % data[8])
	$HUD/horizon/speed/speedLabel.set_text("airspeed(m/s)\n%06.2f" % data[12])
	
	#AOA and sideslip
	var angs = Vector2(data[14],data[13])*50
	$HUD/horizon/ang.set_position(angs)
	
	#Course
	var course = -(data[1] - data[14])
	var pos = Vector2((course/PI)*300,0)
	$HUD/compass/indicator.set_position(pos)

func _on_playButton_pressed():
	$Panel.set_visible(true)

func _on_menuButton_pressed():
	$PopupMenu.set_visible(true)

func _on_HUDButton_toggled(button_pressed):
	$HUD.set_visible(button_pressed)

func _on_exitPlay_pressed():
	$Panel.set_visible(false)

func _on_exitMenu_pressed():
	$PopupMenu.set_visible(false)

func _on_closeLog_pressed():
	$rawLog.set_visible(false)

func _on_rawButton_pressed():
	$rawLog.set_visible(true)
