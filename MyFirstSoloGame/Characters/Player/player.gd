extends Area2D

@export var speed = 400 # Sped Player
var screen_size # Size of the game
# Called when the node enters the scene tree for the first time.

@onready var SpriteNode2D = $AnimatedSprite2D
#@onready var DebugVelocity = $DebugVelocity

func _ready():
	screen_size = get_viewport_rect().size
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player movement vector (0.0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if  Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.x > 0:
		SpriteNode2D.play("move_right") 
	elif velocity.x < 0:
		SpriteNode2D.play("move_left")
	elif velocity.y > 0:
		SpriteNode2D.play("move_down")
	elif velocity.y < 0:
		SpriteNode2D.play("move_up")

	if velocity == Vector2(0,0):
		if !("stop" in SpriteNode2D.animation):
			if "left" in SpriteNode2D.animation:
				SpriteNode2D.play("stop_left")
			elif "right" in SpriteNode2D.animation:
				SpriteNode2D.play("stop_right")
			elif "up" in SpriteNode2D.animation:
				SpriteNode2D.play("stop_up")
			elif "down" in SpriteNode2D.animation:
				SpriteNode2D.play("stop_down")
	
	if velocity.length() > 0: # (300, 50)
		velocity = velocity.normalized() * speed # make a limit for the velocity / speed
	
	global_position += velocity * delta
	# DebugVelocity.text = "Velocity: " + str(velocity)
