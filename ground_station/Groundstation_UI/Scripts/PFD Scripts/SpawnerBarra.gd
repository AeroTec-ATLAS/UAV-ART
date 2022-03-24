extends Node2D


onready var pos_cima = $Cima
onready var pos_baixo = $Baixo


var barra = preload("res://Scenes/Barra.tscn")


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		
		spawn(barra,pos_cima)
		spawn(barra,pos_baixo)


func spawn(spawn_type, spawn_position):
	var new_spawn = spawn_type.instance()
	add_child(new_spawn)
	new_spawn.global_position = spawn_position.global_position
