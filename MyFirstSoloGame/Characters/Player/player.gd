extends CharacterBody2D

@export var speed = 300 # Sped Player
var screen_size # Size of the game
# Called when the node enters the scene tree for the first time.

@onready var SpriteNode2D = $AnimatedSprite2D
#@onready var DebugVelocity = $DebugVelocity

func _ready():
	screen_size = get_viewport_rect().size
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# var velocity = Vector2.ZERO # The player movement vector (0.0)
	velocity.x = Input.get_axis("move_left", "move_right") # (-1 à 1 ) velocity.x recebe os input ("move_left", "move_right")
	velocity.y = Input.get_axis("move_up", "move_down")
	
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
	
	move_and_slide()
	# DebugVelocity.text = "Velocity: " + str(velocity)
