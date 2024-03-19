extends RigidBody2D

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() # First, we get the list of animation names from the AnimatedSprite2D's sprite_frames property. This returns an Array containing all three animation names: ["walk", "swim", "fly"].
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()]) # We then need to pick a random number between 0 and 2 to select one of these names from the list (array indices start at 0). randi() % n selects a random integer between 0 and n-1.


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
