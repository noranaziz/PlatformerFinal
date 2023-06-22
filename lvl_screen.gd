extends Node2D

func _ready():
	if !Game.lvl1Cleared:
		get_node("Lvl2").disabled = true
		get_node("Lvl3").disabled = true
	else:
		get_node("Lvl2").disabled = false
	if !Game.lvl2Cleared:
		get_node("Lvl3").disabled = true
	else:
		get_node("Lvl3").disabled = false

func _on_lvl_1_pressed():
	Game.currentLvl = 1
	get_tree().change_scene_to_file("res://lvl1.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://load_game.tscn")

func _on_lvl_2_pressed():
	Game.currentLvl = 2
	get_tree().change_scene_to_file("res://lvl2.tscn")

func _on_lvl_3_pressed():
	Game.currentLvl = 3
	get_tree().change_scene_to_file("res://lvl3.tscn")
