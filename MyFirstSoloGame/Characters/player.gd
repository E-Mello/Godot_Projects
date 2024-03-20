extends Area2D

@export var speed = 400 # Sped Player
var screen_size # Size of the game

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player initiall with velocity 0
	if Input.is_action_pressed("movie_right"):
		velocity.x += 1
	if  Input.is_action_pressed("movie_left"):
		velocity.x -= 1
	if Input.is_action_pressed("movie_down"):
		velocity.y += 1
	if Input.is_action_pressed("movie_up"):
		velocity.y -= 1
	
	if velocity. length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play() # is the same as get_node("AnimatedSprite2D").play().
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	
	if velocity.x < 0:
		$AnimatedSprite2D.animation = "move_right"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "move_left"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "move_down"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = velocity.y < 0
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "move_up"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = velocity.y > 0
