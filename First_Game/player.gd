extends Area2D

signal hit # This defines a custom signal called "hit" that we will have our player emit (send out) when it collides with an enemy

@export var speed = 400 # Velocity of player (pixels/sec)
var screen_size # Size of the game


func _ready():
	screen_size = get_viewport_rect().size # Take the window size
	hide() # so the player will be hidden when the game starts


func _process(delta): # The delta parameter in the _process() function refers to the frame length
	var velocity = Vector2.ZERO # Vector for player moviment
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop() # is the same as get_node("AnimatedSprite2D").stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) # We can also use clamp() to prevent it from leaving the screen
	
	# Below is the lógic for change the animations
	if velocity.x != 0: 
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false # 
		$AnimatedSprite2D.flip_h = velocity.x < 0 # This animation should be flipped horizontally using the flip_h property for left movement.
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0 # We also have the "up" animation, which should be flipped vertically with flip_v for downward movement


func _on_body_entered(body):
	hide() # Player disappears after being hit
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
