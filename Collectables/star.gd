extends Area2D

@onready var star = get_node("AnimatedSprite2D")

func _ready():
	star.play("Idle")

func _on_body_entered(body):
	if body.name == "Player":
		var tween = get_tree().create_tween()
		if Game.lvl1Cleared and Game.currentLvl == 1:
			modulate.a = 0.5
		elif Game.lvl2Cleared and Game.currentLvl == 2:
			modulate.a = 0.5
		elif Game.lvl3Cleared and Game.currentLvl == 3:
			modulate.a = 0.5
		if modulate.a != 0.5:
			Game.stars += 1
		if Game.currentLvl == 1:
			Game.lvl1Cleared = true
		elif Game.currentLvl == 2:
			Game.lvl2Cleared = true
		elif Game.currentLvl == 3:
			Game.lvl3Cleared = true
		tween.tween_property(self, "position", position - Vector2(0, 15), 0.2)
		tween.tween_property(self, "modulate:a", 0, 0.2)
		await get_tree().create_timer(1).timeout
		#tween.tween_callback(queue_free)
		print(Game.stars)
		get_tree().change_scene_to_file("res://lvl_screen.tscn")
		Utils.saveGame()
		Utils.loadGame()
