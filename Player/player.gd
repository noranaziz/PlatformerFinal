extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# access sprite whenever
@onready var sprite = get_node("AnimationPlayer")
var canMove = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and canMove == true:
		velocity.y = JUMP_VELOCITY
		sprite.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	# handle flipping sprite depending on direction
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	# handle running
	if direction and canMove == true:
		velocity.x = direction * SPEED
		if velocity.y == 0 and get_node("AnimatedSprite2D").animation != "Hurt":
			sprite.play("Run")
	# handle idle
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and get_node("AnimatedSprite2D").animation != "Hurt" and canMove == true:
			sprite.play("Idle")
	# handle fall
	if velocity.y > 0:
		sprite.play("Fall")
	# handle hurt
	if Game.playerHurtGoRight == true:
		canMove = false
		sprite.play("Hurt")
		position.x += 20
		Game.playerHurtGoRight = false
		await sprite.animation_finished
		sprite.play("Idle")
		await get_tree().create_timer(0.25).timeout
		canMove = true
	if Game.playerHurtGoLeft == true:
		canMove = false
		sprite.play("Hurt")
		position.x -= 20
		Game.playerHurtGoLeft = false
		await sprite.animation_finished
		sprite.play("Idle")
		await get_tree().create_timer(0.25).timeout
		canMove = true
	
	move_and_slide()

	# handle death
	if Game.playerHP <= 0:
		sprite.play("Death")
		if Game.playerHurtGoRight == true:
			position.x += 20
		if Game.playerHurtGoLeft == true:
			position.x -= 20
		await sprite.animation_finished
		Game.playerHP = 10
		if Game.gold - 100 <= 0:
			Game.gold = 0
		else:
			Game.gold -= 100
		self.queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		Game.playerHurtGoRight = false
		Game.playerHurtGoLeft = false
		Utils.saveGame()
		Utils.loadGame()
