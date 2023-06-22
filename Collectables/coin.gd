extends Area2D

@onready var coin = get_node("AnimatedSprite2D")
var grabbed = false

func _ready():
	coin.play("Idle")

func _on_body_entered(body):
	if body.name == "Player":
		if grabbed == false:
			Game.gold += 1
		grabbed = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 15), 0.2)
		tween.tween_property(self, "modulate:a", 0, 0.2)
		#tween.tween_callback(queue_free)
		Utils.saveGame()
