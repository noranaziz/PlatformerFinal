extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://load_game.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")

func _on_quit_pressed():
	get_tree().quit()
