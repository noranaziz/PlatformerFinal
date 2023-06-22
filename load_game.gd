extends Node2D

func _ready():
	Utils.loadGame()
	if Game.playerHP == 10 and Game.gold == 0 and Game.stars == 0:
		get_node("Load").disabled = true
	else:
		get_node("Load").disabled = false

func _on_new_pressed():
	Utils.clearGame()
	Utils.loadGame()
	get_node("Load").disabled = false
	get_tree().change_scene_to_file("res://lvl_screen.tscn")

func _on_load_pressed():
	Utils.loadGame()
	get_node("Load").disabled = false
	get_tree().change_scene_to_file("res://lvl_screen.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
