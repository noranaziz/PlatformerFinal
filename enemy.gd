extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
@onready var enemy = get_node("AnimatedSprite2D")
var chase = false

func _ready():
	enemy.play("Idle")
	
func _physics_process(delta):
	# gravity for enemy
	velocity.y += gravity + delta
	if chase == true:
		if enemy.animation != "Death":
			enemy.play("Walk")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			enemy.flip_h = true
		else:
			enemy.flip_h = false
		velocity.x = direction.x * SPEED
		# print(player.global_position)
	else:
		if enemy.animation != "Death":
			enemy.play("Idle")
		velocity.x = 0
	move_and_slide()

# lets enemy chase player if detected
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

# stops enemy from chasing player
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Player":
		pass
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3
		# handle player hurt
		if enemy.flip_h == true:
			Game.playerHurtGoRight = true
		else:
			Game.playerHurtGoLeft = true
		death()

func death():
	Utils.saveGame()
	chase = false
	enemy.play("Death")
	await enemy.animation_finished
	self.queue_free()
